module RS = Random.State

module type ModelInput =
sig
  type t

  val random : unit -> t
  val neighbor : t -> float -> t
end

module PiecewiseConstant(inp_typ : InputType) : ModelInput =
struct
  type t = (float * inp_typ.t) list

  let random max_size =
    List.init (Random.int max_size) (fun _ -> inp_typ.random ())

  let neighbor signal dist =
    List.map (fun (dur, val) -> dur, inp_typ.neighbor val dist) signal
end
