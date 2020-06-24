open Common_types
open Common_utils

type run_bench_inputs = {
  in_n_repet : int;
  in_n_runs : int;
  in_n_processes : int;
  dump_path : string;
  no_dump : bool;
  verbose : bool;
  matlab_path : string;
  save_history : bool;
  benches : (module Common_types.RunBench) list;
}

let get_inputs () =
  let benches =
    Defbench.Autotrans.([
        ("AT1_inst1", (module Phi1_instance1 : RunBench));
        ("AT2_inst1", (module Phi2_instance1 : RunBench));
        ("AT51_inst1", (module Phi51_instance1 : RunBench));
        ("AT52_inst1", (module Phi52_instance1 : RunBench));
        ("AT53_inst1", (module Phi53_instance1 : RunBench));
        ("AT54_inst1", (module Phi54_instance1 : RunBench));
        ("AT6a_inst1", (module Phi6a_instance1 : RunBench));
        ("AT6b_inst1", (module Phi6b_instance1 : RunBench));
        ("AT6c_inst1", (module Phi6c_instance1 : RunBench));

        ("AT1_inst1_ur", (module Phi1UR_instance1 : RunBench));
        ("AT2_inst1_ur", (module Phi2UR_instance1 : RunBench));
        ("AT51_inst1_ur", (module Phi51UR_instance1 : RunBench));
        ("AT52_inst1_ur", (module Phi52UR_instance1 : RunBench));
        ("AT53_inst1_ur", (module Phi53UR_instance1 : RunBench));
        ("AT54_inst1_ur", (module Phi54UR_instance1 : RunBench));
        ("AT6a_inst1_ur", (module Phi6aUR_instance1 : RunBench));
        ("AT6b_inst1_ur", (module Phi6bUR_instance1 : RunBench));
        ("AT6c_inst1_ur", (module Phi6cUR_instance1 : RunBench));

        ("AT1_inst2", (module Phi1_instance2 : RunBench));
        ("AT2_inst2", (module Phi2_instance2 : RunBench));
        ("AT51_inst2", (module Phi51_instance2 : RunBench));
        ("AT52_inst2", (module Phi52_instance2 : RunBench));
        ("AT53_inst2", (module Phi53_instance2 : RunBench));
        ("AT54_inst2", (module Phi54_instance2 : RunBench));
        ("AT6a_inst2", (module Phi6a_instance2 : RunBench));
        ("AT6b_inst2", (module Phi6b_instance2 : RunBench));
        ("AT6c_inst2", (module Phi6c_instance2 : RunBench));

        ("AT1_inst2_ur", (module Phi1UR_instance2 : RunBench));
        ("AT2_inst2_ur", (module Phi2UR_instance2 : RunBench));
        ("AT51_inst2_ur", (module Phi51UR_instance2 : RunBench));
        ("AT52_inst2_ur", (module Phi52UR_instance2 : RunBench));
        ("AT53_inst2_ur", (module Phi53UR_instance2 : RunBench));
        ("AT54_inst2_ur", (module Phi54UR_instance2 : RunBench));
        ("AT6a_inst2_ur", (module Phi6aUR_instance2 : RunBench));
        ("AT6b_inst2_ur", (module Phi6bUR_instance2 : RunBench));
        ("AT6c_inst2_ur", (module Phi6cUR_instance2 : RunBench));
      ])
    @
    Defbench.F16.([
        ("F16", (module Phi : RunBench));
        ("F16_ur", (module PhiUR : RunBench));
      ])
    @
    Defbench.CC.([
        ("CC1", (module Phi1 : RunBench));
        ("CC2", (module Phi2 : RunBench));
        ("CC3", (module Phi3 : RunBench));
        ("CC4", (module Phi4 : RunBench));
        ("CC5", (module Phi5 : RunBench));
        ("CC1_ur", (module Phi1UR : RunBench));
        ("CC2_ur", (module Phi2UR : RunBench));
        ("CC3_ur", (module Phi3UR : RunBench));
        ("CC4_ur", (module Phi4UR : RunBench));
        ("CC5_ur", (module Phi5UR : RunBench));
      ])
    @
    Defbench.WT.([
        ("WT1", (module Phi1 : RunBench));
        ("WT2", (module Phi2 : RunBench));
        ("WT3", (module Phi3 : RunBench));
        ("WT4", (module Phi4 : RunBench));
        ("WT1_ur", (module Phi1UR : RunBench));
        ("WT2_ur", (module Phi2UR : RunBench));
        ("WT3_ur", (module Phi3UR : RunBench));
        ("WT4_ur", (module Phi4UR : RunBench));
      ])
    @
    Defbench.AFC.([
        ("AFC27", (module Phi27 : RunBench));
        ("AFC29", (module Phi29 : RunBench));
        ("AFC33", (module Phi33 : RunBench));
        ("AFC27_ur", (module Phi27UR : RunBench));
        ("AFC29_ur", (module Phi29UR : RunBench));
        ("AFC33_ur", (module Phi33UR : RunBench));
      ])
    @
    Defbench.SC.([
        ("SC_inst1", (module Phi_inst1 : RunBench));
        ("SC_inst2", (module Phi_inst2 : RunBench));
        ("SC_inst1_ur", (module PhiUR_inst1 : RunBench));
        ("SC_inst2_ur", (module PhiUR_inst2 : RunBench));
      ])
    @
    Defbench.NN.([
        ("NN1_inst1", (module Phi1_inst1 : RunBench));
        ("NN1_inst2", (module Phi1_inst2 : RunBench));
        ("NN2_inst1", (module Phi2_inst1 : RunBench));
        ("NN2_inst2", (module Phi2_inst2 : RunBench));
        ("NN1_inst1_ur", (module Phi1UR_inst1 : RunBench));
        ("NN1_inst2_ur", (module Phi1UR_inst2 : RunBench));
        ("NN2_inst1_ur", (module Phi2UR_inst1 : RunBench));
        ("NN2_inst2_ur", (module Phi2UR_inst2 : RunBench));
      ])
  in
  let all_benches = fst (List.split benches) in

  let at_inst1 = [ "AT1_inst1"; "AT2_inst1"; "AT51_inst1"; "AT52_inst1";
                   "AT53_inst1"; "AT54_inst1"; "AT6a_inst1"; "AT6b_inst1";
                   "AT6c_inst1" ]
  in
  let at_inst2 = [ "AT1_inst2"; "AT2_inst2"; "AT51_inst2"; "AT52_inst2";
                   "AT53_inst2"; "AT54_inst2"; "AT6a_inst2"; "AT6b_inst2";
                   "AT6c_inst2" ]
  in
  let at_inst1_ur = [ "AT1_inst1_ur"; "AT2_inst1_ur"; "AT51_inst1_ur"; "AT52_inst1_ur";
                      "AT53_inst1_ur"; "AT54_inst1_ur"; "AT6a_inst1_ur"; "AT6b_inst1_ur";
                      "AT6c_inst1_ur" ]
  in
  let at_inst2_ur = [ "AT1_inst2_ur"; "AT2_inst2_ur"; "AT51_inst2_ur"; "AT52_inst2_ur";
                      "AT53_inst2_ur"; "AT54_inst2_ur"; "AT6a_inst2_ur"; "AT6b_inst2_ur";
                      "AT6c_inst2_ur" ]
  in
  let cc = ["CC1"; "CC2"; "CC3"; "CC4"; "CC5"] in
  let cc_ur = ["CC1_ur"; "CC2_ur"; "CC3_ur"; "CC4_ur"; "CC5_ur"] in
  let wt = ["WT1"; "WT2"; "WT3"; "WT4"] in
  let wt_ur = ["WT1_ur"; "WT2_ur"; "WT3_ur"; "WT4_ur"] in
  let sc = ["SC_inst1"; "SC_inst2"] in
  let sc_ur = ["SC_inst1_ur"; "SC_inst2_ur"] in
  let nn_inst1 = ["NN1_inst1"; "NN2_inst1"] in
  let nn_inst2 = ["NN1_inst2"; "NN2_inst2"] in
  let nn_inst1_ur = ["NN1_inst1_ur"; "NN2_inst1_ur"] in
  let nn_inst2_ur = ["NN1_inst2_ur"; "NN2_inst2_ur"] in

  let macro_benches = [
    ("AT_inst1", at_inst1);
    ("AT_inst2", at_inst2);
    ("AT_inst1_ur", at_inst1_ur);
    ("AT_inst2_ur", at_inst2_ur);
    ("AT", at_inst1 @ at_inst2);
    ("AT_ur", at_inst1_ur @ at_inst2_ur);
    ("CC", cc);
    ("CC_ur", cc_ur);
    ("WT", wt);
    ("WT_ur", wt_ur);
    ("SC", sc);
    ("SC_ur", sc_ur);
    ("NN_inst1", nn_inst1);
    ("NN_inst2", nn_inst2);
    ("NN_inst1_ur", nn_inst1_ur);
    ("NN_inst2_ur", nn_inst2_ur);
    ("NN", nn_inst1 @ nn_inst2);
    ("NN_ur", nn_inst1_ur @ nn_inst2_ur);
    ("all", at_inst1 @ at_inst2 @ cc @ wt @ sc @ nn_inst1 @ nn_inst2);
    ("all_ur", at_inst1_ur @ at_inst2_ur @ cc_ur @ wt_ur @ sc_ur @ nn_inst1_ur @ nn_inst2_ur);
  ] in

  let n_repet = ref 10 in
  let n_runs = ref 100 in
  let n_processes = ref 1 in
  let dump_path = ref "" in
  let no_dump = ref false in
  let verbose = ref false in
  let matlab_path = ref "../matlab" in
  let save_history = ref false in

  let opt_args = [
    "-r", Arg.Set_int n_repet, "number of repetitions";
    "-n", Arg.Set_int n_runs, "budget for each repetition: max number of simulations allowed";
    "-j", Arg.Set_int n_processes, "max number of processes to spawn";
    "-d", Arg.Set_string dump_path, "dump path (default: benchmarks/modelname)";
    "-no-dump", Arg.Set no_dump, "don't dump results";
    "-matlab", Arg.Set_string matlab_path, "path to arch20/matlab folder relative to dump path";
    "-v", Arg.Set verbose, "verbose";
    "-save-hist", Arg.Set save_history, "save history in addition to falsifying runs";
  ] in

  let usg_msg =
    Printf.sprintf "usage: ./run_bench.opt [ OPT_ARGS ] BENCH( BENCH)*\n\nBENCH is either a MACRO or an INDIVIDUAL BENCH:\n%s\n\nOptional arguments:"
      (mk_bench_list_str (fst (List.split benches)) macro_benches)
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
  {
    in_n_repet = !n_repet;
    in_n_runs = !n_runs;
    in_n_processes = !n_processes;
    dump_path = !dump_path;
    no_dump = !no_dump;
    verbose = !verbose;
    matlab_path = !matlab_path;
    save_history = !save_history;
    benches = !sel_bench;
  }

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
    model_name = Bench.model_name_in_matlab;
    bench = Bench.bench_name;
    desc = Bench.name;
    optim = Bench.Optim.name;
    n_repet = n_repet;
    n_runs = n_runs;
    mean_n_runs = compute_mean n_runs_arr;
    median_n_runs = compute_median n_runs_arr;
    fals_inputs = fals_inp_arr;
    n_falsif = !n_falsif;
    total_time = time;
  }

