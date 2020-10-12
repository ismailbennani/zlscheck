module NoLogger = Logger.None(struct type t = float * float array * float array * float end)

(* return type of several repetitions of a benchmark *)
type multiple_repet_result = {
  bench: string;                  (* cf. one_repet_result.bench *)
  desc: string;                   (* cf. one_repet_result.desc *)
  prop: string;                   (* cf. one_repet_result.prop *)
  optim: string;                  (* cf. one_repet_result.optim *)
  n_repet: int;                   (* total number of repetitions *)
  n_runs: int;                    (* max number of runs per repetition *)
  mean_n_runs: float;             (* mean number of runs over successfull repetitions *)
  median_n_runs: float;           (* median number of runs over successfull repetitions *)
  fals_inputs: float array array; (* all falsifying inputs *)
  best_rob: float;                (* best robustness (lowest) *)
  n_falsif: int;                  (* number of falsifying inputs *)
  total_time: float;              (* total time from beginning of first repetition until end of last one *)
}

let print_result ff
    { bench; desc; prop; n_repet; n_runs; mean_n_runs; median_n_runs;
       n_falsif; best_rob; total_time } =
  Printf.fprintf ff "name:%s\n" bench;
  Printf.fprintf ff "desc:%s\n" desc;
  Printf.fprintf ff "prop:%s\n" prop;
  Printf.fprintf ff "n_repet:%d\n" n_repet;
  Printf.fprintf ff "n_runs:%d\n" n_runs;
  Printf.fprintf ff "n_falsif:%d\n" n_falsif;
  Printf.fprintf ff "best_rob:%g\n" best_rob;
  Printf.fprintf ff "mean:%g\n" mean_n_runs;
  Printf.fprintf ff "median:%g\n" median_n_runs;
  Printf.fprintf ff "cumulative_time:%g\n" total_time

let benches_at_inst1 :
  (string *
   (module Deftypes.SUT) *
   (module Optim.S with type input = float array
                    and type output = float * float array) *
   float array) list = [
  "offline",
  (module Defsut.Autotrans.Phi1_instance1),
  (module Optim.GDClassic),
  [| 7161212.647361056 |];

  "online",
  (module Defsut.Autotrans.Phi2_instance1),
  (module Optim.GDADAM),
  [| 66951196.73450878; 0.2217670900991342; 0.704381383294684 |];

  "online",
  (module Defsut.Autotrans.Phi6a_instance1),
  (module Optim.GDADAM),
  [| 1.2841439490395001; 0.999908676405291; 0.8736518983634028; |];

  "online",
  (module Defsut.Autotrans.Phi6b_instance1),
  (module Optim.GDAMSGRAD),
  [| 14135.901415449556; 0.8046073346026619; 0.0001693823277275422; |];

  "online",
  (module Defsut.Autotrans.Phi6c_instance1),
  (module Optim.GDAMSGRAD),
  [| 67.2108423947646; 0.5398839392399972; 0.7214824112839869; |];
]

let benches_at_inst2 :
  (string *
   (module Deftypes.SUT) *
   (module Optim.S with type input = float array
                    and type output = float * float array) *
   float array) list = [
  "offline",
  (module Defsut.Autotrans.Phi1_instance2),
  (module Optim.GDClassic),
  [| 3611052.0392934787 |];

  "online",
  (module Defsut.Autotrans.Phi2_instance2),
  (module Optim.GDAMSGRAD),
  [| 11426.005233911408; 0.21309086797609555; 0.14449605677198818; |];

  "online",
  (module Defsut.Autotrans.Phi6a_instance2),
  (module Optim.GDADAM),
  [| 0.3156323092900114; 0.938970783583067; 0.7805515425531845; |];

  "online",
  (module Defsut.Autotrans.Phi6b_instance2),
  (module Optim.GDAMSGRAD),
  [| 151657.5790273785; 0.9405953191235145; 0.9157354932827959; |];

  "online",
  (module Defsut.Autotrans.Phi6c_instance2),
  (module Optim.GDADAM),
  [| 136983.3607134996; 0.0038822759276849785; 0.26817747886434484; |];
]

let benches_wt :
  (string *
   (module Deftypes.SUT) *
   (module Optim.S with type input = float array
                    and type output = float * float array) *
   float array) list = [
   "offline",
   (module Defsut.WT.Phi1),
   (module Optim.GDClassic),
   [| 21.08739495194267; |];

   "offline",
   (module Defsut.WT.Phi2),
   (module Optim.UR_GDAWARE),
   [| |];

   "online",
   (module Defsut.WT.Phi3),
   (module Optim.GDAMSGRAD),
   [| 85.60862492854429; 0.22861294772033192; 0.8902657293770684; |];

   "offline",
   (module Defsut.WT.Phi4),
   (module Optim.UR_GDAWARE),
   [| |];
 ]

