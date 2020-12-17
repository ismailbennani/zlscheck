(**************************************************************************)
(*                                                                        *)
(*                                Zelus                                   *)
(*               A synchronous language for hybrid systems                *)
(*                       http://zelus.di.ens.fr                           *)
(*                                                                        *)
(*                    Marc Pouzet and Timothy Bourke                      *)
(*                                                                        *)
(*  Copyright 2012 - 2019. All rights reserved.                           *)
(*                                                                        *)
(*  This file is distributed under the terms of the CeCILL-C licence      *)
(*                                                                        *)
(*  Zelus is developed in the INRIA PARKAS team.                          *)
(*                                                                        *)
(**************************************************************************)

(* This module provides functions for lifting a hybrid function into *)
(* a discrete one. This is the so-called "co-simulation" of a *)
(* continuous or hybrid model in which the numerical solver *)
(* and zero-crossing detection mechanism are embedded into the step function *)

(* Lift a hybrid node into a discrete node *)
(* [solve f stop_time (input, t) = next_t, result]
   - f : 'a -C-> 'b is the hybrid node;
   - stop_time : float is the stop time (end) of the simulation;
   - input : 'a is a stream;
   - t : float is a stream of horizons that must be increasing
     (forall n in Nat. t(n) <= t(n+1))
   - result : 'b return is a stream of results;
   - next_t : float is a stream of achieved horizons *)

(* compile with:
 *- ocamlfind ocamlc bigarray.cma sundials.cma ztypes_fad.ml node.ml *)
(*- ocamlfind ocamlc bigarray.cma -package sundialsml sundials.cma
    Zls.cmo -I solvers solvers/illinois.cmo solvers/sundials_cvode.cmo
    ztypes_fad.ml node.ml *)


open Ztypes_fad

let debug = ref true

let log_info s i =
  if !debug then
    Printf.printf "%s%f\n" s i

type status = Node.status =
  | Interpolate (* no integration was necessary *)
  | Success of float (* the integration succeed; limit time for correctness *)
  | RootsFound (* a root has been found *)
  | Horizon of float (* returns the next horizon (time event) *)
  | Cascade (* a cascade *)
  | StopTimeReached (* the end of simulation time is reached *)
  | TimeHasPassed (* an output at time [h] is expected but *)
  (* [h < start] where [start] *)
  (* is the last restart time of the solver *)
  | Error (* something went wrong during integration *)

(* output *)
type return = { time: float; status: status; result: FadFloat.t array; }

module Make (SSolver: Zls.STATE_SOLVER_SENS) (ZSolver: Zls.ZEROC_SOLVER) =
struct
  (* the state of the solver. Either never called (allocated) or running *)
  type ('a, 'b) solver =
    | Init (* initial state of the simulation *)
    | Running of ('a, 'b) solver_state

  and ('a, 'b) solver_state =
    { zstate: ZSolver.t;
      (* the solver state *)
      sstate: SSolver.t;
      (* the zero-crossing solver state *)
      roots: Ztypes_fad.zinvec;
      (* the vector of zero-crossing *)
      nvec: SSolver.nvec;
      (* the vector of positions *)
      cvec: Zls.carray;
      (* the matrix of sensibilities *)
      smat: SSolver.sensmat;
      (* in two forms *)
      mutable t_start: float;
      (* time of the previous reset or mesh point *)
      mutable t_limit: float;
      (* time for the limit of the next solver step, i.e., next time event *)
      mutable t_mesh: float;
      (* horizon reached by the solver. *)
      (* No zero-crossing in [t_start, t_mesh] *)
      mutable t_time: float;
      (* current time *)
      mutable last_input: FadFloat.t array; (* the input is read at discrete-time instants *)
      mutable minput: FadFloat.t array; (* the input with derivatives set to the identity matrix *)
      mutable output: FadFloat.t array; (* the current output with derivatives wrt. the inputs *)
      mutable next: simulation_state; (* state of the simulation *)
    }

  and simulation_state =
    | Integrate (* integrate the signal *)
    | Discrete of bool (* true means zero-crossing; false a cascade *)
    | End (* end of the simulation; stop_time has been reached *)

  let log_cvec s cvec =
    if !debug then begin 
      Printf.printf "%s: [%s]\n" s (String.concat ", " (List.init (Sundials.RealArray.length cvec) (fun i -> Printf.sprintf "%g" cvec.{i})));
      flush stdout;
    end

  let log_smat s smat =
    let padding = String.make (String.length s + 2) ' ' in
    let smat = SSolver.arrays_of_sensmat smat in
    if !debug then begin
      Printf.printf "%s: [\n%s %s\n%s]\n" s padding 
        (String.concat ("\n " ^ padding)
           (Array.to_list (Array.map (fun vec -> 
                (String.concat ", " (Array.to_list (Array.map (Printf.sprintf "%11.5g") vec)))) smat)))
        padding;
      flush stdout;
    end

  let log_fadvec s fadvec =
    let padding = String.make (String.length s + 2) ' ' in
    let dim = Array.fold_left max 0 (Array.map FadFloat.dim fadvec) in
    if !debug then begin
      Printf.printf "%s: [%s]\n%s[\n%s %s\n%s]\n"
        s 
        (String.concat ", " (Array.to_list (Array.map (Printf.sprintf "%g") (Array.map FadFloat.get fadvec))))
        padding padding
        (String.concat ("\n " ^ padding) 
           (Array.to_list (Array.init dim (fun i -> 
                (String.concat ", " (Array.to_list (Array.init (Array.length fadvec) (fun j -> Printf.sprintf "%11.5g" (FadFloat.d fadvec.(j) i)))))))))
        padding;
      flush stdout;
    end

  (* switch between fadvec and cvec when derivatives are not useful *)
  let fadvec_of_cvec cvec = 
    (* create new array fadvec with the values in cvec and null derivatives *)
    if Sundials.RealArray.length cvec = 0 then [||]
    else Array.map FadFloat.make (Sundials.RealArray.to_array cvec)
  let cvec_of_fadvec fadvec =
    (* create new array cvec with the values in fadvec *)
    Sundials.RealArray.of_array (Array.map FadFloat.get fadvec)

  let mk_fadvec cvec smat =
    let dim1, dim2 = SSolver.sdim smat in
    Array.init dim2
      (fun i -> 
         let res = FadFloat.make_sized cvec.{i} dim1 in
         for j = 0 to dim1 - 1 do
           FadFloat.set_deriv res j (Fadbad.OrderedFloat.make (SSolver.sget smat j i))
         done; res)

  let cpy_fadvec_in_cvec fadvec cvec =
    (* retrieve values of elts in fadvec and write them in cvec *)
    Array.iteri (fun i fad_v -> cvec.{i} <- FadFloat.get fad_v) fadvec

  let cpy_inputs input = 
    let n = Array.length input in
    let res = Array.map FadFloat.make (Array.map FadFloat.get input) in
    Array.iteri (fun i v -> FadFloat.diff v i n) res;
    res

  let mk_result input output =
    (* 
      input contains the derivatives of the inputs wrt. some parameters
      output contains the derivatives of the outputs wrt. the inputs
    *)
    let dim = Array.fold_left max 0 (Array.map FadFloat.dim input) in
    Array.init (Array.length output)
      (fun i -> 
         let res = FadFloat.make_sized (FadFloat.get output.(i)) dim in
         for j = 0 to dim - 1 do
           (* compute derivative of res w.r.t. the j-th variable *)
           (* res = system_i(inps.(1), ..., inps.(n) *)
           (* dres/du_j = sum(k=1,n) dinps.(k)/du_j * D(system_i)k(inps.(1), ..., inps.(n)) *)
           (* where D(system_i)k is the function that computes the derivative of the i-th disc_state var of system w.r.t. its k-th input *)
           (* here, dinps.(k)/du_j is stored in diff array of inps.(k) at position j *)
           (* and D(system_i)k... is computed by sundialsml and stored in sens.(k)(i) *)
           let s = ref 0. in
           for k = 0 to Array.length input - 1 do
             s := !s +. (FadFloat.d input.(k) j) *. (FadFloat.d output.(i) k);
           done;
           FadFloat.set_deriv res j (Fadbad.OrderedFloat.make !s)
         done; res)

  let fill_smat smat cvec =
    (* fill the matrix smat with the derivatives in cvec *)
    let (dim1, dim2) = SSolver.sdim smat in
    for i = 0 to dim1 - 1 do
      for j = 0 to dim2 - 1 do
        SSolver.sset smat i j (FadFloat.d cvec.(j) i)
      done;
    done

  type ('a, 'b) state = { state: 'a; mutable solver: 'b }

  (* increment a given horizon by a small margin *)
  let add_margin h = h +. (2.0 *. epsilon_float *. h)

  (* the main lifting function *)
  let solve f (stop_time: float) =
    (* convert the internal representation of a hybrid node *)
    (* into one that can be used by an ODE/Zero-crossing solver *)
    let Hnode
        { state; zsize; csize; derivative; crossing;
          output; setroots; majorstep; reset; horizon } = Lift_fad.lift f in

    (* the allocation function *)
    let alloc () =
      (* At this point, we do not allocate the solver states yet. *)
      (* this is due to the way we compile which expect the derivative *)
      (* and zero-crossing function to expect an input *)
      (* We will change this once those two functions are obtained *)
      (* through slicing and will not need an input *)
      { state = state; solver = Init } in

    let reset ({ state; solver } as s) =
      reset state;
      (* not optimal because the solver session will be re-created instead of reinitialized *)
      s.solver <- Init;

      (* match solver with
         | Init -> ()
         | Running ({ nvec; cvec; smat; zstate; sstate; t_time } as s) ->
         (* reset the ODE solver and Zero-crossing solver *)

         (* this does not work because it is likely that 0.0 is not accessible by get_dky *)
         let _ = SSolver.get_dky sstate nvec 0.0 0 in
         let smat = SSolver.smake (Array.length (SSolver.arrays_of_sensmat smat)) csize in
         SSolver.reinitialize sstate 0.0 nvec smat;
         ZSolver.reinitialize zstate 0.0 cvec;
         s.t_start <- 0.0;
         s.t_time <- 0.0;
         s.t_mesh <- 0.0  *)
    in

    (* the step function *)
    let step ({ state; solver } as s) (expected_time, input) =
      let psize = Array.length input in
      try
        (* make a step *)
        match solver with
        | Init ->
          let minput = cpy_inputs input in

          (* allocate the vectors for continuous state variables *)
          (* and that for the zero-crossing detection *)
          let nvec = SSolver.cmake csize in
          let cvec = SSolver.unvec nvec in
          let roots = Zls.zmake zsize in

          log_info "Init: start = " 0.0;
          (* initial major step *)
          (* this step writes the initial positions in fadvec *)
          let fadvec = fadvec_of_cvec cvec in
          let result = majorstep state 0.0 fadvec minput in

          cpy_fadvec_in_cvec fadvec cvec;

          let derivative params time cvec dvec =
            (* derivatives computes and stores the state derivatives in dvec. 
               we don't need the derivatives of cvec and dvec wrt. the parameters *)
            let cfadvec = fadvec_of_cvec cvec in
            let dfadvec = fadvec_of_cvec dvec in
            derivative state (fadvec_of_cvec params) time cfadvec dfadvec;
            (* derivatives does not write in cvec *)
            cpy_fadvec_in_cvec dfadvec dvec
          in

          let crossing time cvec zoutvec =
            let cfadvec = fadvec_of_cvec cvec in
            let zfadvec = fadvec_of_cvec zoutvec in
            crossing state minput time cfadvec zfadvec;
            (* crossing does not write in cvec *)
            cpy_fadvec_in_cvec zfadvec zoutvec
          in

          let smat = SSolver.smake psize csize in
          fill_smat smat fadvec;

          log_fadvec "initial input" input;

          log_fadvec "initial fadvec" fadvec;
          log_fadvec "result (wr.t. input)" result;
          log_fadvec "result (w.r.t. params)" (mk_result input result);

          (* Allocate the solver *)
          let sstate =
            SSolver.initialize derivative (cvec_of_fadvec minput) nvec smat in
          (* Allocate the zsolver *)
          let zstate =
            ZSolver.initialize zsize crossing cvec in
          SSolver.set_stop_time sstate stop_time;

          let horizon = horizon state in
          let t_limit = min stop_time horizon in
          let next, status =
            if horizon = 0.0 then Discrete(false), Cascade
            else
            if stop_time <= 0.0 then End, StopTimeReached
            else Integrate, Horizon(t_limit) in
          s.solver <- Running { sstate; zstate;
                                t_start = 0.0; t_limit;
                                t_mesh = 0.0; t_time = 0.0;
                                minput;
                                last_input = input;
                                output = result;
                                roots; smat; cvec; nvec;
                                next };
          log_info "horizon = " t_limit;
          { time = 0.0; status; result = mk_result input result }
        | Running({ next; sstate; zstate; t_start; t_mesh; t_limit;
                    t_time; minput; last_input; nvec; cvec; smat; roots } as s) ->
          log_info "Expected time = " expected_time;
          if expected_time < t_start then
            { time = t_start; status = TimeHasPassed; result = s.output }
          else
            (* if the input did not change since the last reset *)
            (* of the solvers and expected_time is less than t_mesh *)
            (* interpolate the state at the expected_time *)
            let input_change =
              (expected_time > t_time) && not (last_input = input) in
            s.t_time <- expected_time;
            if expected_time <= t_mesh then
              if not input_change then begin
                (* interpolation *)
                log_info "Interpolate: time = " expected_time;

                let _ = SSolver.get_dky sstate nvec expected_time 0 in
                let _ = SSolver.get_sens_dky sstate smat expected_time 0 in

                let fadvec = mk_fadvec cvec smat in

                log_fadvec "fadvec" fadvec;
                log_fadvec "input" input;

                (* fadvec contains the values in cvec + their derivatives wrt. input *)
                let result = output state minput fadvec in

                log_fadvec "result (w.r.t. input)" result;
                log_fadvec "result (w.r.t. params)" (mk_result s.last_input result);

                (* output does not change the values in fadvec, no need to copy *)
                s.output <- result;
                { time = expected_time; status = Interpolate; result = mk_result s.last_input s.output }
              end else begin (* if the input has changed since the last step *)
                (* the solution estimated by the solver is wrong and *)
                (* must be cancelled *)
                let _ = SSolver.get_dky sstate nvec t_time 0 in
                let _ = SSolver.get_sens_dky sstate smat t_time 0 in

                log_info "Change of input at t_time = " t_time;
                log_fadvec "old input" last_input;
                log_fadvec "new input" input;

                (* fadvec with derivatives w.r.t. inputs *)
                let fadvec = mk_fadvec cvec smat in
                (* fadvec with derivatives w.r.t. params *)
                let fadvec = mk_result last_input fadvec in

                log_fadvec "fadvec before major step (w.r.t. params)" fadvec;

                let result = majorstep state t_time fadvec input in
                (* majorstep changes the values in fadvec to the new positions after 
                   the discrete step, we need to copy them back to cvec
                   and update the sensitivity matrix *)

                log_fadvec "fadvec after major step (w.r.t. params)" fadvec;

                let minput = cpy_inputs input in

                log_fadvec "minput" minput;

                (* fadvec with derivatives w.r.t. inputs *)
                let fadvec = mk_result minput fadvec in

                log_fadvec "fadvec after major step (w.r.t. input)" fadvec;

                cpy_fadvec_in_cvec fadvec cvec;
                fill_smat smat fadvec;

                log_fadvec "result (w.r.t. params)" result;

                let result = mk_result minput result in

                log_fadvec "result (w.r.t. input)" result;

                s.t_start <- t_time;
                s.t_mesh <- t_time;
                s.minput <- minput;
                s.last_input <- input;
                s.output <- result;
                let status =
                  let horizon = horizon state in
                  if horizon = 0.0
                  then begin s.next <- Discrete(false); Cascade end
                  else
                    let _ = SSolver.reinitialize sstate t_mesh nvec smat in
                    let _ = ZSolver.reinitialize zstate t_mesh cvec in
                    let t_limit = min stop_time horizon in
                    s.t_start <- t_mesh;
                    s.t_limit <- t_limit;
                    s.next <- Integrate;
                    Horizon(t_limit) in
                { time = t_mesh; status = status; result = mk_result s.last_input s.output }
              end
            else
              match next with
              | Integrate ->
                log_info "Integrate: t_mesh = " t_mesh;
                (* the new start point [t_start] is now [t_mesh] *)
                s.t_start <- t_mesh;
                if t_mesh >= stop_time then
                  begin
                    s.next <- End;
                    s.t_time <- expected_time;
                    { time = stop_time; status = StopTimeReached; result = mk_result s.last_input s.output }
                  end
                else
                  let t_limit_with_margin = add_margin t_limit in
                  log_info "t_limit_with_margin = " t_limit_with_margin;
                  let t_nextmesh =
                    (* integrate *)
                    SSolver.step sstate t_limit_with_margin nvec in
                  (* interpolate if the mesh point has passed the *)
                  (* time limit *)
                  log_info "t_nextmesh = " t_nextmesh;
                  let t =
                    if t_limit < t_nextmesh
                    then begin
                      SSolver.get_dky sstate nvec t_limit 0;
                      SSolver.get_sens_dky sstate smat t_limit 0;
                      t_limit
                    end else t_nextmesh in
                  log_info "t_nextmesh = " t;
                  (* is there a zero-crossing? *)
                  ZSolver.step zstate t cvec;
                  let has_roots = ZSolver.has_roots zstate in
                  let status =
                    if has_roots then
                      let t =
                        ZSolver.find
                          zstate (SSolver.get_dky sstate nvec, cvec)
                          roots in
                      SSolver.get_sens_dky sstate smat t 0;
                      log_info "root found at time = " t;
                      s.t_mesh <- t;
                      s.next <- Discrete(true);
                      Success(t)
                    else
                      let next =
                        if t = t_limit then Discrete(false)
                        else Integrate in
                      s.t_mesh <- t;
                      s.next <- next;
                      Success(t) in
                  s.t_time <- expected_time;
                  { time = s.t_start; status = status; result = mk_result s.last_input s.output }
              | Discrete(is_zero_crossing) ->
                log_info "StepRootsFound or StepCascade: time = " t_mesh;

                let input_change = not (last_input = input) in
                let fadvec = 
                  if input_change then begin
                    log_info "Change of input: time = " t_time;
                    log_fadvec "old input" last_input;
                    log_fadvec "new input" input;

                    (* fadvec with derivatives w.r.t. inputs *)
                    let fadvec = mk_fadvec cvec smat in
                    (* fadvec with derivatives w.r.t. params *)
                    let fadvec = mk_result last_input fadvec in

                    log_fadvec "fadvec before major step (w.r.t. params)" fadvec;
                    fadvec
                  end else begin
                    let fadvec = mk_fadvec cvec smat in
                    log_fadvec "fadvec before major step (w.r.t. inputs)" fadvec;
                    fadvec
                  end
                in

                if is_zero_crossing
                then begin
                  setroots state minput fadvec roots;
                  (* setroots writes in fadvec, we need to copy back (3 lines below) *)
                  log_fadvec "fadvec after setroots" fadvec;
                end;
                let result = majorstep state t_mesh fadvec minput in

                let fadvec, result = 
                  if input_change then begin
                    log_fadvec "fadvec before major step (w.r.t. params)" fadvec;
                    log_fadvec "result (w.r.t. params)" result;
                    let minput = cpy_inputs input in
                    (* fadvec with derivatives w.r.t. inputs *)
                    let fadvec = mk_result minput fadvec in
                    let result = mk_result minput result in
                    fadvec, result
                  end else fadvec, result
                in

                log_fadvec "fadvec after major step (w.r.t. inputs)" fadvec;
                log_fadvec "result (w.r.t. inputs)" result;

                (* majorstep writes in fadvec, we need to copy back *)
                cpy_fadvec_in_cvec fadvec cvec;
                fill_smat smat fadvec;

                s.output <- result;
                s.minput <- minput;
                s.last_input <- input;
                let status =
                  let horizon = horizon state in
                  if horizon = 0.0
                  then begin s.next <- Discrete(false); Cascade end
                  else
                    let _ = SSolver.reinitialize sstate t_mesh nvec smat in
                    let _ = ZSolver.reinitialize zstate t_mesh cvec in
                    let t_limit = min stop_time horizon in
                    s.t_start <- t_mesh;
                    s.t_limit <- t_limit;
                    s.next <- Integrate;
                    Horizon(t_limit) in
                { time = t_mesh; status = status; result = mk_result s.last_input s.output }
              | End ->
                log_info "End: stop_time = " stop_time;
                { time = s.t_start; status = StopTimeReached; result = mk_result s.last_input s.output }
      with
      | x -> raise x in
    Node { alloc = alloc; step = step; reset = reset }
end

module SundialsSolver = Make (Sundials_cvodes) (Illinois)

let solve = SundialsSolver.solve
