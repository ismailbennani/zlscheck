module type OrderedFS =
sig
  include Fadbad.OrderedOpS
  val diff: t -> int -> int -> unit
  val d: t -> int -> elt
  val length: t -> int
end

module type DiffF =
sig
  include OrderedFS with type elt = float

  val run_diff : (t array -> t) -> float array -> float * float array
end

module FADLike (OpFAD : OrderedFS with type elt = float) =
struct
  include OpFAD
  let run_diff fn (inputs : float array) : float * float array =
    let n_inputs = Array.length inputs in
    let inputs = Array.map OpFAD.make inputs in
    Array.iteri (fun i n -> OpFAD.diff n i n_inputs) inputs;
    let res = fn inputs in
    let grad = Array.init n_inputs (fun i -> OpFAD.d res i) in
    OpFAD.(!!res), grad
end
