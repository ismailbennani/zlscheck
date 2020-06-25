open Ztypes
open Common_types
open Common_utils

module Make (Bench : Bench) =
struct
  module Optim = Bench.Optim

  let name = Bench.name ^ " - offline - " ^ Optim.name
  let bench_name = Bench.name
  let prop_name = Bench.prop_name
  let prop_name_in_matlab = Bench.prop_name_in_matlab
  let model_name_in_matlab = Bench.model_name_in_matlab
  let folder_name_in_shared = Bench.folder_name_in_shared

  let dump_path = ref (Some Bench.dump_path)
  let dump_folder = ref (Some "")
  let shared_path = ref Bench.shared_path
  let pindex = ref 0
  let save_path = ref ""
  let save_folder = ref ""

  let repetition_n = ref 0
  let sim_n = ref 0

  let print_optim_params ff () =
    Printf.fprintf ff "Optim:\n%s\n"
      (Optim.string_of_params Optim_globals.params)

  let wrap (Node { alloc; step; reset }) (control_points: float array) : float * float array =

    sim_n := !sim_n + 1;

    let n_inputs = Array.length control_points in
    let cp_fad = Array.map MyOp.make control_points in
    Array.iteri (fun i n -> MyOp.diff n i n_inputs) cp_fad;

    let inputs = Bench.interp_fn cp_fad in

    let fd = match !dump_folder with
      | None -> None
      | Some _ -> Some (make_tmp_dump !pindex)
    in

    let mem = alloc () in
    reset mem;

    let rec aux mem t =
      (* we are currently at time t and we want to compute next step *)
      let cur_inp = inputs t in
      let next_t, cur_out, rob = step mem cur_inp in

      begin match fd with
        | None -> ()
        | Some (_, dump_fd) ->
          Printf.fprintf dump_fd "%f,%s,%s,%g\n" t
            (string_of_op_t_arr cur_inp) (string_of_op_t_arr cur_out)
            (MyOp.get rob)
      end;

      if t >= Bench.max_t then rob
      else aux mem next_t
    in
    let final_out = aux mem 0. in
    let rob = MyOp.get final_out in
    let grad = Array.init n_inputs (fun i -> MyOp.d final_out i) in

    begin match fd with
      | None -> ()
      | Some (temp_path, temp_fd) ->
        close_tmp_dump (temp_path, temp_fd);
        if !save_path <> "" then begin
          let save_folder = Filename.concat !save_folder (Printf.sprintf "%d_%d" !pindex !repetition_n) in
          let save_path = Filename.concat save_folder ((string_of_int !sim_n) ^ ".csv") in
          ignore(Unix.system ("mkdir -p " ^ save_folder));
          ignore (Unix.system ("cp " ^ temp_path ^ " " ^ save_path));
        end;
        if rob < 0. then
          let Some dump_folder = !dump_folder in
          ignore(Unix.system ("mv " ^ temp_path ^ " " ^ dump_folder));
          ignore(Unix.system ("rm " ^ temp_path))
    end;

    rob, grad

  let run () =
    dump_folder :=
      begin match !dump_path with
      | None -> None
      | Some path -> Some (make_dump_folder path name);
      end;

    save_folder :=
      if !save_path = "" then "" else make_dump_folder !save_path name;

    repetition_n := !repetition_n + 1;
    sim_n := 0;

    begin match !dump_folder with
    | None -> ()
    | Some dump_folder -> ignore(Unix.system ("mkdir -p " ^ dump_folder));
    end;

    Bench.set_optim_params ();
    let start_time = Unix.gettimeofday () in
    let history, (sample, (rob, grad)) = Optim.falsify (wrap Bench.node) in
    let time = Unix.gettimeofday () -. start_time in
    {
      model_name = model_name_in_matlab;
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
