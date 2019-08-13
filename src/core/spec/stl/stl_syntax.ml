(* TYPES *)

type variable = string
type value = float
type interval = float * float
type strict = bool

type unop  = Neg | Sin | Cos
type binop = Add | Sub | Mul

type e =
  | Econst of value
  | Evar of variable
  | Eunop of unop * e
  | Ebinop of binop * e * e

type low_level =
  (* E > 0 *)
  | Stl_predicate of e
  (* usual operators *)
  | Stl_not of low_level
  | Stl_and of low_level * low_level
  | Stl_or of low_level * low_level
  (* timed operators *)
  | Stl_until of low_level * interval * low_level
  | Stl_since of low_level * interval * low_level

type f =
  (* E > 0 *)
  | Predicate of e
  (* usual operators *)
  | Not of f
  | And of f * f
  | Or of f * f
  (* timed operators *)
  | Until of f * interval * f
  | Since of f * interval * f
  (* future derived operators *)
  | Falways of interval * f | Feventually of interval * f
  (* past derived operators *)
  | Palways of interval * f | Peventually of interval * f

(* *)
let rec f_of_low_level = function
  | Stl_predicate e -> Predicate e
  | Stl_not f -> Not (f_of_low_level f)
  | Stl_and (f1,f2) -> And (f_of_low_level f1, f_of_low_level f2)
  | Stl_or (f1,f2) -> Or (f_of_low_level f1, f_of_low_level f2)
  | Stl_until (f1,i,f2) -> Until (f_of_low_level f1, i, f_of_low_level f2)
  | Stl_since (f1,i,f2) -> Since (f_of_low_level f1, i, f_of_low_level f2)

let rec low_level_of_f = function
  | Predicate e -> Stl_predicate e
  | Not f -> Stl_not (low_level_of_f f)
  | And (f1, f2) -> Stl_and (low_level_of_f f1, low_level_of_f f2)
  | Or (f1, f2) -> Stl_or (low_level_of_f f1, low_level_of_f f2)
  | Until (f1, i, f2) -> Stl_until (low_level_of_f f1, i, low_level_of_f f2)
  | Since (f1, i, f2) -> Stl_until (low_level_of_f f1, i, low_level_of_f f2)
  | Falways (i, f) -> low_level_of_f (Not (Feventually (i, Not f)))
  | Feventually (i, f) -> Stl_until (Stl_predicate (Econst infinity), i, low_level_of_f f)
  | Palways (i, f) -> low_level_of_f (Not (Peventually (i, Not f)))
  | Peventually (i, f) -> Stl_since (Stl_predicate (Econst infinity), i, low_level_of_f f)

(* PRINT UTILS *)

let print_value ff = Format.fprintf ff "%f"
let print_var ff = Format.fprintf ff "%s"
let print_interval ff (f1, f2) = Format.fprintf ff "[%f; %f]" f1 f2
let print_unop ff op =
  Format.fprintf ff "%s" (
    match op with
    | Neg -> "-" | Sin -> "sin" | Cos -> "cos"
  )
let print_binop ff op =
  Format.fprintf ff "%s" (
    match op with
    | Add -> "+" | Sub -> "-" | Mul -> "*"
  )

let rec print_expr ff = function
  | Econst v -> Format.fprintf ff "%a" print_value v
  | Evar v -> Format.fprintf ff "%a" print_var v
  | Eunop (op, e) -> Format.fprintf ff "%a %a" print_unop op print_expr e
  | Ebinop (op, e1, e2) ->
    Format.fprintf ff "(%a %a %a)" print_expr e1 print_binop op print_expr e2

let rec print ff = function
  | Predicate e -> Format.fprintf ff "(%a > 0)" print_expr e
  | Not f -> Format.fprintf ff "NOT %a" print f
  | And (f1, f2) ->
    Format.fprintf ff "(%a AND %a)" print f1 print f2
  | Or (f1, f2) ->
    Format.fprintf ff "(%a OR %a)" print f1 print f2
  | Until (f1, i, f2) ->
    Format.fprintf ff "(%a UNTIL%a %a)"
      print f1 print_interval i print f2
  | Since (f1, i, f2) ->
    Format.fprintf ff "(%a SINCE%a %a)"
      print f1 print_interval i print f2
  | Falways (i, f) ->
    Format.fprintf ff "ALWAYS%a %a"
      print_interval i print f
  | Feventually (i, f) ->
    Format.fprintf ff "EVENTUALLY%a %a"
      print_interval i print f
  | Palways (i, f) ->
    Format.fprintf ff "PAST_ALWAYS%a %a"
      print_interval i print f
  | Peventually (i, f) ->
    Format.fprintf ff "PAST_EVENTUALLY%a %a"
      print_interval i print f

let print_low_level ff f = print ff (f_of_low_level f)

(* MACROS *)

let top = Econst infinity
let bot = Econst neg_infinity
let var v = Evar v
let const f = Econst f
let neg e = Eunop (Neg, e)
let sin e = Eunop (Sin, e)
let cos e = Eunop (Cos, e)
let add e1 e2 = Ebinop (Add, e1, e2)
let sub e1 e2 = Ebinop (Sub, e1, e2)
let mul e1 e2 = Ebinop (Mul, e1, e2)


let gt e f = Predicate (Ebinop (Sub, e, Econst f))
let lt e f = Predicate (Ebinop (Sub, Econst f, e))
let gt_zero e = Predicate e
let lt_zero e = Predicate (Eunop (Neg, e))
let not f = Not f
let conj f1 f2 = And (f1, f2)
let disj f1 f2 = Or (f1, f2)
let until f1 i f2 = Until(f1, i, f2)
let since f1 i f2 = Since(f1, i, f2)
let fev i f = Feventually (i, f)
let falw i f = Falways (i, f)
let pev i f = Peventually (i, f)
let palw i f = Palways (i, f)
