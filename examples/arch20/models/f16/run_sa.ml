open Ztypes
open Zls
open Staliro_types
open SA_Taliro

let pi = 3.14159265359

(* init_cond : array of size 2 *)
let model (init_cond : float array) =
  Staliro_global.set_global "phi" init_cond.(0);
  Staliro_global.set_global "theta" init_cond.(1);
  Staliro_global.set_global "psi" init_cond.(2);
  Sim.build_sim Test_controlledf16.model

module Run = Sampler.Horizon

let _ =
  Run.set_horizon 15.;
  let model = fun init_cond -> Run.run (model init_cond) in
  let input_ranges =
    [|
      0.2 *. pi, 0.2833 *. pi;       (* phi *)
      -0.4 *. pi, -0.35 *. pi;       (* theta *)
      -0.375 *. pi, -0.125 *. pi;    (* psi *)
    |]
  in
  let opt = {
    verbose = true;
    falsification = true;
    false_at_zero = true;
    optim_params = {
      dispAdap = 10.;
      betaXAdap = 50.;
      dispStart = 0.75;
      betaXStart = -15.0;
      minDisp = 0.01;
      maxDisp = 0.99;
      acRatioMin = 0.45;
      acRatioMax = 0.55;
      init_sample = None;
      max_runs = 300;
    }
  } in
  let run, hist = falsify model input_ranges opt in
  Printf.printf "%a\n" (print_run print_float_array) run
