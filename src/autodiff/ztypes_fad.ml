include Ztypes
open Bigarray

(* This module redefines some types in Ztypes so that they carry 
   FadFloat.t values instead of floats *)

type time = float
type cvec = FadFloat.t array
type dvec = FadFloat.t array
type zinvec = (int32, int32_elt,   c_layout) Array1.t
type zoutvec = FadFloat.t array

(* The interface with the ODE solver *)
type cstate =
  { mutable dvec : dvec; (* the vector of derivatives *)
    mutable cvec : cvec; (* the vector of positions *)
    mutable zinvec : zinvec; (* the vector of boolean; true when the
                                solver has detected a zero-crossing *)
    mutable zoutvec : zoutvec; (* the corresponding vector that define
                                  zero-crossings *)
    mutable cindex : int; (* the position in the vector of positions *)
    mutable zindex : int; (* the position in the vector of zero-crossings *)
    mutable cend : int; (* the end of the vector of positions *)
    mutable zend : int; (* the end of the zero-crossing vector *)
    mutable cmax : int; (* the maximum size of the vector of positions *)
    mutable zmax : int; (* the maximum number of zero-crossings *)
    mutable horizon : time; (* the next horizon *)
    mutable major : bool; (* integration iff [major = false] *)
  }


(* a function with type 'a -C-> 'b, when given to a solver, is *)
(* represented by an OCaml value of type ('a, 'b) hsnode *)
type ('a, 'b) hsnode =
  Hnode:
    { state : 's;
      (* the discrete state *)
      zsize : int;
      (* the maximum size of the zero-crossing vector *)
      csize : int;
      (* the maximum size of the continuous state vector (positions) *)
      derivative : 's -> FadFloat.t array -> time -> cvec -> dvec -> unit;
      (* computes the derivative *)
      crossing : 's -> 'a -> time -> cvec -> zoutvec -> unit;
      (* computes the derivative *)
      output : 's -> 'a -> cvec -> 'b;
      (* computes the zero-crossings *)
      setroots : 's -> 'a -> cvec -> zinvec -> unit;
      (* returns the zero-crossings *)
      majorstep : 's -> time -> cvec -> FadFloat.t array -> FadFloat.t array;
      (* computes a step *)
      reset : 's -> unit;
      (* resets the state *)
      horizon : 's -> time;
      (* gives the next time horizon *)
    } -> ('a, 'b) hsnode
