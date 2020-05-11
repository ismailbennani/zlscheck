open Zlscheck_utils
open Optim_types
open Optim_utils

let name = "SA"

let string_of_params p =
  Printf.sprintf "{ \"dispAdap\": %g, \"betaXAdap\": %g, \"minDisp\": %g,\
\"maxDisp\": %g, \"acRatioMin\": %g, \"acRatioMax\": %g, \"dispStart\": %g,\
\"betaXStart\": %g }"
    p.sa.dispAdap p.sa.betaXAdap p.sa.minDisp p.sa.maxDisp p.sa.acRatioMin p.sa.acRatioMax
    p.sa.dispStart p.sa.betaXStart

type input = float array
type output = float

let get_params_as_string () = string_of_params (Optim_globals.params.meth)

type optim_step_params = {
  (* acceptance parameter *)
  mutable betaX : float;
  (* radius of search *)
  mutable displace : float;
  (* number of accepted samples *)
  mutable n_accepts : int;
}

let mk_step_params () = {
    betaX = Optim_globals.params.meth.sa.betaXStart;
    displace = Optim_globals.params.meth.sa.dispStart;
    n_accepts = 0;
  }

let neighbour (radius : float) (center : float array) (bounds : (float * float) array) =
  assert (in_bounds center bounds);

  let direction = Array.map (fun _ -> gaussian(0.,1.)) center in
  let lambda_min, lambda_max = get_bounds center direction bounds radius in

  let lambda = bounded_gaussian (lambda_min, lambda_max)
      (0., min radius (max lambda_min lambda_max)) in

  let new_input = Array.map2 (fun f1 f2 -> f1 +. lambda *. f2) center direction in

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

let sa_step step_params incr_runs fn =
  let params = Optim_globals.params in
  let bounds = params.bounds in
  let max_n_runs = params.max_n_runs in
  let dispAdap = 1. +. params.meth.sa.dispAdap /. 100. in
  let betaXAdap = 1. +. params.meth.sa.betaXAdap /. 100. in
  let acRatioMin = params.meth.sa.acRatioMin in
  let acRatioMax = params.meth.sa.acRatioMax in
  let minDisp = params.meth.sa.minDisp in
  let maxDisp = params.meth.sa.maxDisp in
  let verbose = params.verbose in
  let vverbose = params.vverbose in

  let last_sample, last_val = step_params.last_result in

  if verbose then
    Printf.printf "Run %i/%i\n" (step_params.n_runs+1) max_n_runs;

  (* pick new sample *)
  let new_sample = get_new_sample last_sample
      bounds
      step_params.optim_step.displace
  in
  let new_val = fn new_sample in
  incr_runs ();

  if verbose then begin
      Printf.printf "New point : %a\n" Misc_printers.print_float_array new_sample;
      Printf.printf "New value : %.2e\n" new_val;
  end;

  (* choose next sample *)
  let accepted, cur_sample, cur_val =
    if mcAccept step_params.optim_step.betaX new_val last_val
    then true, new_sample, new_val
    else false, last_sample, last_val
  in

  if verbose then
    Printf.printf "New point accepted : %s\n"
      (if accepted then "true" else "false");

  (* update acceptance parameters *)

  let n_accepts =
    if accepted then step_params.optim_step.n_accepts + 1
    else step_params.optim_step.n_accepts
  in

  if verbose then
    Printf.printf "Number of accepted points so far : %i\n" n_accepts;

  let betaX, displace =
    if step_params.n_runs mod 50 = 0 then
      let acRatio = (float n_accepts) /. (float (step_params.n_runs)) in
      if verbose then
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
  if params.vverbose then
    Printf.printf "Params:\n\tdisplace: %f\n\tbetaX: %f\n"
      step_params.optim_step.displace step_params.optim_step.betaX;

  if params.verbose then begin
    print_newline (); flush stdout
  end;

  (* history and inputs for the next step *)
  step_params.history <- (new_sample, new_val) :: step_params.history;
  step_params.last_result <- (cur_sample, cur_val)

let get_rob_from_output rob = rob

let step = sa_step

(* let run = run_optim sa_step mk_step_params float_array_dist get_rob_from_output *)
