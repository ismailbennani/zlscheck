open Ztypes

let verbose = ref false

module Autotrans =
struct
  let tstep = 0.01
  let bounds = [|0.,100.; 0.,350.|]

  let gd_alpha_high = 10000000.
  let gd_alpha_low = 100.

  module type Instance =
  sig
    val index : int
    val sample_every : int
  end

  module Instance1 = struct let index = 1 let sample_every = 50 end
  module Instance2 = struct let index = 2 let sample_every = 500 end

  module type Params =
  sig
    val name : string
    val max_t : float
    val sample_every : int
    val node : (FadFloat.t array, float * FadFloat.t array * FadFloat.t) Ztypes.node
  end

  module ParamsPhi1 (Instance : Instance) =
  struct
    let name = Printf.sprintf "AT1_inst%d" Instance.index
    let max_t = 20.
    let sample_every = Instance.sample_every
    let node = At.autotrans_at1 tstep
  end

  module ParamsPhi2 (Instance : Instance) =
  struct
    let name = Printf.sprintf "AT2_inst%d" Instance.index
    let max_t = 10.
    let sample_every = if Instance.index = 1 then 250 else Instance.sample_every
    let node = At.autotrans_at2 tstep
  end

  module ParamsPhi51 (Instance : Instance) =
  struct
    let name = Printf.sprintf "AT51_inst%d" Instance.index
    let max_t = 32.5
    let sample_every = Instance.sample_every
    let node = At.autotrans_at51 tstep
  end

  module ParamsPhi52 (Instance : Instance) =
  struct
    let name = Printf.sprintf "AT52_inst%d" Instance.index
    let max_t = 32.5
    let sample_every = Instance.sample_every
    let node = At.autotrans_at52 tstep
  end

  module ParamsPhi53 (Instance : Instance) =
  struct
    let name = Printf.sprintf "AT53_inst%d" Instance.index
    let max_t = 32.5
    let sample_every = Instance.sample_every
    let node = At.autotrans_at53 tstep
  end

  module ParamsPhi54 (Instance : Instance) =
  struct
    let name = Printf.sprintf "AT54_inst%d" Instance.index
    let max_t = 32.5
    let sample_every = Instance.sample_every
    let node = At.autotrans_at54 tstep
  end

  module ParamsPhi6a (Instance : Instance) =
  struct
    let name = Printf.sprintf "AT6a_inst%d" Instance.index
    let max_t = 30.
    let sample_every = Instance.sample_every
    let node = At.autotrans_at6a tstep
  end

  module ParamsPhi6b (Instance : Instance) =
  struct
    let name = Printf.sprintf "AT6b_inst%d" Instance.index
    let max_t = 30.
    let sample_every = Instance.sample_every
    let node = At.autotrans_at6b tstep
  end

  module ParamsPhi6c (Instance : Instance) =
  struct
    let name = Printf.sprintf "AT6c_inst%d" Instance.index
    let max_t = 30.
    let sample_every = if Instance.index = 1 then 1500 else Instance.sample_every
    let node = At.autotrans_at6c tstep
  end

  module AutotransBench (Params: Params) =
  struct
    let name = "autotrans_" ^ Params.name
    let prop_name = Params.name
    let max_t = Params.max_t
    let tstep = tstep
    let sample_every = Params.sample_every
    let bounds = bounds
    let node = Params.node
    let scenario : FadFloat.t Scenario.t =
      let throttle =
        Scenario.piecewise_constant 1
          ((float sample_every) *. tstep) max_t
      in
      let brake =
        Scenario.piecewise_constant 1
          ((float sample_every) *. tstep) max_t
      in Scenario.cross throttle brake
  end

  module Phi1_instance1 = AutotransBench(ParamsPhi1(Instance1))
  module Phi2_instance1 = AutotransBench(ParamsPhi2(Instance1))
  module Phi51_instance1 = AutotransBench(ParamsPhi51(Instance1))
  module Phi52_instance1 = AutotransBench(ParamsPhi52(Instance1))
  module Phi53_instance1 = AutotransBench(ParamsPhi53(Instance1))
  module Phi54_instance1 = AutotransBench(ParamsPhi54(Instance1))
  module Phi6a_instance1 = AutotransBench(ParamsPhi6a(Instance1))
  module Phi6b_instance1 = AutotransBench(ParamsPhi6b(Instance1))
  module Phi6c_instance1 = AutotransBench(ParamsPhi6c(Instance1))

  module Phi1_instance2 = AutotransBench(ParamsPhi1(Instance2))
  module Phi2_instance2 = AutotransBench(ParamsPhi2(Instance2))
  module Phi51_instance2 = AutotransBench(ParamsPhi51(Instance2))
  module Phi52_instance2 = AutotransBench(ParamsPhi52(Instance2))
  module Phi53_instance2 = AutotransBench(ParamsPhi53(Instance2))
  module Phi54_instance2 = AutotransBench(ParamsPhi54(Instance2))
  module Phi6a_instance2 = AutotransBench(ParamsPhi6a(Instance2))
  module Phi6b_instance2 = AutotransBench(ParamsPhi6b(Instance2))
  module Phi6c_instance2 = AutotransBench(ParamsPhi6c(Instance2))
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

  module Phi =
  struct
    let name = "f16"
    let prop_name = "F16"
    let max_t = 15.0
    let tstep = 0.01
    let sample_every = 10
    let bounds = bounds
    let scenario : FadFloat.t Scenario.t = Scenario.constant 3 max_t
    let node = F16.f16 tstep
  end
