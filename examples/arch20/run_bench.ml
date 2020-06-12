open Common_utils

type 'a input = (float * 'a) list

type 'a bench_result = {
  bench: string;
  desc: string;
  n_repet: int;
  n_runs: int;
  mean_n_runs: float;
  median_n_runs: float;
  fals_inputs: 'a array;
  n_falsif: int;
  total_time: float;
  dump_folder: string option;
}

let print_result print_optim_params ff
    { bench; desc; n_repet; n_runs; mean_n_runs; median_n_runs;
      n_falsif; total_time } =
  Printf.fprintf ff "Result %s: %s\n" bench desc;
  Printf.fprintf ff "\t%d/%d successfully falsified\n" n_falsif n_repet;
  Printf.fprintf ff "\tmax runs per falsif: %d\n" n_runs;
  Printf.fprintf ff "\tmean num runs: %g\n" mean_n_runs;
  Printf.fprintf ff "\tmedian num runs: %g\n" median_n_runs;
  Printf.fprintf ff "\ttotal time: %g seconds\n" total_time;
  Printf.fprintf ff "\n";
  Printf.fprintf ff "%a" print_optim_params ()

let print_summary fd results =
  let aux fd { bench; n_falsif; n_repet; mean_n_runs; median_n_runs;
               total_time } =
    Printf.fprintf fd "%s,%d/%d,%f,%f,%f\n"
      bench n_falsif n_repet mean_n_runs median_n_runs total_time
  in
  Printf.fprintf fd "name,FR,mean,median,time\n";
  List.iter (aux fd) results

let print_test_all fd results =
  let aux fd { bench; dump_folder } =
    match dump_folder with
    | None -> ()
    | Some dump_folder ->
      let folder = Filename.concat "fals" (Filename.basename dump_folder) in
      Printf.fprintf fd "cd('%s');\nfprintf(\"%s:\");\nrun('test.m');\ncd('../..');\n"
        folder bench
  in
  List.iter (aux fd) results

let mk_bench_list_str benches = String.concat "\n\t" benches

let run_bench (module Bench : RunBench) n_repet n_runs =
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

  let n_runs_arr = Array.of_list !n_runs_l in
  let fals_inp_arr = Array.of_list !fals_inputs in

  {
    bench = Bench.bench_name;
    desc = Bench.name;
    n_repet = n_repet;
    n_runs = n_runs;
    mean_n_runs = compute_mean n_runs_arr;
    median_n_runs = compute_median n_runs_arr;
    fals_inputs = fals_inp_arr;
    n_falsif = !n_falsif;
    total_time = time;
    dump_folder = !Bench.dump_folder;
  }

