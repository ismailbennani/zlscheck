open Zlscheck_utils
open Optim_types
open Optim_utils

module Make(Output :
            sig
              type t
              val get_rob : t -> float
            end) =
struct
  let name = "UR"
  let string_of_params _ = "()"

  type input = float array
  type output = Output.t
  type optim_params = unit
  type optim_step_params = unit

  let default_params = ()
  let mk_step_params _ = ()

  let get_rob_from_output = Output.get_rob

  let step params step_params incr_runs fn =
    let bounds = params.bounds in
    let max_n_runs = params.max_n_runs in
    let verbose = params.verbose || params.vverbose in

    if verbose then
      Printf.printf "Run %i/%i\n" (step_params.n_runs+1) max_n_runs;

    let new_sample = ur_sample bounds in
    let new_output = fn new_sample in
    let new_val = get_rob_from_output new_output in

    if verbose then begin
      Printf.printf "New point : %a\n" Printer.print_float_array new_sample;
      Printf.printf "New value : %.2e\n" new_val;
    end;

    incr_runs ();

    if params.verbose then begin
      print_newline (); flush stdout
    end;

    step_params.history <- (new_sample, new_output) :: step_params.history;
    step_params.last_result <- (new_sample, new_output)
end

module UR = Make(
  struct
    type t = float
    let get_rob rob = rob
  end)

module GDAWARE = Make(
  struct
    type t = float * float array
    let get_rob (rob, _) = rob
  end)