end

module CC =
struct
  let tstep = 0.01
  let bounds = [| 0., 1.; 0., 1. |]

  module type Params =
  sig
    val index : int
    val node : (FadFloat.t array, float * FadFloat.t array * FadFloat.t) Ztypes.node
  end

  module ParamsPhi1 = struct
    let index = 1
    let node = Cc.cc_cc1 tstep
  end

  module ParamsPhi2 = struct
    let index = 2
    let node = Cc.cc_cc2 tstep
  end

  module ParamsPhi3 = struct
    let index = 3
    let node = Cc.cc_cc3 tstep
  end

  module ParamsPhi4 = struct
    let index = 4
    let node = Cc.cc_cc4 tstep
  end

  module ParamsPhi5 = struct
    let index = 5
    let node = Cc.cc_cc5 tstep
  end

  module CCBench (Params: Params) = struct
    let name = "cc" ^ (string_of_int Params.index)
    let prop_name = "CC" ^ (string_of_int Params.index)
    let max_t = 100.0
    let tstep = tstep
    let sample_every = 500
    let bounds = bounds
    let scenario : FadFloat.t Scenario.t =
      let throttle =
        Scenario.piecewise_constant 1
          ((float sample_every) *. tstep) max_t
      in
      let brake =
        Scenario.piecewise_constant 1
          ((float sample_every) *. tstep) max_t
      in Scenario.cross throttle brake
    let node = Params.node
  end

  module Phi1 = CCBench(ParamsPhi1)
  module Phi2 = CCBench(ParamsPhi2)
  module Phi3 = CCBench(ParamsPhi3)
  module Phi4 = CCBench(ParamsPhi4)
  module Phi5 = CCBench(ParamsPhi5)
end

module WT =
struct
  let max_t = 630.
  let tstep = 0.01
  let h = 5.
  let bounds = [| 8., 16. |]

  module type Params =
  sig
    val index : int
    val node : (FadFloat.t array, float * FadFloat.t array * FadFloat.t) Ztypes.node
  end

  module ParamsPhi1 = struct
    let index = 1
    let node = Wt.wt_wt1 tstep
  end

  module ParamsPhi2 = struct
    let index = 2
    let node = Wt.wt_wt2 tstep
  end

  module ParamsPhi3 = struct
    let index = 3
    let node = Wt.wt_wt3 tstep
  end

  module ParamsPhi4 = struct
    let index = 4
    let node = Wt.wt_wt4 tstep
  end

  module WTBench (Params: Params) =
  struct
    let name = "wt" ^ (string_of_int Params.index)
    let prop_name = "WT" ^ (string_of_int Params.index)
    let max_t = max_t
    let sample_every = 500
    let tstep = tstep
    let bounds = bounds
    let scenario : FadFloat.t Scenario.t =
      Scenario.piecewise_constant 1
        ((float sample_every) *. tstep) max_t
    let node = Params.node
  end

  module Phi1 = WTBench(ParamsPhi1)
  module Phi2 = WTBench(ParamsPhi2)
  module Phi3 = WTBench(ParamsPhi3)
  module Phi4 = WTBench(ParamsPhi4)
end

