open Optim_types
open Optim_utils

module Make(OptimAlg : OptimAlg with type input = float array) =
struct
  let string_of_params =
    string_of_params OptimAlg.string_of_params
      Misc_printers.string_of_float_array

  type input = OptimAlg.input
  type output = OptimAlg.output
  type optim_step_params = OptimAlg.optim_step_params

  let name = OptimAlg.name

  let optim_mode = ref Falsify

  let mk_step_params init_res = {
    online = false;
    mode = !optim_mode;
    n_runs = 1;
    history = [init_res];
    best_result = init_res;
    last_result = init_res;
    optim_step = OptimAlg.mk_step_params ();
  }

  let get_rob_from_output = OptimAlg.get_rob_from_output

  let step (fn : input -> output) step_params =
    let incr_runs () = step_params.n_runs <- step_params.n_runs + 1 in

    (* Print this only if in offline mode. In online mode, this step function
       is called at every step of the simulation, this would be printed too 
       often *)
    if not step_params.online then begin
      Printf.printf "[%s] Run %d/%d (Best rob so far: %g)\n"
        name step_params.n_runs Optim_globals.params.max_n_runs
        (get_rob_from_output (snd step_params.best_result));
      flush stdout;
    end;

    (* In offline mode, if we are falsifying and we found a negative robustness, 
       we can stop here because we already found a falsifying input. 
       In online mode, the robustness we compute are intermediate values, they 
       can be negative for a while then become positive again at the end of the 
       simulation. *)
    if ((not step_params.online) &&
        step_params.n_runs >= Optim_globals.params.max_n_runs) ||
       (step_params.mode = Falsify &&
        get_rob_from_output (snd step_params.best_result) < 0.) then
        true
    else
      (* we retrieve the old best candidate to compare it to the new one
         and compute the new best candidate after this step. *)

      let (old_best_inp, old_best_out) = step_params.best_result in
      OptimAlg.step step_params incr_runs fn;
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

  let run fn =
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
    let step_params = mk_step_params init_res in

    let stop = ref false in
    while not !stop do
      stop := step fn step_params
    done;
    step_params.history, step_params.best_result


  let falsify fn =
    optim_mode := Falsify; run fn
  let minimize fn =
    optim_mode := Minimize; run fn
end

module type S = S

module SA = Make(SimulatedAnnealing)
module SA_GDAWARE = Make(SimulatedAnnealing_gdaware)
module UR = Make(UniformRandom)
module UR_GDAWARE = Make(UniformRandom_gdaware)

module GDClassic = Make(AdaptativeGradient.Classic)
module GDADAGRAD = Make(AdaptativeGradient.ADAGRAD)
module GDADAM = Make(AdaptativeGradient.ADAM)
module GDAMSGRAD = Make(AdaptativeGradient.AMSGRAD)
