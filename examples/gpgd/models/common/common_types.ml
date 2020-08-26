open Ztypes

(* describes a replay node *)
module type Replay =
sig
  val name : string
  val max_t : float
  val replay_node : (float array * MyOp.t array array, unit) node
  val scan_dump_inp : Scanf.Scanning.in_channel -> MyOp.t array
  (* val print_dump_inp : out_channel -> MyOp.t array -> unit *)
end

(* describes one benchmark *)
module type Bench =
sig
  module Optim : Optim.S with type input := float array and type output := float * float array

  val name : string
  val prop_name : string
  val max_t : float
  val sample_every : int (* used by online optim *)

  val prop_name_in_matlab : string
  val model_name_in_matlab : string
  val folder_name_in_shared : string

  val dump_path : string
  val shared_path : string

  val node : (MyOp.t array, float * MyOp.t array * MyOp.t) node

  val set_optim_params: unit -> unit
  (* take k parameters and output a function from time to num_signals values *)
  val interp_fn : MyOp.t array -> float -> MyOp.t array
end
