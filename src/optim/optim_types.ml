type optim_mode = Falsify | Minimize

type ('a, 'b) step_params = {
  mutable online : bool;
  mutable mode: optim_mode;
  mutable n_runs : int;
  mutable history : 'b list;
  mutable best_result : 'b;
  mutable last_result : 'b;
  optim_step : 'a;
}

type gpo_params = {
  mutable nb_init_samples : int;
  mutable a : float;
  mutable b : float;
  mutable alpha : float;
  mutable beta : float;
  mutable eps : float;
  mutable gd_miniter : int;
  mutable gd_maxiter : int;
  mutable gd_alpha : float;
}

type 'a params = {
  mutable max_n_runs: int;
  mutable bounds: (float * float) array;
  mutable init_sample: float array option;
  mutable verbose: bool;
  mutable vverbose: bool;
  optim: 'a;
}

module type OptimAlg =
sig
  type input
  type output
  type optim_params
  type optim_step_params
  val name : string

  val string_of_params : optim_params -> string
  val default_params : optim_params
  val mk_step_params : optim_params params -> optim_step_params

  (* history, best_result_yet = step params step_params history old_result *)
  val step :
    optim_params params ->
    (optim_step_params, input * output) step_params ->
    (* function to increment number of runs *)
    (unit -> unit) ->
    (* function to optimize *)
    (input -> output) -> unit

  val get_rob_from_output : output -> float
end

module type S =
sig
  val name : string
  type input
  type output
  type optim_params
  type optim_step_params

  val mk_step_params :
    (input * output) -> (optim_step_params, input * output) step_params

  val string_of_params : optim_params params -> string
  val step :
    (input -> output) ->
    optim_params params ->
    (optim_step_params, input * output) step_params ->
    bool
  val run :
    (input -> output) ->
    optim_params params ->
    (input * output) list * (input * output)
  val falsify : (input -> output) -> (input * output) list * (input * output)
  val minimize : (input -> output) -> (input * output) list * (input * output)

  val get_rob_from_output : output -> float
end
