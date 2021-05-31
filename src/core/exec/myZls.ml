
open Ztypes
open Bigarray

module type Operator =
sig
  include Fadbad.OrderedOpS with type elt = float and type scalar = float

  val min_t : t
  val max_t : t
  val epsilon_t : t
  val infinity_t : t
  val neg_infinity_t : t

  val abs : t -> t

  val is_infinity : t -> bool
end

module OpFloat =
struct
  type t = float
  type elt = float
  type scalar = float

  let create () = 7895.

  let make x = x
  let get f = f
  let ( !! ) f = f

  let integer i = (float i)

  let to_string = string_of_float
  let string_of_scalar = string_of_float
  let string_of_elt = string_of_float

  let copy x = x
  let deepcopy x = x

  let zero () = 0.
  let one () = 1.
  let two () = 2.

  let scale x a = (a *. x)
  let translate x a = (x +. a)

  let ( ~+ ) = Stdlib.( ~+. )
  let ( ~- ) = Stdlib.( ~-. )

  let ( + ) = Stdlib.( +. )
  let ( += ) x y = assert false

  let ( - ) = Stdlib.( -. )
  let ( -= ) x y = assert false

  let ( * ) = Stdlib.( *. )
  let ( *= ) x y = assert false

  let ( / ) = Stdlib.( /. )
  let ( /= ) x y = assert false

  let ( ** ) = Stdlib.( ** )

  let inv x = Stdlib.((1. /. x))
  let sqr x = Stdlib.((x *. x))

  let sqrt = Stdlib.sqrt
  let log = Stdlib.log
  let exp = Stdlib.exp
  let sin = Stdlib.sin
  let cos = Stdlib.cos
  let tan = Stdlib.tan
  let asin = Stdlib.asin
  let acos = Stdlib.acos
  let atan = Stdlib.atan

  let ( = ) = Stdlib.( = )
  let ( <> ) = Stdlib.( <> )
  let ( < ) = Stdlib.( < )
  let ( <= ) = Stdlib.( <= )
  let ( > ) = Stdlib.( > )
  let ( >= ) = Stdlib.( >= )

  let max = Stdlib.max
  let min = Stdlib.min

  let min_t = Stdlib.min_float
  let max_t = Stdlib.max_float
  let epsilon_t = Stdlib.epsilon_float
  let infinity_t = Stdlib.infinity
  let neg_infinity_t = Stdlib.neg_infinity

  let abs = abs_float
  let is_infinity x = Float.is_infinite x && Stdlib.(x > 0.)
end

module OpFloatRef =
struct
  include Fadbad.OrderedFloat
  let min_t = ref min_float
  let max_t = ref max_float
  let epsilon_t = ref epsilon_float
  let infinity_t = ref infinity
  let neg_infinity_t = ref neg_infinity

  let abs f = ref (abs_float !f)
  let is_infinity f = Float.is_infinite !f && Stdlib.(!f > 0.)
end

module type ArrayTy =
sig
  type elt
  type carray
  type zarray

  val cmake : int -> carray
  val zmake : int -> zarray
  val length : carray -> int
  val get_c : carray -> int -> elt
  val set_c : carray -> int -> elt -> unit
  val blit_c : carray -> carray -> unit
  val get_z : zarray -> int -> int32
  val set_z : zarray -> int -> int32 -> unit
  val blit_z : zarray -> zarray -> unit
end

module CamlArray(Elt : sig type t val zero : t end) : ArrayTy =
struct
  type elt = Elt.t
  type carray = elt array
  type zarray = int32 array

  let cmake n = Array.init n (fun _ -> Elt.zero)
  let zmake n = Array.make n 0l
  let length = Array.length
  let get_c = Array.get
  let set_c = Array.set
  let blit_c a b = Array.blit a 0 b 0 (Array.length a)
  let get_z = Array.get
  let set_z = Array.set
  let blit_z a b = Array.blit a 0 b 0 (Array.length a)
end

module BigArray1(Elt :
                 sig
                   type t
                   type repr
                   type layout
                   val kind : (t, repr) Bigarray.kind
                   val layout : layout Bigarray.layout
                   val zero : t
                 end) : ArrayTy =
