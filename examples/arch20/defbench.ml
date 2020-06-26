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

let pcwse_cste_afc h control_points =
  fun t ->
  (* first coordinate of control_points is the value of the second coordinate of
     the input, the rest of the array is to be interpolated for first coordinate
     of input *)
  let index = truncate (t /. h) in
  let cp_n = Array.length control_points in
  if index + 1 >= cp_n then
    [| control_points.(cp_n - 1); control_points.(0) |]
  else
    [| control_points.(1 + index); control_points.(0) |]

let pcwse_cste_variable_times times values t =
  let i = Interp.ifind (MyOp.make t) times in
  if i = 0 then [| values.(0) |] else [| values.(i-1) |]

let myop_compare x y =
  if MyOp.(x < y) then -1
  else if MyOp.(x > y) then 1
  else 0

let pcwse_cste_variable_times_sa control_points =
  let times = Array.sub control_points 12 11 in
  Array.sort myop_compare times;
  let times' = Array.create 12 (MyOp.make 0.) in
  Array.blit times 0 times' 1 11;
  Printf.printf "times: [%s]\n" (String.concat "; " (Array.to_list (Array.map string_of_float (Array.map MyOp.get times))));
  let values = Array.map (fun x -> MyOp.scale x 0.001) (Array.sub control_points 0 12) in
  fun t ->
  let i = Interp.ifind (MyOp.make t) times in
  if i = 0 then [| values.(0) |] else [| values.(i-1) |]

let pcwse_linear times values t =
  [| Interp.interp1 (times, values) (MyOp.make t) |]

