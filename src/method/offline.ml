open Ztypes
open Deftypes
open Optim_types
open Method_types
open Method_utils

module Make
    (SUT : Deftypes.SUT)
    (Optim : Optim.S with type input = float array
                      and type output = float * float array)
    (Logger : Logger.S) =
struct
  include SUT
  module Optim = Optim
  let optim_params_of_array = Optim.optim_params_of_array
  let string_of_params = Optim.string_of_params

  module Logger = Logger

  let name = SUT.name ^ " - offline - " ^ Optim.name
  let bench_name = SUT.name

  let repetition_n = ref 0
  let sim_n = ref 0

  let print_optim_params ff params =
    Printf.fprintf ff "Optim:\n%s\n"
      (Optim.string_of_params params)

  let wrap lparams (Node { alloc; step; reset }) (control_points: float array) : float * float array =
    sim_n := !sim_n + 1;

    let n_inputs = Array.length control_points in
    let cp_fad = Array.map FadFloat.make control_points in
    Array.iteri (fun i n -> FadFloat.diff n i n_inputs) cp_fad;

    let scenario = SUT.scenario in

    (* only piecewise constant supported for now *)
    let interp = Scenario.get_interp scenario cp_fad in

    let rec aux mem logstate t =
      (* we are currently at time t and we want to compute next step *)
      let cur_inp = interp t in
      let next_t, cur_out, rob = step mem cur_inp in

      Logger.log logstate (t,
                           Array.map FadFloat.get cur_inp,
                           Array.map FadFloat.get cur_out,
                           FadFloat.get rob);

      if t >= SUT.max_t then rob
      else aux mem logstate next_t
    in

    let mem = alloc () in
    reset mem;
    let logstate = Logger.init lparams in

    let final_out = aux mem logstate 0. in

    Logger.finalize logstate;

    let rob = FadFloat.get final_out in
    let grad = Array.init n_inputs (fun i -> FadFloat.d final_out i) in
    rob, grad

  let run (lparams : Logger.params) params =
    repetition_n := !repetition_n + 1;

    (* params.bounds are the bounds of each value of the inputs *)
    (* we need to compute  the bounds of the vector that will be given to *)
    (* the interpolation function *)
    (* only piecewise constant inputs supported for now, the number of *)
    (* consecutive equal inputs is given by SUT.sample_every *)
    let input_bounds = params.bounds in
    let n_pieces =
      truncate (ceil
                  ((float (Scenario.n_ctrl_points SUT.scenario)) /.
                   (float (Scenario.dim SUT.scenario))))
    in
    let new_bounds = Array.init (n_pieces * (Array.length input_bounds))
        (fun i -> input_bounds.(i / n_pieces))
    in
    let params = { params with bounds = new_bounds } in

    let start_time = Unix.gettimeofday () in
    let history, (sample, (rob, grad)) = Optim.falsify (wrap lparams SUT.node) params in
    let time = Unix.gettimeofday () -. start_time in
    {
      bench = bench_name;
      desc = name;
      prop = prop_name;
      optim = Optim.name;
      n_runs = List.length history;
      samples = Array.of_list (fst (List.split history));
      robs = Array.of_list (fst (List.split (snd (List.split history))));
      best_sample = sample;
      best_rob = rob;
      falsified = rob < 0.;
      elapsed_time = time;
    }
end
