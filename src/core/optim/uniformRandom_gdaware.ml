open Zlscheck_utils
open Optim_types
open Optim_utils

let name = "UR"

type alg_params = ur_params

let string_of_params _ = "()"

type input = float array
type output = float * float array
type optim_step_params = unit

let get_params () = ()
let mk_step_params () = ()

let ur_step step_params incr_runs fn =
  let params = Optim_globals.params in
  let bounds = params.bounds in
  let max_n_runs = params.max_n_runs in
  let verbose = params.verbose || params.vverbose in

  let old_sample, (old_val, _) = step_params.last_result in

  if verbose then
    Printf.printf "Run %i/%i\n" (step_params.n_runs+1) max_n_runs;

  let new_sample = ur_sample bounds in
  let new_val = fn new_sample in

  if verbose then begin
    Printf.printf "New point : %a\n" Misc_printers.print_float_array new_sample;
    Printf.printf "New value : %.2e\n" (fst new_val);
  end;

  incr_runs ();

  if params.verbose then begin
    print_newline (); flush stdout
  end;

  step_params.history <- (new_sample, new_val) :: step_params.history;
  step_params.last_result <- (new_sample, new_val)

let get_rob_from_output (rob, _) = rob

let step = ur_step

(* let run = run_optim ur_step mk_step_params float_array_dist get_rob_from_output *)
