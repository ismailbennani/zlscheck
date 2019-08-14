module Make(Type : sig type t end) =
  ExecPeriodic.Make(struct
    type values = Type.t
    type acc = (Ztypes.time * values) list

    let periodic_fun acc time (res : values) =
      match acc with
      | None -> Some [(time, res)]
      | Some acc -> Some ((time, res) :: acc)
  end)
