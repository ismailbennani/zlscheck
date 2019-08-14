module type Step =
sig
  type params
  type sample
  type value

  val step :
    params ->
    (* cost function *)
    (sample -> value) ->
    (* last state *)
    (sample * value) ->
    (* new selected state *)
    (sample * value)
end

type optim_mode = Falsify | Minimize | Maximize

type 'a params = {
  max_n_runs : int;
  mode : optim_mode;
  bounds : (float * float) array;
  init_sample : float array option;
  optim : 'a;
}

type 'a step_params = {
  mutable n_runs : int;
  optim_step : 'a;
}

let run_optim
    (optim_step :
       'a params -> 'b -> ('c -> float) -> ('c * float) list -> 'c * float ->
     ('c * float) list * ('c * float)
    )
    (mk_step_params : 'a params -> 'b)
    (params : 'a params)
    (fn : 'c -> float) =

  let rec aux step_params history (old_sample, old_val) =
    if step_params.n_runs >= params.max_n_runs then
      history, (old_sample, old_val)
    else if params.mode = Falsify && old_val < 0. then begin
      Printf.eprintf "Already found a falsifying input\n";
      history, (old_sample, old_val)
    end else
      let history, current_point =
        optim_step params step_params fn history (old_sample, old_val) in

      aux step_params history current_point
  in

  let step_params = mk_step_params params in

  let first_sample =
    match params.init_sample with
    | None -> Utils.ur_sample params.bounds
    | Some sample ->
      if not (Utils.in_bounds sample params.bounds) then begin
        Printf.eprintf "Given initial sample is not in bounds\n";
        assert false
      end; sample
  in
  let first_value = fn first_sample in

  let init_point = (first_sample, first_value) in

  aux step_params [init_point] init_point
