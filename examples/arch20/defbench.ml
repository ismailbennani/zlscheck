open Ztypes

let verbose = ref false

let pcwse_cste h control_points =
  fun t ->
  (* piecewise constant signal interpolation in 1D *)
  let index = truncate (t /. h) in
  let cp_n = Array.length control_points in
  if index >= cp_n then [| control_points.(cp_n - 1) |]
  else [| control_points.(index)|]

let pcwse_cste2 h control_points =
  fun t ->
  (* piecewise constant signal interpolation in 2D
     values for input 1 are in even cells of control_points and values for
     input 2 are in odd cells.
  *)

  let index = truncate (t /. h) in
  let cp_n = Array.length control_points in
  if 2 * index + 1 >= cp_n then
    [| control_points.(cp_n - 2); control_points.(cp_n - 1) |]
  else
    [| control_points.(2*index); control_points.(2*index+1) |]

module Autotrans =
struct

  let h = 5. (* size of constant segment *)
  let bounds_online = [|0.,100.; 0.,350.|]
  let bounds_offline =
    [| 0.,100.; 0.,350.; 0.,100.; 0.,350.; 0.,100.; 0.,350.; 0.,100.; 0.,350.;
       0.,100.; 0.,350.; 0.,100.; 0.,350.; 0.,100.; 0.,350. |]

  let gd_alpha_high = 100000.
  let gd_alpha_low = 100.

  module type Params =
  sig
    module Optim : Optim.S
    val name : string
    val tstep : float
    val max_t : float
    val sample_every: int
    val prop_name_in_matlab : string
    val set_optim_params : unit -> unit
    val node : (MyOp.t array, float * MyOp.t array * MyOp.t) Ztypes.node
  end

  module ParamsPhi1  (Optim : Optim.S)=
  struct
    module Optim = Optim
    let name = "AT1"

    let tstep = 0.01
    let max_t = 20.

    let sample_every = 50

    let prop_name_in_matlab = "AT{1}"

    let set_optim_params () =
      Optim_globals.params.meth.gd.alpha <- gd_alpha_high;
      Optim_globals.params.meth.gd.do_restart <- true;
      Optim_globals.params.bounds <- bounds_offline;
      Optim_globals.params.verbose <- !verbose;
      Optim_globals.params.vverbose <- !verbose

    let node = At_bench.autotrans_at1 tstep
  end

  module ParamsPhi2  (Optim : Optim.S)=
  struct
    module Optim = Optim
    let name = "AT2"

    let tstep = 0.01
    let max_t = 10.

    let sample_every = 50

    let prop_name_in_matlab = "AT{2}"

    let set_optim_params () =
      Optim_globals.params.meth.gd.alpha <- gd_alpha_high;
      Optim_globals.params.meth.gd.do_restart <- true;
      Optim_globals.params.bounds <- bounds_offline;
      Optim_globals.params.verbose <- !verbose;
      Optim_globals.params.vverbose <- !verbose

    let node = At_bench.autotrans_at2 tstep
  end

  module ParamsPhi51 (Optim : Optim.S) =
  struct
    module Optim = Optim
    let name = "AT51"

    let tstep = 0.01
    let max_t = 32.5

    let sample_every = 50

    let prop_name_in_matlab = "AT{3}"

    let set_optim_params () =
      Optim_globals.params.meth.gd.alpha <- gd_alpha_high;
      Optim_globals.params.bounds <- bounds_online;
      Optim_globals.params.verbose <- !verbose;
      Optim_globals.params.vverbose <- !verbose

    let node = At_bench.autotrans_at51 tstep
  end

  module ParamsPhi52 (Optim : Optim.S) =
  struct
    module Optim = Optim
    let name = "AT52"

    let tstep = 0.01
    let max_t = 32.5

    let sample_every = 50

    let prop_name_in_matlab = "AT{4}"

    let set_optim_params () =
      Optim_globals.params.meth.gd.alpha <- gd_alpha_high;
      Optim_globals.params.bounds <- bounds_online;
      Optim_globals.params.verbose <- !verbose;
      Optim_globals.params.vverbose <- !verbose

    let node = At_bench.autotrans_at52 tstep
  end

  module ParamsPhi53 (Optim : Optim.S) =
  struct
    module Optim = Optim
    let name = "AT53"

    let tstep = 0.01
    let max_t = 32.5

    let sample_every = 50

    let prop_name_in_matlab = "AT{5}"

    let set_optim_params () =
      Optim_globals.params.meth.gd.alpha <- gd_alpha_high;
      Optim_globals.params.bounds <- bounds_online;
      Optim_globals.params.verbose <- !verbose;
      Optim_globals.params.vverbose <- !verbose

    let node = At_bench.autotrans_at53 tstep
  end

  module ParamsPhi54 (Optim : Optim.S) =
  struct
    module Optim = Optim
    let name = "AT54"

    let tstep = 0.01
    let max_t = 32.5

    let sample_every = 50

    let prop_name_in_matlab = "AT{6}"

    let set_optim_params () =
      Optim_globals.params.meth.gd.alpha <- gd_alpha_high;
      Optim_globals.params.bounds <- bounds_online;
      Optim_globals.params.verbose <- !verbose;
      Optim_globals.params.vverbose <- !verbose

    let node = At_bench.autotrans_at54 tstep
  end

  module ParamsPhi6a (Optim : Optim.S) =
  struct
    module Optim = Optim
    let name = "AT6a"

    let tstep = 0.01
    let max_t = 30.

    let sample_every = 50

    let prop_name_in_matlab = "AT{7}"

    let set_optim_params () =
      Optim_globals.params.meth.gd.alpha <- gd_alpha_low;
      Optim_globals.params.meth.gd.do_restart <- true;
      Optim_globals.params.bounds <- bounds_offline;
      Optim_globals.params.verbose <- !verbose;
      Optim_globals.params.vverbose <- !verbose

    let node = At_bench.autotrans_at6a tstep
  end

  module ParamsPhi6b (Optim : Optim.S) =
  struct
    module Optim = Optim
    let name = "AT6b"

    let tstep = 0.01
    let max_t = 30.

    let sample_every = 50

    let prop_name_in_matlab = "AT{8}"

    let set_optim_params () =
      Optim_globals.params.meth.gd.alpha <- gd_alpha_high;
      Optim_globals.params.meth.gd.do_restart <- true;
      Optim_globals.params.bounds <- bounds_offline;
      Optim_globals.params.verbose <- !verbose;
      Optim_globals.params.vverbose <- !verbose

    let node = At_bench.autotrans_at6b tstep
  end

  module ParamsPhi6c (Optim : Optim.S) =
  struct
    module Optim = Optim
    let name = "AT6c"

    let tstep = 0.01
    let max_t = 30.

    let sample_every = 50

    let prop_name_in_matlab = "AT{9}"

    let set_optim_params () =
      Optim_globals.params.meth.gd.alpha <- gd_alpha_high;
      Optim_globals.params.meth.gd.do_restart <- true;
      Optim_globals.params.bounds <- bounds_offline;
      Optim_globals.params.verbose <- !verbose;
      Optim_globals.params.vverbose <- !verbose

    let node = At_bench.autotrans_at6c tstep
  end

  module AutotransdReplay =
  struct
    let name = "ReplayDiscrete"
    let max_t = 50.

    let replay_node = Replay_models.autotransd
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
    let model_name_in_matlab = "transmission"
    let dump_path = "models/at/bench_results"
    let matlab_path = "../../../../matlab"
    let max_t = Params.max_t
    let sample_every = Params.sample_every
    let set_optim_params = Params.set_optim_params
    let node = Params.node
    let interp_fn = pcwse_cste2 h
  end

  module Phi1 = Offline.Make (AutotransBench(ParamsPhi1(Optim.GDClassic)))
  module Phi2 = Offline.Make (AutotransBench(ParamsPhi2(Optim.GDClassic)))
  module Phi51 = Online.Make (AutotransBench(ParamsPhi51(Optim.GDClassic)))
  module Phi52 = Online.Make (AutotransBench(ParamsPhi52(Optim.GDClassic)))
  module Phi53 = Online.Make (AutotransBench(ParamsPhi53(Optim.GDClassic)))
  module Phi54 = Online.Make (AutotransBench(ParamsPhi54(Optim.GDClassic)))
  module Phi6a = Offline.Make (AutotransBench(ParamsPhi6a(Optim.GDClassic)))
  module Phi6b = Offline.Make (AutotransBench(ParamsPhi6b(Optim.GDClassic)))
  module Phi6c = Offline.Make (AutotransBench(ParamsPhi6c(Optim.GDClassic)))

  module Phi1UR = Offline.Make (AutotransBench(ParamsPhi1(Optim.UR_GDAWARE)))
  module Phi2UR = Offline.Make (AutotransBench(ParamsPhi2(Optim.UR_GDAWARE)))
  module Phi51UR = Online.Make (AutotransBench(ParamsPhi51(Optim.UR_GDAWARE)))
  module Phi52UR = Online.Make (AutotransBench(ParamsPhi52(Optim.UR_GDAWARE)))
  module Phi53UR = Online.Make (AutotransBench(ParamsPhi53(Optim.UR_GDAWARE)))
  module Phi54UR = Online.Make (AutotransBench(ParamsPhi54(Optim.UR_GDAWARE)))
  module Phi6aUR = Offline.Make (AutotransBench(ParamsPhi6a(Optim.UR_GDAWARE)))
  module Phi6bUR = Offline.Make (AutotransBench(ParamsPhi6b(Optim.UR_GDAWARE)))
  module Phi6cUR = Offline.Make (AutotransBench(ParamsPhi6c(Optim.UR_GDAWARE)))

  module ReplayDiscrete = Replay.Make (AutotransdReplay)
  module ReplayContinuous = Replay.Make (AutotranscReplay)
