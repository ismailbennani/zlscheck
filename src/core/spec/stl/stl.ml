module Syntax = Stl_syntax
module Semantic = Stl_semantic

type t = Syntax.f
type trace = (float * float Semantic.EnvMap.t) array
type result = float

let eval = Semantic.eval

let print_t = Syntax.print
let print_low_level = Syntax.print_low_level
let print_trace ff t =

  let print_envmap ff envmap =
    Format.fprintf ff "@[<v>{@;@[<h>@ @ @[<v>%a@]@]@;}@]@;"
      (fun ff map ->
         let str_list =
           Semantic.EnvMap.fold
             (fun key value res ->
                (Format.sprintf "@[<h>%s: %.2e;@]" key value) :: res)
             map []
         in match str_list with
         | [] -> ()
         | x :: q -> Format.fprintf ff "%s" x;
           List.iter (Format.fprintf ff "@,%s") q
      )
      envmap
  in

  Format.fprintf ff "@[<v>[|@;@[<h>@ @ @[<v>%a@]@]@;|]@]@;"
    (fun ff a ->
       Array.iter
         (fun (t, map) ->
            Format.fprintf ff "@[<h>At t=%.2e:@ %a@]@;"
              t print_envmap map)
       a)
    t
let print_result ff r = Format.fprintf ff "%.2f" r

(* future_reach if the time in the future from which values won't affect
   the specification's satisfaction *)
let rec future_reach_low_level = function
  | Syntax.Stl_predicate _ -> 0.
  | Syntax.Stl_not f -> future_reach_low_level f
  | Syntax.Stl_and (f1, f2)
  | Syntax.Stl_or (f1, f2) ->
    max (future_reach_low_level f1) (future_reach_low_level f2)
  | Syntax.Stl_since (f1, (lower, _), f2) ->
    let fr1 = future_reach_low_level f1 in
    let fr2 = future_reach_low_level f2 in
    max fr1 (fr2 -. lower)
  | Syntax.Stl_until (f1, (_, upper), f2) ->
    let fr1 = future_reach_low_level f1 in
    let fr2 = future_reach_low_level f2 in
    upper +. max fr1 fr2
let future_reach f = future_reach_low_level (Syntax.low_level_of_f f)

let rec past_reach_low_level = function
  | Syntax.Stl_predicate _ -> 0.
  | Syntax.Stl_not f -> past_reach_low_level f
  | Syntax.Stl_and (f1, f2)
  | Syntax.Stl_or (f1, f2) ->
    max (past_reach_low_level f1) (past_reach_low_level f2)
  | Syntax.Stl_since (f1, (_, upper), f2) ->
    let fr1 = past_reach_low_level f1 in
    let fr2 = past_reach_low_level f2 in
    upper +. max fr1 fr2
  | Syntax.Stl_until (f1, (lower, _), f2) ->
    let fr1 = past_reach_low_level f1 in
    let fr2 = past_reach_low_level f2 in
    max fr1 (fr2 -. lower)
let past_reach f = past_reach_low_level (Syntax.low_level_of_f f)

let rec precision_low_level = function
  | Syntax.Stl_predicate _ -> infinity
  | Syntax.Stl_not f -> precision_low_level f
  | Syntax.Stl_and (f1, f2)
  | Syntax.Stl_or (f1, f2) ->
    min (precision_low_level f1) (precision_low_level f2)
  | Syntax.Stl_since (f1, (lower, upper), f2)
  | Syntax.Stl_until (f1, (lower, upper), f2) ->
    let fr1 = precision_low_level f1 in
    let fr2 = precision_low_level f2 in
    min (min fr1 fr2) (upper -. lower)
let precision f = precision_low_level (Syntax.low_level_of_f f)
