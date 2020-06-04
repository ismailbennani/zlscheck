open Ztypes

let verbose = ref false

module Autotrans =
struct

  let h = 5. (* size of constant segment *)
  let bounds_online = [|0.,100.; 0.,350.|]
  let bounds_offline =
    [|0.,100.; 0.,350.; 0.,100.; 0.,350.; 0.,100.; 0.,350.; 0.,100.; 0.,350.;
      0.,100.; 0.,350.; 0.,100.; 0.,350.; 0.,100.; 0.,350.; 0.,100.; 0.,350.;
      0.,100.; 0.,350.; 0.,100.; 0.,350.|]

  let gd_alpha_high = 100000.
  let gd_alpha_low = 100.

  module type Params =
  sig
    module Optim : Optim.S
    val name : string
    val tstep : float
    val max_t : float
    val prop_name_in_matlab : string
    val set_optim_params : unit -> unit
    val node : (MyOp.t array, float * MyOp.t array * MyOp.t) Ztypes.node
  end

  module ParamsPhi1 =
  struct
    module Optim = Optim.GDClassic
    let name = "AT1"

    let tstep = 0.01
    let max_t = 20.

    let prop_name_in_matlab = "AT{1}"

    let set_optim_params () =
      Optim_globals.params.meth.gd.alpha <- gd_alpha_high;
      Optim_globals.params.meth.gd.do_restart <- true;
      Optim_globals.params.bounds <- bounds_offline;
      Optim_globals.params.verbose <- !verbose;
      Optim_globals.params.vverbose <- !verbose

    let node = Bench_models.autotrans_at1 tstep
  end

  module ParamsPhi1Online =
  struct
    module Optim = Optim.UR_GDAWARE
    let name = "AT1"

    let tstep = 0.01
    let max_t = 20.

    let prop_name_in_matlab = "AT{1}"

    let set_optim_params () =
      Optim_globals.params.meth.gd.alpha <- gd_alpha_high;
      Optim_globals.params.bounds <- bounds_online;
      Optim_globals.params.verbose <- !verbose;
      Optim_globals.params.vverbose <- !verbose

    let node = Bench_models.autotrans_at1 tstep
  end

  module ParamsPhi2 =
  struct
    module Optim = Optim.GDClassic
    let name = "AT2"

    let tstep = 0.01
    let max_t = 30.

    let prop_name_in_matlab = "AT{2}"

    let set_optim_params () =
      Optim_globals.params.meth.gd.alpha <- gd_alpha_high;
      Optim_globals.params.meth.gd.do_restart <- true;
      Optim_globals.params.bounds <- bounds_offline;
      Optim_globals.params.verbose <- !verbose;
      Optim_globals.params.vverbose <- !verbose

    let node = Bench_models.autotrans_at2 tstep
  end

  module ParamsPhi2Online =
  struct
    module Optim = Optim.UR_GDAWARE
    let name = "AT2"

    let tstep = 0.01
    let max_t = 30.

    let prop_name_in_matlab = "AT{2}"

    let set_optim_params () =
      Optim_globals.params.meth.gd.alpha <- gd_alpha_high;
      Optim_globals.params.bounds <- bounds_online;
      Optim_globals.params.verbose <- !verbose;
      Optim_globals.params.vverbose <- !verbose

    let node = Bench_models.autotrans_at2 tstep
  end

  module ParamsPhi51 =
  struct
    module Optim = Optim.UR_GDAWARE
    let name = "AT51"

    let tstep = 0.01
    let max_t = 30.

    let prop_name_in_matlab = "AT{3}"

    let set_optim_params () =
      Optim_globals.params.bounds <- bounds_offline;
      Optim_globals.params.verbose <- !verbose;
      Optim_globals.params.vverbose <- !verbose

    let node = Bench_models.autotrans_at51 tstep
  end

  module ParamsPhi52 =
  struct
    module Optim = Optim.UR_GDAWARE
    let name = "AT52"

    let tstep = 0.01
    let max_t = 30.

    let prop_name_in_matlab = "AT{4}"

    let set_optim_params () =
      Optim_globals.params.bounds <- bounds_offline;
      Optim_globals.params.verbose <- !verbose;
      Optim_globals.params.vverbose <- !verbose

    let node = Bench_models.autotrans_at52 tstep
  end

  module ParamsPhi53 =
  struct
    module Optim = Optim.UR_GDAWARE
    let name = "AT53"

    let tstep = 0.01
    let max_t = 30.

    let prop_name_in_matlab = "AT{5}"

    let set_optim_params () =
      Optim_globals.params.bounds <- bounds_offline;
      Optim_globals.params.verbose <- !verbose;
      Optim_globals.params.vverbose <- !verbose

    let node = Bench_models.autotrans_at53 tstep
  end

  module ParamsPhi54 =
  struct
    module Optim = Optim.UR_GDAWARE
    let name = "AT54"

    let tstep = 0.01
    let max_t = 30.

    let prop_name_in_matlab = "AT{6}"

    let set_optim_params () =
      Optim_globals.params.bounds <- bounds_offline;
      Optim_globals.params.verbose <- !verbose;
      Optim_globals.params.vverbose <- !verbose

    let node = Bench_models.autotrans_at54 tstep
  end

  module ParamsPhi51Online =
  struct
    module Optim = Optim.UR_GDAWARE
    let name = "AT51"

    let tstep = 0.01
    let max_t = 30.

    let prop_name_in_matlab = "AT{3}"

    let set_optim_params () =
      Optim_globals.params.meth.gd.alpha <- gd_alpha_high;
      Optim_globals.params.bounds <- bounds_online;
      Optim_globals.params.verbose <- !verbose;
      Optim_globals.params.vverbose <- !verbose

    let node = Bench_models.autotrans_at51 tstep
  end

  module ParamsPhi52Online =
  struct
    module Optim = Optim.UR_GDAWARE
    let name = "AT52"

    let tstep = 0.01
    let max_t = 30.

    let prop_name_in_matlab = "AT{4}"

    let set_optim_params () =
      Optim_globals.params.meth.gd.alpha <- gd_alpha_high;
      Optim_globals.params.bounds <- bounds_online;
      Optim_globals.params.verbose <- !verbose;
      Optim_globals.params.vverbose <- !verbose

    let node = Bench_models.autotrans_at52 tstep
  end

  module ParamsPhi53Online =
  struct
    module Optim = Optim.UR_GDAWARE
    let name = "AT53"

    let tstep = 0.01
    let max_t = 30.

    let prop_name_in_matlab = "AT{5}"

    let set_optim_params () =
      Optim_globals.params.meth.gd.alpha <- gd_alpha_high;
      Optim_globals.params.bounds <- bounds_online;
      Optim_globals.params.verbose <- !verbose;
      Optim_globals.params.vverbose <- !verbose

    let node = Bench_models.autotrans_at53 tstep
  end

  module ParamsPhi54Online =
  struct
    module Optim = Optim.UR_GDAWARE
    let name = "AT54"

    let tstep = 0.01
    let max_t = 30.

    let prop_name_in_matlab = "AT{6}"

    let set_optim_params () =
      Optim_globals.params.meth.gd.alpha <- gd_alpha_high;
      Optim_globals.params.bounds <- bounds_online;
      Optim_globals.params.verbose <- !verbose;
      Optim_globals.params.vverbose <- !verbose

    let node = Bench_models.autotrans_at54 tstep
  end

  module ParamsPhi6a =
  struct
    module Optim = Optim.GDClassic
    let name = "AT6a"

    let tstep = 0.01
    let max_t = 34.

    let prop_name_in_matlab = "AT{7}"

    let set_optim_params () =
      Optim_globals.params.meth.gd.alpha <- gd_alpha_low;
      Optim_globals.params.meth.gd.do_restart <- true;
      Optim_globals.params.bounds <- bounds_offline;
      Optim_globals.params.verbose <- !verbose;
      Optim_globals.params.vverbose <- !verbose

    let node = Bench_models.autotrans_at6a tstep
  end

  module ParamsPhi6aOnline =
  struct
    module Optim = Optim.UR_GDAWARE
    let name = "AT6a"

    let tstep = 0.01
    let max_t = 34.

    let prop_name_in_matlab = "AT{7}"

    let set_optim_params () =
      Optim_globals.params.meth.gd.alpha <- gd_alpha_low;
      Optim_globals.params.bounds <- bounds_online;
      Optim_globals.params.verbose <- !verbose;
      Optim_globals.params.vverbose <- !verbose

    let node = Bench_models.autotrans_at6a tstep
  end

  module ParamsPhi6b =
  struct
    module Optim = Optim.GDClassic
    let name = "AT6b"

    let tstep = 0.01
    let max_t = 38.

    let prop_name_in_matlab = "AT{8}"

    let set_optim_params () =
      Optim_globals.params.meth.gd.alpha <- gd_alpha_low;
      Optim_globals.params.meth.gd.do_restart <- true;
      Optim_globals.params.bounds <- bounds_offline;
      Optim_globals.params.verbose <- !verbose;
      Optim_globals.params.vverbose <- !verbose

    let node = Bench_models.autotrans_at6b tstep
  end

  module ParamsPhi6bOnline =
  struct
    module Optim = Optim.UR_GDAWARE
    let name = "AT6b"

    let tstep = 0.01
    let max_t = 38.

    let prop_name_in_matlab = "AT{8}"

    let set_optim_params () =
      Optim_globals.params.meth.gd.alpha <- gd_alpha_low;
      Optim_globals.params.bounds <- bounds_online;
      Optim_globals.params.verbose <- !verbose;
      Optim_globals.params.vverbose <- !verbose

    let node = Bench_models.autotrans_at6b tstep
  end

  module ParamsPhi6c =
  struct
    module Optim = Optim.GDClassic
    let name = "AT6c"

    let tstep = 0.01
    let max_t = 50.

    let prop_name_in_matlab = "AT{9}"

    let set_optim_params () =
      Optim_globals.params.meth.gd.alpha <- gd_alpha_low;
      Optim_globals.params.meth.gd.do_restart <- true;
      Optim_globals.params.bounds <- bounds_offline;
      Optim_globals.params.verbose <- !verbose;
      Optim_globals.params.vverbose <- !verbose

    let node = Bench_models.autotrans_at6c tstep
  end

  module ParamsPhi6cOnline =
  struct
    module Optim = Optim.UR_GDAWARE
    let name = "AT6c"

    let tstep = 0.01
    let max_t = 50.

    let prop_name_in_matlab = "AT{9}"

    let set_optim_params () =
      Optim_globals.params.meth.gd.alpha <- gd_alpha_low;
      Optim_globals.params.bounds <- bounds_online;
      Optim_globals.params.verbose <- !verbose;
      Optim_globals.params.vverbose <- !verbose

    let node = Bench_models.autotrans_at6c tstep
  end

  module AutotransdReplay =
  struct
    let name = "ReplayDiscrete"
    let tstep = 0.01
    let max_t = 50.

    let replay_node = Replay_models.autotransd tstep
    let scan_dump_inp ib =
      Scanf.bscanf ib "%g,%g,%g,%g,%g,%g"
        (fun th br rpm gear speed rob ->
           [| MyOp.make th; MyOp.make br; MyOp.make rpm; MyOp.make gear;
              MyOp.make speed; MyOp.make rob |])
    (* let print_dump_inp ff inp =
      Printf.fprintf ff "th=%g, br=%g" (MyOp.get inp.(0)) (MyOp.get inp.(1)) *)
  end

  module AutotranscReplay =
  struct
    let name = "ReplayContinuous"
    let tstep = 0.01 (* used for plotting only *)
    let max_t = 50.

    let replay_node = Replay_models.autotransc max_t tstep
    let scan_dump_inp ib =
      Scanf.bscanf ib "%g,%g,%g,%g,%g,%g"
        (fun th br rpm gear speed rob ->
           [| MyOp.make th; MyOp.make br; MyOp.make rpm; MyOp.make gear;
                MyOp.make speed; MyOp.make rob |])
    (* let print_dump_inp ff inp =
      Printf.fprintf ff "th=%g, br=%g" (MyOp.get inp.(0)) (MyOp.get inp.(1)) *)
  end

  module AutotransBench (Params: Params) =
  struct
    module Optim = Params.Optim

    let name = "autotrans_" ^ Params.name
    let prop_name_in_matlab = Params.prop_name_in_matlab
    let dump_path = "models/autotrans/bench_results"
    let matlab_path = "../../../../matlab"
    let max_t = Params.max_t
    let sample_every = 50
    let set_optim_params = Params.set_optim_params
    let node = Params.node
    let interp_fn control_points =
      fun t ->
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
      let cp_n = Array.length control_points in
      if 2 * index + 1 >= cp_n then
        [| control_points.(cp_n - 2); control_points.(cp_n - 1) |]
      else
        [| control_points.(2*index); control_points.(2*index+1) |]
  end

  module Phi1 = Offline.Make (AutotransBench(ParamsPhi1))
  module Phi2 = Offline.Make (AutotransBench(ParamsPhi2))
  module Phi51 = Offline.Make (AutotransBench(ParamsPhi51))
  module Phi52 = Offline.Make (AutotransBench(ParamsPhi52))
  module Phi53 = Offline.Make (AutotransBench(ParamsPhi53))
  module Phi54 = Offline.Make (AutotransBench(ParamsPhi54))
  module Phi6a = Offline.Make (AutotransBench(ParamsPhi6a))
  module Phi6b = Offline.Make (AutotransBench(ParamsPhi6b))
  module Phi6c = Offline.Make (AutotransBench(ParamsPhi6c))

  module Phi1Online = Online.Make (AutotransBench(ParamsPhi1Online))
  module Phi2Online = Online.Make (AutotransBench(ParamsPhi2Online))
  module Phi51Online = Online.Make (AutotransBench(ParamsPhi51Online))
  module Phi52Online = Online.Make (AutotransBench(ParamsPhi52Online))
  module Phi53Online = Online.Make (AutotransBench(ParamsPhi53Online))
  module Phi54Online = Online.Make (AutotransBench(ParamsPhi54Online))
  module Phi6aOnline = Online.Make (AutotransBench(ParamsPhi6aOnline))
  module Phi6bOnline = Online.Make (AutotransBench(ParamsPhi6bOnline))
  module Phi6cOnline = Online.Make (AutotransBench(ParamsPhi6cOnline))

  module ReplayDiscrete = Replay.Make (AutotransdReplay)
  module ReplayContinuous = Replay.Make (AutotranscReplay)
end
