open Ztypes

module Autotrans =
struct

  let h = 5. (* size of constant segment *)
  let bounds_online = [|0.,100.; 0.,350.|]
  let bounds_offline =
    [|0.,100.; 0.,350.; 0.,100.; 0.,350.; 0.,100.; 0.,350.; 0.,100.; 0.,350.;
      0.,100.; 0.,350.; 0.,100.; 0.,350.; 0.,100.; 0.,350.; 0.,100.; 0.,350.;
      0.,100.; 0.,350.; 0.,100.; 0.,350.|]
  let verbose = false
  let vverbose = false

  module type Params =
  sig
    module Optim : Optim.S
    val name : string
    val tstep : float
    val max_t : float
    val set_optim_params : unit -> unit
    val node : (MyOp.t array, float * MyOp.t) Ztypes.node
  end

  module ParamsPhi1 =
  struct
    module Optim = Optim.GDClassic
    let name = "AT1"

    let tstep = 0.01
    let max_t = 20.

    let set_optim_params () =
      Optim_globals.params.meth.gd.alpha <- 10000.;
      Optim_globals.params.bounds <- bounds_offline;
      Optim_globals.params.verbose <- verbose;
      Optim_globals.params.vverbose <- vverbose

    let node = Bench.autotrans_phi1 tstep
  end

  module ParamsPhi2 =
  struct
    module Optim = Optim.GDClassic
    let name = "AT2"

    let tstep = 0.01
    let max_t = 30.

    let set_optim_params () =
      Optim_globals.params.meth.gd.alpha <- 10000.;
      Optim_globals.params.bounds <- bounds_offline;
      Optim_globals.params.verbose <- verbose;
      Optim_globals.params.vverbose <- vverbose

    let node = Bench.autotrans_phi2 tstep
  end

  module ParamsPhi51Offline =
  struct
    module Optim = Optim.UR_GDAWARE
    let name = "AT51"

    let tstep = 0.01
    let max_t = 30.

    let set_optim_params () =
      Optim_globals.params.bounds <- bounds_offline;
      Optim_globals.params.verbose <- verbose;
      Optim_globals.params.vverbose <- vverbose

    let node = Bench.autotrans_phi51 tstep
  end

  module ParamsPhi52Offline =
  struct
    module Optim = Optim.UR_GDAWARE
    let name = "AT52"

    let tstep = 0.01
    let max_t = 30.

    let set_optim_params () =
      Optim_globals.params.bounds <- bounds_offline;
      Optim_globals.params.verbose <- verbose;
      Optim_globals.params.vverbose <- vverbose

    let node = Bench.autotrans_phi52 tstep
  end

  module ParamsPhi53Offline =
  struct
    module Optim = Optim.UR_GDAWARE
    let name = "AT53"

    let tstep = 0.01
    let max_t = 30.

    let set_optim_params () =
      Optim_globals.params.bounds <- bounds_offline;
      Optim_globals.params.verbose <- verbose;
      Optim_globals.params.vverbose <- vverbose

    let node = Bench.autotrans_phi53 tstep
  end

  module ParamsPhi54Offline =
  struct
    module Optim = Optim.UR_GDAWARE
    let name = "AT54"

    let tstep = 0.01
    let max_t = 30.

    let set_optim_params () =
      Optim_globals.params.bounds <- bounds_offline;
      Optim_globals.params.verbose <- verbose;
      Optim_globals.params.vverbose <- vverbose

    let node = Bench.autotrans_phi54 tstep
  end

  module ParamsPhi51Online =
  struct
    module Optim = Optim.GDClassic
    let name = "AT51"

    let tstep = 0.01
    let max_t = 30.

    let set_optim_params () =
      Optim_globals.params.meth.gd.alpha <- 10000.;
      Optim_globals.params.bounds <- bounds_online;
      Optim_globals.params.verbose <- verbose;
      Optim_globals.params.vverbose <- vverbose

    let node = Bench.autotrans_phi51 tstep
  end

  module ParamsPhi52Online =
  struct
    module Optim = Optim.GDClassic
    let name = "AT52"

    let tstep = 0.01
    let max_t = 30.

    let set_optim_params () =
      Optim_globals.params.meth.gd.alpha <- 10000.;
      Optim_globals.params.bounds <- bounds_online;
      Optim_globals.params.verbose <- verbose;
      Optim_globals.params.vverbose <- vverbose

    let node = Bench.autotrans_phi52 tstep
  end

  module ParamsPhi53Online =
  struct
    module Optim = Optim.GDClassic
    let name = "AT53"

    let tstep = 0.01
    let max_t = 30.

    let set_optim_params () =
      Optim_globals.params.meth.gd.alpha <- 10000.;
      Optim_globals.params.bounds <- bounds_online;
      Optim_globals.params.verbose <- verbose;
      Optim_globals.params.vverbose <- vverbose

    let node = Bench.autotrans_phi53 tstep
  end

  module ParamsPhi54Online =
  struct
    module Optim = Optim.GDClassic
    let name = "AT54"

    let tstep = 0.01
    let max_t = 30.

    let set_optim_params () =
      Optim_globals.params.meth.gd.alpha <- 10000.;
      Optim_globals.params.bounds <- bounds_online;
      Optim_globals.params.verbose <- verbose;
      Optim_globals.params.vverbose <- vverbose

    let node = Bench.autotrans_phi54 tstep
  end

  module ParamsPhi6a =
  struct
    module Optim = Optim.GDClassic
    let name = "AT6a"

    let tstep = 0.01
    let max_t = 30.

    let set_optim_params () =
      Optim_globals.params.meth.gd.alpha <- 10000.;
      Optim_globals.params.bounds <- bounds_offline;
      Optim_globals.params.verbose <- verbose;
      Optim_globals.params.vverbose <- vverbose

    let node = Bench.autotrans_phi6a tstep
  end

  module ParamsPhi6b =
  struct
    module Optim = Optim.GDADAM
    let name = "AT6b"

    let tstep = 0.01
    let max_t = 30.

    let set_optim_params () =
      Optim_globals.params.meth.gd.alpha <- 100.;
      Optim_globals.params.bounds <- bounds_offline;
      Optim_globals.params.verbose <- verbose;
      Optim_globals.params.vverbose <- vverbose

    let node = Bench.autotrans_phi6b tstep
  end

  module ParamsPhi6c =
  struct
    module Optim = Optim.GDAMSGRAD
    let name = "AT6c"

    let tstep = 0.01
    let max_t = 30.

    let set_optim_params () =
      Optim_globals.params.meth.gd.alpha <- 100.;
      Optim_globals.params.bounds <- bounds_offline;
      Optim_globals.params.verbose <- verbose;
      Optim_globals.params.vverbose <- vverbose

    let node = Bench.autotrans_phi6c tstep
  end

  module AutotransBench (Params: Params) =
  struct
    module Optim = Params.Optim

    let name = "autotrans_" ^ Params.name
    let dump_path = Some "models/autotrans/dump"
    let max_t = Params.max_t
    let set_optim_params = Params.set_optim_params
    let node = Params.node
    let interp_fn control_points t =
      (* scenario:
         throttle:
             cp0                    cp2
         ___________           ___________

                    ___________           ______________________
         brake:
                        cp1                   cp3
                    ___________           ___________

         ___________           ___________           ___________

         0          h         2h          3h        4h
         with h = maxt / 5
      *)

      let index = truncate (t /. h) in
      [| control_points.(2*index); control_points.(2*index+1) |]
  end

  module Phi1 = Offline.Make (AutotransBench(ParamsPhi1))
  module Phi2 = Offline.Make (AutotransBench(ParamsPhi2))
  module Phi51Offline = Offline.Make (AutotransBench(ParamsPhi51Offline))
  module Phi52Offline = Offline.Make (AutotransBench(ParamsPhi52Offline))
  module Phi53Offline = Offline.Make (AutotransBench(ParamsPhi53Offline))
  module Phi54Offline = Offline.Make (AutotransBench(ParamsPhi54Offline))
  module Phi51Online = Online.Make (AutotransBench(ParamsPhi51Online))
  module Phi52Online = Online.Make (AutotransBench(ParamsPhi52Online))
  module Phi53Online = Online.Make (AutotransBench(ParamsPhi53Online))
  module Phi54Online = Online.Make (AutotransBench(ParamsPhi54Online))
  module Phi6a = Offline.Make (AutotransBench(ParamsPhi6a))
  module Phi6b = Offline.Make (AutotransBench(ParamsPhi6b))
  module Phi6c = Offline.Make (AutotransBench(ParamsPhi6c))
end

module Sanity_check =
  Offline.Make
    (struct
      module Optim = Optim.GDAMSGRAD
      let name = "sanity_check"
      let dump_path = None
      let max_t = 30.0
      let node = Bench.sanity_check 0.01
      let set_optim_params () =
        Optim_globals.params.meth.gd.alpha <- 10000000.;
        Optim_globals.params.meth.gd.beta1 <- 0.1;
        Optim_globals.params.meth.gd.beta2 <- 1.;
        Optim_globals.params.bounds <- [|-100.,100.|];
        Optim_globals.params.vverbose <- true

      let interp_fn control_points t = control_points
    end)

(* let _ =
   Optim_globals.params.meth.gd.alpha <- 1.;
   Optim_globals.params.bounds <- [|0.,100.; 0.,350.; 0.,100.; 0.,350.|];
   Optim_globals.params.verbose <- false;

   let res = Sanity_check.run () in
   Offline.print_result (fun ff f_a ->
      Printf.fprintf ff "[|%s|]"
        (String.concat "; "
           (Array.to_list (Array.map (fun f -> Printf.sprintf "%g" f) f_a)))
    ) res;
   print_endline "--done." *)
