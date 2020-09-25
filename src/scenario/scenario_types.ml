module type S =
sig
  type params
  type output

  val interp : params -> float -> output
end
