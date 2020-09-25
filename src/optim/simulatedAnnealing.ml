open Zlscheck_utils
open Optim_types
open Optim_utils

module Make(Output :
            sig
              type t
              val get_rob : t -> float
            end) =
struct
  let name = "SA"

  type input = float array
  type output = Output.t
  type optim_params = {
    dispAdap : float;
    betaXAdap : float;
    minDisp : float;
    maxDisp : float;
    acRatioMin : float;
    acRatioMax : float;

    dispStart : float;
    betaXStart : float;
  }

  let string_of_params p =
      Printf.sprintf "{ \"dispAdap\": %g, \"betaXAdap\": %g, \"minDisp\": %g,\
                      \"maxDisp\": %g, \"acRatioMin\": %g, \"acRatioMax\": %g,\
                      \"dispStart\": %g, \"betaXStart\": %g }"
        p.dispAdap p.betaXAdap p.minDisp p.maxDisp p.acRatioMin p.acRatioMax
        p.dispStart p.betaXStart

  let default_params = {
    dispAdap = 10.;
    betaXAdap = 50.;
    minDisp = 0.01;
    maxDisp = 0.99;
    acRatioMin = 0.45;
    acRatioMax = 0.55;
    dispStart = 0.75;
    betaXStart = -15.;
  };

  type optim_step_params = {
    (* acceptance parameter *)
    mutable betaX : float;
    (* radius of search *)
    mutable displace : float;
    (* number of accepted samples *)
    mutable n_accepts : int;
  }

  let mk_step_params params = {
    betaX = params.optim.betaXStart;
    displace = params.optim.dispStart;
    n_accepts = 0;
  }

  let neighbour (radius : float) (center : float array)
      (bounds : (float * float) array) =
    assert (in_bounds center bounds);

    let direction = Array.map (fun _ -> gaussian(0.,1.)) center in
    let lambda_min, lambda_max = get_bounds center direction bounds radius in

    let lambda = bounded_gaussian (lambda_min, lambda_max)
        (0., min radius (max lambda_min lambda_max)) in

    let new_input =
      Array.map2 (fun f1 f2 -> f1 +. lambda *. f2) center direction in

    assert (in_bounds new_input bounds);
    new_input

  let get_new_sample last_sample input_ranges displace =
    neighbour displace last_sample input_ranges

  let mcAccept betaX new_val cur_val =
    (* new value is better than the old one *)
    if new_val < cur_val then
      true
    else
      let acceptance_prob = exp ((new_val -. cur_val) *. betaX) in
      (acceptance_prob >= Random.float 1.)

  let get_rob_from_output = Output.get_rob

  let step params step_params incr_runs fn =
    let bounds = params.bounds in
    let max_n_runs = params.max_n_runs in
    let dispAdap = 1. +. params.optim.dispAdap /. 100. in
    let betaXAdap = 1. +. params.optim.betaXAdap /. 100. in
    let acRatioMin = params.optim.acRatioMin in
    let acRatioMax = params.optim.acRatioMax in
    let minDisp = params.optim.minDisp in
    let maxDisp = params.optim.maxDisp in
    let verbose = params.verbose in
    let vverbose = params.vverbose in

    let last_sample, last_output = step_params.last_result in
    let last_val = get_rob_from_output last_output in

    if verbose || vverbose then
      Printf.printf "Run %i/%i\n" (step_params.n_runs+1) max_n_runs;

    (* pick new sample *)
    let new_sample = get_new_sample last_sample
        bounds
        step_params.optim_step.displace
    in
    let new_output = fn new_sample in
    incr_runs ();

    let new_val = get_rob_from_output new_output in

    if verbose || vverbose then begin
      Printf.printf "New point : %a\n"
        Printer.print_float_array new_sample;
      Printf.printf "New value : %.2e\n" new_val;
    end;

    (* choose next sample *)
    let accepted, next_sample, next_output =
      if mcAccept step_params.optim_step.betaX new_val last_val
      then true, new_sample, new_output
      else false, last_sample, last_output
    in

    if verbose || vverbose then
      Printf.printf "New point accepted : %s\n"
        (if accepted then "true" else "false");

    (* update acceptance parameters *)

    let n_accepts =
      if accepted then step_params.optim_step.n_accepts + 1
      else step_params.optim_step.n_accepts
    in

    if verbose || vverbose then
      Printf.printf "Number of accepted points so far : %i\n" n_accepts;

    let betaX, displace =
      if step_params.n_runs mod 50 = 0 then
        let acRatio = (float n_accepts) /. (float (step_params.n_runs)) in
        if verbose || vverbose then
          Printf.printf "Acceptance ratio : %i%%\n" (truncate (acRatio *. 100.));
        if acRatio > acRatioMax then
          (step_params.optim_step.betaX *. betaXAdap,
           step_params.optim_step.displace *. dispAdap)
        else if acRatio < acRatioMin then
          (step_params.optim_step.betaX /. betaXAdap,
           step_params.optim_step.displace /. dispAdap)
        else (step_params.optim_step.betaX, step_params.optim_step.displace)
      else (step_params.optim_step.betaX, step_params.optim_step.displace)
    in

    step_params.optim_step.betaX <- betaX;
    step_params.optim_step.displace <-
      saturate (minDisp, maxDisp) displace;
    step_params.optim_step.n_accepts <- n_accepts;
    if vverbose then
      Printf.printf "Params:\n\tdisplace: %f\n\tbetaX: %f\n"
        step_params.optim_step.displace step_params.optim_step.betaX;

    if verbose || vverbose then begin
      print_newline (); flush stdout
    end;

    (* history and inputs for the next step *)
    step_params.history <- (new_sample, new_output) :: step_params.history;
    step_params.last_result <- (next_sample, next_output)
end

module SA = Make(
  struct
    type t = float
    let get_rob rob = rob
  end)

module GDAWARE = Make(
  struct
    type t = float * float array
    let get_rob (rob, _) = rob
  end)
