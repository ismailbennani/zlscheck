open Optim_types
open Optim_utils

let default_params optim_params = {
  max_n_runs = 500;
  bounds = [||];
  init_sample = None;
  vverbose = false;
  verbose = false;
  optim = optim_params
}

module Make(OptimAlg : OptimAlg with type input = float array) =
struct

  type input = OptimAlg.input
  type output = OptimAlg.output
  type optim_params = OptimAlg.optim_params params
  type optim_step_params = OptimAlg.optim_step_params

  let string_of_params =
    string_of_params OptimAlg.string_of_params
      (fun i -> Printf.sprintf "[%s]" (Printer.string_of_float_array "; " i))

  let default_params = default_params OptimAlg.default_params

  let name = OptimAlg.name

  let optim_mode = ref Falsify

  let mk_step_params params init_res = {
    online = false;
    mode = !optim_mode;
    n_runs = 1;
    history = [init_res];
    best_result = init_res;
    last_result = init_res;
    optim_step = OptimAlg.mk_step_params params;
  }

  let get_rob_from_output = OptimAlg.get_rob_from_output

  let step (fn : input -> output) params step_params =
    let incr_runs () = step_params.n_runs <- step_params.n_runs + 1 in

    if not step_params.online then begin
      Printf.printf "[%s] Run %d/%d (Best rob so far: %g)\n"
        name step_params.n_runs params.max_n_runs
        (get_rob_from_output (snd step_params.best_result));
      flush stdout;
    end;

    if ((not step_params.online) &&
        step_params.n_runs >= params.max_n_runs) ||
       (step_params.mode = Falsify &&
        get_rob_from_output (snd step_params.best_result) < 0.) then
        true
    else
      let (old_best_inp, old_best_out) = step_params.best_result in
      OptimAlg.step params step_params incr_runs fn;
      let (new_inp, new_out) = step_params.last_result in

      let old_rob = get_rob_from_output old_best_out in
      let new_rob = get_rob_from_output new_out in

      if not (Float.is_nan new_rob) then begin
        if not (Float.is_nan old_rob) then
          let new_best =
            if new_rob < old_rob
            then (new_inp, new_out)
            else (old_best_inp, old_best_out)
          in step_params.best_result <- new_best
        else
          step_params.best_result <- (new_inp, new_out)
      end;
      false

  let run fn params =
    let first_sample =
      match params.init_sample with
      | None -> Zlscheck_utils.ur_sample params.bounds
      | Some sample ->
        if not (Zlscheck_utils.in_bounds sample params.bounds) then begin
          Printf.eprintf "Given initial sample is not in bounds\n";
          assert false
        end; sample
    in
    let first_value = fn first_sample in

    let init_res = (first_sample, first_value) in
    let step_params = mk_step_params params init_res in

    let stop = ref false in
    while not !stop do
      stop := step fn params step_params
    done;
    step_params.history, step_params.best_result


  let falsify fn =
    optim_mode := Falsify; run fn
  let minimize fn =
    optim_mode := Minimize; run fn
end

module type S = S

module SA = Make(SimulatedAnnealing.SA)
module SA_GDAWARE = Make(SimulatedAnnealing.GDAWARE)
module UR = Make(UniformRandom.UR)
module UR_GDAWARE = Make(UniformRandom.GDAWARE)

module GDClassic = Make(AdaptativeGradient.Classic)
module GDADAGRAD = Make(AdaptativeGradient.ADAGRAD)
module GDADAM = Make(AdaptativeGradient.ADAM)
module GDAMSGRAD = Make(AdaptativeGradient.AMSGRAD)
