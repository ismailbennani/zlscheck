open Ztypes
open Common_utils

module Make (Bench : Bench) =
struct
  module Optim = Bench.Optim

  let name = Bench.name ^ " - offline"
  let dump_folder = match Bench.dump_path with
    | None -> None
    | Some dump_path -> Some (make_dump_folder dump_path)

  let wrap (Node { alloc; step; reset }) (control_points: float array) : float * float array =

    let n_inputs = Array.length control_points in
    let cp_fad = Array.map MyOp.make control_points in
    Array.iteri (fun i n -> MyOp.diff n i n_inputs) cp_fad;

    let inputs = Bench.interp_fn cp_fad in

    let fd = match Bench.dump_path with
      | None -> None
      | Some _ -> Some (make_tmp_dump ())
    in

    let mem = alloc () in
    reset mem;

    let rec aux mem last_t =
      (* we are currently at time last_t and we want to compute next step *)
      let cur_inp = inputs last_t in

      begin match fd with
        | None -> ()
        | Some (_, dump_fd) ->
          Printf.fprintf dump_fd "%f,%s\n" last_t
            (String.concat ","
               (Array.to_list
                  (Array.map
                     (fun fad_f -> Printf.sprintf "%f" (MyOp.get fad_f))
                     cur_inp)))
      end;

      let t, cur_out = step mem cur_inp in

      (* Printf.printf "------ t=%g\nZc:\n" t;
         List.map (fun id -> Printf.printf "\t%s: %g\n\t\tgrads: %a\n"
                   (Zc.name id) (MyOp.get (Zc.value id))
                   print_grads (Zc.value id))
         (Zc.ids ());
         print_newline (); *)

      if t >= Bench.max_t then cur_out
      else aux mem t
    in
    let final_out = aux mem 0. in
    let rob = MyOp.get final_out in
    let grad = Array.init n_inputs (fun i -> MyOp.d final_out i) in

    if rob < 0. then
      begin match fd with
        | None -> ()
        | Some (temp_path, temp_fd) ->
          close_out temp_fd;
          let Some dump_folder = dump_folder in
          ignore(Unix.system ("mv " ^ temp_path ^ " " ^ dump_folder))
      end;

    rob, grad

  let run () =
    begin match dump_folder with
    | None -> ()
    | Some dump_folder -> ignore(Unix.system ("mkdir -p " ^ dump_folder))
    end;

    Bench.set_optim_params ();
    let start_time = Unix.gettimeofday () in
    let history, (sample, (rob, grad)) = Optim.falsify (wrap Bench.node) in
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