module Autotrans =
struct
  let tstep = 0.01
  let bounds_online = [|0.,100.; 0.,350.|]

  let gd_alpha_high = 10000000.
  let gd_alpha_low = 1000.

  module type Instance =
  sig
    val index : int
    val sample_every : int
  end

  module Instance1 = struct let index = 1 let sample_every = 50 end
  module Instance2 = struct let index = 2 let sample_every = 500 end

  module type Params =
  sig
    module Optim : Optim.S
    val name : string
    val max_t : float
    val instance : int
    val sample_every : int
    val prop_name_in_matlab : string
    val set_optim_params : unit -> unit
    val node : (MyOp.t array, float * MyOp.t array * MyOp.t) Ztypes.node
  end

  module ParamsPhi1 (Optim : Optim.S) (Instance : Instance) =
  struct
    module Optim = Optim
    let name = Printf.sprintf "AT1_inst%d" Instance.index

    let max_t = 20.

    let instance = Instance.index
    let sample_every = Instance.sample_every

    let prop_name_in_matlab = "AT{1}"

    let set_optim_params () =
      Optim_globals.params.meth.gd.alpha <- gd_alpha_high;
      Optim_globals.params.meth.gd.do_restart <- true;
      Optim_globals.params.bounds <-
        Array.init (truncate (ceil (max_t /. ((float sample_every) *. tstep))) * 2)
          (fun i -> bounds_online.(i mod 2));
      Optim_globals.params.verbose <- !verbose;
      Optim_globals.params.vverbose <- !verbose

    let node = At_bench.autotrans_at1 tstep
  end

  module ParamsPhi2 (Optim : Optim.S) (Instance : Instance) =
  struct
    module Optim = Optim
    let name = Printf.sprintf "AT2_inst%d" Instance.index

    let max_t = 10.

    let instance = Instance.index
    let sample_every = if Instance.index = 1 then 250 else Instance.sample_every

    let prop_name_in_matlab = "AT{2}"

    let set_optim_params () =
      Optim_globals.params.meth.gd.alpha <- gd_alpha_high;
      Optim_globals.params.meth.gd.do_restart <- true;
      Optim_globals.params.bounds <-
      Array.init (truncate (ceil (max_t /. ((float sample_every) *. tstep))) * 2)
        (fun i -> bounds_online.(i mod 2));
      Optim_globals.params.verbose <- !verbose;
      Optim_globals.params.vverbose <- !verbose

    let node = At_bench.autotrans_at2 tstep
  end

  module ParamsPhi51 (Optim : Optim.S) (Instance : Instance) =
  struct
    module Optim = Optim
    let name = Printf.sprintf "AT51_inst%d" Instance.index

    let max_t = 32.5

    let instance = Instance.index
    let sample_every = Instance.sample_every

    let prop_name_in_matlab = "AT{3}"

    let set_optim_params () =
      Optim_globals.params.meth.gd.alpha <- gd_alpha_high;
      Optim_globals.params.bounds <- bounds_online;
      Optim_globals.params.verbose <- !verbose;
      Optim_globals.params.vverbose <- !verbose

    let node = At_bench.autotrans_at51 tstep
  end

  module ParamsPhi52 (Optim : Optim.S) (Instance : Instance) =
  struct
    module Optim = Optim
    let name = Printf.sprintf "AT52_inst%d" Instance.index

    let max_t = 32.5

    let instance = Instance.index
    let sample_every = Instance.sample_every

    let prop_name_in_matlab = "AT{4}"

    let set_optim_params () =
      Optim_globals.params.meth.gd.alpha <- gd_alpha_high;
      Optim_globals.params.bounds <- bounds_online;
      Optim_globals.params.verbose <- !verbose;
      Optim_globals.params.vverbose <- !verbose

    let node = At_bench.autotrans_at52 tstep
  end

  module ParamsPhi53 (Optim : Optim.S) (Instance : Instance) =
  struct
    module Optim = Optim
    let name = Printf.sprintf "AT53_inst%d" Instance.index

    let max_t = 32.5

    let instance = Instance.index
    let sample_every = Instance.sample_every

    let prop_name_in_matlab = "AT{5}"

    let set_optim_params () =
      Optim_globals.params.meth.gd.alpha <- gd_alpha_high;
      Optim_globals.params.bounds <- bounds_online;
      Optim_globals.params.verbose <- !verbose;
      Optim_globals.params.vverbose <- !verbose

    let node = At_bench.autotrans_at53 tstep
  end

  module ParamsPhi54 (Optim : Optim.S) (Instance : Instance) =
  struct
    module Optim = Optim
    let name = Printf.sprintf "AT54_inst%d" Instance.index

    let max_t = 32.5

    let instance = Instance.index
    let sample_every = Instance.sample_every

    let prop_name_in_matlab = "AT{6}"

    let set_optim_params () =
      Optim_globals.params.meth.gd.alpha <- gd_alpha_high;
      Optim_globals.params.bounds <- bounds_online;
      Optim_globals.params.verbose <- !verbose;
      Optim_globals.params.vverbose <- !verbose

    let node = At_bench.autotrans_at54 tstep
  end

  module ParamsPhi6a (Optim : Optim.S) (Instance : Instance) =
  struct
    module Optim = Optim
    let name = Printf.sprintf "AT6a_inst%d" Instance.index

    let max_t = 30.

    let instance = Instance.index
    let sample_every = if Instance.index = 1 then 500 else Instance.sample_every

    let prop_name_in_matlab = "AT{7}"

    let set_optim_params () =
      Optim_globals.params.meth.gd.alpha <- 100.;
      Optim_globals.params.meth.gd.do_restart <- true;
      Optim_globals.params.bounds <-
      Array.init (truncate (ceil (max_t /. ((float sample_every) *. tstep))) * 2)
        (fun i -> bounds_online.(i mod 2));
      Optim_globals.params.verbose <- !verbose;
      Optim_globals.params.vverbose <- !verbose

    let node = At_bench.autotrans_at6a tstep
  end

  module ParamsPhi6b (Optim : Optim.S) (Instance : Instance) =
  struct
    module Optim = Optim
    let name = Printf.sprintf "AT6b_inst%d" Instance.index

    let max_t = 30.

    let instance = Instance.index
    let sample_every = if Instance.index = 1 then 1000 else Instance.sample_every

    let prop_name_in_matlab = "AT{8}"

    let set_optim_params () =
      Optim_globals.params.meth.gd.alpha <- gd_alpha_low;
      Optim_globals.params.meth.gd.do_restart <- true;
      Optim_globals.params.bounds <-
      Array.init (truncate (ceil (max_t /. ((float sample_every) *. tstep))) * 2)
        (fun i -> bounds_online.(i mod 2));
      Optim_globals.params.verbose <- !verbose;
      Optim_globals.params.vverbose <- !verbose

    let node = At_bench.autotrans_at6b tstep
  end

  module ParamsPhi6c (Optim : Optim.S) (Instance : Instance) =
  struct
    module Optim = Optim
    let name = Printf.sprintf "AT6c_inst%d" Instance.index

    let max_t = 30.

    let instance = Instance.index
    let sample_every = if Instance.index = 1 then 1500 else Instance.sample_every

    let prop_name_in_matlab = "AT{9}"

    let set_optim_params () =
      Optim_globals.params.meth.gd.alpha <- gd_alpha_low;
      Optim_globals.params.meth.gd.do_restart <- true;
      Optim_globals.params.bounds <-
      Array.init (truncate (ceil (max_t /. ((float sample_every) *. tstep))) * 2)
        (fun i -> bounds_online.(i mod 2));
      Optim_globals.params.verbose <- !verbose;
      Optim_globals.params.vverbose <- !verbose

    let node = At_bench.autotrans_at6c tstep
  end

  module AutotransdReplay =
  struct
    let name = "ReplayDiscrete"
    let max_t = 50.

    let replay_node = Replay_models.at
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
    let prop_name = Params.name
    let prop_name_in_matlab = Params.prop_name_in_matlab
    let model_name_in_matlab = "transmission"
    let folder_name_in_shared = "transmission"
    let dump_path = Printf.sprintf "benchmarks/at_inst%d" Params.instance
    let shared_path = "../../../shared"
    let max_t = Params.max_t
    let sample_every = Params.sample_every
    let set_optim_params = Params.set_optim_params
    let node = Params.node
    let interp_fn = pcwse_cste2 (float sample_every *. tstep)
  end

  module Phi1_instance1 = Offline.Make (AutotransBench(ParamsPhi1(Optim.GDClassic)(Instance1)))
  module Phi2_instance1 = Offline.Make (AutotransBench(ParamsPhi2(Optim.GDClassic)(Instance1)))
  module Phi51_instance1 = Online.Make (AutotransBench(ParamsPhi51(Optim.GDClassic)(Instance1)))
  module Phi52_instance1 = Online.Make (AutotransBench(ParamsPhi52(Optim.GDClassic)(Instance1)))
  module Phi53_instance1 = Online.Make (AutotransBench(ParamsPhi53(Optim.GDClassic)(Instance1)))
  module Phi54_instance1 = Online.Make (AutotransBench(ParamsPhi54(Optim.GDClassic)(Instance1)))
  module Phi6a_instance1 = Offline.Make (AutotransBench(ParamsPhi6a(Optim.GDClassic)(Instance1)))
  module Phi6b_instance1 = Offline.Make (AutotransBench(ParamsPhi6b(Optim.GDClassic)(Instance1)))
  module Phi6c_instance1 = Offline.Make (AutotransBench(ParamsPhi6c(Optim.GDClassic)(Instance1)))

  module Phi1UR_instance1 = Offline.Make (AutotransBench(ParamsPhi1(Optim.UR_GDAWARE)(Instance1)))
  module Phi2UR_instance1 = Offline.Make (AutotransBench(ParamsPhi2(Optim.UR_GDAWARE)(Instance1)))
  module Phi51UR_instance1 = Online.Make (AutotransBench(ParamsPhi51(Optim.UR_GDAWARE)(Instance1)))
  module Phi52UR_instance1 = Online.Make (AutotransBench(ParamsPhi52(Optim.UR_GDAWARE)(Instance1)))
  module Phi53UR_instance1 = Online.Make (AutotransBench(ParamsPhi53(Optim.UR_GDAWARE)(Instance1)))
  module Phi54UR_instance1 = Online.Make (AutotransBench(ParamsPhi54(Optim.UR_GDAWARE)(Instance1)))
  module Phi6aUR_instance1 = Offline.Make (AutotransBench(ParamsPhi6a(Optim.UR_GDAWARE)(Instance1)))
  module Phi6bUR_instance1 = Offline.Make (AutotransBench(ParamsPhi6b(Optim.UR_GDAWARE)(Instance1)))
  module Phi6cUR_instance1 = Offline.Make (AutotransBench(ParamsPhi6c(Optim.UR_GDAWARE)(Instance1)))

  module Phi1_instance2 = Offline.Make (AutotransBench(ParamsPhi1(Optim.GDClassic)(Instance2)))
  module Phi2_instance2 = Offline.Make (AutotransBench(ParamsPhi2(Optim.GDClassic)(Instance2)))
  module Phi51_instance2 = Online.Make (AutotransBench(ParamsPhi51(Optim.GDClassic)(Instance2)))
  module Phi52_instance2 = Online.Make (AutotransBench(ParamsPhi52(Optim.GDClassic)(Instance2)))
  module Phi53_instance2 = Online.Make (AutotransBench(ParamsPhi53(Optim.GDClassic)(Instance2)))
  module Phi54_instance2 = Online.Make (AutotransBench(ParamsPhi54(Optim.GDClassic)(Instance2)))
  module Phi6a_instance2 = Offline.Make (AutotransBench(ParamsPhi6a(Optim.GDClassic)(Instance2)))
  module Phi6b_instance2 = Offline.Make (AutotransBench(ParamsPhi6b(Optim.GDClassic)(Instance2)))
  module Phi6c_instance2 = Offline.Make (AutotransBench(ParamsPhi6c(Optim.GDClassic)(Instance2)))

  module Phi1UR_instance2 = Offline.Make (AutotransBench(ParamsPhi1(Optim.UR_GDAWARE)(Instance2)))
  module Phi2UR_instance2 = Offline.Make (AutotransBench(ParamsPhi2(Optim.UR_GDAWARE)(Instance2)))
  module Phi51UR_instance2 = Online.Make (AutotransBench(ParamsPhi51(Optim.UR_GDAWARE)(Instance2)))
  module Phi52UR_instance2 = Online.Make (AutotransBench(ParamsPhi52(Optim.UR_GDAWARE)(Instance2)))
  module Phi53UR_instance2 = Online.Make (AutotransBench(ParamsPhi53(Optim.UR_GDAWARE)(Instance2)))
  module Phi54UR_instance2 = Online.Make (AutotransBench(ParamsPhi54(Optim.UR_GDAWARE)(Instance2)))
  module Phi6aUR_instance2 = Offline.Make (AutotransBench(ParamsPhi6a(Optim.UR_GDAWARE)(Instance2)))
  module Phi6bUR_instance2 = Offline.Make (AutotransBench(ParamsPhi6b(Optim.UR_GDAWARE)(Instance2)))
  module Phi6cUR_instance2 = Offline.Make (AutotransBench(ParamsPhi6c(Optim.UR_GDAWARE)(Instance2)))

  module ReplayDiscrete = Replay.Make (AutotransdReplay)
