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
    let sample_every = 500
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

module Test =
struct
  module D =
  struct
    let name = "VDP_D"
    let prop_name = "VDP"
    let max_t = 10.
    let tstep = 0.0001
    let sample_every = 0
    let bounds = [| 0., 5. |]
    let scenario : FadFloat.t Scenario.t = Scenario.constant 1 max_t
    let node = Vdp.vdp_d tstep max_t
  end

  module C =
  struct
    let name = "VDP_C"
    let prop_name = "VDP"
    let max_t = 10.
    let tstep = 0.1
    let sample_every = 0
    let bounds = [| 0., 5. |]
    let scenario : FadFloat.t Scenario.t = Scenario.constant 1 max_t
    let node = Vdp.vdp_c tstep max_t
  end
end