end

module F16 =
struct
  let pi = 3.1416
  (* bounds in ARCH git *)
  (* let bounds = [| pi /. 4. -. pi /. 20., pi /. 4. +. pi /. 20.;
                  -. pi /. 2. *. 0.8, -. pi /. 2. *. 0.8 +. pi /. 20.;
                  -. pi /. 4. -. pi /. 8., -. pi /. 4. +. pi /. 8. |] *)
  (* bounds in ARCH report *)
  let bounds = [| 0.2 *. pi, 0.2833 *. pi; -0.5 *. pi, -0.54 *. pi;
                  0.25 *. pi, 0.375 *. pi |]

  module F16Bench(Params:
                  sig
                    module Optim: Optim.S
                    val set_optim_params : unit -> unit
                  end) =
  struct
    module Optim = Params.Optim

    let name = "f16"
    let prop_name_in_matlab = "F16{1}"
    let model_name_in_matlab = "F16_GCAS"
    let dump_path = "models/f16/bench_results"
    let matlab_path = "../../../../matlab"
    let max_t = 15.0
    let sample_every = 10
    let set_optim_params () =
      Params.set_optim_params ();
      Optim_globals.params.bounds <- bounds;
      Optim_globals.params.verbose <- !verbose;
      Optim_globals.params.vverbose <- !verbose

    let node = F16_bench.f16 0.01
    let interp_fn control_points t = control_points
  end

  module Phi = Offline.Make(
      F16Bench(struct
        module Optim = Optim.GDClassic
        let set_optim_params () =
          Optim_globals.params.meth.gd.alpha <- 1e-4;
          Optim_globals.params.meth.gd.do_restart <- true;
      end)
    )

  module PhiUR = Offline.Make(
      F16Bench(struct
        module Optim = Optim.UR_GDAWARE
        let set_optim_params () = ()
      end))

  module ReplayDiscrete = Replay.Make (struct
      let name = "ReplayDiscrete"
      let max_t = 15.

      let replay_node = Replay_models.f16
      let scan_dump_inp ib =
        Scanf.bscanf ib "%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g"
          (fun phi0 theta0 psi0 alt alpha beta vt phi theta psi p q r rob ->
             Array.map MyOp.make
               [| phi0; theta0; psi0; alt; alpha; beta; vt;
                  phi; theta; psi; p; q; r; rob |])
    end)
