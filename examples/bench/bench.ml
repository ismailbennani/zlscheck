let systems : (string * (module Deftypes.SUT)) list = [
  "AT1_inst1", (module Defsut.Autotrans.Phi1_instance1);
  "AT2_inst1", (module Defsut.Autotrans.Phi2_instance1);
  "AT51_inst1", (module Defsut.Autotrans.Phi51_instance1);
  "AT52_inst1", (module Defsut.Autotrans.Phi52_instance1);
  "AT53_inst1", (module Defsut.Autotrans.Phi53_instance1);
  "AT54_inst1", (module Defsut.Autotrans.Phi54_instance1);
  "AT6a_inst1", (module Defsut.Autotrans.Phi6a_instance1);
  "AT6b_inst1", (module Defsut.Autotrans.Phi6b_instance1);
  "AT6c_inst1", (module Defsut.Autotrans.Phi6c_instance1);
  "AT1_inst2", (module Defsut.Autotrans.Phi1_instance2);
  "AT2_inst2", (module Defsut.Autotrans.Phi2_instance2);
  "AT51_inst2", (module Defsut.Autotrans.Phi51_instance2);
  "AT52_inst2", (module Defsut.Autotrans.Phi52_instance2);
  "AT53_inst2", (module Defsut.Autotrans.Phi53_instance2);
  "AT54_inst2", (module Defsut.Autotrans.Phi54_instance2);
  "AT6a_inst2", (module Defsut.Autotrans.Phi6a_instance2);
  "AT6b_inst2", (module Defsut.Autotrans.Phi6b_instance2);
  "AT6c_inst2", (module Defsut.Autotrans.Phi6c_instance2);
  "WT1", (module Defsut.WT.Phi1);
  "WT2", (module Defsut.WT.Phi2);
  "WT3", (module Defsut.WT.Phi3);
  "WT4", (module Defsut.WT.Phi4);
  "AFC27", (module Defsut.AFC.Phi27);
  "AFC29", (module Defsut.AFC.Phi29);
  "AFC33", (module Defsut.AFC.Phi33);
  "CC1", (module Defsut.CC.Phi1);
  "CC2", (module Defsut.CC.Phi2);
  "CC3", (module Defsut.CC.Phi3);
  "CC4", (module Defsut.CC.Phi4);
  "CC5", (module Defsut.CC.Phi5);
]

let _ =
  Smac_wrapper.main systems
