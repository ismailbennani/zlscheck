module type PropertyOutput =
sig
  type t

  (* CONSTANTS *)

  val top    : t
  val bottom : t

  (* CONSTRUCTORS *)

  val good : float -> t
  val bad  : float -> t

  val lt : float -> float -> t
  val le : float -> float -> t
  val gt : float -> float -> t
  val ge : float -> float -> t
  val eq : float -> float -> t

  (* DESTRUCTORS *)

  val howTrue : t -> float
  val isTrue  : t -> bool

  (* OPERATORS *)

  val neg : t -> t
  val and : t -> t -> t
end

(* DEFAULT OUTPUT TYPES *)

(* as defined by Fainekos and Donzé, the output of a property is a float *)
module ClassicRobustness : PropertyOutput =
struct
  type t = float

  let top = infinity
  let bottom = neg_infinity

  let good f = f
  let bad f = -. f

  let gt f1 f2 = f1 -. f2
  let ge f1 f2 = f1 -. f2
  let lt f1 f2 = f2 -. f1
  let le f1 f2 = f2 -. f1

  let howTrue f = f
  let isTrue f = f >= 0.

  let neg f = -. f
  let and f1 f2 = min f1 f2
end

module type Vbool_combinators =
sig
  val combine_true  : float -> float -> float
  val combine_false : float -> float -> float
end

module Max_combinators : Vbool_combinators =
struct
  let combine_true f1 f2 = max f1 f2
  let combine_false f1 f2 = min f1 f2
end

(* as defined in Koen Claessen's paper
    Using Valued Booleans to Find Simpler Counterexamples in Random Testing of
      Cyber-Physical Systems
*)
module Plus_combinators : Vbool_combinators =
struct
  (* robustness of a conjunction of two true values *)
  let combine_true  (v1, v2) = 1. /. (1./.v1 +. 1./.v2)
  (* robustness of a conjunction of two false values *)
  let combine_false (v1, v2) = v1 +. v2
end

(* as defined in Koen Claessen's paper
    Using Valued Booleans to Find Simpler Counterexamples in Random Testing of
      Cyber-Physical Systems
   the output is a boolean and a float
   the combinators are functions to decide what the robustness of a
   conjunction is depending on the robustness of each term *)
module Vbool(Combinators : Vbool_combinators) : PropertyOutput =
struct
  type t = (bool * float)

  let top = (true, infinity)
  let bottom = (false, neg_infinity)

  let good f = (true, f)
  let bad f = (false, f)

  let howTrue (b, f) = if b then (1. +. f) else (-1. -. f)

  let isTrue(b, _) = b
  let isFalse(b, _) = not b
  let rob (_, f) = f

  (* constructors *)

  let lt (x,y) = if x <  y then (true, y -. x) else (false, x -. y)
  let le (x,y) = if x <= y then (true, y -. x) else (false, x -. y)
  let gt (x,y) = if x >  y then (true, x -. y) else (false, y -. x)
  let ge (x,y) = if x >= y then (true, x -. y) else (false, y -. x)
  let eq (x,y) = (x=y, 0.)

  (* operators *)

  let neg (b,v) = (not b, v)
  let and (b1, v1) (b2, v2) =
        match b1, b2 with
        | false, false -> (false, Combinators.combine_false(v1, v2))
        | false, true  -> (false, v1)
        | true, false  -> (false, v2)
        | true, true   -> (true, Combinators.combine_true(v1, v2))
end

module Max_vbool = Vbool(Max_combinators)
module Plus_vbool = Vbool(Plus_combinators)
