module type OnlineFormulaType =
sig
  (* type of the formula *)
  type t
  (* type of one instant *)
  type instant
  (* type of the result *)
  type result

  type timed_instant = Ztypes.time * instant

  (* (updated_formula, current_result) = step formula (time, instant) *)
  val step : t -> timed_instant -> t * result

  val print_t : Format.formatter -> t -> unit
  val print_instant : Format.formatter -> instant -> unit
  val print_result : Format.formatter -> result -> unit
end

module Monitor(FormulaType : OnlineFormulaType) =
struct
  let formula : FormulaType.t option ref = ref None

  let set_formula f = formula := Some f
  let get_formula () : FormulaType.t =
    match !formula with
    | None -> Printf.eprintf "No formula has been specified yet\n"; exit 1
    | Some f -> f

  let step timed_instant =
    let new_formula, res = FormulaType.step (get_formula ()) timed_instant in
    set_formula new_formula;
    res

  let print_formula ff () = FormulaType.print_t ff (get_formula ())
end
