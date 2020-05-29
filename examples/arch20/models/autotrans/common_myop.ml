(* The Zélus compiler, version 2.0
  (lundi 25 mai 2020, 14:33:03 (UTC+0200)) *)
open Ztypes
open MyOp
type shift = UP | DOWN 
let pi = ( *. ) 4.  (Stdlib.atan 1.)

let iei = 0.0219914882836

let engine_feedback_gain = (/.) 1.  iei

let p_final_drive_ratio = 3.23

let p_drag_friction = 40.

let p_aerodynamic_drag = 0.02

let p_wheel_radius = 1.

let p_vehicle_inertia = 12.0941478573

let iv_inv = (/.) 1.  p_vehicle_inertia

let p_initial_transmission_out_speed = ( *. ) ((/.) 0.  p_wheel_radius) 
                                              p_final_drive_ratio

let initial_speed = 0.

let p_mph = (/.) 60.  5280.

let l_speed_coef = ( *. ) (( *. ) 2.  pi)  p_wheel_radius

let p_initial_wheel_speed = (/.) ((/.) initial_speed  p_mph)  l_speed_coef

let twait = 0.08

let lookup_engine ((l_73:MyOp.t) , (c_72:MyOp.t)) =
  Utils.lookup2D (Consts.line_engine , Consts.col_engine , Consts.vals_engine)
                  (l_73 , c_72)

let lookup_interpup ((l_75:MyOp.t) , (c_74:MyOp.t)) =
  Utils.lookup2D (Consts.line_interpup ,
                  Consts.col_interpup , Consts.vals_interpup)  (l_75 , c_74)

let lookup_interpdn ((l_77:MyOp.t) , (c_76:MyOp.t)) =
  Utils.lookup2D (Consts.line_interpdn ,
                  Consts.col_interpdn , Consts.vals_interpdn)  (l_77 , c_76)

let lookup_factork (l_78:MyOp.t) =
  Utils.lookup1D (Consts.line_factork , Consts.vals_factork)  l_78

let lookup_torkratio (l_79:MyOp.t) =
  Utils.lookup1D (Consts.line_torkratio , Consts.vals_torkratio)  l_79

let lookup_gear (l_80:MyOp.t) =
  Utils.lookup1D (Consts.line_gear , Consts.vals_gear)  l_80

let torque_converter ((ne_81:MyOp.t) , (nin_82:MyOp.t)) =
  let (speedratio_86:MyOp.t) = MyOp.(/) nin_82  ne_81 in
  let (factorK_83:MyOp.t) = lookup_factork speedratio_86 in
  let (quotient_85:MyOp.t) = MyOp.(/) ne_81  factorK_83 in
  let (impeller_84:MyOp.t) = MyOp.( * ) quotient_85  quotient_85 in
  let (torqueratio_88:MyOp.t) = lookup_torkratio speedratio_86 in
  let (turbine_90:MyOp.t) = MyOp.( * ) impeller_84  torqueratio_88 in
  (impeller_84 , turbine_90)

let transmissionratio ((tin_93:MyOp.t) , (gear_91:MyOp.t) , (nout_92:MyOp.t)) =
  let (gear_lookup_94:MyOp.t) = lookup_gear gear_91 in
  let (tout_96:MyOp.t) = MyOp.( * ) tin_93  gear_lookup_94 in
  let (nin_95:MyOp.t) = MyOp.( * ) nout_92  gear_lookup_94 in
  (tout_96 , nin_95)

let transmission ((ne_98:MyOp.t) , (gear_97:MyOp.t) , (nout_99:MyOp.t)) =
  let (gear_lookup_107:MyOp.t) = lookup_gear gear_97 in
  let (nin_108:MyOp.t) = MyOp.( * ) nout_99  gear_lookup_107 in
  let ((ti_101:MyOp.t) , (turbine_torque_103:MyOp.t)) =
      torque_converter (ne_98 , nin_108) in
  let (tout_109:MyOp.t) = MyOp.( * ) turbine_torque_103  gear_lookup_107 in
  (ti_101 , tout_109)