end

module F16 =
struct
  let pi = 3.1416
  (* bounds in ARCH git *)
  let bounds = [| pi /. 4. -. pi /. 20., pi /. 4. +. pi /. 20.;
                  -. pi /. 2. *. 0.8, -. pi /. 2. *. 0.8 +. pi /. 20.;
                  -. pi /. 4. -. pi /. 8., -. pi /. 4. +. pi /. 8. |]
  (* bounds in ARCH report *)
  (* let bounds = [| 0.2 *. pi, 0.2833 *. pi; -0.5 *. pi, -0.54 *. pi;
                  0.25 *. pi, 0.375 *. pi |] *)

  module F16Bench(Params:
                  sig
                    module Optim: Optim.S
                    val set_optim_params : unit -> unit
                  end) =
  struct
    module Optim = Params.Optim

    let name = "f16"
    let prop_name = "F16"
    let prop_name_in_matlab = "F16{1}"
    let model_name_in_matlab = "F16_GCAS"
    let folder_name_in_shared = "F16_GCAS"
    let dump_path = "benchmarks/f16"
    let shared_path = "../../../shared"
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
    let prop_name = "CC" ^ (string_of_int Params.index)
    let prop_name_in_matlab = "CC{" ^ (string_of_int Params.index) ^ "}"
    let model_name_in_matlab = "chasingcars"
    let folder_name_in_shared = "chasing-cars"
    let dump_path = "benchmarks/cc"
    let shared_path = "../../../shared"
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
    let prop_name = "WT" ^ (string_of_int Params.index)
    let prop_name_in_matlab = "WT{" ^ (string_of_int Params.index) ^ "}"
    let model_name_in_matlab = "wind_turbine"
    let folder_name_in_shared = "wind-turbine"
    let dump_path = "benchmarks/wt"
    let shared_path = "../../../shared"
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

  let online_bounds_normal_mode = [| 0., 61.1 |]
  let offline_bounds_normal_mode =
    [| 900., 1100.; 0., 61.1; 0., 61.1; 0., 61.1; 0., 61.1; 0., 61.1; 0., 61.1;
       0., 61.1; 0., 61.1; 0., 61.1; 0., 61.1 |]
  let online_bounds_power_mode = [| 61.2, 81.2; 900., 1100. |]
  let offline_bounds_power_mode =
    [| 900., 1100.; 61.2, 81.2; 61.2, 81.2; 61.2, 81.2; 61.2, 81.2; 61.2, 81.2;
       61.2, 81.2; 61.2, 81.2; 61.2, 81.2; 61.2, 81.2; 61.2, 81.2 |]

  module type Params =
  sig
    val index : int
    val gd_alpha : float
    val bounds : (float * float) array
    val sample_every : int
    val node : (MyOp.t array, float * MyOp.t array * MyOp.t) Ztypes.node
  end
  module AFCBench (Params: Params) (Optim: Optim.S) =
  struct
    module Optim = Optim

    let name = "afc" ^ (string_of_int Params.index)
    let prop_name = "AFC" ^ (string_of_int Params.index)
    let prop_name_in_matlab = "AFC{" ^ (string_of_int Params.index) ^ "}"
    let model_name_in_matlab = "powertrain"
    let folder_name_in_shared = "powertrain"
    let dump_path = "benchmarks/afc"
    let shared_path = "../../../shared"
    let max_t = max_t
    let sample_every = Params.sample_every
    let set_optim_params () =
      Optim_globals.params.meth.gd.alpha <- Params.gd_alpha;
      Optim_globals.params.meth.gd.do_restart <- true;
      Optim_globals.params.bounds <- Params.bounds;
      Optim_globals.params.verbose <- !verbose;
      Optim_globals.params.vverbose <- !verbose

    let node = Params.node
    let interp_fn = pcwse_cste_afc h
  end

  module ParamsPhi27 = struct
    let index = 27
    let bounds = online_bounds_normal_mode
    let gd_alpha = 1000.
    let sample_every = truncate (5. /. 5e-5)
    let node = Afc_bench.afc_afc1 5e-5 (MyOp.make (Random.float 200. +. 900.))
  end

  module ParamsPhi29 = struct
    let index = 29
    let bounds = offline_bounds_normal_mode
    let gd_alpha = 1e7
    let sample_every = 0
    let node = Afc_bench.afc_afc2 5e-5
  end

  module ParamsPhi33 = struct
    let index = 33
    let bounds = offline_bounds_power_mode
    let gd_alpha = 1e9
    let sample_every = 0
    let node = Afc_bench.afc_afc2 5e-5
  end

  module ReplayDiscrete = Replay.Make (struct
      let name = "ReplayDiscrete"
      let max_t = max_t

      let replay_node = Replay_models.afc
      let scan_dump_inp ib =
        Scanf.bscanf ib "%s"
          (fun s ->
             let nums = Array.of_list (String.split_on_char ',' s) in
             let no_rob = Array.sub nums 0 (Array.length nums - 1) in
             Array.map MyOp.make (Array.map float_of_string no_rob))
    end)

  module Phi27 = Online.Make(AFCBench(ParamsPhi27)(Optim.GDClassic))
  module Phi29 = Offline.Make(AFCBench(ParamsPhi29)(Optim.GDClassic))
  module Phi33 = Offline.Make(AFCBench(ParamsPhi33)(Optim.GDClassic))
  module Phi27UR = Online.Make(AFCBench(ParamsPhi27)(Optim.UR_GDAWARE))
  module Phi29UR = Offline.Make(AFCBench(ParamsPhi29)(Optim.UR_GDAWARE))
  module Phi33UR = Offline.Make(AFCBench(ParamsPhi33)(Optim.UR_GDAWARE))
