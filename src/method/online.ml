open Ztypes
open Deftypes
open Optim_types
open Method_types
open Method_utils

module UR = Optim.UR_GDAWARE

module Make
    (SUT : Deftypes.SUT)
    (Optim : Optim.S with type input = float array
                      and type output = float * float array)
    (Logger : Logger.S with type input = float * float array * float array * float) =
struct
  include SUT

  module Optim = Optim
  let optim_params_of_array = Optim.optim_params_of_array
  let string_of_params = Optim.string_of_params

  module Logger = Logger

  (* optim algorithm for initial values *)
  module OfflineOptim = UR

  let name = SUT.name ^ " - online - " ^ Optim.name
  let bench_name = SUT.name
  let repetition_n = ref 0
  let sim_n = ref 0

  let print_optim_params ff params =
    Printf.fprintf ff "Online Optim:\n%s\n"
      (Optim.string_of_params params)

  type 'a wrapped_mem = {
    mutable time : float;
    mem: 'a;
    mutable logstate : Logger.t;
  }

  type ('a, 'b) my_node =
      MyNode: { my_alloc : unit -> 's wrapped_mem;
                my_step : 's wrapped_mem -> 'a -> 'b;
                my_reset : 's wrapped_mem -> unit }
        -> ('a, 'b) my_node

  let wrap lparams (Node { alloc; step; reset }) =
    let new_alloc () = {
      time = 0.;
      mem = alloc ();
      logstate = Obj.magic (); (* this will not be used before reset is called *)
    }
    in
    let new_reset wmem =
      wmem.time <- 0.;
      reset wmem.mem;
      wmem.logstate <- Logger.init lparams;
    in
    let new_step wmem inp =
      let n_inputs = Array.length inp in
      (* make fadbad input *)
      let inp_fad = Array.map FadFloat.make inp in
      Array.iteri (fun i n -> FadFloat.diff n i n_inputs) inp_fad;

      (* model step *)
      for i = 1 to SUT.sample_every - 1 do
        let next_t, cur_out, rob = step wmem.mem inp_fad in

        Logger.log wmem.logstate (wmem.time, inp,
                                  Array.map FadFloat.get cur_out,
                                  FadFloat.get rob);
      done;
      let next_t, cur_out, rob = step wmem.mem inp_fad in
      
      Logger.log wmem.logstate (wmem.time, inp,
                                Array.map FadFloat.get cur_out,
                                FadFloat.get rob);

      (* get rob and grad *)
      let r = FadFloat.get rob in
      let g = Array.init n_inputs (fun i -> FadFloat.d rob i) in

      wmem.time <- next_t;
      r, g
    in
    MyNode { my_alloc = new_alloc; my_step = new_step; my_reset = new_reset }

  let run_once params (MyNode { my_alloc; my_step; my_reset }) (initial_input : float array) =
    sim_n := !sim_n + 1;

    let mem = my_alloc () in
    my_reset mem;

    let initial_output = my_step mem initial_input in
    let step_params =
      Optim.mk_step_params params (initial_input, initial_output) in
    step_params.online <- true;
    step_params.mode <- Minimize;

    let stop = ref false in
    let n = ref 0 in
    let last_rob = ref (0., [||]) in
    while not !stop do
      (* model step *)
      ignore (Optim.step (my_step mem) params step_params);
      let rob, grad = (snd step_params.last_result) in

      last_rob := rob, grad;
      n := !n + 1;
      stop := mem.time > SUT.max_t;
    done;

    Logger.finalize mem.logstate;

    let rob, grad = !last_rob in

    rob, grad

  let run (lparams : Logger.params) params =
    repetition_n := !repetition_n + 1;
    sim_n := 0;

    let ur_params = UR.mk_params params.max_n_runs params.bounds in

    let start_time = Unix.gettimeofday () in

    let history, (sample, (rob, grad)) =
      OfflineOptim.falsify (run_once params (wrap lparams SUT.node)) ur_params in

    let time = Unix.gettimeofday () -. start_time in
    {
      bench = bench_name;
      desc = name;
      prop = prop_name;
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