end

module CC =
struct
  let online_bounds = [| 0., 1.; 0., 1. |]
  let offline_bounds = [| 0., 1.; 0., 1.; 0., 1.; 0., 1.; 0., 1.; 0., 1.;
                          0., 1.; 0., 1.; 0., 1.; 0., 1.; 0., 1.; 0., 1.;
                          0., 1.; 0., 1.; 0., 1.; 0., 1.; 0., 1.; 0., 1.;
                          0., 1.; 0., 1.; 0., 1.; 0., 1.; 0., 1.; 0., 1.;
                          0., 1.; 0., 1.; 0., 1.; 0., 1.; 0., 1.; 0., 1.;
                          0., 1.; 0., 1.; 0., 1.; 0., 1.; 0., 1.; 0., 1.;
                          0., 1.; 0., 1.; 0., 1.; 0., 1. |]

  module type Params =
  sig
    module Optim : Optim.S
    val index : int
    val node : (MyOp.t array, float * MyOp.t array * MyOp.t) Ztypes.node
  end

  module ParamsPhi1 (Optim: Optim.S) = struct
    module Optim = Optim
    let index = 1
    let node = Cc_bench.cc_cc1 0.01
  end

  module ParamsPhi2 (Optim: Optim.S) = struct
    module Optim = Optim
    let index = 2
    let node = Cc_bench.cc_cc2 0.01
  end

  module ParamsPhi3 (Optim: Optim.S) = struct
    module Optim = Optim
    let index = 3
    let node = Cc_bench.cc_cc3 0.01
  end

  module ParamsPhi4 (Optim: Optim.S) = struct
    module Optim = Optim
    let index = 4
    let node = Cc_bench.cc_cc4 0.01
  end

  module ParamsPhi5 (Optim: Optim.S) = struct
    module Optim = Optim
    let index = 5
    let node = Cc_bench.cc_cc5 0.01
  end

  module CCBench (Params: Params) = struct
    module Optim = Params.Optim

    let name = "cc" ^ (string_of_int Params.index)
    let prop_name_in_matlab = "CC{" ^ (string_of_int Params.index) ^ "}"
    let model_name_in_matlab = "chasingcars"
    let dump_path = "models/cc/bench_results"
    let matlab_path = "../../../../matlab"
    let max_t = 100.0
    let sample_every = 500
    let set_optim_params () =
      Optim_globals.params.meth.gd.alpha <- 1e-2;
      Optim_globals.params.meth.gd.do_restart <- true;
      Optim_globals.params.bounds <- online_bounds;
      Optim_globals.params.verbose <- !verbose;
      Optim_globals.params.vverbose <- !verbose

    let node = Params.node
    let interp_fn = pcwse_cste2 5.
  end

  module ReplayDiscrete = Replay.Make (struct
      let name = "ReplayDiscrete"
      let max_t = 100.

      let replay_node = Replay_models.cc
      let scan_dump_inp ib =
        Scanf.bscanf ib "%g,%g,%g,%g,%g,%g,%g,%g"
          (fun throttle brake c1 c2 c3 c4 c5 rob ->
             Array.map MyOp.make
               [| throttle; brake; c1; c2; c3; c4; c5; rob |])
    end)

  module ReplayContinuous = Replay.Make (struct
      let name = "ReplayDiscrete"
      let tstep = 0.1
      let max_t = 100.

      let replay_node = Replay_models.cc_c tstep max_t
      let scan_dump_inp ib =
        Scanf.bscanf ib "%g,%g,%g,%g,%g,%g,%g,%g"
          (fun throttle brake c1 c2 c3 c4 c5 rob ->
             Array.map MyOp.make
               [| throttle; brake; c1; c2; c3; c4; c5; rob |])
    end)

  module Phi1 = Online.Make(CCBench(ParamsPhi1(Optim.GDClassic)))
  module Phi2 = Online.Make(CCBench(ParamsPhi2(Optim.GDClassic)))
  module Phi3 = Online.Make(CCBench(ParamsPhi3(Optim.GDClassic)))
  module Phi4 = Online.Make(CCBench(ParamsPhi4(Optim.GDClassic)))
  module Phi5 = Online.Make(CCBench(ParamsPhi5(Optim.GDClassic)))
  module Phi1UR = Online.Make(CCBench(ParamsPhi1(Optim.UR_GDAWARE)))
  module Phi2UR = Online.Make(CCBench(ParamsPhi2(Optim.UR_GDAWARE)))
  module Phi3UR = Online.Make(CCBench(ParamsPhi3(Optim.UR_GDAWARE)))
  module Phi4UR = Online.Make(CCBench(ParamsPhi4(Optim.UR_GDAWARE)))
  module Phi5UR = Online.Make(CCBench(ParamsPhi5(Optim.UR_GDAWARE)))
