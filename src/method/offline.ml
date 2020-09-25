open Ztypes
open Deftypes
open Method_types
open Method_utils

module Make
    (Bench : Deftypes.Bench)
    (Logger : Logger.S with type input := float * float array * float * float array)=
struct
  module Optim = Bench.Optim
  module Scenario = Bench.Scenario

  let name = Bench.name ^ " - offline - " ^ Optim.name
  let bench_name = Bench.name
  let prop_name = Bench.prop_name
  let repetition_n = ref 0
  let sim_n = ref 0

  let print_optim_params ff params =
    Printf.fprintf ff "Optim:\n%s\n"
      (Optim.string_of_params params)

  let wrap (Node { alloc; step; reset }) (control_points: float array) : float * float array =
    sim_n := !sim_n + 1;

    let n_inputs = Array.length control_points in
    let cp_fad = Array.map FadFloat.make control_points in
    Array.iteri (fun i n -> FadFloat.diff n i n_inputs) cp_fad;

    let interp = Scenario.get_interp cp_fad in

    let rec aux mem logstate t =
      (* we are currently at time t and we want to compute next step *)
      let cur_inp = interp t in
      let next_t, cur_out, rob = step mem cur_inp in

      Logger.log logstate
        (t, Array.map FadFloat.get cur_inp,
         FadFloat.get rob, Array.map FadFloat.get cur_out);

      if t >= Bench.max_t then rob
      else aux mem logstate next_t
    in

    let mem = alloc () in
    reset mem;
    let logstate = Logger.init () in

    let final_out = aux mem logstate 0. in

    Logger.finalize logstate;

    let rob = FadFloat.get final_out in
    let grad = Array.init n_inputs (fun i -> FadFloat.d final_out i) in
    rob, grad

  let run optim_params =
    repetition_n := !repetition_n + 1;

    let start_time = Unix.gettimeofday () in
    let history, (sample, (rob, grad)) = Optim.falsify (wrap Bench.node) optim_params in
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
