module type SUT =
sig
  val name : string
  val prop_name : string
  val max_t : float
  val bounds : (float * float) array
  val sample_every : int
  val node : (FadFloat.t array, float * FadFloat.t array * FadFloat.t) Ztypes.node
end

(* return type of one repetition of a benchmark *)
type 'a one_repet_result = {
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

(* return type of several repetitions of a benchmark *)
type multiple_repet_result = {
  bench: string;            (* cf. one_repet_result.bench *)
  desc: string;             (* cf. one_repet_result.desc *)
  prop: string;             (* cf. one_repet_result.prop *)
  optim: string;            (* cf. one_repet_result.optim *)
  n_repet: int;             (* total number of repetitions *)
  n_runs: int;              (* max number of runs per repetition *)
  mean_n_runs: float;       (* mean number of runs over successfull repetitions *)
  median_n_runs: float;     (* median number of runs over successfull repetitions *)
  fals_inputs: float array; (* all falsifying inputs *)
  best_rob: float;          (* best robustness (lowest) *)
  n_falsif: int;            (* number of falsifying inputs *)
  total_time: float;        (* total time from beginning of first repetition until end of last one *)
}

(* describes one benchmark *)
module type Bench =
sig
  (* a SUT *)
  include SUT

  (* an optimization algorithm *)
  module Optim : Optim.S with type input := float array and type output := float * float array
  val params : Optim.optim_params Optim_types.params

  (* a scenario *)
  module Scenario : Scenario.S with type params := FadFloat.t array and type output := FadFloat.t array
end