end

module WT =
struct
  let max_t = 630.
  let h = 5.
  let dim = truncate (ceil (max_t /. h))

  let online_bounds = [| 8., 16. |]
  let offline_bounds = Array.make dim (online_bounds.(0))

  module type Params =
  sig
    module Optim : Optim.S
    val index : int
    val node : (MyOp.t array, float * MyOp.t array * MyOp.t) Ztypes.node
  end

  module WTBench (Params: Params) =
  struct
    module Optim = Params.Optim

    let name = "wt" ^ (string_of_int Params.index)
    let prop_name_in_matlab = "WT{" ^ (string_of_int Params.index) ^ "}"
    let model_name_in_matlab = "wind_turbine"
    let dump_path = "models/wt/bench_results"
    let matlab_path = "../../../../matlab"
    let max_t = max_t
    let sample_every = 500
    let set_optim_params () =
      Optim_globals.params.meth.gd.alpha <- 1e4;
      Optim_globals.params.meth.gd.do_restart <- true;
      Optim_globals.params.bounds <- offline_bounds;
      Optim_globals.params.verbose <- !verbose;
      Optim_globals.params.vverbose <- !verbose

    let node = Params.node
    let interp_fn = pcwse_cste h
  end

  module ParamsPhi1 (Optim: Optim.S)= struct
    module Optim = Optim
    let index = 1
    let node = Wt_bench.wt_wt1 0.01
  end

  module ParamsPhi2 (Optim: Optim.S)= struct
    module Optim = Optim
    let index = 2
    let node = Wt_bench.wt_wt2 0.01
  end

  module ParamsPhi3 (Optim: Optim.S)= struct
    module Optim = Optim
    let index = 3
    let node = Wt_bench.wt_wt3 0.01
  end

  module ParamsPhi4 (Optim: Optim.S)= struct
    module Optim = Optim
    let index = 4
    let node = Wt_bench.wt_wt4 0.01
  end

  module ReplayDiscrete = Replay.Make (struct
      let name = "ReplayDiscrete"
      let max_t = max_t

      let replay_node = Replay_models.wt
      let scan_dump_inp ib =
        Scanf.bscanf ib "%g,%g,%g,%g,%g,%g,%g,%g"
          (fun throttle brake c1 c2 c3 c4 c5 rob ->
             Array.map MyOp.make
               [| throttle; brake; c1; c2; c3; c4; c5; rob |])
    end)

  module Phi1 = Offline.Make(WTBench(ParamsPhi1(Optim.GDClassic)))
  module Phi2 = Offline.Make(WTBench(ParamsPhi2(Optim.GDClassic)))
  module Phi3 = Offline.Make(WTBench(ParamsPhi3(Optim.GDClassic)))
  module Phi4 = Offline.Make(WTBench(ParamsPhi4(Optim.GDClassic)))
  module Phi1UR = Offline.Make(WTBench(ParamsPhi1(Optim.UR_GDAWARE)))
  module Phi2UR = Offline.Make(WTBench(ParamsPhi2(Optim.UR_GDAWARE)))
  module Phi3UR = Offline.Make(WTBench(ParamsPhi3(Optim.UR_GDAWARE)))
  module Phi4UR = Offline.Make(WTBench(ParamsPhi4(Optim.UR_GDAWARE)))