module AFC =
struct
  let max_t = 50.
  let h = 5.
  let tstep = 5e-5
  let dim = truncate (ceil (max_t /. h))

  let bounds_normal_mode = [| 900., 1100.; 0., 61.1 |]
  let bounds_power_mode = [| 900., 1100.; 61.2, 81.2 |]

  module type Params =
  sig
    val index : int
    val bounds : (float * float) array
    val sample_every : int
    val node : (FadFloat.t array, float * FadFloat.t array * FadFloat.t) Ztypes.node
  end

  module ParamsPhi27 = struct
    let index = 27
    let bounds = bounds_normal_mode
    let sample_every = truncate (h /. tstep)
    let node = Afc.afc_afc1 tstep
  end

  module ParamsPhi29 = struct
    let index = 29
    let bounds = bounds_normal_mode
    let sample_every = truncate (h /. tstep)
    let node = Afc.afc_afc2 tstep
  end

  module ParamsPhi33 = struct
    let index = 33
    let bounds = bounds_power_mode
    let sample_every = truncate (h /. tstep)
    let node = Afc.afc_afc2 tstep
  end

  module AFCBench (Params: Params) =
  struct
    let name = "afc" ^ (string_of_int Params.index)
    let prop_name = "AFC" ^ (string_of_int Params.index)
    let max_t = max_t
    let tstep = tstep
    let sample_every = Params.sample_every
    let bounds = Params.bounds
    let scenario : FadFloat.t Scenario.t =
      let engine_speed = Scenario.constant 1 max_t in
      let throttle = Scenario.piecewise_constant 1
          ((float sample_every) *. tstep) max_t in
      Scenario.cross engine_speed throttle
    let node = Params.node
  end

  module Phi27 = AFCBench(ParamsPhi27)
  module Phi29 = AFCBench(ParamsPhi29)
  module Phi33 = AFCBench(ParamsPhi33)
end

module SC =
struct
  let max_t = 40.
  let online_bounds = [| 3.99, 4.01 |]

  module ParamsInst1 =
  struct
    let h = 0.2
    let instance = 1
  end

  module ParamsInst2 =
  struct
    let h = 2.
    let instance = 2
  end

  module SCBench (Params: sig
      val h : float
      val instance : int
    end) =
  struct

    let name = "sc_inst" ^ (string_of_int Params.instance)
    let prop_name = "SC_inst" ^ (string_of_int Params.instance)
    let tstep = 0.01
    let max_t = max_t
    let bounds = online_bounds
    let sample_every = truncate (Params.h /. tstep)
    let node = Sc.sc_sc1 tstep
  end

  module Phi_inst1 = SCBench(ParamsInst1)
  module Phi_inst2 = SCBench(ParamsInst2)
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
    val h : float
    val node : float -> (FadFloat.t array, float * FadFloat.t array * FadFloat.t) Ztypes.node
  end

  module ParamsInst1 : Params =
  struct
    let h = 3.
    let n_pieces = truncate (ceil (max_t /. h))
    let offline_bounds = Array.make n_pieces online_bounds.(0)
    let name = "nn_inst1"
    let prop_name = "NN_inst1"
    let node = Nn.nn_nn1
  end

  module ParamsInst2 : Params =
  struct
    let n_pieces = 3
    let h = max_t /. (float n_pieces)
    let offline_bounds = Array.make n_pieces online_bounds.(0)
    let name = "nn_inst2"
    let prop_name = "NN_inst2"
    let node = Nn.nn_nn1
  end

  module ParamsInst1_2 : Params =
  struct
    let h = 3.
    let n_pieces = truncate (ceil (max_t /. h))
    let offline_bounds = Array.make n_pieces online_bounds.(0)
    let name = "nn_inst1_0_04"
    let prop_name = "NN_inst1 (beta=0.04)"
    let node = Nn.nn_nn2
  end

  module ParamsInst2_2 : Params =
  struct
    let n_pieces = 3
    let h = max_t /. (float n_pieces)
    let offline_bounds = Array.make n_pieces online_bounds.(0)
    let name = "nn_inst2_0_04"
    let prop_name = "NN_inst2 (beta=0.04)"
    let node = Nn.nn_nn2
  end

  module NNBench (Params: Params) =
  struct

    let name = Params.name
    let prop_name = Params.prop_name
    let max_t = max_t
    let tstep = 0.001
    let sample_every = Params.h /. tstep
    let node = Params.node 0.001
  end

  module Phi1_inst1 = NNBench(ParamsInst1)
  module Phi1_inst2 = NNBench(ParamsInst2)
  module Phi2_inst1 = NNBench(ParamsInst1_2)
  module Phi2_inst2 = NNBench(ParamsInst2_2)
end