end

module SC =
struct
  let h = 0.2
  let max_t = 40.
  let n_pieces = truncate (ceil (max_t /. h))

  let online_bounds = [| 3.99, 4.01 |]
  let offline_bounds = Array.make n_pieces online_bounds.(0)
  let instance2_bounds = Array.make 12 online_bounds.(0)
  let instance2_minsize = 1.
  let instance2_maxsize = 5.
  let instance2_sa_bounds =
    Array.concat [Array.make 12 (3990., 4010.); Array.make 11 (0., 40.)]

  module SCBench (Optim : Optim.S) (Params: sig
      val name : string
      val set_optim_params : unit -> unit
      val interp_fn : MyOp.t array -> float -> MyOp.t array
    end) =
  struct
    module Optim = Optim

    let name = Params.name
    let prop_name = "SC"
    let prop_name_in_matlab = "SC{1}"
    let model_name_in_matlab = "steamcondenser"
    let folder_name_in_shared = "SteamCondenser"
    let dump_path = "benchmarks/sc"
    let shared_path = "../../../shared"
    let max_t = 40.0
    let sample_every = 200
    let set_optim_params () =
      Params.set_optim_params ();
      Optim_globals.params.verbose <- !verbose;
      Optim_globals.params.vverbose <- !verbose

    let node = Sc_bench.sc_sc1 0.01
    let interp_fn = Params.interp_fn
  end

  module ParamsInst1 =
    struct
      let h = 2.
      let n_pieces = truncate (ceil (max_t /. h))
      let offline_bounds = Array.make n_pieces online_bounds.(0)

      let name = "sc_inst1"

      let set_optim_params () =
        Optim_globals.params.meth.gd.alpha <- 5.;
        Optim_globals.params.bounds <- offline_bounds;
        Optim_globals.params.meth.gd.do_restart <- true
      let interp_fn = pcwse_cste h
    end

  module ParamsInst2 =
    struct
      let h = 0.2
      let n_pieces = truncate (ceil (max_t /. h))
      let offline_bounds = Array.make n_pieces online_bounds.(0)

      let name = "sc_inst2"

      let set_optim_params () =
        Optim_globals.params.meth.gd.alpha <- 5.;
        Optim_globals.params.bounds <- offline_bounds;
        Optim_globals.params.meth.gd.do_restart <- true
      let interp_fn = pcwse_cste h
    end

  module Phi_inst1 = Offline.Make(SCBench(Optim.GDClassic)(ParamsInst1))
  module Phi_inst2 = Offline.Make(SCBench(Optim.GDClassic)(ParamsInst2))
  module PhiUR_inst1 = Offline.Make(SCBench(Optim.UR_GDAWARE)(ParamsInst1))
  module PhiUR_inst2 = Offline.Make(SCBench(Optim.UR_GDAWARE)(ParamsInst2))


  module ReplayDiscrete = Replay.Make (struct
      let name = "ReplayDiscrete"
      let max_t = 40.

      let replay_node = Replay_models.sc
      let scan_dump_inp ib =
        Scanf.bscanf ib "%g,%g,%g,%g,%g,%g"
          (fun fs temp fcw q p rob ->
             Array.map MyOp.make
               [| fs; temp; fcw; q; p; rob |])
    end)
