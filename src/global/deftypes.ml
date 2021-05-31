module type SUT =
sig
  val name : string
  val prop_name : string
  val max_t : float
  val tstep : float
  val sample_every : int
  val bounds : (float * float) array
  val node : (FadFloat.t array, float * FadFloat.t array * FadFloat.t) Ztypes.node
  val scenario : FadFloat.t Scenario.t
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
