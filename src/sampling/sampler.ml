open Ztypes

module type Sampler =
sig
  val sample : 'o hsimu -> (float -> 'o -> unit) -> unit
end

module Horizon =
struct
  module Solver = Zlsolve.Make(Defaultsolver)(Illinois)

  let horizon = ref (-1.)

  let set_horizon h = horizon := h
  let get_horizon () = !horizon

  let run
      (Hsim { alloc      = main_alloc;
              maxsize    = main_maxsize;
              csize      = main_csize;
              zsize      = main_zsize;
              step       = main_step;
              derivative = main_ders;
              crossings  = main_zero;
              reset      = main_reset;
              horizon    = main_horizon; } : 'a hsimu) =

    if get_horizon () < 0. then begin
      Printf.eprintf "No horizon has been set"; assert false
    end;

    (* Solver.enable_logging (); *)

    let new_step mem cvec dvec zinvec time =
      Printf.printf "Step time : %.8f\r" time; flush stdout;
      time, main_step mem cvec dvec zinvec time
    in
    let new_horizon mem =
      min (main_horizon mem) (get_horizon ())
    in

    let stepfn = Solver.step
                        main_alloc
                        main_csize
                        main_zsize
                        new_horizon
                        main_maxsize
                        main_ders
                        new_step
                        main_zero
                        main_reset
    in
    let rec step () =
      let res, is_done, delta = stepfn () in
      if is_done then begin
        Printf.eprintf "Solver done before reaching the horizon";
        assert false
      end;
      begin match res with
      | None -> step ()
      | Some (t, f) -> if t = get_horizon () then begin Printf.printf "Reached tmax = %.2f\n" t; f end else step ()
      end;
    in step ()
end

module Period(Dump : Dumper.Dumper) =
struct
  module Solver = Zlsolve.Make(Defaultsolver)(Illinois)

  type 'a timed = { mutable cur_time : float; mutable cur_hor : float; mem : 'a }
  let timed_fn f mem = f mem.mem

  let period = ref None
  let offset = ref 0.

  let set_offset off = offset := off
  let get_offset () = !offset

  let set_period t = period := Some t
  let get_period () =
    match !period with
    | None -> Printf.eprintf "No period has been set\n"; assert false
    | Some period -> period

  let sample
      (Hsim { alloc      = main_alloc;
              maxsize    = main_maxsize;
              csize      = main_csize;
              zsize      = main_zsize;
              step       = main_step;
              derivative = main_ders;
              crossings  = main_zero;
              reset      = main_reset;
              horizon    = main_horizon; } : 'a hsimu) =

    let new_csize = (timed_fn main_csize) in
    let new_zsize = (timed_fn main_zsize) in
    let new_maxsize = (timed_fn main_maxsize) in
    let new_ders = (timed_fn main_ders) in
    let new_zero = (timed_fn main_zero) in
    let new_reset = (timed_fn main_reset) in

    let new_alloc () =
      let mem = main_alloc () in
      { cur_time = 0.; cur_hor = !offset; mem = mem }
    in
    let new_horizon mem =
      while mem.cur_hor <= mem.cur_time do
        mem.cur_hor <- mem.cur_hor +. (get_period ());
      done;
      min mem.cur_hor (main_horizon mem.mem)
    in
    let new_step mem cvec dvec zinvec time =
        mem.cur_time <- time;
        mem, main_step mem.mem cvec dvec zinvec time
    in

    let stepfn = Solver.step
                        new_alloc
                        new_csize
                        new_zsize
                        new_horizon
                        new_maxsize
                        new_ders
                        new_step
                        new_zero
                        new_reset
    in

    let rec step () =
      let res, is_done, delta = stepfn () in
      begin match res with
        | None -> ()
        | Some (mem, res) -> Dump.dump mem.cur_time res
      end;
      if not is_done then begin step () end
    in
    step ()
end
