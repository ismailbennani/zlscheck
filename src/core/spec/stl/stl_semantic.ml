open Stl_syntax

module EnvMap = Map.Make(String)

let find_var env v = EnvMap.find v env
let f_of_bool b = Stl_predicate (Econst (if b then infinity else neg_infinity))
let shift_right t (i1, i2) = (i1 +. t), (i2 +. t)
let shift_left t (i1, i2) = (t -. i1), (t -. i2)

(*
  if before is false : returns the first index i in timed_env such that
                       the time of timed_env.(i) is after t
  if before is true : returns the last index i in timed_env such that
                      the time of timed_env.(i) is before t
*)
let time_index before timed_env t =
  let rec time_index_from i =
    if i >= Array.length timed_env then Array.length timed_env - 1
    else if t <= fst timed_env.(i) then if before then max (i-1) 0 else i
    else time_index_from (i+1)
  in time_index_from 0

let eval_unop op f =
  match op with
  | Neg -> -. f
  | Sin -> Stdlib.sin f
  | Cos -> Stdlib.cos f

let eval_binop op f1 f2 =
  match op with
  | Add -> f1 +. f2
  | Sub -> f1 -. f2
  | Mul -> f1 *. f2

(* evaluate an expression using the values in env *)
let rec eval_expr env = function
  | Econst f -> f
  | Evar v -> find_var env v
  | Eunop (op, f) -> eval_unop op (eval_expr env f)
  | Ebinop (op, f1, f2) -> eval_binop op (eval_expr env f1) (eval_expr env f2)

and eval_low_level f (timed_env : (float * float EnvMap.t) array) =
  let rec eval_timed (timed_env) f1 f2 interval i =
    (* NOTE : interval is the time interval where f2 should occure,
              it can be before the time corresponding to i (since)
              or after (until) *)

    (* until/since robustness :
         max   ( min ( eval f2 t' ,        max         ( eval f1 t'' ) ) )
       t' in I                     t'' between t and t'
    *)
    let start_time, end_time = interval in
    let start_i = time_index false timed_env start_time in
    let end_i = time_index true timed_env end_time in

    let res = ref None in
    for i' = start_i to end_i do
      let max_f1 = ref None in
      for i'' = i to i' do
        let eval_f1 = eval_aux f1 i'' in
        max_f1 :=
          match !max_f1 with
          | None -> Some eval_f1
          | Some f -> Some (max f eval_f1);
      done;
      let max_f1 = match !max_f1 with None -> assert false | Some f -> f in
      let min_f2_f1 = min (eval_aux f2 i') max_f1 in
      res :=
        match !res with
        | None -> Some min_f2_f1
        | Some f -> Some (max f min_f2_f1);
    done;
    match !res with
    | None -> assert false
    | Some f -> f

  and eval_aux f i =
    match f with
    | Stl_predicate e -> eval_expr (snd timed_env.(i)) e
    | Stl_not f' -> -. (eval_aux f' i)
    | Stl_and (f1, f2) -> min (eval_aux f1 i) (eval_aux f2 i)
    | Stl_or (f1, f2) -> max (eval_aux f1 i) (eval_aux f2 i)
    | Stl_until (f1, interval, f2) ->
      let t = fst timed_env.(i) in
      eval_timed timed_env f1 f2 (shift_right t interval) i
    | Stl_since (f1, interval, f2) ->
      let t = fst timed_env.(i) in
      eval_timed timed_env f1 f2 (shift_left t interval) i
  in eval_aux f 0

let eval f timed_env = eval_low_level (low_level_of_f f) timed_env
