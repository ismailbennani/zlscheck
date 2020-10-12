open Optim_types

module NoLogger = Logger.None(struct type t = float * float array * float array * float end)

let optim_algs =
  [
    "ur", (module Optim.UR_GDAWARE : Optim.S
            with type input = float array
             and type output = float * float array);
    (* "sa", (module Optim.SA_GDAWARE : Optim.S
            with type input = float array
             and type output = float * float array); *)
    "gd", (module Optim.GDClassic : Optim.S
            with type input = float array
             and type output = float * float array);
    "gd_adagrad", (module Optim.GDADAGRAD : Optim.S
                    with type input = float array
                     and type output = float * float array);
    "gd_adam", (module Optim.GDADAM : Optim.S
                 with type input = float array
                  and type output = float * float array);
    "gd_amsgrad", (module Optim.GDAMSGRAD : Optim.S
                    with type input = float array
                     and type output = float * float array);
  ]

let params = [|
  SimulatedAnnealing.SA.default_params.dispAdap;
  SimulatedAnnealing.SA.default_params.betaXAdap;
  SimulatedAnnealing.SA.default_params.minDisp;
  SimulatedAnnealing.SA.default_params.maxDisp;
  SimulatedAnnealing.SA.default_params.acRatioMin;
  SimulatedAnnealing.SA.default_params.acRatioMax;
  SimulatedAnnealing.SA.default_params.dispStart;
  SimulatedAnnealing.SA.default_params.betaXStart;
|]

(* for each optim alg, a function to construct the right param record from
   record all_params and a list of key,spec,doc that updates it
   and that will be given to Arg.parse if the corresponding optim alg has been
   chosen *)
let optim_params = [
  "ur", [];
  (* "sa", [
    "-dispAdap", Arg.Float (fun f -> params.(0) <- f), "sa param";
    "-betaXAdap", Arg.Float (fun f -> params.(1) <- f), "sa param";
    "-minDisp", Arg.Float (fun f -> params.(2) <- f), "sa param";
    "-maxDisp", Arg.Float (fun f -> params.(3) <- f), "sa param";
    "-acRatioMin", Arg.Float (fun f -> params.(4) <- f), "sa param";
    "-acRatioMax", Arg.Float (fun f -> params.(5) <- f), "sa param";
    "-dispStart", Arg.Float (fun f -> params.(6) <- f), "sa param";
    "-betaXStart", Arg.Float (fun f -> params.(7) <- f), "sa param";
  ]; *)
  "gd", [
    "-alpha", Arg.Float (fun f -> params.(0) <- f), "gd param";
  ];
  "gd_adagrad", [
    "-alpha", Arg.Float (fun f -> params.(0) <- f), "gd param";
  ];
  "gd_adam", [
    "-alpha", Arg.Float (fun f -> params.(0) <- f), "gd param";
    "-beta1", Arg.Float (fun f -> params.(1) <- f), "gd param";
    "-beta2", Arg.Float (fun f -> params.(2) <- f), "gd param";
  ];
  "gd_amsgrad", [
    "-alpha", Arg.Float (fun f -> params.(0) <- f), "gd param";
    "-beta1", Arg.Float (fun f -> params.(1) <- f), "gd param";
    "-beta2", Arg.Float (fun f -> params.(2) <- f), "gd param";
  ];
]

let param_bounds = [
  (* "dispAdap", (1., 100., false, 10.);
  "betaXAdap", (-100., 100., false, 50.);
  "minDisp", (0., 1., false, 0.01);
  "maxDisp", (0., 1., false, 0.99);
  "acRatioMin", (0., 1., false, 0.45);
  "acRatioMax", (0., 1., false, 0.55);
  "dispStart", (0., 1., false, 0.75);
  "betaXStart", (-50., -1., false, -15.); *)
  "alpha", (1e-1, 1e8, true, 10.);
  "beta1", (0., 1., false, 0.9);
  "beta2", (0., 1., false, 0.99);
]

let optim_param_names =
  List.map (fun (alg, spec) ->
      alg,
      List.map
        (fun (x, _, _) -> String.sub x 1 (String.length x - 1)) spec)
    optim_params

let all_param_names = List.map fst param_bounds

let param_optim =
  List.map
    (fun name -> name,
                 List.filter_map
                   (fun (alg, params) ->
                      if List.mem name params then Some alg else None)
                   optim_param_names)
    all_param_names

let optim_choices = List.map fst optim_algs
let doc_optim =
  Printf.sprintf "optim algorithm to use (%s)"
    (String.concat " | " optim_choices)

let mk_input_name prefix i =
  Printf.sprintf "%s%d" prefix i

