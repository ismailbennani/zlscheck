open Optim_types

let string_of_mode = function
  | Falsify -> "Falsify"
  | Minimize -> "Minimize"

let string_of_params string_of_optim string_of_init p =
  Printf.sprintf "{ \"max_n_runs\": %d, \"mode\": %s, \"bounds\": [%s],\
                  \"init_sample\": %s, \"verbose\": %s, \"meth\": %s }"
    p.max_n_runs (string_of_mode p.mode)
    (String.concat "; "
       (Array.to_list
          (Array.map
             (fun (f1, f2) -> Printf.sprintf "%g,%g" f1 f2)
             p.bounds)))
    (match p.init_sample with None -> "None" | Some i -> string_of_init i)
    (if p.verbose then "true" else "false") (string_of_optim p.meth)

(* let run_optim (fn : 'input -> 'output)
  : ('input * 'output) list * ('input * 'output)  =

  let rec aux step_params history (old_inp, old_out) =
    let incr_runs () = step_params.n_runs <- step_params.n_runs + 1 in
    if step_params.n_runs >= Optim_globals.params.max_n_runs ||
       Optim_globals.params.mode = Falsify && get_rob_from_output old_out < 0. then
      history, step_params.best_result
    else
      let history, (new_inp, new_out) =
        Alg.step step_params incr_runs fn history (old_inp, old_out) in
      let (old_best_inp, old_best_out) = step_params.best_result in
      let new_best =
        if get_rob_from_output new_out < get_rob_from_output old_best_out
        then (new_inp, new_out)
        else (old_best_inp, old_best_out)
      in
      step_params.best_result <- new_best;
      aux step_params history (new_inp, new_out)
  in

  let first_sample =
    match Optim_globals.params.init_sample with
    | None -> Zlscheck_utils.ur_sample Optim_globals.params.bounds
    | Some sample ->
      if not (Zlscheck_utils.in_bounds sample Optim_globals.params.bounds) then begin
        Printf.eprintf "Given initial sample is not in bounds\n";
        assert false
      end; sample
  in
  let first_value = fn first_sample in

  let init_res = (first_sample, first_value) in
  let step_params = mk_step_params (mk_optim_step_params ()) init_res in

  aux step_params [init_res] init_res *)
