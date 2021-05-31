include Zls

(* Interfaces functions from within Zelus *)

let set = Array.set
let get = Array.get 

module type STATE_SOLVER_SENS =
sig
  include STATE_SOLVER

  (* type of sensitivity matrix used internally by the solver *)
  type sensmat

  val smake : int -> int -> sensmat
  val sget : sensmat -> int -> int -> float
  val sset : sensmat -> int -> int -> float -> unit
  val sdim : sensmat -> int * int 
  val arrays_of_sensmat : sensmat -> float array array

  (* A parametrized right-hand-side function called by the solver to calculate the
     instantaneous derivatives: [f params t cvec dvec].
     - params, current values of parameters (constant inputs)
     - t, the current simulation time (input)
     - cvec, current values for continuous states (input)
     - dvec, the vector of instantaneous derivatives (output) *)
  type rhsfn = carray -> float -> carray -> carray -> unit

  (* An interpolation function: [ds sensmat t k]
     - sensmat, a vector for storing the interpolated sensitivities
     - t, the time to interpolate at,
     - k, the derivative to interpolate *)
  type dkysensfn = sensmat -> float -> int -> unit

  (* [initialize f params c uS] creates a solver session from a function [f params],
     an initial state vector [c] and an initial sensitivity matrix [uS]. *)
  val initialize : rhsfn -> carray -> nvec -> sensmat -> t

  (* [reinitialize s t c uS] reinitializes the solver with the given time
     [t], vector of continuous states [c] and sensitivity matrix [uS]. *)
  val reinitialize : t -> float -> nvec -> sensmat -> unit

  (* Returns an interpolation function that can produce sensitivities for any
     time [t] since the last mesh-point or the initial instant. *)
  val get_sens_dky : t -> dkysensfn
end