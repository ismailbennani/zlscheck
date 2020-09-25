module type S =
sig
  type params
  type output

  val name : string
  val dim : int
  val length : params -> float (* time after which output is constant *)
  val get_interp : params -> (float -> output array)
end

module Constant(Config : sig type t val dim : int end) =
struct
  type params = Config.t array
  type output = Config.t
  let name = "Constant"
  let dim = Config.dim
  let length _ = 0
  let get_interp t = fun _ -> t
end

module PiecewiseConstant(Config : sig type t val dim: int end) =
struct
  type params = {
    ctrl_points: Config.t array;
    step_length: float;
  }
  type output = Config.t

  let name = "PiecewiseConstant"
  let dim = Config.dim

  let length { step_length; ctrl_points } =
    step_length *. (float ((Array.length ctrl_points) / dim))

  let get_interp { step_length; ctrl_points } =
    fun t ->
      let index = truncate (t /. step_length) in
      let cp_n = Array.length ctrl_points in
      if index >= cp_n / dim then
        Array.sub ctrl_points (cp_n - dim - 1) dim
      else Array.sub ctrl_points (dim * index) dim
end

(* concat two scenarios in time *)
module Concat
    (Scenario1: S)
    (Scenario2: S with type output := Scenario1.output) =
struct
  type params = {
    params1: Scenario1.params;
    params2: Scenario2.params;
  }
  type output = Scenario1.output

  let name = Scenario1.name ^ "+" ^ Scenario2.name
  let dim = min Scenario1.dim Scenario2.dim

  let length { params1; params2 } =
    (Scenario1.length params1) +. (Scenario2.length params2)

  let get_interp { params1; params2 } =
    let interp1 = Scenario1.get_interp params1 in
    let interp2 = Scenario2.get_interp params2 in
    let length1 = Scenario1.length params1 in
    fun t ->
      if t > length1
      then interp1 t
      else interp2 (t -. length1)
end

(* concat two scenarios in space *)
module Cross
    (Scenario1: S)
    (Scenario2: S with type output := Scenario1.output) =
struct
  type params = {
    params1: Scenario1.params;
    params2: Scenario2.params;
  }
  type output = Scenario1.output

  let name = Scenario1.name ^ "." ^ Scenario2.name
  let dim = Scenario1.dim + Scenario2.dim

  let length { params1; params2 } =
    max (Scenario1.length params1) (Scenario2.length params2)

  let get_interp { params1; params2 } =
    let interp1 = Scenario1.get_interp params1 in
    let interp2 = Scenario2.get_interp params2 in
    fun t -> Array.append (interp1 t) (interp2 t)
end

module Cste(Config : sig type t val dim: int end) = Constant(Config)
module PC(Config : sig type t val dim: int end) = PiecewiseConstant(Config)

module CsteFadFloat = Cste(struct type t = FadFloat.t let dim = 1 end)

module PCFadFloat = PC(struct type t = FadFloat.t let dim = 1 end)
module PCFadFloat2 = PC(struct type t = FadFloat.t let dim = 2 end)
module PCFadFloat3 = PC(struct type t = FadFloat.t let dim = 3 end)
module PCFadFloat4 = PC(struct type t = FadFloat.t let dim = 4 end)
module PCFadFloat5 = PC(struct type t = FadFloat.t let dim = 5 end)
module PCFadFloat6 = PC(struct type t = FadFloat.t let dim = 6 end)
