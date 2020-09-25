module type S =
sig
  type params
  type output

  val name : string
  val dim : int
  val length : params -> float (* time after which output is constant *)
  val get_interp : params -> (float -> output array)
end