let _ =
  Random.self_init ();

  let benches =
    Defbench.Autotrans.([
      ("AT1", (module Phi1 : RunBench));
      ("AT2", (module Phi2 : RunBench));
      ("AT51", (module Phi51 : RunBench));
      ("AT52", (module Phi52 : RunBench));
      ("AT53", (module Phi53 : RunBench));
      ("AT54", (module Phi54 : RunBench));
      ("AT6a", (module Phi6a : RunBench));
      ("AT6b", (module Phi6b : RunBench));
      ("AT6c", (module Phi6c : RunBench));

      ("AT1_online", (module Phi1Online : RunBench));
      ("AT2_online", (module Phi2Online : RunBench));
      ("AT51_online", (module Phi51Online : RunBench));
      ("AT52_online", (module Phi52Online : RunBench));
      ("AT53_online", (module Phi53Online : RunBench));
      ("AT54_online", (module Phi54Online : RunBench));
      ("AT6a_online", (module Phi6aOnline : RunBench));
      ("AT6b_online", (module Phi6bOnline : RunBench));
      ("AT6c_online", (module Phi6cOnline : RunBench));
    ])
    @
    Defbench.F16.([
        ("F16", (module Phi : RunBench))
      ])
    @
    Defbench.CC.([
        ("CC1", (module Phi1 : RunBench));
        ("CC2", (module Phi2 : RunBench));
        ("CC3", (module Phi3 : RunBench));
        ("CC4", (module Phi4 : RunBench));
      ])
    @
    Defbench.WT.([
        ("WT1", (module Phi1 : RunBench));
        ("WT2", (module Phi2 : RunBench));
        ("WT3", (module Phi3 : RunBench));
        ("WT4", (module Phi4 : RunBench));
      ])
  in
  let all_benches = fst (List.split benches) in

  let at_offline = [ "AT1"; "AT2"; "AT51"; "AT52"; "AT53"; "AT54";
                    "AT6a"; "AT6b"; "AT6c" ]
  in
  let at_online = [ "AT1_online"; "AT2_online";
                    "AT51_online"; "AT52_online"; "AT53_online"; "AT54_online";
                    "AT6a_online"; "AT6b_online"; "AT6c_online" ]
  in


  let macro_benches = [
    ("AT", at_offline @ at_online);
    ("AT_offline", at_offline);
    ("AT_online", at_online);
    ("all", all_benches)
  ] in

  let n_repet = ref 10 in
  let n_runs = ref 100 in
  let dump_path = ref "" in
  let no_dump = ref false in
  let verbose = ref false in
  let matlab_path = ref "../matlab" in
  let save_history = ref false in

  let opt_args = [
    "-r", Arg.Set_int n_repet, "number of repetitions";
    "-n", Arg.Set_int n_runs, "budget for each repetition: max number of simulations allowed";
    "-d", Arg.Set_string dump_path, "dump path";
    "-no-dump", Arg.Set no_dump, "don't dump results";
    "-matlab", Arg.Set_string matlab_path, "path to arch20/matlab folder relative to dump path";
    "-v", Arg.Set verbose, "verbose";
    "-save-hist", Arg.Set save_history, "save history";
  ] in

  let usg_msg =
    Printf.sprintf "usage: ./run_bench.opt [ OPT_ARGS ] BENCH\n\nBENCH can be one of the following:\n\t%s\n\nOptional arguments:"
      (mk_bench_list_str ((fst (List.split benches)) @ (fst (List.split macro_benches))))
  in

  let sel_bench = ref [] in
  let anon_args a =
    if List.mem_assoc a macro_benches then
      let to_add = List.map (fun b -> List.assoc b benches) (List.assoc a macro_benches) in
      sel_bench := to_add @ !sel_bench
    else if List.mem_assoc a benches then sel_bench := (List.assoc a benches) :: !sel_bench
    else Printf.printf "Don't know bench %s.\n" a;
  in

  Arg.parse opt_args anon_args usg_msg;


  if !sel_bench = [] then begin
    Printf.printf "no valid bench selected.\n\n";
    Arg.usage opt_args usg_msg;
    raise Exit
  end;

  let rec run_benches results b =
    match b with
    | [] -> print_endline "done running benches"; results
    | (module Bench : RunBench) :: q ->
      (* set verbose *)
      Defbench.verbose := !verbose;

      (* set bench params *)
      if !no_dump then
        Bench.dump_path := None
      else if !dump_path <> "" then begin
        Bench.dump_path := Some (Filename.concat !dump_path "fals");
        Bench.matlab_path := Filename.concat "../../" !matlab_path;
      end;

      Bench.save_path := if !save_history then Filename.concat !dump_path "hist" else "";

      let res = run_bench (module Bench) !n_repet !n_runs in

      Printf.printf "%a\n"
        (print_result Bench.print_optim_params) res;

      begin match !Bench.dump_path with
        | None -> ()
        | Some path ->
          let dump_folder = make_dump_folder path Bench.name in

          let info_path = Filename.concat dump_folder "info" in
          let info_fd = open_out info_path in
          Printf.fprintf info_fd "%a\n"
            (print_result Bench.print_optim_params) res;
          close_out info_fd;

          let matlab_test_fd = open_out (Filename.concat dump_folder "test.m") in
          print_matlab_test matlab_test_fd !Bench.matlab_path
            Bench.model_name_in_matlab Bench.prop_name_in_matlab dump_folder;
          close_out matlab_test_fd;

          Printf.printf "Dump saved at %s\nmodel_name: %s\n" dump_folder Bench.model_name_in_matlab
      end;
      run_benches (res :: results) q
  in

  let results = run_benches [] !sel_bench in

  (* write summary.txt *)
  if not !no_dump && !dump_path <> "" then begin
    let summary_path = (Filename.concat !dump_path "summary") in
    let summary_fd = open_out summary_path in
    print_summary summary_fd results;
    Printf.printf "Summary saved at %s\n" summary_path;
    close_out summary_fd;

    let test_all_path = (Filename.concat !dump_path "test_all.m") in
    let test_all_fd = open_out test_all_path in
    print_test_all test_all_fd results;
    close_out test_all_fd;
  end
