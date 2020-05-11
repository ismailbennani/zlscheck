open Zlscheck_utils
open Optim_types
open Optim_utils

let name = "Particles"

type alg_params = particle_params

let string_of_params { n } = Printf.sprintf "{ n = %d }" n

type input = float array
type output = float

type particle_step_params = {
  mutable distribution : input Distribution.t;
}
let mk_step_params () = {
  distribution = Distribution.uniform_sample Optim_globals.params.bounds;
}

let ur_step step_params incr_runs fn history
    (old_sample, old_val) =
  let params = Optim_globals.params in
  let bounds = params.bounds in
  let max_n_runs = params.max_n_runs in
  let n = params.meth.particle.n in
  let verbose = params.verbose in

  if verbose then
    Printf.printf "Run %i/%i\n" (step_params.n_runs+1) max_n_runs;

  (* let new_sample = ur_sample bounds in
  let new_val = fn new_sample in

  if verbose then begin
    Printf.printf "New point : %a\n" Misc_printers.print_float_array new_sample;
    Printf.printf "New value : %.2e\n" new_val;
  end;

  incr_runs ();

  if params.verbose then begin
    print_newline (); flush stdout
  end;

  (new_sample, new_val) :: history, (new_sample, new_val) *)

  failwith "not implemented"

let get_rob_from_output rob = rob

(* let run = run_optim ur_step mk_step_params float_array_dist get_rob_from_output *)
