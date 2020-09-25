open Ztypes

(* type of Online.Make(..) and Offline.Make(..), cf
   cf zlscheck/examples/arch20/common/offline.ml and online.ml *)
module type RunBench =
sig
  val name : string
  val bench_name : string
  val prop_name : string
  val print_optim_params : out_channel -> unit -> unit
  val run : unit -> float array Deftypes.one_repet_result
end
