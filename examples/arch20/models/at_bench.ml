(* The Zélus compiler, version 2.0
  (jeudi 4 juin 2020, 17:57:12 (UTC+0200)) *)
open Ztypes
type state__8769 =
At_bench_UpShifting_860
| At_bench_DownShifting_859 | At_bench_SteadyState_858 
type state__8768 =
At_bench_Fourth_857
| At_bench_Third_856 | At_bench_Second_855 | At_bench_First_854 
type state__8767 =
At_bench_UpShifting_792
| At_bench_DownShifting_791 | At_bench_SteadyState_790 
type state__8766 =
At_bench_Fourth_789
| At_bench_Third_788 | At_bench_Second_787 | At_bench_First_786 
type state__8765 =
At_bench_UpShifting_724
| At_bench_DownShifting_723 | At_bench_SteadyState_722 
type state__8764 =
At_bench_Fourth_721
| At_bench_Third_720 | At_bench_Second_719 | At_bench_First_718 
type state__8763 =
At_bench_UpShifting_655
| At_bench_DownShifting_654 | At_bench_SteadyState_653 
type state__8762 =
At_bench_Fourth_652
| At_bench_Third_651 | At_bench_Second_650 | At_bench_First_649 
type state__8761 =
At_bench_UpShifting_582
| At_bench_DownShifting_581 | At_bench_SteadyState_580 
type state__8760 =
At_bench_Fourth_579
| At_bench_Third_578 | At_bench_Second_577 | At_bench_First_576 
type state__8759 =
At_bench_UpShifting_509
| At_bench_DownShifting_508 | At_bench_SteadyState_507 
type state__8758 =
At_bench_Fourth_506
| At_bench_Third_505 | At_bench_Second_504 | At_bench_First_503 
type state__8757 =
At_bench_UpShifting_436
| At_bench_DownShifting_435 | At_bench_SteadyState_434 
type state__8756 =
At_bench_Fourth_433
| At_bench_Third_432 | At_bench_Second_431 | At_bench_First_430 
type state__8755 =
At_bench_UpShifting_364
| At_bench_DownShifting_363 | At_bench_SteadyState_362 
type state__8754 =
At_bench_Fourth_361
| At_bench_Third_360 | At_bench_Second_359 | At_bench_First_358 
type state__8753 =
At_bench_UpShifting_296
| At_bench_DownShifting_295 | At_bench_SteadyState_294 
type state__8752 =
At_bench_Fourth_293
| At_bench_Third_292 | At_bench_Second_291 | At_bench_First_290 
open MyOp
open Discrete_obs_fad
type ('a) _at1 =
  { mutable i_2034 : 'a }

let at1  = 
  let Node { alloc = i_2034_alloc; step = i_2034_step ; reset = i_2034_reset } = 
  Discrete_obs_fad.always_timed 20.  in
  let at1_alloc _ =
    ();{ i_2034 = i_2034_alloc () (* discrete *)  } in
  let at1_reset self  =
    (i_2034_reset self.i_2034 :unit) in 
  let at1_step self ((tstep_1147:MyOp.t) ,
                     (inp_1145:'a5224) , (outp_1146:(MyOp.t)Array.t)) =
    ((let (speed_1148:MyOp.t) = Array.get outp_1146  2 in
      i_2034_step self.i_2034
        (tstep_1147 , (Discrete_obs_fad.q_lt (speed_1148 , (MyOp.make 120.))))):
    MyOp.t) in
  Node { alloc = at1_alloc; reset = at1_reset ; step = at1_step }
type ('a) _at2 =
  { mutable i_2035 : 'a }

let at2  = 
  let Node { alloc = i_2035_alloc; step = i_2035_step ; reset = i_2035_reset } = 
  Discrete_obs_fad.always_timed 10.  in
  let at2_alloc _ =
    ();{ i_2035 = i_2035_alloc () (* discrete *)  } in
  let at2_reset self  =
    (i_2035_reset self.i_2035 :unit) in 
  let at2_step self ((tstep_1151:MyOp.t) ,
                     (inp_1149:'a5244) , (outp_1150:(MyOp.t)Array.t)) =
    ((let (rpm_1152:MyOp.t) = Array.get outp_1150  0 in
      i_2035_step self.i_2035
        (tstep_1151 , (Discrete_obs_fad.q_lt (rpm_1152 , (MyOp.make 4750.))))):
    MyOp.t) in
  Node { alloc = at2_alloc; reset = at2_reset ; step = at2_step }
type ('e , 'd , 'c , 'b , 'a) _at5 =
  { mutable i_2038 : 'e ;
    mutable i_2037 : 'd ;
    mutable i_2036 : 'c ; mutable i_1162 : 'b ; mutable m_1160 : 'a }

let at5 (geari_1153:float) = 
  let Node { alloc = i_2038_alloc; step = i_2038_step ; reset = i_2038_reset } = Discrete_obs_fad.q_up 
   in 
  let Node { alloc = i_2037_alloc; step = i_2037_step ; reset = i_2037_reset } = 
  Discrete_obs_fad.always_timed 30.  in 
  let Node { alloc = i_2036_alloc; step = i_2036_step ; reset = i_2036_reset } = 
  Discrete_obs_fad.alwaysBfromA_timed 2.5  in
  let at5_alloc _ =
    ();
    { i_1162 = (false:bool) ; m_1160 = (create ():MyOp.t);
      i_2038 = i_2038_alloc () (* discrete *)  ;
      i_2037 = i_2037_alloc () (* discrete *)  ;
      i_2036 = i_2036_alloc () (* discrete *)  } in
  let at5_reset self  =
    ((self.i_1162 <- true ;
      i_2038_reset self.i_2038  ;
      i_2037_reset self.i_2037  ; i_2036_reset self.i_2036 ):unit) in 
  let at5_step self ((tstep_1156:MyOp.t) ,
                     (inp_1154:'a5265) , (outp_1155:(MyOp.t)Array.t)) =
    (((if self.i_1162 then self.m_1160 <- Discrete_obs_fad.q_true) ;
      self.i_1162 <- false ;
      (let (x_1161:MyOp.t) = self.m_1160 in
       self.m_1160 <- Discrete_obs_fad.q_false ;
       (let (gear_1157:MyOp.t) = Array.get outp_1155  1 in
        let (switch_1159:MyOp.t) =
            Discrete_obs_fad.q_and ((Discrete_obs_fad.q_not x_1161) ,
                                    (i_2038_step self.i_2038
                                       (Discrete_obs_fad.q_eqi (gear_1157 ,
                                                                (MyOp.make 
                                                                   geari_1153))))) in
        i_2037_step self.i_2037
          (tstep_1156 ,
           (i_2036_step self.i_2036
              (tstep_1156 ,
               switch_1159 ,
               (Discrete_obs_fad.q_eqi (gear_1157 , (MyOp.make geari_1153))))))))):
    MyOp.t) in
  Node { alloc = at5_alloc; reset = at5_reset ; step = at5_step }
type ('e , 'd , 'c , 'b , 'a) _at51 =
  { mutable i_2041 : 'e ;
    mutable i_2040 : 'd ;
    mutable i_2039 : 'c ; mutable i_1175 : 'b ; mutable m_1173 : 'a }

let at51  = 
  let Node { alloc = i_2041_alloc; step = i_2041_step ; reset = i_2041_reset } = Discrete_obs_fad.q_up 
   in 
  let Node { alloc = i_2040_alloc; step = i_2040_step ; reset = i_2040_reset } = 
  Discrete_obs_fad.always_timed 30.  in 
  let Node { alloc = i_2039_alloc; step = i_2039_step ; reset = i_2039_reset } = 
  Discrete_obs_fad.alwaysBfromA_timed 2.5  in
  let at51_alloc _ =
    ();
    { i_1175 = (false:bool) ; m_1173 = (create ():MyOp.t);
      i_2041 = i_2041_alloc () (* discrete *)  ;
      i_2040 = i_2040_alloc () (* discrete *)  ;
      i_2039 = i_2039_alloc () (* discrete *)  } in
  let at51_reset self  =
    ((self.i_1175 <- true ;
      i_2041_reset self.i_2041  ;
      i_2040_reset self.i_2040  ; i_2039_reset self.i_2039 ):unit) in 
  let at51_step self ((tstep_1165:MyOp.t) ,
                      (inp_1163:'a5305) , (outp_1164:(MyOp.t)Array.t)) =
    (((if self.i_1175 then self.m_1173 <- Discrete_obs_fad.q_true) ;
      self.i_1175 <- false ;
      (let (x_1174:MyOp.t) = self.m_1173 in
       self.m_1173 <- Discrete_obs_fad.q_false ;
       (let (gear_1170:MyOp.t) = Array.get outp_1164  1 in
        let (switch_1172:MyOp.t) =
            Discrete_obs_fad.q_and ((Discrete_obs_fad.q_not x_1174) ,
                                    (i_2041_step self.i_2041
                                       (Discrete_obs_fad.q_eqi (gear_1170 ,
                                                                (MyOp.make 1.))))) in
        i_2040_step self.i_2040
          (tstep_1165 ,
           (i_2039_step self.i_2039
              (tstep_1165 ,
               switch_1172 ,
               (Discrete_obs_fad.q_eqi (gear_1170 , (MyOp.make 1.))))))))):
    MyOp.t) in
  Node { alloc = at51_alloc; reset = at51_reset ; step = at51_step }
type ('e , 'd , 'c , 'b , 'a) _at52 =
  { mutable i_2044 : 'e ;
    mutable i_2043 : 'd ;
    mutable i_2042 : 'c ; mutable i_1188 : 'b ; mutable m_1186 : 'a }

let at52  = 
  let Node { alloc = i_2044_alloc; step = i_2044_step ; reset = i_2044_reset } = Discrete_obs_fad.q_up 
   in 
  let Node { alloc = i_2043_alloc; step = i_2043_step ; reset = i_2043_reset } = 
  Discrete_obs_fad.always_timed 30.  in 
  let Node { alloc = i_2042_alloc; step = i_2042_step ; reset = i_2042_reset } = 
  Discrete_obs_fad.alwaysBfromA_timed 2.5  in
  let at52_alloc _ =
    ();
    { i_1188 = (false:bool) ; m_1186 = (create ():MyOp.t);
      i_2044 = i_2044_alloc () (* discrete *)  ;
      i_2043 = i_2043_alloc () (* discrete *)  ;
      i_2042 = i_2042_alloc () (* discrete *)  } in
  let at52_reset self  =
    ((self.i_1188 <- true ;
      i_2044_reset self.i_2044  ;
      i_2043_reset self.i_2043  ; i_2042_reset self.i_2042 ):unit) in 
  let at52_step self ((tstep_1178:MyOp.t) ,
                      (inp_1176:'a5343) , (outp_1177:(MyOp.t)Array.t)) =
    (((if self.i_1188 then self.m_1186 <- Discrete_obs_fad.q_true) ;
      self.i_1188 <- false ;
      (let (x_1187:MyOp.t) = self.m_1186 in
       self.m_1186 <- Discrete_obs_fad.q_false ;
       (let (gear_1183:MyOp.t) = Array.get outp_1177  1 in
        let (switch_1185:MyOp.t) =
            Discrete_obs_fad.q_and ((Discrete_obs_fad.q_not x_1187) ,
                                    (i_2044_step self.i_2044
                                       (Discrete_obs_fad.q_eqi (gear_1183 ,
                                                                (MyOp.make 2.))))) in
        i_2043_step self.i_2043
          (tstep_1178 ,
           (i_2042_step self.i_2042
              (tstep_1178 ,
               switch_1185 ,
               (Discrete_obs_fad.q_eqi (gear_1183 , (MyOp.make 2.))))))))):
    MyOp.t) in
  Node { alloc = at52_alloc; reset = at52_reset ; step = at52_step }
type ('e , 'd , 'c , 'b , 'a) _at53 =
  { mutable i_2047 : 'e ;
    mutable i_2046 : 'd ;
    mutable i_2045 : 'c ; mutable i_1201 : 'b ; mutable m_1199 : 'a }

let at53  = 
  let Node { alloc = i_2047_alloc; step = i_2047_step ; reset = i_2047_reset } = Discrete_obs_fad.q_up 
   in 
  let Node { alloc = i_2046_alloc; step = i_2046_step ; reset = i_2046_reset } = 
  Discrete_obs_fad.always_timed 30.  in 
  let Node { alloc = i_2045_alloc; step = i_2045_step ; reset = i_2045_reset } = 
  Discrete_obs_fad.alwaysBfromA_timed 2.5  in
  let at53_alloc _ =
    ();
    { i_1201 = (false:bool) ; m_1199 = (create ():MyOp.t);
      i_2047 = i_2047_alloc () (* discrete *)  ;
      i_2046 = i_2046_alloc () (* discrete *)  ;
      i_2045 = i_2045_alloc () (* discrete *)  } in
  let at53_reset self  =
    ((self.i_1201 <- true ;
      i_2047_reset self.i_2047  ;
      i_2046_reset self.i_2046  ; i_2045_reset self.i_2045 ):unit) in 
  let at53_step self ((tstep_1191:MyOp.t) ,
                      (inp_1189:'a5381) , (outp_1190:(MyOp.t)Array.t)) =
    (((if self.i_1201 then self.m_1199 <- Discrete_obs_fad.q_true) ;
      self.i_1201 <- false ;
      (let (x_1200:MyOp.t) = self.m_1199 in
       self.m_1199 <- Discrete_obs_fad.q_false ;
       (let (gear_1196:MyOp.t) = Array.get outp_1190  1 in
        let (switch_1198:MyOp.t) =
            Discrete_obs_fad.q_and ((Discrete_obs_fad.q_not x_1200) ,
                                    (i_2047_step self.i_2047
                                       (Discrete_obs_fad.q_eqi (gear_1196 ,
                                                                (MyOp.make 3.))))) in
        i_2046_step self.i_2046
          (tstep_1191 ,
           (i_2045_step self.i_2045
              (tstep_1191 ,
               switch_1198 ,
               (Discrete_obs_fad.q_eqi (gear_1196 , (MyOp.make 3.))))))))):
    MyOp.t) in
  Node { alloc = at53_alloc; reset = at53_reset ; step = at53_step }
type ('e , 'd , 'c , 'b , 'a) _at54 =
  { mutable i_2050 : 'e ;
    mutable i_2049 : 'd ;
    mutable i_2048 : 'c ; mutable i_1214 : 'b ; mutable m_1212 : 'a }

let at54  = 
  let Node { alloc = i_2050_alloc; step = i_2050_step ; reset = i_2050_reset } = Discrete_obs_fad.q_up 
   in 
  let Node { alloc = i_2049_alloc; step = i_2049_step ; reset = i_2049_reset } = 
  Discrete_obs_fad.always_timed 30.  in 
  let Node { alloc = i_2048_alloc; step = i_2048_step ; reset = i_2048_reset } = 
  Discrete_obs_fad.alwaysBfromA_timed 2.5  in
  let at54_alloc _ =
    ();
    { i_1214 = (false:bool) ; m_1212 = (create ():MyOp.t);
      i_2050 = i_2050_alloc () (* discrete *)  ;
      i_2049 = i_2049_alloc () (* discrete *)  ;
      i_2048 = i_2048_alloc () (* discrete *)  } in
  let at54_reset self  =
    ((self.i_1214 <- true ;
      i_2050_reset self.i_2050  ;
      i_2049_reset self.i_2049  ; i_2048_reset self.i_2048 ):unit) in 
  let at54_step self ((tstep_1204:MyOp.t) ,
                      (inp_1202:'a5419) , (outp_1203:(MyOp.t)Array.t)) =
    (((if self.i_1214 then self.m_1212 <- Discrete_obs_fad.q_true) ;
      self.i_1214 <- false ;
      (let (x_1213:MyOp.t) = self.m_1212 in
       self.m_1212 <- Discrete_obs_fad.q_false ;
       (let (gear_1209:MyOp.t) = Array.get outp_1203  1 in
        let (switch_1211:MyOp.t) =
            Discrete_obs_fad.q_and ((Discrete_obs_fad.q_not x_1213) ,
                                    (i_2050_step self.i_2050
                                       (Discrete_obs_fad.q_eqi (gear_1209 ,
                                                                (MyOp.make 4.))))) in
        i_2049_step self.i_2049
          (tstep_1204 ,
           (i_2048_step self.i_2048
              (tstep_1204 ,
               switch_1211 ,
               (Discrete_obs_fad.q_eqi (gear_1209 , (MyOp.make 4.))))))))):
    MyOp.t) in
  Node { alloc = at54_alloc; reset = at54_reset ; step = at54_step }
type ('b , 'a) _at6 =
  { mutable i_2052 : 'b ; mutable i_2051 : 'a }

let at6 (tstep_1219:MyOp.t)  ((t_1218:float) , (s_1217:float)) = 
  let Node { alloc = i_2052_alloc; step = i_2052_step ; reset = i_2052_reset } = 
  Discrete_obs_fad.always_timed t_1218  in 
  let Node { alloc = i_2051_alloc; step = i_2051_step ; reset = i_2051_reset } = 
  Discrete_obs_fad.once_timed 30.  in
  let at6_alloc _ =
    ();
    { i_2052 = i_2052_alloc () (* discrete *)  ;
      i_2051 = i_2051_alloc () (* discrete *)  } in
  let at6_reset self  =
    ((i_2052_reset self.i_2052  ; i_2051_reset self.i_2051 ):unit) in 
  let at6_step self ((inp_1215:'a5451) , (outp_1216:(MyOp.t)Array.t)) =
    ((let (rpm_1220:MyOp.t) = Array.get outp_1216  0 in
      let (speed_1221:MyOp.t) = Array.get outp_1216  2 in
      let (rpm_max_1222:MyOp.t) = MyOp.make 3000. in
      let (speed_max_1223:MyOp.t) = MyOp.make s_1217 in
      Discrete_obs_fad.q_or ((i_2051_step self.i_2051
                                (tstep_1219 ,
                                 (Discrete_obs_fad.q_gt (rpm_1220 ,
                                                         rpm_max_1222)))) ,
                             (i_2052_step self.i_2052
                                (tstep_1219 ,
                                 (Discrete_obs_fad.q_lt (speed_1221 ,
                                                         speed_max_1223)))))):
    MyOp.t) in
  Node { alloc = at6_alloc; reset = at6_reset ; step = at6_step }
type ('b , 'a) _at6a =
  { mutable i_2054 : 'b ; mutable i_2053 : 'a }

let at6a  = 
  let Node { alloc = i_2054_alloc; step = i_2054_step ; reset = i_2054_reset } = 
  Discrete_obs_fad.always_timed 3.99  in 
  let Node { alloc = i_2053_alloc; step = i_2053_step ; reset = i_2053_reset } = 
  Discrete_obs_fad.once_timed 30.  in
  let at6a_alloc _ =
    ();
    { i_2054 = i_2054_alloc () (* discrete *)  ;
      i_2053 = i_2053_alloc () (* discrete *)  } in
  let at6a_reset self  =
    ((i_2054_reset self.i_2054  ; i_2053_reset self.i_2053 ):unit) in 
  let at6a_step self ((tstep_1226:MyOp.t) ,
                      (inp_1224:'a5490) , (outp_1225:(MyOp.t)Array.t)) =
    ((let (rpm_1227:MyOp.t) = Array.get outp_1225  0 in
      let (speed_1228:MyOp.t) = Array.get outp_1225  2 in
      let (rpm_max_1229:MyOp.t) = MyOp.make 3000. in
      let (speed_max_1230:MyOp.t) = MyOp.make 35. in
      Discrete_obs_fad.q_or ((i_2053_step self.i_2053
                                (tstep_1226 ,
                                 (Discrete_obs_fad.q_gt (rpm_1227 ,
                                                         rpm_max_1229)))) ,
                             (i_2054_step self.i_2054
                                (tstep_1226 ,
                                 (Discrete_obs_fad.q_lt (speed_1228 ,
                                                         speed_max_1230)))))):
    MyOp.t) in
  Node { alloc = at6a_alloc; reset = at6a_reset ; step = at6a_step }
type ('b , 'a) _at6b =
  { mutable i_2056 : 'b ; mutable i_2055 : 'a }

let at6b  = 
  let Node { alloc = i_2056_alloc; step = i_2056_step ; reset = i_2056_reset } = 
  Discrete_obs_fad.always_timed 7.99  in 
  let Node { alloc = i_2055_alloc; step = i_2055_step ; reset = i_2055_reset } = 
  Discrete_obs_fad.once_timed 30.  in
  let at6b_alloc _ =
    ();
    { i_2056 = i_2056_alloc () (* discrete *)  ;
      i_2055 = i_2055_alloc () (* discrete *)  } in
  let at6b_reset self  =
    ((i_2056_reset self.i_2056  ; i_2055_reset self.i_2055 ):unit) in 
  let at6b_step self ((tstep_1233:MyOp.t) ,
                      (inp_1231:'a5524) , (outp_1232:(MyOp.t)Array.t)) =
    ((let (rpm_1234:MyOp.t) =
          MyOp.(/) (Array.get outp_1232  0)  (MyOp.make 5000.) in
      let (speed_1235:MyOp.t) =
          MyOp.(/) (Array.get outp_1232  2)  (MyOp.make 120.) in
      let (rpm_max_1236:MyOp.t) = MyOp.make ((/.) 3000.  5000.) in
      let (speed_max_1237:MyOp.t) = MyOp.make ((/.) 50.  120.) in
      Discrete_obs_fad.q_or ((i_2055_step self.i_2055
                                (tstep_1233 ,
                                 (Discrete_obs_fad.q_gt (rpm_1234 ,
                                                         rpm_max_1236)))) ,
                             (i_2056_step self.i_2056
                                (tstep_1233 ,
                                 (Discrete_obs_fad.q_lt (speed_1235 ,
                                                         speed_max_1237)))))):
    MyOp.t) in
  Node { alloc = at6b_alloc; reset = at6b_reset ; step = at6b_step }
type ('b , 'a) _at6c =
  { mutable i_2058 : 'b ; mutable i_2057 : 'a }

let at6c  = 
  let Node { alloc = i_2058_alloc; step = i_2058_step ; reset = i_2058_reset } = 
  Discrete_obs_fad.always_timed 19.99  in 
  let Node { alloc = i_2057_alloc; step = i_2057_step ; reset = i_2057_reset } = 
  Discrete_obs_fad.once_timed 30.  in
  let at6c_alloc _ =
    ();
    { i_2058 = i_2058_alloc () (* discrete *)  ;
      i_2057 = i_2057_alloc () (* discrete *)  } in
  let at6c_reset self  =
    ((i_2058_reset self.i_2058  ; i_2057_reset self.i_2057 ):unit) in 
  let at6c_step self ((tstep_1240:MyOp.t) ,
                      (inp_1238:'a5584) , (outp_1239:(MyOp.t)Array.t)) =
    ((let (rpm_1241:MyOp.t) =
          MyOp.(/) (Array.get outp_1239  0)  (MyOp.make 5000.) in
      let (speed_1242:MyOp.t) =
          MyOp.(/) (Array.get outp_1239  2)  (MyOp.make 120.) in
      let (rpm_max_1243:MyOp.t) = MyOp.make ((/.) 3000.  5000.) in
      let (speed_max_1244:MyOp.t) = MyOp.make ((/.) 65.  120.) in
      Discrete_obs_fad.q_or ((i_2057_step self.i_2057
                                (tstep_1240 ,
                                 (Discrete_obs_fad.q_gt (rpm_1241 ,
                                                         rpm_max_1243)))) ,
                             (i_2058_step self.i_2058
                                (tstep_1240 ,
                                 (Discrete_obs_fad.q_lt (speed_1242 ,
                                                         speed_max_1244)))))):
    MyOp.t) in
  Node { alloc = at6c_alloc; reset = at6c_reset ; step = at6c_step }
type ('q ,
      'p ,
      'o ,
      'n , 'm , 'l , 'k , 'j , 'i , 'h , 'g , 'f , 'e , 'd , 'c , 'b , 'a) _autotrans_at1 =
  { mutable i_2060 : 'q ;
    mutable i_2059 : 'p ;
    mutable i_1329 : 'o ;
    mutable m_1326 : 'n ;
    mutable m_1324 : 'm ;
    mutable m_1321 : 'l ;
    mutable m_1319 : 'k ;
    mutable m_1317 : 'j ;
    mutable nx_1316 : 'i ;
    mutable m_1314 : 'h ;
    mutable m_1312 : 'g ;
    mutable r_1307 : 'f ;
    mutable s_1306 : 'e ;
    mutable r_1305 : 'd ;
    mutable s_1304 : 'c ; mutable t0_1274 : 'b ; mutable t0_1273 : 'a }

let autotrans_at1 ((tstep_1246:float): float) = 
  let Node { alloc = i_2060_alloc; step = i_2060_step ; reset = i_2060_reset } = Autotransd.engine 
   in 
  let Node { alloc = i_2059_alloc; step = i_2059_step ; reset = i_2059_reset } = at1 
   in
  let autotrans_at1_alloc _ =
    ();
    { i_1329 = (false:bool) ;
      m_1326 = (create ():MyOp.t) ;
      m_1324 = (create ():MyOp.t) ;
      m_1321 = (create ():MyOp.t) ;
      m_1319 = (create ():MyOp.t) ;
      m_1317 = (create ():MyOp.t) ;
      nx_1316 = (create ():MyOp.t) ;
      m_1314 = (create ():MyOp.t) ;
      m_1312 = (create ():MyOp.t) ;
      r_1307 = (false:bool) ;
      s_1306 = (At_bench_UpShifting_296:state__8753) ;
      r_1305 = (false:bool) ;
      s_1304 = (At_bench_Fourth_293:state__8752) ;
      t0_1274 = (create ():MyOp.t) ; t0_1273 = (create ():MyOp.t);
      i_2060 = i_2060_alloc () (* discrete *)  ;
      i_2059 = i_2059_alloc () (* discrete *)  } in
  let autotrans_at1_reset self  =
    ((self.i_1329 <- true ;
      i_2060_reset self.i_2060  ;
      i_2059_reset self.i_2059  ;
      self.r_1307 <- false ;
      self.s_1306 <- At_bench_SteadyState_294 ;
      self.r_1305 <- false ; self.s_1304 <- At_bench_First_290):unit) in 
  let autotrans_at1_step self (inp_1245:(MyOp.t)Array.t) =
    ((let shiftp_1309 = ref (false:bool) in
      let shiftv_1308 = ref (Common_myop.DOWN:Common_myop.shift) in
      (if self.i_1329 then self.nx_1316 <- Autotransd.gear1) ;
      (let (gear_1272:MyOp.t) = self.nx_1316 in
       let (gear_lookup_1285:MyOp.t) = Common_myop.lookup_gear gear_1272 in
       let (nin_1286:MyOp.t) = MyOp.( * ) self.m_1319  gear_lookup_1285 in
       let ((ti_1279:MyOp.t) , (turbine_torque_1281:MyOp.t)) =
           Common_myop.torque_converter (self.m_1317 , nin_1286) in
       let (tout_1287:MyOp.t) =
           MyOp.( * ) turbine_torque_1281  gear_lookup_1285 in
       let (final_drive_ratio_1293:MyOp.t) =
           MyOp.scale tout_1287  Common_myop.p_final_drive_ratio in
       let (aux1_1291:MyOp.t) = MyOp.(-) final_drive_ratio_1293  self.m_1324 in
       let (vehicle_inertia_1302:MyOp.t) =
           MyOp.scale aux1_1291  Common_myop.iv_inv in
       (if self.i_1329 then self.m_1314 <- MyOp.make 0.) ;
       (let (x_1315:MyOp.t) = self.m_1314 in
        let (x_1323:MyOp.t) =
            if self.i_1329 then x_1315 else MyOp.(-) x_1315  self.m_1321 in
        let (x_1328:MyOp.t) =
            if self.i_1329
            then MyOp.make Common_myop.p_initial_wheel_speed
            else
              MyOp.(+) self.m_1326  (MyOp.( * ) vehicle_inertia_1302  x_1323) in
        let (tstep'_1256:MyOp.t) = MyOp.make tstep_1246 in
        (if self.i_1329 then self.m_1312 <- tstep'_1256) ;
        self.i_1329 <- false ;
        (let (throttle_1255:MyOp.t) = Array.get inp_1245  0 in
         let (rpm_1262:MyOp.t) =
             i_2060_step self.i_2060 (x_1315 , ti_1279 , throttle_1255) in
         let (linear_speed_1294:MyOp.t) =
             MyOp.scale x_1328  Common_myop.l_speed_coef in
         let (mph_1295:MyOp.t) =
             MyOp.scale linear_speed_1294  Common_myop.p_mph in
         let (outp_1250:(MyOp.t)Array.t) =
             Array.of_list ((::) (rpm_1262 ,
                                  ((::) (gear_1272 , ((::) (mph_1295 , ([]))))))) in
         let (rob_1251:MyOp.t) =
             i_2059_step self.i_2059 (tstep'_1256 , inp_1245 , outp_1250) in
         self.m_1326 <- x_1328 ;
         (let (brake_1247:MyOp.t) = Array.get inp_1245  1 in
          let (road_load_1296:MyOp.t) =
              MyOp.translate (MyOp.scale (MyOp.sqr mph_1295) 
                                         Common_myop.p_aerodynamic_drag) 
                             Common_myop.p_drag_friction in
          let (brake_1292:MyOp.t) = MyOp.(+) brake_1247  road_load_1296 in
          let (sgn_1297:MyOp.t) =
              if (>=) mph_1295  Autotransd.zero_val
              then MyOp.make 1.
              else MyOp.make (-1.) in
          let (signed_load_1298:MyOp.t) = MyOp.( * ) sgn_1297  brake_1292 in
          self.m_1324 <- signed_load_1298 ;
          self.m_1321 <- x_1315 ;
          (let (trans_rpm_1301:MyOp.t) =
               MyOp.scale x_1328  Common_myop.p_final_drive_ratio in
           self.m_1319 <- trans_rpm_1301 ;
           self.m_1317 <- rpm_1262 ;
           (let (dn_th_1269:MyOp.t) =
                Common_myop.lookup_interpdn (throttle_1255 , gear_1272) in
            let (up_th_1271:MyOp.t) =
                Common_myop.lookup_interpup (throttle_1255 , gear_1272) in
            (begin match self.s_1306 with
                   | At_bench_SteadyState_294 ->
                       (if self.r_1307 then ()) ;
                       (begin match (((>) mph_1295  up_th_1271) ,
                                     ((<) mph_1295  dn_th_1269)) with
                              | (_ , true) ->
                                  self.t0_1273 <- x_1315 ;
                                  self.r_1307 <- true ;
                                  self.s_1306 <- At_bench_DownShifting_295
                              | (true , _) ->
                                  self.t0_1274 <- x_1315 ;
                                  self.r_1307 <- true ;
                                  self.s_1306 <- At_bench_UpShifting_296
                              | _ -> self.r_1307 <- false  end)
                   | At_bench_DownShifting_295 ->
                       (if self.r_1307 then ()) ;
                       (begin match (((>) x_1315 
                                          (MyOp.translate self.t0_1273 
                                                          Common_myop.twait))
                                     , ((>) mph_1295  dn_th_1269)) with
                              | (_ , true) ->
                                  self.r_1307 <- true ;
                                  self.s_1306 <- At_bench_SteadyState_294
                              | (true , _) ->
                                  shiftp_1309 := true ;
                                  shiftv_1308 := Common_myop.DOWN ;
                                  self.r_1307 <- true ;
                                  self.s_1306 <- At_bench_SteadyState_294
                              | _ -> self.r_1307 <- false  end)
                   | At_bench_UpShifting_296 ->
                       (if self.r_1307 then ()) ;
                       (begin match (((>) x_1315 
                                          (MyOp.translate self.t0_1274 
                                                          Common_myop.twait))
                                     , ((<) mph_1295  up_th_1271)) with
                              | (_ , true) ->
                                  self.r_1307 <- true ;
                                  self.s_1306 <- At_bench_SteadyState_294
                              | (true , _) ->
                                  shiftp_1309 := true ;
                                  shiftv_1308 := Common_myop.UP ;
                                  self.r_1307 <- true ;
                                  self.s_1306 <- At_bench_SteadyState_294
                              | _ -> self.r_1307 <- false  end)
                    end) ;
            (begin match self.s_1304 with
                   | At_bench_First_290 ->
                       (if self.r_1305 then ()) ;
                       (begin match (!shiftv_1308 , !shiftp_1309) with
                              | (Common_myop.UP , true) ->
                                  self.nx_1316 <- Autotransd.gear2 ;
                                  self.r_1305 <- true ;
                                  self.s_1304 <- At_bench_Second_291
                              | _ -> self.r_1305 <- false  end)
                   | At_bench_Second_291 ->
                       (if self.r_1305 then ()) ;
                       (begin match (!shiftv_1308 , !shiftp_1309) with
                              | (Common_myop.DOWN , true) ->
                                  self.nx_1316 <- Autotransd.gear1 ;
                                  self.r_1305 <- true ;
                                  self.s_1304 <- At_bench_First_290
                              | (Common_myop.UP , true) ->
                                  self.nx_1316 <- Autotransd.gear3 ;
                                  self.r_1305 <- true ;
                                  self.s_1304 <- At_bench_Third_292
                              | _ -> self.r_1305 <- false  end)
                   | At_bench_Third_292 ->
                       (if self.r_1305 then ()) ;
                       (begin match (!shiftv_1308 , !shiftp_1309) with
                              | (Common_myop.DOWN , true) ->
                                  self.nx_1316 <- Autotransd.gear2 ;
                                  self.r_1305 <- true ;
                                  self.s_1304 <- At_bench_Second_291
                              | (Common_myop.UP , true) ->
                                  self.nx_1316 <- Autotransd.gear4 ;
                                  self.r_1305 <- true ;
                                  self.s_1304 <- At_bench_Fourth_293
                              | _ -> self.r_1305 <- false  end)
                   | At_bench_Fourth_293 ->
                       (if self.r_1305 then ()) ;
                       (begin match (!shiftv_1308 , !shiftp_1309) with
                              | (Common_myop.DOWN , true) ->
                                  self.nx_1316 <- Autotransd.gear3 ;
                                  self.r_1305 <- true ;
                                  self.s_1304 <- At_bench_Third_292
                              | _ -> self.r_1305 <- false  end)
                    end) ;
            (let (x_1313:MyOp.t) = self.m_1312 in
             self.m_1314 <- x_1313 ;
             self.m_1312 <- MyOp.(+) x_1313  tstep'_1256 ;
             ((MyOp.get x_1313) , outp_1250 , rob_1251))))))))):float *
                                                                MyOp.t
                                                                Array.t *
                                                                MyOp.t) in
  Node { alloc = autotrans_at1_alloc; reset = autotrans_at1_reset ;
                                      step = autotrans_at1_step }
type ('q ,
      'p ,
      'o ,
      'n , 'm , 'l , 'k , 'j , 'i , 'h , 'g , 'f , 'e , 'd , 'c , 'b , 'a) _autotrans_at2 =
  { mutable i_2062 : 'q ;
    mutable i_2061 : 'p ;
    mutable i_1414 : 'o ;
    mutable m_1411 : 'n ;
    mutable m_1409 : 'm ;
    mutable m_1406 : 'l ;
    mutable m_1404 : 'k ;
    mutable m_1402 : 'j ;
    mutable nx_1401 : 'i ;
    mutable m_1399 : 'h ;
    mutable m_1397 : 'g ;
    mutable r_1392 : 'f ;
    mutable s_1391 : 'e ;
    mutable r_1390 : 'd ;
    mutable s_1389 : 'c ; mutable t0_1359 : 'b ; mutable t0_1358 : 'a }

let autotrans_at2 (tstep_1331:float) = 
  let Node { alloc = i_2062_alloc; step = i_2062_step ; reset = i_2062_reset } = Autotransd.engine 
   in 
  let Node { alloc = i_2061_alloc; step = i_2061_step ; reset = i_2061_reset } = at2 
   in
  let autotrans_at2_alloc _ =
    ();
    { i_1414 = (false:bool) ;
      m_1411 = (create ():MyOp.t) ;
      m_1409 = (create ():MyOp.t) ;
      m_1406 = (create ():MyOp.t) ;
      m_1404 = (create ():MyOp.t) ;
      m_1402 = (create ():MyOp.t) ;
      nx_1401 = (create ():MyOp.t) ;
      m_1399 = (create ():MyOp.t) ;
      m_1397 = (create ():MyOp.t) ;
      r_1392 = (false:bool) ;
      s_1391 = (At_bench_UpShifting_364:state__8755) ;
      r_1390 = (false:bool) ;
      s_1389 = (At_bench_Fourth_361:state__8754) ;
      t0_1359 = (create ():MyOp.t) ; t0_1358 = (create ():MyOp.t);
      i_2062 = i_2062_alloc () (* discrete *)  ;
      i_2061 = i_2061_alloc () (* discrete *)  } in
  let autotrans_at2_reset self  =
    ((self.i_1414 <- true ;
      i_2062_reset self.i_2062  ;
      i_2061_reset self.i_2061  ;
      self.r_1392 <- false ;
      self.s_1391 <- At_bench_SteadyState_362 ;
      self.r_1390 <- false ; self.s_1389 <- At_bench_First_358):unit) in 
  let autotrans_at2_step self (inp_1330:(MyOp.t)Array.t) =
    ((let shiftp_1394 = ref (false:bool) in
      let shiftv_1393 = ref (Common_myop.DOWN:Common_myop.shift) in
      (if self.i_1414 then self.nx_1401 <- Autotransd.gear1) ;
      (let (gear_1357:MyOp.t) = self.nx_1401 in
       let (gear_lookup_1370:MyOp.t) = Common_myop.lookup_gear gear_1357 in
       let (nin_1371:MyOp.t) = MyOp.( * ) self.m_1404  gear_lookup_1370 in
       let ((ti_1364:MyOp.t) , (turbine_torque_1366:MyOp.t)) =
           Common_myop.torque_converter (self.m_1402 , nin_1371) in
       let (tout_1372:MyOp.t) =
           MyOp.( * ) turbine_torque_1366  gear_lookup_1370 in
       let (final_drive_ratio_1378:MyOp.t) =
           MyOp.scale tout_1372  Common_myop.p_final_drive_ratio in
       let (aux1_1376:MyOp.t) = MyOp.(-) final_drive_ratio_1378  self.m_1409 in
       let (vehicle_inertia_1387:MyOp.t) =
           MyOp.scale aux1_1376  Common_myop.iv_inv in
       (if self.i_1414 then self.m_1399 <- MyOp.make 0.) ;
       (let (x_1400:MyOp.t) = self.m_1399 in
        let (x_1408:MyOp.t) =
            if self.i_1414 then x_1400 else MyOp.(-) x_1400  self.m_1406 in
        let (x_1413:MyOp.t) =
            if self.i_1414
            then MyOp.make Common_myop.p_initial_wheel_speed
            else
              MyOp.(+) self.m_1411  (MyOp.( * ) vehicle_inertia_1387  x_1408) in
        let (tstep'_1341:MyOp.t) = MyOp.make tstep_1331 in
        (if self.i_1414 then self.m_1397 <- tstep'_1341) ;
        self.i_1414 <- false ;
        (let (throttle_1340:MyOp.t) = Array.get inp_1330  0 in
         let (rpm_1347:MyOp.t) =
             i_2062_step self.i_2062 (x_1400 , ti_1364 , throttle_1340) in
         let (linear_speed_1379:MyOp.t) =
             MyOp.scale x_1413  Common_myop.l_speed_coef in
         let (mph_1380:MyOp.t) =
             MyOp.scale linear_speed_1379  Common_myop.p_mph in
         let (outp_1335:(MyOp.t)Array.t) =
             Array.of_list ((::) (rpm_1347 ,
                                  ((::) (gear_1357 , ((::) (mph_1380 , ([]))))))) in
         let (rob_1336:MyOp.t) =
             i_2061_step self.i_2061 (tstep'_1341 , inp_1330 , outp_1335) in
         self.m_1411 <- x_1413 ;
         (let (brake_1332:MyOp.t) = Array.get inp_1330  1 in
          let (road_load_1381:MyOp.t) =
              MyOp.translate (MyOp.scale (MyOp.sqr mph_1380) 
                                         Common_myop.p_aerodynamic_drag) 
                             Common_myop.p_drag_friction in
          let (brake_1377:MyOp.t) = MyOp.(+) brake_1332  road_load_1381 in
          let (sgn_1382:MyOp.t) =
              if (>=) mph_1380  Autotransd.zero_val
              then MyOp.make 1.
              else MyOp.make (-1.) in
          let (signed_load_1383:MyOp.t) = MyOp.( * ) sgn_1382  brake_1377 in
          self.m_1409 <- signed_load_1383 ;
          self.m_1406 <- x_1400 ;
          (let (trans_rpm_1386:MyOp.t) =
               MyOp.scale x_1413  Common_myop.p_final_drive_ratio in
           self.m_1404 <- trans_rpm_1386 ;
           self.m_1402 <- rpm_1347 ;
           (let (dn_th_1354:MyOp.t) =
                Common_myop.lookup_interpdn (throttle_1340 , gear_1357) in
            let (up_th_1356:MyOp.t) =
                Common_myop.lookup_interpup (throttle_1340 , gear_1357) in
            (begin match self.s_1391 with
                   | At_bench_SteadyState_362 ->
                       (if self.r_1392 then ()) ;
                       (begin match (((>) mph_1380  up_th_1356) ,
                                     ((<) mph_1380  dn_th_1354)) with
                              | (_ , true) ->
                                  self.t0_1358 <- x_1400 ;
                                  self.r_1392 <- true ;
                                  self.s_1391 <- At_bench_DownShifting_363
                              | (true , _) ->
                                  self.t0_1359 <- x_1400 ;
                                  self.r_1392 <- true ;
                                  self.s_1391 <- At_bench_UpShifting_364
                              | _ -> self.r_1392 <- false  end)
                   | At_bench_DownShifting_363 ->
                       (if self.r_1392 then ()) ;
                       (begin match (((>) x_1400 
                                          (MyOp.translate self.t0_1358 
                                                          Common_myop.twait))
                                     , ((>) mph_1380  dn_th_1354)) with
                              | (_ , true) ->
                                  self.r_1392 <- true ;
                                  self.s_1391 <- At_bench_SteadyState_362
                              | (true , _) ->
                                  shiftp_1394 := true ;
                                  shiftv_1393 := Common_myop.DOWN ;
                                  self.r_1392 <- true ;
                                  self.s_1391 <- At_bench_SteadyState_362
                              | _ -> self.r_1392 <- false  end)
                   | At_bench_UpShifting_364 ->
                       (if self.r_1392 then ()) ;
                       (begin match (((>) x_1400 
                                          (MyOp.translate self.t0_1359 
                                                          Common_myop.twait))
                                     , ((<) mph_1380  up_th_1356)) with
                              | (_ , true) ->
                                  self.r_1392 <- true ;
                                  self.s_1391 <- At_bench_SteadyState_362
                              | (true , _) ->
                                  shiftp_1394 := true ;
                                  shiftv_1393 := Common_myop.UP ;
                                  self.r_1392 <- true ;
                                  self.s_1391 <- At_bench_SteadyState_362
                              | _ -> self.r_1392 <- false  end)
                    end) ;
            (begin match self.s_1389 with
                   | At_bench_First_358 ->
                       (if self.r_1390 then ()) ;
                       (begin match (!shiftv_1393 , !shiftp_1394) with
                              | (Common_myop.UP , true) ->
                                  self.nx_1401 <- Autotransd.gear2 ;
                                  self.r_1390 <- true ;
                                  self.s_1389 <- At_bench_Second_359
                              | _ -> self.r_1390 <- false  end)
                   | At_bench_Second_359 ->
                       (if self.r_1390 then ()) ;
                       (begin match (!shiftv_1393 , !shiftp_1394) with
                              | (Common_myop.DOWN , true) ->
                                  self.nx_1401 <- Autotransd.gear1 ;
                                  self.r_1390 <- true ;
                                  self.s_1389 <- At_bench_First_358
                              | (Common_myop.UP , true) ->
                                  self.nx_1401 <- Autotransd.gear3 ;
                                  self.r_1390 <- true ;
                                  self.s_1389 <- At_bench_Third_360
                              | _ -> self.r_1390 <- false  end)
                   | At_bench_Third_360 ->
                       (if self.r_1390 then ()) ;
                       (begin match (!shiftv_1393 , !shiftp_1394) with
                              | (Common_myop.DOWN , true) ->
                                  self.nx_1401 <- Autotransd.gear2 ;
                                  self.r_1390 <- true ;
                                  self.s_1389 <- At_bench_Second_359
                              | (Common_myop.UP , true) ->
                                  self.nx_1401 <- Autotransd.gear4 ;
                                  self.r_1390 <- true ;
                                  self.s_1389 <- At_bench_Fourth_361
                              | _ -> self.r_1390 <- false  end)
                   | At_bench_Fourth_361 ->
                       (if self.r_1390 then ()) ;
                       (begin match (!shiftv_1393 , !shiftp_1394) with
                              | (Common_myop.DOWN , true) ->
                                  self.nx_1401 <- Autotransd.gear3 ;
                                  self.r_1390 <- true ;
                                  self.s_1389 <- At_bench_Third_360
                              | _ -> self.r_1390 <- false  end)
                    end) ;
            (let (x_1398:MyOp.t) = self.m_1397 in
             self.m_1399 <- x_1398 ;
             self.m_1397 <- MyOp.(+) x_1398  tstep'_1341 ;
             ((MyOp.get x_1398) , outp_1335 , rob_1336))))))))):float *
                                                                MyOp.t
                                                                Array.t *
                                                                MyOp.t) in
  Node { alloc = autotrans_at2_alloc; reset = autotrans_at2_reset ;
                                      step = autotrans_at2_step }
type ('t ,
      's ,
      'r ,
      'q ,
      'p ,
      'o ,
      'n , 'm , 'l , 'k , 'j , 'i , 'h , 'g , 'f , 'e , 'd , 'c , 'b , 'a) _autotrans_at51 =
  { mutable i_2064 : 't ;
    mutable i_2063 : 's ;
    mutable i_1503 : 'r ;
    mutable m_1500 : 'q ;
    mutable m_1498 : 'p ;
    mutable m_1495 : 'o ;
    mutable m_1493 : 'n ;
    mutable m_1491 : 'm ;
    mutable nx_1490 : 'l ;
    mutable m_1488 : 'k ;
    mutable m_1486 : 'j ;
    mutable r_1481 : 'i ;
    mutable s_1480 : 'h ;
    mutable r_1479 : 'g ;
    mutable s_1478 : 'f ;
    mutable t0_1448 : 'e ;
    mutable t0_1447 : 'd ;
    mutable rob_1444 : 'c ; mutable i_1505 : 'b ; mutable go_up_1504 : 'a }

let autotrans_at51 (tstep_1416:float) = 
  let Node { alloc = i_2064_alloc; step = i_2064_step ; reset = i_2064_reset } = Autotransd_modes.engine 
   in 
  let Node { alloc = i_2063_alloc; step = i_2063_step ; reset = i_2063_reset } = at51 
   in
  let autotrans_at51_alloc _ =
    ();
    { i_1503 = (false:bool) ;
      m_1500 = (create ():MyOp.t) ;
      m_1498 = (create ():MyOp.t) ;
      m_1495 = (create ():MyOp.t) ;
      m_1493 = (create ():MyOp.t) ;
      m_1491 = (create ():MyOp.t) ;
      nx_1490 = (create ():MyOp.t) ;
      m_1488 = (create ():MyOp.t) ;
      m_1486 = (create ():MyOp.t) ;
      r_1481 = (false:bool) ;
      s_1480 = (At_bench_UpShifting_436:state__8757) ;
      r_1479 = (false:bool) ;
      s_1478 = (At_bench_Fourth_433:state__8756) ;
      t0_1448 = (create ():MyOp.t) ;
      t0_1447 = (create ():MyOp.t) ;
      rob_1444 = (create ():MyOp.t) ;
      i_1505 = (false:bool) ; go_up_1504 = (false:bool);
      i_2064 = i_2064_alloc () (* discrete *)  ;
      i_2063 = i_2063_alloc () (* discrete *)  } in
  let autotrans_at51_reset self  =
    ((self.i_1503 <- true ;
      i_2064_reset self.i_2064  ;
      i_2063_reset self.i_2063  ;
      self.r_1481 <- false ;
      self.s_1480 <- At_bench_SteadyState_434 ;
      self.i_1505 <- true ;
      self.r_1479 <- false ; self.s_1478 <- At_bench_First_430):unit) in 
  let autotrans_at51_step self (inp_1415:(MyOp.t)Array.t) =
    ((let shiftp_1483 = ref (false:bool) in
      let shiftv_1482 = ref (Common_myop.DOWN:Common_myop.shift) in
      (if self.i_1503 then self.nx_1490 <- Autotransd_modes.gear1) ;
      (let (gear_1446:MyOp.t) = self.nx_1490 in
       let (gear_lookup_1459:MyOp.t) = Common_myop.lookup_gear gear_1446 in
       let (nin_1460:MyOp.t) = MyOp.( * ) self.m_1493  gear_lookup_1459 in
       let ((ti_1453:MyOp.t) , (turbine_torque_1455:MyOp.t)) =
           Common_myop.torque_converter (self.m_1491 , nin_1460) in
       let (tout_1461:MyOp.t) =
           MyOp.( * ) turbine_torque_1455  gear_lookup_1459 in
       let (final_drive_ratio_1467:MyOp.t) =
           MyOp.scale tout_1461  Common_myop.p_final_drive_ratio in
       let (aux1_1465:MyOp.t) = MyOp.(-) final_drive_ratio_1467  self.m_1498 in
       let (vehicle_inertia_1476:MyOp.t) =
           MyOp.scale aux1_1465  Common_myop.iv_inv in
       (if self.i_1503 then self.m_1488 <- MyOp.make 0.) ;
       (let (x_1489:MyOp.t) = self.m_1488 in
        let (x_1497:MyOp.t) =
            if self.i_1503 then x_1489 else MyOp.(-) x_1489  self.m_1495 in
        let (x_1502:MyOp.t) =
            if self.i_1503
            then MyOp.make Common_myop.p_initial_wheel_speed
            else
              MyOp.(+) self.m_1500  (MyOp.( * ) vehicle_inertia_1476  x_1497) in
        let (tstep'_1428:MyOp.t) = MyOp.make tstep_1416 in
        (if self.i_1503 then self.m_1486 <- tstep'_1428) ;
        self.i_1503 <- false ;
        (let (throttle_1427:MyOp.t) = Array.get inp_1415  0 in
         let (rpm_1435:MyOp.t) =
             i_2064_step self.i_2064 (x_1489 , ti_1453 , throttle_1427) in
         let (linear_speed_1468:MyOp.t) =
             MyOp.scale x_1502  Common_myop.l_speed_coef in
         let (mph_1469:MyOp.t) =
             MyOp.scale linear_speed_1468  Common_myop.p_mph in
         let (outp_1420:(MyOp.t)Array.t) =
             Array.of_list ((::) (rpm_1435 ,
                                  ((::) (gear_1446 , ((::) (mph_1469 , ([]))))))) in
         let (rob_spec_1423:MyOp.t) =
             i_2063_step self.i_2063 (tstep'_1428 , inp_1415 , outp_1420) in
         let (dn_th_1442:MyOp.t) =
             Common_myop.lookup_interpdn (throttle_1427 , gear_1446) in
         let (up_th_1445:MyOp.t) =
             Common_myop.lookup_interpup (throttle_1427 , gear_1446) in
         (begin match self.s_1480 with
                | At_bench_SteadyState_434 ->
                    (if self.r_1481 then self.i_1505 <- true) ;
                    (if self.i_1505 then
                     self.go_up_1504 <- (>) (MyOp.make (Random.float 1.)) 
                                            (MyOp.make 0.5)) ;
                    self.i_1505 <- false ;
                    self.rob_1444 <- (if self.go_up_1504
                                      then MyOp.(-) up_th_1445  mph_1469
                                      else MyOp.(-) mph_1469  dn_th_1442) ;
                    (begin match (((>) mph_1469  up_th_1445) ,
                                  ((<) mph_1469  dn_th_1442)) with
                           | (_ , true) ->
                               self.t0_1447 <- x_1489 ;
                               self.r_1481 <- true ;
                               self.s_1480 <- At_bench_DownShifting_435
                           | (true , _) ->
                               self.t0_1448 <- x_1489 ;
                               self.r_1481 <- true ;
                               self.s_1480 <- At_bench_UpShifting_436
                           | _ -> self.r_1481 <- false  end)
                | At_bench_DownShifting_435 ->
                    (if self.r_1481 then ()) ;
                    self.rob_1444 <- Autotransd_modes.zero_val ;
                    (begin match (((>) x_1489 
                                       (MyOp.translate self.t0_1447 
                                                       Common_myop.twait)) ,
                                  ((>) mph_1469  dn_th_1442)) with
                           | (_ , true) ->
                               self.r_1481 <- true ;
                               self.s_1480 <- At_bench_SteadyState_434
                           | (true , _) ->
                               shiftp_1483 := true ;
                               shiftv_1482 := Common_myop.DOWN ;
                               self.r_1481 <- true ;
                               self.s_1480 <- At_bench_SteadyState_434
                           | _ -> self.r_1481 <- false  end)
                | At_bench_UpShifting_436 ->
                    (if self.r_1481 then ()) ;
                    self.rob_1444 <- Autotransd_modes.zero_val ;
                    (begin match (((>) x_1489 
                                       (MyOp.translate self.t0_1448 
                                                       Common_myop.twait)) ,
                                  ((<) mph_1469  up_th_1445)) with
                           | (_ , true) ->
                               self.r_1481 <- true ;
                               self.s_1480 <- At_bench_SteadyState_434
                           | (true , _) ->
                               shiftp_1483 := true ;
                               shiftv_1482 := Common_myop.UP ;
                               self.r_1481 <- true ;
                               self.s_1480 <- At_bench_SteadyState_434
                           | _ -> self.r_1481 <- false  end)
                 end) ;
         (let (rob_1421:MyOp.t) =
              if Discrete_obs_fad.isFalse rob_spec_1423
              then rob_spec_1423
              else
                if Discrete_obs_fad.isTrue self.rob_1444
                then self.rob_1444
                else rob_spec_1423 in
          self.m_1500 <- x_1502 ;
          (let (brake_1417:MyOp.t) = Array.get inp_1415  1 in
           let (road_load_1470:MyOp.t) =
               MyOp.translate (MyOp.scale (MyOp.sqr mph_1469) 
                                          Common_myop.p_aerodynamic_drag) 
                              Common_myop.p_drag_friction in
           let (brake_1466:MyOp.t) = MyOp.(+) brake_1417  road_load_1470 in
           let (sgn_1471:MyOp.t) =
               if (>=) mph_1469  Autotransd_modes.zero_val
               then MyOp.make 1.
               else MyOp.make (-1.) in
           let (signed_load_1472:MyOp.t) = MyOp.( * ) sgn_1471  brake_1466 in
           self.m_1498 <- signed_load_1472 ;
           self.m_1495 <- x_1489 ;
           (let (trans_rpm_1475:MyOp.t) =
                MyOp.scale x_1502  Common_myop.p_final_drive_ratio in
            self.m_1493 <- trans_rpm_1475 ;
            self.m_1491 <- rpm_1435 ;
            (begin match self.s_1478 with
                   | At_bench_First_430 ->
                       (if self.r_1479 then ()) ;
                       (begin match (!shiftv_1482 , !shiftp_1483) with
                              | (Common_myop.UP , true) ->
                                  self.nx_1490 <- Autotransd_modes.gear2 ;
                                  self.r_1479 <- true ;
                                  self.s_1478 <- At_bench_Second_431
                              | _ -> self.r_1479 <- false  end)
                   | At_bench_Second_431 ->
                       (if self.r_1479 then ()) ;
                       (begin match (!shiftv_1482 , !shiftp_1483) with
                              | (Common_myop.DOWN , true) ->
                                  self.nx_1490 <- Autotransd_modes.gear1 ;
                                  self.r_1479 <- true ;
                                  self.s_1478 <- At_bench_First_430
                              | (Common_myop.UP , true) ->
                                  self.nx_1490 <- Autotransd_modes.gear3 ;
                                  self.r_1479 <- true ;
                                  self.s_1478 <- At_bench_Third_432
                              | _ -> self.r_1479 <- false  end)
                   | At_bench_Third_432 ->
                       (if self.r_1479 then ()) ;
                       (begin match (!shiftv_1482 , !shiftp_1483) with
                              | (Common_myop.DOWN , true) ->
                                  self.nx_1490 <- Autotransd_modes.gear2 ;
                                  self.r_1479 <- true ;
                                  self.s_1478 <- At_bench_Second_431
                              | (Common_myop.UP , true) ->
                                  self.nx_1490 <- Autotransd_modes.gear4 ;
                                  self.r_1479 <- true ;
                                  self.s_1478 <- At_bench_Fourth_433
                              | _ -> self.r_1479 <- false  end)
                   | At_bench_Fourth_433 ->
                       (if self.r_1479 then ()) ;
                       (begin match (!shiftv_1482 , !shiftp_1483) with
                              | (Common_myop.DOWN , true) ->
                                  self.nx_1490 <- Autotransd_modes.gear3 ;
                                  self.r_1479 <- true ;
                                  self.s_1478 <- At_bench_Third_432
                              | _ -> self.r_1479 <- false  end)
                    end) ;
            (let (x_1487:MyOp.t) = self.m_1486 in
             self.m_1488 <- x_1487 ;
             self.m_1486 <- MyOp.(+) x_1487  tstep'_1428 ;
             ((MyOp.get x_1487) , outp_1420 , rob_1421))))))))):float *
                                                                MyOp.t
                                                                Array.t *
                                                                MyOp.t) in
  Node { alloc = autotrans_at51_alloc; reset = autotrans_at51_reset ;
                                       step = autotrans_at51_step }
type ('t ,
      's ,
      'r ,
      'q ,
      'p ,
      'o ,
      'n , 'm , 'l , 'k , 'j , 'i , 'h , 'g , 'f , 'e , 'd , 'c , 'b , 'a) _autotrans_at52 =
  { mutable i_2066 : 't ;
    mutable i_2065 : 's ;
    mutable i_1594 : 'r ;
    mutable m_1591 : 'q ;
    mutable m_1589 : 'p ;
    mutable m_1586 : 'o ;
    mutable m_1584 : 'n ;
    mutable m_1582 : 'm ;
    mutable nx_1581 : 'l ;
    mutable m_1579 : 'k ;
    mutable m_1577 : 'j ;
    mutable r_1572 : 'i ;
    mutable s_1571 : 'h ;
    mutable r_1570 : 'g ;
    mutable s_1569 : 'f ;
    mutable t0_1539 : 'e ;
    mutable t0_1538 : 'd ;
    mutable rob_1535 : 'c ; mutable i_1596 : 'b ; mutable go_up_1595 : 'a }

let autotrans_at52 (tstep_1507:float) = 
  let Node { alloc = i_2066_alloc; step = i_2066_step ; reset = i_2066_reset } = Autotransd_modes.engine 
   in 
  let Node { alloc = i_2065_alloc; step = i_2065_step ; reset = i_2065_reset } = at52 
   in
  let autotrans_at52_alloc _ =
    ();
    { i_1594 = (false:bool) ;
      m_1591 = (create ():MyOp.t) ;
      m_1589 = (create ():MyOp.t) ;
      m_1586 = (create ():MyOp.t) ;
      m_1584 = (create ():MyOp.t) ;
      m_1582 = (create ():MyOp.t) ;
      nx_1581 = (create ():MyOp.t) ;
      m_1579 = (create ():MyOp.t) ;
      m_1577 = (create ():MyOp.t) ;
      r_1572 = (false:bool) ;
      s_1571 = (At_bench_UpShifting_509:state__8759) ;
      r_1570 = (false:bool) ;
      s_1569 = (At_bench_Fourth_506:state__8758) ;
      t0_1539 = (create ():MyOp.t) ;
      t0_1538 = (create ():MyOp.t) ;
      rob_1535 = (create ():MyOp.t) ;
      i_1596 = (false:bool) ; go_up_1595 = (false:bool);
      i_2066 = i_2066_alloc () (* discrete *)  ;
      i_2065 = i_2065_alloc () (* discrete *)  } in
  let autotrans_at52_reset self  =
    ((self.i_1594 <- true ;
      i_2066_reset self.i_2066  ;
      i_2065_reset self.i_2065  ;
      self.r_1572 <- false ;
      self.s_1571 <- At_bench_SteadyState_507 ;
      self.i_1596 <- true ;
      self.r_1570 <- false ; self.s_1569 <- At_bench_First_503):unit) in 
  let autotrans_at52_step self (inp_1506:(MyOp.t)Array.t) =
    ((let shiftp_1574 = ref (false:bool) in
      let shiftv_1573 = ref (Common_myop.DOWN:Common_myop.shift) in
      (if self.i_1594 then self.nx_1581 <- Autotransd_modes.gear1) ;
      (let (gear_1537:MyOp.t) = self.nx_1581 in
       let (gear_lookup_1550:MyOp.t) = Common_myop.lookup_gear gear_1537 in
       let (nin_1551:MyOp.t) = MyOp.( * ) self.m_1584  gear_lookup_1550 in
       let ((ti_1544:MyOp.t) , (turbine_torque_1546:MyOp.t)) =
           Common_myop.torque_converter (self.m_1582 , nin_1551) in
       let (tout_1552:MyOp.t) =
           MyOp.( * ) turbine_torque_1546  gear_lookup_1550 in
       let (final_drive_ratio_1558:MyOp.t) =
           MyOp.scale tout_1552  Common_myop.p_final_drive_ratio in
       let (aux1_1556:MyOp.t) = MyOp.(-) final_drive_ratio_1558  self.m_1589 in
       let (vehicle_inertia_1567:MyOp.t) =
           MyOp.scale aux1_1556  Common_myop.iv_inv in
       (if self.i_1594 then self.m_1579 <- MyOp.make 0.) ;
       (let (x_1580:MyOp.t) = self.m_1579 in
        let (x_1588:MyOp.t) =
            if self.i_1594 then x_1580 else MyOp.(-) x_1580  self.m_1586 in
        let (x_1593:MyOp.t) =
            if self.i_1594
            then MyOp.make Common_myop.p_initial_wheel_speed
            else
              MyOp.(+) self.m_1591  (MyOp.( * ) vehicle_inertia_1567  x_1588) in
        let (tstep'_1519:MyOp.t) = MyOp.make tstep_1507 in
        (if self.i_1594 then self.m_1577 <- tstep'_1519) ;
        self.i_1594 <- false ;
        (let (throttle_1518:MyOp.t) = Array.get inp_1506  0 in
         let (rpm_1526:MyOp.t) =
             i_2066_step self.i_2066 (x_1580 , ti_1544 , throttle_1518) in
         let (linear_speed_1559:MyOp.t) =
             MyOp.scale x_1593  Common_myop.l_speed_coef in
         let (mph_1560:MyOp.t) =
             MyOp.scale linear_speed_1559  Common_myop.p_mph in
         let (outp_1511:(MyOp.t)Array.t) =
             Array.of_list ((::) (rpm_1526 ,
                                  ((::) (gear_1537 , ((::) (mph_1560 , ([]))))))) in
         let (rob_spec_1514:MyOp.t) =
             i_2065_step self.i_2065 (tstep'_1519 , inp_1506 , outp_1511) in
         let (dn_th_1533:MyOp.t) =
             Common_myop.lookup_interpdn (throttle_1518 , gear_1537) in
         let (up_th_1536:MyOp.t) =
             Common_myop.lookup_interpup (throttle_1518 , gear_1537) in
         (begin match self.s_1571 with
                | At_bench_SteadyState_507 ->
                    (if self.r_1572 then self.i_1596 <- true) ;
                    (if self.i_1596 then
                     self.go_up_1595 <- (>) (MyOp.make (Random.float 1.)) 
                                            (MyOp.make 0.5)) ;
                    self.i_1596 <- false ;
                    self.rob_1535 <- (if self.go_up_1595
                                      then MyOp.(-) up_th_1536  mph_1560
                                      else MyOp.(-) mph_1560  dn_th_1533) ;
                    (begin match (((>) mph_1560  up_th_1536) ,
                                  ((<) mph_1560  dn_th_1533)) with
                           | (_ , true) ->
                               self.t0_1538 <- x_1580 ;
                               self.r_1572 <- true ;
                               self.s_1571 <- At_bench_DownShifting_508
                           | (true , _) ->
                               self.t0_1539 <- x_1580 ;
                               self.r_1572 <- true ;
                               self.s_1571 <- At_bench_UpShifting_509
                           | _ -> self.r_1572 <- false  end)
                | At_bench_DownShifting_508 ->
                    (if self.r_1572 then ()) ;
                    self.rob_1535 <- Autotransd_modes.zero_val ;
                    (begin match (((>) x_1580 
                                       (MyOp.translate self.t0_1538 
                                                       Common_myop.twait)) ,
                                  ((>) mph_1560  dn_th_1533)) with
                           | (_ , true) ->
                               self.r_1572 <- true ;
                               self.s_1571 <- At_bench_SteadyState_507
                           | (true , _) ->
                               shiftp_1574 := true ;
                               shiftv_1573 := Common_myop.DOWN ;
                               self.r_1572 <- true ;
                               self.s_1571 <- At_bench_SteadyState_507
                           | _ -> self.r_1572 <- false  end)
                | At_bench_UpShifting_509 ->
                    (if self.r_1572 then ()) ;
                    self.rob_1535 <- Autotransd_modes.zero_val ;
                    (begin match (((>) x_1580 
                                       (MyOp.translate self.t0_1539 
                                                       Common_myop.twait)) ,
                                  ((<) mph_1560  up_th_1536)) with
                           | (_ , true) ->
                               self.r_1572 <- true ;
                               self.s_1571 <- At_bench_SteadyState_507
                           | (true , _) ->
                               shiftp_1574 := true ;
                               shiftv_1573 := Common_myop.UP ;
                               self.r_1572 <- true ;
                               self.s_1571 <- At_bench_SteadyState_507
                           | _ -> self.r_1572 <- false  end)
                 end) ;
         (let (rob_1512:MyOp.t) =
              if Discrete_obs_fad.isFalse rob_spec_1514
              then rob_spec_1514
              else
                if Discrete_obs_fad.isTrue self.rob_1535
                then self.rob_1535
                else rob_spec_1514 in
          self.m_1591 <- x_1593 ;
          (let (brake_1508:MyOp.t) = Array.get inp_1506  1 in
           let (road_load_1561:MyOp.t) =
               MyOp.translate (MyOp.scale (MyOp.sqr mph_1560) 
                                          Common_myop.p_aerodynamic_drag) 
                              Common_myop.p_drag_friction in
           let (brake_1557:MyOp.t) = MyOp.(+) brake_1508  road_load_1561 in
           let (sgn_1562:MyOp.t) =
               if (>=) mph_1560  Autotransd_modes.zero_val
               then MyOp.make 1.
               else MyOp.make (-1.) in
           let (signed_load_1563:MyOp.t) = MyOp.( * ) sgn_1562  brake_1557 in
           self.m_1589 <- signed_load_1563 ;
           self.m_1586 <- x_1580 ;
           (let (trans_rpm_1566:MyOp.t) =
                MyOp.scale x_1593  Common_myop.p_final_drive_ratio in
            self.m_1584 <- trans_rpm_1566 ;
            self.m_1582 <- rpm_1526 ;
            (begin match self.s_1569 with
                   | At_bench_First_503 ->
                       (if self.r_1570 then ()) ;
                       (begin match (!shiftv_1573 , !shiftp_1574) with
                              | (Common_myop.UP , true) ->
                                  self.nx_1581 <- Autotransd_modes.gear2 ;
                                  self.r_1570 <- true ;
                                  self.s_1569 <- At_bench_Second_504
                              | _ -> self.r_1570 <- false  end)
                   | At_bench_Second_504 ->
                       (if self.r_1570 then ()) ;
                       (begin match (!shiftv_1573 , !shiftp_1574) with
                              | (Common_myop.DOWN , true) ->
                                  self.nx_1581 <- Autotransd_modes.gear1 ;
                                  self.r_1570 <- true ;
                                  self.s_1569 <- At_bench_First_503
                              | (Common_myop.UP , true) ->
                                  self.nx_1581 <- Autotransd_modes.gear3 ;
                                  self.r_1570 <- true ;
                                  self.s_1569 <- At_bench_Third_505
                              | _ -> self.r_1570 <- false  end)
                   | At_bench_Third_505 ->
                       (if self.r_1570 then ()) ;
                       (begin match (!shiftv_1573 , !shiftp_1574) with
                              | (Common_myop.DOWN , true) ->
                                  self.nx_1581 <- Autotransd_modes.gear2 ;
                                  self.r_1570 <- true ;
                                  self.s_1569 <- At_bench_Second_504
                              | (Common_myop.UP , true) ->
                                  self.nx_1581 <- Autotransd_modes.gear4 ;
                                  self.r_1570 <- true ;
                                  self.s_1569 <- At_bench_Fourth_506
                              | _ -> self.r_1570 <- false  end)
                   | At_bench_Fourth_506 ->
                       (if self.r_1570 then ()) ;
                       (begin match (!shiftv_1573 , !shiftp_1574) with
                              | (Common_myop.DOWN , true) ->
                                  self.nx_1581 <- Autotransd_modes.gear3 ;
                                  self.r_1570 <- true ;
                                  self.s_1569 <- At_bench_Third_505
                              | _ -> self.r_1570 <- false  end)
                    end) ;
            (let (x_1578:MyOp.t) = self.m_1577 in
             self.m_1579 <- x_1578 ;
             self.m_1577 <- MyOp.(+) x_1578  tstep'_1519 ;
             ((MyOp.get x_1578) ,
              outp_1511 , (MyOp.(+) rob_1512  (MyOp.make 0.1))))))))))):
    float * MyOp.t Array.t * MyOp.t) in
  Node { alloc = autotrans_at52_alloc; reset = autotrans_at52_reset ;
                                       step = autotrans_at52_step }
type ('t ,
      's ,
      'r ,
      'q ,
      'p ,
      'o ,
      'n , 'm , 'l , 'k , 'j , 'i , 'h , 'g , 'f , 'e , 'd , 'c , 'b , 'a) _autotrans_at53 =
  { mutable i_2068 : 't ;
    mutable i_2067 : 's ;
    mutable i_1685 : 'r ;
    mutable m_1682 : 'q ;
    mutable m_1680 : 'p ;
    mutable m_1677 : 'o ;
    mutable m_1675 : 'n ;
    mutable m_1673 : 'm ;
    mutable nx_1672 : 'l ;
    mutable m_1670 : 'k ;
    mutable m_1668 : 'j ;
    mutable r_1663 : 'i ;
    mutable s_1662 : 'h ;
    mutable r_1661 : 'g ;
    mutable s_1660 : 'f ;
    mutable t0_1630 : 'e ;
    mutable t0_1629 : 'd ;
    mutable rob_1626 : 'c ; mutable i_1687 : 'b ; mutable go_up_1686 : 'a }

let autotrans_at53 (tstep_1598:float) = 
  let Node { alloc = i_2068_alloc; step = i_2068_step ; reset = i_2068_reset } = Autotransd_modes.engine 
   in 
  let Node { alloc = i_2067_alloc; step = i_2067_step ; reset = i_2067_reset } = at53 
   in
  let autotrans_at53_alloc _ =
    ();
    { i_1685 = (false:bool) ;
      m_1682 = (create ():MyOp.t) ;
      m_1680 = (create ():MyOp.t) ;
      m_1677 = (create ():MyOp.t) ;
      m_1675 = (create ():MyOp.t) ;
      m_1673 = (create ():MyOp.t) ;
      nx_1672 = (create ():MyOp.t) ;
      m_1670 = (create ():MyOp.t) ;
      m_1668 = (create ():MyOp.t) ;
      r_1663 = (false:bool) ;
      s_1662 = (At_bench_UpShifting_582:state__8761) ;
      r_1661 = (false:bool) ;
      s_1660 = (At_bench_Fourth_579:state__8760) ;
      t0_1630 = (create ():MyOp.t) ;
      t0_1629 = (create ():MyOp.t) ;
      rob_1626 = (create ():MyOp.t) ;
      i_1687 = (false:bool) ; go_up_1686 = (false:bool);
      i_2068 = i_2068_alloc () (* discrete *)  ;
      i_2067 = i_2067_alloc () (* discrete *)  } in
  let autotrans_at53_reset self  =
    ((self.i_1685 <- true ;
      i_2068_reset self.i_2068  ;
      i_2067_reset self.i_2067  ;
      self.r_1663 <- false ;
      self.s_1662 <- At_bench_SteadyState_580 ;
      self.i_1687 <- true ;
      self.r_1661 <- false ; self.s_1660 <- At_bench_First_576):unit) in 
  let autotrans_at53_step self (inp_1597:(MyOp.t)Array.t) =
    ((let shiftp_1665 = ref (false:bool) in
      let shiftv_1664 = ref (Common_myop.DOWN:Common_myop.shift) in
      (if self.i_1685 then self.nx_1672 <- Autotransd_modes.gear1) ;
      (let (gear_1628:MyOp.t) = self.nx_1672 in
       let (gear_lookup_1641:MyOp.t) = Common_myop.lookup_gear gear_1628 in
       let (nin_1642:MyOp.t) = MyOp.( * ) self.m_1675  gear_lookup_1641 in
       let ((ti_1635:MyOp.t) , (turbine_torque_1637:MyOp.t)) =
           Common_myop.torque_converter (self.m_1673 , nin_1642) in
       let (tout_1643:MyOp.t) =
           MyOp.( * ) turbine_torque_1637  gear_lookup_1641 in
       let (final_drive_ratio_1649:MyOp.t) =
           MyOp.scale tout_1643  Common_myop.p_final_drive_ratio in
       let (aux1_1647:MyOp.t) = MyOp.(-) final_drive_ratio_1649  self.m_1680 in
       let (vehicle_inertia_1658:MyOp.t) =
           MyOp.scale aux1_1647  Common_myop.iv_inv in
       (if self.i_1685 then self.m_1670 <- MyOp.make 0.) ;
       (let (x_1671:MyOp.t) = self.m_1670 in
        let (x_1679:MyOp.t) =
            if self.i_1685 then x_1671 else MyOp.(-) x_1671  self.m_1677 in
        let (x_1684:MyOp.t) =
            if self.i_1685
            then MyOp.make Common_myop.p_initial_wheel_speed
            else
              MyOp.(+) self.m_1682  (MyOp.( * ) vehicle_inertia_1658  x_1679) in
        let (tstep'_1610:MyOp.t) = MyOp.make tstep_1598 in
        (if self.i_1685 then self.m_1668 <- tstep'_1610) ;
        self.i_1685 <- false ;
        (let (throttle_1609:MyOp.t) = Array.get inp_1597  0 in
         let (rpm_1617:MyOp.t) =
             i_2068_step self.i_2068 (x_1671 , ti_1635 , throttle_1609) in
         let (linear_speed_1650:MyOp.t) =
             MyOp.scale x_1684  Common_myop.l_speed_coef in
         let (mph_1651:MyOp.t) =
             MyOp.scale linear_speed_1650  Common_myop.p_mph in
         let (outp_1602:(MyOp.t)Array.t) =
             Array.of_list ((::) (rpm_1617 ,
                                  ((::) (gear_1628 , ((::) (mph_1651 , ([]))))))) in
         let (rob_spec_1605:MyOp.t) =
             i_2067_step self.i_2067 (tstep'_1610 , inp_1597 , outp_1602) in
         let (dn_th_1624:MyOp.t) =
             Common_myop.lookup_interpdn (throttle_1609 , gear_1628) in
         let (up_th_1627:MyOp.t) =
             Common_myop.lookup_interpup (throttle_1609 , gear_1628) in
         (begin match self.s_1662 with
                | At_bench_SteadyState_580 ->
                    (if self.r_1663 then self.i_1687 <- true) ;
                    (if self.i_1687 then
                     self.go_up_1686 <- (>) (MyOp.make (Random.float 1.)) 
                                            (MyOp.make 0.5)) ;
                    self.i_1687 <- false ;
                    self.rob_1626 <- (if self.go_up_1686
                                      then MyOp.(-) up_th_1627  mph_1651
                                      else MyOp.(-) mph_1651  dn_th_1624) ;
                    (begin match (((>) mph_1651  up_th_1627) ,
                                  ((<) mph_1651  dn_th_1624)) with
                           | (_ , true) ->
                               self.t0_1629 <- x_1671 ;
                               self.r_1663 <- true ;
                               self.s_1662 <- At_bench_DownShifting_581
                           | (true , _) ->
                               self.t0_1630 <- x_1671 ;
                               self.r_1663 <- true ;
                               self.s_1662 <- At_bench_UpShifting_582
                           | _ -> self.r_1663 <- false  end)
                | At_bench_DownShifting_581 ->
                    (if self.r_1663 then ()) ;
                    self.rob_1626 <- Autotransd_modes.zero_val ;
                    (begin match (((>) x_1671 
                                       (MyOp.translate self.t0_1629 
                                                       Common_myop.twait)) ,
                                  ((>) mph_1651  dn_th_1624)) with
                           | (_ , true) ->
                               self.r_1663 <- true ;
                               self.s_1662 <- At_bench_SteadyState_580
                           | (true , _) ->
                               shiftp_1665 := true ;
                               shiftv_1664 := Common_myop.DOWN ;
                               self.r_1663 <- true ;
                               self.s_1662 <- At_bench_SteadyState_580
                           | _ -> self.r_1663 <- false  end)
                | At_bench_UpShifting_582 ->
                    (if self.r_1663 then ()) ;
                    self.rob_1626 <- Autotransd_modes.zero_val ;
                    (begin match (((>) x_1671 
                                       (MyOp.translate self.t0_1630 
                                                       Common_myop.twait)) ,
                                  ((<) mph_1651  up_th_1627)) with
                           | (_ , true) ->
                               self.r_1663 <- true ;
                               self.s_1662 <- At_bench_SteadyState_580
                           | (true , _) ->
                               shiftp_1665 := true ;
                               shiftv_1664 := Common_myop.UP ;
                               self.r_1663 <- true ;
                               self.s_1662 <- At_bench_SteadyState_580
                           | _ -> self.r_1663 <- false  end)
                 end) ;
         (let (rob_1603:MyOp.t) =
              if Discrete_obs_fad.isFalse rob_spec_1605
              then rob_spec_1605
              else
                if Discrete_obs_fad.isTrue self.rob_1626
                then self.rob_1626
                else rob_spec_1605 in
          self.m_1682 <- x_1684 ;
          (let (brake_1599:MyOp.t) = Array.get inp_1597  1 in
           let (road_load_1652:MyOp.t) =
               MyOp.translate (MyOp.scale (MyOp.sqr mph_1651) 
                                          Common_myop.p_aerodynamic_drag) 
                              Common_myop.p_drag_friction in
           let (brake_1648:MyOp.t) = MyOp.(+) brake_1599  road_load_1652 in
           let (sgn_1653:MyOp.t) =
               if (>=) mph_1651  Autotransd_modes.zero_val
               then MyOp.make 1.
               else MyOp.make (-1.) in
           let (signed_load_1654:MyOp.t) = MyOp.( * ) sgn_1653  brake_1648 in
           self.m_1680 <- signed_load_1654 ;
           self.m_1677 <- x_1671 ;
           (let (trans_rpm_1657:MyOp.t) =
                MyOp.scale x_1684  Common_myop.p_final_drive_ratio in
            self.m_1675 <- trans_rpm_1657 ;
            self.m_1673 <- rpm_1617 ;
            (begin match self.s_1660 with
                   | At_bench_First_576 ->
                       (if self.r_1661 then ()) ;
                       (begin match (!shiftv_1664 , !shiftp_1665) with
                              | (Common_myop.UP , true) ->
                                  self.nx_1672 <- Autotransd_modes.gear2 ;
                                  self.r_1661 <- true ;
                                  self.s_1660 <- At_bench_Second_577
                              | _ -> self.r_1661 <- false  end)
                   | At_bench_Second_577 ->
                       (if self.r_1661 then ()) ;
                       (begin match (!shiftv_1664 , !shiftp_1665) with
                              | (Common_myop.DOWN , true) ->
                                  self.nx_1672 <- Autotransd_modes.gear1 ;
                                  self.r_1661 <- true ;
                                  self.s_1660 <- At_bench_First_576
                              | (Common_myop.UP , true) ->
                                  self.nx_1672 <- Autotransd_modes.gear3 ;
                                  self.r_1661 <- true ;
                                  self.s_1660 <- At_bench_Third_578
                              | _ -> self.r_1661 <- false  end)
                   | At_bench_Third_578 ->
                       (if self.r_1661 then ()) ;
                       (begin match (!shiftv_1664 , !shiftp_1665) with
                              | (Common_myop.DOWN , true) ->
                                  self.nx_1672 <- Autotransd_modes.gear2 ;
                                  self.r_1661 <- true ;
                                  self.s_1660 <- At_bench_Second_577
                              | (Common_myop.UP , true) ->
                                  self.nx_1672 <- Autotransd_modes.gear4 ;
                                  self.r_1661 <- true ;
                                  self.s_1660 <- At_bench_Fourth_579
                              | _ -> self.r_1661 <- false  end)
                   | At_bench_Fourth_579 ->
                       (if self.r_1661 then ()) ;
                       (begin match (!shiftv_1664 , !shiftp_1665) with
                              | (Common_myop.DOWN , true) ->
                                  self.nx_1672 <- Autotransd_modes.gear3 ;
                                  self.r_1661 <- true ;
                                  self.s_1660 <- At_bench_Third_578
                              | _ -> self.r_1661 <- false  end)
                    end) ;
            (let (x_1669:MyOp.t) = self.m_1668 in
             self.m_1670 <- x_1669 ;
             self.m_1668 <- MyOp.(+) x_1669  tstep'_1610 ;
             ((MyOp.get x_1669) , outp_1602 , rob_1603))))))))):float *
                                                                MyOp.t
                                                                Array.t *
                                                                MyOp.t) in
  Node { alloc = autotrans_at53_alloc; reset = autotrans_at53_reset ;
                                       step = autotrans_at53_step }
type ('t ,
      's ,
      'r ,
      'q ,
      'p ,
      'o ,
      'n , 'm , 'l , 'k , 'j , 'i , 'h , 'g , 'f , 'e , 'd , 'c , 'b , 'a) _autotrans_at54 =
  { mutable i_2070 : 't ;
    mutable i_2069 : 's ;
    mutable i_1776 : 'r ;
    mutable m_1773 : 'q ;
    mutable m_1771 : 'p ;
    mutable m_1768 : 'o ;
    mutable m_1766 : 'n ;
    mutable m_1764 : 'm ;
    mutable nx_1763 : 'l ;
    mutable m_1761 : 'k ;
    mutable m_1759 : 'j ;
    mutable r_1754 : 'i ;
    mutable s_1753 : 'h ;
    mutable r_1752 : 'g ;
    mutable s_1751 : 'f ;
    mutable t0_1721 : 'e ;
    mutable t0_1720 : 'd ;
    mutable rob_1717 : 'c ; mutable i_1778 : 'b ; mutable go_up_1777 : 'a }

let autotrans_at54 (tstep_1689:float) = 
  let Node { alloc = i_2070_alloc; step = i_2070_step ; reset = i_2070_reset } = Autotransd_modes.engine 
   in 
  let Node { alloc = i_2069_alloc; step = i_2069_step ; reset = i_2069_reset } = at54 
   in
  let autotrans_at54_alloc _ =
    ();
    { i_1776 = (false:bool) ;
      m_1773 = (create ():MyOp.t) ;
      m_1771 = (create ():MyOp.t) ;
      m_1768 = (create ():MyOp.t) ;
      m_1766 = (create ():MyOp.t) ;
      m_1764 = (create ():MyOp.t) ;
      nx_1763 = (create ():MyOp.t) ;
      m_1761 = (create ():MyOp.t) ;
      m_1759 = (create ():MyOp.t) ;
      r_1754 = (false:bool) ;
      s_1753 = (At_bench_UpShifting_655:state__8763) ;
      r_1752 = (false:bool) ;
      s_1751 = (At_bench_Fourth_652:state__8762) ;
      t0_1721 = (create ():MyOp.t) ;
      t0_1720 = (create ():MyOp.t) ;
      rob_1717 = (create ():MyOp.t) ;
      i_1778 = (false:bool) ; go_up_1777 = (false:bool);
      i_2070 = i_2070_alloc () (* discrete *)  ;
      i_2069 = i_2069_alloc () (* discrete *)  } in
  let autotrans_at54_reset self  =
    ((self.i_1776 <- true ;
      i_2070_reset self.i_2070  ;
      i_2069_reset self.i_2069  ;
      self.r_1754 <- false ;
      self.s_1753 <- At_bench_SteadyState_653 ;
      self.i_1778 <- true ;
      self.r_1752 <- false ; self.s_1751 <- At_bench_First_649):unit) in 
  let autotrans_at54_step self (inp_1688:(MyOp.t)Array.t) =
    ((let shiftp_1756 = ref (false:bool) in
      let shiftv_1755 = ref (Common_myop.DOWN:Common_myop.shift) in
      (if self.i_1776 then self.nx_1763 <- Autotransd_modes.gear1) ;
      (let (gear_1719:MyOp.t) = self.nx_1763 in
       let (gear_lookup_1732:MyOp.t) = Common_myop.lookup_gear gear_1719 in
       let (nin_1733:MyOp.t) = MyOp.( * ) self.m_1766  gear_lookup_1732 in
       let ((ti_1726:MyOp.t) , (turbine_torque_1728:MyOp.t)) =
           Common_myop.torque_converter (self.m_1764 , nin_1733) in
       let (tout_1734:MyOp.t) =
           MyOp.( * ) turbine_torque_1728  gear_lookup_1732 in
       let (final_drive_ratio_1740:MyOp.t) =
           MyOp.scale tout_1734  Common_myop.p_final_drive_ratio in
       let (aux1_1738:MyOp.t) = MyOp.(-) final_drive_ratio_1740  self.m_1771 in
       let (vehicle_inertia_1749:MyOp.t) =
           MyOp.scale aux1_1738  Common_myop.iv_inv in
       (if self.i_1776 then self.m_1761 <- MyOp.make 0.) ;
       (let (x_1762:MyOp.t) = self.m_1761 in
        let (x_1770:MyOp.t) =
            if self.i_1776 then x_1762 else MyOp.(-) x_1762  self.m_1768 in
        let (x_1775:MyOp.t) =
            if self.i_1776
            then MyOp.make Common_myop.p_initial_wheel_speed
            else
              MyOp.(+) self.m_1773  (MyOp.( * ) vehicle_inertia_1749  x_1770) in
        let (tstep'_1701:MyOp.t) = MyOp.make tstep_1689 in
        (if self.i_1776 then self.m_1759 <- tstep'_1701) ;
        self.i_1776 <- false ;
        (let (throttle_1700:MyOp.t) = Array.get inp_1688  0 in
         let (rpm_1708:MyOp.t) =
             i_2070_step self.i_2070 (x_1762 , ti_1726 , throttle_1700) in
         let (linear_speed_1741:MyOp.t) =
             MyOp.scale x_1775  Common_myop.l_speed_coef in
         let (mph_1742:MyOp.t) =
             MyOp.scale linear_speed_1741  Common_myop.p_mph in
         let (outp_1693:(MyOp.t)Array.t) =
             Array.of_list ((::) (rpm_1708 ,
                                  ((::) (gear_1719 , ((::) (mph_1742 , ([]))))))) in
         let (rob_spec_1696:MyOp.t) =
             i_2069_step self.i_2069 (tstep'_1701 , inp_1688 , outp_1693) in
         let (dn_th_1715:MyOp.t) =
             Common_myop.lookup_interpdn (throttle_1700 , gear_1719) in
         let (up_th_1718:MyOp.t) =
             Common_myop.lookup_interpup (throttle_1700 , gear_1719) in
         (begin match self.s_1753 with
                | At_bench_SteadyState_653 ->
                    (if self.r_1754 then self.i_1778 <- true) ;
                    (if self.i_1778 then
                     self.go_up_1777 <- (>) (MyOp.make (Random.float 1.)) 
                                            (MyOp.make 0.5)) ;
                    self.i_1778 <- false ;
                    self.rob_1717 <- (if self.go_up_1777
                                      then MyOp.(-) up_th_1718  mph_1742
                                      else MyOp.(-) mph_1742  dn_th_1715) ;
                    (begin match (((>) mph_1742  up_th_1718) ,
                                  ((<) mph_1742  dn_th_1715)) with
                           | (_ , true) ->
                               self.t0_1720 <- x_1762 ;
                               self.r_1754 <- true ;
                               self.s_1753 <- At_bench_DownShifting_654
                           | (true , _) ->
                               self.t0_1721 <- x_1762 ;
                               self.r_1754 <- true ;
                               self.s_1753 <- At_bench_UpShifting_655
                           | _ -> self.r_1754 <- false  end)
                | At_bench_DownShifting_654 ->
                    (if self.r_1754 then ()) ;
                    self.rob_1717 <- Autotransd_modes.zero_val ;
                    (begin match (((>) x_1762 
                                       (MyOp.translate self.t0_1720 
                                                       Common_myop.twait)) ,
                                  ((>) mph_1742  dn_th_1715)) with
                           | (_ , true) ->
                               self.r_1754 <- true ;
                               self.s_1753 <- At_bench_SteadyState_653
                           | (true , _) ->
                               shiftp_1756 := true ;
                               shiftv_1755 := Common_myop.DOWN ;
                               self.r_1754 <- true ;
                               self.s_1753 <- At_bench_SteadyState_653
                           | _ -> self.r_1754 <- false  end)
                | At_bench_UpShifting_655 ->
                    (if self.r_1754 then ()) ;
                    self.rob_1717 <- Autotransd_modes.zero_val ;
                    (begin match (((>) x_1762 
                                       (MyOp.translate self.t0_1721 
                                                       Common_myop.twait)) ,
                                  ((<) mph_1742  up_th_1718)) with
                           | (_ , true) ->
                               self.r_1754 <- true ;
                               self.s_1753 <- At_bench_SteadyState_653
                           | (true , _) ->
                               shiftp_1756 := true ;
                               shiftv_1755 := Common_myop.UP ;
                               self.r_1754 <- true ;
                               self.s_1753 <- At_bench_SteadyState_653
                           | _ -> self.r_1754 <- false  end)
                 end) ;
         (let (rob_1694:MyOp.t) =
              if Discrete_obs_fad.isFalse rob_spec_1696
              then rob_spec_1696
              else
                if Discrete_obs_fad.isTrue self.rob_1717
                then self.rob_1717
                else rob_spec_1696 in
          self.m_1773 <- x_1775 ;
          (let (brake_1690:MyOp.t) = Array.get inp_1688  1 in
           let (road_load_1743:MyOp.t) =
               MyOp.translate (MyOp.scale (MyOp.sqr mph_1742) 
                                          Common_myop.p_aerodynamic_drag) 
                              Common_myop.p_drag_friction in
           let (brake_1739:MyOp.t) = MyOp.(+) brake_1690  road_load_1743 in
           let (sgn_1744:MyOp.t) =
               if (>=) mph_1742  Autotransd_modes.zero_val
               then MyOp.make 1.
               else MyOp.make (-1.) in
           let (signed_load_1745:MyOp.t) = MyOp.( * ) sgn_1744  brake_1739 in
           self.m_1771 <- signed_load_1745 ;
           self.m_1768 <- x_1762 ;
           (let (trans_rpm_1748:MyOp.t) =
                MyOp.scale x_1775  Common_myop.p_final_drive_ratio in
            self.m_1766 <- trans_rpm_1748 ;
            self.m_1764 <- rpm_1708 ;
            (begin match self.s_1751 with
                   | At_bench_First_649 ->
                       (if self.r_1752 then ()) ;
                       (begin match (!shiftv_1755 , !shiftp_1756) with
                              | (Common_myop.UP , true) ->
                                  self.nx_1763 <- Autotransd_modes.gear2 ;
                                  self.r_1752 <- true ;
                                  self.s_1751 <- At_bench_Second_650
                              | _ -> self.r_1752 <- false  end)
                   | At_bench_Second_650 ->
                       (if self.r_1752 then ()) ;
                       (begin match (!shiftv_1755 , !shiftp_1756) with
                              | (Common_myop.DOWN , true) ->
                                  self.nx_1763 <- Autotransd_modes.gear1 ;
                                  self.r_1752 <- true ;
                                  self.s_1751 <- At_bench_First_649
                              | (Common_myop.UP , true) ->
                                  self.nx_1763 <- Autotransd_modes.gear3 ;
                                  self.r_1752 <- true ;
                                  self.s_1751 <- At_bench_Third_651
                              | _ -> self.r_1752 <- false  end)
                   | At_bench_Third_651 ->
                       (if self.r_1752 then ()) ;
                       (begin match (!shiftv_1755 , !shiftp_1756) with
                              | (Common_myop.DOWN , true) ->
                                  self.nx_1763 <- Autotransd_modes.gear2 ;
                                  self.r_1752 <- true ;
                                  self.s_1751 <- At_bench_Second_650
                              | (Common_myop.UP , true) ->
                                  self.nx_1763 <- Autotransd_modes.gear4 ;
                                  self.r_1752 <- true ;
                                  self.s_1751 <- At_bench_Fourth_652
                              | _ -> self.r_1752 <- false  end)
                   | At_bench_Fourth_652 ->
                       (if self.r_1752 then ()) ;
                       (begin match (!shiftv_1755 , !shiftp_1756) with
                              | (Common_myop.DOWN , true) ->
                                  self.nx_1763 <- Autotransd_modes.gear3 ;
                                  self.r_1752 <- true ;
                                  self.s_1751 <- At_bench_Third_651
                              | _ -> self.r_1752 <- false  end)
                    end) ;
            (let (x_1760:MyOp.t) = self.m_1759 in
             self.m_1761 <- x_1760 ;
             self.m_1759 <- MyOp.(+) x_1760  tstep'_1701 ;
             ((MyOp.get x_1760) , outp_1693 , rob_1694))))))))):float *
                                                                MyOp.t
                                                                Array.t *
                                                                MyOp.t) in
  Node { alloc = autotrans_at54_alloc; reset = autotrans_at54_reset ;
                                       step = autotrans_at54_step }
type ('q ,
      'p ,
      'o ,
      'n , 'm , 'l , 'k , 'j , 'i , 'h , 'g , 'f , 'e , 'd , 'c , 'b , 'a) _autotrans_at6a =
  { mutable i_2072 : 'q ;
    mutable i_2071 : 'p ;
    mutable i_1863 : 'o ;
    mutable m_1860 : 'n ;
    mutable m_1858 : 'm ;
    mutable m_1855 : 'l ;
    mutable m_1853 : 'k ;
    mutable m_1851 : 'j ;
    mutable nx_1850 : 'i ;
    mutable m_1848 : 'h ;
    mutable m_1846 : 'g ;
    mutable r_1841 : 'f ;
    mutable s_1840 : 'e ;
    mutable r_1839 : 'd ;
    mutable s_1838 : 'c ; mutable t0_1808 : 'b ; mutable t0_1807 : 'a }

let autotrans_at6a (tstep_1780:float) = 
  let Node { alloc = i_2072_alloc; step = i_2072_step ; reset = i_2072_reset } = Autotransd.engine 
   in 
  let Node { alloc = i_2071_alloc; step = i_2071_step ; reset = i_2071_reset } = at6a 
   in
  let autotrans_at6a_alloc _ =
    ();
    { i_1863 = (false:bool) ;
      m_1860 = (create ():MyOp.t) ;
      m_1858 = (create ():MyOp.t) ;
      m_1855 = (create ():MyOp.t) ;
      m_1853 = (create ():MyOp.t) ;
      m_1851 = (create ():MyOp.t) ;
      nx_1850 = (create ():MyOp.t) ;
      m_1848 = (create ():MyOp.t) ;
      m_1846 = (create ():MyOp.t) ;
      r_1841 = (false:bool) ;
      s_1840 = (At_bench_UpShifting_724:state__8765) ;
      r_1839 = (false:bool) ;
      s_1838 = (At_bench_Fourth_721:state__8764) ;
      t0_1808 = (create ():MyOp.t) ; t0_1807 = (create ():MyOp.t);
      i_2072 = i_2072_alloc () (* discrete *)  ;
      i_2071 = i_2071_alloc () (* discrete *)  } in
  let autotrans_at6a_reset self  =
    ((self.i_1863 <- true ;
      i_2072_reset self.i_2072  ;
      i_2071_reset self.i_2071  ;
      self.r_1841 <- false ;
      self.s_1840 <- At_bench_SteadyState_722 ;
      self.r_1839 <- false ; self.s_1838 <- At_bench_First_718):unit) in 
  let autotrans_at6a_step self (inp_1779:(MyOp.t)Array.t) =
    ((let shiftp_1843 = ref (false:bool) in
      let shiftv_1842 = ref (Common_myop.DOWN:Common_myop.shift) in
      (if self.i_1863 then self.nx_1850 <- Autotransd.gear1) ;
      (let (gear_1806:MyOp.t) = self.nx_1850 in
       let (gear_lookup_1819:MyOp.t) = Common_myop.lookup_gear gear_1806 in
       let (nin_1820:MyOp.t) = MyOp.( * ) self.m_1853  gear_lookup_1819 in
       let ((ti_1813:MyOp.t) , (turbine_torque_1815:MyOp.t)) =
           Common_myop.torque_converter (self.m_1851 , nin_1820) in
       let (tout_1821:MyOp.t) =
           MyOp.( * ) turbine_torque_1815  gear_lookup_1819 in
       let (final_drive_ratio_1827:MyOp.t) =
           MyOp.scale tout_1821  Common_myop.p_final_drive_ratio in
       let (aux1_1825:MyOp.t) = MyOp.(-) final_drive_ratio_1827  self.m_1858 in
       let (vehicle_inertia_1836:MyOp.t) =
           MyOp.scale aux1_1825  Common_myop.iv_inv in
       (if self.i_1863 then self.m_1848 <- MyOp.make 0.) ;
       (let (x_1849:MyOp.t) = self.m_1848 in
        let (x_1857:MyOp.t) =
            if self.i_1863 then x_1849 else MyOp.(-) x_1849  self.m_1855 in
        let (x_1862:MyOp.t) =
            if self.i_1863
            then MyOp.make Common_myop.p_initial_wheel_speed
            else
              MyOp.(+) self.m_1860  (MyOp.( * ) vehicle_inertia_1836  x_1857) in
        let (tstep'_1790:MyOp.t) = MyOp.make tstep_1780 in
        (if self.i_1863 then self.m_1846 <- tstep'_1790) ;
        self.i_1863 <- false ;
        (let (throttle_1789:MyOp.t) = Array.get inp_1779  0 in
         let (rpm_1796:MyOp.t) =
             i_2072_step self.i_2072 (x_1849 , ti_1813 , throttle_1789) in
         let (linear_speed_1828:MyOp.t) =
             MyOp.scale x_1862  Common_myop.l_speed_coef in
         let (mph_1829:MyOp.t) =
             MyOp.scale linear_speed_1828  Common_myop.p_mph in
         let (outp_1784:(MyOp.t)Array.t) =
             Array.of_list ((::) (rpm_1796 ,
                                  ((::) (gear_1806 , ((::) (mph_1829 , ([]))))))) in
         let (rob_1785:MyOp.t) =
             i_2071_step self.i_2071 (tstep'_1790 , inp_1779 , outp_1784) in
         self.m_1860 <- x_1862 ;
         (let (brake_1781:MyOp.t) = Array.get inp_1779  1 in
          let (road_load_1830:MyOp.t) =
              MyOp.translate (MyOp.scale (MyOp.sqr mph_1829) 
                                         Common_myop.p_aerodynamic_drag) 
                             Common_myop.p_drag_friction in
          let (brake_1826:MyOp.t) = MyOp.(+) brake_1781  road_load_1830 in
          let (sgn_1831:MyOp.t) =
              if (>=) mph_1829  Autotransd.zero_val
              then MyOp.make 1.
              else MyOp.make (-1.) in
          let (signed_load_1832:MyOp.t) = MyOp.( * ) sgn_1831  brake_1826 in
          self.m_1858 <- signed_load_1832 ;
          self.m_1855 <- x_1849 ;
          (let (trans_rpm_1835:MyOp.t) =
               MyOp.scale x_1862  Common_myop.p_final_drive_ratio in
           self.m_1853 <- trans_rpm_1835 ;
           self.m_1851 <- rpm_1796 ;
           (let (dn_th_1803:MyOp.t) =
                Common_myop.lookup_interpdn (throttle_1789 , gear_1806) in
            let (up_th_1805:MyOp.t) =
                Common_myop.lookup_interpup (throttle_1789 , gear_1806) in
            (begin match self.s_1840 with
                   | At_bench_SteadyState_722 ->
                       (if self.r_1841 then ()) ;
                       (begin match (((>) mph_1829  up_th_1805) ,
                                     ((<) mph_1829  dn_th_1803)) with
                              | (_ , true) ->
                                  self.t0_1807 <- x_1849 ;
                                  self.r_1841 <- true ;
                                  self.s_1840 <- At_bench_DownShifting_723
                              | (true , _) ->
                                  self.t0_1808 <- x_1849 ;
                                  self.r_1841 <- true ;
                                  self.s_1840 <- At_bench_UpShifting_724
                              | _ -> self.r_1841 <- false  end)
                   | At_bench_DownShifting_723 ->
                       (if self.r_1841 then ()) ;
                       (begin match (((>) x_1849 
                                          (MyOp.translate self.t0_1807 
                                                          Common_myop.twait))
                                     , ((>) mph_1829  dn_th_1803)) with
                              | (_ , true) ->
                                  self.r_1841 <- true ;
                                  self.s_1840 <- At_bench_SteadyState_722
                              | (true , _) ->
                                  shiftp_1843 := true ;
                                  shiftv_1842 := Common_myop.DOWN ;
                                  self.r_1841 <- true ;
                                  self.s_1840 <- At_bench_SteadyState_722
                              | _ -> self.r_1841 <- false  end)
                   | At_bench_UpShifting_724 ->
                       (if self.r_1841 then ()) ;
                       (begin match (((>) x_1849 
                                          (MyOp.translate self.t0_1808 
                                                          Common_myop.twait))
                                     , ((<) mph_1829  up_th_1805)) with
                              | (_ , true) ->
                                  self.r_1841 <- true ;
                                  self.s_1840 <- At_bench_SteadyState_722
                              | (true , _) ->
                                  shiftp_1843 := true ;
                                  shiftv_1842 := Common_myop.UP ;
                                  self.r_1841 <- true ;
                                  self.s_1840 <- At_bench_SteadyState_722
                              | _ -> self.r_1841 <- false  end)
                    end) ;
            (begin match self.s_1838 with
                   | At_bench_First_718 ->
                       (if self.r_1839 then ()) ;
                       (begin match (!shiftv_1842 , !shiftp_1843) with
                              | (Common_myop.UP , true) ->
                                  self.nx_1850 <- Autotransd.gear2 ;
                                  self.r_1839 <- true ;
                                  self.s_1838 <- At_bench_Second_719
                              | _ -> self.r_1839 <- false  end)
                   | At_bench_Second_719 ->
                       (if self.r_1839 then ()) ;
                       (begin match (!shiftv_1842 , !shiftp_1843) with
                              | (Common_myop.DOWN , true) ->
                                  self.nx_1850 <- Autotransd.gear1 ;
                                  self.r_1839 <- true ;
                                  self.s_1838 <- At_bench_First_718
                              | (Common_myop.UP , true) ->
                                  self.nx_1850 <- Autotransd.gear3 ;
                                  self.r_1839 <- true ;
                                  self.s_1838 <- At_bench_Third_720
                              | _ -> self.r_1839 <- false  end)
                   | At_bench_Third_720 ->
                       (if self.r_1839 then ()) ;
                       (begin match (!shiftv_1842 , !shiftp_1843) with
                              | (Common_myop.DOWN , true) ->
                                  self.nx_1850 <- Autotransd.gear2 ;
                                  self.r_1839 <- true ;
                                  self.s_1838 <- At_bench_Second_719
                              | (Common_myop.UP , true) ->
                                  self.nx_1850 <- Autotransd.gear4 ;
                                  self.r_1839 <- true ;
                                  self.s_1838 <- At_bench_Fourth_721
                              | _ -> self.r_1839 <- false  end)
                   | At_bench_Fourth_721 ->
                       (if self.r_1839 then ()) ;
                       (begin match (!shiftv_1842 , !shiftp_1843) with
                              | (Common_myop.DOWN , true) ->
                                  self.nx_1850 <- Autotransd.gear3 ;
                                  self.r_1839 <- true ;
                                  self.s_1838 <- At_bench_Third_720
                              | _ -> self.r_1839 <- false  end)
                    end) ;
            (let (x_1847:MyOp.t) = self.m_1846 in
             self.m_1848 <- x_1847 ;
             self.m_1846 <- MyOp.(+) x_1847  tstep'_1790 ;
             ((MyOp.get x_1847) ,
              outp_1784 , (MyOp.(+) rob_1785  (MyOp.make 0.1))))))))))):
    float * MyOp.t Array.t * MyOp.t) in
  Node { alloc = autotrans_at6a_alloc; reset = autotrans_at6a_reset ;
                                       step = autotrans_at6a_step }
type ('q ,
      'p ,
      'o ,
      'n , 'm , 'l , 'k , 'j , 'i , 'h , 'g , 'f , 'e , 'd , 'c , 'b , 'a) _autotrans_at6b =
  { mutable i_2074 : 'q ;
    mutable i_2073 : 'p ;
    mutable i_1948 : 'o ;
    mutable m_1945 : 'n ;
    mutable m_1943 : 'm ;
    mutable m_1940 : 'l ;
    mutable m_1938 : 'k ;
    mutable m_1936 : 'j ;
    mutable nx_1935 : 'i ;
    mutable m_1933 : 'h ;
    mutable m_1931 : 'g ;
    mutable r_1926 : 'f ;
    mutable s_1925 : 'e ;
    mutable r_1924 : 'd ;
    mutable s_1923 : 'c ; mutable t0_1893 : 'b ; mutable t0_1892 : 'a }

let autotrans_at6b (tstep_1865:float) = 
  let Node { alloc = i_2074_alloc; step = i_2074_step ; reset = i_2074_reset } = Autotransd.engine 
   in 
  let Node { alloc = i_2073_alloc; step = i_2073_step ; reset = i_2073_reset } = at6b 
   in
  let autotrans_at6b_alloc _ =
    ();
    { i_1948 = (false:bool) ;
      m_1945 = (create ():MyOp.t) ;
      m_1943 = (create ():MyOp.t) ;
      m_1940 = (create ():MyOp.t) ;
      m_1938 = (create ():MyOp.t) ;
      m_1936 = (create ():MyOp.t) ;
      nx_1935 = (create ():MyOp.t) ;
      m_1933 = (create ():MyOp.t) ;
      m_1931 = (create ():MyOp.t) ;
      r_1926 = (false:bool) ;
      s_1925 = (At_bench_UpShifting_792:state__8767) ;
      r_1924 = (false:bool) ;
      s_1923 = (At_bench_Fourth_789:state__8766) ;
      t0_1893 = (create ():MyOp.t) ; t0_1892 = (create ():MyOp.t);
      i_2074 = i_2074_alloc () (* discrete *)  ;
      i_2073 = i_2073_alloc () (* discrete *)  } in
  let autotrans_at6b_reset self  =
    ((self.i_1948 <- true ;
      i_2074_reset self.i_2074  ;
      i_2073_reset self.i_2073  ;
      self.r_1926 <- false ;
      self.s_1925 <- At_bench_SteadyState_790 ;
      self.r_1924 <- false ; self.s_1923 <- At_bench_First_786):unit) in 
  let autotrans_at6b_step self (inp_1864:(MyOp.t)Array.t) =
    ((let shiftp_1928 = ref (false:bool) in
      let shiftv_1927 = ref (Common_myop.DOWN:Common_myop.shift) in
      (if self.i_1948 then self.nx_1935 <- Autotransd.gear1) ;
      (let (gear_1891:MyOp.t) = self.nx_1935 in
       let (gear_lookup_1904:MyOp.t) = Common_myop.lookup_gear gear_1891 in
       let (nin_1905:MyOp.t) = MyOp.( * ) self.m_1938  gear_lookup_1904 in
       let ((ti_1898:MyOp.t) , (turbine_torque_1900:MyOp.t)) =
           Common_myop.torque_converter (self.m_1936 , nin_1905) in
       let (tout_1906:MyOp.t) =
           MyOp.( * ) turbine_torque_1900  gear_lookup_1904 in
       let (final_drive_ratio_1912:MyOp.t) =
           MyOp.scale tout_1906  Common_myop.p_final_drive_ratio in
       let (aux1_1910:MyOp.t) = MyOp.(-) final_drive_ratio_1912  self.m_1943 in
       let (vehicle_inertia_1921:MyOp.t) =
           MyOp.scale aux1_1910  Common_myop.iv_inv in
       (if self.i_1948 then self.m_1933 <- MyOp.make 0.) ;
       (let (x_1934:MyOp.t) = self.m_1933 in
        let (x_1942:MyOp.t) =
            if self.i_1948 then x_1934 else MyOp.(-) x_1934  self.m_1940 in
        let (x_1947:MyOp.t) =
            if self.i_1948
            then MyOp.make Common_myop.p_initial_wheel_speed
            else
              MyOp.(+) self.m_1945  (MyOp.( * ) vehicle_inertia_1921  x_1942) in
        let (tstep'_1875:MyOp.t) = MyOp.make tstep_1865 in
        (if self.i_1948 then self.m_1931 <- tstep'_1875) ;
        self.i_1948 <- false ;
        (let (throttle_1874:MyOp.t) = Array.get inp_1864  0 in
         let (rpm_1881:MyOp.t) =
             i_2074_step self.i_2074 (x_1934 , ti_1898 , throttle_1874) in
         let (linear_speed_1913:MyOp.t) =
             MyOp.scale x_1947  Common_myop.l_speed_coef in
         let (mph_1914:MyOp.t) =
             MyOp.scale linear_speed_1913  Common_myop.p_mph in
         let (outp_1869:(MyOp.t)Array.t) =
             Array.of_list ((::) (rpm_1881 ,
                                  ((::) (gear_1891 , ((::) (mph_1914 , ([]))))))) in
         let (rob_1870:MyOp.t) =
             i_2073_step self.i_2073 (tstep'_1875 , inp_1864 , outp_1869) in
         self.m_1945 <- x_1947 ;
         (let (brake_1866:MyOp.t) = Array.get inp_1864  1 in
          let (road_load_1915:MyOp.t) =
              MyOp.translate (MyOp.scale (MyOp.sqr mph_1914) 
                                         Common_myop.p_aerodynamic_drag) 
                             Common_myop.p_drag_friction in
          let (brake_1911:MyOp.t) = MyOp.(+) brake_1866  road_load_1915 in
          let (sgn_1916:MyOp.t) =
              if (>=) mph_1914  Autotransd.zero_val
              then MyOp.make 1.
              else MyOp.make (-1.) in
          let (signed_load_1917:MyOp.t) = MyOp.( * ) sgn_1916  brake_1911 in
          self.m_1943 <- signed_load_1917 ;
          self.m_1940 <- x_1934 ;
          (let (trans_rpm_1920:MyOp.t) =
               MyOp.scale x_1947  Common_myop.p_final_drive_ratio in
           self.m_1938 <- trans_rpm_1920 ;
           self.m_1936 <- rpm_1881 ;
           (let (dn_th_1888:MyOp.t) =
                Common_myop.lookup_interpdn (throttle_1874 , gear_1891) in
            let (up_th_1890:MyOp.t) =
                Common_myop.lookup_interpup (throttle_1874 , gear_1891) in
            (begin match self.s_1925 with
                   | At_bench_SteadyState_790 ->
                       (if self.r_1926 then ()) ;
                       (begin match (((>) mph_1914  up_th_1890) ,
                                     ((<) mph_1914  dn_th_1888)) with
                              | (_ , true) ->
                                  self.t0_1892 <- x_1934 ;
                                  self.r_1926 <- true ;
                                  self.s_1925 <- At_bench_DownShifting_791
                              | (true , _) ->
                                  self.t0_1893 <- x_1934 ;
                                  self.r_1926 <- true ;
                                  self.s_1925 <- At_bench_UpShifting_792
                              | _ -> self.r_1926 <- false  end)
                   | At_bench_DownShifting_791 ->
                       (if self.r_1926 then ()) ;
                       (begin match (((>) x_1934 
                                          (MyOp.translate self.t0_1892 
                                                          Common_myop.twait))
                                     , ((>) mph_1914  dn_th_1888)) with
                              | (_ , true) ->
                                  self.r_1926 <- true ;
                                  self.s_1925 <- At_bench_SteadyState_790
                              | (true , _) ->
                                  shiftp_1928 := true ;
                                  shiftv_1927 := Common_myop.DOWN ;
                                  self.r_1926 <- true ;
                                  self.s_1925 <- At_bench_SteadyState_790
                              | _ -> self.r_1926 <- false  end)
                   | At_bench_UpShifting_792 ->
                       (if self.r_1926 then ()) ;
                       (begin match (((>) x_1934 
                                          (MyOp.translate self.t0_1893 
                                                          Common_myop.twait))
                                     , ((<) mph_1914  up_th_1890)) with
                              | (_ , true) ->
                                  self.r_1926 <- true ;
                                  self.s_1925 <- At_bench_SteadyState_790
                              | (true , _) ->
                                  shiftp_1928 := true ;
                                  shiftv_1927 := Common_myop.UP ;
                                  self.r_1926 <- true ;
                                  self.s_1925 <- At_bench_SteadyState_790
                              | _ -> self.r_1926 <- false  end)
                    end) ;
            (begin match self.s_1923 with
                   | At_bench_First_786 ->
                       (if self.r_1924 then ()) ;
                       (begin match (!shiftv_1927 , !shiftp_1928) with
                              | (Common_myop.UP , true) ->
                                  self.nx_1935 <- Autotransd.gear2 ;
                                  self.r_1924 <- true ;
                                  self.s_1923 <- At_bench_Second_787
                              | _ -> self.r_1924 <- false  end)
                   | At_bench_Second_787 ->
                       (if self.r_1924 then ()) ;
                       (begin match (!shiftv_1927 , !shiftp_1928) with
                              | (Common_myop.DOWN , true) ->
                                  self.nx_1935 <- Autotransd.gear1 ;
                                  self.r_1924 <- true ;
                                  self.s_1923 <- At_bench_First_786
                              | (Common_myop.UP , true) ->
                                  self.nx_1935 <- Autotransd.gear3 ;
                                  self.r_1924 <- true ;
                                  self.s_1923 <- At_bench_Third_788
                              | _ -> self.r_1924 <- false  end)
                   | At_bench_Third_788 ->
                       (if self.r_1924 then ()) ;
                       (begin match (!shiftv_1927 , !shiftp_1928) with
                              | (Common_myop.DOWN , true) ->
                                  self.nx_1935 <- Autotransd.gear2 ;
                                  self.r_1924 <- true ;
                                  self.s_1923 <- At_bench_Second_787
                              | (Common_myop.UP , true) ->
                                  self.nx_1935 <- Autotransd.gear4 ;
                                  self.r_1924 <- true ;
                                  self.s_1923 <- At_bench_Fourth_789
                              | _ -> self.r_1924 <- false  end)
                   | At_bench_Fourth_789 ->
                       (if self.r_1924 then ()) ;
                       (begin match (!shiftv_1927 , !shiftp_1928) with
                              | (Common_myop.DOWN , true) ->
                                  self.nx_1935 <- Autotransd.gear3 ;
                                  self.r_1924 <- true ;
                                  self.s_1923 <- At_bench_Third_788
                              | _ -> self.r_1924 <- false  end)
                    end) ;
            (let (x_1932:MyOp.t) = self.m_1931 in
             self.m_1933 <- x_1932 ;
             self.m_1931 <- MyOp.(+) x_1932  tstep'_1875 ;
             ((MyOp.get x_1932) , outp_1869 , rob_1870))))))))):float *
                                                                MyOp.t
                                                                Array.t *
                                                                MyOp.t) in
  Node { alloc = autotrans_at6b_alloc; reset = autotrans_at6b_reset ;
                                       step = autotrans_at6b_step }
type ('q ,
      'p ,
      'o ,
      'n , 'm , 'l , 'k , 'j , 'i , 'h , 'g , 'f , 'e , 'd , 'c , 'b , 'a) _autotrans_at6c =
  { mutable i_2076 : 'q ;
    mutable i_2075 : 'p ;
    mutable i_2033 : 'o ;
    mutable m_2030 : 'n ;
    mutable m_2028 : 'm ;
    mutable m_2025 : 'l ;
    mutable m_2023 : 'k ;
    mutable m_2021 : 'j ;
    mutable nx_2020 : 'i ;
    mutable m_2018 : 'h ;
    mutable m_2016 : 'g ;
    mutable r_2011 : 'f ;
    mutable s_2010 : 'e ;
    mutable r_2009 : 'd ;
    mutable s_2008 : 'c ; mutable t0_1978 : 'b ; mutable t0_1977 : 'a }

let autotrans_at6c (tstep_1950:float) = 
  let Node { alloc = i_2076_alloc; step = i_2076_step ; reset = i_2076_reset } = Autotransd.engine 
   in 
  let Node { alloc = i_2075_alloc; step = i_2075_step ; reset = i_2075_reset } = at6c 
   in
  let autotrans_at6c_alloc _ =
    ();
    { i_2033 = (false:bool) ;
      m_2030 = (create ():MyOp.t) ;
      m_2028 = (create ():MyOp.t) ;
      m_2025 = (create ():MyOp.t) ;
      m_2023 = (create ():MyOp.t) ;
      m_2021 = (create ():MyOp.t) ;
      nx_2020 = (create ():MyOp.t) ;
      m_2018 = (create ():MyOp.t) ;
      m_2016 = (create ():MyOp.t) ;
      r_2011 = (false:bool) ;
      s_2010 = (At_bench_UpShifting_860:state__8769) ;
      r_2009 = (false:bool) ;
      s_2008 = (At_bench_Fourth_857:state__8768) ;
      t0_1978 = (create ():MyOp.t) ; t0_1977 = (create ():MyOp.t);
      i_2076 = i_2076_alloc () (* discrete *)  ;
      i_2075 = i_2075_alloc () (* discrete *)  } in
  let autotrans_at6c_reset self  =
    ((self.i_2033 <- true ;
      i_2076_reset self.i_2076  ;
      i_2075_reset self.i_2075  ;
      self.r_2011 <- false ;
      self.s_2010 <- At_bench_SteadyState_858 ;
      self.r_2009 <- false ; self.s_2008 <- At_bench_First_854):unit) in 
  let autotrans_at6c_step self (inp_1949:(MyOp.t)Array.t) =
    ((let shiftp_2013 = ref (false:bool) in
      let shiftv_2012 = ref (Common_myop.DOWN:Common_myop.shift) in
      (if self.i_2033 then self.nx_2020 <- Autotransd.gear1) ;
      (let (gear_1976:MyOp.t) = self.nx_2020 in
       let (gear_lookup_1989:MyOp.t) = Common_myop.lookup_gear gear_1976 in
       let (nin_1990:MyOp.t) = MyOp.( * ) self.m_2023  gear_lookup_1989 in
       let ((ti_1983:MyOp.t) , (turbine_torque_1985:MyOp.t)) =
           Common_myop.torque_converter (self.m_2021 , nin_1990) in
       let (tout_1991:MyOp.t) =
           MyOp.( * ) turbine_torque_1985  gear_lookup_1989 in
       let (final_drive_ratio_1997:MyOp.t) =
           MyOp.scale tout_1991  Common_myop.p_final_drive_ratio in
       let (aux1_1995:MyOp.t) = MyOp.(-) final_drive_ratio_1997  self.m_2028 in
       let (vehicle_inertia_2006:MyOp.t) =
           MyOp.scale aux1_1995  Common_myop.iv_inv in
       (if self.i_2033 then self.m_2018 <- MyOp.make 0.) ;
       (let (x_2019:MyOp.t) = self.m_2018 in
        let (x_2027:MyOp.t) =
            if self.i_2033 then x_2019 else MyOp.(-) x_2019  self.m_2025 in
        let (x_2032:MyOp.t) =
            if self.i_2033
            then MyOp.make Common_myop.p_initial_wheel_speed
            else
              MyOp.(+) self.m_2030  (MyOp.( * ) vehicle_inertia_2006  x_2027) in
        let (tstep'_1960:MyOp.t) = MyOp.make tstep_1950 in
        (if self.i_2033 then self.m_2016 <- tstep'_1960) ;
        self.i_2033 <- false ;
        (let (throttle_1959:MyOp.t) = Array.get inp_1949  0 in
         let (rpm_1966:MyOp.t) =
             i_2076_step self.i_2076 (x_2019 , ti_1983 , throttle_1959) in
         let (linear_speed_1998:MyOp.t) =
             MyOp.scale x_2032  Common_myop.l_speed_coef in
         let (mph_1999:MyOp.t) =
             MyOp.scale linear_speed_1998  Common_myop.p_mph in
         let (outp_1954:(MyOp.t)Array.t) =
             Array.of_list ((::) (rpm_1966 ,
                                  ((::) (gear_1976 , ((::) (mph_1999 , ([]))))))) in
         let (rob_1955:MyOp.t) =
             i_2075_step self.i_2075 (tstep'_1960 , inp_1949 , outp_1954) in
         self.m_2030 <- x_2032 ;
         (let (brake_1951:MyOp.t) = Array.get inp_1949  1 in
          let (road_load_2000:MyOp.t) =
              MyOp.translate (MyOp.scale (MyOp.sqr mph_1999) 
                                         Common_myop.p_aerodynamic_drag) 
                             Common_myop.p_drag_friction in
          let (brake_1996:MyOp.t) = MyOp.(+) brake_1951  road_load_2000 in
          let (sgn_2001:MyOp.t) =
              if (>=) mph_1999  Autotransd.zero_val
              then MyOp.make 1.
              else MyOp.make (-1.) in
          let (signed_load_2002:MyOp.t) = MyOp.( * ) sgn_2001  brake_1996 in
          self.m_2028 <- signed_load_2002 ;
          self.m_2025 <- x_2019 ;
          (let (trans_rpm_2005:MyOp.t) =
               MyOp.scale x_2032  Common_myop.p_final_drive_ratio in
           self.m_2023 <- trans_rpm_2005 ;
           self.m_2021 <- rpm_1966 ;
           (let (dn_th_1973:MyOp.t) =
                Common_myop.lookup_interpdn (throttle_1959 , gear_1976) in
            let (up_th_1975:MyOp.t) =
                Common_myop.lookup_interpup (throttle_1959 , gear_1976) in
            (begin match self.s_2010 with
                   | At_bench_SteadyState_858 ->
                       (if self.r_2011 then ()) ;
                       (begin match (((>) mph_1999  up_th_1975) ,
                                     ((<) mph_1999  dn_th_1973)) with
                              | (_ , true) ->
                                  self.t0_1977 <- x_2019 ;
                                  self.r_2011 <- true ;
                                  self.s_2010 <- At_bench_DownShifting_859
                              | (true , _) ->
                                  self.t0_1978 <- x_2019 ;
                                  self.r_2011 <- true ;
                                  self.s_2010 <- At_bench_UpShifting_860
                              | _ -> self.r_2011 <- false  end)
                   | At_bench_DownShifting_859 ->
                       (if self.r_2011 then ()) ;
                       (begin match (((>) x_2019 
                                          (MyOp.translate self.t0_1977 
                                                          Common_myop.twait))
                                     , ((>) mph_1999  dn_th_1973)) with
                              | (_ , true) ->
                                  self.r_2011 <- true ;
                                  self.s_2010 <- At_bench_SteadyState_858
                              | (true , _) ->
                                  shiftp_2013 := true ;
                                  shiftv_2012 := Common_myop.DOWN ;
                                  self.r_2011 <- true ;
                                  self.s_2010 <- At_bench_SteadyState_858
                              | _ -> self.r_2011 <- false  end)
                   | At_bench_UpShifting_860 ->
                       (if self.r_2011 then ()) ;
                       (begin match (((>) x_2019 
                                          (MyOp.translate self.t0_1978 
                                                          Common_myop.twait))
                                     , ((<) mph_1999  up_th_1975)) with
                              | (_ , true) ->
                                  self.r_2011 <- true ;
                                  self.s_2010 <- At_bench_SteadyState_858
                              | (true , _) ->
                                  shiftp_2013 := true ;
                                  shiftv_2012 := Common_myop.UP ;
                                  self.r_2011 <- true ;
                                  self.s_2010 <- At_bench_SteadyState_858
                              | _ -> self.r_2011 <- false  end)
                    end) ;
            (begin match self.s_2008 with
                   | At_bench_First_854 ->
                       (if self.r_2009 then ()) ;
                       (begin match (!shiftv_2012 , !shiftp_2013) with
                              | (Common_myop.UP , true) ->
                                  self.nx_2020 <- Autotransd.gear2 ;
                                  self.r_2009 <- true ;
                                  self.s_2008 <- At_bench_Second_855
                              | _ -> self.r_2009 <- false  end)
                   | At_bench_Second_855 ->
                       (if self.r_2009 then ()) ;
                       (begin match (!shiftv_2012 , !shiftp_2013) with
                              | (Common_myop.DOWN , true) ->
                                  self.nx_2020 <- Autotransd.gear1 ;
                                  self.r_2009 <- true ;
                                  self.s_2008 <- At_bench_First_854
                              | (Common_myop.UP , true) ->
                                  self.nx_2020 <- Autotransd.gear3 ;
                                  self.r_2009 <- true ;
                                  self.s_2008 <- At_bench_Third_856
                              | _ -> self.r_2009 <- false  end)
                   | At_bench_Third_856 ->
                       (if self.r_2009 then ()) ;
                       (begin match (!shiftv_2012 , !shiftp_2013) with
                              | (Common_myop.DOWN , true) ->
                                  self.nx_2020 <- Autotransd.gear2 ;
                                  self.r_2009 <- true ;
                                  self.s_2008 <- At_bench_Second_855
                              | (Common_myop.UP , true) ->
                                  self.nx_2020 <- Autotransd.gear4 ;
                                  self.r_2009 <- true ;
                                  self.s_2008 <- At_bench_Fourth_857
                              | _ -> self.r_2009 <- false  end)
                   | At_bench_Fourth_857 ->
                       (if self.r_2009 then ()) ;
                       (begin match (!shiftv_2012 , !shiftp_2013) with
                              | (Common_myop.DOWN , true) ->
                                  self.nx_2020 <- Autotransd.gear3 ;
                                  self.r_2009 <- true ;
                                  self.s_2008 <- At_bench_Third_856
                              | _ -> self.r_2009 <- false  end)
                    end) ;
            (let (x_2017:MyOp.t) = self.m_2016 in
             self.m_2018 <- x_2017 ;
             self.m_2016 <- MyOp.(+) x_2017  tstep'_1960 ;
             ((MyOp.get x_2017) , outp_1954 , rob_1955))))))))):float *
                                                                MyOp.t
                                                                Array.t *
                                                                MyOp.t) in
  Node { alloc = autotrans_at6c_alloc; reset = autotrans_at6c_reset ;
                                       step = autotrans_at6c_step }
