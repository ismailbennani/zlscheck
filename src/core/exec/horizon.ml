open Ztypes

module HorizonFun(Type : sig type t end) =
struct
  type values = Type.t
  type acc = values

  let periodic_fun _ _ (res : values) = Some res
end

module Hybrid =
struct
  (* module CustomSolver(Op : MyZls.Operator)(SSolver : MyZls.Make(Op).STATE_SOLVER) =
  struct
    type values = Op.elt
    include ExecPeriodic.Make(HorizonFun(struct type t = values end))(SSolver)
    let run model =
      let model = model in
      match sample (Sim.build_sim model) with
      | None -> failwith "The model didn't return any value"
      | Some res -> res
  end *)

  (* Solver that uses floating point arithmetic to compute its solution *)
  module FloatSolver(SSolver : Zls.STATE_SOLVER) =
    struct
      type values = float
      include ExecPeriodic.Make(HorizonFun(struct type t = values end))(SSolver)
      let run model =
        match sample (Sim.build_sim model) with
        | None -> failwith "The model didn't return any value"
        | Some res -> res
    end
end

module Discrete(Type : sig type t end) =
struct
  type values = Type.t
  let max_steps = ref (-1)
  let set_max_steps i = max_steps := i
  let get_max_steps () = !max_steps

  let sample (Node { alloc; step; reset }) =
    let rec aux mem n_step =
      let res = step mem () in
      if n_step <= 0 then res
      else aux mem (n_step - 1)
    in

    let mem = alloc () in
    reset mem;
    aux mem (get_max_steps ())

  let run model = sample model
end
