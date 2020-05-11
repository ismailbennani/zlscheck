module Hybrid(Type : sig type t end) =
  ExecPeriodic.Make(struct
    type values = Type.t
    type acc = (Ztypes.time * values) list

    let periodic_fun acc time (res : values) =
      match acc with
      | None -> Some [(time, res)]
      | Some acc -> Some (acc @ [(time, res)])
  end)

open Ztypes

module Discrete(Type : sig type t end) =
struct
  let max_steps = ref (-1)
  let set_max_steps i = max_steps := i
  let get_max_steps () = !max_steps

  let sample (Node { alloc; step; reset }) =
    let rec aux acc mem n_step =
      if n_step <= 0 then List.rev acc
      else
        let res = step mem () in
        aux (res :: acc) mem (n_step - 1)
    in

    let mem = alloc () in
    reset mem;
    aux [] mem (get_max_steps ())
end
