open Staliro_types
open Staliro_utils

let verbose = ref false

let print_if_verbose f =
  if !verbose then f Printf.printf else ()

type optim_params = {
  dispAdap : float;
  betaXAdap : float;
  dispStart : float;
  betaXStart : float;
  minDisp : float;
  maxDisp : float;
  acRatioMax : float;
  acRatioMin : float;
  init_sample : float array option;
  max_runs : int;
}

type step_params = {
  (* acceptance parameter *)
  betaX : float;
  (* radius of search *)
  displace : float;
  (* max number of model evaluation *)
  n_trial : int;
  (* number of accepted samples *)
  n_accepts : int;
  input_ranges : (float * float) array;
}

let print_step_params ff p =
  Printf.fprintf ff "{\n\tbetaX = %.2e\n\tdisplace = %.2e\n\tn_trial = %d\n\tn_accepts = %d\n\tinput_ranges = %a\n}\n"
    p.betaX p.displace p.n_trial p.n_accepts print_floatfloat_array p.input_ranges

let get_initial_sample (input_ranges : (float * float) array) =
  Array.map uniform_float input_ranges

let get_new_sample last_sample input_ranges displace =
  neighbour displace last_sample input_ranges

let mcAccept betaX new_val cur_val =
  (* new value is better than the old one *)
  if new_val < cur_val then
    true
  else
    let acceptance_prob = exp ((new_val -. cur_val) *. betaX) in
    (acceptance_prob >= Random.float 1.)


let sa_step optim_params step_params zlsModel (last_sample, last_val) =
  (* pick new sample *)
  let new_sample = get_new_sample last_sample
                                  step_params.input_ranges
                                  step_params.displace
  in
  let new_val = zlsModel new_sample in

  (* choose next sample *)
  let accepted, cur_sample, cur_val =
    if mcAccept step_params.betaX new_val last_val
    then true, new_sample, new_val
    else false, last_sample, last_val
  in

  (* update acceptance parameters *)

  let n_trial = step_params.n_trial + 1 in
  let n_accepts =
    if accepted then step_params.n_accepts + 1
                else step_params.n_accepts
  in

  let betaX, displace =
    if n_trial mod 50 = 0 then
      let acRatio = (float n_accepts) /. (float n_trial) in
      if acRatio > optim_params.acRatioMax then
        (step_params.betaX *. optim_params.betaXAdap,
         step_params.displace *. optim_params.dispAdap)
      else if acRatio < optim_params.acRatioMin then
        (step_params.betaX /. optim_params.betaXAdap,
         step_params.displace /. optim_params.dispAdap)
      else (step_params.betaX, step_params.displace)
    else (step_params.betaX, step_params.displace)
  in

  (* inputs for the next step *)
  ({ step_params with
     betaX = betaX;
     displace = saturate (optim_params.minDisp, optim_params.maxDisp) displace;
     n_trial = n_trial;
     n_accepts = n_accepts },
   cur_sample, cur_val ),
  (* new values that have been computed, we need to add them to history *)
  (new_sample, new_val)

let sa opt input_ranges zlsModel =
  let isFalse rob = if opt.false_at_zero then rob <= 0. else rob < 0. in

  let rec step hist step_params (sample, rob) =
    if (opt.falsification && isFalse rob) ||
       (step_params.n_trial >= opt.optim_params.max_runs) then begin
      print_if_verbose (fun m -> m "%s" "Done");
      hist
    end else begin
      let (new_params, cur_sample, cur_rob), (new_sample, new_rob) =
        sa_step opt.optim_params step_params zlsModel (sample, rob) in

      print_if_verbose (fun m -> m "%s" "\n======= STEP\n");
      print_if_verbose (fun m -> m "New sample : %a\n" print_float_array new_sample);
      print_if_verbose (fun m -> m "New rob : %a\n" print_float new_rob);
      print_if_verbose (fun m -> m "Accepted sample : %a\n" print_float_array cur_sample);
      print_if_verbose (fun m -> m "Accepted rob : %a\n" print_float cur_rob);
      print_if_verbose (fun m -> m "New params :\n%a\n\n" print_step_params new_params);

      let new_hist = {
        hist_rob = new_rob :: hist.hist_rob;
        hist_samples = new_sample :: hist.hist_samples;
      } in
      step new_hist new_params (cur_sample, cur_rob)
    end
  in

  Printf.printf "Running Simulated Annealing\n";
  Printf.printf "Verbose : %s\n\n" (if !verbose then "true" else "false");

  let init_sample =
    match opt.optim_params.init_sample with
    | None -> get_initial_sample input_ranges
    | Some sample -> sample
  in

  Printf.printf "Initial sample : %a\n" print_float_array init_sample;

  let init_rob = zlsModel init_sample in

  Printf.printf "Initial rob : %a\n" print_float init_rob;

  let init_params = {
    betaX = opt.optim_params.betaXStart;
    displace = opt.optim_params.dispStart;
    n_trial = 0;
    n_accepts = 0;
    input_ranges = input_ranges;
  } in

  print_if_verbose (fun m -> m "Initial params :\n%a\n" print_step_params init_params);

  let init_hist = {
    hist_rob = [init_rob];
    hist_samples = [init_sample];
  } in
  step init_hist init_params (init_sample, init_rob)

let falsify (zlsModel : float array -> float)
    (input_ranges : (float * float) array) (* for now only hypercubes are supported *)
    (opt : optim_params staliro_options)
  : ((float array, unit) run * float array history) =
  let isFalse rob = if opt.false_at_zero then rob < 0. else rob < 0. in

  Random.self_init ();
  verbose := opt.verbose;

  let starttime = Sys.time () in
  let hist = sa opt input_ranges zlsModel in
  let endtime = Sys.time () in
  let bestSample, bestRob =
    if List.length hist.hist_samples = 1 then
      (List.hd hist.hist_samples, List.hd hist.hist_rob)
    else
      List.fold_left2 (fun (bS, bR) s r ->
          if r < bR then (s, r) else (bS, bR)
        ) (List.hd hist.hist_samples, List.hd hist.hist_rob)
        (List.tl hist.hist_samples) (List.tl hist.hist_rob)
  in
  {
    bestSample = bestSample;
    bestRob = bestRob;
    nTests = List.length hist.hist_rob;
    paramVal = ();
    falsified = isFalse bestRob;
    run_time = endtime -. starttime;
  },
  hist
