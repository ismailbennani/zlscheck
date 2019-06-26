(* PRINTER *)

module type Printer = sig
  type t
  val fprint : out_channel -> t -> unit
  val sprint: t -> string
end

module IntPrinter = struct
  type t = int
  let fprint ff i = Printf.fprintf ff "%i" i
  let sprint = string_of_int
end
module FloatPrinter = struct
  type t = float
  let fprint ff f = Printf.fprintf ff "%f" f
  let sprint = string_of_float
end
module StringPrinter = struct
  type t = string
  let fprint ff s = Printf.fprintf ff "%s" s
  let sprint s = s
end

module OptionPrinter(Printer : Printer) = struct
  type t = Printer.t option
  let fprint ff o =
    match o with
    | None -> Printf.fprintf ff "None"
    | Some v -> Printf.fprintf ff "%a" Printer.fprint v
  let sprint o = match o with | None -> "None" | Some v -> Printer.sprint v
end
module TuplePrinter(Printer1 : Printer)(Printer2 : Printer) = struct
  type t = Printer1.t * Printer2.t
  let fprint ff (v1, v2) =
    Printf.fprintf ff "%a, %a" Printer1.fprint v1 Printer2.fprint v2
  let sprint (v1, v2) =
    (Printer1.sprint v1) ^ ", " ^ (Printer2.sprint v2)
end
module ListPrinter(Printer : Printer) = struct
  type t = Printer.t list
  let fprint ff l =
    Printf.fprintf ff "[%s]" (String.concat "; " (List.map Printer.sprint l))
  let sprint l =
    "[" ^ (String.concat "; " (List.map Printer.sprint l)) ^ "]"
end

(* DUMPER *)

module type Dumper = sig
  type t
  val dump : float -> t -> unit
end

module List(Typ : sig type t end) = struct
  type t = Typ.t
  let l_v : (float * t) list ref = ref []
  let get () = !l_v
  let reset () = l_v := []
  let dump t v = l_v := (t, v) :: !l_v
end
module Stdout(Printer : Printer) = struct
  type t = Printer.t
  let dump t (v : Printer.t) = Printf.printf "%e\t%a\n" t Printer.fprint v
end
module File(Printer : Printer) = struct
  type t = Printer.t
  let filepath = ref ""
  let fd = ref None

  let close_file () =
    begin match !fd with
      | None -> ()
      | Some fd -> close_out fd
    end
  let open_file () =
    close_file ();
    if !filepath <> "" then fd := Some (open_out !filepath)

  let set_file fpath =
    close_file ();
    filepath := fpath;
    open_file ()

  let dump t (v : Printer.t) =
    match !fd with
    | None -> Printf.eprintf "No filepath has been set\n"; assert false
    | Some fd -> Printf.fprintf fd "%e\t%a\n" t Printer.fprint v
end

module IntStdout = Stdout(IntPrinter)
module FloatStdout = Stdout(FloatPrinter)
module StringStdout = Stdout(StringPrinter)
module OptionStdout(Printer : Printer) = Stdout(OptionPrinter(Printer))
module TupleStdout(Printer1 : Printer)(Printer2 : Printer) =
  Stdout(TuplePrinter(Printer1)(Printer2))
module ListStdout(Printer : Printer) = Stdout(ListPrinter(Printer))

module IntFile = File(IntPrinter)
module FloatFile = File(FloatPrinter)
module StringFile = File(StringPrinter)
module OptionFile(Printer : Printer) = File(OptionPrinter(Printer))
module TupleFile(Printer1 : Printer)(Printer2 : Printer) =
  File(TuplePrinter(Printer1)(Printer2))
module ListFile(Printer : Printer) = File(ListPrinter(Printer))
