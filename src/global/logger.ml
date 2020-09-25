module type S =
sig
  type t
  type input

  val init : unit -> t
  val log : t -> input -> unit
  val finalize : t -> unit
end

module None(Ty: sig type t end) =
struct
  type t = unit
  type input = Ty.t
  let init () = ()
  let log () _ = ()
  let finalize () = ()
end

module LogToFile(Path: sig val path : string end) =
struct
  type t = out_channel
  type input = float * float array * float * float array

  let init () = open_out Path.path
  let log fd (t, inp, rob, grad) =
    let open Printer in
    Printf.fprintf fd "%g,%s,%g,%s\n"
      t (string_of_float_array "," inp) rob (string_of_float_array "," grad)
  let finalize fd = close_out fd
end
