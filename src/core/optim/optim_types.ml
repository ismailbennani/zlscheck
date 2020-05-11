type optim_mode = Falsify | Minimize

type ('a, 'b) step_params = {
  mutable n_runs : int;
  mutable history : 'b list;
  mutable best_result : 'b;
  mutable last_result : 'b;
  optim_step : 'a;
}

type ur_params = unit

type particle_params = {
  mutable n : int;
}

type sa_params = {
  mutable dispAdap : float;
  mutable betaXAdap : float;
  mutable minDisp : float;
  mutable maxDisp : float;
  mutable acRatioMin : float;
  mutable acRatioMax : float;

  mutable dispStart : float;
  mutable betaXStart : float;
}

type gd_params = {
  mutable do_restart : bool;
  mutable alpha : float;
  mutable beta1 : float;
  mutable beta2 : float;
}

type method_params = {
  ur : ur_params;
  particle : particle_params;
  sa : sa_params;
  gd : gd_params;
}

type params = {
  mutable max_n_runs: int;
  mutable mode: optim_mode;
  mutable bounds: (float * float) array;
  mutable init_sample: float array option;
  mutable verbose: bool;
  mutable vverbose: bool;
  meth: method_params;
}

module type OptimAlg =
sig
  val string_of_params : method_params -> string
  type input
  type output
  type optim_step_params
  val name : string

  val mk_step_params : unit -> optim_step_params

  (* history, best_result_yet = step step_params history old_result *)
  val step :
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
  type optim_step_params

  val mk_step_params : (input * output) -> (optim_step_params, input * output) step_params

  val string_of_params : params -> string
  val step : (input -> output) -> (optim_step_params, input * output) step_params -> bool
  val run : (input -> output) -> (input * output) list * (input * output)
  val falsify : (input -> output) -> (input * output) list * (input * output)
  val minimize : (input -> output) -> (input * output) list * (input * output)

  val get_rob_from_output : output -> float
end
