open Ztypes

type 'a result = {
  optim: string;
  n_runs: int;
  samples: 'a array;
  robs: float array;
  best_sample: 'a;
  best_rob: float;
  falsified: bool;
  elapsed_time: float (* seconds *)
}

let print_result print_sample { optim; n_runs; best_sample; best_rob;
                                falsified; elapsed_time } =
  Printf.printf "Result %s (%d runs): %sFALSIFIED after %g seconds\n"
    optim n_runs (if falsified then "" else "NOT ") elapsed_time;
  Printf.printf "\tbest_sample: %a with rob %g\n"
    print_sample best_sample best_rob

module type Bench =
sig
  module Optim : Optim.S with type input := float array and type output := float * float array

  val name : string
  val max_t : float

  val node : (MyOp.t array, float * MyOp.t) node

  val set_optim_params: unit -> unit
  (* take k parameters and output a function from time to num_signals values *)
  val interp_fn : MyOp.t array -> float -> MyOp.t array
end

module type S =
sig
  module Optim : Optim.S with type input := float array and type output := float * float array
  val name : string
  val run : unit -> float array result
end

let print_grads ff x =
  Printf.fprintf ff "[%s]" (String.concat "; "
                              (List.init (MyOp.length x)
                                 (fun i -> Printf.sprintf "%g" (MyOp.d x i))))
