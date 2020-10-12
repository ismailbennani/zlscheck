module type S =
sig
  type t
  type params
  type input

  val init : params -> t
  val log : t -> input -> unit
  val finalize : t -> unit
end

module None(Ty: sig type t end) =
struct
  type t = unit
  type params = unit
  type input = Ty.t

  let init () = ()
  let log () _ = ()
  let finalize () = ()
end

module LogToFile =
struct
  type t = out_channel
  type params = string
  type input = float * float array * float array * float

  let init path = open_out path
  let log fd (t, inp, out, rob) =
    let open Printer in
    Printf.fprintf fd "%g,%s,%s,%g\n"
      t (string_of_float_array "," inp) (string_of_float_array "," out) rob
  let finalize fd = close_out fd
end