let run_bench_parallel (module Bench : RunBench) n_repet n_runs n_processes =
  Optim_globals.params.max_n_runs <- n_runs;

  (* n_repets for each child *)
  let n_repets = Array.make n_processes (n_repet / n_processes) in
  for i = 0 to (n_repet mod n_processes) - 1 do
    n_repets.(i) <- n_repets.(i) + 1;
  done;
  (* one run is done by main process to set Bench global state *)
  n_repets.(0) <- n_repets.(0) - 1;

  (* where to write results *)
  let outp_filenames = Hashtbl.create n_processes in

  flush stdout;
  (* spawn children with unique ids *)
  for i = 0 to n_processes - 1 do
    let tmp_file = Filename.temp_file "benchresult" "" in
    match Unix.fork () with
    | 0 ->
      Random.self_init ();
      let n_repet = n_repets.(i) in
      let start_time = Unix.gettimeofday () in

      Bench.pindex := i + 1;

      let n_falsif = ref 0 in
      let n_runs_l = ref [] in
      let start_time = Unix.gettimeofday () in

      for j = 0 to n_repet - 1 do
        Printf.printf "[Child %d] -- Bench %d/%d\n"
          (Unix.getpid ()) (j+1) n_repet;

        let res = Bench.run () in

        if res.falsified then begin
          n_falsif := !n_falsif + 1;
          n_runs_l := res.n_runs :: !n_runs_l
        end
      done;

      let time = Unix.gettimeofday () -. start_time in

      (* write results *)
      let out_fd = open_out tmp_file in
      Printf.fprintf out_fd "repet:%d\nn_falsif:%d\n%atime:%g\n"
        n_repet !n_falsif
        (fun ff l -> List.iter (fun n -> Printf.fprintf ff "n_runs:%d\n" n) l)
        !n_runs_l time;
      close_out out_fd;
      exit 0
    | id ->
      Printf.printf "Spawned child with id %d ...\n" id; flush stdout;
      Hashtbl.add outp_filenames id tmp_file;
  done;

  (* one run is done by main process to set Bench global state *)
  let start_time = Unix.gettimeofday () in
  let res = Bench.run () in
  let time = Unix.gettimeofday () -. start_time in

  let n_runs_l = ref (if res.falsified then [res.n_runs] else []) in
  let total_falsif = ref (if res.falsified then 1 else 0) in
  let total_time = ref time in

  (* wait for children termination and read results *)
  for i = 0 to n_processes - 1 do
    let (pid,_) = Unix.waitpid [] (-1) in

    let tmp_file = Hashtbl.find outp_filenames pid in
    Printf.printf "Child %d done. Reading results in %s ...\n"
      pid tmp_file;

    let fd = ref (Scanf.Scanning.open_in tmp_file) in

    let n_retry = ref 0 in
    while Scanf.Scanning.end_of_input !fd && !n_retry < 10 do
      Scanf.Scanning.close_in !fd;
      Printf.printf "File %s empty, retry in 1 sec (%d/10)\n" tmp_file !n_retry;
      Unix.sleep 1;
      fd := Scanf.Scanning.open_in tmp_file;
      n_retry := !n_retry + 1;
    done;

    if (Scanf.Scanning.end_of_input !fd) then
      Printf.printf "File %s empty, ignoring it.\n" tmp_file
    else begin
      let this_n_falsif = ref 0 in
      Scanf.bscanf !fd "repet:%d\n" (fun n_repet -> ());
      Scanf.bscanf !fd "n_falsif:%d\n"
        (fun n_falsif ->
           this_n_falsif := n_falsif;
           total_falsif := n_falsif + !total_falsif);
      for i = 0 to !this_n_falsif - 1 do
        Scanf.bscanf !fd "n_runs:%d\n"
          (fun n_runs -> n_runs_l := n_runs :: !n_runs_l);
      done;
      Scanf.bscanf !fd "time:%g"
        (fun time -> total_time := time +. !total_time);
    end;

    Scanf.Scanning.close_in !fd;
  done;

  {
    model_name = Bench.model_name_in_matlab;
    bench = Bench.bench_name;
    desc = Bench.name;
    optim = Bench.Optim.name;
    n_repet = n_repet;
    n_runs = n_runs;
    mean_n_runs = compute_mean (Array.of_list !n_runs_l);
    median_n_runs = compute_median (Array.of_list !n_runs_l);
    fals_inputs = [||];
    n_falsif = !total_falsif;
    total_time = !total_time;
  }

