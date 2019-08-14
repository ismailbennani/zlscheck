open Optim
open Utils

type ur_params = unit
let ur_default = ()

let mk_step_params _ = {
  n_runs = 1;
  optim_step = ()
}

let ur_step (params : unit params) step_params fn history (old_sample, old_val) =
  let new_sample = ur_sample params.bounds in
  let new_val = fn new_sample in

  let best_sample, best_val =
    if new_val < old_val then new_sample, new_val else old_sample, old_val
  in

  step_params.n_runs <- step_params.n_runs + 1;

  (new_sample, new_val) :: history, (best_sample, best_val)

(* let ur (params : unit params) fn =
  let rec aux step_params history (old_sample, old_val) =
    if step_params.n_runs >= params.max_n_runs then
      history, (old_sample, old_val)
    else if params.mode = Falsify && old_val < 0. then begin
      Printf.eprintf "Already found a falsifying input\n";
      history, (old_sample, old_val)
    end else
      let history, current_point =
        ur_step params step_params fn history (old_sample, old_val) in

      aux step_params history current_point
  in

  let step_params = { n_runs = 1 } in

  let first_sample =
    match params.init_sample with
    | None -> ur_sample params.bounds
    | Some sample ->
      if not (in_bounds sample params.bounds) then begin
        Printf.eprintf "Given initial sample is not in bounds\n";
        assert false
      end; sample
  in
  let first_value = fn first_sample in

  let init_point = (first_sample, first_value) in

  aux step_params [init_point] init_point *)

let ur = run_optim ur_step mk_step_params
