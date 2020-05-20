open Ztypes
open Common_utils

module Make (Bench : Bench) =
struct
  (* optim algorithm in the loop to reach next mode *)
  module OnlineOptim = Bench.Optim

  (* optim algorithm for initial values *)
  module Optim = Optim.UR_GDAWARE

  let name = Bench.name

  type 'a wrapped_mem = { mutable time : float; mem: 'a }
  type ('a, 'b) my_node =
      MyNode: { my_alloc : unit -> 's wrapped_mem;
              my_step : 's wrapped_mem -> 'a -> 'b;
              my_reset : 's wrapped_mem -> unit }
        -> ('a, 'b) my_node

  let wrap (Node { alloc; step; reset }) =
    let new_alloc () = { time = 0.; mem = alloc () } in
    let new_reset wmem = wmem.time <- 0.; reset wmem.mem in
    let new_step wmem inp =
      let n_inputs = Array.length inp in
      (* make fadbad input *)
      let inp_fad = Array.map MyOp.make inp in
      Array.iteri (fun i n -> MyOp.diff n i n_inputs) inp_fad;

      (* model step *)
      let t, cur_out = step wmem.mem inp_fad in
      wmem.time <- t;

      (* get rob and grad *)
      let rob = MyOp.get cur_out in
      let grad = Array.init n_inputs (fun i -> MyOp.d cur_out i) in
      rob, grad
    in MyNode { my_alloc = new_alloc; my_step = new_step; my_reset = new_reset }

  let run_once (MyNode { my_alloc; my_step; my_reset }) (initial_input : float array) =
    let mem = my_alloc () in
    my_reset mem;

    let initial_output = my_step mem initial_input in
    let step_params =
      OnlineOptim.mk_step_params (initial_input, initial_output) in
    step_params.online <- true;

    let stop = ref false in
    while not !stop do
      (* model step *)
      let falsified = OnlineOptim.step (my_step mem) step_params in
      stop := mem.time >= Bench.max_t || falsified;
    done;
    snd step_params.last_result

  let run () =
    Bench.set_optim_params ();
    let start_time = Unix.gettimeofday () in

    let history, (sample, (rob, grad)) =
      Optim.falsify (run_once (wrap Bench.node)) in

    let time = Unix.gettimeofday () -. start_time in
    {
      optim = Optim.name;
      n_runs = List.length history;
      samples = Array.of_list (fst (List.split history));
      robs = Array.of_list (fst (List.split (snd (List.split history))));
      best_sample = sample;
      best_rob = rob;
      falsified = rob < 0.;
      elapsed_time = time;
    }

end
