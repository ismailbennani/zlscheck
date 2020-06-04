open Ztypes
open Common_utils

module Make (Bench : Bench) =
struct
  (* optim algorithm in the loop to reach next mode *)
  module OnlineOptim = Bench.Optim

  (* optim algorithm for initial values *)
  module Optim = Optim.UR_GDAWARE

  let name = Bench.name ^ " - online - " ^ Optim.name ^ " - " ^ OnlineOptim.name
  let bench_name = Bench.name
  let prop_name_in_matlab = Bench.prop_name_in_matlab
  let dump_path = ref (Some Bench.dump_path)
  let dump_folder = ref (Some "")
  let matlab_path = ref Bench.matlab_path
  let cur_tmp_fd = ref None

  let print_optim_params ff () =
    Printf.fprintf ff "Optim:\n%s\n\nOnline Optim:\n%s\n"
      (Optim.string_of_params Optim_globals.params)
      (OnlineOptim.string_of_params Optim_globals.params)

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
      let next_t, cur_out, rob = step wmem.mem inp_fad in

      begin match !cur_tmp_fd with
        | None -> ()
        | Some (_, dump_fd) ->
          Printf.fprintf dump_fd "%f,%s,%s,%f\n" wmem.time
            (string_of_op_t_arr inp_fad)
            (string_of_op_t_arr cur_out) (MyOp.get rob)
      end;

      wmem.time <- next_t;
      (* get rob and grad *)
      let r = MyOp.get rob in
      let g = Array.init n_inputs (fun i -> MyOp.d rob i) in
      r, g
    in MyNode { my_alloc = new_alloc; my_step = new_step; my_reset = new_reset }

  let run_once (MyNode { my_alloc; my_step; my_reset }) (initial_input : float array) =
    cur_tmp_fd :=
      begin match !dump_folder with
      | None -> None
      | Some _ -> Some (make_tmp_dump ())
      end;

    let mem = my_alloc () in
    my_reset mem;

    let initial_output = my_step mem initial_input in
    let step_params =
      OnlineOptim.mk_step_params (initial_input, initial_output) in
    step_params.online <- true;
    step_params.mode <- Minimize;

    let stop = ref false in
    let n = ref 0 in
    let last_rob = ref (0., [||]) in
    while not !stop do
      (* model step *)
      if !n mod Bench.sample_every = 0 then begin
        ignore (OnlineOptim.step (my_step mem) step_params);
        last_rob := (snd step_params.last_result);
      end else
        last_rob := my_step mem (fst step_params.last_result);
      n := !n + 1;
      stop := mem.time > Bench.max_t;
    done;
    let rob, grad = !last_rob in

    begin match !cur_tmp_fd with
      | None -> ()
      | Some (temp_path, temp_fd) ->
        close_tmp_dump (temp_path, temp_fd);
        cur_tmp_fd := None;
        if rob < 0. then
          let Some dump_folder = !dump_folder in
          ignore(Unix.system ("mv " ^ temp_path ^ " " ^ dump_folder))
    end;

    rob, grad

  let run () =
    dump_folder :=
      begin match !dump_path with
      | None -> None
      | Some path -> Some (make_dump_folder path name);
      end;

    begin match !dump_folder with
    | None -> ()
    | Some dump_folder -> ignore(Unix.system ("mkdir -p " ^ dump_folder));
    end;

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
