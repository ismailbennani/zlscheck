open Optim
open Utils

type sa_params = {
  dispAdap : float;
  betaXAdap : float;
  minDisp : float;
  maxDisp : float;
  acRatioMin : float;
  acRatioMax : float;

  dispStart : float;
  betaXStart : float;
}

let sa_default = {
  dispAdap = 10.;
  betaXAdap = -15.;
  minDisp = 0.01;
  maxDisp = 0.99;
  acRatioMin = 0.45;
  acRatioMax = 0.55;
  dispStart = 0.75;
  betaXStart = -15.;
}

type sa_step_params = {
  (* acceptance parameter *)
  mutable betaX : float;
  (* radius of search *)
  mutable displace : float;
  (* number of accepted samples *)
  mutable n_accepts : int;
}

let mk_step_params params = {
  n_runs = 1;
  optim_step = {
    betaX = params.optim.betaXStart;
    displace = params.optim.dispStart;
    n_accepts = 0;
  }
}

let get_new_sample last_sample input_ranges displace =
  neighbour displace last_sample input_ranges

let mcAccept betaX new_val cur_val =
  (* new value is better than the old one *)
  if new_val < cur_val then
    true
  else
    let acceptance_prob = exp ((new_val -. cur_val) *. betaX) in
    (acceptance_prob >= Random.float 1.)

let sa_step params step_params fn history (last_sample, last_val) =
  (* pick new sample *)
  let new_sample = get_new_sample last_sample
      params.bounds
      step_params.optim_step.displace
  in
  let new_val = fn new_sample in

  (* choose next sample *)
  let accepted, cur_sample, cur_val =
    if mcAccept step_params.optim_step.betaX new_val last_val
    then true, new_sample, new_val
    else false, last_sample, last_val
  in

  (* update acceptance parameters *)

  let n_runs = step_params.n_runs + 1 in
  let n_accepts =
    if accepted then step_params.optim_step.n_accepts + 1
    else step_params.optim_step.n_accepts
  in

  let betaX, displace =
    if n_runs mod 50 = 0 then
      let acRatio = (float n_accepts) /. (float n_runs) in
      if acRatio > params.optim.acRatioMax then
        (step_params.optim_step.betaX *. params.optim.betaXAdap,
         step_params.optim_step.displace *. params.optim.dispAdap)
      else if acRatio < params.optim.acRatioMin then
        (step_params.optim_step.betaX /. params.optim.betaXAdap,
         step_params.optim_step.displace /. params.optim.dispAdap)
      else (step_params.optim_step.betaX, step_params.optim_step.displace)
    else (step_params.optim_step.betaX, step_params.optim_step.displace)
  in

  step_params.optim_step.betaX <- betaX;
  step_params.optim_step.displace <- saturate (params.optim.minDisp, params.optim.maxDisp) displace;
  step_params.n_runs <- n_runs;
  step_params.optim_step.n_accepts <- n_accepts;

  (* history and inputs for the next step *)
  (new_sample, new_val) :: history, (cur_sample, cur_val)

let sa = run_optim sa_step mk_step_params
