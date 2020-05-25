type 'a input = (float * 'a) list

type 'a bench_result = {
  bench: string;
  optim: string;
  n_repet: int;
  n_runs: int;
  mean_n_runs: float;
  fals_inputs: 'a list;
  n_falsif: int;
  total_time: float;
}

let print_result { bench; optim; n_repet; n_runs; mean_n_runs; n_falsif; total_time } =
  Printf.printf "Result %s - %s\n" bench optim;
  Printf.printf "\t%d/%d successfully falsified\n" n_falsif n_repet;
  Printf.printf "\tmax runs per falsif: %d\n" n_runs;
  Printf.printf "\ttotal time: %g seconds\n" total_time;
  Printf.printf "\tmean num runs: %g\n" mean_n_runs

let compute_mean l =
  let rec get_sum_size = function
    | [] -> 0, 0
    | x :: q -> let sum, size = get_sum_size q in (x+sum, size+1)
  in
  match l with
  | [] -> 0.
  | _ ->
    let sum, size = get_sum_size l in
    (float sum) /. (float size)

let run_bench (module Bench : Common_utils.S) n_repet n_runs =
  Optim_globals.params.max_n_runs <- n_runs;

  let n_falsif = ref 0 in
  let fals_inputs = ref [] in
  let n_runs_l = ref [] in
  let start_time = Unix.gettimeofday () in

  for i = 0 to n_repet - 1 do
    Printf.printf "-- Bench %d/%d\n" (i+1) n_repet;
    let res = Bench.run () in

    if res.falsified then begin
      n_falsif := !n_falsif + 1;
      fals_inputs := res.best_sample :: !fals_inputs;
      n_runs_l := res.n_runs :: !n_runs_l
    end
  done;

  let time = Unix.gettimeofday () -. start_time in

  {
    bench = Bench.name;
    optim = Bench.Optim.name;
    n_repet = n_repet;
    n_runs = n_runs;
    mean_n_runs = compute_mean !n_runs_l;
    fals_inputs = !fals_inputs;
    n_falsif = !n_falsif;
    total_time = time;
  }

let _ =
  Random.self_init ();

  let sel_bench = ref [] in

  let benches = [
    ("autotrans_phi1", (module Defbench.Autotrans.Phi1 : Common_utils.S));
    ("autotrans_phi2", (module Defbench.Autotrans.Phi2 : Common_utils.S));
    ("autotrans_phi51_offline", (module Defbench.Autotrans.Phi51Offline : Common_utils.S));
    ("autotrans_phi52_offline", (module Defbench.Autotrans.Phi52Offline : Common_utils.S));
    ("autotrans_phi53_offline", (module Defbench.Autotrans.Phi53Offline : Common_utils.S));
    ("autotrans_phi54_offline", (module Defbench.Autotrans.Phi54Offline : Common_utils.S));
    ("autotrans_phi51_online", (module Defbench.Autotrans.Phi51Online : Common_utils.S));
    ("autotrans_phi52_online", (module Defbench.Autotrans.Phi52Online : Common_utils.S));
    ("autotrans_phi53_online", (module Defbench.Autotrans.Phi53Online : Common_utils.S));
    ("autotrans_phi54_online", (module Defbench.Autotrans.Phi54Online : Common_utils.S));
    ("autotrans_phi6a", (module Defbench.Autotrans.Phi6a : Common_utils.S));
    ("autotrans_phi6b", (module Defbench.Autotrans.Phi6b : Common_utils.S));
    ("autotrans_phi6c", (module Defbench.Autotrans.Phi6c : Common_utils.S));
    ("sanity", (module Defbench.Sanity_check : Common_utils.S))
  ] in

  let benches_str = String.concat " | " (fst (List.split benches)) ^ " | all" in
  let all_benches = snd (List.split benches) in

  let usg_msg = Printf.sprintf "usage: ./run_bench.opt [%s]" benches_str in

  Arg.parse [] (fun a ->
      if a = "all" then sel_bench := all_benches
      else if List.mem_assoc a benches then sel_bench := [List.assoc a benches])
    usg_msg;

  if !sel_bench = [] then begin
    print_endline "no bench selected";
    failwith usg_msg;
  end;

  let n_repet = 10 in
  let n_runs = 100 in

  let rec run_benches b =
    match b with
    | [] -> print_endline "done"
    | (module Bench : Common_utils.S) :: q ->
      let res = run_bench (module Bench) n_repet n_runs in
      print_result res;
      begin match Bench.dump_folder with
      | None -> ()
      | Some dump_folder ->
        Printf.printf "Dump saved at %s\n" dump_folder
      end;
      run_benches q
  in
  run_benches !sel_bench