struct
  open Bigarray

  type elt = Elt.t
  type carray = (elt, Elt.repr, Elt.layout) Array1.t
  type zarray = (int32, int32_elt, Elt.layout) Array1.t

  let cmake n =
    let r = Array1.create Elt.kind Elt.layout n in
    Array1.fill r Elt.zero;
    r
  let zmake n =
    let r = Array1.create int32 Elt.layout n in
    Array1.fill r 0l;
    r
  let length = Array1.dim
  let get_c = Array1.get
  let set_c = Array1.set
  let blit_c = Array1.blit
  let get_z = Array1.get
  let set_z = Array1.set
  let blit_z = Array1.blit
end

module BigArrayZelus = BigArray1(struct
    type t = float
    type repr = Bigarray.float64_elt
    type layout = Bigarray.c_layout
    let kind = Bigarray.float64
    let layout = Bigarray.c_layout
    let zero = 0.0
  end)

module Make(Operator : Operator)(Array : ArrayTy) =
struct
  (* Interfaces functions from within Zelus *)

  type carray = Array.carray
  type zarray = Array.zarray

  let length = Array.length

  let get_zin v i = Array.get_z v i <> 0l
  (* fill zinvec with zeros *)
  let zzero zinvec length =
    for i = 0 to length - 1 do
      Array.set_z zinvec i 0l
    done

  type 's f_alloc = unit -> 's
  type 's f_maxsize = 's -> int * int
  type 's f_csize = 's -> int
  type 's f_zsize = 's -> int
  type ('s, 'o) f_step = 's -> carray -> carray -> zarray -> Operator.t -> 'o
  type 's f_ders = 's -> carray -> carray -> zarray -> carray -> Operator.t -> unit
  type 's f_zero = 's -> carray -> zarray -> carray -> Operator.t -> unit
  type 's f_reset = 's -> unit
  type 's f_horizon = 's -> Operator.t

  (* TODO: eliminate this ? *)
  (* Compare two floats for equality, see:
   * http://www.cygnus-software.com/papers/comparingfloats/comparingfloats.htm *)
  let time_eq f1 f2 =
    if Operator.(abs (f1 - f2) < Operator.min_t)
    then true (* absolute error check for numbers around to zero *)
    else
      let rel_error =
        if Operator.(abs f1 > abs f2)
        then Operator.(abs ((f1 - f2) / f1))
        else Operator.(abs ((f1 - f2) / f2))
      in
     Operator.(rel_error <= make 0.000001)
  (* Compare times with 99.9999% accuracy. *)

  let time_leq t1 t2 = Operator.(t1 < t2) || time_eq t1 t2
  let time_geq t1 t2 = Operator.(t1 > t2) || time_eq t1 t2

  module type ZELUS_SOLVER =
  sig (* {{{ *)
    (** Interface for compiled functions *)

    (** Configuring and calling the D-C solver *)

    (* Log simulation steps and continuous state values. *)
    val enable_logging       : unit -> unit

    (* The solver's minimum and maximum step sizes. *)
    val min_step_size : Operator.t option ref
    val max_step_size : Operator.t option ref

    (* The maximum simulation time. *)
    val max_sim_time  : Operator.t option ref
    val set_max_sim_time : Operator.t -> unit

    (* A factor relating simulation and wall clock times. *)
    val speedup       : Operator.t ref

    val step  :    's f_alloc
      -> 's f_csize
      -> 's f_zsize
      -> 's f_horizon
      -> 's f_maxsize
      -> 's f_ders
      -> ('s, 'o) f_step
      -> 's f_zero
      -> 's f_reset
      -> (unit -> 'o option * bool * Operator.t)

  end (* }}} *)

  module type STATE_SOLVER =
  sig

    (* A session with the solver. *)
    type t

    (* The type of vectors used internally by the solver. *)
    type nvec

    (* Create a vector of the given size. *)
    val cmake : int -> nvec

    (* Unwrap a vector returning an array of continuous-state values. *)
    val unvec : nvec -> carray

    (* A right-hand-side function called by the solver to calculate the
       instantaneous derivatives: [f t cvec dvec].
       - t, the current simulation time (input)
       - cvec, current values for continuous states (input)
       - dvec, the vector of instantaneous derivatives (output) *)
    type rhsfn = Operator.t -> carray -> carray -> unit

    (* An interpolation function: [df cvec t k]
       - cvec, a vector for storing the interpolated continuous states (output)
       - t, the time to interpolate at,
       - k, the derivative to interpolate *)
    type dkyfn = nvec -> Operator.t -> int -> unit

    (* [initialize f c] creates a solver session from a function [f] and
       an initial state vector [c]. *)
    val initialize : rhsfn -> nvec -> t

    (* [reinitialize s t c] reinitializes the solver with the given time
       [t] and vector of continuous states [c]. *)
    val reinitialize : t -> Operator.t -> nvec -> unit

    (* [t' = step s tl c] given a state vector [c], takes a step to the next
       'mesh-point', or the given time limit [tl] (whichever is sooner),
       updating [c]. *)
    val step : t -> Operator.t -> nvec -> Operator.t

    (* Returns an interpolation function that can produce results for any
       time [t] since the last mesh-point or the initial instant. *)
    val get_dky : t -> dkyfn

    (* generic solver parameters *)
    val set_stop_time  : t -> Operator.t -> unit
    val set_min_step   : t -> Operator.t -> unit
    val set_max_step   : t -> Operator.t -> unit
    val set_tolerances : t -> Operator.t -> Operator.t -> unit
  end

  module type ZEROC_SOLVER =
  sig
    (* A session with the solver. A zero-crossing solver has two internal
       continuous-state vectors, called 'before' and 'now'. *)
    type t

    (* Zero-crossing function: [g t cvec zout]
       - t, simulation time (input)
       - cvec, vector of continuous states (input)
       - zout, values of zero-crossing expressions (output) *)
    type zcfn  = Operator.t -> carray -> carray -> unit

    (* Create a session with the zero-crossing solver:
       [initialize nroots g cvec0]
       - nroots, number of zero-crossing expressions
       - g, function to calculate zero-crossing expressions
       - cvec0, initial continuous state

       Sets the 'now' vector to cvec0. *)
    val initialize   : int -> zcfn -> carray -> t

    (* The same but does not run [g] at initialization time *)
    val initialize_only   : int -> zcfn -> carray -> t

    (* Reinitialize the zero-crossing solver after a discrete step that
       updates the continuous states directly: [reinitialize s t cvec].
       - s, a session with the zero-crossing solver
       - t, the current simultation time
       - cvec, the current continuous state vector

       Resets the 'now' vector to cvec. *)
    val reinitialize : t -> Operator.t -> carray -> unit

    (* Advance the zero-crossing solver after a continuous step:
       [step s t cvec].
       - s, a session with the zero-crossing solver
       - t, the current simultation time
       - cvec, the current continuous state vector

       Moves the current 'now' vector to 'before', then sets 'now' to cvec. *)
    val step         : t -> Operator.t -> carray -> unit

    val takeoff      : t -> bool
    (* Returns true if one zero-crossing signal moves from 0 to v > 0 *)
    (* Compares the 'before' and 'now' vectors and returns true only if
       there exists an i, such that before[i] < 0 and now[i] >= 0. *)
    val has_roots    : t -> bool

    (* Locates the time of the zero-crossing closest to the 'before' vector.
       Call after [has_roots] indicates the existence of a zero-crossing:
       [t = find s (f, c) zin].
       - The [get_dky] function [f] is provided by the state solver and is
         expected to update the array [c] with the interpolated state.
       - zin, is populated with the status of all zero-crossings
       - the returned values is the simulation time of the earliest
         zero-crossing that was found. *)
    val find         : t -> ((Operator.t -> int -> unit) * carray) -> zarray -> Operator.t
  end

  module type RUNTIME =
  sig
    val go : unit hsimu -> unit
    val check : bool hsimu -> int -> unit
  end

  module type DISCRETE_RUNTIME =
  sig
    val go : Operator.t -> (unit -> unit) -> unit
  end
end

module Vanilla = Make(OpFloat)(BigArrayZelus)
