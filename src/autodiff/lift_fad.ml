 open Ztypes_fad
 open Bigarray

let zmake n =
  let r = Array1.create int32 c_layout n in
  Array1.fill r 0l;
  r


(* convert the internal representation of a hybrid node into *)
(* one that provide the elementary function for the simulation with *)
(* an ODE/Zero-crossing solver *)
let lift f =
  let cstate =
    { cvec = Array.init 0 (fun _ -> FadFloat.create ()); 
      dvec = Array.init 0 (fun _ -> FadFloat.create ()); 
      cindex = 0; zindex = 0;
      cend = 0; zend = 0; cmax = 0; zmax = 0;
      zinvec = zmake 0; zoutvec = Array.init 0 (fun _ -> FadFloat.create ()); 
      major = false; horizon = max_float } in

  let (Node { alloc = f_alloc; step = f_step; reset = f_reset }) : (time * FadFloat.t array, FadFloat.t array) Ztypes.node = f cstate in
  let s = f_alloc () in

  let n_zeros = cstate.zmax in
  let n_cstates = cstate.cmax in

  let no_roots_in = zmake n_zeros in
  let no_roots_out = Array.init n_zeros (fun _ -> FadFloat.create ()) in
  let ignore_der = Array.init n_cstates (fun _ -> FadFloat.create ()) in

  let no_time = -1.0 in

  (* the function that compute the derivatives *)
  let derivative s input time cvec dvec =
    cstate.major <- false;
    cstate.zinvec <- no_roots_in;
    cstate.zoutvec <- no_roots_out;
    cstate.cvec <- cvec;
    cstate.dvec <- dvec;
    cstate.cindex <- 0;
    cstate.zindex <- 0;
    ignore (f_step s (no_time, input)) in

  (* the function that compute the zero-crossings *)
  let crossing s input time cvec zoutvec =
    cstate.major <- false;
    cstate.zinvec <- no_roots_in;
    cstate.dvec <- ignore_der;
    cstate.zoutvec <- zoutvec;
    cstate.cvec <- cvec;
    cstate.cindex <- 0;
    cstate.zindex <- 0;
    ignore (f_step s (no_time, input)) in

  (* the function which compute the output during integration *)
  let output s input cvec =
    cstate.major <- false;
    cstate.zoutvec <- no_roots_out;
    cstate.dvec <- ignore_der;
    cstate.zinvec <- no_roots_in;
    cstate.cvec <- cvec;
    cstate.cindex <- 0;
    cstate.zindex <- 0;
    f_step s (no_time, input) in

  (* the function which sets the zinvector into the *)
  (* internal zero-crossing variables *)
  let setroots s input cvec zinvec =
    cstate.major <- false;
    cstate.zoutvec <- no_roots_out;
    cstate.dvec <- ignore_der;
    cstate.zinvec <- zinvec;
    cstate.cvec <- cvec;
    cstate.cindex <- 0;
    cstate.zindex <- 0;
    ignore (f_step s (no_time, input)) in

  (* the function which compute a discrete step *)
  let majorstep s time cvec input =
    cstate.major <- true;
    cstate.horizon <- infinity;
    cstate.zinvec <- no_roots_in;
    cstate.zoutvec <- no_roots_out;
    cstate.dvec <- ignore_der;
    cstate.cvec <- cvec;
    cstate.cindex <- 0;
    cstate.zindex <- 0;
    f_step s (time, input) in

  (* horizon *)
  let horizon s = cstate.horizon in

  Hnode { state = s; csize = n_cstates; zsize = n_zeros;
	  derivative = derivative;
	  crossing = crossing;
	  output = output;
	  setroots = setroots;
	  majorstep = majorstep;
	  reset = f_reset;
	  horizon = horizon }