let rec run_benches inputs results b =
  match b with
  | [] -> print_endline "done running benches"; results
  | (module Bench : RunBench) :: q ->
    Printf.printf "Starting bench %s\n" Bench.name;

    (* set verbose *)
    Defbench.verbose := inputs.verbose;

    (* set bench params *)
    if inputs.no_dump then
      Bench.dump_path := None
    else if inputs.dump_path <> "" then begin
      Bench.dump_path := Some (Filename.concat inputs.dump_path "fals");
      Bench.matlab_path := Filename.concat "../../" inputs.matlab_path;
    end;

    Bench.save_path :=
      if inputs.save_history
      then Filename.concat inputs.dump_path "hist"
      else "";

    let res =
      if inputs.in_n_processes = 1 then
        run_bench (module Bench) inputs.in_n_repet inputs.in_n_runs
      else
        run_bench_parallel (module Bench)
          inputs.in_n_repet inputs.in_n_runs inputs.in_n_processes
    in

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

        let matlab_validate_fd = open_out (Filename.concat dump_folder "validate.m") in
        print_matlab_validate matlab_validate_fd Bench.bench_name !Bench.matlab_path
          Bench.model_name_in_matlab Bench.prop_name_in_matlab Bench.folder_name_in_shared;
        close_out matlab_validate_fd;

        Printf.printf "Dump saved at %s\nmodel_name: %s\n"
          dump_folder Bench.model_name_in_matlab
    end;
    run_benches inputs (res :: results) q

let _ =
  Random.self_init ();

  let inputs = get_inputs () in
  let results = run_benches inputs [] inputs.benches in

  (* write summary.txt *)
  if not inputs.no_dump && inputs.dump_path <> "" then begin
    let validate_all_path = (Filename.concat inputs.dump_path "validate_all.m") in
    if not (Sys.file_exists validate_all_path) then begin
      let validate_all_fd = open_out validate_all_path in
      print_validate_all validate_all_fd inputs.matlab_path;
      close_out validate_all_fd;
    end
  end
