open Ztypes

module type PeriodicFun = sig
  type acc
  type values
  (* new_accumulator = periodic_fun accumulator time values *)
  val periodic_fun : acc option -> Ztypes.time -> values -> acc option
end

module Make(Fun : PeriodicFun) (SSolver : Zls.STATE_SOLVER) =
struct
  module Solver = Zlsolve.Make(SSolver)(Illinois)

  type 'a timed = { mutable cur_time : float; mutable cur_hor : float; mem : 'a }
  let timed_fn f mem = f mem.mem

  let period = ref None
  let max_time = ref (-1.)
  let offset = ref 0.

  let set_offset off = offset := off
  let get_offset () = !offset

  let set_max_time t = max_time := t
  let get_max_time () = !max_time

  let set_period t = period := Some t
  let get_period () =
    match !period with
    | None -> !max_time
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

    (* TODO 
      if get_max_time () > 0. then Solver.set_max_sim_time (get_max_time ());
    *)

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

    let rec step acc =
      let res, is_done, delta = stepfn () in
      let fun_res =
        begin match res with
          | None -> None
          | Some (mem, res) -> Fun.periodic_fun acc mem.cur_time res
        end
      in
      if not is_done then step (if fun_res = None then acc else fun_res)
      else acc
    in
    step None
end
