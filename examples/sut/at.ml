(* The Zélus compiler, version 2.1
  (vendredi 25 septembre 2020, 18:02:26 (UTC+0200)) *)
open Ztypes
type state__9136 =
At_UpShifting_855 | At_DownShifting_854 | At_SteadyState_853 
type state__9135 =
At_Fourth_852 | At_Third_851 | At_Second_850 | At_First_849 
type state__9134 =
At_UpShifting_782 | At_DownShifting_781 | At_SteadyState_780 
type state__9133 =
At_Fourth_779 | At_Third_778 | At_Second_777 | At_First_776 
type state__9132 =
At_UpShifting_709 | At_DownShifting_708 | At_SteadyState_707 
type state__9131 =
At_Fourth_706 | At_Third_705 | At_Second_704 | At_First_703 
type state__9130 =
At_UpShifting_636 | At_DownShifting_635 | At_SteadyState_634 
type state__9129 =
At_Fourth_633 | At_Third_632 | At_Second_631 | At_First_630 
type state__9128 =
At_UpShifting_561 | At_DownShifting_560 | At_SteadyState_559 
type state__9127 =
At_Fourth_558 | At_Third_557 | At_Second_556 | At_First_555 
type state__9126 =
At_UpShifting_486 | At_DownShifting_485 | At_SteadyState_484 
type state__9125 =
At_Fourth_483 | At_Third_482 | At_Second_481 | At_First_480 
type state__9124 =
At_UpShifting_411 | At_DownShifting_410 | At_SteadyState_409 
type state__9123 =
At_Fourth_408 | At_Third_407 | At_Second_406 | At_First_405 
type state__9122 =
At_UpShifting_336 | At_DownShifting_335 | At_SteadyState_334 
type state__9121 =
At_Fourth_333 | At_Third_332 | At_Second_331 | At_First_330 
type state__9120 =
At_UpShifting_263 | At_DownShifting_262 | At_SteadyState_261 
type state__9119 =
At_Fourth_260 | At_Third_259 | At_Second_258 | At_First_257 
open FadFloat
open Discrete_obs_fad
type ('a) _at1 =
  { mutable i_2105 : 'a }

let at1  = 
  let Node { alloc = i_2105_alloc; step = i_2105_step ; reset = i_2105_reset } = 
  Discrete_obs_fad.always_timed 20.  in
  let at1_alloc _ =
    ();{ i_2105 = i_2105_alloc () (* discrete *)  } in
  let at1_reset self  =
    (i_2105_reset self.i_2105 :unit) in 
  let at1_step self ((tstep_1176:FadFloat.t) ,
                     (outp_1175:(FadFloat.t)Array.t)) =
    ((let (speed_1177:FadFloat.t) = Array.get outp_1175  2 in
      i_2105_step self.i_2105
        (tstep_1176 ,
         (Discrete_obs_fad.q_lt (speed_1177 , (FadFloat.make 120.))))):
    FadFloat.t) in
  Node { alloc = at1_alloc; reset = at1_reset ; step = at1_step }
type ('a) _at2 =
  { mutable i_2106 : 'a }

let at2  = 
  let Node { alloc = i_2106_alloc; step = i_2106_step ; reset = i_2106_reset } = 
  Discrete_obs_fad.always_timed 10.  in
  let at2_alloc _ =
    ();{ i_2106 = i_2106_alloc () (* discrete *)  } in
  let at2_reset self  =
    (i_2106_reset self.i_2106 :unit) in 
  let at2_step self ((tstep_1179:FadFloat.t) ,
                     (outp_1178:(FadFloat.t)Array.t)) =
    ((let (rpm_1180:FadFloat.t) = Array.get outp_1178  0 in
      i_2106_step self.i_2106
        (tstep_1179 ,
         (Discrete_obs_fad.q_lt (rpm_1180 , (FadFloat.make 4750.))))):
    FadFloat.t) in
  Node { alloc = at2_alloc; reset = at2_reset ; step = at2_step }
type ('e , 'd , 'c , 'b , 'a) _at5 =
  { mutable i_2109 : 'e ;
    mutable i_2108 : 'd ;
    mutable i_2107 : 'c ; mutable i_1189 : 'b ; mutable m_1187 : 'a }

let at5 (geari_1181:float) = 
  let Node { alloc = i_2109_alloc; step = i_2109_step ; reset = i_2109_reset } = Discrete_obs_fad.q_up 
   in 
  let Node { alloc = i_2108_alloc; step = i_2108_step ; reset = i_2108_reset } = 
  Discrete_obs_fad.always_timed 30.  in 
  let Node { alloc = i_2107_alloc; step = i_2107_step ; reset = i_2107_reset } = 
  Discrete_obs_fad.alwaysBfromA_timed 2.5  in
  let at5_alloc _ =
    ();
    { i_1189 = (false:bool) ; m_1187 = (create ():FadFloat.t);
      i_2109 = i_2109_alloc () (* discrete *)  ;
      i_2108 = i_2108_alloc () (* discrete *)  ;
      i_2107 = i_2107_alloc () (* discrete *)  } in
  let at5_reset self  =
    ((self.i_1189 <- true ;
      i_2109_reset self.i_2109  ;
      i_2108_reset self.i_2108  ; i_2107_reset self.i_2107 ):unit) in 
  let at5_step self ((tstep_1183:FadFloat.t) ,
                     (outp_1182:(FadFloat.t)Array.t)) =
    (((if self.i_1189 then self.m_1187 <- Discrete_obs_fad.q_true) ;
      self.i_1189 <- false ;
      (let (x_1188:FadFloat.t) = self.m_1187 in
       self.m_1187 <- Discrete_obs_fad.q_false ;
       (let (gear_1184:FadFloat.t) = Array.get outp_1182  1 in
        let (switch_1186:FadFloat.t) =
            Discrete_obs_fad.q_and ((Discrete_obs_fad.q_not x_1188) ,
                                    (i_2109_step self.i_2109
                                       (Discrete_obs_fad.q_eqi (gear_1184 ,
                                                                (FadFloat.make 
                                                                   geari_1181))))) in
        i_2108_step self.i_2108
          (tstep_1183 ,
           (i_2107_step self.i_2107
              (tstep_1183 ,
               switch_1186 ,
               (Discrete_obs_fad.q_eqi (gear_1184 ,
                                        (FadFloat.make geari_1181))))))))):
    FadFloat.t) in
  Node { alloc = at5_alloc; reset = at5_reset ; step = at5_step }
type ('a) _at51 =
  { mutable i_2110 : 'a }

let at51  = 
  let Node { alloc = i_2110_alloc; step = i_2110_step ; reset = i_2110_reset } = 
  at5 1.  in
  let at51_alloc _ =
    ();{ i_2110 = i_2110_alloc () (* discrete *)  } in
  let at51_reset self  =
    (i_2110_reset self.i_2110 :unit) in 
  let at51_step self ((tstep_1191:FadFloat.t) ,
                      (outp_1190:(FadFloat.t)Array.t)) =
    (i_2110_step self.i_2110 (tstep_1191 , outp_1190):FadFloat.t) in
  Node { alloc = at51_alloc; reset = at51_reset ; step = at51_step }
type ('a) _at52 =
  { mutable i_2111 : 'a }

let at52  = 
  let Node { alloc = i_2111_alloc; step = i_2111_step ; reset = i_2111_reset } = 
  at5 2.  in
  let at52_alloc _ =
    ();{ i_2111 = i_2111_alloc () (* discrete *)  } in
  let at52_reset self  =
    (i_2111_reset self.i_2111 :unit) in 
  let at52_step self ((tstep_1193:FadFloat.t) ,
                      (outp_1192:(FadFloat.t)Array.t)) =
    (i_2111_step self.i_2111 (tstep_1193 , outp_1192):FadFloat.t) in
  Node { alloc = at52_alloc; reset = at52_reset ; step = at52_step }
type ('a) _at53 =
  { mutable i_2112 : 'a }

let at53  = 
  let Node { alloc = i_2112_alloc; step = i_2112_step ; reset = i_2112_reset } = 
  at5 3.  in
  let at53_alloc _ =
    ();{ i_2112 = i_2112_alloc () (* discrete *)  } in
  let at53_reset self  =
    (i_2112_reset self.i_2112 :unit) in 
  let at53_step self ((tstep_1195:FadFloat.t) ,
                      (outp_1194:(FadFloat.t)Array.t)) =
    (i_2112_step self.i_2112 (tstep_1195 , outp_1194):FadFloat.t) in
  Node { alloc = at53_alloc; reset = at53_reset ; step = at53_step }
type ('a) _at54 =
  { mutable i_2113 : 'a }

let at54  = 
  let Node { alloc = i_2113_alloc; step = i_2113_step ; reset = i_2113_reset } = 
  at5 4.  in
  let at54_alloc _ =
    ();{ i_2113 = i_2113_alloc () (* discrete *)  } in
  let at54_reset self  =
    (i_2113_reset self.i_2113 :unit) in 
  let at54_step self ((tstep_1197:FadFloat.t) ,
                      (outp_1196:(FadFloat.t)Array.t)) =
    (i_2113_step self.i_2113 (tstep_1197 , outp_1196):FadFloat.t) in
  Node { alloc = at54_alloc; reset = at54_reset ; step = at54_step }
type ('b , 'a) _at6 =
  { mutable i_2115 : 'b ; mutable i_2114 : 'a }

let at6 (tstep_1201:FadFloat.t)  ((t_1200:float) , (s_1199:float)) = 
  let Node { alloc = i_2115_alloc; step = i_2115_step ; reset = i_2115_reset } = 
  Discrete_obs_fad.always_timed t_1200  in 
  let Node { alloc = i_2114_alloc; step = i_2114_step ; reset = i_2114_reset } = 
  Discrete_obs_fad.once_timed 30.  in
  let at6_alloc _ =
    ();
    { i_2115 = i_2115_alloc () (* discrete *)  ;
      i_2114 = i_2114_alloc () (* discrete *)  } in
  let at6_reset self  =
    ((i_2115_reset self.i_2115  ; i_2114_reset self.i_2114 ):unit) in 
  let at6_step self (outp_1198:(FadFloat.t)Array.t) =
    ((let (rpm_1202:FadFloat.t) = Array.get outp_1198  0 in
      let (speed_1203:FadFloat.t) = Array.get outp_1198  2 in
      let (rpm_max_1204:FadFloat.t) = FadFloat.make 3000. in
      let (speed_max_1205:FadFloat.t) = FadFloat.make s_1199 in
      Discrete_obs_fad.q_or ((i_2114_step self.i_2114
                                (tstep_1201 ,
                                 (Discrete_obs_fad.q_gt (rpm_1202 ,
                                                         rpm_max_1204)))) ,
                             (i_2115_step self.i_2115
                                (tstep_1201 ,
                                 (Discrete_obs_fad.q_lt (speed_1203 ,
                                                         speed_max_1205)))))):
    FadFloat.t) in
  Node { alloc = at6_alloc; reset = at6_reset ; step = at6_step }
type ('b , 'a) _at6a =
  { mutable i_2117 : 'b ; mutable i_2116 : 'a }

let at6a  = 
  let Node { alloc = i_2117_alloc; step = i_2117_step ; reset = i_2117_reset } = 
  Discrete_obs_fad.always_timed 3.99  in 
  let Node { alloc = i_2116_alloc; step = i_2116_step ; reset = i_2116_reset } = 
  Discrete_obs_fad.once_timed 30.  in
  let at6a_alloc _ =
    ();
    { i_2117 = i_2117_alloc () (* discrete *)  ;
      i_2116 = i_2116_alloc () (* discrete *)  } in
  let at6a_reset self  =
    ((i_2117_reset self.i_2117  ; i_2116_reset self.i_2116 ):unit) in 
  let at6a_step self ((tstep_1207:FadFloat.t) ,
                      (outp_1206:(FadFloat.t)Array.t)) =
    ((let (rpm_1208:FadFloat.t) = Array.get outp_1206  0 in
      let (speed_1209:FadFloat.t) = Array.get outp_1206  2 in
      let (rpm_max_1210:FadFloat.t) = FadFloat.make 3000. in
      let (speed_max_1211:FadFloat.t) = FadFloat.make 35. in
      Discrete_obs_fad.q_or ((i_2116_step self.i_2116
                                (tstep_1207 ,
                                 (Discrete_obs_fad.q_gt (rpm_1208 ,
                                                         rpm_max_1210)))) ,
                             (i_2117_step self.i_2117
                                (tstep_1207 ,
                                 (Discrete_obs_fad.q_lt (speed_1209 ,
                                                         speed_max_1211)))))):
    FadFloat.t) in
  Node { alloc = at6a_alloc; reset = at6a_reset ; step = at6a_step }
type ('b , 'a) _at6b =
  { mutable i_2119 : 'b ; mutable i_2118 : 'a }

let at6b  = 
  let Node { alloc = i_2119_alloc; step = i_2119_step ; reset = i_2119_reset } = 
  Discrete_obs_fad.always_timed 7.99  in 
  let Node { alloc = i_2118_alloc; step = i_2118_step ; reset = i_2118_reset } = 
  Discrete_obs_fad.once_timed 30.  in
  let at6b_alloc _ =
    ();
    { i_2119 = i_2119_alloc () (* discrete *)  ;
      i_2118 = i_2118_alloc () (* discrete *)  } in
  let at6b_reset self  =
    ((i_2119_reset self.i_2119  ; i_2118_reset self.i_2118 ):unit) in 
  let at6b_step self ((tstep_1213:FadFloat.t) ,
                      (outp_1212:(FadFloat.t)Array.t)) =
    ((let (rpm_1214:FadFloat.t) =
          FadFloat.(/) (Array.get outp_1212  0)  (FadFloat.make 5000.) in
      let (speed_1215:FadFloat.t) =
          FadFloat.(/) (Array.get outp_1212  2)  (FadFloat.make 120.) in
      let (rpm_max_1216:FadFloat.t) = FadFloat.make ((/.) 3000.  5000.) in
      let (speed_max_1217:FadFloat.t) = FadFloat.make ((/.) 50.  120.) in
      Discrete_obs_fad.q_or ((i_2118_step self.i_2118
                                (tstep_1213 ,
                                 (Discrete_obs_fad.q_gt (rpm_1214 ,
                                                         rpm_max_1216)))) ,
                             (i_2119_step self.i_2119
                                (tstep_1213 ,
                                 (Discrete_obs_fad.q_lt (speed_1215 ,
                                                         speed_max_1217)))))):
    FadFloat.t) in
  Node { alloc = at6b_alloc; reset = at6b_reset ; step = at6b_step }
type ('b , 'a) _at6c =
  { mutable i_2121 : 'b ; mutable i_2120 : 'a }

let at6c  = 
  let Node { alloc = i_2121_alloc; step = i_2121_step ; reset = i_2121_reset } = 
  Discrete_obs_fad.always_timed 19.99  in 
  let Node { alloc = i_2120_alloc; step = i_2120_step ; reset = i_2120_reset } = 
  Discrete_obs_fad.once_timed 30.  in
  let at6c_alloc _ =
    ();
    { i_2121 = i_2121_alloc () (* discrete *)  ;
      i_2120 = i_2120_alloc () (* discrete *)  } in
  let at6c_reset self  =
    ((i_2121_reset self.i_2121  ; i_2120_reset self.i_2120 ):unit) in 
  let at6c_step self ((tstep_1219:FadFloat.t) ,
                      (outp_1218:(FadFloat.t)Array.t)) =
    ((let (rpm_1220:FadFloat.t) =
          FadFloat.(/) (Array.get outp_1218  0)  (FadFloat.make 5000.) in
      let (speed_1221:FadFloat.t) =
          FadFloat.(/) (Array.get outp_1218  2)  (FadFloat.make 120.) in
      let (rpm_max_1222:FadFloat.t) = FadFloat.make ((/.) 3000.  5000.) in
      let (speed_max_1223:FadFloat.t) = FadFloat.make ((/.) 65.  120.) in
      Discrete_obs_fad.q_or ((i_2120_step self.i_2120
                                (tstep_1219 ,
                                 (Discrete_obs_fad.q_gt (rpm_1220 ,
                                                         rpm_max_1222)))) ,
                             (i_2121_step self.i_2121
                                (tstep_1219 ,
                                 (Discrete_obs_fad.q_lt (speed_1221 ,
                                                         speed_max_1223)))))):
    FadFloat.t) in
  Node { alloc = at6c_alloc; reset = at6c_reset ; step = at6c_step }
type ('s ,
      'r ,
      'q ,
      'p ,
      'o ,
      'n , 'm , 'l , 'k , 'j , 'i , 'h , 'g , 'f , 'e , 'd , 'c , 'b , 'a) _autotrans_at1 =
  { mutable i_2122 : 's ;
    mutable i_1318 : 'r ;
    mutable m_1315 : 'q ;
    mutable m_1313 : 'p ;
    mutable m_1310 : 'o ;
    mutable m_1308 : 'n ;
    mutable nx_1307 : 'm ;
    mutable m_1305 : 'l ;
    mutable m_1302 : 'k ;
    mutable m_1297 : 'j ;
    mutable m_1295 : 'i ;
    mutable r_1290 : 'h ;
    mutable s_1289 : 'g ;
    mutable r_1288 : 'f ;
    mutable s_1287 : 'e ;
    mutable t0_1270 : 'd ;
    mutable t0_1269 : 'c ; mutable i_1320 : 'b ; mutable go_up_1319 : 'a }

let autotrans_at1 (tstep_1225:float) = 
  let Node { alloc = i_2122_alloc; step = i_2122_step ; reset = i_2122_reset } = at1 
   in
  let autotrans_at1_alloc _ =
    ();
    { i_1318 = (false:bool) ;
      m_1315 = (create ():FadFloat.t) ;
      m_1313 = (create ():FadFloat.t) ;
      m_1310 = (create ():FadFloat.t) ;
      m_1308 = (create ():FadFloat.t) ;
      nx_1307 = (create ():FadFloat.t) ;
      m_1305 = (create ():FadFloat.t) ;
      m_1302 = (create ():FadFloat.t) ;
      m_1297 = (create ():FadFloat.t) ;
      m_1295 = (create ():FadFloat.t) ;
      r_1290 = (false:bool) ;
      s_1289 = (At_UpShifting_263:state__9120) ;
      r_1288 = (false:bool) ;
      s_1287 = (At_Fourth_260:state__9119) ;
      t0_1270 = (create ():FadFloat.t) ;
      t0_1269 = (create ():FadFloat.t) ;
      i_1320 = (false:bool) ; go_up_1319 = (false:bool);
      i_2122 = i_2122_alloc () (* discrete *)  } in
  let autotrans_at1_reset self  =
    ((self.i_1318 <- true ;
      i_2122_reset self.i_2122  ;
      self.r_1290 <- false ;
      self.s_1289 <- At_SteadyState_261 ;
      self.i_1320 <- true ;
      self.r_1288 <- false ; self.s_1287 <- At_First_257):unit) in 
  let autotrans_at1_step self (inp_1224:(FadFloat.t)Array.t) =
    ((let shiftp_1292 = ref (false:bool) in
      let shiftv_1291 = ref (At_common.DOWN:At_common.shift) in
      let (final_drive_ratio_1276:FadFloat.t) =
          FadFloat.scale self.m_1308  At_common.p_final_drive_ratio in
      let (aux1_1274:FadFloat.t) =
          FadFloat.(-) final_drive_ratio_1276  self.m_1313 in
      let (vehicle_inertia_1285:FadFloat.t) =
          FadFloat.scale aux1_1274  At_common.iv_inv in
      (if self.i_1318 then self.m_1297 <- FadFloat.make 0.) ;
      (let (x_1298:FadFloat.t) = self.m_1297 in
       let (x_1312:FadFloat.t) =
           if self.i_1318 then x_1298 else FadFloat.(-) x_1298  self.m_1310 in
       let (x_1317:FadFloat.t) =
           if self.i_1318
           then FadFloat.make At_common.p_initial_wheel_speed
           else
             FadFloat.(+) self.m_1315 
                          (FadFloat.( * ) vehicle_inertia_1285  x_1312) in
       (if self.i_1318 then self.nx_1307 <- Autotransd.gear1) ;
       (let (x0_1255:FadFloat.t) = FadFloat.make 1000. in
        (if self.i_1318 then self.m_1305 <- x0_1255) ;
        (let (x_1304:FadFloat.t) =
             if self.i_1318 then x_1298 else FadFloat.(-) x_1298  self.m_1302 in
         let (tstep'_1235:FadFloat.t) = FadFloat.make tstep_1225 in
         (if self.i_1318 then self.m_1295 <- tstep'_1235) ;
         self.i_1318 <- false ;
         (let (xmin_1257:FadFloat.t) = FadFloat.make 600. in
          let (xmax_1256:FadFloat.t) = FadFloat.make 6000. in
          let (x_1306:FadFloat.t) = self.m_1305 in
          let (x_1260:FadFloat.t) =
              FadFloat.max xmin_1257  (FadFloat.min xmax_1256  x_1306) in
          let (gear_1268:FadFloat.t) = self.nx_1307 in
          let (linear_speed_1277:FadFloat.t) =
              FadFloat.scale x_1317  At_common.l_speed_coef in
          let (mph_1278:FadFloat.t) =
              FadFloat.scale linear_speed_1277  At_common.p_mph in
          let (outp_1229:(FadFloat.t)Array.t) =
              Array.of_list ((::) (x_1260 ,
                                   ((::) (gear_1268 ,
                                          ((::) (mph_1278 , ([]))))))) in
          let (rob_1230:FadFloat.t) =
              i_2122_step self.i_2122 (tstep'_1235 , outp_1229) in
          let (trans_rpm_1284:FadFloat.t) =
              FadFloat.scale x_1317  At_common.p_final_drive_ratio in
          let ((ti_1244:FadFloat.t) , (out_torque_1240:FadFloat.t)) =
              At_common.transmission (x_1260 , gear_1268 , trans_rpm_1284) in
          self.m_1308 <- out_torque_1240 ;
          self.m_1315 <- x_1317 ;
          (let (brake_1226:FadFloat.t) = Array.get inp_1224  1 in
           let (road_load_1279:FadFloat.t) =
               FadFloat.translate (FadFloat.scale (FadFloat.sqr mph_1278) 
                                                  At_common.p_aerodynamic_drag)
                                   At_common.p_drag_friction in
           let (brake_1275:FadFloat.t) =
               FadFloat.(+) brake_1226  road_load_1279 in
           let (sgn_1280:FadFloat.t) =
               if (>=) mph_1278  (FadFloat.make 0.)
               then FadFloat.make 1.
               else FadFloat.make (-1.) in
           let (signed_load_1281:FadFloat.t) =
               FadFloat.( * ) sgn_1280  brake_1275 in
           self.m_1313 <- signed_load_1281 ;
           self.m_1310 <- x_1298 ;
           (let (throttle_1234:FadFloat.t) = Array.get inp_1224  0 in
            let (dn_th_1264:FadFloat.t) =
                At_common.lookup_interpdn (throttle_1234 , gear_1268) in
            let (up_th_1267:FadFloat.t) =
                At_common.lookup_interpup (throttle_1234 , gear_1268) in
            (begin match self.s_1289 with
                   | At_SteadyState_261 ->
                       (if self.r_1290 then self.i_1320 <- true) ;
                       (if self.i_1320 then
                        self.go_up_1319 <- (>) (FadFloat.make (Random.float 
                                                                 1.)) 
                                               (FadFloat.make 0.5)) ;
                       self.i_1320 <- false ;
                       (begin match (((>) mph_1278  up_th_1267) ,
                                     ((<) mph_1278  dn_th_1264)) with
                              | (_ , true) ->
                                  self.t0_1269 <- x_1298 ;
                                  self.r_1290 <- true ;
                                  self.s_1289 <- At_DownShifting_262
                              | (true , _) ->
                                  self.t0_1270 <- x_1298 ;
                                  self.r_1290 <- true ;
                                  self.s_1289 <- At_UpShifting_263
                              | _ -> self.r_1290 <- false  end)
                   | At_DownShifting_262 ->
                       (if self.r_1290 then ()) ;
                       (begin match (((>) x_1298 
                                          (FadFloat.translate self.t0_1269 
                                                              At_common.twait))
                                     , ((>) mph_1278  dn_th_1264)) with
                              | (_ , true) ->
                                  self.r_1290 <- true ;
                                  self.s_1289 <- At_SteadyState_261
                              | (true , _) ->
                                  shiftp_1292 := true ;
                                  shiftv_1291 := At_common.DOWN ;
                                  self.r_1290 <- true ;
                                  self.s_1289 <- At_SteadyState_261
                              | _ -> self.r_1290 <- false  end)
                   | At_UpShifting_263 ->
                       (if self.r_1290 then ()) ;
                       (begin match (((>) x_1298 
                                          (FadFloat.translate self.t0_1270 
                                                              At_common.twait))
                                     , ((<) mph_1278  up_th_1267)) with
                              | (_ , true) ->
                                  self.r_1290 <- true ;
                                  self.s_1289 <- At_SteadyState_261
                              | (true , _) ->
                                  shiftp_1292 := true ;
                                  shiftv_1291 := At_common.UP ;
                                  self.r_1290 <- true ;
                                  self.s_1289 <- At_SteadyState_261
                              | _ -> self.r_1290 <- false  end)
                    end) ;
            (begin match self.s_1287 with
                   | At_First_257 ->
                       (if self.r_1288 then ()) ;
                       (begin match (!shiftv_1291 , !shiftp_1292) with
                              | (At_common.UP , true) ->
                                  self.nx_1307 <- Autotransd.gear2 ;
                                  self.r_1288 <- true ;
                                  self.s_1287 <- At_Second_258
                              | _ -> self.r_1288 <- false  end)
                   | At_Second_258 ->
                       (if self.r_1288 then ()) ;
                       (begin match (!shiftv_1291 , !shiftp_1292) with
                              | (At_common.DOWN , true) ->
                                  self.nx_1307 <- Autotransd.gear1 ;
                                  self.r_1288 <- true ;
                                  self.s_1287 <- At_First_257
                              | (At_common.UP , true) ->
                                  self.nx_1307 <- Autotransd.gear3 ;
                                  self.r_1288 <- true ;
                                  self.s_1287 <- At_Third_259
                              | _ -> self.r_1288 <- false  end)
                   | At_Third_259 ->
                       (if self.r_1288 then ()) ;
                       (begin match (!shiftv_1291 , !shiftp_1292) with
                              | (At_common.DOWN , true) ->
                                  self.nx_1307 <- Autotransd.gear2 ;
                                  self.r_1288 <- true ;
                                  self.s_1287 <- At_Second_258
                              | (At_common.UP , true) ->
                                  self.nx_1307 <- Autotransd.gear4 ;
                                  self.r_1288 <- true ;
                                  self.s_1287 <- At_Fourth_260
                              | _ -> self.r_1288 <- false  end)
                   | At_Fourth_260 ->
                       (if self.r_1288 then ()) ;
                       (begin match (!shiftv_1291 , !shiftp_1292) with
                              | (At_common.DOWN , true) ->
                                  self.nx_1307 <- Autotransd.gear3 ;
                                  self.r_1288 <- true ;
                                  self.s_1287 <- At_Third_259
                              | _ -> self.r_1288 <- false  end)
                    end) ;
            (let (te_1251:FadFloat.t) =
                 At_common.lookup_engine (throttle_1234 , x_1260) in
             let (drpm_1249:FadFloat.t) = FadFloat.(-) te_1251  ti_1244 in
             let (dx_1253:FadFloat.t) =
                 FadFloat.scale drpm_1249  At_common.engine_feedback_gain in
             self.m_1305 <- FadFloat.(+) x_1260 
                                         (FadFloat.( * ) dx_1253  x_1304) ;
             self.m_1302 <- x_1298 ;
             (let (x_1296:FadFloat.t) = self.m_1295 in
              self.m_1297 <- x_1296 ;
              self.m_1295 <- FadFloat.(+) x_1296  tstep'_1235 ;
              ((FadFloat.get x_1296) , outp_1229 , rob_1230)))))))))):
    float * FadFloat.t Array.t * FadFloat.t) in
  Node { alloc = autotrans_at1_alloc; reset = autotrans_at1_reset ;
                                      step = autotrans_at1_step }
type ('s ,
      'r ,
      'q ,
      'p ,
      'o ,
      'n , 'm , 'l , 'k , 'j , 'i , 'h , 'g , 'f , 'e , 'd , 'c , 'b , 'a) _autotrans_at2 =
  { mutable i_2123 : 's ;
    mutable i_1415 : 'r ;
    mutable m_1412 : 'q ;
    mutable m_1410 : 'p ;
    mutable m_1407 : 'o ;
    mutable m_1405 : 'n ;
    mutable nx_1404 : 'm ;
    mutable m_1402 : 'l ;
    mutable m_1399 : 'k ;
    mutable m_1394 : 'j ;
    mutable m_1392 : 'i ;
    mutable r_1387 : 'h ;
    mutable s_1386 : 'g ;
    mutable r_1385 : 'f ;
    mutable s_1384 : 'e ;
    mutable t0_1367 : 'd ;
    mutable t0_1366 : 'c ; mutable i_1417 : 'b ; mutable go_up_1416 : 'a }

let autotrans_at2 (tstep_1322:float) = 
  let Node { alloc = i_2123_alloc; step = i_2123_step ; reset = i_2123_reset } = at2 
   in
  let autotrans_at2_alloc _ =
    ();
    { i_1415 = (false:bool) ;
      m_1412 = (create ():FadFloat.t) ;
      m_1410 = (create ():FadFloat.t) ;
      m_1407 = (create ():FadFloat.t) ;
      m_1405 = (create ():FadFloat.t) ;
      nx_1404 = (create ():FadFloat.t) ;
      m_1402 = (create ():FadFloat.t) ;
      m_1399 = (create ():FadFloat.t) ;
      m_1394 = (create ():FadFloat.t) ;
      m_1392 = (create ():FadFloat.t) ;
      r_1387 = (false:bool) ;
      s_1386 = (At_UpShifting_336:state__9122) ;
      r_1385 = (false:bool) ;
      s_1384 = (At_Fourth_333:state__9121) ;
      t0_1367 = (create ():FadFloat.t) ;
      t0_1366 = (create ():FadFloat.t) ;
      i_1417 = (false:bool) ; go_up_1416 = (false:bool);
      i_2123 = i_2123_alloc () (* discrete *)  } in
  let autotrans_at2_reset self  =
    ((self.i_1415 <- true ;
      i_2123_reset self.i_2123  ;
      self.r_1387 <- false ;
      self.s_1386 <- At_SteadyState_334 ;
      self.i_1417 <- true ;
      self.r_1385 <- false ; self.s_1384 <- At_First_330):unit) in 
  let autotrans_at2_step self (inp_1321:(FadFloat.t)Array.t) =
    ((let shiftp_1389 = ref (false:bool) in
      let shiftv_1388 = ref (At_common.DOWN:At_common.shift) in
      let (final_drive_ratio_1373:FadFloat.t) =
          FadFloat.scale self.m_1405  At_common.p_final_drive_ratio in
      let (aux1_1371:FadFloat.t) =
          FadFloat.(-) final_drive_ratio_1373  self.m_1410 in
      let (vehicle_inertia_1382:FadFloat.t) =
          FadFloat.scale aux1_1371  At_common.iv_inv in
      (if self.i_1415 then self.m_1394 <- FadFloat.make 0.) ;
      (let (x_1395:FadFloat.t) = self.m_1394 in
       let (x_1409:FadFloat.t) =
           if self.i_1415 then x_1395 else FadFloat.(-) x_1395  self.m_1407 in
       let (x_1414:FadFloat.t) =
           if self.i_1415
           then FadFloat.make At_common.p_initial_wheel_speed
           else
             FadFloat.(+) self.m_1412 
                          (FadFloat.( * ) vehicle_inertia_1382  x_1409) in
       (if self.i_1415 then self.nx_1404 <- Autotransd.gear1) ;
       (let (x0_1352:FadFloat.t) = FadFloat.make 1000. in
        (if self.i_1415 then self.m_1402 <- x0_1352) ;
        (let (x_1401:FadFloat.t) =
             if self.i_1415 then x_1395 else FadFloat.(-) x_1395  self.m_1399 in
         let (tstep'_1332:FadFloat.t) = FadFloat.make tstep_1322 in
         (if self.i_1415 then self.m_1392 <- tstep'_1332) ;
         self.i_1415 <- false ;
         (let (xmin_1354:FadFloat.t) = FadFloat.make 600. in
          let (xmax_1353:FadFloat.t) = FadFloat.make 6000. in
          let (x_1403:FadFloat.t) = self.m_1402 in
          let (x_1357:FadFloat.t) =
              FadFloat.max xmin_1354  (FadFloat.min xmax_1353  x_1403) in
          let (gear_1365:FadFloat.t) = self.nx_1404 in
          let (linear_speed_1374:FadFloat.t) =
              FadFloat.scale x_1414  At_common.l_speed_coef in
          let (mph_1375:FadFloat.t) =
              FadFloat.scale linear_speed_1374  At_common.p_mph in
          let (outp_1326:(FadFloat.t)Array.t) =
              Array.of_list ((::) (x_1357 ,
                                   ((::) (gear_1365 ,
                                          ((::) (mph_1375 , ([]))))))) in
          let (rob_1327:FadFloat.t) =
              i_2123_step self.i_2123 (tstep'_1332 , outp_1326) in
          let (trans_rpm_1381:FadFloat.t) =
              FadFloat.scale x_1414  At_common.p_final_drive_ratio in
          let ((ti_1341:FadFloat.t) , (out_torque_1337:FadFloat.t)) =
              At_common.transmission (x_1357 , gear_1365 , trans_rpm_1381) in
          self.m_1405 <- out_torque_1337 ;
          self.m_1412 <- x_1414 ;
          (let (brake_1323:FadFloat.t) = Array.get inp_1321  1 in
           let (road_load_1376:FadFloat.t) =
               FadFloat.translate (FadFloat.scale (FadFloat.sqr mph_1375) 
                                                  At_common.p_aerodynamic_drag)
                                   At_common.p_drag_friction in
           let (brake_1372:FadFloat.t) =
               FadFloat.(+) brake_1323  road_load_1376 in
           let (sgn_1377:FadFloat.t) =
               if (>=) mph_1375  (FadFloat.make 0.)
               then FadFloat.make 1.
               else FadFloat.make (-1.) in
           let (signed_load_1378:FadFloat.t) =
               FadFloat.( * ) sgn_1377  brake_1372 in
           self.m_1410 <- signed_load_1378 ;
           self.m_1407 <- x_1395 ;
           (let (throttle_1331:FadFloat.t) = Array.get inp_1321  0 in
            let (dn_th_1361:FadFloat.t) =
                At_common.lookup_interpdn (throttle_1331 , gear_1365) in
            let (up_th_1364:FadFloat.t) =
                At_common.lookup_interpup (throttle_1331 , gear_1365) in
            (begin match self.s_1386 with
                   | At_SteadyState_334 ->
                       (if self.r_1387 then self.i_1417 <- true) ;
                       (if self.i_1417 then
                        self.go_up_1416 <- (>) (FadFloat.make (Random.float 
                                                                 1.)) 
                                               (FadFloat.make 0.5)) ;
                       self.i_1417 <- false ;
                       (begin match (((>) mph_1375  up_th_1364) ,
                                     ((<) mph_1375  dn_th_1361)) with
                              | (_ , true) ->
                                  self.t0_1366 <- x_1395 ;
                                  self.r_1387 <- true ;
                                  self.s_1386 <- At_DownShifting_335
                              | (true , _) ->
                                  self.t0_1367 <- x_1395 ;
                                  self.r_1387 <- true ;
                                  self.s_1386 <- At_UpShifting_336
                              | _ -> self.r_1387 <- false  end)
                   | At_DownShifting_335 ->
                       (if self.r_1387 then ()) ;
                       (begin match (((>) x_1395 
                                          (FadFloat.translate self.t0_1366 
                                                              At_common.twait))
                                     , ((>) mph_1375  dn_th_1361)) with
                              | (_ , true) ->
                                  self.r_1387 <- true ;
                                  self.s_1386 <- At_SteadyState_334
                              | (true , _) ->
                                  shiftp_1389 := true ;
                                  shiftv_1388 := At_common.DOWN ;
                                  self.r_1387 <- true ;
                                  self.s_1386 <- At_SteadyState_334
                              | _ -> self.r_1387 <- false  end)
                   | At_UpShifting_336 ->
                       (if self.r_1387 then ()) ;
                       (begin match (((>) x_1395 
                                          (FadFloat.translate self.t0_1367 
                                                              At_common.twait))
                                     , ((<) mph_1375  up_th_1364)) with
                              | (_ , true) ->
                                  self.r_1387 <- true ;
                                  self.s_1386 <- At_SteadyState_334
                              | (true , _) ->
                                  shiftp_1389 := true ;
                                  shiftv_1388 := At_common.UP ;
                                  self.r_1387 <- true ;
                                  self.s_1386 <- At_SteadyState_334
                              | _ -> self.r_1387 <- false  end)
                    end) ;
            (begin match self.s_1384 with
                   | At_First_330 ->
                       (if self.r_1385 then ()) ;
                       (begin match (!shiftv_1388 , !shiftp_1389) with
                              | (At_common.UP , true) ->
                                  self.nx_1404 <- Autotransd.gear2 ;
                                  self.r_1385 <- true ;
                                  self.s_1384 <- At_Second_331
                              | _ -> self.r_1385 <- false  end)
                   | At_Second_331 ->
                       (if self.r_1385 then ()) ;
                       (begin match (!shiftv_1388 , !shiftp_1389) with
                              | (At_common.DOWN , true) ->
                                  self.nx_1404 <- Autotransd.gear1 ;
                                  self.r_1385 <- true ;
                                  self.s_1384 <- At_First_330
                              | (At_common.UP , true) ->
                                  self.nx_1404 <- Autotransd.gear3 ;
                                  self.r_1385 <- true ;
                                  self.s_1384 <- At_Third_332
                              | _ -> self.r_1385 <- false  end)
                   | At_Third_332 ->
                       (if self.r_1385 then ()) ;
                       (begin match (!shiftv_1388 , !shiftp_1389) with
                              | (At_common.DOWN , true) ->
                                  self.nx_1404 <- Autotransd.gear2 ;
                                  self.r_1385 <- true ;
                                  self.s_1384 <- At_Second_331
                              | (At_common.UP , true) ->
                                  self.nx_1404 <- Autotransd.gear4 ;
                                  self.r_1385 <- true ;
                                  self.s_1384 <- At_Fourth_333
                              | _ -> self.r_1385 <- false  end)
                   | At_Fourth_333 ->
                       (if self.r_1385 then ()) ;
                       (begin match (!shiftv_1388 , !shiftp_1389) with
                              | (At_common.DOWN , true) ->
                                  self.nx_1404 <- Autotransd.gear3 ;
                                  self.r_1385 <- true ;
                                  self.s_1384 <- At_Third_332
                              | _ -> self.r_1385 <- false  end)
                    end) ;
            (let (te_1348:FadFloat.t) =
                 At_common.lookup_engine (throttle_1331 , x_1357) in
             let (drpm_1346:FadFloat.t) = FadFloat.(-) te_1348  ti_1341 in
             let (dx_1350:FadFloat.t) =
                 FadFloat.scale drpm_1346  At_common.engine_feedback_gain in
             self.m_1402 <- FadFloat.(+) x_1357 
                                         (FadFloat.( * ) dx_1350  x_1401) ;
             self.m_1399 <- x_1395 ;
             (let (x_1393:FadFloat.t) = self.m_1392 in
              self.m_1394 <- x_1393 ;
              self.m_1392 <- FadFloat.(+) x_1393  tstep'_1332 ;
              ((FadFloat.get x_1393) ,
               outp_1326 , (FadFloat.translate rob_1327  40.))))))))))):
    float * FadFloat.t Array.t * FadFloat.t) in
  Node { alloc = autotrans_at2_alloc; reset = autotrans_at2_reset ;
                                      step = autotrans_at2_step }
type ('t ,
      's ,
      'r ,
      'q ,
      'p ,
      'o ,
      'n , 'm , 'l , 'k , 'j , 'i , 'h , 'g , 'f , 'e , 'd , 'c , 'b , 'a) _autotrans_at51 =
  { mutable i_2124 : 't ;
    mutable i_1514 : 's ;
    mutable m_1511 : 'r ;
    mutable m_1509 : 'q ;
    mutable m_1506 : 'p ;
    mutable m_1504 : 'o ;
    mutable nx_1503 : 'n ;
    mutable m_1501 : 'm ;
    mutable m_1498 : 'l ;
    mutable m_1493 : 'k ;
    mutable m_1491 : 'j ;
    mutable r_1486 : 'i ;
    mutable s_1485 : 'h ;
    mutable r_1484 : 'g ;
    mutable s_1483 : 'f ;
    mutable t0_1466 : 'e ;
    mutable t0_1465 : 'd ;
    mutable rob_1462 : 'c ; mutable i_1516 : 'b ; mutable go_up_1515 : 'a }

let autotrans_at51 (tstep_1419:float) = 
  let Node { alloc = i_2124_alloc; step = i_2124_step ; reset = i_2124_reset } = at51 
   in
  let autotrans_at51_alloc _ =
    ();
    { i_1514 = (false:bool) ;
      m_1511 = (create ():FadFloat.t) ;
      m_1509 = (create ():FadFloat.t) ;
      m_1506 = (create ():FadFloat.t) ;
      m_1504 = (create ():FadFloat.t) ;
      nx_1503 = (create ():FadFloat.t) ;
      m_1501 = (create ():FadFloat.t) ;
      m_1498 = (create ():FadFloat.t) ;
      m_1493 = (create ():FadFloat.t) ;
      m_1491 = (create ():FadFloat.t) ;
      r_1486 = (false:bool) ;
      s_1485 = (At_UpShifting_411:state__9124) ;
      r_1484 = (false:bool) ;
      s_1483 = (At_Fourth_408:state__9123) ;
      t0_1466 = (create ():FadFloat.t) ;
      t0_1465 = (create ():FadFloat.t) ;
      rob_1462 = (create ():FadFloat.t) ;
      i_1516 = (false:bool) ; go_up_1515 = (false:bool);
      i_2124 = i_2124_alloc () (* discrete *)  } in
  let autotrans_at51_reset self  =
    ((self.i_1514 <- true ;
      i_2124_reset self.i_2124  ;
      self.r_1486 <- false ;
      self.s_1485 <- At_SteadyState_409 ;
      self.i_1516 <- true ;
      self.r_1484 <- false ; self.s_1483 <- At_First_405):unit) in 
  let autotrans_at51_step self (inp_1418:(FadFloat.t)Array.t) =
    ((let shiftp_1488 = ref (false:bool) in
      let shiftv_1487 = ref (At_common.DOWN:At_common.shift) in
      let (final_drive_ratio_1472:FadFloat.t) =
          FadFloat.scale self.m_1504  At_common.p_final_drive_ratio in
      let (aux1_1470:FadFloat.t) =
          FadFloat.(-) final_drive_ratio_1472  self.m_1509 in
      let (vehicle_inertia_1481:FadFloat.t) =
          FadFloat.scale aux1_1470  At_common.iv_inv in
      (if self.i_1514 then self.m_1493 <- FadFloat.make 0.) ;
      (let (x_1494:FadFloat.t) = self.m_1493 in
       let (x_1508:FadFloat.t) =
           if self.i_1514 then x_1494 else FadFloat.(-) x_1494  self.m_1506 in
       let (x_1513:FadFloat.t) =
           if self.i_1514
           then FadFloat.make At_common.p_initial_wheel_speed
           else
             FadFloat.(+) self.m_1511 
                          (FadFloat.( * ) vehicle_inertia_1481  x_1508) in
       (if self.i_1514 then self.nx_1503 <- Autotransd.gear1) ;
       (let (x0_1451:FadFloat.t) = FadFloat.make 1000. in
        (if self.i_1514 then self.m_1501 <- x0_1451) ;
        (let (x_1500:FadFloat.t) =
             if self.i_1514 then x_1494 else FadFloat.(-) x_1494  self.m_1498 in
         let (tstep'_1431:FadFloat.t) = FadFloat.make tstep_1419 in
         (if self.i_1514 then self.m_1491 <- tstep'_1431) ;
         self.i_1514 <- false ;
         (let (xmin_1453:FadFloat.t) = FadFloat.make 600. in
          let (xmax_1452:FadFloat.t) = FadFloat.make 6000. in
          let (x_1502:FadFloat.t) = self.m_1501 in
          let (x_1456:FadFloat.t) =
              FadFloat.max xmin_1453  (FadFloat.min xmax_1452  x_1502) in
          let (gear_1464:FadFloat.t) = self.nx_1503 in
          let (linear_speed_1473:FadFloat.t) =
              FadFloat.scale x_1513  At_common.l_speed_coef in
          let (mph_1474:FadFloat.t) =
              FadFloat.scale linear_speed_1473  At_common.p_mph in
          let (outp_1423:(FadFloat.t)Array.t) =
              Array.of_list ((::) (x_1456 ,
                                   ((::) (gear_1464 ,
                                          ((::) (mph_1474 , ([]))))))) in
          let (rob_spec_1426:FadFloat.t) =
              i_2124_step self.i_2124 (tstep'_1431 , outp_1423) in
          let (throttle_1430:FadFloat.t) = Array.get inp_1418  0 in
          let (dn_th_1460:FadFloat.t) =
              At_common.lookup_interpdn (throttle_1430 , gear_1464) in
          let (up_th_1463:FadFloat.t) =
              At_common.lookup_interpup (throttle_1430 , gear_1464) in
          (begin match self.s_1485 with
                 | At_SteadyState_409 ->
                     (if self.r_1486 then self.i_1516 <- true) ;
                     (if self.i_1516 then
                      self.go_up_1515 <- (>) (FadFloat.make (Random.float 1.))
                                              (FadFloat.make 0.5)) ;
                     self.i_1516 <- false ;
                     self.rob_1462 <- (if self.go_up_1515
                                       then FadFloat.(-) up_th_1463  mph_1474
                                       else FadFloat.(-) mph_1474  dn_th_1460)
                     ;
                     (begin match (((>) mph_1474  up_th_1463) ,
                                   ((<) mph_1474  dn_th_1460)) with
                            | (_ , true) ->
                                self.t0_1465 <- x_1494 ;
                                self.r_1486 <- true ;
                                self.s_1485 <- At_DownShifting_410
                            | (true , _) ->
                                self.t0_1466 <- x_1494 ;
                                self.r_1486 <- true ;
                                self.s_1485 <- At_UpShifting_411
                            | _ -> self.r_1486 <- false  end)
                 | At_DownShifting_410 ->
                     (if self.r_1486 then ()) ;
                     self.rob_1462 <- FadFloat.make 0. ;
                     (begin match (((>) x_1494 
                                        (FadFloat.translate self.t0_1465 
                                                            At_common.twait))
                                   , ((>) mph_1474  dn_th_1460)) with
                            | (_ , true) ->
                                self.r_1486 <- true ;
                                self.s_1485 <- At_SteadyState_409
                            | (true , _) ->
                                shiftp_1488 := true ;
                                shiftv_1487 := At_common.DOWN ;
                                self.r_1486 <- true ;
                                self.s_1485 <- At_SteadyState_409
                            | _ -> self.r_1486 <- false  end)
                 | At_UpShifting_411 ->
                     (if self.r_1486 then ()) ;
                     self.rob_1462 <- FadFloat.make 0. ;
                     (begin match (((>) x_1494 
                                        (FadFloat.translate self.t0_1466 
                                                            At_common.twait))
                                   , ((<) mph_1474  up_th_1463)) with
                            | (_ , true) ->
                                self.r_1486 <- true ;
                                self.s_1485 <- At_SteadyState_409
                            | (true , _) ->
                                shiftp_1488 := true ;
                                shiftv_1487 := At_common.UP ;
                                self.r_1486 <- true ;
                                self.s_1485 <- At_SteadyState_409
                            | _ -> self.r_1486 <- false  end)
                  end) ;
          (let (rob_optim_1425:FadFloat.t) =
               FadFloat.translate self.rob_1462  0.5 in
           let (rob_1424:FadFloat.t) =
               if Discrete_obs_fad.isFalse rob_spec_1426
               then rob_spec_1426
               else
                 if Discrete_obs_fad.isTrue rob_optim_1425
                 then rob_optim_1425
                 else rob_spec_1426 in
           let _ = print_endline "autotrans_at51" in
           let (trans_rpm_1480:FadFloat.t) =
               FadFloat.scale x_1513  At_common.p_final_drive_ratio in
           let ((ti_1440:FadFloat.t) , (out_torque_1436:FadFloat.t)) =
               At_common.transmission (x_1456 , gear_1464 , trans_rpm_1480) in
           self.m_1504 <- out_torque_1436 ;
           self.m_1511 <- x_1513 ;
           (let (brake_1420:FadFloat.t) = Array.get inp_1418  1 in
            let (road_load_1475:FadFloat.t) =
                FadFloat.translate (FadFloat.scale (FadFloat.sqr mph_1474) 
                                                   At_common.p_aerodynamic_drag)
                                    At_common.p_drag_friction in
            let (brake_1471:FadFloat.t) =
                FadFloat.(+) brake_1420  road_load_1475 in
            let (sgn_1476:FadFloat.t) =
                if (>=) mph_1474  (FadFloat.make 0.)
                then FadFloat.make 1.
                else FadFloat.make (-1.) in
            let (signed_load_1477:FadFloat.t) =
                FadFloat.( * ) sgn_1476  brake_1471 in
            self.m_1509 <- signed_load_1477 ;
            self.m_1506 <- x_1494 ;
            (begin match self.s_1483 with
                   | At_First_405 ->
                       (if self.r_1484 then ()) ;
                       (begin match (!shiftv_1487 , !shiftp_1488) with
                              | (At_common.UP , true) ->
                                  self.nx_1503 <- Autotransd.gear2 ;
                                  self.r_1484 <- true ;
                                  self.s_1483 <- At_Second_406
                              | _ -> self.r_1484 <- false  end)
                   | At_Second_406 ->
                       (if self.r_1484 then ()) ;
                       (begin match (!shiftv_1487 , !shiftp_1488) with
                              | (At_common.DOWN , true) ->
                                  self.nx_1503 <- Autotransd.gear1 ;
                                  self.r_1484 <- true ;
                                  self.s_1483 <- At_First_405
                              | (At_common.UP , true) ->
                                  self.nx_1503 <- Autotransd.gear3 ;
                                  self.r_1484 <- true ;
                                  self.s_1483 <- At_Third_407
                              | _ -> self.r_1484 <- false  end)
                   | At_Third_407 ->
                       (if self.r_1484 then ()) ;
                       (begin match (!shiftv_1487 , !shiftp_1488) with
                              | (At_common.DOWN , true) ->
                                  self.nx_1503 <- Autotransd.gear2 ;
                                  self.r_1484 <- true ;
                                  self.s_1483 <- At_Second_406
                              | (At_common.UP , true) ->
                                  self.nx_1503 <- Autotransd.gear4 ;
                                  self.r_1484 <- true ;
                                  self.s_1483 <- At_Fourth_408
                              | _ -> self.r_1484 <- false  end)
                   | At_Fourth_408 ->
                       (if self.r_1484 then ()) ;
                       (begin match (!shiftv_1487 , !shiftp_1488) with
                              | (At_common.DOWN , true) ->
                                  self.nx_1503 <- Autotransd.gear3 ;
                                  self.r_1484 <- true ;
                                  self.s_1483 <- At_Third_407
                              | _ -> self.r_1484 <- false  end)
                    end) ;
            (let (te_1447:FadFloat.t) =
                 At_common.lookup_engine (throttle_1430 , x_1456) in
             let (drpm_1445:FadFloat.t) = FadFloat.(-) te_1447  ti_1440 in
             let (dx_1449:FadFloat.t) =
                 FadFloat.scale drpm_1445  At_common.engine_feedback_gain in
             self.m_1501 <- FadFloat.(+) x_1456 
                                         (FadFloat.( * ) dx_1449  x_1500) ;
             self.m_1498 <- x_1494 ;
             (let (x_1492:FadFloat.t) = self.m_1491 in
              self.m_1493 <- x_1492 ;
              self.m_1491 <- FadFloat.(+) x_1492  tstep'_1431 ;
              ((FadFloat.get x_1492) , outp_1423 , rob_1424)))))))))):
    float * FadFloat.t Array.t * FadFloat.t) in
  Node { alloc = autotrans_at51_alloc; reset = autotrans_at51_reset ;
                                       step = autotrans_at51_step }
type ('t ,
      's ,
      'r ,
      'q ,
      'p ,
      'o ,
      'n , 'm , 'l , 'k , 'j , 'i , 'h , 'g , 'f , 'e , 'd , 'c , 'b , 'a) _autotrans_at52 =
  { mutable i_2125 : 't ;
    mutable i_1613 : 's ;
    mutable m_1610 : 'r ;
    mutable m_1608 : 'q ;
    mutable m_1605 : 'p ;
    mutable m_1603 : 'o ;
    mutable nx_1602 : 'n ;
    mutable m_1600 : 'm ;
    mutable m_1597 : 'l ;
    mutable m_1592 : 'k ;
    mutable m_1590 : 'j ;
    mutable r_1585 : 'i ;
    mutable s_1584 : 'h ;
    mutable r_1583 : 'g ;
    mutable s_1582 : 'f ;
    mutable t0_1565 : 'e ;
    mutable t0_1564 : 'd ;
    mutable rob_1561 : 'c ; mutable i_1615 : 'b ; mutable go_up_1614 : 'a }

let autotrans_at52 (tstep_1518:float) = 
  let Node { alloc = i_2125_alloc; step = i_2125_step ; reset = i_2125_reset } = at52 
   in
  let autotrans_at52_alloc _ =
    ();
    { i_1613 = (false:bool) ;
      m_1610 = (create ():FadFloat.t) ;
      m_1608 = (create ():FadFloat.t) ;
      m_1605 = (create ():FadFloat.t) ;
      m_1603 = (create ():FadFloat.t) ;
      nx_1602 = (create ():FadFloat.t) ;
      m_1600 = (create ():FadFloat.t) ;
      m_1597 = (create ():FadFloat.t) ;
      m_1592 = (create ():FadFloat.t) ;
      m_1590 = (create ():FadFloat.t) ;
      r_1585 = (false:bool) ;
      s_1584 = (At_UpShifting_486:state__9126) ;
      r_1583 = (false:bool) ;
      s_1582 = (At_Fourth_483:state__9125) ;
      t0_1565 = (create ():FadFloat.t) ;
      t0_1564 = (create ():FadFloat.t) ;
      rob_1561 = (create ():FadFloat.t) ;
      i_1615 = (false:bool) ; go_up_1614 = (false:bool);
      i_2125 = i_2125_alloc () (* discrete *)  } in
  let autotrans_at52_reset self  =
    ((self.i_1613 <- true ;
      i_2125_reset self.i_2125  ;
      self.r_1585 <- false ;
      self.s_1584 <- At_SteadyState_484 ;
      self.i_1615 <- true ;
      self.r_1583 <- false ; self.s_1582 <- At_First_480):unit) in 
  let autotrans_at52_step self (inp_1517:(FadFloat.t)Array.t) =
    ((let shiftp_1587 = ref (false:bool) in
      let shiftv_1586 = ref (At_common.DOWN:At_common.shift) in
      let (final_drive_ratio_1571:FadFloat.t) =
          FadFloat.scale self.m_1603  At_common.p_final_drive_ratio in
      let (aux1_1569:FadFloat.t) =
          FadFloat.(-) final_drive_ratio_1571  self.m_1608 in
      let (vehicle_inertia_1580:FadFloat.t) =
          FadFloat.scale aux1_1569  At_common.iv_inv in
      (if self.i_1613 then self.m_1592 <- FadFloat.make 0.) ;
      (let (x_1593:FadFloat.t) = self.m_1592 in
       let (x_1607:FadFloat.t) =
           if self.i_1613 then x_1593 else FadFloat.(-) x_1593  self.m_1605 in
       let (x_1612:FadFloat.t) =
           if self.i_1613
           then FadFloat.make At_common.p_initial_wheel_speed
           else
             FadFloat.(+) self.m_1610 
                          (FadFloat.( * ) vehicle_inertia_1580  x_1607) in
       (if self.i_1613 then self.nx_1602 <- Autotransd.gear1) ;
       (let (x0_1550:FadFloat.t) = FadFloat.make 1000. in
        (if self.i_1613 then self.m_1600 <- x0_1550) ;
        (let (x_1599:FadFloat.t) =
             if self.i_1613 then x_1593 else FadFloat.(-) x_1593  self.m_1597 in
         let (tstep'_1530:FadFloat.t) = FadFloat.make tstep_1518 in
         (if self.i_1613 then self.m_1590 <- tstep'_1530) ;
         self.i_1613 <- false ;
         (let (xmin_1552:FadFloat.t) = FadFloat.make 600. in
          let (xmax_1551:FadFloat.t) = FadFloat.make 6000. in
          let (x_1601:FadFloat.t) = self.m_1600 in
          let (x_1555:FadFloat.t) =
              FadFloat.max xmin_1552  (FadFloat.min xmax_1551  x_1601) in
          let (gear_1563:FadFloat.t) = self.nx_1602 in
          let (linear_speed_1572:FadFloat.t) =
              FadFloat.scale x_1612  At_common.l_speed_coef in
          let (mph_1573:FadFloat.t) =
              FadFloat.scale linear_speed_1572  At_common.p_mph in
          let (outp_1522:(FadFloat.t)Array.t) =
              Array.of_list ((::) (x_1555 ,
                                   ((::) (gear_1563 ,
                                          ((::) (mph_1573 , ([]))))))) in
          let (rob_spec_1525:FadFloat.t) =
              i_2125_step self.i_2125 (tstep'_1530 , outp_1522) in
          let (throttle_1529:FadFloat.t) = Array.get inp_1517  0 in
          let (dn_th_1559:FadFloat.t) =
              At_common.lookup_interpdn (throttle_1529 , gear_1563) in
          let (up_th_1562:FadFloat.t) =
              At_common.lookup_interpup (throttle_1529 , gear_1563) in
          (begin match self.s_1584 with
                 | At_SteadyState_484 ->
                     (if self.r_1585 then self.i_1615 <- true) ;
                     (if self.i_1615 then
                      self.go_up_1614 <- (>) (FadFloat.make (Random.float 1.))
                                              (FadFloat.make 0.5)) ;
                     self.i_1615 <- false ;
                     self.rob_1561 <- (if self.go_up_1614
                                       then FadFloat.(-) up_th_1562  mph_1573
                                       else FadFloat.(-) mph_1573  dn_th_1559)
                     ;
                     (begin match (((>) mph_1573  up_th_1562) ,
                                   ((<) mph_1573  dn_th_1559)) with
                            | (_ , true) ->
                                self.t0_1564 <- x_1593 ;
                                self.r_1585 <- true ;
                                self.s_1584 <- At_DownShifting_485
                            | (true , _) ->
                                self.t0_1565 <- x_1593 ;
                                self.r_1585 <- true ;
                                self.s_1584 <- At_UpShifting_486
                            | _ -> self.r_1585 <- false  end)
                 | At_DownShifting_485 ->
                     (if self.r_1585 then ()) ;
                     self.rob_1561 <- FadFloat.make 0. ;
                     (begin match (((>) x_1593 
                                        (FadFloat.translate self.t0_1564 
                                                            At_common.twait))
                                   , ((>) mph_1573  dn_th_1559)) with
                            | (_ , true) ->
                                self.r_1585 <- true ;
                                self.s_1584 <- At_SteadyState_484
                            | (true , _) ->
                                shiftp_1587 := true ;
                                shiftv_1586 := At_common.DOWN ;
                                self.r_1585 <- true ;
                                self.s_1584 <- At_SteadyState_484
                            | _ -> self.r_1585 <- false  end)
                 | At_UpShifting_486 ->
                     (if self.r_1585 then ()) ;
                     self.rob_1561 <- FadFloat.make 0. ;
                     (begin match (((>) x_1593 
                                        (FadFloat.translate self.t0_1565 
                                                            At_common.twait))
                                   , ((<) mph_1573  up_th_1562)) with
                            | (_ , true) ->
                                self.r_1585 <- true ;
                                self.s_1584 <- At_SteadyState_484
                            | (true , _) ->
                                shiftp_1587 := true ;
                                shiftv_1586 := At_common.UP ;
                                self.r_1585 <- true ;
                                self.s_1584 <- At_SteadyState_484
                            | _ -> self.r_1585 <- false  end)
                  end) ;
          (let (rob_optim_1524:FadFloat.t) =
               FadFloat.translate self.rob_1561  0.5 in
           let (rob_1523:FadFloat.t) =
               if Discrete_obs_fad.isFalse rob_spec_1525
               then rob_spec_1525
               else
                 if Discrete_obs_fad.isTrue rob_optim_1524
                 then rob_optim_1524
                 else rob_spec_1525 in
           let (trans_rpm_1579:FadFloat.t) =
               FadFloat.scale x_1612  At_common.p_final_drive_ratio in
           let ((ti_1539:FadFloat.t) , (out_torque_1535:FadFloat.t)) =
               At_common.transmission (x_1555 , gear_1563 , trans_rpm_1579) in
           self.m_1603 <- out_torque_1535 ;
           self.m_1610 <- x_1612 ;
           (let (brake_1519:FadFloat.t) = Array.get inp_1517  1 in
            let (road_load_1574:FadFloat.t) =
                FadFloat.translate (FadFloat.scale (FadFloat.sqr mph_1573) 
                                                   At_common.p_aerodynamic_drag)
                                    At_common.p_drag_friction in
            let (brake_1570:FadFloat.t) =
                FadFloat.(+) brake_1519  road_load_1574 in
            let (sgn_1575:FadFloat.t) =
                if (>=) mph_1573  (FadFloat.make 0.)
                then FadFloat.make 1.
                else FadFloat.make (-1.) in
            let (signed_load_1576:FadFloat.t) =
                FadFloat.( * ) sgn_1575  brake_1570 in
            self.m_1608 <- signed_load_1576 ;
            self.m_1605 <- x_1593 ;
            (begin match self.s_1582 with
                   | At_First_480 ->
                       (if self.r_1583 then ()) ;
                       (begin match (!shiftv_1586 , !shiftp_1587) with
                              | (At_common.UP , true) ->
                                  self.nx_1602 <- Autotransd.gear2 ;
                                  self.r_1583 <- true ;
                                  self.s_1582 <- At_Second_481
                              | _ -> self.r_1583 <- false  end)
                   | At_Second_481 ->
                       (if self.r_1583 then ()) ;
                       (begin match (!shiftv_1586 , !shiftp_1587) with
                              | (At_common.DOWN , true) ->
                                  self.nx_1602 <- Autotransd.gear1 ;
                                  self.r_1583 <- true ;
                                  self.s_1582 <- At_First_480
                              | (At_common.UP , true) ->
                                  self.nx_1602 <- Autotransd.gear3 ;
                                  self.r_1583 <- true ;
                                  self.s_1582 <- At_Third_482
                              | _ -> self.r_1583 <- false  end)
                   | At_Third_482 ->
                       (if self.r_1583 then ()) ;
                       (begin match (!shiftv_1586 , !shiftp_1587) with
                              | (At_common.DOWN , true) ->
                                  self.nx_1602 <- Autotransd.gear2 ;
                                  self.r_1583 <- true ;
                                  self.s_1582 <- At_Second_481
                              | (At_common.UP , true) ->
                                  self.nx_1602 <- Autotransd.gear4 ;
                                  self.r_1583 <- true ;
                                  self.s_1582 <- At_Fourth_483
                              | _ -> self.r_1583 <- false  end)
                   | At_Fourth_483 ->
                       (if self.r_1583 then ()) ;
                       (begin match (!shiftv_1586 , !shiftp_1587) with
                              | (At_common.DOWN , true) ->
                                  self.nx_1602 <- Autotransd.gear3 ;
                                  self.r_1583 <- true ;
                                  self.s_1582 <- At_Third_482
                              | _ -> self.r_1583 <- false  end)
                    end) ;
            (let (te_1546:FadFloat.t) =
                 At_common.lookup_engine (throttle_1529 , x_1555) in
             let (drpm_1544:FadFloat.t) = FadFloat.(-) te_1546  ti_1539 in
             let (dx_1548:FadFloat.t) =
                 FadFloat.scale drpm_1544  At_common.engine_feedback_gain in
             self.m_1600 <- FadFloat.(+) x_1555 
                                         (FadFloat.( * ) dx_1548  x_1599) ;
             self.m_1597 <- x_1593 ;
             (let (x_1591:FadFloat.t) = self.m_1590 in
              self.m_1592 <- x_1591 ;
              self.m_1590 <- FadFloat.(+) x_1591  tstep'_1530 ;
              ((FadFloat.get x_1591) ,
               outp_1522 , (FadFloat.(+) rob_1523  (FadFloat.make 0.1)))))))))))):
    float * FadFloat.t Array.t * FadFloat.t) in
  Node { alloc = autotrans_at52_alloc; reset = autotrans_at52_reset ;
                                       step = autotrans_at52_step }
type ('t ,
      's ,
      'r ,
      'q ,
      'p ,
      'o ,
      'n , 'm , 'l , 'k , 'j , 'i , 'h , 'g , 'f , 'e , 'd , 'c , 'b , 'a) _autotrans_at53 =
  { mutable i_2126 : 't ;
    mutable i_1712 : 's ;
    mutable m_1709 : 'r ;
    mutable m_1707 : 'q ;
    mutable m_1704 : 'p ;
    mutable m_1702 : 'o ;
    mutable nx_1701 : 'n ;
    mutable m_1699 : 'm ;
    mutable m_1696 : 'l ;
    mutable m_1691 : 'k ;
    mutable m_1689 : 'j ;
    mutable r_1684 : 'i ;
    mutable s_1683 : 'h ;
    mutable r_1682 : 'g ;
    mutable s_1681 : 'f ;
    mutable t0_1664 : 'e ;
    mutable t0_1663 : 'd ;
    mutable rob_1660 : 'c ; mutable i_1714 : 'b ; mutable go_up_1713 : 'a }

let autotrans_at53 (tstep_1617:float) = 
  let Node { alloc = i_2126_alloc; step = i_2126_step ; reset = i_2126_reset } = at53 
   in
  let autotrans_at53_alloc _ =
    ();
    { i_1712 = (false:bool) ;
      m_1709 = (create ():FadFloat.t) ;
      m_1707 = (create ():FadFloat.t) ;
      m_1704 = (create ():FadFloat.t) ;
      m_1702 = (create ():FadFloat.t) ;
      nx_1701 = (create ():FadFloat.t) ;
      m_1699 = (create ():FadFloat.t) ;
      m_1696 = (create ():FadFloat.t) ;
      m_1691 = (create ():FadFloat.t) ;
      m_1689 = (create ():FadFloat.t) ;
      r_1684 = (false:bool) ;
      s_1683 = (At_UpShifting_561:state__9128) ;
      r_1682 = (false:bool) ;
      s_1681 = (At_Fourth_558:state__9127) ;
      t0_1664 = (create ():FadFloat.t) ;
      t0_1663 = (create ():FadFloat.t) ;
      rob_1660 = (create ():FadFloat.t) ;
      i_1714 = (false:bool) ; go_up_1713 = (false:bool);
      i_2126 = i_2126_alloc () (* discrete *)  } in
  let autotrans_at53_reset self  =
    ((self.i_1712 <- true ;
      i_2126_reset self.i_2126  ;
      self.r_1684 <- false ;
      self.s_1683 <- At_SteadyState_559 ;
      self.i_1714 <- true ;
      self.r_1682 <- false ; self.s_1681 <- At_First_555):unit) in 
  let autotrans_at53_step self (inp_1616:(FadFloat.t)Array.t) =
    ((let shiftp_1686 = ref (false:bool) in
      let shiftv_1685 = ref (At_common.DOWN:At_common.shift) in
      let (final_drive_ratio_1670:FadFloat.t) =
          FadFloat.scale self.m_1702  At_common.p_final_drive_ratio in
      let (aux1_1668:FadFloat.t) =
          FadFloat.(-) final_drive_ratio_1670  self.m_1707 in
      let (vehicle_inertia_1679:FadFloat.t) =
          FadFloat.scale aux1_1668  At_common.iv_inv in
      (if self.i_1712 then self.m_1691 <- FadFloat.make 0.) ;
      (let (x_1692:FadFloat.t) = self.m_1691 in
       let (x_1706:FadFloat.t) =
           if self.i_1712 then x_1692 else FadFloat.(-) x_1692  self.m_1704 in
       let (x_1711:FadFloat.t) =
           if self.i_1712
           then FadFloat.make At_common.p_initial_wheel_speed
           else
             FadFloat.(+) self.m_1709 
                          (FadFloat.( * ) vehicle_inertia_1679  x_1706) in
       (if self.i_1712 then self.nx_1701 <- Autotransd.gear1) ;
       (let (x0_1649:FadFloat.t) = FadFloat.make 1000. in
        (if self.i_1712 then self.m_1699 <- x0_1649) ;
        (let (x_1698:FadFloat.t) =
             if self.i_1712 then x_1692 else FadFloat.(-) x_1692  self.m_1696 in
         let (tstep'_1629:FadFloat.t) = FadFloat.make tstep_1617 in
         (if self.i_1712 then self.m_1689 <- tstep'_1629) ;
         self.i_1712 <- false ;
         (let (xmin_1651:FadFloat.t) = FadFloat.make 600. in
          let (xmax_1650:FadFloat.t) = FadFloat.make 6000. in
          let (x_1700:FadFloat.t) = self.m_1699 in
          let (x_1654:FadFloat.t) =
              FadFloat.max xmin_1651  (FadFloat.min xmax_1650  x_1700) in
          let (gear_1662:FadFloat.t) = self.nx_1701 in
          let (linear_speed_1671:FadFloat.t) =
              FadFloat.scale x_1711  At_common.l_speed_coef in
          let (mph_1672:FadFloat.t) =
              FadFloat.scale linear_speed_1671  At_common.p_mph in
          let (outp_1621:(FadFloat.t)Array.t) =
              Array.of_list ((::) (x_1654 ,
                                   ((::) (gear_1662 ,
                                          ((::) (mph_1672 , ([]))))))) in
          let (rob_spec_1624:FadFloat.t) =
              i_2126_step self.i_2126 (tstep'_1629 , outp_1621) in
          let (throttle_1628:FadFloat.t) = Array.get inp_1616  0 in
          let (dn_th_1658:FadFloat.t) =
              At_common.lookup_interpdn (throttle_1628 , gear_1662) in
          let (up_th_1661:FadFloat.t) =
              At_common.lookup_interpup (throttle_1628 , gear_1662) in
          (begin match self.s_1683 with
                 | At_SteadyState_559 ->
                     (if self.r_1684 then self.i_1714 <- true) ;
                     (if self.i_1714 then
                      self.go_up_1713 <- (>) (FadFloat.make (Random.float 1.))
                                              (FadFloat.make 0.5)) ;
                     self.i_1714 <- false ;
                     self.rob_1660 <- (if self.go_up_1713
                                       then FadFloat.(-) up_th_1661  mph_1672
                                       else FadFloat.(-) mph_1672  dn_th_1658)
                     ;
                     (begin match (((>) mph_1672  up_th_1661) ,
                                   ((<) mph_1672  dn_th_1658)) with
                            | (_ , true) ->
                                self.t0_1663 <- x_1692 ;
                                self.r_1684 <- true ;
                                self.s_1683 <- At_DownShifting_560
                            | (true , _) ->
                                self.t0_1664 <- x_1692 ;
                                self.r_1684 <- true ;
                                self.s_1683 <- At_UpShifting_561
                            | _ -> self.r_1684 <- false  end)
                 | At_DownShifting_560 ->
                     (if self.r_1684 then ()) ;
                     self.rob_1660 <- FadFloat.make 0. ;
                     (begin match (((>) x_1692 
                                        (FadFloat.translate self.t0_1663 
                                                            At_common.twait))
                                   , ((>) mph_1672  dn_th_1658)) with
                            | (_ , true) ->
                                self.r_1684 <- true ;
                                self.s_1683 <- At_SteadyState_559
                            | (true , _) ->
                                shiftp_1686 := true ;
                                shiftv_1685 := At_common.DOWN ;
                                self.r_1684 <- true ;
                                self.s_1683 <- At_SteadyState_559
                            | _ -> self.r_1684 <- false  end)
                 | At_UpShifting_561 ->
                     (if self.r_1684 then ()) ;
                     self.rob_1660 <- FadFloat.make 0. ;
                     (begin match (((>) x_1692 
                                        (FadFloat.translate self.t0_1664 
                                                            At_common.twait))
                                   , ((<) mph_1672  up_th_1661)) with
                            | (_ , true) ->
                                self.r_1684 <- true ;
                                self.s_1683 <- At_SteadyState_559
                            | (true , _) ->
                                shiftp_1686 := true ;
                                shiftv_1685 := At_common.UP ;
                                self.r_1684 <- true ;
                                self.s_1683 <- At_SteadyState_559
                            | _ -> self.r_1684 <- false  end)
                  end) ;
          (let (rob_optim_1623:FadFloat.t) =
               FadFloat.translate self.rob_1660  0.5 in
           let (rob_1622:FadFloat.t) =
               if Discrete_obs_fad.isFalse rob_spec_1624
               then rob_spec_1624
               else
                 if Discrete_obs_fad.isTrue rob_optim_1623
                 then rob_optim_1623
                 else rob_spec_1624 in
           let (trans_rpm_1678:FadFloat.t) =
               FadFloat.scale x_1711  At_common.p_final_drive_ratio in
           let ((ti_1638:FadFloat.t) , (out_torque_1634:FadFloat.t)) =
               At_common.transmission (x_1654 , gear_1662 , trans_rpm_1678) in
           self.m_1702 <- out_torque_1634 ;
           self.m_1709 <- x_1711 ;
           (let (brake_1618:FadFloat.t) = Array.get inp_1616  1 in
            let (road_load_1673:FadFloat.t) =
                FadFloat.translate (FadFloat.scale (FadFloat.sqr mph_1672) 
                                                   At_common.p_aerodynamic_drag)
                                    At_common.p_drag_friction in
            let (brake_1669:FadFloat.t) =
                FadFloat.(+) brake_1618  road_load_1673 in
            let (sgn_1674:FadFloat.t) =
                if (>=) mph_1672  (FadFloat.make 0.)
                then FadFloat.make 1.
                else FadFloat.make (-1.) in
            let (signed_load_1675:FadFloat.t) =
                FadFloat.( * ) sgn_1674  brake_1669 in
            self.m_1707 <- signed_load_1675 ;
            self.m_1704 <- x_1692 ;
            (begin match self.s_1681 with
                   | At_First_555 ->
                       (if self.r_1682 then ()) ;
                       (begin match (!shiftv_1685 , !shiftp_1686) with
                              | (At_common.UP , true) ->
                                  self.nx_1701 <- Autotransd.gear2 ;
                                  self.r_1682 <- true ;
                                  self.s_1681 <- At_Second_556
                              | _ -> self.r_1682 <- false  end)
                   | At_Second_556 ->
                       (if self.r_1682 then ()) ;
                       (begin match (!shiftv_1685 , !shiftp_1686) with
                              | (At_common.DOWN , true) ->
                                  self.nx_1701 <- Autotransd.gear1 ;
                                  self.r_1682 <- true ;
                                  self.s_1681 <- At_First_555
                              | (At_common.UP , true) ->
                                  self.nx_1701 <- Autotransd.gear3 ;
                                  self.r_1682 <- true ;
                                  self.s_1681 <- At_Third_557
                              | _ -> self.r_1682 <- false  end)
                   | At_Third_557 ->
                       (if self.r_1682 then ()) ;
                       (begin match (!shiftv_1685 , !shiftp_1686) with
                              | (At_common.DOWN , true) ->
                                  self.nx_1701 <- Autotransd.gear2 ;
                                  self.r_1682 <- true ;
                                  self.s_1681 <- At_Second_556
                              | (At_common.UP , true) ->
                                  self.nx_1701 <- Autotransd.gear4 ;
                                  self.r_1682 <- true ;
                                  self.s_1681 <- At_Fourth_558
                              | _ -> self.r_1682 <- false  end)
                   | At_Fourth_558 ->
                       (if self.r_1682 then ()) ;
                       (begin match (!shiftv_1685 , !shiftp_1686) with
                              | (At_common.DOWN , true) ->
                                  self.nx_1701 <- Autotransd.gear3 ;
                                  self.r_1682 <- true ;
                                  self.s_1681 <- At_Third_557
                              | _ -> self.r_1682 <- false  end)
                    end) ;
            (let (te_1645:FadFloat.t) =
                 At_common.lookup_engine (throttle_1628 , x_1654) in
             let (drpm_1643:FadFloat.t) = FadFloat.(-) te_1645  ti_1638 in
             let (dx_1647:FadFloat.t) =
                 FadFloat.scale drpm_1643  At_common.engine_feedback_gain in
             self.m_1699 <- FadFloat.(+) x_1654 
                                         (FadFloat.( * ) dx_1647  x_1698) ;
             self.m_1696 <- x_1692 ;
             (let (x_1690:FadFloat.t) = self.m_1689 in
              self.m_1691 <- x_1690 ;
              self.m_1689 <- FadFloat.(+) x_1690  tstep'_1629 ;
              ((FadFloat.get x_1690) , outp_1621 , rob_1622)))))))))):
    float * FadFloat.t Array.t * FadFloat.t) in
  Node { alloc = autotrans_at53_alloc; reset = autotrans_at53_reset ;
                                       step = autotrans_at53_step }
type ('t ,
      's ,
      'r ,
      'q ,
      'p ,
      'o ,
      'n , 'm , 'l , 'k , 'j , 'i , 'h , 'g , 'f , 'e , 'd , 'c , 'b , 'a) _autotrans_at54 =
  { mutable i_2127 : 't ;
    mutable i_1811 : 's ;
    mutable m_1808 : 'r ;
    mutable m_1806 : 'q ;
    mutable m_1803 : 'p ;
    mutable m_1801 : 'o ;
    mutable nx_1800 : 'n ;
    mutable m_1798 : 'm ;
    mutable m_1795 : 'l ;
    mutable m_1790 : 'k ;
    mutable m_1788 : 'j ;
    mutable r_1783 : 'i ;
    mutable s_1782 : 'h ;
    mutable r_1781 : 'g ;
    mutable s_1780 : 'f ;
    mutable t0_1763 : 'e ;
    mutable t0_1762 : 'd ;
    mutable rob_1759 : 'c ; mutable i_1813 : 'b ; mutable go_up_1812 : 'a }

let autotrans_at54 (tstep_1716:float) = 
  let Node { alloc = i_2127_alloc; step = i_2127_step ; reset = i_2127_reset } = at54 
   in
  let autotrans_at54_alloc _ =
    ();
    { i_1811 = (false:bool) ;
      m_1808 = (create ():FadFloat.t) ;
      m_1806 = (create ():FadFloat.t) ;
      m_1803 = (create ():FadFloat.t) ;
      m_1801 = (create ():FadFloat.t) ;
      nx_1800 = (create ():FadFloat.t) ;
      m_1798 = (create ():FadFloat.t) ;
      m_1795 = (create ():FadFloat.t) ;
      m_1790 = (create ():FadFloat.t) ;
      m_1788 = (create ():FadFloat.t) ;
      r_1783 = (false:bool) ;
      s_1782 = (At_UpShifting_636:state__9130) ;
      r_1781 = (false:bool) ;
      s_1780 = (At_Fourth_633:state__9129) ;
      t0_1763 = (create ():FadFloat.t) ;
      t0_1762 = (create ():FadFloat.t) ;
      rob_1759 = (create ():FadFloat.t) ;
      i_1813 = (false:bool) ; go_up_1812 = (false:bool);
      i_2127 = i_2127_alloc () (* discrete *)  } in
  let autotrans_at54_reset self  =
    ((self.i_1811 <- true ;
      i_2127_reset self.i_2127  ;
      self.r_1783 <- false ;
      self.s_1782 <- At_SteadyState_634 ;
      self.i_1813 <- true ;
      self.r_1781 <- false ; self.s_1780 <- At_First_630):unit) in 
  let autotrans_at54_step self (inp_1715:(FadFloat.t)Array.t) =
    ((let shiftp_1785 = ref (false:bool) in
      let shiftv_1784 = ref (At_common.DOWN:At_common.shift) in
      let (final_drive_ratio_1769:FadFloat.t) =
          FadFloat.scale self.m_1801  At_common.p_final_drive_ratio in
      let (aux1_1767:FadFloat.t) =
          FadFloat.(-) final_drive_ratio_1769  self.m_1806 in
      let (vehicle_inertia_1778:FadFloat.t) =
          FadFloat.scale aux1_1767  At_common.iv_inv in
      (if self.i_1811 then self.m_1790 <- FadFloat.make 0.) ;
      (let (x_1791:FadFloat.t) = self.m_1790 in
       let (x_1805:FadFloat.t) =
           if self.i_1811 then x_1791 else FadFloat.(-) x_1791  self.m_1803 in
       let (x_1810:FadFloat.t) =
           if self.i_1811
           then FadFloat.make At_common.p_initial_wheel_speed
           else
             FadFloat.(+) self.m_1808 
                          (FadFloat.( * ) vehicle_inertia_1778  x_1805) in
       (if self.i_1811 then self.nx_1800 <- Autotransd.gear1) ;
       (let (x0_1748:FadFloat.t) = FadFloat.make 1000. in
        (if self.i_1811 then self.m_1798 <- x0_1748) ;
        (let (x_1797:FadFloat.t) =
             if self.i_1811 then x_1791 else FadFloat.(-) x_1791  self.m_1795 in
         let (tstep'_1728:FadFloat.t) = FadFloat.make tstep_1716 in
         (if self.i_1811 then self.m_1788 <- tstep'_1728) ;
         self.i_1811 <- false ;
         (let (xmin_1750:FadFloat.t) = FadFloat.make 600. in
          let (xmax_1749:FadFloat.t) = FadFloat.make 6000. in
          let (x_1799:FadFloat.t) = self.m_1798 in
          let (x_1753:FadFloat.t) =
              FadFloat.max xmin_1750  (FadFloat.min xmax_1749  x_1799) in
          let (gear_1761:FadFloat.t) = self.nx_1800 in
          let (linear_speed_1770:FadFloat.t) =
              FadFloat.scale x_1810  At_common.l_speed_coef in
          let (mph_1771:FadFloat.t) =
              FadFloat.scale linear_speed_1770  At_common.p_mph in
          let (outp_1720:(FadFloat.t)Array.t) =
              Array.of_list ((::) (x_1753 ,
                                   ((::) (gear_1761 ,
                                          ((::) (mph_1771 , ([]))))))) in
          let (rob_spec_1723:FadFloat.t) =
              i_2127_step self.i_2127 (tstep'_1728 , outp_1720) in
          let (throttle_1727:FadFloat.t) = Array.get inp_1715  0 in
          let (dn_th_1757:FadFloat.t) =
              At_common.lookup_interpdn (throttle_1727 , gear_1761) in
          let (up_th_1760:FadFloat.t) =
              At_common.lookup_interpup (throttle_1727 , gear_1761) in
          (begin match self.s_1782 with
                 | At_SteadyState_634 ->
                     (if self.r_1783 then self.i_1813 <- true) ;
                     (if self.i_1813 then
                      self.go_up_1812 <- (>) (FadFloat.make (Random.float 1.))
                                              (FadFloat.make 0.5)) ;
                     self.i_1813 <- false ;
                     self.rob_1759 <- (if self.go_up_1812
                                       then FadFloat.(-) up_th_1760  mph_1771
                                       else FadFloat.(-) mph_1771  dn_th_1757)
                     ;
                     (begin match (((>) mph_1771  up_th_1760) ,
                                   ((<) mph_1771  dn_th_1757)) with
                            | (_ , true) ->
                                self.t0_1762 <- x_1791 ;
                                self.r_1783 <- true ;
                                self.s_1782 <- At_DownShifting_635
                            | (true , _) ->
                                self.t0_1763 <- x_1791 ;
                                self.r_1783 <- true ;
                                self.s_1782 <- At_UpShifting_636
                            | _ -> self.r_1783 <- false  end)
                 | At_DownShifting_635 ->
                     (if self.r_1783 then ()) ;
                     self.rob_1759 <- FadFloat.make 0. ;
                     (begin match (((>) x_1791 
                                        (FadFloat.translate self.t0_1762 
                                                            At_common.twait))
                                   , ((>) mph_1771  dn_th_1757)) with
                            | (_ , true) ->
                                self.r_1783 <- true ;
                                self.s_1782 <- At_SteadyState_634
                            | (true , _) ->
                                shiftp_1785 := true ;
                                shiftv_1784 := At_common.DOWN ;
                                self.r_1783 <- true ;
                                self.s_1782 <- At_SteadyState_634
                            | _ -> self.r_1783 <- false  end)
                 | At_UpShifting_636 ->
                     (if self.r_1783 then ()) ;
                     self.rob_1759 <- FadFloat.make 0. ;
                     (begin match (((>) x_1791 
                                        (FadFloat.translate self.t0_1763 
                                                            At_common.twait))
                                   , ((<) mph_1771  up_th_1760)) with
                            | (_ , true) ->
                                self.r_1783 <- true ;
                                self.s_1782 <- At_SteadyState_634
                            | (true , _) ->
                                shiftp_1785 := true ;
                                shiftv_1784 := At_common.UP ;
                                self.r_1783 <- true ;
                                self.s_1782 <- At_SteadyState_634
                            | _ -> self.r_1783 <- false  end)
                  end) ;
          (let (rob_optim_1722:FadFloat.t) =
               FadFloat.translate self.rob_1759  0.5 in
           let (rob_1721:FadFloat.t) =
               if Discrete_obs_fad.isFalse rob_spec_1723
               then rob_spec_1723
               else
                 if Discrete_obs_fad.isTrue rob_optim_1722
                 then rob_optim_1722
                 else rob_spec_1723 in
           let (trans_rpm_1777:FadFloat.t) =
               FadFloat.scale x_1810  At_common.p_final_drive_ratio in
           let ((ti_1737:FadFloat.t) , (out_torque_1733:FadFloat.t)) =
               At_common.transmission (x_1753 , gear_1761 , trans_rpm_1777) in
           self.m_1801 <- out_torque_1733 ;
           self.m_1808 <- x_1810 ;
           (let (brake_1717:FadFloat.t) = Array.get inp_1715  1 in
            let (road_load_1772:FadFloat.t) =
                FadFloat.translate (FadFloat.scale (FadFloat.sqr mph_1771) 
                                                   At_common.p_aerodynamic_drag)
                                    At_common.p_drag_friction in
            let (brake_1768:FadFloat.t) =
                FadFloat.(+) brake_1717  road_load_1772 in
            let (sgn_1773:FadFloat.t) =
                if (>=) mph_1771  (FadFloat.make 0.)
                then FadFloat.make 1.
                else FadFloat.make (-1.) in
            let (signed_load_1774:FadFloat.t) =
                FadFloat.( * ) sgn_1773  brake_1768 in
            self.m_1806 <- signed_load_1774 ;
            self.m_1803 <- x_1791 ;
            (begin match self.s_1780 with
                   | At_First_630 ->
                       (if self.r_1781 then ()) ;
                       (begin match (!shiftv_1784 , !shiftp_1785) with
                              | (At_common.UP , true) ->
                                  self.nx_1800 <- Autotransd.gear2 ;
                                  self.r_1781 <- true ;
                                  self.s_1780 <- At_Second_631
                              | _ -> self.r_1781 <- false  end)
                   | At_Second_631 ->
                       (if self.r_1781 then ()) ;
                       (begin match (!shiftv_1784 , !shiftp_1785) with
                              | (At_common.DOWN , true) ->
                                  self.nx_1800 <- Autotransd.gear1 ;
                                  self.r_1781 <- true ;
                                  self.s_1780 <- At_First_630
                              | (At_common.UP , true) ->
                                  self.nx_1800 <- Autotransd.gear3 ;
                                  self.r_1781 <- true ;
                                  self.s_1780 <- At_Third_632
                              | _ -> self.r_1781 <- false  end)
                   | At_Third_632 ->
                       (if self.r_1781 then ()) ;
                       (begin match (!shiftv_1784 , !shiftp_1785) with
                              | (At_common.DOWN , true) ->
                                  self.nx_1800 <- Autotransd.gear2 ;
                                  self.r_1781 <- true ;
                                  self.s_1780 <- At_Second_631
                              | (At_common.UP , true) ->
                                  self.nx_1800 <- Autotransd.gear4 ;
                                  self.r_1781 <- true ;
                                  self.s_1780 <- At_Fourth_633
                              | _ -> self.r_1781 <- false  end)
                   | At_Fourth_633 ->
                       (if self.r_1781 then ()) ;
                       (begin match (!shiftv_1784 , !shiftp_1785) with
                              | (At_common.DOWN , true) ->
                                  self.nx_1800 <- Autotransd.gear3 ;
                                  self.r_1781 <- true ;
                                  self.s_1780 <- At_Third_632
                              | _ -> self.r_1781 <- false  end)
                    end) ;
            (let (te_1744:FadFloat.t) =
                 At_common.lookup_engine (throttle_1727 , x_1753) in
             let (drpm_1742:FadFloat.t) = FadFloat.(-) te_1744  ti_1737 in
             let (dx_1746:FadFloat.t) =
                 FadFloat.scale drpm_1742  At_common.engine_feedback_gain in
             self.m_1798 <- FadFloat.(+) x_1753 
                                         (FadFloat.( * ) dx_1746  x_1797) ;
             self.m_1795 <- x_1791 ;
             (let (x_1789:FadFloat.t) = self.m_1788 in
              self.m_1790 <- x_1789 ;
              self.m_1788 <- FadFloat.(+) x_1789  tstep'_1728 ;
              ((FadFloat.get x_1789) , outp_1720 , rob_1721)))))))))):
    float * FadFloat.t Array.t * FadFloat.t) in
  Node { alloc = autotrans_at54_alloc; reset = autotrans_at54_reset ;
                                       step = autotrans_at54_step }
type ('s ,
      'r ,
      'q ,
      'p ,
      'o ,
      'n , 'm , 'l , 'k , 'j , 'i , 'h , 'g , 'f , 'e , 'd , 'c , 'b , 'a) _autotrans_at6a =
  { mutable i_2128 : 's ;
    mutable i_1908 : 'r ;
    mutable m_1905 : 'q ;
    mutable m_1903 : 'p ;
    mutable m_1900 : 'o ;
    mutable m_1898 : 'n ;
    mutable nx_1897 : 'm ;
    mutable m_1895 : 'l ;
    mutable m_1892 : 'k ;
    mutable m_1887 : 'j ;
    mutable m_1885 : 'i ;
    mutable r_1880 : 'h ;
    mutable s_1879 : 'g ;
    mutable r_1878 : 'f ;
    mutable s_1877 : 'e ;
    mutable t0_1860 : 'd ;
    mutable t0_1859 : 'c ; mutable i_1910 : 'b ; mutable go_up_1909 : 'a }

let autotrans_at6a (tstep_1815:float) = 
  let Node { alloc = i_2128_alloc; step = i_2128_step ; reset = i_2128_reset } = at6a 
   in
  let autotrans_at6a_alloc _ =
    ();
    { i_1908 = (false:bool) ;
      m_1905 = (create ():FadFloat.t) ;
      m_1903 = (create ():FadFloat.t) ;
      m_1900 = (create ():FadFloat.t) ;
      m_1898 = (create ():FadFloat.t) ;
      nx_1897 = (create ():FadFloat.t) ;
      m_1895 = (create ():FadFloat.t) ;
      m_1892 = (create ():FadFloat.t) ;
      m_1887 = (create ():FadFloat.t) ;
      m_1885 = (create ():FadFloat.t) ;
      r_1880 = (false:bool) ;
      s_1879 = (At_UpShifting_709:state__9132) ;
      r_1878 = (false:bool) ;
      s_1877 = (At_Fourth_706:state__9131) ;
      t0_1860 = (create ():FadFloat.t) ;
      t0_1859 = (create ():FadFloat.t) ;
      i_1910 = (false:bool) ; go_up_1909 = (false:bool);
      i_2128 = i_2128_alloc () (* discrete *)  } in
  let autotrans_at6a_reset self  =
    ((self.i_1908 <- true ;
      i_2128_reset self.i_2128  ;
      self.r_1880 <- false ;
      self.s_1879 <- At_SteadyState_707 ;
      self.i_1910 <- true ;
      self.r_1878 <- false ; self.s_1877 <- At_First_703):unit) in 
  let autotrans_at6a_step self (inp_1814:(FadFloat.t)Array.t) =
    ((let shiftp_1882 = ref (false:bool) in
      let shiftv_1881 = ref (At_common.DOWN:At_common.shift) in
      let (final_drive_ratio_1866:FadFloat.t) =
          FadFloat.scale self.m_1898  At_common.p_final_drive_ratio in
      let (aux1_1864:FadFloat.t) =
          FadFloat.(-) final_drive_ratio_1866  self.m_1903 in
      let (vehicle_inertia_1875:FadFloat.t) =
          FadFloat.scale aux1_1864  At_common.iv_inv in
      (if self.i_1908 then self.m_1887 <- FadFloat.make 0.) ;
      (let (x_1888:FadFloat.t) = self.m_1887 in
       let (x_1902:FadFloat.t) =
           if self.i_1908 then x_1888 else FadFloat.(-) x_1888  self.m_1900 in
       let (x_1907:FadFloat.t) =
           if self.i_1908
           then FadFloat.make At_common.p_initial_wheel_speed
           else
             FadFloat.(+) self.m_1905 
                          (FadFloat.( * ) vehicle_inertia_1875  x_1902) in
       (if self.i_1908 then self.nx_1897 <- Autotransd.gear1) ;
       (let (x0_1845:FadFloat.t) = FadFloat.make 1000. in
        (if self.i_1908 then self.m_1895 <- x0_1845) ;
        (let (x_1894:FadFloat.t) =
             if self.i_1908 then x_1888 else FadFloat.(-) x_1888  self.m_1892 in
         let (tstep'_1825:FadFloat.t) = FadFloat.make tstep_1815 in
         (if self.i_1908 then self.m_1885 <- tstep'_1825) ;
         self.i_1908 <- false ;
         (let (xmin_1847:FadFloat.t) = FadFloat.make 600. in
          let (xmax_1846:FadFloat.t) = FadFloat.make 6000. in
          let (x_1896:FadFloat.t) = self.m_1895 in
          let (x_1850:FadFloat.t) =
              FadFloat.max xmin_1847  (FadFloat.min xmax_1846  x_1896) in
          let (gear_1858:FadFloat.t) = self.nx_1897 in
          let (linear_speed_1867:FadFloat.t) =
              FadFloat.scale x_1907  At_common.l_speed_coef in
          let (mph_1868:FadFloat.t) =
              FadFloat.scale linear_speed_1867  At_common.p_mph in
          let (outp_1819:(FadFloat.t)Array.t) =
              Array.of_list ((::) (x_1850 ,
                                   ((::) (gear_1858 ,
                                          ((::) (mph_1868 , ([]))))))) in
          let (rob_1820:FadFloat.t) =
              i_2128_step self.i_2128 (tstep'_1825 , outp_1819) in
          let (trans_rpm_1874:FadFloat.t) =
              FadFloat.scale x_1907  At_common.p_final_drive_ratio in
          let ((ti_1834:FadFloat.t) , (out_torque_1830:FadFloat.t)) =
              At_common.transmission (x_1850 , gear_1858 , trans_rpm_1874) in
          self.m_1898 <- out_torque_1830 ;
          self.m_1905 <- x_1907 ;
          (let (brake_1816:FadFloat.t) = Array.get inp_1814  1 in
           let (road_load_1869:FadFloat.t) =
               FadFloat.translate (FadFloat.scale (FadFloat.sqr mph_1868) 
                                                  At_common.p_aerodynamic_drag)
                                   At_common.p_drag_friction in
           let (brake_1865:FadFloat.t) =
               FadFloat.(+) brake_1816  road_load_1869 in
           let (sgn_1870:FadFloat.t) =
               if (>=) mph_1868  (FadFloat.make 0.)
               then FadFloat.make 1.
               else FadFloat.make (-1.) in
           let (signed_load_1871:FadFloat.t) =
               FadFloat.( * ) sgn_1870  brake_1865 in
           self.m_1903 <- signed_load_1871 ;
           self.m_1900 <- x_1888 ;
           (let (throttle_1824:FadFloat.t) = Array.get inp_1814  0 in
            let (dn_th_1854:FadFloat.t) =
                At_common.lookup_interpdn (throttle_1824 , gear_1858) in
            let (up_th_1857:FadFloat.t) =
                At_common.lookup_interpup (throttle_1824 , gear_1858) in
            (begin match self.s_1879 with
                   | At_SteadyState_707 ->
                       (if self.r_1880 then self.i_1910 <- true) ;
                       (if self.i_1910 then
                        self.go_up_1909 <- (>) (FadFloat.make (Random.float 
                                                                 1.)) 
                                               (FadFloat.make 0.5)) ;
                       self.i_1910 <- false ;
                       (begin match (((>) mph_1868  up_th_1857) ,
                                     ((<) mph_1868  dn_th_1854)) with
                              | (_ , true) ->
                                  self.t0_1859 <- x_1888 ;
                                  self.r_1880 <- true ;
                                  self.s_1879 <- At_DownShifting_708
                              | (true , _) ->
                                  self.t0_1860 <- x_1888 ;
                                  self.r_1880 <- true ;
                                  self.s_1879 <- At_UpShifting_709
                              | _ -> self.r_1880 <- false  end)
                   | At_DownShifting_708 ->
                       (if self.r_1880 then ()) ;
                       (begin match (((>) x_1888 
                                          (FadFloat.translate self.t0_1859 
                                                              At_common.twait))
                                     , ((>) mph_1868  dn_th_1854)) with
                              | (_ , true) ->
                                  self.r_1880 <- true ;
                                  self.s_1879 <- At_SteadyState_707
                              | (true , _) ->
                                  shiftp_1882 := true ;
                                  shiftv_1881 := At_common.DOWN ;
                                  self.r_1880 <- true ;
                                  self.s_1879 <- At_SteadyState_707
                              | _ -> self.r_1880 <- false  end)
                   | At_UpShifting_709 ->
                       (if self.r_1880 then ()) ;
                       (begin match (((>) x_1888 
                                          (FadFloat.translate self.t0_1860 
                                                              At_common.twait))
                                     , ((<) mph_1868  up_th_1857)) with
                              | (_ , true) ->
                                  self.r_1880 <- true ;
                                  self.s_1879 <- At_SteadyState_707
                              | (true , _) ->
                                  shiftp_1882 := true ;
                                  shiftv_1881 := At_common.UP ;
                                  self.r_1880 <- true ;
                                  self.s_1879 <- At_SteadyState_707
                              | _ -> self.r_1880 <- false  end)
                    end) ;
            (begin match self.s_1877 with
                   | At_First_703 ->
                       (if self.r_1878 then ()) ;
                       (begin match (!shiftv_1881 , !shiftp_1882) with
                              | (At_common.UP , true) ->
                                  self.nx_1897 <- Autotransd.gear2 ;
                                  self.r_1878 <- true ;
                                  self.s_1877 <- At_Second_704
                              | _ -> self.r_1878 <- false  end)
                   | At_Second_704 ->
                       (if self.r_1878 then ()) ;
                       (begin match (!shiftv_1881 , !shiftp_1882) with
                              | (At_common.DOWN , true) ->
                                  self.nx_1897 <- Autotransd.gear1 ;
                                  self.r_1878 <- true ;
                                  self.s_1877 <- At_First_703
                              | (At_common.UP , true) ->
                                  self.nx_1897 <- Autotransd.gear3 ;
                                  self.r_1878 <- true ;
                                  self.s_1877 <- At_Third_705
                              | _ -> self.r_1878 <- false  end)
                   | At_Third_705 ->
                       (if self.r_1878 then ()) ;
                       (begin match (!shiftv_1881 , !shiftp_1882) with
                              | (At_common.DOWN , true) ->
                                  self.nx_1897 <- Autotransd.gear2 ;
                                  self.r_1878 <- true ;
                                  self.s_1877 <- At_Second_704
                              | (At_common.UP , true) ->
                                  self.nx_1897 <- Autotransd.gear4 ;
                                  self.r_1878 <- true ;
                                  self.s_1877 <- At_Fourth_706
                              | _ -> self.r_1878 <- false  end)
                   | At_Fourth_706 ->
                       (if self.r_1878 then ()) ;
                       (begin match (!shiftv_1881 , !shiftp_1882) with
                              | (At_common.DOWN , true) ->
                                  self.nx_1897 <- Autotransd.gear3 ;
                                  self.r_1878 <- true ;
                                  self.s_1877 <- At_Third_705
                              | _ -> self.r_1878 <- false  end)
                    end) ;
            (let (te_1841:FadFloat.t) =
                 At_common.lookup_engine (throttle_1824 , x_1850) in
             let (drpm_1839:FadFloat.t) = FadFloat.(-) te_1841  ti_1834 in
             let (dx_1843:FadFloat.t) =
                 FadFloat.scale drpm_1839  At_common.engine_feedback_gain in
             self.m_1895 <- FadFloat.(+) x_1850 
                                         (FadFloat.( * ) dx_1843  x_1894) ;
             self.m_1892 <- x_1888 ;
             (let (x_1886:FadFloat.t) = self.m_1885 in
              self.m_1887 <- x_1886 ;
              self.m_1885 <- FadFloat.(+) x_1886  tstep'_1825 ;
              ((FadFloat.get x_1886) ,
               outp_1819 , (FadFloat.(+) rob_1820  (FadFloat.make 0.1)))))))))))):
    float * FadFloat.t Array.t * FadFloat.t) in
  Node { alloc = autotrans_at6a_alloc; reset = autotrans_at6a_reset ;
                                       step = autotrans_at6a_step }
type ('s ,
      'r ,
      'q ,
      'p ,
      'o ,
      'n , 'm , 'l , 'k , 'j , 'i , 'h , 'g , 'f , 'e , 'd , 'c , 'b , 'a) _autotrans_at6b =
  { mutable i_2129 : 's ;
    mutable i_2005 : 'r ;
    mutable m_2002 : 'q ;
    mutable m_2000 : 'p ;
    mutable m_1997 : 'o ;
    mutable m_1995 : 'n ;
    mutable nx_1994 : 'm ;
    mutable m_1992 : 'l ;
    mutable m_1989 : 'k ;
    mutable m_1984 : 'j ;
    mutable m_1982 : 'i ;
    mutable r_1977 : 'h ;
    mutable s_1976 : 'g ;
    mutable r_1975 : 'f ;
    mutable s_1974 : 'e ;
    mutable t0_1957 : 'd ;
    mutable t0_1956 : 'c ; mutable i_2007 : 'b ; mutable go_up_2006 : 'a }

let autotrans_at6b (tstep_1912:float) = 
  let Node { alloc = i_2129_alloc; step = i_2129_step ; reset = i_2129_reset } = at6b 
   in
  let autotrans_at6b_alloc _ =
    ();
    { i_2005 = (false:bool) ;
      m_2002 = (create ():FadFloat.t) ;
      m_2000 = (create ():FadFloat.t) ;
      m_1997 = (create ():FadFloat.t) ;
      m_1995 = (create ():FadFloat.t) ;
      nx_1994 = (create ():FadFloat.t) ;
      m_1992 = (create ():FadFloat.t) ;
      m_1989 = (create ():FadFloat.t) ;
      m_1984 = (create ():FadFloat.t) ;
      m_1982 = (create ():FadFloat.t) ;
      r_1977 = (false:bool) ;
      s_1976 = (At_UpShifting_782:state__9134) ;
      r_1975 = (false:bool) ;
      s_1974 = (At_Fourth_779:state__9133) ;
      t0_1957 = (create ():FadFloat.t) ;
      t0_1956 = (create ():FadFloat.t) ;
      i_2007 = (false:bool) ; go_up_2006 = (false:bool);
      i_2129 = i_2129_alloc () (* discrete *)  } in
  let autotrans_at6b_reset self  =
    ((self.i_2005 <- true ;
      i_2129_reset self.i_2129  ;
      self.r_1977 <- false ;
      self.s_1976 <- At_SteadyState_780 ;
      self.i_2007 <- true ;
      self.r_1975 <- false ; self.s_1974 <- At_First_776):unit) in 
  let autotrans_at6b_step self (inp_1911:(FadFloat.t)Array.t) =
    ((let shiftp_1979 = ref (false:bool) in
      let shiftv_1978 = ref (At_common.DOWN:At_common.shift) in
      let (final_drive_ratio_1963:FadFloat.t) =
          FadFloat.scale self.m_1995  At_common.p_final_drive_ratio in
      let (aux1_1961:FadFloat.t) =
          FadFloat.(-) final_drive_ratio_1963  self.m_2000 in
      let (vehicle_inertia_1972:FadFloat.t) =
          FadFloat.scale aux1_1961  At_common.iv_inv in
      (if self.i_2005 then self.m_1984 <- FadFloat.make 0.) ;
      (let (x_1985:FadFloat.t) = self.m_1984 in
       let (x_1999:FadFloat.t) =
           if self.i_2005 then x_1985 else FadFloat.(-) x_1985  self.m_1997 in
       let (x_2004:FadFloat.t) =
           if self.i_2005
           then FadFloat.make At_common.p_initial_wheel_speed
           else
             FadFloat.(+) self.m_2002 
                          (FadFloat.( * ) vehicle_inertia_1972  x_1999) in
       (if self.i_2005 then self.nx_1994 <- Autotransd.gear1) ;
       (let (x0_1942:FadFloat.t) = FadFloat.make 1000. in
        (if self.i_2005 then self.m_1992 <- x0_1942) ;
        (let (x_1991:FadFloat.t) =
             if self.i_2005 then x_1985 else FadFloat.(-) x_1985  self.m_1989 in
         let (tstep'_1922:FadFloat.t) = FadFloat.make tstep_1912 in
         (if self.i_2005 then self.m_1982 <- tstep'_1922) ;
         self.i_2005 <- false ;
         (let (xmin_1944:FadFloat.t) = FadFloat.make 600. in
          let (xmax_1943:FadFloat.t) = FadFloat.make 6000. in
          let (x_1993:FadFloat.t) = self.m_1992 in
          let (x_1947:FadFloat.t) =
              FadFloat.max xmin_1944  (FadFloat.min xmax_1943  x_1993) in
          let (gear_1955:FadFloat.t) = self.nx_1994 in
          let (linear_speed_1964:FadFloat.t) =
              FadFloat.scale x_2004  At_common.l_speed_coef in
          let (mph_1965:FadFloat.t) =
              FadFloat.scale linear_speed_1964  At_common.p_mph in
          let (outp_1916:(FadFloat.t)Array.t) =
              Array.of_list ((::) (x_1947 ,
                                   ((::) (gear_1955 ,
                                          ((::) (mph_1965 , ([]))))))) in
          let (rob_1917:FadFloat.t) =
              i_2129_step self.i_2129 (tstep'_1922 , outp_1916) in
          let (trans_rpm_1971:FadFloat.t) =
              FadFloat.scale x_2004  At_common.p_final_drive_ratio in
          let ((ti_1931:FadFloat.t) , (out_torque_1927:FadFloat.t)) =
              At_common.transmission (x_1947 , gear_1955 , trans_rpm_1971) in
          self.m_1995 <- out_torque_1927 ;
          self.m_2002 <- x_2004 ;
          (let (brake_1913:FadFloat.t) = Array.get inp_1911  1 in
           let (road_load_1966:FadFloat.t) =
               FadFloat.translate (FadFloat.scale (FadFloat.sqr mph_1965) 
                                                  At_common.p_aerodynamic_drag)
                                   At_common.p_drag_friction in
           let (brake_1962:FadFloat.t) =
               FadFloat.(+) brake_1913  road_load_1966 in
           let (sgn_1967:FadFloat.t) =
               if (>=) mph_1965  (FadFloat.make 0.)
               then FadFloat.make 1.
               else FadFloat.make (-1.) in
           let (signed_load_1968:FadFloat.t) =
               FadFloat.( * ) sgn_1967  brake_1962 in
           self.m_2000 <- signed_load_1968 ;
           self.m_1997 <- x_1985 ;
           (let (throttle_1921:FadFloat.t) = Array.get inp_1911  0 in
            let (dn_th_1951:FadFloat.t) =
                At_common.lookup_interpdn (throttle_1921 , gear_1955) in
            let (up_th_1954:FadFloat.t) =
                At_common.lookup_interpup (throttle_1921 , gear_1955) in
            (begin match self.s_1976 with
                   | At_SteadyState_780 ->
                       (if self.r_1977 then self.i_2007 <- true) ;
                       (if self.i_2007 then
                        self.go_up_2006 <- (>) (FadFloat.make (Random.float 
                                                                 1.)) 
                                               (FadFloat.make 0.5)) ;
                       self.i_2007 <- false ;
                       (begin match (((>) mph_1965  up_th_1954) ,
                                     ((<) mph_1965  dn_th_1951)) with
                              | (_ , true) ->
                                  self.t0_1956 <- x_1985 ;
                                  self.r_1977 <- true ;
                                  self.s_1976 <- At_DownShifting_781
                              | (true , _) ->
                                  self.t0_1957 <- x_1985 ;
                                  self.r_1977 <- true ;
                                  self.s_1976 <- At_UpShifting_782
                              | _ -> self.r_1977 <- false  end)
                   | At_DownShifting_781 ->
                       (if self.r_1977 then ()) ;
                       (begin match (((>) x_1985 
                                          (FadFloat.translate self.t0_1956 
                                                              At_common.twait))
                                     , ((>) mph_1965  dn_th_1951)) with
                              | (_ , true) ->
                                  self.r_1977 <- true ;
                                  self.s_1976 <- At_SteadyState_780
                              | (true , _) ->
                                  shiftp_1979 := true ;
                                  shiftv_1978 := At_common.DOWN ;
                                  self.r_1977 <- true ;
                                  self.s_1976 <- At_SteadyState_780
                              | _ -> self.r_1977 <- false  end)
                   | At_UpShifting_782 ->
                       (if self.r_1977 then ()) ;
                       (begin match (((>) x_1985 
                                          (FadFloat.translate self.t0_1957 
                                                              At_common.twait))
                                     , ((<) mph_1965  up_th_1954)) with
                              | (_ , true) ->
                                  self.r_1977 <- true ;
                                  self.s_1976 <- At_SteadyState_780
                              | (true , _) ->
                                  shiftp_1979 := true ;
                                  shiftv_1978 := At_common.UP ;
                                  self.r_1977 <- true ;
                                  self.s_1976 <- At_SteadyState_780
                              | _ -> self.r_1977 <- false  end)
                    end) ;
            (begin match self.s_1974 with
                   | At_First_776 ->
                       (if self.r_1975 then ()) ;
                       (begin match (!shiftv_1978 , !shiftp_1979) with
                              | (At_common.UP , true) ->
                                  self.nx_1994 <- Autotransd.gear2 ;
                                  self.r_1975 <- true ;
                                  self.s_1974 <- At_Second_777
                              | _ -> self.r_1975 <- false  end)
                   | At_Second_777 ->
                       (if self.r_1975 then ()) ;
                       (begin match (!shiftv_1978 , !shiftp_1979) with
                              | (At_common.DOWN , true) ->
                                  self.nx_1994 <- Autotransd.gear1 ;
                                  self.r_1975 <- true ;
                                  self.s_1974 <- At_First_776
                              | (At_common.UP , true) ->
                                  self.nx_1994 <- Autotransd.gear3 ;
                                  self.r_1975 <- true ;
                                  self.s_1974 <- At_Third_778
                              | _ -> self.r_1975 <- false  end)
                   | At_Third_778 ->
                       (if self.r_1975 then ()) ;
                       (begin match (!shiftv_1978 , !shiftp_1979) with
                              | (At_common.DOWN , true) ->
                                  self.nx_1994 <- Autotransd.gear2 ;
                                  self.r_1975 <- true ;
                                  self.s_1974 <- At_Second_777
                              | (At_common.UP , true) ->
                                  self.nx_1994 <- Autotransd.gear4 ;
                                  self.r_1975 <- true ;
                                  self.s_1974 <- At_Fourth_779
                              | _ -> self.r_1975 <- false  end)
                   | At_Fourth_779 ->
                       (if self.r_1975 then ()) ;
                       (begin match (!shiftv_1978 , !shiftp_1979) with
                              | (At_common.DOWN , true) ->
                                  self.nx_1994 <- Autotransd.gear3 ;
                                  self.r_1975 <- true ;
                                  self.s_1974 <- At_Third_778
                              | _ -> self.r_1975 <- false  end)
                    end) ;
            (let (te_1938:FadFloat.t) =
                 At_common.lookup_engine (throttle_1921 , x_1947) in
             let (drpm_1936:FadFloat.t) = FadFloat.(-) te_1938  ti_1931 in
             let (dx_1940:FadFloat.t) =
                 FadFloat.scale drpm_1936  At_common.engine_feedback_gain in
             self.m_1992 <- FadFloat.(+) x_1947 
                                         (FadFloat.( * ) dx_1940  x_1991) ;
             self.m_1989 <- x_1985 ;
             (let (x_1983:FadFloat.t) = self.m_1982 in
              self.m_1984 <- x_1983 ;
              self.m_1982 <- FadFloat.(+) x_1983  tstep'_1922 ;
              ((FadFloat.get x_1983) , outp_1916 , rob_1917)))))))))):
    float * FadFloat.t Array.t * FadFloat.t) in
  Node { alloc = autotrans_at6b_alloc; reset = autotrans_at6b_reset ;
                                       step = autotrans_at6b_step }
type ('s ,
      'r ,
      'q ,
      'p ,
      'o ,
      'n , 'm , 'l , 'k , 'j , 'i , 'h , 'g , 'f , 'e , 'd , 'c , 'b , 'a) _autotrans_at6c =
  { mutable i_2130 : 's ;
    mutable i_2102 : 'r ;
    mutable m_2099 : 'q ;
    mutable m_2097 : 'p ;
    mutable m_2094 : 'o ;
    mutable m_2092 : 'n ;
    mutable nx_2091 : 'm ;
    mutable m_2089 : 'l ;
    mutable m_2086 : 'k ;
    mutable m_2081 : 'j ;
    mutable m_2079 : 'i ;
    mutable r_2074 : 'h ;
    mutable s_2073 : 'g ;
    mutable r_2072 : 'f ;
    mutable s_2071 : 'e ;
    mutable t0_2054 : 'd ;
    mutable t0_2053 : 'c ; mutable i_2104 : 'b ; mutable go_up_2103 : 'a }

let autotrans_at6c (tstep_2009:float) = 
  let Node { alloc = i_2130_alloc; step = i_2130_step ; reset = i_2130_reset } = at6c 
   in
  let autotrans_at6c_alloc _ =
    ();
    { i_2102 = (false:bool) ;
      m_2099 = (create ():FadFloat.t) ;
      m_2097 = (create ():FadFloat.t) ;
      m_2094 = (create ():FadFloat.t) ;
      m_2092 = (create ():FadFloat.t) ;
      nx_2091 = (create ():FadFloat.t) ;
      m_2089 = (create ():FadFloat.t) ;
      m_2086 = (create ():FadFloat.t) ;
      m_2081 = (create ():FadFloat.t) ;
      m_2079 = (create ():FadFloat.t) ;
      r_2074 = (false:bool) ;
      s_2073 = (At_UpShifting_855:state__9136) ;
      r_2072 = (false:bool) ;
      s_2071 = (At_Fourth_852:state__9135) ;
      t0_2054 = (create ():FadFloat.t) ;
      t0_2053 = (create ():FadFloat.t) ;
      i_2104 = (false:bool) ; go_up_2103 = (false:bool);
      i_2130 = i_2130_alloc () (* discrete *)  } in
  let autotrans_at6c_reset self  =
    ((self.i_2102 <- true ;
      i_2130_reset self.i_2130  ;
      self.r_2074 <- false ;
      self.s_2073 <- At_SteadyState_853 ;
      self.i_2104 <- true ;
      self.r_2072 <- false ; self.s_2071 <- At_First_849):unit) in 
  let autotrans_at6c_step self (inp_2008:(FadFloat.t)Array.t) =
    ((let shiftp_2076 = ref (false:bool) in
      let shiftv_2075 = ref (At_common.DOWN:At_common.shift) in
      let (final_drive_ratio_2060:FadFloat.t) =
          FadFloat.scale self.m_2092  At_common.p_final_drive_ratio in
      let (aux1_2058:FadFloat.t) =
          FadFloat.(-) final_drive_ratio_2060  self.m_2097 in
      let (vehicle_inertia_2069:FadFloat.t) =
          FadFloat.scale aux1_2058  At_common.iv_inv in
      (if self.i_2102 then self.m_2081 <- FadFloat.make 0.) ;
      (let (x_2082:FadFloat.t) = self.m_2081 in
       let (x_2096:FadFloat.t) =
           if self.i_2102 then x_2082 else FadFloat.(-) x_2082  self.m_2094 in
       let (x_2101:FadFloat.t) =
           if self.i_2102
           then FadFloat.make At_common.p_initial_wheel_speed
           else
             FadFloat.(+) self.m_2099 
                          (FadFloat.( * ) vehicle_inertia_2069  x_2096) in
       (if self.i_2102 then self.nx_2091 <- Autotransd.gear1) ;
       (let (x0_2039:FadFloat.t) = FadFloat.make 1000. in
        (if self.i_2102 then self.m_2089 <- x0_2039) ;
        (let (x_2088:FadFloat.t) =
             if self.i_2102 then x_2082 else FadFloat.(-) x_2082  self.m_2086 in
         let (tstep'_2019:FadFloat.t) = FadFloat.make tstep_2009 in
         (if self.i_2102 then self.m_2079 <- tstep'_2019) ;
         self.i_2102 <- false ;
         (let (xmin_2041:FadFloat.t) = FadFloat.make 600. in
          let (xmax_2040:FadFloat.t) = FadFloat.make 6000. in
          let (x_2090:FadFloat.t) = self.m_2089 in
          let (x_2044:FadFloat.t) =
              FadFloat.max xmin_2041  (FadFloat.min xmax_2040  x_2090) in
          let (gear_2052:FadFloat.t) = self.nx_2091 in
          let (linear_speed_2061:FadFloat.t) =
              FadFloat.scale x_2101  At_common.l_speed_coef in
          let (mph_2062:FadFloat.t) =
              FadFloat.scale linear_speed_2061  At_common.p_mph in
          let (outp_2013:(FadFloat.t)Array.t) =
              Array.of_list ((::) (x_2044 ,
                                   ((::) (gear_2052 ,
                                          ((::) (mph_2062 , ([]))))))) in
          let (rob_2014:FadFloat.t) =
              i_2130_step self.i_2130 (tstep'_2019 , outp_2013) in
          let (trans_rpm_2068:FadFloat.t) =
              FadFloat.scale x_2101  At_common.p_final_drive_ratio in
          let ((ti_2028:FadFloat.t) , (out_torque_2024:FadFloat.t)) =
              At_common.transmission (x_2044 , gear_2052 , trans_rpm_2068) in
          self.m_2092 <- out_torque_2024 ;
          self.m_2099 <- x_2101 ;
          (let (brake_2010:FadFloat.t) = Array.get inp_2008  1 in
           let (road_load_2063:FadFloat.t) =
               FadFloat.translate (FadFloat.scale (FadFloat.sqr mph_2062) 
                                                  At_common.p_aerodynamic_drag)
                                   At_common.p_drag_friction in
           let (brake_2059:FadFloat.t) =
               FadFloat.(+) brake_2010  road_load_2063 in
           let (sgn_2064:FadFloat.t) =
               if (>=) mph_2062  (FadFloat.make 0.)
               then FadFloat.make 1.
               else FadFloat.make (-1.) in
           let (signed_load_2065:FadFloat.t) =
               FadFloat.( * ) sgn_2064  brake_2059 in
           self.m_2097 <- signed_load_2065 ;
           self.m_2094 <- x_2082 ;
           (let (throttle_2018:FadFloat.t) = Array.get inp_2008  0 in
            let (dn_th_2048:FadFloat.t) =
                At_common.lookup_interpdn (throttle_2018 , gear_2052) in
            let (up_th_2051:FadFloat.t) =
                At_common.lookup_interpup (throttle_2018 , gear_2052) in
            (begin match self.s_2073 with
                   | At_SteadyState_853 ->
                       (if self.r_2074 then self.i_2104 <- true) ;
                       (if self.i_2104 then
                        self.go_up_2103 <- (>) (FadFloat.make (Random.float 
                                                                 1.)) 
                                               (FadFloat.make 0.5)) ;
                       self.i_2104 <- false ;
                       (begin match (((>) mph_2062  up_th_2051) ,
                                     ((<) mph_2062  dn_th_2048)) with
                              | (_ , true) ->
                                  self.t0_2053 <- x_2082 ;
                                  self.r_2074 <- true ;
                                  self.s_2073 <- At_DownShifting_854
                              | (true , _) ->
                                  self.t0_2054 <- x_2082 ;
                                  self.r_2074 <- true ;
                                  self.s_2073 <- At_UpShifting_855
                              | _ -> self.r_2074 <- false  end)
                   | At_DownShifting_854 ->
                       (if self.r_2074 then ()) ;
                       (begin match (((>) x_2082 
                                          (FadFloat.translate self.t0_2053 
                                                              At_common.twait))
                                     , ((>) mph_2062  dn_th_2048)) with
                              | (_ , true) ->
                                  self.r_2074 <- true ;
                                  self.s_2073 <- At_SteadyState_853
                              | (true , _) ->
                                  shiftp_2076 := true ;
                                  shiftv_2075 := At_common.DOWN ;
                                  self.r_2074 <- true ;
                                  self.s_2073 <- At_SteadyState_853
                              | _ -> self.r_2074 <- false  end)
                   | At_UpShifting_855 ->
                       (if self.r_2074 then ()) ;
                       (begin match (((>) x_2082 
                                          (FadFloat.translate self.t0_2054 
                                                              At_common.twait))
                                     , ((<) mph_2062  up_th_2051)) with
                              | (_ , true) ->
                                  self.r_2074 <- true ;
                                  self.s_2073 <- At_SteadyState_853
                              | (true , _) ->
                                  shiftp_2076 := true ;
                                  shiftv_2075 := At_common.UP ;
                                  self.r_2074 <- true ;
                                  self.s_2073 <- At_SteadyState_853
                              | _ -> self.r_2074 <- false  end)
                    end) ;
            (begin match self.s_2071 with
                   | At_First_849 ->
                       (if self.r_2072 then ()) ;
                       (begin match (!shiftv_2075 , !shiftp_2076) with
                              | (At_common.UP , true) ->
                                  self.nx_2091 <- Autotransd.gear2 ;
                                  self.r_2072 <- true ;
                                  self.s_2071 <- At_Second_850
                              | _ -> self.r_2072 <- false  end)
                   | At_Second_850 ->
                       (if self.r_2072 then ()) ;
                       (begin match (!shiftv_2075 , !shiftp_2076) with
                              | (At_common.DOWN , true) ->
                                  self.nx_2091 <- Autotransd.gear1 ;
                                  self.r_2072 <- true ;
                                  self.s_2071 <- At_First_849
                              | (At_common.UP , true) ->
                                  self.nx_2091 <- Autotransd.gear3 ;
                                  self.r_2072 <- true ;
                                  self.s_2071 <- At_Third_851
                              | _ -> self.r_2072 <- false  end)
                   | At_Third_851 ->
                       (if self.r_2072 then ()) ;
                       (begin match (!shiftv_2075 , !shiftp_2076) with
                              | (At_common.DOWN , true) ->
                                  self.nx_2091 <- Autotransd.gear2 ;
                                  self.r_2072 <- true ;
                                  self.s_2071 <- At_Second_850
                              | (At_common.UP , true) ->
                                  self.nx_2091 <- Autotransd.gear4 ;
                                  self.r_2072 <- true ;
                                  self.s_2071 <- At_Fourth_852
                              | _ -> self.r_2072 <- false  end)
                   | At_Fourth_852 ->
                       (if self.r_2072 then ()) ;
                       (begin match (!shiftv_2075 , !shiftp_2076) with
                              | (At_common.DOWN , true) ->
                                  self.nx_2091 <- Autotransd.gear3 ;
                                  self.r_2072 <- true ;
                                  self.s_2071 <- At_Third_851
                              | _ -> self.r_2072 <- false  end)
                    end) ;
            (let (te_2035:FadFloat.t) =
                 At_common.lookup_engine (throttle_2018 , x_2044) in
             let (drpm_2033:FadFloat.t) = FadFloat.(-) te_2035  ti_2028 in
             let (dx_2037:FadFloat.t) =
                 FadFloat.scale drpm_2033  At_common.engine_feedback_gain in
             self.m_2089 <- FadFloat.(+) x_2044 
                                         (FadFloat.( * ) dx_2037  x_2088) ;
             self.m_2086 <- x_2082 ;
             (let (x_2080:FadFloat.t) = self.m_2079 in
              self.m_2081 <- x_2080 ;
              self.m_2079 <- FadFloat.(+) x_2080  tstep'_2019 ;
              ((FadFloat.get x_2080) , outp_2013 , rob_2014)))))))))):
    float * FadFloat.t Array.t * FadFloat.t) in
  Node { alloc = autotrans_at6c_alloc; reset = autotrans_at6c_reset ;
                                       step = autotrans_at6c_step }