end

module AFC =
struct
  let max_t = 50.
  let h = 5.
  let dim = truncate (ceil (max_t /. h))

  let online_bounds_normal_mode = [| 0., 61.1; 900., 1100. |]
  let offline_bounds_normal_mode =
    [| 0., 61.1; 900., 1100.; 0., 61.1; 900., 1100.; 0., 61.1; 900., 1100.;
       0., 61.1; 900., 1100.; 0., 61.1; 900., 1100.; 0., 61.1; 900., 1100.;
       0., 61.1; 900., 1100.; 0., 61.1; 900., 1100.; 0., 61.1; 900., 1100.;
       0., 61.1; 900., 1100. |]
  let online_bounds_power_mode = [| 61.2, 81.2; 900., 1100. |]
  let offline_bounds_power_mode =
    [| 61.2, 81.2; 900., 1100.; 61.2, 81.2; 900., 1100.; 61.2, 81.2; 900., 1100.;
       61.2, 81.2; 900., 1100.; 61.2, 81.2; 900., 1100.; 61.2, 81.2; 900., 1100.;
       61.2, 81.2; 900., 1100.; 61.2, 81.2; 900., 1100.; 61.2, 81.2; 900., 1100.;
       61.2, 81.2; 900., 1100. |]

  module type Params =
  sig
    module Optim : Optim.S
    val index : int
    val bounds : (float * float) array
    val node : (MyOp.t array, float * MyOp.t array * MyOp.t) Ztypes.node
  end
  module AFCBench (Params: Params) =
  struct
    module Optim = Params.Optim

    let name = "afc" ^ (string_of_int Params.index)
    let prop_name_in_matlab = "AFC{" ^ (string_of_int Params.index) ^ "}"
    let model_name_in_matlab = "powertrain"
    let dump_path = "models/afc/bench_results"
    let matlab_path = "../../../../matlab"
    let max_t = max_t
    let sample_every = 500
    let set_optim_params () =
      Optim_globals.params.meth.gd.alpha <- 1e4;
      Optim_globals.params.meth.gd.do_restart <- true;
      Optim_globals.params.bounds <- Params.bounds;
      Optim_globals.params.verbose <- !verbose;
      Optim_globals.params.vverbose <- !verbose

    let node = Params.node
    let interp_fn = pcwse_cste2 h
  end

  module ParamsPhi27 (Optim: Optim.S)= struct
    module Optim = Optim
    let index = 1
    let bounds = offline_bounds_normal_mode
    let node = Afc_bench.afc_afc27 5e-5
  end

  module ReplayDiscrete = Replay.Make (struct
      let name = "ReplayDiscrete"
      let max_t = max_t

      let replay_node = Replay_models.afc
      let scan_dump_inp ib =
        Scanf.bscanf ib "%g,%g,%g,%g,%g,%g,%g"
          (fun throttle engine abf abf_ref mu mode rob ->
             Array.map MyOp.make
               [| throttle; engine; abf; abf_ref; mu; mode; rob |])
    end)

  module Phi27 = Offline.Make(AFCBench(ParamsPhi27(Optim.GDClassic)))
  module Phi27UR = Offline.Make(AFCBench(ParamsPhi27(Optim.UR_GDAWARE)))
end