let run (systems : (string * (module Deftypes.SUT)) list) =
  let sut = ref "" in
  let optim = ref "" in
  let meth = ref "" in
  let dump_path = ref "benchmarks" in
  let add_init_inputs = ref false in
  let initial_input = ref [||] in
  let max_n_sim = ref 100 in
  let smac_params = Array.make 5 0. in
  let smac_params_i = ref 0 in
  let verbose = ref false in
  let vverbose = ref false in

  let common_speclist = [
    "-o", Arg.Set_string dump_path, "dump path (default: " ^ !dump_path ^ ")";
    "-n", Arg.Set_int max_n_sim, "max number of simulation per run \
                                    (default: " ^ (string_of_int !max_n_sim) ^
                                   ")";
    "-initial", Arg.Set add_init_inputs, "if set, initial inputs are added \
                                          as parameters of SMAC";
    "-v", Arg.Set verbose, "print more stuff";
    "-vv", Arg.Set vverbose, "print even more stuff";
  ] in

  let system_choices = List.map fst systems in
  let doc_sut =
    Printf.sprintf "system to test (%s)"
      (String.concat " | " system_choices)
  in

  let usage_msg =
    Printf.sprintf "usage: %s run [-initial] -sut [ SUT ] -optim [ OPTIM ] \
                    [ OPTIONS ]\n"
       Sys.argv.(0)
  in

  let rec sut_spec_init =
    ("-sut", Arg.String (fun s ->
         if !verbose then
           Printf.eprintf "Selected SUT: %s\n" s;
         sut := s;
         if !meth <> "" && !add_init_inputs then begin
           let (module SUT) = List.assoc s systems in
           let n_inputs, input_prefix =
             if !meth = "online" then
               (Scenario.dim SUT.scenario, "u")
             else if !meth = "offline" then
               (Scenario.n_ctrl_points SUT.scenario, "i")
             else begin
               Printf.eprintf "Unknown method %s\n" !meth;
               Arg.usage !speclist usage_msg;
               exit 1;
             end
           in
           initial_input := Array.make n_inputs 0.;
           speclist :=
             (List.init n_inputs (fun i ->
                  "-" ^ (mk_input_name input_prefix i),
                  Arg.Float (fun f -> !initial_input.(i) <- f),
                  Printf.sprintf "set initial input %d" i)) @
             (if !optim = "" then [optim_spec_init]
              else List.assoc !optim optim_params) @
             common_speclist
         end), doc_sut)
  and meth_spec_init =
    ("-method", Arg.String (fun s ->
         if !verbose then
           Printf.eprintf "Selected method: %s\n" s;
         meth := s;
         if !sut <> "" && !add_init_inputs then begin
           let (module SUT) = List.assoc !sut systems in
           let n_inputs, input_prefix =
             if !meth = "online" then
               (Scenario.dim SUT.scenario, "u")
             else if !meth = "offline" then
               (Scenario.n_ctrl_points SUT.scenario, "i")
             else begin
               Printf.eprintf "Unknown method %s\n" !meth;
               Arg.usage !speclist usage_msg;
               exit 1;
             end
           in
           initial_input := Array.make n_inputs 0.;
           speclist :=
             (List.init n_inputs (fun i ->
                  "-" ^ (mk_input_name input_prefix i),
                  Arg.Float (fun f -> !initial_input.(i) <- f),
                  Printf.sprintf "set initial input %d" i)) @
             (if !optim = "" then [optim_spec_init]
              else List.assoc !optim optim_params) @
             common_speclist
         end), "method ( online | offline )")
  and optim_spec_init =
    ("-optim", Arg.String (fun s ->
         if !verbose then
           Printf.eprintf "Selected OPTIM: %s\n" s;
         optim := s;
         speclist := (if !sut <> "" && !meth <> "" && !add_init_inputs then
                        let (module SUT) = List.assoc !sut systems in
                        let n_inputs, input_prefix =
                          if !meth = "online" then
                            (Scenario.dim SUT.scenario, "u")
                          else if !meth = "offline" then
                            (Scenario.n_ctrl_points SUT.scenario, "i")
                          else begin
                            Printf.eprintf "Unknown method %s\n" !meth;
                            Arg.usage !speclist usage_msg;
                            exit 1;
                          end
                        in
                        List.init n_inputs (fun i ->
                            "-" ^ (mk_input_name input_prefix i),
                            Arg.Float (fun f -> !initial_input.(i) <- f),
                            Printf.sprintf "set initial input %d" i)
                      else if !sut = "" && !meth = "" then
                        [sut_spec_init; meth_spec_init]
                      else if !sut = "" then [sut_spec_init]
                      else if !meth = "" then [meth_spec_init]
                      else []
                     ) @
                     (List.assoc s optim_params) @
                     common_speclist
       ), doc_optim)
  and speclist = ref (sut_spec_init ::
                      optim_spec_init ::
                      meth_spec_init ::
                      common_speclist) in

  Arg.parse_dynamic speclist
    (fun s ->
       smac_params.(!smac_params_i) <- float_of_string s;
       smac_params_i := !smac_params_i + 1)
    usage_msg;

  if !sut = "" || !optim = "" then begin
    Printf.eprintf "%s not defined\n"
      (if !sut = "" then "SUT" else "OPTIM algorithm");
    Arg.usage !speclist usage_msg;
    exit 1;
  end;

  let (module SUT) = List.assoc !sut systems in
  let (module Optim : Optim.S
        with type input = float array
         and type output = float * float array) =
    List.assoc !optim optim_algs
  in
  let (module RunBench : Method_types.RunBench
        with type Logger.params = unit) =
    if !meth = "online" then
      (module Online.Make(SUT)(Optim)(NoLogger))
    else if !meth = "offline" then
      (module Offline.Make(SUT)(Optim)(NoLogger))
    else begin
      Printf.eprintf "Unknown method %s\n" !meth;
      Arg.usage !speclist usage_msg;
      exit 1;
    end
  in

  let instance = truncate smac_params.(0) in
  let instance_specifics = truncate smac_params.(1) in
  let cutoff_time = smac_params.(2) in
  let run_length = truncate smac_params.(3) in
  let seed = truncate smac_params.(4) in

  Random.init seed;

  let optim_params = RunBench.optim_params_of_array params in
  let params = { (Optim.mk_params !max_n_sim SUT.bounds) with
                 init_sample =
                   if Array.length !initial_input = 0
                   then None
                   else Some !initial_input;
                 verbose = false;
                 vverbose = false;
                 optim = optim_params;
               }
  in

  if !vverbose then begin
    Printf.eprintf "Zlscheck starting...\n";
    Printf.eprintf "SUT: %s\n" SUT.name;
    Printf.eprintf "Optim: %s\n" Optim.name;
    Printf.eprintf "Scenario: %a\n" Scenario.fprintf SUT.scenario;
    Printf.eprintf "Initial input: %a\n" Printer.print_float_array
      !initial_input;
    Printf.eprintf "Params: %s\n" (RunBench.string_of_params params);
    Printf.eprintf "SMAC params: instance=%d instance_specifics=%d \
                    cutoff_time=%g run_length=%d seed=%d\n"
      instance instance_specifics cutoff_time run_length seed;
  end;

  (* DO STUFF *)

  if not (Sys.file_exists !dump_path) then
    ignore (Sys.command ("mkdir -p " ^ !dump_path ^ " &> /dev/null"));
  let filepath = Filename.concat !dump_path "result.out" in
  let result = RunBench.run () params in

  Printf.printf "Result for SMAC: SUCCESS, %g, %d, %g, %d, %d\n"
    result.elapsed_time result.n_runs result.best_rob seed instance_specifics