let benches_cc :
(string *
 (module Deftypes.SUT) *
 (module Optim.S with type input = float array
                  and type output = float * float array) *
 float array) list = [
   "online",
   (module Defsut.CC.Phi1),
   (module Optim.GDADAM),
   [| 80777401.04129301; 0.974037952568933; 0.9757181377067947; |];

   "online",
   (module Defsut.CC.Phi2),
   (module Optim.GDADAM),
   [| 94875197.23282649; 0.7067017949496157; 0.12379129595959801; |];

   "online",
   (module Defsut.CC.Phi3),
   (module Optim.GDAMSGRAD),
   [| 138264.39331581187; 0.671260748689189; 0.4896204961228039; |];

   "online",
   (module Defsut.CC.Phi4),
   (module Optim.GDADAM),
   [| 0.3465831984869988; 0.9029926683301219; 0.9127255976308775; |];

   "online",
   (module Defsut.CC.Phi5),
   (module Optim.GDADAM),
   [| 2.5210896053993563; 0.9734377599334705; 0.8728999865865236; |];
]

let run_offline max_n_runs
    (module SUT : Deftypes.SUT)
    (module Optim : Optim.S with type input = float array
                             and type output = float * float array)
    (params : float array) =
  let (module Bench : Method_types.RunBench with type Logger.params = unit
                                             and type Optim.optim_params = Optim.optim_params) =
    (module Offline.Make(SUT)(Optim)(NoLogger)) in
  let optim_params = Optim.optim_params_of_array params in
  let default_params = Optim.mk_params 300 SUT.bounds in
  Bench.run () { default_params with optim = optim_params;
                                     verbose = true; }

let run_online max_n_runs
    (module SUT : Deftypes.SUT)
    (module Optim : Optim.S with type input = float array
                             and type output = float * float array)
    (params : float array) =
  let (module Bench : Method_types.RunBench with type Logger.params = unit
                                             and type Optim.optim_params = Optim.optim_params) =
    (module Online.Make(SUT)(Optim)(NoLogger)) in
  let optim_params = Optim.optim_params_of_array params in
  let default_params = Optim.mk_params 300 SUT.bounds in
  Bench.run () { default_params with optim = optim_params;
                                     max_n_runs;
                                     verbose = true; }

let compute_mean a =
  let n = Array.length a in
  if n = 0 then -1.
  else
    let sum = Array.fold_left ( + ) 0 a in
    (float sum) /. (float n)

let compute_median a =
  let n = Array.length a in
  if n = 0 then -1.
  else
    let a' = Array.copy a in
    Array.fast_sort compare a';
    ((float a.((n-1)/2)) +. (float a.(n/2))) /. 2.0;;

let repeat n_repet max_n_runs meth
    (module SUT : Deftypes.SUT)
    (module Optim : Optim.S with type input = float array
                             and type output = float * float array)
    (params : float array) =
  let open Optim_types in
  assert (n_repet > 0);
  let n_falsif = ref 0 in
  let bench_ref = ref None in
  let desc_ref = ref None in
  let prop_ref = ref None in
  let optim_ref = ref None in
  let all_n_runs = ref [] in
  let fals_inputs = ref [] in
  let best_rob_all = ref infinity in

  let start_time = Unix.gettimeofday () in

  for i = 0 to n_repet - 1 do
    let open Deftypes in
    let ({ bench; desc; prop; optim; n_runs;
           best_sample; best_rob; falsified } as res)  =
      if meth = "online"
      then run_online max_n_runs (module SUT) (module Optim) params
      else run_offline max_n_runs (module SUT) (module Optim) params
    in

    bench_ref := Some bench;
    desc_ref := Some desc;
    prop_ref := Some prop;
    optim_ref := Some optim;
    n_falsif := if falsified then !n_falsif + 1 else !n_falsif;
    fals_inputs := if falsified then best_sample :: !fals_inputs else !fals_inputs;
    best_rob_all := if best_rob < !best_rob_all then best_rob else !best_rob_all;
    all_n_runs := if falsified then n_runs :: !all_n_runs else !all_n_runs;
  done;

  let total_time = Unix.gettimeofday () -. start_time in

  let Some bench = !bench_ref in
  let Some desc = !desc_ref in
  let Some prop = !prop_ref in
  let Some optim = !optim_ref in
  let all_n_runs_arr = Array.of_list !all_n_runs in
  let mean_n_runs = compute_mean all_n_runs_arr in
  let median_n_runs = compute_median all_n_runs_arr in
  {
    bench; desc; prop; optim; n_repet;
    n_runs = max_n_runs;
    mean_n_runs; median_n_runs;
    fals_inputs = Array.of_list !fals_inputs;
    best_rob = !best_rob_all;
    n_falsif = !n_falsif;
    total_time;
  }

let _ =
  AdaptativeGradient.Classic.default_params.do_restart <- true;
  AdaptativeGradient.ADAGRAD.default_params.do_restart <- true;
  AdaptativeGradient.ADAM.default_params.do_restart <- true;
  AdaptativeGradient.AMSGRAD.default_params.do_restart <- true;

  List.map
    (fun (meth,
          (module SUT : Deftypes.SUT),
          (module Optim : Optim.S with type input = float array
                                   and type output = float * float array),
          params) ->
      let result = repeat 50 300 meth (module SUT) (module Optim) params in
      Printf.printf "%a\n" print_result result;
      let fd = open_out (result.bench ^ ".out") in
      Printf.fprintf fd "%a\n" print_result result;
      close_out fd)
    ["offline",
    (module Defsut.Autotrans.Phi6a_instance1),
    (module Optim.GDADAM),
    [| 1.2841439490395001; 0.999908676405291; 0.8736518983634028; |];]
    (* benches_wt *)