end

module NN =
struct
  let h = 0.2
  let max_t = 40.
  let n_pieces = truncate (ceil (max_t /. h))

  let online_bounds = [| 1., 3. |]

  module type Params =
  sig
    val name : string
    val prop_name : string
    val node : float -> (MyOp.t array, float * MyOp.t array * MyOp.t) Ztypes.node
    val set_optim_params : unit -> unit
    val interp_fn : MyOp.t array -> float -> MyOp.t array
  end

  module NNBench (Optim : Optim.S) (Params: Params) =
  struct
    module Optim = Optim

    let name = Params.name
    let prop_name = Params.prop_name
    let prop_name_in_matlab = "NN{1}"
    let model_name_in_matlab = "neural"
    let folder_name_in_shared = "neural"
    let dump_path = "benchmarks/nn"
    let shared_path = "../../../shared"
    let max_t = 40.0
    let sample_every = 200
    let set_optim_params () =
      Params.set_optim_params ();
      Optim_globals.params.verbose <- !verbose;
      Optim_globals.params.vverbose <- !verbose

    let node = Params.node 0.001
    let interp_fn = Params.interp_fn
  end

  module ParamsInst1 : Params =
    struct
      let h = 3.
      let n_pieces = truncate (ceil (max_t /. h))
      let offline_bounds = Array.make n_pieces online_bounds.(0)

      let name = "nn_inst1"
      let prop_name = "NN_inst1"
      let node = Nn_bench.nn_nn1

      let set_optim_params () =
        Optim_globals.params.meth.gd.alpha <- 1.;
        Optim_globals.params.bounds <- offline_bounds;
        Optim_globals.params.meth.gd.do_restart <- true
      let interp_fn = pcwse_cste h
    end

  module ParamsInst2 : Params =
    struct
      let n_pieces = 3
      let h = max_t /. (float n_pieces)
      let offline_bounds = Array.make n_pieces online_bounds.(0)

      let name = "nn_inst2"
      let prop_name = "NN_inst2"
      let node = Nn_bench.nn_nn1

      let set_optim_params () =
        Optim_globals.params.meth.gd.alpha <- 1.;
        Optim_globals.params.bounds <- offline_bounds;
        Optim_globals.params.meth.gd.do_restart <- true
      let interp_fn = pcwse_cste h
    end

  module ParamsInst1_2 : Params =
    struct
      let h = 3.
      let n_pieces = truncate (ceil (max_t /. h))
      let offline_bounds = Array.make n_pieces online_bounds.(0)

      let name = "nn_inst1_0_04"
      let prop_name = "NN_inst1 (beta=0.04)"
      let node = Nn_bench.nn_nn2

      let set_optim_params () =
        Optim_globals.params.meth.gd.alpha <- 1.;
        Optim_globals.params.bounds <- offline_bounds;
        Optim_globals.params.meth.gd.do_restart <- true
      let interp_fn = pcwse_cste h
    end

  module ParamsInst2_2 : Params =
    struct
      let n_pieces = 3
      let h = max_t /. (float n_pieces)
      let offline_bounds = Array.make n_pieces online_bounds.(0)

      let name = "nn_inst2_0_04"
      let prop_name = "NN_inst2 (beta=0.04)"
      let node = Nn_bench.nn_nn2

      let set_optim_params () =
        Optim_globals.params.meth.gd.alpha <- 1.;
        Optim_globals.params.bounds <- offline_bounds;
        Optim_globals.params.meth.gd.do_restart <- true
      let interp_fn = pcwse_cste h
    end

  module Phi1_inst1 = Offline.Make(NNBench(Optim.GDClassic)(ParamsInst1))
  module Phi1_inst2 = Offline.Make(NNBench(Optim.GDClassic)(ParamsInst2))
  module Phi2_inst1 = Offline.Make(NNBench(Optim.GDClassic)(ParamsInst1_2))
  module Phi2_inst2 = Offline.Make(NNBench(Optim.GDClassic)(ParamsInst2_2))
  module Phi1UR_inst1 = Offline.Make(NNBench(Optim.UR_GDAWARE)(ParamsInst1))
  module Phi1UR_inst2 = Offline.Make(NNBench(Optim.UR_GDAWARE)(ParamsInst2))
  module Phi2UR_inst1 = Offline.Make(NNBench(Optim.UR_GDAWARE)(ParamsInst1_2))
  module Phi2UR_inst2 = Offline.Make(NNBench(Optim.UR_GDAWARE)(ParamsInst2_2))


  module ReplayDiscrete = Replay.Make (struct
      let name = "ReplayDiscrete"
      let max_t = 40.

      let replay_node = Replay_models.nn
      let scan_dump_inp ib =
        Scanf.bscanf ib "%g,%g,%g,%g"
          (fun reference pos nnpos rob ->
             Array.map MyOp.make
               [| reference; pos; nnpos; rob |])
    end)
end
