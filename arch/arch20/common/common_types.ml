open Ztypes

(* return type of one repetition of a benchmark
   this type is returned by Offline.Make(..).run and Online.Make(..).run,
   cf zlscheck/examples/arch20/common/offline.ml and online.ml *)
type 'a one_repet_result = {
  model_name: string;  (* name of model being benchmarked *)
  bench: string;       (* name of this benchmark *)
  desc: string;        (* description of this benchmark *)
  prop: string;        (* description of this benchmark *)
  optim: string;       (* name of optim algorithm *)
  n_runs: int;         (* total number of simulation runs *)
  samples: 'a array;   (* all the inputs that have been sampled *)
  robs: float array;   (* all the robustness that have been obtained (in same order than samples) *)
  best_sample: 'a;     (* input with best robustness (lowest) *)
  best_rob: float;     (* best robustness (lowest) *)
  falsified: bool;     (* is best_rob < 0 ? *)
  elapsed_time: float; (* total time from beginning of first sim until end of last one in seconds *)
}

(* return type of several repetition of a benchmark
   this type is returned by Run_bench.run_benches
   cf zlscheck/examples/arch20/run_bench.ml *)
type 'a multiple_repet_result = {
  model_name: string;    (* cf one_repet_result.model_name *)
  bench: string;         (* cf one_repet_result.bench *)
  desc: string;          (* cf one_repet_result.desc *)
  prop: string;          (* cf one_repet_result.desc *)
  optim: string;         (* cf one_repet_result.optim *)
  n_repet: int;          (* total number of repetitions *)
  n_runs: int;           (* max number of runs per repetition *)
  mean_n_runs: float;    (* mean number of runs over successfull repetitions *)
  median_n_runs: float;  (* median number of runs over successfull repetitions *)
  fals_inputs: 'a array; (* all falsifying inputs *)
  best_rob: float;       (* best robustness (lowest) *)
  n_falsif: int;         (* number of falsifying inputs *)
  total_time: float;     (* total time from beginning of first repetition until end of last one *)
}

(* describes a replay node *)
module type Replay =
sig
  val name : string
  val max_t : float
  val replay_node : (float array * MyOp.t array array, unit) node
  val scan_dump_inp : Scanf.Scanning.in_channel -> MyOp.t array
  (* val print_dump_inp : out_channel -> MyOp.t array -> unit *)
end

(* type of Replay.Make(..), cf. zlscheck/examples/arch20/common/replay.ml *)
module type RunReplay =
sig
  val name : string
  val run : string -> unit
end

(* describes one benchmark *)
module type Bench =
sig
  module Optim : Optim.S with type input := float array and type output := float * float array

  val name : string
  val prop_name : string
  val max_t : float
  val sample_every : int (* used by online optim *)

  val prop_name_in_matlab : string
  val model_name_in_matlab : string
  val folder_name_in_shared : string

  val dump_path : string
  val shared_path : string

  val node : (MyOp.t array, float * MyOp.t array * MyOp.t) node

  val set_optim_params: unit -> unit
  (* take k parameters and output a function from time to num_signals values *)
  val interp_fn : MyOp.t array -> float -> MyOp.t array
end

(* type of Online.Make(..) and Offline.Make(..), cf
   cf zlscheck/examples/arch20/common/offline.ml and online.ml *)
module type RunBench =
sig
  module Optim : Optim.S with type input := float array and type output := float * float array
  val name : string
  val bench_name : string
  val prop_name : string
  val prop_name_in_matlab : string
  val model_name_in_matlab : string
  val folder_name_in_shared : string
  val pindex : int ref
  val dump_path : string option ref
  val dump_folder : string option ref
  val shared_path : string ref
  val save_path : string ref
  val print_optim_params : out_channel -> unit -> unit
  val run : unit -> float array one_repet_result
end
