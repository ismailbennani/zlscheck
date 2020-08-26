open Ztypes

(* describes one benchmark *)
module type Bench =
sig
  val name : string
  val max_n : int
  val node : (MyOp.t array, MyOp.t * bool) cnode
  val set_optim_params : unit -> unit
end
