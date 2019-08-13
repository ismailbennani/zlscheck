module type OfflineFormulaType =
sig
  (* type of the formula *)
  type t
  (* type of the trace *)
  type trace
  (* type of the result *)
  type result

  val eval : t -> trace -> result

  val print_t : Format.formatter -> t -> unit
  val print_trace : Format.formatter -> trace -> unit
  val print_result : Format.formatter -> result -> unit
end

module Check(FormulaType : OfflineFormulaType) =
struct
  let print_formula = FormulaType.print_t
  let print_trace = FormulaType.print_trace
  let print_result = FormulaType.print_result

  let eval = FormulaType.eval
end
