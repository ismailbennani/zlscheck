(* This file defines a Falsification algorithm similar to that of S-Taliro. It applies the chosen 
   optimization algorithm (implemented in OptimAlg) on a score function that corresponds to the 
   robustness of a whole simulation of the model. *)

open Optim

(* for now, the function fn returns a float (a robustness)
   wip : falsify (and the other functions) should take a model and a
         specification and use them to compute the cost function to optimize
*)

module Make(OptimAlg : OptimAlg) =
struct
  type params = OptimAlg.alg_params Optim.params

  let max_n_runs = ref 1000
  let set_max_runs i = max_n_runs := i
  let get_max_runs () = !max_n_runs

  let bounds = ref [||]
  let set_bounds i = bounds := i
  let get_bounds () =
    if !bounds = [||] then begin
      Printf.eprintf "No bounds have been set\n"; assert false
    end else !bounds

  let init_sample = ref None
  let set_initial_sample i = init_sample := i
  let get_initial_sample () = !init_sample

  let set_optim_params p = OptimAlg.params := p
  let get_optim_params () = !OptimAlg.params

  let verbose = ref false
  let set_verbose b = verbose := b
  let get_verbose () = !verbose

  let mk_params mode = {
    max_n_runs = get_max_runs ();
    mode = mode;
    bounds = get_bounds ();
    init_sample = get_initial_sample ();
    verbose = get_verbose ();
    optim = get_optim_params ();
  }

  let falsify fn = let params = mk_params Falsify in OptimAlg.run params fn
  let minimize fn = let params = mk_params Minimize in OptimAlg.run params fn
  let maximize fn = let params = mk_params Maximize in OptimAlg.run params fn
end

module SATaliro = Make(SimulatedAnnealing)
module URTaliro = Make(UniformRandom)