let mk_config (systems : (string * (module Deftypes.SUT)) list) =
  let sut = ref "" in
  let path = ref "." in
  let cmd = ref Sys.argv.(0) in
  let add_init_inputs = ref false in
  let time_limit = ref 60.0 in
  let max_n_sim = ref 0 in
  let verbose = ref false in
  let vverbose = ref false in

  let system_choices = List.map fst systems in
  let doc_sut =
    Printf.sprintf "system to test (%s)"
      (String.concat " | " system_choices)
  in

  let usage_msg = Printf.sprintf "usage: %s make -sut [ SUT ] [ OPTIONS ]\n" Sys.argv.(0) in

  let speclist = [
    "-sut", Arg.Set_string sut, doc_sut;
    "-time_limit", Arg.Set_float time_limit, "maximum amount of CPU-time used \
                                              for optimization (default: " ^
                                             (string_of_float !time_limit) ^
                                             ")";
    "-o", Arg.Set_string path, "output directory";
    "-cmd", Arg.Set_string cmd, "command to run target algorithm \
                                 (default: argv[0])";
    "-initial", Arg.Set add_init_inputs, "if set, initial inputs are added \
                                          as parameters of SMAC";
    "-n", Arg.Set_int max_n_sim, "max number of simulations per run";
    "-v", Arg.Set verbose, "print more stuff";
    "-vv", Arg.Set vverbose, "print even more stuff";
  ] in
  Arg.parse speclist (fun _ -> ()) usage_msg;

  if !sut = "" then begin
    Printf.eprintf "SUT not defined\n";
    Arg.usage speclist usage_msg;
    exit 1
  end;

  let (module SUT) = List.assoc !sut systems in
  let n_inputs_online = Scenario.dim SUT.scenario in
  let n_inputs_offline = Scenario.n_ctrl_points SUT.scenario in
  let input_names_online = List.init n_inputs_online (mk_input_name "u") in
  let input_names_offline = List.init n_inputs_offline (mk_input_name "i") in

  let uniq_param_names =  List.sort_uniq String.compare
      (List.concat (List.map snd optim_param_names))
  in

  let cmd = Printf.sprintf "%s run %s%s-sut %s%s%s"
      !cmd
      (if !add_init_inputs then "-initial " else "")
      (if !max_n_sim > 0 then "-n " ^ (string_of_int !max_n_sim) ^ " " else "")
      !sut
      (if !verbose then " -v" else "")
      (if !vverbose then " -vv" else "")
  in

  if not (Sys.file_exists !path) then begin
    if !verbose || !vverbose then
      Printf.eprintf "Create folder %s\n" !path;
    ignore (Unix.system ("mkdir -p " ^ !path ^ " &> /dev/null"));
    while not (Sys.file_exists !path) do Unix.sleep 1 done;
  end;

  let scenario_filepath = Filename.concat !path "scenario.txt" in
  let scenario_fd = open_out scenario_filepath in

  Printf.fprintf scenario_fd "ta = %s\n\
                              pcs_fn = param_config_space.pcs\n\
                              run_obj = quality\n\
                              wallclock_limit = %g\n\
                              cutoff_time = %g\n\
                              output_dir = results\n\
                              deterministic = 0\n"
    cmd !time_limit (!time_limit /. 2.);
  close_out scenario_fd;

  Printf.printf "Successfully saved %s.\n" scenario_filepath;

  let param_config_filepath = Filename.concat !path "param_config_space.pcs" in
  let param_config_fd = open_out param_config_filepath in

  Printf.fprintf param_config_fd "optim { %s } [ %s ]\n\
                                  method { online, offline } [ offline ]\n\
                                  \n\
                                  %s\n\
                                  %s\n\
                                  %s\n\
                                  \n\
                                  # Conditionals:\n\
                                  %s\n\
                                  %s\n\
                                  %s\n"
    (String.concat ", " optim_choices) (List.hd optim_choices)
    (if !add_init_inputs then
       String.concat "\n"
         (List.mapi
            (fun i n -> Printf.sprintf "%s [%g, %g] [%g]"
                n (fst SUT.bounds.(i)) (snd SUT.bounds.(i))
                (((fst SUT.bounds.(i)) +. (snd SUT.bounds.(i))) /. 2.))
            input_names_online)
     else "")
    (if !add_init_inputs then
       String.concat "\n"
         (List.mapi
            (fun i n ->
               let n_pieces =
                 truncate
                   (ceil
                      ((float (Scenario.n_ctrl_points SUT.scenario)) /.
                       (float (Scenario.dim SUT.scenario))))
               in
               let minv = fst SUT.bounds.(i / n_pieces) in
               let maxv = snd SUT.bounds.(i / n_pieces) in
               Printf.sprintf "%s [%g, %g] [%g]"
                 n minv maxv ((minv +. maxv) /. 2.)
            ) input_names_offline)
     else "")
    (String.concat "\n"
       (List.map
          (fun n ->
             let (minv, maxv, logscale, defaultv) = List.assoc n param_bounds in
             Printf.sprintf "%s [%g, %g] [%g]%s" n minv maxv defaultv
               (if logscale then " log" else ""))
          uniq_param_names))
    (if !add_init_inputs then
       String.concat "\n" (List.map (Printf.sprintf "%s | method in { online }")
                             input_names_online)
     else "")
    (if !add_init_inputs then
       String.concat "\n" (List.map (Printf.sprintf "%s | method in { offline }")
                             input_names_offline)
     else "")
    (String.concat "\n" (List.map (fun (param, algs) ->
         Printf.sprintf "%s | optim in { %s }"
           param (String.concat ", " algs))
         param_optim));
  close_out param_config_fd;

  Printf.printf "Successfully saved %s.\n" param_config_filepath

let main systems =
  let usage_msg =
    Printf.sprintf "usage: %s [ make | run ] [ OPTIONS ]\n"
      Sys.argv.(0)
  in

  Arg.parse []
    (fun s ->
       if s = "run" then begin (run systems); exit 0 end
       else if s = "make" then begin (mk_config systems); exit 0 end
       else Arg.usage [] usage_msg
    ) usage_msg;

  Arg.usage [] usage_msg
