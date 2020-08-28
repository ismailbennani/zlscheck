(* The Zélus compiler, version 2.1
  (jeudi 27 août 2020, 15:59:00 (UTC+0200)) *)
open Ztypes
type state__9636 =
At_bench_UpShifting_882
| At_bench_DownShifting_881 | At_bench_SteadyState_880 
type state__9635 =
At_bench_Fourth_879
| At_bench_Third_878 | At_bench_Second_877 | At_bench_First_876 
type state__9634 =
At_bench_UpShifting_800
| At_bench_DownShifting_799 | At_bench_SteadyState_798 
type state__9633 =
At_bench_Fourth_797
| At_bench_Third_796 | At_bench_Second_795 | At_bench_First_794 
type state__9632 =
At_bench_UpShifting_718
| At_bench_DownShifting_717 | At_bench_SteadyState_716 
type state__9631 =
At_bench_Fourth_715
| At_bench_Third_714 | At_bench_Second_713 | At_bench_First_712 
type state__9630 =
At_bench_UpShifting_644
| At_bench_DownShifting_643 | At_bench_SteadyState_642 
type state__9629 =
At_bench_Fourth_641
| At_bench_Third_640 | At_bench_Second_639 | At_bench_First_638 
type state__9628 =
At_bench_UpShifting_571
| At_bench_DownShifting_570 | At_bench_SteadyState_569 
type state__9627 =
At_bench_Fourth_568
| At_bench_Third_567 | At_bench_Second_566 | At_bench_First_565 
type state__9626 =
At_bench_UpShifting_498
| At_bench_DownShifting_497 | At_bench_SteadyState_496 
type state__9625 =
At_bench_Fourth_495
| At_bench_Third_494 | At_bench_Second_493 | At_bench_First_492 
type state__9624 =
At_bench_UpShifting_425
| At_bench_DownShifting_424 | At_bench_SteadyState_423 
type state__9623 =
At_bench_Fourth_422
| At_bench_Third_421 | At_bench_Second_420 | At_bench_First_419 
type state__9622 =
At_bench_UpShifting_352
| At_bench_DownShifting_351 | At_bench_SteadyState_350 
type state__9621 =
At_bench_Fourth_349
| At_bench_Third_348 | At_bench_Second_347 | At_bench_First_346 
type state__9620 =
At_bench_UpShifting_279
| At_bench_DownShifting_278 | At_bench_SteadyState_277 
type state__9619 =
At_bench_Fourth_276
| At_bench_Third_275 | At_bench_Second_274 | At_bench_First_273 
open MyOp
open Discrete_obs_fad
type ('a) _at1 =
  { mutable i_2285 : 'a }

let at1  = 
  let Cnode { alloc = i_2285_alloc; copy = i_2285_copy ;
                                    step = i_2285_step ; reset = i_2285_reset } = 
  Discrete_obs_fad.always_timed 20.  in
  let at1_alloc _ =
    ();{ i_2285 = i_2285_alloc () (* discrete *)  } in
  let at1_copy source dest =
    i_2285_copy source.i_2285 dest.i_2285 (* discrete *) in
  let at1_reset self  =
    (i_2285_reset self.i_2285 :unit) in 
  let at1_step self ((tstep_1271:MyOp.t) , (outp_1270:(MyOp.t)Array.t)) =
    ((let (speed_1272:MyOp.t) = Array.get outp_1270  2 in
      i_2285_step self.i_2285
        (tstep_1271 , (Discrete_obs_fad.q_lt (speed_1272 , (MyOp.make 120.))))):
    MyOp.t) in
  Cnode { alloc = at1_alloc; copy = at1_copy ;
                             reset = at1_reset ; step = at1_step }
type ('a) _at2 =
  { mutable i_2286 : 'a }

let at2  = 
  let Cnode { alloc = i_2286_alloc; copy = i_2286_copy ;
                                    step = i_2286_step ; reset = i_2286_reset } = 
  Discrete_obs_fad.always_timed 10.  in
  let at2_alloc _ =
    ();{ i_2286 = i_2286_alloc () (* discrete *)  } in
  let at2_copy source dest =
    i_2286_copy source.i_2286 dest.i_2286 (* discrete *) in
  let at2_reset self  =
    (i_2286_reset self.i_2286 :unit) in 
  let at2_step self ((tstep_1274:MyOp.t) , (outp_1273:(MyOp.t)Array.t)) =
    ((let (rpm_1275:MyOp.t) = Array.get outp_1273  0 in
      i_2286_step self.i_2286
        (tstep_1274 , (Discrete_obs_fad.q_lt (rpm_1275 , (MyOp.make 4750.))))):
    MyOp.t) in
  Cnode { alloc = at2_alloc; copy = at2_copy ;
                             reset = at2_reset ; step = at2_step }
type ('e , 'd , 'c , 'b , 'a) _at5 =
  { mutable i_2289 : 'e ;
    mutable i_2288 : 'd ;
    mutable i_2287 : 'c ; mutable i_1284 : 'b ; mutable m_1282 : 'a }

let at5 (geari_1276:float) = 
  let Cnode { alloc = i_2289_alloc; copy = i_2289_copy ;
                                    step = i_2289_step ; reset = i_2289_reset } = Discrete_obs_fad.q_up 
   in 
  let Cnode { alloc = i_2288_alloc; copy = i_2288_copy ;
                                    step = i_2288_step ; reset = i_2288_reset } = 
  Discrete_obs_fad.always_timed 30.  in 
  let Cnode { alloc = i_2287_alloc; copy = i_2287_copy ;
                                    step = i_2287_step ; reset = i_2287_reset } = 
  Discrete_obs_fad.alwaysBfromA_timed 2.5  in
  let at5_alloc _ =
    ();
    { i_1284 = (false:bool) ; m_1282 = (create ():MyOp.t);
      i_2289 = i_2289_alloc () (* discrete *)  ;
      i_2288 = i_2288_alloc () (* discrete *)  ;
      i_2287 = i_2287_alloc () (* discrete *)  } in
  let at5_copy source dest =
    dest.i_1284 <- source.i_1284 ; dest.m_1282 <- source.m_1282;
    i_2289_copy source.i_2289 dest.i_2289 (* discrete *) ;
    i_2288_copy source.i_2288 dest.i_2288 (* discrete *) ;
    i_2287_copy source.i_2287 dest.i_2287 (* discrete *) in
  let at5_reset self  =
    ((self.i_1284 <- true ;
      i_2289_reset self.i_2289  ;
      i_2288_reset self.i_2288  ; i_2287_reset self.i_2287 ):unit) in 
  let at5_step self ((tstep_1278:MyOp.t) , (outp_1277:(MyOp.t)Array.t)) =
    (((if self.i_1284 then self.m_1282 <- Discrete_obs_fad.q_true) ;
      self.i_1284 <- false ;
      (let (x_1283:MyOp.t) = self.m_1282 in
       self.m_1282 <- Discrete_obs_fad.q_false ;
       (let (gear_1279:MyOp.t) = Array.get outp_1277  1 in
        let (switch_1281:MyOp.t) =
            Discrete_obs_fad.q_and ((Discrete_obs_fad.q_not x_1283) ,
                                    (i_2289_step self.i_2289
                                       (Discrete_obs_fad.q_eqi (gear_1279 ,
                                                                (MyOp.make 
                                                                   geari_1276))))) in
        i_2288_step self.i_2288
          (tstep_1278 ,
           (i_2287_step self.i_2287
              (tstep_1278 ,
               switch_1281 ,
               (Discrete_obs_fad.q_eqi (gear_1279 , (MyOp.make geari_1276))))))))):
    MyOp.t) in
  Cnode { alloc = at5_alloc; copy = at5_copy ;
                             reset = at5_reset ; step = at5_step }
type ('a) _at51 =
  { mutable i_2290 : 'a }

let at51  = 
  let Cnode { alloc = i_2290_alloc; copy = i_2290_copy ;
                                    step = i_2290_step ; reset = i_2290_reset } = 
  at5 1.  in
  let at51_alloc _ =
    ();{ i_2290 = i_2290_alloc () (* discrete *)  } in
  let at51_copy source dest =
    i_2290_copy source.i_2290 dest.i_2290 (* discrete *) in
  let at51_reset self  =
    (i_2290_reset self.i_2290 :unit) in 
  let at51_step self ((tstep_1286:MyOp.t) , (outp_1285:(MyOp.t)Array.t)) =
    (i_2290_step self.i_2290 (tstep_1286 , outp_1285):MyOp.t) in
  Cnode { alloc = at51_alloc; copy = at51_copy ;
                              reset = at51_reset ; step = at51_step }
type ('a) _at52 =
  { mutable i_2291 : 'a }

let at52  = 
  let Cnode { alloc = i_2291_alloc; copy = i_2291_copy ;
                                    step = i_2291_step ; reset = i_2291_reset } = 
  at5 2.  in
  let at52_alloc _ =
    ();{ i_2291 = i_2291_alloc () (* discrete *)  } in
  let at52_copy source dest =
    i_2291_copy source.i_2291 dest.i_2291 (* discrete *) in
  let at52_reset self  =
    (i_2291_reset self.i_2291 :unit) in 
  let at52_step self ((tstep_1288:MyOp.t) , (outp_1287:(MyOp.t)Array.t)) =
    (i_2291_step self.i_2291 (tstep_1288 , outp_1287):MyOp.t) in
  Cnode { alloc = at52_alloc; copy = at52_copy ;
                              reset = at52_reset ; step = at52_step }
type ('a) _at53 =
  { mutable i_2292 : 'a }

let at53  = 
  let Cnode { alloc = i_2292_alloc; copy = i_2292_copy ;
                                    step = i_2292_step ; reset = i_2292_reset } = 
  at5 3.  in
  let at53_alloc _ =
    ();{ i_2292 = i_2292_alloc () (* discrete *)  } in
  let at53_copy source dest =
    i_2292_copy source.i_2292 dest.i_2292 (* discrete *) in
  let at53_reset self  =
    (i_2292_reset self.i_2292 :unit) in 
  let at53_step self ((tstep_1290:MyOp.t) , (outp_1289:(MyOp.t)Array.t)) =
    (i_2292_step self.i_2292 (tstep_1290 , outp_1289):MyOp.t) in
  Cnode { alloc = at53_alloc; copy = at53_copy ;
                              reset = at53_reset ; step = at53_step }
type ('a) _at54 =
  { mutable i_2293 : 'a }

let at54  = 
  let Cnode { alloc = i_2293_alloc; copy = i_2293_copy ;
                                    step = i_2293_step ; reset = i_2293_reset } = 
  at5 4.  in
  let at54_alloc _ =
    ();{ i_2293 = i_2293_alloc () (* discrete *)  } in
  let at54_copy source dest =
    i_2293_copy source.i_2293 dest.i_2293 (* discrete *) in
  let at54_reset self  =
    (i_2293_reset self.i_2293 :unit) in 
  let at54_step self ((tstep_1292:MyOp.t) , (outp_1291:(MyOp.t)Array.t)) =
    (i_2293_step self.i_2293 (tstep_1292 , outp_1291):MyOp.t) in
  Cnode { alloc = at54_alloc; copy = at54_copy ;
                              reset = at54_reset ; step = at54_step }
type ('b , 'a) _at6 =
  { mutable i_2295 : 'b ; mutable i_2294 : 'a }

let at6 (tstep_1296:MyOp.t)  ((t_1295:float) , (s_1294:float)) = 
  let Cnode { alloc = i_2295_alloc; copy = i_2295_copy ;
                                    step = i_2295_step ; reset = i_2295_reset } = 
  Discrete_obs_fad.always_timed t_1295  in 
  let Cnode { alloc = i_2294_alloc; copy = i_2294_copy ;
                                    step = i_2294_step ; reset = i_2294_reset } = 
  Discrete_obs_fad.once_timed 30.  in
  let at6_alloc _ =
    ();
    { i_2295 = i_2295_alloc () (* discrete *)  ;
      i_2294 = i_2294_alloc () (* discrete *)  } in
  let at6_copy source dest =
    i_2295_copy source.i_2295 dest.i_2295 (* discrete *) ;
    i_2294_copy source.i_2294 dest.i_2294 (* discrete *) in
  let at6_reset self  =
    ((i_2295_reset self.i_2295  ; i_2294_reset self.i_2294 ):unit) in 
  let at6_step self (outp_1293:(MyOp.t)Array.t) =
    ((let (rpm_1297:MyOp.t) = Array.get outp_1293  0 in
      let (speed_1298:MyOp.t) = Array.get outp_1293  2 in
      let (rpm_max_1299:MyOp.t) = MyOp.make 3000. in
      let (speed_max_1300:MyOp.t) = MyOp.make s_1294 in
      Discrete_obs_fad.q_or ((i_2294_step self.i_2294
                                (tstep_1296 ,
                                 (Discrete_obs_fad.q_gt (rpm_1297 ,
                                                         rpm_max_1299)))) ,
                             (i_2295_step self.i_2295
                                (tstep_1296 ,
                                 (Discrete_obs_fad.q_lt (speed_1298 ,
                                                         speed_max_1300)))))):
    MyOp.t) in
  Cnode { alloc = at6_alloc; copy = at6_copy ;
                             reset = at6_reset ; step = at6_step }
type ('e , 'd , 'c , 'b , 'a) _at6a =
  { mutable i_2297 : 'e ;
    mutable i_2296 : 'd ;
    mutable i_1314 : 'c ; mutable m_1311 : 'b ; mutable m_1309 : 'a }

let at6a  = 
  let Cnode { alloc = i_2297_alloc; copy = i_2297_copy ;
                                    step = i_2297_step ; reset = i_2297_reset } = 
  Discrete_obs_fad.always_timed 4.  in 
  let Cnode { alloc = i_2296_alloc; copy = i_2296_copy ;
                                    step = i_2296_step ; reset = i_2296_reset } = 
  Discrete_obs_fad.once_timed 30.  in
  let at6a_alloc _ =
    ();
    { i_1314 = (false:bool) ;
      m_1311 = (create ():MyOp.t) ; m_1309 = (create ():MyOp.t);
      i_2297 = i_2297_alloc () (* discrete *)  ;
      i_2296 = i_2296_alloc () (* discrete *)  } in
  let at6a_copy source dest =
    dest.i_1314 <- source.i_1314 ;
    dest.m_1311 <- source.m_1311 ; dest.m_1309 <- source.m_1309;
    i_2297_copy source.i_2297 dest.i_2297 (* discrete *) ;
    i_2296_copy source.i_2296 dest.i_2296 (* discrete *) in
  let at6a_reset self  =
    ((self.i_1314 <- true ;
      i_2297_reset self.i_2297  ; i_2296_reset self.i_2296 ):unit) in 
  let at6a_step self ((tstep_1302:MyOp.t) , (outp_1301:(MyOp.t)Array.t)) =
    (((if self.i_1314 then self.m_1309 <- MyOp.make 0.) ;
      (let (x_1310:MyOp.t) = self.m_1309 in
       let (x_1313:bool) =
           if self.i_1314
           then false
           else
             (&&) ((>=) x_1310  (MyOp.make 4.)) 
                  ((<) self.m_1311  (MyOp.make 4.)) in
       self.i_1314 <- false ;
       (let (rpm_1303:MyOp.t) =
            MyOp.(/) (Array.get outp_1301  0)  (MyOp.make 1000.) in
        let (speed_1304:MyOp.t) =
            MyOp.(/) (Array.get outp_1301  2)  (MyOp.make 100.) in
        let (rpm_max_1305:MyOp.t) = MyOp.make ((/.) 3000.  1000.) in
        let (speed_max_1306:MyOp.t) = MyOp.make ((/.) 35.  100.) in
        self.m_1309 <- MyOp.(+) x_1310  tstep_1302 ;
        self.m_1311 <- x_1310 ;
        ((Discrete_obs_fad.q_or ((i_2296_step self.i_2296
                                    (tstep_1302 ,
                                     (Discrete_obs_fad.q_gt (rpm_1303 ,
                                                             rpm_max_1305))))
                                 ,
                                 (i_2297_step self.i_2297
                                    (tstep_1302 ,
                                     (Discrete_obs_fad.q_lt (speed_1304 ,
                                                             speed_max_1306))))))
         , x_1313)))):MyOp.t * bool) in
  Cnode { alloc = at6a_alloc; copy = at6a_copy ;
                              reset = at6a_reset ; step = at6a_step }
type ('e , 'd , 'c , 'b , 'a) _at6b =
  { mutable i_2299 : 'e ;
    mutable i_2298 : 'd ;
    mutable i_1328 : 'c ; mutable m_1325 : 'b ; mutable m_1323 : 'a }

let at6b  = 
  let Cnode { alloc = i_2299_alloc; copy = i_2299_copy ;
                                    step = i_2299_step ; reset = i_2299_reset } = 
  Discrete_obs_fad.always_timed 8.  in 
  let Cnode { alloc = i_2298_alloc; copy = i_2298_copy ;
                                    step = i_2298_step ; reset = i_2298_reset } = 
  Discrete_obs_fad.once_timed 30.  in
  let at6b_alloc _ =
    ();
    { i_1328 = (false:bool) ;
      m_1325 = (create ():MyOp.t) ; m_1323 = (create ():MyOp.t);
      i_2299 = i_2299_alloc () (* discrete *)  ;
      i_2298 = i_2298_alloc () (* discrete *)  } in
  let at6b_copy source dest =
    dest.i_1328 <- source.i_1328 ;
    dest.m_1325 <- source.m_1325 ; dest.m_1323 <- source.m_1323;
    i_2299_copy source.i_2299 dest.i_2299 (* discrete *) ;
    i_2298_copy source.i_2298 dest.i_2298 (* discrete *) in
  let at6b_reset self  =
    ((self.i_1328 <- true ;
      i_2299_reset self.i_2299  ; i_2298_reset self.i_2298 ):unit) in 
  let at6b_step self ((tstep_1316:MyOp.t) , (outp_1315:(MyOp.t)Array.t)) =
    (((if self.i_1328 then self.m_1323 <- MyOp.make 0.) ;
      (let (x_1324:MyOp.t) = self.m_1323 in
       let (x_1327:bool) =
           if self.i_1328
           then false
           else
             (&&) ((>=) x_1324  (MyOp.make 8.)) 
                  ((<) self.m_1325  (MyOp.make 8.)) in
       self.i_1328 <- false ;
       (let (rpm_1317:MyOp.t) =
            MyOp.(/) (Array.get outp_1315  0)  (MyOp.make 1000.) in
        let (speed_1318:MyOp.t) =
            MyOp.(/) (Array.get outp_1315  2)  (MyOp.make 100.) in
        let (rpm_max_1319:MyOp.t) = MyOp.make ((/.) 3000.  1000.) in
        let (speed_max_1320:MyOp.t) = MyOp.make ((/.) 50.  100.) in
        self.m_1323 <- MyOp.(+) x_1324  tstep_1316 ;
        self.m_1325 <- x_1324 ;
        ((Discrete_obs_fad.q_or ((i_2298_step self.i_2298
                                    (tstep_1316 ,
                                     (Discrete_obs_fad.q_gt (rpm_1317 ,
                                                             rpm_max_1319))))
                                 ,
                                 (i_2299_step self.i_2299
                                    (tstep_1316 ,
                                     (Discrete_obs_fad.q_lt (speed_1318 ,
                                                             speed_max_1320))))))
         , x_1327)))):MyOp.t * bool) in
  Cnode { alloc = at6b_alloc; copy = at6b_copy ;
                              reset = at6b_reset ; step = at6b_step }
type ('e , 'd , 'c , 'b , 'a) _at6c =
  { mutable i_2301 : 'e ;
    mutable i_2300 : 'd ;
    mutable i_1342 : 'c ; mutable m_1339 : 'b ; mutable m_1337 : 'a }

let at6c  = 
  let Cnode { alloc = i_2301_alloc; copy = i_2301_copy ;
                                    step = i_2301_step ; reset = i_2301_reset } = 
  Discrete_obs_fad.always_timed 20.  in 
  let Cnode { alloc = i_2300_alloc; copy = i_2300_copy ;
                                    step = i_2300_step ; reset = i_2300_reset } = 
  Discrete_obs_fad.once_timed 30.  in
  let at6c_alloc _ =
    ();
    { i_1342 = (false:bool) ;
      m_1339 = (create ():MyOp.t) ; m_1337 = (create ():MyOp.t);
      i_2301 = i_2301_alloc () (* discrete *)  ;
      i_2300 = i_2300_alloc () (* discrete *)  } in
  let at6c_copy source dest =
    dest.i_1342 <- source.i_1342 ;
    dest.m_1339 <- source.m_1339 ; dest.m_1337 <- source.m_1337;
    i_2301_copy source.i_2301 dest.i_2301 (* discrete *) ;
    i_2300_copy source.i_2300 dest.i_2300 (* discrete *) in
  let at6c_reset self  =
    ((self.i_1342 <- true ;
      i_2301_reset self.i_2301  ; i_2300_reset self.i_2300 ):unit) in 
  let at6c_step self ((tstep_1330:MyOp.t) , (outp_1329:(MyOp.t)Array.t)) =
    (((if self.i_1342 then self.m_1337 <- MyOp.make 0.) ;
      (let (x_1338:MyOp.t) = self.m_1337 in
       let (x_1341:bool) =
           if self.i_1342
           then false
           else
             (&&) ((>=) x_1338  (MyOp.make 20.)) 
                  ((<) self.m_1339  (MyOp.make 20.)) in
       self.i_1342 <- false ;
       (let (rpm_1331:MyOp.t) =
            MyOp.(/) (Array.get outp_1329  0)  (MyOp.make 5000.) in
        let (speed_1332:MyOp.t) =
            MyOp.(/) (Array.get outp_1329  2)  (MyOp.make 120.) in
        let (rpm_max_1333:MyOp.t) = MyOp.make ((/.) 3000.  5000.) in
        let (speed_max_1334:MyOp.t) = MyOp.make ((/.) 65.  120.) in
        self.m_1337 <- MyOp.(+) x_1338  tstep_1330 ;
        self.m_1339 <- x_1338 ;
        ((Discrete_obs_fad.q_or ((i_2300_step self.i_2300
                                    (tstep_1330 ,
                                     (Discrete_obs_fad.q_gt (rpm_1331 ,
                                                             rpm_max_1333))))
                                 ,
                                 (i_2301_step self.i_2301
                                    (tstep_1330 ,
                                     (Discrete_obs_fad.q_lt (speed_1332 ,
                                                             speed_max_1334))))))
         , x_1341)))):MyOp.t * bool) in
  Cnode { alloc = at6c_alloc; copy = at6c_copy ;
                              reset = at6c_reset ; step = at6c_step }
type ('t ,
      's ,
      'r ,
      'q ,
      'p ,
      'o ,
      'n , 'm , 'l , 'k , 'j , 'i , 'h , 'g , 'f , 'e , 'd , 'c , 'b , 'a) _autotrans_at1 =
  { mutable i_2302 : 't ;
    mutable i_1440 : 's ;
    mutable m_1437 : 'r ;
    mutable m_1434 : 'q ;
    mutable m_1432 : 'p ;
    mutable m_1429 : 'o ;
    mutable m_1427 : 'n ;
    mutable nx_1426 : 'm ;
    mutable m_1424 : 'l ;
    mutable m_1421 : 'k ;
    mutable m_1416 : 'j ;
    mutable m_1414 : 'i ;
    mutable r_1409 : 'h ;
    mutable s_1408 : 'g ;
    mutable r_1407 : 'f ;
    mutable s_1406 : 'e ;
    mutable t0_1389 : 'd ;
    mutable t0_1388 : 'c ; mutable i_1442 : 'b ; mutable go_up_1441 : 'a }

let autotrans_at1 (tstep_1344:float) = 
  let Cnode { alloc = i_2302_alloc; copy = i_2302_copy ;
                                    step = i_2302_step ; reset = i_2302_reset } = at1 
   in
  let autotrans_at1_alloc _ =
    ();
    { i_1440 = (false:bool) ;
      m_1437 = (create ():MyOp.t) ;
      m_1434 = (create ():MyOp.t) ;
      m_1432 = (create ():MyOp.t) ;
      m_1429 = (create ():MyOp.t) ;
      m_1427 = (create ():MyOp.t) ;
      nx_1426 = (create ():MyOp.t) ;
      m_1424 = (create ():MyOp.t) ;
      m_1421 = (create ():MyOp.t) ;
      m_1416 = (create ():MyOp.t) ;
      m_1414 = (create ():MyOp.t) ;
      r_1409 = (false:bool) ;
      s_1408 = (At_bench_UpShifting_279:state__9620) ;
      r_1407 = (false:bool) ;
      s_1406 = (At_bench_Fourth_276:state__9619) ;
      t0_1389 = (create ():MyOp.t) ;
      t0_1388 = (create ():MyOp.t) ;
      i_1442 = (false:bool) ; go_up_1441 = (false:bool);
      i_2302 = i_2302_alloc () (* discrete *)  } in
  let autotrans_at1_copy source dest =
    dest.i_1440 <- source.i_1440 ;
    dest.m_1437 <- source.m_1437 ;
    dest.m_1434 <- source.m_1434 ;
    dest.m_1432 <- source.m_1432 ;
    dest.m_1429 <- source.m_1429 ;
    dest.m_1427 <- source.m_1427 ;
    dest.nx_1426 <- source.nx_1426 ;
    dest.m_1424 <- source.m_1424 ;
    dest.m_1421 <- source.m_1421 ;
    dest.m_1416 <- source.m_1416 ;
    dest.m_1414 <- source.m_1414 ;
    dest.r_1409 <- source.r_1409 ;
    dest.s_1408 <- source.s_1408 ;
    dest.r_1407 <- source.r_1407 ;
    dest.s_1406 <- source.s_1406 ;
    dest.t0_1389 <- source.t0_1389 ;
    dest.t0_1388 <- source.t0_1388 ;
    dest.i_1442 <- source.i_1442 ; dest.go_up_1441 <- source.go_up_1441;
    i_2302_copy source.i_2302 dest.i_2302 (* discrete *) in
  let autotrans_at1_reset self  =
    ((self.i_1440 <- true ;
      i_2302_reset self.i_2302  ;
      self.r_1409 <- false ;
      self.s_1408 <- At_bench_SteadyState_277 ;
      self.i_1442 <- true ;
      self.r_1407 <- false ; self.s_1406 <- At_bench_First_273):unit) in 
  let autotrans_at1_step self (inp_1343:(MyOp.t)Array.t) =
    ((let shiftp_1411 = ref (false:bool) in
      let shiftv_1410 = ref (At_common.DOWN:At_common.shift) in
      (if self.i_1440 then self.nx_1426 <- Autotransd.gear1) ;
      (let (gear_1387:MyOp.t) = self.nx_1426 in
       let (x_1439:bool) =
           if self.i_1440 then false else (<>) gear_1387  self.m_1437 in
       let (final_drive_ratio_1395:MyOp.t) =
           MyOp.scale self.m_1427  At_common.p_final_drive_ratio in
       let (aux1_1393:MyOp.t) = MyOp.(-) final_drive_ratio_1395  self.m_1432 in
       let (vehicle_inertia_1404:MyOp.t) =
           MyOp.scale aux1_1393  At_common.iv_inv in
       (if self.i_1440 then self.m_1416 <- MyOp.make 0.) ;
       (let (x_1417:MyOp.t) = self.m_1416 in
        let (x_1431:MyOp.t) =
            if self.i_1440 then x_1417 else MyOp.(-) x_1417  self.m_1429 in
        let (x_1436:MyOp.t) =
            if self.i_1440
            then MyOp.make At_common.p_initial_wheel_speed
            else
              MyOp.(+) self.m_1434  (MyOp.( * ) vehicle_inertia_1404  x_1431) in
        let (x0_1375:MyOp.t) = MyOp.make 1000. in
        (if self.i_1440 then self.m_1424 <- x0_1375) ;
        (let (x_1423:MyOp.t) =
             if self.i_1440 then x_1417 else MyOp.(-) x_1417  self.m_1421 in
         let (tstep'_1355:MyOp.t) = MyOp.make tstep_1344 in
         (if self.i_1440 then self.m_1414 <- tstep'_1355) ;
         self.i_1440 <- false ;
         (let (xmin_1377:MyOp.t) = MyOp.make 600. in
          let (xmax_1376:MyOp.t) = MyOp.make 6000. in
          let (x_1425:MyOp.t) = self.m_1424 in
          let (x_1380:MyOp.t) =
              MyOp.max xmin_1377  (MyOp.min xmax_1376  x_1425) in
          let (linear_speed_1396:MyOp.t) =
              MyOp.scale x_1436  At_common.l_speed_coef in
          let (mph_1397:MyOp.t) =
              MyOp.scale linear_speed_1396  At_common.p_mph in
          let (outp_1348:(MyOp.t)Array.t) =
              Array.of_list ((::) (x_1380 ,
                                   ((::) (gear_1387 ,
                                          ((::) (mph_1397 , ([]))))))) in
          let (rob_1349:MyOp.t) =
              i_2302_step self.i_2302 (tstep'_1355 , outp_1348) in
          self.m_1437 <- gear_1387 ;
          (let (trans_rpm_1403:MyOp.t) =
               MyOp.scale x_1436  At_common.p_final_drive_ratio in
           let ((ti_1363:MyOp.t) , (out_torque_1360:MyOp.t)) =
               At_common.transmission (x_1380 , gear_1387 , trans_rpm_1403) in
           self.m_1427 <- out_torque_1360 ;
           self.m_1434 <- x_1436 ;
           (let (brake_1345:MyOp.t) = Array.get inp_1343  1 in
            let (road_load_1398:MyOp.t) =
                MyOp.translate (MyOp.scale (MyOp.sqr mph_1397) 
                                           At_common.p_aerodynamic_drag) 
                               At_common.p_drag_friction in
            let (brake_1394:MyOp.t) = MyOp.(+) brake_1345  road_load_1398 in
            let (sgn_1399:MyOp.t) =
                if (>=) mph_1397  (MyOp.make 0.)
                then MyOp.make 1.
                else MyOp.make (-1.) in
            let (signed_load_1400:MyOp.t) = MyOp.( * ) sgn_1399  brake_1394 in
            self.m_1432 <- signed_load_1400 ;
            self.m_1429 <- x_1417 ;
            (let (throttle_1353:MyOp.t) = Array.get inp_1343  0 in
             let (dn_th_1384:MyOp.t) =
                 At_common.lookup_interpdn (throttle_1353 , gear_1387) in
             let (up_th_1386:MyOp.t) =
                 At_common.lookup_interpup (throttle_1353 , gear_1387) in
             (begin match self.s_1408 with
                    | At_bench_SteadyState_277 ->
                        (if self.r_1409 then self.i_1442 <- true) ;
                        (if self.i_1442 then
                         self.go_up_1441 <- (>) (MyOp.make (Random.float 1.))
                                                 (MyOp.make 0.5)) ;
                        self.i_1442 <- false ;
                        (begin match (((>) mph_1397  up_th_1386) ,
                                      ((<) mph_1397  dn_th_1384)) with
                               | (_ , true) ->
                                   self.t0_1388 <- x_1417 ;
                                   self.r_1409 <- true ;
                                   self.s_1408 <- At_bench_DownShifting_278
                               | (true , _) ->
                                   self.t0_1389 <- x_1417 ;
                                   self.r_1409 <- true ;
                                   self.s_1408 <- At_bench_UpShifting_279
                               | _ -> self.r_1409 <- false  end)
                    | At_bench_DownShifting_278 ->
                        (if self.r_1409 then ()) ;
                        (begin match (((>) x_1417 
                                           (MyOp.translate self.t0_1388 
                                                           At_common.twait))
                                      , ((>) mph_1397  dn_th_1384)) with
                               | (_ , true) ->
                                   self.r_1409 <- true ;
                                   self.s_1408 <- At_bench_SteadyState_277
                               | (true , _) ->
                                   shiftp_1411 := true ;
                                   shiftv_1410 := At_common.DOWN ;
                                   self.r_1409 <- true ;
                                   self.s_1408 <- At_bench_SteadyState_277
                               | _ -> self.r_1409 <- false  end)
                    | At_bench_UpShifting_279 ->
                        (if self.r_1409 then ()) ;
                        (begin match (((>) x_1417 
                                           (MyOp.translate self.t0_1389 
                                                           At_common.twait))
                                      , ((<) mph_1397  up_th_1386)) with
                               | (_ , true) ->
                                   self.r_1409 <- true ;
                                   self.s_1408 <- At_bench_SteadyState_277
                               | (true , _) ->
                                   shiftp_1411 := true ;
                                   shiftv_1410 := At_common.UP ;
                                   self.r_1409 <- true ;
                                   self.s_1408 <- At_bench_SteadyState_277
                               | _ -> self.r_1409 <- false  end)
                     end) ;
             (begin match self.s_1406 with
                    | At_bench_First_273 ->
                        (if self.r_1407 then ()) ;
                        (begin match (!shiftv_1410 , !shiftp_1411) with
                               | (At_common.UP , true) ->
                                   self.nx_1426 <- Autotransd.gear2 ;
                                   self.r_1407 <- true ;
                                   self.s_1406 <- At_bench_Second_274
                               | _ -> self.r_1407 <- false  end)
                    | At_bench_Second_274 ->
                        (if self.r_1407 then ()) ;
                        (begin match (!shiftv_1410 , !shiftp_1411) with
                               | (At_common.DOWN , true) ->
                                   self.nx_1426 <- Autotransd.gear1 ;
                                   self.r_1407 <- true ;
                                   self.s_1406 <- At_bench_First_273
                               | (At_common.UP , true) ->
                                   self.nx_1426 <- Autotransd.gear3 ;
                                   self.r_1407 <- true ;
                                   self.s_1406 <- At_bench_Third_275
                               | _ -> self.r_1407 <- false  end)
                    | At_bench_Third_275 ->
                        (if self.r_1407 then ()) ;
                        (begin match (!shiftv_1410 , !shiftp_1411) with
                               | (At_common.DOWN , true) ->
                                   self.nx_1426 <- Autotransd.gear2 ;
                                   self.r_1407 <- true ;
                                   self.s_1406 <- At_bench_Second_274
                               | (At_common.UP , true) ->
                                   self.nx_1426 <- Autotransd.gear4 ;
                                   self.r_1407 <- true ;
                                   self.s_1406 <- At_bench_Fourth_276
                               | _ -> self.r_1407 <- false  end)
                    | At_bench_Fourth_276 ->
                        (if self.r_1407 then ()) ;
                        (begin match (!shiftv_1410 , !shiftp_1411) with
                               | (At_common.DOWN , true) ->
                                   self.nx_1426 <- Autotransd.gear3 ;
                                   self.r_1407 <- true ;
                                   self.s_1406 <- At_bench_Third_275
                               | _ -> self.r_1407 <- false  end)
                     end) ;
             (let (te_1371:MyOp.t) =
                  At_common.lookup_engine (throttle_1353 , x_1380) in
              let (drpm_1369:MyOp.t) = MyOp.(-) te_1371  ti_1363 in
              let (dx_1373:MyOp.t) =
                  MyOp.scale drpm_1369  At_common.engine_feedback_gain in
              self.m_1424 <- MyOp.(+) x_1380  (MyOp.( * ) dx_1373  x_1423) ;
              self.m_1421 <- x_1417 ;
              (let (x_1415:MyOp.t) = self.m_1414 in
               self.m_1416 <- x_1415 ;
               self.m_1414 <- MyOp.(+) x_1415  tstep'_1355 ;
               (rob_1349 , x_1439))))))))))):MyOp.t * bool) in
  Cnode { alloc = autotrans_at1_alloc; copy = autotrans_at1_copy ;
                                       reset = autotrans_at1_reset ;
                                       step = autotrans_at1_step }
type ('t ,
      's ,
      'r ,
      'q ,
      'p ,
      'o ,
      'n , 'm , 'l , 'k , 'j , 'i , 'h , 'g , 'f , 'e , 'd , 'c , 'b , 'a) _autotrans_at2 =
  { mutable i_2303 : 't ;
    mutable i_1540 : 's ;
    mutable m_1537 : 'r ;
    mutable m_1534 : 'q ;
    mutable m_1532 : 'p ;
    mutable m_1529 : 'o ;
    mutable m_1527 : 'n ;
    mutable nx_1526 : 'm ;
    mutable m_1524 : 'l ;
    mutable m_1521 : 'k ;
    mutable m_1516 : 'j ;
    mutable m_1514 : 'i ;
    mutable r_1509 : 'h ;
    mutable s_1508 : 'g ;
    mutable r_1507 : 'f ;
    mutable s_1506 : 'e ;
    mutable t0_1489 : 'd ;
    mutable t0_1488 : 'c ; mutable i_1542 : 'b ; mutable go_up_1541 : 'a }

let autotrans_at2 (tstep_1444:float) = 
  let Cnode { alloc = i_2303_alloc; copy = i_2303_copy ;
                                    step = i_2303_step ; reset = i_2303_reset } = at2 
   in
  let autotrans_at2_alloc _ =
    ();
    { i_1540 = (false:bool) ;
      m_1537 = (create ():MyOp.t) ;
      m_1534 = (create ():MyOp.t) ;
      m_1532 = (create ():MyOp.t) ;
      m_1529 = (create ():MyOp.t) ;
      m_1527 = (create ():MyOp.t) ;
      nx_1526 = (create ():MyOp.t) ;
      m_1524 = (create ():MyOp.t) ;
      m_1521 = (create ():MyOp.t) ;
      m_1516 = (create ():MyOp.t) ;
      m_1514 = (create ():MyOp.t) ;
      r_1509 = (false:bool) ;
      s_1508 = (At_bench_UpShifting_352:state__9622) ;
      r_1507 = (false:bool) ;
      s_1506 = (At_bench_Fourth_349:state__9621) ;
      t0_1489 = (create ():MyOp.t) ;
      t0_1488 = (create ():MyOp.t) ;
      i_1542 = (false:bool) ; go_up_1541 = (false:bool);
      i_2303 = i_2303_alloc () (* discrete *)  } in
  let autotrans_at2_copy source dest =
    dest.i_1540 <- source.i_1540 ;
    dest.m_1537 <- source.m_1537 ;
    dest.m_1534 <- source.m_1534 ;
    dest.m_1532 <- source.m_1532 ;
    dest.m_1529 <- source.m_1529 ;
    dest.m_1527 <- source.m_1527 ;
    dest.nx_1526 <- source.nx_1526 ;
    dest.m_1524 <- source.m_1524 ;
    dest.m_1521 <- source.m_1521 ;
    dest.m_1516 <- source.m_1516 ;
    dest.m_1514 <- source.m_1514 ;
    dest.r_1509 <- source.r_1509 ;
    dest.s_1508 <- source.s_1508 ;
    dest.r_1507 <- source.r_1507 ;
    dest.s_1506 <- source.s_1506 ;
    dest.t0_1489 <- source.t0_1489 ;
    dest.t0_1488 <- source.t0_1488 ;
    dest.i_1542 <- source.i_1542 ; dest.go_up_1541 <- source.go_up_1541;
    i_2303_copy source.i_2303 dest.i_2303 (* discrete *) in
  let autotrans_at2_reset self  =
    ((self.i_1540 <- true ;
      i_2303_reset self.i_2303  ;
      self.r_1509 <- false ;
      self.s_1508 <- At_bench_SteadyState_350 ;
      self.i_1542 <- true ;
      self.r_1507 <- false ; self.s_1506 <- At_bench_First_346):unit) in 
  let autotrans_at2_step self (inp_1443:(MyOp.t)Array.t) =
    ((let shiftp_1511 = ref (false:bool) in
      let shiftv_1510 = ref (At_common.DOWN:At_common.shift) in
      (if self.i_1540 then self.nx_1526 <- Autotransd.gear1) ;
      (let (gear_1487:MyOp.t) = self.nx_1526 in
       let (x_1539:bool) =
           if self.i_1540 then false else (<>) gear_1487  self.m_1537 in
       let (final_drive_ratio_1495:MyOp.t) =
           MyOp.scale self.m_1527  At_common.p_final_drive_ratio in
       let (aux1_1493:MyOp.t) = MyOp.(-) final_drive_ratio_1495  self.m_1532 in
       let (vehicle_inertia_1504:MyOp.t) =
           MyOp.scale aux1_1493  At_common.iv_inv in
       (if self.i_1540 then self.m_1516 <- MyOp.make 0.) ;
       (let (x_1517:MyOp.t) = self.m_1516 in
        let (x_1531:MyOp.t) =
            if self.i_1540 then x_1517 else MyOp.(-) x_1517  self.m_1529 in
        let (x_1536:MyOp.t) =
            if self.i_1540
            then MyOp.make At_common.p_initial_wheel_speed
            else
              MyOp.(+) self.m_1534  (MyOp.( * ) vehicle_inertia_1504  x_1531) in
        let (x0_1475:MyOp.t) = MyOp.make 1000. in
        (if self.i_1540 then self.m_1524 <- x0_1475) ;
        (let (x_1523:MyOp.t) =
             if self.i_1540 then x_1517 else MyOp.(-) x_1517  self.m_1521 in
         let (tstep'_1455:MyOp.t) = MyOp.make tstep_1444 in
         (if self.i_1540 then self.m_1514 <- tstep'_1455) ;
         self.i_1540 <- false ;
         (let (xmin_1477:MyOp.t) = MyOp.make 600. in
          let (xmax_1476:MyOp.t) = MyOp.make 6000. in
          let (x_1525:MyOp.t) = self.m_1524 in
          let (x_1480:MyOp.t) =
              MyOp.max xmin_1477  (MyOp.min xmax_1476  x_1525) in
          let (linear_speed_1496:MyOp.t) =
              MyOp.scale x_1536  At_common.l_speed_coef in
          let (mph_1497:MyOp.t) =
              MyOp.scale linear_speed_1496  At_common.p_mph in
          let (outp_1448:(MyOp.t)Array.t) =
              Array.of_list ((::) (x_1480 ,
                                   ((::) (gear_1487 ,
                                          ((::) (mph_1497 , ([]))))))) in
          let (rob_1449:MyOp.t) =
              i_2303_step self.i_2303 (tstep'_1455 , outp_1448) in
          self.m_1537 <- gear_1487 ;
          (let (trans_rpm_1503:MyOp.t) =
               MyOp.scale x_1536  At_common.p_final_drive_ratio in
           let ((ti_1463:MyOp.t) , (out_torque_1460:MyOp.t)) =
               At_common.transmission (x_1480 , gear_1487 , trans_rpm_1503) in
           self.m_1527 <- out_torque_1460 ;
           self.m_1534 <- x_1536 ;
           (let (brake_1445:MyOp.t) = Array.get inp_1443  1 in
            let (road_load_1498:MyOp.t) =
                MyOp.translate (MyOp.scale (MyOp.sqr mph_1497) 
                                           At_common.p_aerodynamic_drag) 
                               At_common.p_drag_friction in
            let (brake_1494:MyOp.t) = MyOp.(+) brake_1445  road_load_1498 in
            let (sgn_1499:MyOp.t) =
                if (>=) mph_1497  (MyOp.make 0.)
                then MyOp.make 1.
                else MyOp.make (-1.) in
            let (signed_load_1500:MyOp.t) = MyOp.( * ) sgn_1499  brake_1494 in
            self.m_1532 <- signed_load_1500 ;
            self.m_1529 <- x_1517 ;
            (let (throttle_1453:MyOp.t) = Array.get inp_1443  0 in
             let (dn_th_1484:MyOp.t) =
                 At_common.lookup_interpdn (throttle_1453 , gear_1487) in
             let (up_th_1486:MyOp.t) =
                 At_common.lookup_interpup (throttle_1453 , gear_1487) in
             (begin match self.s_1508 with
                    | At_bench_SteadyState_350 ->
                        (if self.r_1509 then self.i_1542 <- true) ;
                        (if self.i_1542 then
                         self.go_up_1541 <- (>) (MyOp.make (Random.float 1.))
                                                 (MyOp.make 0.5)) ;
                        self.i_1542 <- false ;
                        (begin match (((>) mph_1497  up_th_1486) ,
                                      ((<) mph_1497  dn_th_1484)) with
                               | (_ , true) ->
                                   self.t0_1488 <- x_1517 ;
                                   self.r_1509 <- true ;
                                   self.s_1508 <- At_bench_DownShifting_351
                               | (true , _) ->
                                   self.t0_1489 <- x_1517 ;
                                   self.r_1509 <- true ;
                                   self.s_1508 <- At_bench_UpShifting_352
                               | _ -> self.r_1509 <- false  end)
                    | At_bench_DownShifting_351 ->
                        (if self.r_1509 then ()) ;
                        (begin match (((>) x_1517 
                                           (MyOp.translate self.t0_1488 
                                                           At_common.twait))
                                      , ((>) mph_1497  dn_th_1484)) with
                               | (_ , true) ->
                                   self.r_1509 <- true ;
                                   self.s_1508 <- At_bench_SteadyState_350
                               | (true , _) ->
                                   shiftp_1511 := true ;
                                   shiftv_1510 := At_common.DOWN ;
                                   self.r_1509 <- true ;
                                   self.s_1508 <- At_bench_SteadyState_350
                               | _ -> self.r_1509 <- false  end)
                    | At_bench_UpShifting_352 ->
                        (if self.r_1509 then ()) ;
                        (begin match (((>) x_1517 
                                           (MyOp.translate self.t0_1489 
                                                           At_common.twait))
                                      , ((<) mph_1497  up_th_1486)) with
                               | (_ , true) ->
                                   self.r_1509 <- true ;
                                   self.s_1508 <- At_bench_SteadyState_350
                               | (true , _) ->
                                   shiftp_1511 := true ;
                                   shiftv_1510 := At_common.UP ;
                                   self.r_1509 <- true ;
                                   self.s_1508 <- At_bench_SteadyState_350
                               | _ -> self.r_1509 <- false  end)
                     end) ;
             (begin match self.s_1506 with
                    | At_bench_First_346 ->
                        (if self.r_1507 then ()) ;
                        (begin match (!shiftv_1510 , !shiftp_1511) with
                               | (At_common.UP , true) ->
                                   self.nx_1526 <- Autotransd.gear2 ;
                                   self.r_1507 <- true ;
                                   self.s_1506 <- At_bench_Second_347
                               | _ -> self.r_1507 <- false  end)
                    | At_bench_Second_347 ->
                        (if self.r_1507 then ()) ;
                        (begin match (!shiftv_1510 , !shiftp_1511) with
                               | (At_common.DOWN , true) ->
                                   self.nx_1526 <- Autotransd.gear1 ;
                                   self.r_1507 <- true ;
                                   self.s_1506 <- At_bench_First_346
                               | (At_common.UP , true) ->
                                   self.nx_1526 <- Autotransd.gear3 ;
                                   self.r_1507 <- true ;
                                   self.s_1506 <- At_bench_Third_348
                               | _ -> self.r_1507 <- false  end)
                    | At_bench_Third_348 ->
                        (if self.r_1507 then ()) ;
                        (begin match (!shiftv_1510 , !shiftp_1511) with
                               | (At_common.DOWN , true) ->
                                   self.nx_1526 <- Autotransd.gear2 ;
                                   self.r_1507 <- true ;
                                   self.s_1506 <- At_bench_Second_347
                               | (At_common.UP , true) ->
                                   self.nx_1526 <- Autotransd.gear4 ;
                                   self.r_1507 <- true ;
                                   self.s_1506 <- At_bench_Fourth_349
                               | _ -> self.r_1507 <- false  end)
                    | At_bench_Fourth_349 ->
                        (if self.r_1507 then ()) ;
                        (begin match (!shiftv_1510 , !shiftp_1511) with
                               | (At_common.DOWN , true) ->
                                   self.nx_1526 <- Autotransd.gear3 ;
                                   self.r_1507 <- true ;
                                   self.s_1506 <- At_bench_Third_348
                               | _ -> self.r_1507 <- false  end)
                     end) ;
             (let (te_1471:MyOp.t) =
                  At_common.lookup_engine (throttle_1453 , x_1480) in
              let (drpm_1469:MyOp.t) = MyOp.(-) te_1471  ti_1463 in
              let (dx_1473:MyOp.t) =
                  MyOp.scale drpm_1469  At_common.engine_feedback_gain in
              self.m_1524 <- MyOp.(+) x_1480  (MyOp.( * ) dx_1473  x_1523) ;
              self.m_1521 <- x_1517 ;
              (let (x_1515:MyOp.t) = self.m_1514 in
               self.m_1516 <- x_1515 ;
               self.m_1514 <- MyOp.(+) x_1515  tstep'_1455 ;
               (rob_1449 , x_1539))))))))))):MyOp.t * bool) in
  Cnode { alloc = autotrans_at2_alloc; copy = autotrans_at2_copy ;
                                       reset = autotrans_at2_reset ;
                                       step = autotrans_at2_step }
type ('t ,
      's ,
      'r ,
      'q ,
      'p ,
      'o ,
      'n , 'm , 'l , 'k , 'j , 'i , 'h , 'g , 'f , 'e , 'd , 'c , 'b , 'a) _autotrans_at51 =
  { mutable i_2304 : 't ;
    mutable i_1640 : 's ;
    mutable m_1637 : 'r ;
    mutable m_1634 : 'q ;
    mutable m_1632 : 'p ;
    mutable m_1629 : 'o ;
    mutable m_1627 : 'n ;
    mutable nx_1626 : 'm ;
    mutable m_1624 : 'l ;
    mutable m_1621 : 'k ;
    mutable m_1616 : 'j ;
    mutable m_1614 : 'i ;
    mutable r_1609 : 'h ;
    mutable s_1608 : 'g ;
    mutable r_1607 : 'f ;
    mutable s_1606 : 'e ;
    mutable t0_1589 : 'd ;
    mutable t0_1588 : 'c ; mutable i_1642 : 'b ; mutable go_up_1641 : 'a }

let autotrans_at51 (tstep_1544:float) = 
  let Cnode { alloc = i_2304_alloc; copy = i_2304_copy ;
                                    step = i_2304_step ; reset = i_2304_reset } = at51 
   in
  let autotrans_at51_alloc _ =
    ();
    { i_1640 = (false:bool) ;
      m_1637 = (create ():MyOp.t) ;
      m_1634 = (create ():MyOp.t) ;
      m_1632 = (create ():MyOp.t) ;
      m_1629 = (create ():MyOp.t) ;
      m_1627 = (create ():MyOp.t) ;
      nx_1626 = (create ():MyOp.t) ;
      m_1624 = (create ():MyOp.t) ;
      m_1621 = (create ():MyOp.t) ;
      m_1616 = (create ():MyOp.t) ;
      m_1614 = (create ():MyOp.t) ;
      r_1609 = (false:bool) ;
      s_1608 = (At_bench_UpShifting_425:state__9624) ;
      r_1607 = (false:bool) ;
      s_1606 = (At_bench_Fourth_422:state__9623) ;
      t0_1589 = (create ():MyOp.t) ;
      t0_1588 = (create ():MyOp.t) ;
      i_1642 = (false:bool) ; go_up_1641 = (false:bool);
      i_2304 = i_2304_alloc () (* discrete *)  } in
  let autotrans_at51_copy source dest =
    dest.i_1640 <- source.i_1640 ;
    dest.m_1637 <- source.m_1637 ;
    dest.m_1634 <- source.m_1634 ;
    dest.m_1632 <- source.m_1632 ;
    dest.m_1629 <- source.m_1629 ;
    dest.m_1627 <- source.m_1627 ;
    dest.nx_1626 <- source.nx_1626 ;
    dest.m_1624 <- source.m_1624 ;
    dest.m_1621 <- source.m_1621 ;
    dest.m_1616 <- source.m_1616 ;
    dest.m_1614 <- source.m_1614 ;
    dest.r_1609 <- source.r_1609 ;
    dest.s_1608 <- source.s_1608 ;
    dest.r_1607 <- source.r_1607 ;
    dest.s_1606 <- source.s_1606 ;
    dest.t0_1589 <- source.t0_1589 ;
    dest.t0_1588 <- source.t0_1588 ;
    dest.i_1642 <- source.i_1642 ; dest.go_up_1641 <- source.go_up_1641;
    i_2304_copy source.i_2304 dest.i_2304 (* discrete *) in
  let autotrans_at51_reset self  =
    ((self.i_1640 <- true ;
      i_2304_reset self.i_2304  ;
      self.r_1609 <- false ;
      self.s_1608 <- At_bench_SteadyState_423 ;
      self.i_1642 <- true ;
      self.r_1607 <- false ; self.s_1606 <- At_bench_First_419):unit) in 
  let autotrans_at51_step self (inp_1543:(MyOp.t)Array.t) =
    ((let shiftp_1611 = ref (false:bool) in
      let shiftv_1610 = ref (At_common.DOWN:At_common.shift) in
      (if self.i_1640 then self.nx_1626 <- Autotransd.gear1) ;
      (let (gear_1587:MyOp.t) = self.nx_1626 in
       let (x_1639:bool) =
           if self.i_1640 then false else (<>) gear_1587  self.m_1637 in
       let (final_drive_ratio_1595:MyOp.t) =
           MyOp.scale self.m_1627  At_common.p_final_drive_ratio in
       let (aux1_1593:MyOp.t) = MyOp.(-) final_drive_ratio_1595  self.m_1632 in
       let (vehicle_inertia_1604:MyOp.t) =
           MyOp.scale aux1_1593  At_common.iv_inv in
       (if self.i_1640 then self.m_1616 <- MyOp.make 0.) ;
       (let (x_1617:MyOp.t) = self.m_1616 in
        let (x_1631:MyOp.t) =
            if self.i_1640 then x_1617 else MyOp.(-) x_1617  self.m_1629 in
        let (x_1636:MyOp.t) =
            if self.i_1640
            then MyOp.make At_common.p_initial_wheel_speed
            else
              MyOp.(+) self.m_1634  (MyOp.( * ) vehicle_inertia_1604  x_1631) in
        let (x0_1575:MyOp.t) = MyOp.make 1000. in
        (if self.i_1640 then self.m_1624 <- x0_1575) ;
        (let (x_1623:MyOp.t) =
             if self.i_1640 then x_1617 else MyOp.(-) x_1617  self.m_1621 in
         let (tstep'_1555:MyOp.t) = MyOp.make tstep_1544 in
         (if self.i_1640 then self.m_1614 <- tstep'_1555) ;
         self.i_1640 <- false ;
         (let (xmin_1577:MyOp.t) = MyOp.make 600. in
          let (xmax_1576:MyOp.t) = MyOp.make 6000. in
          let (x_1625:MyOp.t) = self.m_1624 in
          let (x_1580:MyOp.t) =
              MyOp.max xmin_1577  (MyOp.min xmax_1576  x_1625) in
          let (linear_speed_1596:MyOp.t) =
              MyOp.scale x_1636  At_common.l_speed_coef in
          let (mph_1597:MyOp.t) =
              MyOp.scale linear_speed_1596  At_common.p_mph in
          let (outp_1548:(MyOp.t)Array.t) =
              Array.of_list ((::) (x_1580 ,
                                   ((::) (gear_1587 ,
                                          ((::) (mph_1597 , ([]))))))) in
          let (rob_1549:MyOp.t) =
              i_2304_step self.i_2304 (tstep'_1555 , outp_1548) in
          self.m_1637 <- gear_1587 ;
          (let (trans_rpm_1603:MyOp.t) =
               MyOp.scale x_1636  At_common.p_final_drive_ratio in
           let ((ti_1563:MyOp.t) , (out_torque_1560:MyOp.t)) =
               At_common.transmission (x_1580 , gear_1587 , trans_rpm_1603) in
           self.m_1627 <- out_torque_1560 ;
           self.m_1634 <- x_1636 ;
           (let (brake_1545:MyOp.t) = Array.get inp_1543  1 in
            let (road_load_1598:MyOp.t) =
                MyOp.translate (MyOp.scale (MyOp.sqr mph_1597) 
                                           At_common.p_aerodynamic_drag) 
                               At_common.p_drag_friction in
            let (brake_1594:MyOp.t) = MyOp.(+) brake_1545  road_load_1598 in
            let (sgn_1599:MyOp.t) =
                if (>=) mph_1597  (MyOp.make 0.)
                then MyOp.make 1.
                else MyOp.make (-1.) in
            let (signed_load_1600:MyOp.t) = MyOp.( * ) sgn_1599  brake_1594 in
            self.m_1632 <- signed_load_1600 ;
            self.m_1629 <- x_1617 ;
            (let (throttle_1553:MyOp.t) = Array.get inp_1543  0 in
             let (dn_th_1584:MyOp.t) =
                 At_common.lookup_interpdn (throttle_1553 , gear_1587) in
             let (up_th_1586:MyOp.t) =
                 At_common.lookup_interpup (throttle_1553 , gear_1587) in
             (begin match self.s_1608 with
                    | At_bench_SteadyState_423 ->
                        (if self.r_1609 then self.i_1642 <- true) ;
                        (if self.i_1642 then
                         self.go_up_1641 <- (>) (MyOp.make (Random.float 1.))
                                                 (MyOp.make 0.5)) ;
                        self.i_1642 <- false ;
                        (begin match (((>) mph_1597  up_th_1586) ,
                                      ((<) mph_1597  dn_th_1584)) with
                               | (_ , true) ->
                                   self.t0_1588 <- x_1617 ;
                                   self.r_1609 <- true ;
                                   self.s_1608 <- At_bench_DownShifting_424
                               | (true , _) ->
                                   self.t0_1589 <- x_1617 ;
                                   self.r_1609 <- true ;
                                   self.s_1608 <- At_bench_UpShifting_425
                               | _ -> self.r_1609 <- false  end)
                    | At_bench_DownShifting_424 ->
                        (if self.r_1609 then ()) ;
                        (begin match (((>) x_1617 
                                           (MyOp.translate self.t0_1588 
                                                           At_common.twait))
                                      , ((>) mph_1597  dn_th_1584)) with
                               | (_ , true) ->
                                   self.r_1609 <- true ;
                                   self.s_1608 <- At_bench_SteadyState_423
                               | (true , _) ->
                                   shiftp_1611 := true ;
                                   shiftv_1610 := At_common.DOWN ;
                                   self.r_1609 <- true ;
                                   self.s_1608 <- At_bench_SteadyState_423
                               | _ -> self.r_1609 <- false  end)
                    | At_bench_UpShifting_425 ->
                        (if self.r_1609 then ()) ;
                        (begin match (((>) x_1617 
                                           (MyOp.translate self.t0_1589 
                                                           At_common.twait))
                                      , ((<) mph_1597  up_th_1586)) with
                               | (_ , true) ->
                                   self.r_1609 <- true ;
                                   self.s_1608 <- At_bench_SteadyState_423
                               | (true , _) ->
                                   shiftp_1611 := true ;
                                   shiftv_1610 := At_common.UP ;
                                   self.r_1609 <- true ;
                                   self.s_1608 <- At_bench_SteadyState_423
                               | _ -> self.r_1609 <- false  end)
                     end) ;
             (begin match self.s_1606 with
                    | At_bench_First_419 ->
                        (if self.r_1607 then ()) ;
                        (begin match (!shiftv_1610 , !shiftp_1611) with
                               | (At_common.UP , true) ->
                                   self.nx_1626 <- Autotransd.gear2 ;
                                   self.r_1607 <- true ;
                                   self.s_1606 <- At_bench_Second_420
                               | _ -> self.r_1607 <- false  end)
                    | At_bench_Second_420 ->
                        (if self.r_1607 then ()) ;
                        (begin match (!shiftv_1610 , !shiftp_1611) with
                               | (At_common.DOWN , true) ->
                                   self.nx_1626 <- Autotransd.gear1 ;
                                   self.r_1607 <- true ;
                                   self.s_1606 <- At_bench_First_419
                               | (At_common.UP , true) ->
                                   self.nx_1626 <- Autotransd.gear3 ;
                                   self.r_1607 <- true ;
                                   self.s_1606 <- At_bench_Third_421
                               | _ -> self.r_1607 <- false  end)
                    | At_bench_Third_421 ->
                        (if self.r_1607 then ()) ;
                        (begin match (!shiftv_1610 , !shiftp_1611) with
                               | (At_common.DOWN , true) ->
                                   self.nx_1626 <- Autotransd.gear2 ;
                                   self.r_1607 <- true ;
                                   self.s_1606 <- At_bench_Second_420
                               | (At_common.UP , true) ->
                                   self.nx_1626 <- Autotransd.gear4 ;
                                   self.r_1607 <- true ;
                                   self.s_1606 <- At_bench_Fourth_422
                               | _ -> self.r_1607 <- false  end)
                    | At_bench_Fourth_422 ->
                        (if self.r_1607 then ()) ;
                        (begin match (!shiftv_1610 , !shiftp_1611) with
                               | (At_common.DOWN , true) ->
                                   self.nx_1626 <- Autotransd.gear3 ;
                                   self.r_1607 <- true ;
                                   self.s_1606 <- At_bench_Third_421
                               | _ -> self.r_1607 <- false  end)
                     end) ;
             (let (te_1571:MyOp.t) =
                  At_common.lookup_engine (throttle_1553 , x_1580) in
              let (drpm_1569:MyOp.t) = MyOp.(-) te_1571  ti_1563 in
              let (dx_1573:MyOp.t) =
                  MyOp.scale drpm_1569  At_common.engine_feedback_gain in
              self.m_1624 <- MyOp.(+) x_1580  (MyOp.( * ) dx_1573  x_1623) ;
              self.m_1621 <- x_1617 ;
              (let (x_1615:MyOp.t) = self.m_1614 in
               self.m_1616 <- x_1615 ;
               self.m_1614 <- MyOp.(+) x_1615  tstep'_1555 ;
               (rob_1549 , x_1639))))))))))):MyOp.t * bool) in
  Cnode { alloc = autotrans_at51_alloc; copy = autotrans_at51_copy ;
                                        reset = autotrans_at51_reset ;
                                        step = autotrans_at51_step }
type ('t ,
      's ,
      'r ,
      'q ,
      'p ,
      'o ,
      'n , 'm , 'l , 'k , 'j , 'i , 'h , 'g , 'f , 'e , 'd , 'c , 'b , 'a) _autotrans_at52 =
  { mutable i_2305 : 't ;
    mutable i_1740 : 's ;
    mutable m_1737 : 'r ;
    mutable m_1734 : 'q ;
    mutable m_1732 : 'p ;
    mutable m_1729 : 'o ;
    mutable m_1727 : 'n ;
    mutable nx_1726 : 'm ;
    mutable m_1724 : 'l ;
    mutable m_1721 : 'k ;
    mutable m_1716 : 'j ;
    mutable m_1714 : 'i ;
    mutable r_1709 : 'h ;
    mutable s_1708 : 'g ;
    mutable r_1707 : 'f ;
    mutable s_1706 : 'e ;
    mutable t0_1689 : 'd ;
    mutable t0_1688 : 'c ; mutable i_1742 : 'b ; mutable go_up_1741 : 'a }

let autotrans_at52 (tstep_1644:float) = 
  let Cnode { alloc = i_2305_alloc; copy = i_2305_copy ;
                                    step = i_2305_step ; reset = i_2305_reset } = at52 
   in
  let autotrans_at52_alloc _ =
    ();
    { i_1740 = (false:bool) ;
      m_1737 = (create ():MyOp.t) ;
      m_1734 = (create ():MyOp.t) ;
      m_1732 = (create ():MyOp.t) ;
      m_1729 = (create ():MyOp.t) ;
      m_1727 = (create ():MyOp.t) ;
      nx_1726 = (create ():MyOp.t) ;
      m_1724 = (create ():MyOp.t) ;
      m_1721 = (create ():MyOp.t) ;
      m_1716 = (create ():MyOp.t) ;
      m_1714 = (create ():MyOp.t) ;
      r_1709 = (false:bool) ;
      s_1708 = (At_bench_UpShifting_498:state__9626) ;
      r_1707 = (false:bool) ;
      s_1706 = (At_bench_Fourth_495:state__9625) ;
      t0_1689 = (create ():MyOp.t) ;
      t0_1688 = (create ():MyOp.t) ;
      i_1742 = (false:bool) ; go_up_1741 = (false:bool);
      i_2305 = i_2305_alloc () (* discrete *)  } in
  let autotrans_at52_copy source dest =
    dest.i_1740 <- source.i_1740 ;
    dest.m_1737 <- source.m_1737 ;
    dest.m_1734 <- source.m_1734 ;
    dest.m_1732 <- source.m_1732 ;
    dest.m_1729 <- source.m_1729 ;
    dest.m_1727 <- source.m_1727 ;
    dest.nx_1726 <- source.nx_1726 ;
    dest.m_1724 <- source.m_1724 ;
    dest.m_1721 <- source.m_1721 ;
    dest.m_1716 <- source.m_1716 ;
    dest.m_1714 <- source.m_1714 ;
    dest.r_1709 <- source.r_1709 ;
    dest.s_1708 <- source.s_1708 ;
    dest.r_1707 <- source.r_1707 ;
    dest.s_1706 <- source.s_1706 ;
    dest.t0_1689 <- source.t0_1689 ;
    dest.t0_1688 <- source.t0_1688 ;
    dest.i_1742 <- source.i_1742 ; dest.go_up_1741 <- source.go_up_1741;
    i_2305_copy source.i_2305 dest.i_2305 (* discrete *) in
  let autotrans_at52_reset self  =
    ((self.i_1740 <- true ;
      i_2305_reset self.i_2305  ;
      self.r_1709 <- false ;
      self.s_1708 <- At_bench_SteadyState_496 ;
      self.i_1742 <- true ;
      self.r_1707 <- false ; self.s_1706 <- At_bench_First_492):unit) in 
  let autotrans_at52_step self (inp_1643:(MyOp.t)Array.t) =
    ((let shiftp_1711 = ref (false:bool) in
      let shiftv_1710 = ref (At_common.DOWN:At_common.shift) in
      (if self.i_1740 then self.nx_1726 <- Autotransd.gear1) ;
      (let (gear_1687:MyOp.t) = self.nx_1726 in
       let (x_1739:bool) =
           if self.i_1740 then false else (<>) gear_1687  self.m_1737 in
       let (final_drive_ratio_1695:MyOp.t) =
           MyOp.scale self.m_1727  At_common.p_final_drive_ratio in
       let (aux1_1693:MyOp.t) = MyOp.(-) final_drive_ratio_1695  self.m_1732 in
       let (vehicle_inertia_1704:MyOp.t) =
           MyOp.scale aux1_1693  At_common.iv_inv in
       (if self.i_1740 then self.m_1716 <- MyOp.make 0.) ;
       (let (x_1717:MyOp.t) = self.m_1716 in
        let (x_1731:MyOp.t) =
            if self.i_1740 then x_1717 else MyOp.(-) x_1717  self.m_1729 in
        let (x_1736:MyOp.t) =
            if self.i_1740
            then MyOp.make At_common.p_initial_wheel_speed
            else
              MyOp.(+) self.m_1734  (MyOp.( * ) vehicle_inertia_1704  x_1731) in
        let (x0_1675:MyOp.t) = MyOp.make 1000. in
        (if self.i_1740 then self.m_1724 <- x0_1675) ;
        (let (x_1723:MyOp.t) =
             if self.i_1740 then x_1717 else MyOp.(-) x_1717  self.m_1721 in
         let (tstep'_1655:MyOp.t) = MyOp.make tstep_1644 in
         (if self.i_1740 then self.m_1714 <- tstep'_1655) ;
         self.i_1740 <- false ;
         (let (xmin_1677:MyOp.t) = MyOp.make 600. in
          let (xmax_1676:MyOp.t) = MyOp.make 6000. in
          let (x_1725:MyOp.t) = self.m_1724 in
          let (x_1680:MyOp.t) =
              MyOp.max xmin_1677  (MyOp.min xmax_1676  x_1725) in
          let (linear_speed_1696:MyOp.t) =
              MyOp.scale x_1736  At_common.l_speed_coef in
          let (mph_1697:MyOp.t) =
              MyOp.scale linear_speed_1696  At_common.p_mph in
          let (outp_1648:(MyOp.t)Array.t) =
              Array.of_list ((::) (x_1680 ,
                                   ((::) (gear_1687 ,
                                          ((::) (mph_1697 , ([]))))))) in
          let (rob_1649:MyOp.t) =
              i_2305_step self.i_2305 (tstep'_1655 , outp_1648) in
          self.m_1737 <- gear_1687 ;
          (let (trans_rpm_1703:MyOp.t) =
               MyOp.scale x_1736  At_common.p_final_drive_ratio in
           let ((ti_1663:MyOp.t) , (out_torque_1660:MyOp.t)) =
               At_common.transmission (x_1680 , gear_1687 , trans_rpm_1703) in
           self.m_1727 <- out_torque_1660 ;
           self.m_1734 <- x_1736 ;
           (let (brake_1645:MyOp.t) = Array.get inp_1643  1 in
            let (road_load_1698:MyOp.t) =
                MyOp.translate (MyOp.scale (MyOp.sqr mph_1697) 
                                           At_common.p_aerodynamic_drag) 
                               At_common.p_drag_friction in
            let (brake_1694:MyOp.t) = MyOp.(+) brake_1645  road_load_1698 in
            let (sgn_1699:MyOp.t) =
                if (>=) mph_1697  (MyOp.make 0.)
                then MyOp.make 1.
                else MyOp.make (-1.) in
            let (signed_load_1700:MyOp.t) = MyOp.( * ) sgn_1699  brake_1694 in
            self.m_1732 <- signed_load_1700 ;
            self.m_1729 <- x_1717 ;
            (let (throttle_1653:MyOp.t) = Array.get inp_1643  0 in
             let (dn_th_1684:MyOp.t) =
                 At_common.lookup_interpdn (throttle_1653 , gear_1687) in
             let (up_th_1686:MyOp.t) =
                 At_common.lookup_interpup (throttle_1653 , gear_1687) in
             (begin match self.s_1708 with
                    | At_bench_SteadyState_496 ->
                        (if self.r_1709 then self.i_1742 <- true) ;
                        (if self.i_1742 then
                         self.go_up_1741 <- (>) (MyOp.make (Random.float 1.))
                                                 (MyOp.make 0.5)) ;
                        self.i_1742 <- false ;
                        (begin match (((>) mph_1697  up_th_1686) ,
                                      ((<) mph_1697  dn_th_1684)) with
                               | (_ , true) ->
                                   self.t0_1688 <- x_1717 ;
                                   self.r_1709 <- true ;
                                   self.s_1708 <- At_bench_DownShifting_497
                               | (true , _) ->
                                   self.t0_1689 <- x_1717 ;
                                   self.r_1709 <- true ;
                                   self.s_1708 <- At_bench_UpShifting_498
                               | _ -> self.r_1709 <- false  end)
                    | At_bench_DownShifting_497 ->
                        (if self.r_1709 then ()) ;
                        (begin match (((>) x_1717 
                                           (MyOp.translate self.t0_1688 
                                                           At_common.twait))
                                      , ((>) mph_1697  dn_th_1684)) with
                               | (_ , true) ->
                                   self.r_1709 <- true ;
                                   self.s_1708 <- At_bench_SteadyState_496
                               | (true , _) ->
                                   shiftp_1711 := true ;
                                   shiftv_1710 := At_common.DOWN ;
                                   self.r_1709 <- true ;
                                   self.s_1708 <- At_bench_SteadyState_496
                               | _ -> self.r_1709 <- false  end)
                    | At_bench_UpShifting_498 ->
                        (if self.r_1709 then ()) ;
                        (begin match (((>) x_1717 
                                           (MyOp.translate self.t0_1689 
                                                           At_common.twait))
                                      , ((<) mph_1697  up_th_1686)) with
                               | (_ , true) ->
                                   self.r_1709 <- true ;
                                   self.s_1708 <- At_bench_SteadyState_496
                               | (true , _) ->
                                   shiftp_1711 := true ;
                                   shiftv_1710 := At_common.UP ;
                                   self.r_1709 <- true ;
                                   self.s_1708 <- At_bench_SteadyState_496
                               | _ -> self.r_1709 <- false  end)
                     end) ;
             (begin match self.s_1706 with
                    | At_bench_First_492 ->
                        (if self.r_1707 then ()) ;
                        (begin match (!shiftv_1710 , !shiftp_1711) with
                               | (At_common.UP , true) ->
                                   self.nx_1726 <- Autotransd.gear2 ;
                                   self.r_1707 <- true ;
                                   self.s_1706 <- At_bench_Second_493
                               | _ -> self.r_1707 <- false  end)
                    | At_bench_Second_493 ->
                        (if self.r_1707 then ()) ;
                        (begin match (!shiftv_1710 , !shiftp_1711) with
                               | (At_common.DOWN , true) ->
                                   self.nx_1726 <- Autotransd.gear1 ;
                                   self.r_1707 <- true ;
                                   self.s_1706 <- At_bench_First_492
                               | (At_common.UP , true) ->
                                   self.nx_1726 <- Autotransd.gear3 ;
                                   self.r_1707 <- true ;
                                   self.s_1706 <- At_bench_Third_494
                               | _ -> self.r_1707 <- false  end)
                    | At_bench_Third_494 ->
                        (if self.r_1707 then ()) ;
                        (begin match (!shiftv_1710 , !shiftp_1711) with
                               | (At_common.DOWN , true) ->
                                   self.nx_1726 <- Autotransd.gear2 ;
                                   self.r_1707 <- true ;
                                   self.s_1706 <- At_bench_Second_493
                               | (At_common.UP , true) ->
                                   self.nx_1726 <- Autotransd.gear4 ;
                                   self.r_1707 <- true ;
                                   self.s_1706 <- At_bench_Fourth_495
                               | _ -> self.r_1707 <- false  end)
                    | At_bench_Fourth_495 ->
                        (if self.r_1707 then ()) ;
                        (begin match (!shiftv_1710 , !shiftp_1711) with
                               | (At_common.DOWN , true) ->
                                   self.nx_1726 <- Autotransd.gear3 ;
                                   self.r_1707 <- true ;
                                   self.s_1706 <- At_bench_Third_494
                               | _ -> self.r_1707 <- false  end)
                     end) ;
             (let (te_1671:MyOp.t) =
                  At_common.lookup_engine (throttle_1653 , x_1680) in
              let (drpm_1669:MyOp.t) = MyOp.(-) te_1671  ti_1663 in
              let (dx_1673:MyOp.t) =
                  MyOp.scale drpm_1669  At_common.engine_feedback_gain in
              self.m_1724 <- MyOp.(+) x_1680  (MyOp.( * ) dx_1673  x_1723) ;
              self.m_1721 <- x_1717 ;
              (let (x_1715:MyOp.t) = self.m_1714 in
               self.m_1716 <- x_1715 ;
               self.m_1714 <- MyOp.(+) x_1715  tstep'_1655 ;
               (rob_1649 , x_1739))))))))))):MyOp.t * bool) in
  Cnode { alloc = autotrans_at52_alloc; copy = autotrans_at52_copy ;
                                        reset = autotrans_at52_reset ;
                                        step = autotrans_at52_step }
type ('t ,
      's ,
      'r ,
      'q ,
      'p ,
      'o ,
      'n , 'm , 'l , 'k , 'j , 'i , 'h , 'g , 'f , 'e , 'd , 'c , 'b , 'a) _autotrans_at53 =
  { mutable i_2306 : 't ;
    mutable i_1840 : 's ;
    mutable m_1837 : 'r ;
    mutable m_1834 : 'q ;
    mutable m_1832 : 'p ;
    mutable m_1829 : 'o ;
    mutable m_1827 : 'n ;
    mutable nx_1826 : 'm ;
    mutable m_1824 : 'l ;
    mutable m_1821 : 'k ;
    mutable m_1816 : 'j ;
    mutable m_1814 : 'i ;
    mutable r_1809 : 'h ;
    mutable s_1808 : 'g ;
    mutable r_1807 : 'f ;
    mutable s_1806 : 'e ;
    mutable t0_1789 : 'd ;
    mutable t0_1788 : 'c ; mutable i_1842 : 'b ; mutable go_up_1841 : 'a }

let autotrans_at53 (tstep_1744:float) = 
  let Cnode { alloc = i_2306_alloc; copy = i_2306_copy ;
                                    step = i_2306_step ; reset = i_2306_reset } = at53 
   in
  let autotrans_at53_alloc _ =
    ();
    { i_1840 = (false:bool) ;
      m_1837 = (create ():MyOp.t) ;
      m_1834 = (create ():MyOp.t) ;
      m_1832 = (create ():MyOp.t) ;
      m_1829 = (create ():MyOp.t) ;
      m_1827 = (create ():MyOp.t) ;
      nx_1826 = (create ():MyOp.t) ;
      m_1824 = (create ():MyOp.t) ;
      m_1821 = (create ():MyOp.t) ;
      m_1816 = (create ():MyOp.t) ;
      m_1814 = (create ():MyOp.t) ;
      r_1809 = (false:bool) ;
      s_1808 = (At_bench_UpShifting_571:state__9628) ;
      r_1807 = (false:bool) ;
      s_1806 = (At_bench_Fourth_568:state__9627) ;
      t0_1789 = (create ():MyOp.t) ;
      t0_1788 = (create ():MyOp.t) ;
      i_1842 = (false:bool) ; go_up_1841 = (false:bool);
      i_2306 = i_2306_alloc () (* discrete *)  } in
  let autotrans_at53_copy source dest =
    dest.i_1840 <- source.i_1840 ;
    dest.m_1837 <- source.m_1837 ;
    dest.m_1834 <- source.m_1834 ;
    dest.m_1832 <- source.m_1832 ;
    dest.m_1829 <- source.m_1829 ;
    dest.m_1827 <- source.m_1827 ;
    dest.nx_1826 <- source.nx_1826 ;
    dest.m_1824 <- source.m_1824 ;
    dest.m_1821 <- source.m_1821 ;
    dest.m_1816 <- source.m_1816 ;
    dest.m_1814 <- source.m_1814 ;
    dest.r_1809 <- source.r_1809 ;
    dest.s_1808 <- source.s_1808 ;
    dest.r_1807 <- source.r_1807 ;
    dest.s_1806 <- source.s_1806 ;
    dest.t0_1789 <- source.t0_1789 ;
    dest.t0_1788 <- source.t0_1788 ;
    dest.i_1842 <- source.i_1842 ; dest.go_up_1841 <- source.go_up_1841;
    i_2306_copy source.i_2306 dest.i_2306 (* discrete *) in
  let autotrans_at53_reset self  =
    ((self.i_1840 <- true ;
      i_2306_reset self.i_2306  ;
      self.r_1809 <- false ;
      self.s_1808 <- At_bench_SteadyState_569 ;
      self.i_1842 <- true ;
      self.r_1807 <- false ; self.s_1806 <- At_bench_First_565):unit) in 
  let autotrans_at53_step self (inp_1743:(MyOp.t)Array.t) =
    ((let shiftp_1811 = ref (false:bool) in
      let shiftv_1810 = ref (At_common.DOWN:At_common.shift) in
      (if self.i_1840 then self.nx_1826 <- Autotransd.gear1) ;
      (let (gear_1787:MyOp.t) = self.nx_1826 in
       let (x_1839:bool) =
           if self.i_1840 then false else (<>) gear_1787  self.m_1837 in
       let (final_drive_ratio_1795:MyOp.t) =
           MyOp.scale self.m_1827  At_common.p_final_drive_ratio in
       let (aux1_1793:MyOp.t) = MyOp.(-) final_drive_ratio_1795  self.m_1832 in
       let (vehicle_inertia_1804:MyOp.t) =
           MyOp.scale aux1_1793  At_common.iv_inv in
       (if self.i_1840 then self.m_1816 <- MyOp.make 0.) ;
       (let (x_1817:MyOp.t) = self.m_1816 in
        let (x_1831:MyOp.t) =
            if self.i_1840 then x_1817 else MyOp.(-) x_1817  self.m_1829 in
        let (x_1836:MyOp.t) =
            if self.i_1840
            then MyOp.make At_common.p_initial_wheel_speed
            else
              MyOp.(+) self.m_1834  (MyOp.( * ) vehicle_inertia_1804  x_1831) in
        let (x0_1775:MyOp.t) = MyOp.make 1000. in
        (if self.i_1840 then self.m_1824 <- x0_1775) ;
        (let (x_1823:MyOp.t) =
             if self.i_1840 then x_1817 else MyOp.(-) x_1817  self.m_1821 in
         let (tstep'_1755:MyOp.t) = MyOp.make tstep_1744 in
         (if self.i_1840 then self.m_1814 <- tstep'_1755) ;
         self.i_1840 <- false ;
         (let (xmin_1777:MyOp.t) = MyOp.make 600. in
          let (xmax_1776:MyOp.t) = MyOp.make 6000. in
          let (x_1825:MyOp.t) = self.m_1824 in
          let (x_1780:MyOp.t) =
              MyOp.max xmin_1777  (MyOp.min xmax_1776  x_1825) in
          let (linear_speed_1796:MyOp.t) =
              MyOp.scale x_1836  At_common.l_speed_coef in
          let (mph_1797:MyOp.t) =
              MyOp.scale linear_speed_1796  At_common.p_mph in
          let (outp_1748:(MyOp.t)Array.t) =
              Array.of_list ((::) (x_1780 ,
                                   ((::) (gear_1787 ,
                                          ((::) (mph_1797 , ([]))))))) in
          let (rob_1749:MyOp.t) =
              i_2306_step self.i_2306 (tstep'_1755 , outp_1748) in
          self.m_1837 <- gear_1787 ;
          (let (trans_rpm_1803:MyOp.t) =
               MyOp.scale x_1836  At_common.p_final_drive_ratio in
           let ((ti_1763:MyOp.t) , (out_torque_1760:MyOp.t)) =
               At_common.transmission (x_1780 , gear_1787 , trans_rpm_1803) in
           self.m_1827 <- out_torque_1760 ;
           self.m_1834 <- x_1836 ;
           (let (brake_1745:MyOp.t) = Array.get inp_1743  1 in
            let (road_load_1798:MyOp.t) =
                MyOp.translate (MyOp.scale (MyOp.sqr mph_1797) 
                                           At_common.p_aerodynamic_drag) 
                               At_common.p_drag_friction in
            let (brake_1794:MyOp.t) = MyOp.(+) brake_1745  road_load_1798 in
            let (sgn_1799:MyOp.t) =
                if (>=) mph_1797  (MyOp.make 0.)
                then MyOp.make 1.
                else MyOp.make (-1.) in
            let (signed_load_1800:MyOp.t) = MyOp.( * ) sgn_1799  brake_1794 in
            self.m_1832 <- signed_load_1800 ;
            self.m_1829 <- x_1817 ;
            (let (throttle_1753:MyOp.t) = Array.get inp_1743  0 in
             let (dn_th_1784:MyOp.t) =
                 At_common.lookup_interpdn (throttle_1753 , gear_1787) in
             let (up_th_1786:MyOp.t) =
                 At_common.lookup_interpup (throttle_1753 , gear_1787) in
             (begin match self.s_1808 with
                    | At_bench_SteadyState_569 ->
                        (if self.r_1809 then self.i_1842 <- true) ;
                        (if self.i_1842 then
                         self.go_up_1841 <- (>) (MyOp.make (Random.float 1.))
                                                 (MyOp.make 0.5)) ;
                        self.i_1842 <- false ;
                        (begin match (((>) mph_1797  up_th_1786) ,
                                      ((<) mph_1797  dn_th_1784)) with
                               | (_ , true) ->
                                   self.t0_1788 <- x_1817 ;
                                   self.r_1809 <- true ;
                                   self.s_1808 <- At_bench_DownShifting_570
                               | (true , _) ->
                                   self.t0_1789 <- x_1817 ;
                                   self.r_1809 <- true ;
                                   self.s_1808 <- At_bench_UpShifting_571
                               | _ -> self.r_1809 <- false  end)
                    | At_bench_DownShifting_570 ->
                        (if self.r_1809 then ()) ;
                        (begin match (((>) x_1817 
                                           (MyOp.translate self.t0_1788 
                                                           At_common.twait))
                                      , ((>) mph_1797  dn_th_1784)) with
                               | (_ , true) ->
                                   self.r_1809 <- true ;
                                   self.s_1808 <- At_bench_SteadyState_569
                               | (true , _) ->
                                   shiftp_1811 := true ;
                                   shiftv_1810 := At_common.DOWN ;
                                   self.r_1809 <- true ;
                                   self.s_1808 <- At_bench_SteadyState_569
                               | _ -> self.r_1809 <- false  end)
                    | At_bench_UpShifting_571 ->
                        (if self.r_1809 then ()) ;
                        (begin match (((>) x_1817 
                                           (MyOp.translate self.t0_1789 
                                                           At_common.twait))
                                      , ((<) mph_1797  up_th_1786)) with
                               | (_ , true) ->
                                   self.r_1809 <- true ;
                                   self.s_1808 <- At_bench_SteadyState_569
                               | (true , _) ->
                                   shiftp_1811 := true ;
                                   shiftv_1810 := At_common.UP ;
                                   self.r_1809 <- true ;
                                   self.s_1808 <- At_bench_SteadyState_569
                               | _ -> self.r_1809 <- false  end)
                     end) ;
             (begin match self.s_1806 with
                    | At_bench_First_565 ->
                        (if self.r_1807 then ()) ;
                        (begin match (!shiftv_1810 , !shiftp_1811) with
                               | (At_common.UP , true) ->
                                   self.nx_1826 <- Autotransd.gear2 ;
                                   self.r_1807 <- true ;
                                   self.s_1806 <- At_bench_Second_566
                               | _ -> self.r_1807 <- false  end)
                    | At_bench_Second_566 ->
                        (if self.r_1807 then ()) ;
                        (begin match (!shiftv_1810 , !shiftp_1811) with
                               | (At_common.DOWN , true) ->
                                   self.nx_1826 <- Autotransd.gear1 ;
                                   self.r_1807 <- true ;
                                   self.s_1806 <- At_bench_First_565
                               | (At_common.UP , true) ->
                                   self.nx_1826 <- Autotransd.gear3 ;
                                   self.r_1807 <- true ;
                                   self.s_1806 <- At_bench_Third_567
                               | _ -> self.r_1807 <- false  end)
                    | At_bench_Third_567 ->
                        (if self.r_1807 then ()) ;
                        (begin match (!shiftv_1810 , !shiftp_1811) with
                               | (At_common.DOWN , true) ->
                                   self.nx_1826 <- Autotransd.gear2 ;
                                   self.r_1807 <- true ;
                                   self.s_1806 <- At_bench_Second_566
                               | (At_common.UP , true) ->
                                   self.nx_1826 <- Autotransd.gear4 ;
                                   self.r_1807 <- true ;
                                   self.s_1806 <- At_bench_Fourth_568
                               | _ -> self.r_1807 <- false  end)
                    | At_bench_Fourth_568 ->
                        (if self.r_1807 then ()) ;
                        (begin match (!shiftv_1810 , !shiftp_1811) with
                               | (At_common.DOWN , true) ->
                                   self.nx_1826 <- Autotransd.gear3 ;
                                   self.r_1807 <- true ;
                                   self.s_1806 <- At_bench_Third_567
                               | _ -> self.r_1807 <- false  end)
                     end) ;
             (let (te_1771:MyOp.t) =
                  At_common.lookup_engine (throttle_1753 , x_1780) in
              let (drpm_1769:MyOp.t) = MyOp.(-) te_1771  ti_1763 in
              let (dx_1773:MyOp.t) =
                  MyOp.scale drpm_1769  At_common.engine_feedback_gain in
              self.m_1824 <- MyOp.(+) x_1780  (MyOp.( * ) dx_1773  x_1823) ;
              self.m_1821 <- x_1817 ;
              (let (x_1815:MyOp.t) = self.m_1814 in
               self.m_1816 <- x_1815 ;
               self.m_1814 <- MyOp.(+) x_1815  tstep'_1755 ;
               (rob_1749 , x_1839))))))))))):MyOp.t * bool) in
  Cnode { alloc = autotrans_at53_alloc; copy = autotrans_at53_copy ;
                                        reset = autotrans_at53_reset ;
                                        step = autotrans_at53_step }
type ('t ,
      's ,
      'r ,
      'q ,
      'p ,
      'o ,
      'n , 'm , 'l , 'k , 'j , 'i , 'h , 'g , 'f , 'e , 'd , 'c , 'b , 'a) _autotrans_at54 =
  { mutable i_2307 : 't ;
    mutable i_1940 : 's ;
    mutable m_1937 : 'r ;
    mutable m_1934 : 'q ;
    mutable m_1932 : 'p ;
    mutable m_1929 : 'o ;
    mutable m_1927 : 'n ;
    mutable nx_1926 : 'm ;
    mutable m_1924 : 'l ;
    mutable m_1921 : 'k ;
    mutable m_1916 : 'j ;
    mutable m_1914 : 'i ;
    mutable r_1909 : 'h ;
    mutable s_1908 : 'g ;
    mutable r_1907 : 'f ;
    mutable s_1906 : 'e ;
    mutable t0_1889 : 'd ;
    mutable t0_1888 : 'c ; mutable i_1942 : 'b ; mutable go_up_1941 : 'a }

let autotrans_at54 (tstep_1844:float) = 
  let Cnode { alloc = i_2307_alloc; copy = i_2307_copy ;
                                    step = i_2307_step ; reset = i_2307_reset } = at54 
   in
  let autotrans_at54_alloc _ =
    ();
    { i_1940 = (false:bool) ;
      m_1937 = (create ():MyOp.t) ;
      m_1934 = (create ():MyOp.t) ;
      m_1932 = (create ():MyOp.t) ;
      m_1929 = (create ():MyOp.t) ;
      m_1927 = (create ():MyOp.t) ;
      nx_1926 = (create ():MyOp.t) ;
      m_1924 = (create ():MyOp.t) ;
      m_1921 = (create ():MyOp.t) ;
      m_1916 = (create ():MyOp.t) ;
      m_1914 = (create ():MyOp.t) ;
      r_1909 = (false:bool) ;
      s_1908 = (At_bench_UpShifting_644:state__9630) ;
      r_1907 = (false:bool) ;
      s_1906 = (At_bench_Fourth_641:state__9629) ;
      t0_1889 = (create ():MyOp.t) ;
      t0_1888 = (create ():MyOp.t) ;
      i_1942 = (false:bool) ; go_up_1941 = (false:bool);
      i_2307 = i_2307_alloc () (* discrete *)  } in
  let autotrans_at54_copy source dest =
    dest.i_1940 <- source.i_1940 ;
    dest.m_1937 <- source.m_1937 ;
    dest.m_1934 <- source.m_1934 ;
    dest.m_1932 <- source.m_1932 ;
    dest.m_1929 <- source.m_1929 ;
    dest.m_1927 <- source.m_1927 ;
    dest.nx_1926 <- source.nx_1926 ;
    dest.m_1924 <- source.m_1924 ;
    dest.m_1921 <- source.m_1921 ;
    dest.m_1916 <- source.m_1916 ;
    dest.m_1914 <- source.m_1914 ;
    dest.r_1909 <- source.r_1909 ;
    dest.s_1908 <- source.s_1908 ;
    dest.r_1907 <- source.r_1907 ;
    dest.s_1906 <- source.s_1906 ;
    dest.t0_1889 <- source.t0_1889 ;
    dest.t0_1888 <- source.t0_1888 ;
    dest.i_1942 <- source.i_1942 ; dest.go_up_1941 <- source.go_up_1941;
    i_2307_copy source.i_2307 dest.i_2307 (* discrete *) in
  let autotrans_at54_reset self  =
    ((self.i_1940 <- true ;
      i_2307_reset self.i_2307  ;
      self.r_1909 <- false ;
      self.s_1908 <- At_bench_SteadyState_642 ;
      self.i_1942 <- true ;
      self.r_1907 <- false ; self.s_1906 <- At_bench_First_638):unit) in 
  let autotrans_at54_step self (inp_1843:(MyOp.t)Array.t) =
    ((let shiftp_1911 = ref (false:bool) in
      let shiftv_1910 = ref (At_common.DOWN:At_common.shift) in
      (if self.i_1940 then self.nx_1926 <- Autotransd.gear1) ;
      (let (gear_1887:MyOp.t) = self.nx_1926 in
       let (x_1939:bool) =
           if self.i_1940 then false else (<>) gear_1887  self.m_1937 in
       let (final_drive_ratio_1895:MyOp.t) =
           MyOp.scale self.m_1927  At_common.p_final_drive_ratio in
       let (aux1_1893:MyOp.t) = MyOp.(-) final_drive_ratio_1895  self.m_1932 in
       let (vehicle_inertia_1904:MyOp.t) =
           MyOp.scale aux1_1893  At_common.iv_inv in
       (if self.i_1940 then self.m_1916 <- MyOp.make 0.) ;
       (let (x_1917:MyOp.t) = self.m_1916 in
        let (x_1931:MyOp.t) =
            if self.i_1940 then x_1917 else MyOp.(-) x_1917  self.m_1929 in
        let (x_1936:MyOp.t) =
            if self.i_1940
            then MyOp.make At_common.p_initial_wheel_speed
            else
              MyOp.(+) self.m_1934  (MyOp.( * ) vehicle_inertia_1904  x_1931) in
        let (x0_1875:MyOp.t) = MyOp.make 1000. in
        (if self.i_1940 then self.m_1924 <- x0_1875) ;
        (let (x_1923:MyOp.t) =
             if self.i_1940 then x_1917 else MyOp.(-) x_1917  self.m_1921 in
         let (tstep'_1855:MyOp.t) = MyOp.make tstep_1844 in
         (if self.i_1940 then self.m_1914 <- tstep'_1855) ;
         self.i_1940 <- false ;
         (let (xmin_1877:MyOp.t) = MyOp.make 600. in
          let (xmax_1876:MyOp.t) = MyOp.make 6000. in
          let (x_1925:MyOp.t) = self.m_1924 in
          let (x_1880:MyOp.t) =
              MyOp.max xmin_1877  (MyOp.min xmax_1876  x_1925) in
          let (linear_speed_1896:MyOp.t) =
              MyOp.scale x_1936  At_common.l_speed_coef in
          let (mph_1897:MyOp.t) =
              MyOp.scale linear_speed_1896  At_common.p_mph in
          let (outp_1848:(MyOp.t)Array.t) =
              Array.of_list ((::) (x_1880 ,
                                   ((::) (gear_1887 ,
                                          ((::) (mph_1897 , ([]))))))) in
          let (rob_1849:MyOp.t) =
              i_2307_step self.i_2307 (tstep'_1855 , outp_1848) in
          self.m_1937 <- gear_1887 ;
          (let (trans_rpm_1903:MyOp.t) =
               MyOp.scale x_1936  At_common.p_final_drive_ratio in
           let ((ti_1863:MyOp.t) , (out_torque_1860:MyOp.t)) =
               At_common.transmission (x_1880 , gear_1887 , trans_rpm_1903) in
           self.m_1927 <- out_torque_1860 ;
           self.m_1934 <- x_1936 ;
           (let (brake_1845:MyOp.t) = Array.get inp_1843  1 in
            let (road_load_1898:MyOp.t) =
                MyOp.translate (MyOp.scale (MyOp.sqr mph_1897) 
                                           At_common.p_aerodynamic_drag) 
                               At_common.p_drag_friction in
            let (brake_1894:MyOp.t) = MyOp.(+) brake_1845  road_load_1898 in
            let (sgn_1899:MyOp.t) =
                if (>=) mph_1897  (MyOp.make 0.)
                then MyOp.make 1.
                else MyOp.make (-1.) in
            let (signed_load_1900:MyOp.t) = MyOp.( * ) sgn_1899  brake_1894 in
            self.m_1932 <- signed_load_1900 ;
            self.m_1929 <- x_1917 ;
            (let (throttle_1853:MyOp.t) = Array.get inp_1843  0 in
             let (dn_th_1884:MyOp.t) =
                 At_common.lookup_interpdn (throttle_1853 , gear_1887) in
             let (up_th_1886:MyOp.t) =
                 At_common.lookup_interpup (throttle_1853 , gear_1887) in
             (begin match self.s_1908 with
                    | At_bench_SteadyState_642 ->
                        (if self.r_1909 then self.i_1942 <- true) ;
                        (if self.i_1942 then
                         self.go_up_1941 <- (>) (MyOp.make (Random.float 1.))
                                                 (MyOp.make 0.5)) ;
                        self.i_1942 <- false ;
                        (begin match (((>) mph_1897  up_th_1886) ,
                                      ((<) mph_1897  dn_th_1884)) with
                               | (_ , true) ->
                                   self.t0_1888 <- x_1917 ;
                                   self.r_1909 <- true ;
                                   self.s_1908 <- At_bench_DownShifting_643
                               | (true , _) ->
                                   self.t0_1889 <- x_1917 ;
                                   self.r_1909 <- true ;
                                   self.s_1908 <- At_bench_UpShifting_644
                               | _ -> self.r_1909 <- false  end)
                    | At_bench_DownShifting_643 ->
                        (if self.r_1909 then ()) ;
                        (begin match (((>) x_1917 
                                           (MyOp.translate self.t0_1888 
                                                           At_common.twait))
                                      , ((>) mph_1897  dn_th_1884)) with
                               | (_ , true) ->
                                   self.r_1909 <- true ;
                                   self.s_1908 <- At_bench_SteadyState_642
                               | (true , _) ->
                                   shiftp_1911 := true ;
                                   shiftv_1910 := At_common.DOWN ;
                                   self.r_1909 <- true ;
                                   self.s_1908 <- At_bench_SteadyState_642
                               | _ -> self.r_1909 <- false  end)
                    | At_bench_UpShifting_644 ->
                        (if self.r_1909 then ()) ;
                        (begin match (((>) x_1917 
                                           (MyOp.translate self.t0_1889 
                                                           At_common.twait))
                                      , ((<) mph_1897  up_th_1886)) with
                               | (_ , true) ->
                                   self.r_1909 <- true ;
                                   self.s_1908 <- At_bench_SteadyState_642
                               | (true , _) ->
                                   shiftp_1911 := true ;
                                   shiftv_1910 := At_common.UP ;
                                   self.r_1909 <- true ;
                                   self.s_1908 <- At_bench_SteadyState_642
                               | _ -> self.r_1909 <- false  end)
                     end) ;
             (begin match self.s_1906 with
                    | At_bench_First_638 ->
                        (if self.r_1907 then ()) ;
                        (begin match (!shiftv_1910 , !shiftp_1911) with
                               | (At_common.UP , true) ->
                                   self.nx_1926 <- Autotransd.gear2 ;
                                   self.r_1907 <- true ;
                                   self.s_1906 <- At_bench_Second_639
                               | _ -> self.r_1907 <- false  end)
                    | At_bench_Second_639 ->
                        (if self.r_1907 then ()) ;
                        (begin match (!shiftv_1910 , !shiftp_1911) with
                               | (At_common.DOWN , true) ->
                                   self.nx_1926 <- Autotransd.gear1 ;
                                   self.r_1907 <- true ;
                                   self.s_1906 <- At_bench_First_638
                               | (At_common.UP , true) ->
                                   self.nx_1926 <- Autotransd.gear3 ;
                                   self.r_1907 <- true ;
                                   self.s_1906 <- At_bench_Third_640
                               | _ -> self.r_1907 <- false  end)
                    | At_bench_Third_640 ->
                        (if self.r_1907 then ()) ;
                        (begin match (!shiftv_1910 , !shiftp_1911) with
                               | (At_common.DOWN , true) ->
                                   self.nx_1926 <- Autotransd.gear2 ;
                                   self.r_1907 <- true ;
                                   self.s_1906 <- At_bench_Second_639
                               | (At_common.UP , true) ->
                                   self.nx_1926 <- Autotransd.gear4 ;
                                   self.r_1907 <- true ;
                                   self.s_1906 <- At_bench_Fourth_641
                               | _ -> self.r_1907 <- false  end)
                    | At_bench_Fourth_641 ->
                        (if self.r_1907 then ()) ;
                        (begin match (!shiftv_1910 , !shiftp_1911) with
                               | (At_common.DOWN , true) ->
                                   self.nx_1926 <- Autotransd.gear3 ;
                                   self.r_1907 <- true ;
                                   self.s_1906 <- At_bench_Third_640
                               | _ -> self.r_1907 <- false  end)
                     end) ;
             (let (te_1871:MyOp.t) =
                  At_common.lookup_engine (throttle_1853 , x_1880) in
              let (drpm_1869:MyOp.t) = MyOp.(-) te_1871  ti_1863 in
              let (dx_1873:MyOp.t) =
                  MyOp.scale drpm_1869  At_common.engine_feedback_gain in
              self.m_1924 <- MyOp.(+) x_1880  (MyOp.( * ) dx_1873  x_1923) ;
              self.m_1921 <- x_1917 ;
              (let (x_1915:MyOp.t) = self.m_1914 in
               self.m_1916 <- x_1915 ;
               self.m_1914 <- MyOp.(+) x_1915  tstep'_1855 ;
               (rob_1849 , x_1939))))))))))):MyOp.t * bool) in
  Cnode { alloc = autotrans_at54_alloc; copy = autotrans_at54_copy ;
                                        reset = autotrans_at54_reset ;
                                        step = autotrans_at54_step }
type ('w ,
      'v ,
      'u ,
      't ,
      's ,
      'r ,
      'q ,
      'p ,
      'o ,
      'n , 'm , 'l , 'k , 'j , 'i , 'h , 'g , 'f , 'e , 'd , 'c , 'b , 'a) _autotrans_at6a =
  { mutable i_2309 : 'w ;
    mutable i_2308 : 'v ;
    mutable i_2054 : 'u ;
    mutable m_2051 : 't ;
    mutable m_2049 : 's ;
    mutable m_2046 : 'r ;
    mutable m_2043 : 'q ;
    mutable m_2041 : 'p ;
    mutable m_2038 : 'o ;
    mutable m_2036 : 'n ;
    mutable nx_2035 : 'm ;
    mutable m_2033 : 'l ;
    mutable m_2030 : 'k ;
    mutable m_2025 : 'j ;
    mutable m_2023 : 'i ;
    mutable r_2018 : 'h ;
    mutable s_2017 : 'g ;
    mutable r_2016 : 'f ;
    mutable s_2015 : 'e ;
    mutable t0_1990 : 'd ;
    mutable t0_1989 : 'c ; mutable i_2056 : 'b ; mutable go_up_2055 : 'a }

let autotrans_at6a (tstep_1944:float) = 
  let Cnode { alloc = i_2309_alloc; copy = i_2309_copy ;
                                    step = i_2309_step ; reset = i_2309_reset } = 
  Discrete_obs_fad.always_timed 4.  in 
  let Cnode { alloc = i_2308_alloc; copy = i_2308_copy ;
                                    step = i_2308_step ; reset = i_2308_reset } = 
  Discrete_obs_fad.once_timed 30.  in
  let autotrans_at6a_alloc _ =
    ();
    { i_2054 = (false:bool) ;
      m_2051 = (create ():MyOp.t) ;
      m_2049 = (create ():MyOp.t) ;
      m_2046 = (create ():MyOp.t) ;
      m_2043 = (create ():MyOp.t) ;
      m_2041 = (create ():MyOp.t) ;
      m_2038 = (create ():MyOp.t) ;
      m_2036 = (create ():MyOp.t) ;
      nx_2035 = (create ():MyOp.t) ;
      m_2033 = (create ():MyOp.t) ;
      m_2030 = (create ():MyOp.t) ;
      m_2025 = (create ():MyOp.t) ;
      m_2023 = (create ():MyOp.t) ;
      r_2018 = (false:bool) ;
      s_2017 = (At_bench_UpShifting_718:state__9632) ;
      r_2016 = (false:bool) ;
      s_2015 = (At_bench_Fourth_715:state__9631) ;
      t0_1990 = (create ():MyOp.t) ;
      t0_1989 = (create ():MyOp.t) ;
      i_2056 = (false:bool) ; go_up_2055 = (false:bool);
      i_2309 = i_2309_alloc () (* discrete *)  ;
      i_2308 = i_2308_alloc () (* discrete *)  } in
  let autotrans_at6a_copy source dest =
    dest.i_2054 <- source.i_2054 ;
    dest.m_2051 <- source.m_2051 ;
    dest.m_2049 <- source.m_2049 ;
    dest.m_2046 <- source.m_2046 ;
    dest.m_2043 <- source.m_2043 ;
    dest.m_2041 <- source.m_2041 ;
    dest.m_2038 <- source.m_2038 ;
    dest.m_2036 <- source.m_2036 ;
    dest.nx_2035 <- source.nx_2035 ;
    dest.m_2033 <- source.m_2033 ;
    dest.m_2030 <- source.m_2030 ;
    dest.m_2025 <- source.m_2025 ;
    dest.m_2023 <- source.m_2023 ;
    dest.r_2018 <- source.r_2018 ;
    dest.s_2017 <- source.s_2017 ;
    dest.r_2016 <- source.r_2016 ;
    dest.s_2015 <- source.s_2015 ;
    dest.t0_1990 <- source.t0_1990 ;
    dest.t0_1989 <- source.t0_1989 ;
    dest.i_2056 <- source.i_2056 ; dest.go_up_2055 <- source.go_up_2055;
    i_2309_copy source.i_2309 dest.i_2309 (* discrete *) ;
    i_2308_copy source.i_2308 dest.i_2308 (* discrete *) in
  let autotrans_at6a_reset self  =
    ((self.i_2054 <- true ;
      i_2309_reset self.i_2309  ;
      i_2308_reset self.i_2308  ;
      self.r_2018 <- false ;
      self.s_2017 <- At_bench_SteadyState_716 ;
      self.i_2056 <- true ;
      self.r_2016 <- false ; self.s_2015 <- At_bench_First_712):unit) in 
  let autotrans_at6a_step self (inp_1943:(MyOp.t)Array.t) =
    ((let shiftp_2020 = ref (false:bool) in
      let shiftv_2019 = ref (At_common.DOWN:At_common.shift) in
      (if self.i_2054 then self.m_2049 <- MyOp.make 0.) ;
      (let (x_2050:MyOp.t) = self.m_2049 in
       let (x_2053:bool) =
           if self.i_2054
           then false
           else
             (&&) ((>=) x_2050  (MyOp.make 4.)) 
                  ((<) self.m_2051  (MyOp.make 4.)) in
       (if self.i_2054 then self.nx_2035 <- Autotransd.gear1) ;
       (let (gear_1988:MyOp.t) = self.nx_2035 in
        let (x_2048:bool) =
            if self.i_2054 then false else (<>) gear_1988  self.m_2046 in
        let (final_drive_ratio_1996:MyOp.t) =
            MyOp.scale self.m_2036  At_common.p_final_drive_ratio in
        let (aux1_1994:MyOp.t) = MyOp.(-) final_drive_ratio_1996  self.m_2041 in
        let (vehicle_inertia_2005:MyOp.t) =
            MyOp.scale aux1_1994  At_common.iv_inv in
        (if self.i_2054 then self.m_2025 <- MyOp.make 0.) ;
        (let (x_2026:MyOp.t) = self.m_2025 in
         let (x_2040:MyOp.t) =
             if self.i_2054 then x_2026 else MyOp.(-) x_2026  self.m_2038 in
         let (x_2045:MyOp.t) =
             if self.i_2054
             then MyOp.make At_common.p_initial_wheel_speed
             else
               MyOp.(+) self.m_2043 
                        (MyOp.( * ) vehicle_inertia_2005  x_2040) in
         let (x0_1976:MyOp.t) = MyOp.make 1000. in
         (if self.i_2054 then self.m_2033 <- x0_1976) ;
         (let (x_2032:MyOp.t) =
              if self.i_2054 then x_2026 else MyOp.(-) x_2026  self.m_2030 in
          let (tstep'_1956:MyOp.t) = MyOp.make tstep_1944 in
          (if self.i_2054 then self.m_2023 <- tstep'_1956) ;
          self.i_2054 <- false ;
          self.m_2049 <- MyOp.(+) x_2050  tstep'_1956 ;
          self.m_2051 <- x_2050 ;
          (let (xmin_1978:MyOp.t) = MyOp.make 600. in
           let (xmax_1977:MyOp.t) = MyOp.make 6000. in
           let (x_2034:MyOp.t) = self.m_2033 in
           let (x_1981:MyOp.t) =
               MyOp.max xmin_1978  (MyOp.min xmax_1977  x_2034) in
           let (linear_speed_1997:MyOp.t) =
               MyOp.scale x_2045  At_common.l_speed_coef in
           let (mph_1998:MyOp.t) =
               MyOp.scale linear_speed_1997  At_common.p_mph in
           let (outp_1948:(MyOp.t)Array.t) =
               Array.of_list ((::) (x_1981 ,
                                    ((::) (gear_1988 ,
                                           ((::) (mph_1998 , ([]))))))) in
           let (rpm_2009:MyOp.t) =
               MyOp.(/) (Array.get outp_1948  0)  (MyOp.make 1000.) in
           let (speed_2010:MyOp.t) =
               MyOp.(/) (Array.get outp_1948  2)  (MyOp.make 100.) in
           let (rpm_max_2011:MyOp.t) = MyOp.make ((/.) 3000.  1000.) in
           let (speed_max_2012:MyOp.t) = MyOp.make ((/.) 35.  100.) in
           let (rob_1949:MyOp.t) =
               Discrete_obs_fad.q_or ((i_2308_step self.i_2308
                                         (tstep'_1956 ,
                                          (Discrete_obs_fad.q_gt (rpm_2009 ,
                                                                  rpm_max_2011))))
                                      ,
                                      (i_2309_step self.i_2309
                                         (tstep'_1956 ,
                                          (Discrete_obs_fad.q_lt (speed_2010
                                                                  ,
                                                                  speed_max_2012))))) in
           self.m_2046 <- gear_1988 ;
           (let (trans_rpm_2004:MyOp.t) =
                MyOp.scale x_2045  At_common.p_final_drive_ratio in
            let ((ti_1964:MyOp.t) , (out_torque_1961:MyOp.t)) =
                At_common.transmission (x_1981 , gear_1988 , trans_rpm_2004) in
            self.m_2036 <- out_torque_1961 ;
            self.m_2043 <- x_2045 ;
            (let (brake_1945:MyOp.t) = Array.get inp_1943  1 in
             let (road_load_1999:MyOp.t) =
                 MyOp.translate (MyOp.scale (MyOp.sqr mph_1998) 
                                            At_common.p_aerodynamic_drag) 
                                At_common.p_drag_friction in
             let (brake_1995:MyOp.t) = MyOp.(+) brake_1945  road_load_1999 in
             let (sgn_2000:MyOp.t) =
                 if (>=) mph_1998  (MyOp.make 0.)
                 then MyOp.make 1.
                 else MyOp.make (-1.) in
             let (signed_load_2001:MyOp.t) = MyOp.( * ) sgn_2000  brake_1995 in
             self.m_2041 <- signed_load_2001 ;
             self.m_2038 <- x_2026 ;
             (let (throttle_1953:MyOp.t) = Array.get inp_1943  0 in
              let (dn_th_1985:MyOp.t) =
                  At_common.lookup_interpdn (throttle_1953 , gear_1988) in
              let (up_th_1987:MyOp.t) =
                  At_common.lookup_interpup (throttle_1953 , gear_1988) in
              (begin match self.s_2017 with
                     | At_bench_SteadyState_716 ->
                         (if self.r_2018 then self.i_2056 <- true) ;
                         (if self.i_2056 then
                          self.go_up_2055 <- (>) (MyOp.make (Random.float 1.))
                                                  (MyOp.make 0.5)) ;
                         self.i_2056 <- false ;
                         (begin match (((>) mph_1998  up_th_1987) ,
                                       ((<) mph_1998  dn_th_1985)) with
                                | (_ , true) ->
                                    self.t0_1989 <- x_2026 ;
                                    self.r_2018 <- true ;
                                    self.s_2017 <- At_bench_DownShifting_717
                                | (true , _) ->
                                    self.t0_1990 <- x_2026 ;
                                    self.r_2018 <- true ;
                                    self.s_2017 <- At_bench_UpShifting_718
                                | _ -> self.r_2018 <- false  end)
                     | At_bench_DownShifting_717 ->
                         (if self.r_2018 then ()) ;
                         (begin match (((>) x_2026 
                                            (MyOp.translate self.t0_1989 
                                                            At_common.twait))
                                       , ((>) mph_1998  dn_th_1985)) with
                                | (_ , true) ->
                                    self.r_2018 <- true ;
                                    self.s_2017 <- At_bench_SteadyState_716
                                | (true , _) ->
                                    shiftp_2020 := true ;
                                    shiftv_2019 := At_common.DOWN ;
                                    self.r_2018 <- true ;
                                    self.s_2017 <- At_bench_SteadyState_716
                                | _ -> self.r_2018 <- false  end)
                     | At_bench_UpShifting_718 ->
                         (if self.r_2018 then ()) ;
                         (begin match (((>) x_2026 
                                            (MyOp.translate self.t0_1990 
                                                            At_common.twait))
                                       , ((<) mph_1998  up_th_1987)) with
                                | (_ , true) ->
                                    self.r_2018 <- true ;
                                    self.s_2017 <- At_bench_SteadyState_716
                                | (true , _) ->
                                    shiftp_2020 := true ;
                                    shiftv_2019 := At_common.UP ;
                                    self.r_2018 <- true ;
                                    self.s_2017 <- At_bench_SteadyState_716
                                | _ -> self.r_2018 <- false  end)
                      end) ;
              (begin match self.s_2015 with
                     | At_bench_First_712 ->
                         (if self.r_2016 then ()) ;
                         (begin match (!shiftv_2019 , !shiftp_2020) with
                                | (At_common.UP , true) ->
                                    self.nx_2035 <- Autotransd.gear2 ;
                                    self.r_2016 <- true ;
                                    self.s_2015 <- At_bench_Second_713
                                | _ -> self.r_2016 <- false  end)
                     | At_bench_Second_713 ->
                         (if self.r_2016 then ()) ;
                         (begin match (!shiftv_2019 , !shiftp_2020) with
                                | (At_common.DOWN , true) ->
                                    self.nx_2035 <- Autotransd.gear1 ;
                                    self.r_2016 <- true ;
                                    self.s_2015 <- At_bench_First_712
                                | (At_common.UP , true) ->
                                    self.nx_2035 <- Autotransd.gear3 ;
                                    self.r_2016 <- true ;
                                    self.s_2015 <- At_bench_Third_714
                                | _ -> self.r_2016 <- false  end)
                     | At_bench_Third_714 ->
                         (if self.r_2016 then ()) ;
                         (begin match (!shiftv_2019 , !shiftp_2020) with
                                | (At_common.DOWN , true) ->
                                    self.nx_2035 <- Autotransd.gear2 ;
                                    self.r_2016 <- true ;
                                    self.s_2015 <- At_bench_Second_713
                                | (At_common.UP , true) ->
                                    self.nx_2035 <- Autotransd.gear4 ;
                                    self.r_2016 <- true ;
                                    self.s_2015 <- At_bench_Fourth_715
                                | _ -> self.r_2016 <- false  end)
                     | At_bench_Fourth_715 ->
                         (if self.r_2016 then ()) ;
                         (begin match (!shiftv_2019 , !shiftp_2020) with
                                | (At_common.DOWN , true) ->
                                    self.nx_2035 <- Autotransd.gear3 ;
                                    self.r_2016 <- true ;
                                    self.s_2015 <- At_bench_Third_714
                                | _ -> self.r_2016 <- false  end)
                      end) ;
              (let (te_1972:MyOp.t) =
                   At_common.lookup_engine (throttle_1953 , x_1981) in
               let (drpm_1970:MyOp.t) = MyOp.(-) te_1972  ti_1964 in
               let (dx_1974:MyOp.t) =
                   MyOp.scale drpm_1970  At_common.engine_feedback_gain in
               self.m_2033 <- MyOp.(+) x_1981  (MyOp.( * ) dx_1974  x_2032) ;
               self.m_2030 <- x_2026 ;
               (let (x_2024:MyOp.t) = self.m_2023 in
                self.m_2025 <- x_2024 ;
                self.m_2023 <- MyOp.(+) x_2024  tstep'_1956 ;
                (rob_1949 , ((||) x_2048  x_2053))))))))))))):MyOp.t * bool) in
  Cnode { alloc = autotrans_at6a_alloc; copy = autotrans_at6a_copy ;
                                        reset = autotrans_at6a_reset ;
                                        step = autotrans_at6a_step }
type ('w ,
      'v ,
      'u ,
      't ,
      's ,
      'r ,
      'q ,
      'p ,
      'o ,
      'n , 'm , 'l , 'k , 'j , 'i , 'h , 'g , 'f , 'e , 'd , 'c , 'b , 'a) _autotrans_at6b =
  { mutable i_2311 : 'w ;
    mutable i_2310 : 'v ;
    mutable i_2168 : 'u ;
    mutable m_2165 : 't ;
    mutable m_2163 : 's ;
    mutable m_2160 : 'r ;
    mutable m_2157 : 'q ;
    mutable m_2155 : 'p ;
    mutable m_2152 : 'o ;
    mutable m_2150 : 'n ;
    mutable nx_2149 : 'm ;
    mutable m_2147 : 'l ;
    mutable m_2144 : 'k ;
    mutable m_2139 : 'j ;
    mutable m_2137 : 'i ;
    mutable r_2132 : 'h ;
    mutable s_2131 : 'g ;
    mutable r_2130 : 'f ;
    mutable s_2129 : 'e ;
    mutable t0_2104 : 'd ;
    mutable t0_2103 : 'c ; mutable i_2170 : 'b ; mutable go_up_2169 : 'a }

let autotrans_at6b (tstep_2058:float) = 
  let Cnode { alloc = i_2311_alloc; copy = i_2311_copy ;
                                    step = i_2311_step ; reset = i_2311_reset } = 
  Discrete_obs_fad.always_timed 8.  in 
  let Cnode { alloc = i_2310_alloc; copy = i_2310_copy ;
                                    step = i_2310_step ; reset = i_2310_reset } = 
  Discrete_obs_fad.once_timed 30.  in
  let autotrans_at6b_alloc _ =
    ();
    { i_2168 = (false:bool) ;
      m_2165 = (create ():MyOp.t) ;
      m_2163 = (create ():MyOp.t) ;
      m_2160 = (create ():MyOp.t) ;
      m_2157 = (create ():MyOp.t) ;
      m_2155 = (create ():MyOp.t) ;
      m_2152 = (create ():MyOp.t) ;
      m_2150 = (create ():MyOp.t) ;
      nx_2149 = (create ():MyOp.t) ;
      m_2147 = (create ():MyOp.t) ;
      m_2144 = (create ():MyOp.t) ;
      m_2139 = (create ():MyOp.t) ;
      m_2137 = (create ():MyOp.t) ;
      r_2132 = (false:bool) ;
      s_2131 = (At_bench_UpShifting_800:state__9634) ;
      r_2130 = (false:bool) ;
      s_2129 = (At_bench_Fourth_797:state__9633) ;
      t0_2104 = (create ():MyOp.t) ;
      t0_2103 = (create ():MyOp.t) ;
      i_2170 = (false:bool) ; go_up_2169 = (false:bool);
      i_2311 = i_2311_alloc () (* discrete *)  ;
      i_2310 = i_2310_alloc () (* discrete *)  } in
  let autotrans_at6b_copy source dest =
    dest.i_2168 <- source.i_2168 ;
    dest.m_2165 <- source.m_2165 ;
    dest.m_2163 <- source.m_2163 ;
    dest.m_2160 <- source.m_2160 ;
    dest.m_2157 <- source.m_2157 ;
    dest.m_2155 <- source.m_2155 ;
    dest.m_2152 <- source.m_2152 ;
    dest.m_2150 <- source.m_2150 ;
    dest.nx_2149 <- source.nx_2149 ;
    dest.m_2147 <- source.m_2147 ;
    dest.m_2144 <- source.m_2144 ;
    dest.m_2139 <- source.m_2139 ;
    dest.m_2137 <- source.m_2137 ;
    dest.r_2132 <- source.r_2132 ;
    dest.s_2131 <- source.s_2131 ;
    dest.r_2130 <- source.r_2130 ;
    dest.s_2129 <- source.s_2129 ;
    dest.t0_2104 <- source.t0_2104 ;
    dest.t0_2103 <- source.t0_2103 ;
    dest.i_2170 <- source.i_2170 ; dest.go_up_2169 <- source.go_up_2169;
    i_2311_copy source.i_2311 dest.i_2311 (* discrete *) ;
    i_2310_copy source.i_2310 dest.i_2310 (* discrete *) in
  let autotrans_at6b_reset self  =
    ((self.i_2168 <- true ;
      i_2311_reset self.i_2311  ;
      i_2310_reset self.i_2310  ;
      self.r_2132 <- false ;
      self.s_2131 <- At_bench_SteadyState_798 ;
      self.i_2170 <- true ;
      self.r_2130 <- false ; self.s_2129 <- At_bench_First_794):unit) in 
  let autotrans_at6b_step self (inp_2057:(MyOp.t)Array.t) =
    ((let shiftp_2134 = ref (false:bool) in
      let shiftv_2133 = ref (At_common.DOWN:At_common.shift) in
      (if self.i_2168 then self.m_2163 <- MyOp.make 0.) ;
      (let (x_2164:MyOp.t) = self.m_2163 in
       let (x_2167:bool) =
           if self.i_2168
           then false
           else
             (&&) ((>=) x_2164  (MyOp.make 8.)) 
                  ((<) self.m_2165  (MyOp.make 8.)) in
       (if self.i_2168 then self.nx_2149 <- Autotransd.gear1) ;
       (let (gear_2102:MyOp.t) = self.nx_2149 in
        let (x_2162:bool) =
            if self.i_2168 then false else (<>) gear_2102  self.m_2160 in
        let (final_drive_ratio_2110:MyOp.t) =
            MyOp.scale self.m_2150  At_common.p_final_drive_ratio in
        let (aux1_2108:MyOp.t) = MyOp.(-) final_drive_ratio_2110  self.m_2155 in
        let (vehicle_inertia_2119:MyOp.t) =
            MyOp.scale aux1_2108  At_common.iv_inv in
        (if self.i_2168 then self.m_2139 <- MyOp.make 0.) ;
        (let (x_2140:MyOp.t) = self.m_2139 in
         let (x_2154:MyOp.t) =
             if self.i_2168 then x_2140 else MyOp.(-) x_2140  self.m_2152 in
         let (x_2159:MyOp.t) =
             if self.i_2168
             then MyOp.make At_common.p_initial_wheel_speed
             else
               MyOp.(+) self.m_2157 
                        (MyOp.( * ) vehicle_inertia_2119  x_2154) in
         let (x0_2090:MyOp.t) = MyOp.make 1000. in
         (if self.i_2168 then self.m_2147 <- x0_2090) ;
         (let (x_2146:MyOp.t) =
              if self.i_2168 then x_2140 else MyOp.(-) x_2140  self.m_2144 in
          let (tstep'_2070:MyOp.t) = MyOp.make tstep_2058 in
          (if self.i_2168 then self.m_2137 <- tstep'_2070) ;
          self.i_2168 <- false ;
          self.m_2163 <- MyOp.(+) x_2164  tstep'_2070 ;
          self.m_2165 <- x_2164 ;
          (let (xmin_2092:MyOp.t) = MyOp.make 600. in
           let (xmax_2091:MyOp.t) = MyOp.make 6000. in
           let (x_2148:MyOp.t) = self.m_2147 in
           let (x_2095:MyOp.t) =
               MyOp.max xmin_2092  (MyOp.min xmax_2091  x_2148) in
           let (linear_speed_2111:MyOp.t) =
               MyOp.scale x_2159  At_common.l_speed_coef in
           let (mph_2112:MyOp.t) =
               MyOp.scale linear_speed_2111  At_common.p_mph in
           let (outp_2062:(MyOp.t)Array.t) =
               Array.of_list ((::) (x_2095 ,
                                    ((::) (gear_2102 ,
                                           ((::) (mph_2112 , ([]))))))) in
           let (rpm_2123:MyOp.t) =
               MyOp.(/) (Array.get outp_2062  0)  (MyOp.make 1000.) in
           let (speed_2124:MyOp.t) =
               MyOp.(/) (Array.get outp_2062  2)  (MyOp.make 100.) in
           let (rpm_max_2125:MyOp.t) = MyOp.make ((/.) 3000.  1000.) in
           let (speed_max_2126:MyOp.t) = MyOp.make ((/.) 50.  100.) in
           let (rob_2063:MyOp.t) =
               Discrete_obs_fad.q_or ((i_2310_step self.i_2310
                                         (tstep'_2070 ,
                                          (Discrete_obs_fad.q_gt (rpm_2123 ,
                                                                  rpm_max_2125))))
                                      ,
                                      (i_2311_step self.i_2311
                                         (tstep'_2070 ,
                                          (Discrete_obs_fad.q_lt (speed_2124
                                                                  ,
                                                                  speed_max_2126))))) in
           self.m_2160 <- gear_2102 ;
           (let (trans_rpm_2118:MyOp.t) =
                MyOp.scale x_2159  At_common.p_final_drive_ratio in
            let ((ti_2078:MyOp.t) , (out_torque_2075:MyOp.t)) =
                At_common.transmission (x_2095 , gear_2102 , trans_rpm_2118) in
            self.m_2150 <- out_torque_2075 ;
            self.m_2157 <- x_2159 ;
            (let (brake_2059:MyOp.t) = Array.get inp_2057  1 in
             let (road_load_2113:MyOp.t) =
                 MyOp.translate (MyOp.scale (MyOp.sqr mph_2112) 
                                            At_common.p_aerodynamic_drag) 
                                At_common.p_drag_friction in
             let (brake_2109:MyOp.t) = MyOp.(+) brake_2059  road_load_2113 in
             let (sgn_2114:MyOp.t) =
                 if (>=) mph_2112  (MyOp.make 0.)
                 then MyOp.make 1.
                 else MyOp.make (-1.) in
             let (signed_load_2115:MyOp.t) = MyOp.( * ) sgn_2114  brake_2109 in
             self.m_2155 <- signed_load_2115 ;
             self.m_2152 <- x_2140 ;
             (let (throttle_2067:MyOp.t) = Array.get inp_2057  0 in
              let (dn_th_2099:MyOp.t) =
                  At_common.lookup_interpdn (throttle_2067 , gear_2102) in
              let (up_th_2101:MyOp.t) =
                  At_common.lookup_interpup (throttle_2067 , gear_2102) in
              (begin match self.s_2131 with
                     | At_bench_SteadyState_798 ->
                         (if self.r_2132 then self.i_2170 <- true) ;
                         (if self.i_2170 then
                          self.go_up_2169 <- (>) (MyOp.make (Random.float 1.))
                                                  (MyOp.make 0.5)) ;
                         self.i_2170 <- false ;
                         (begin match (((>) mph_2112  up_th_2101) ,
                                       ((<) mph_2112  dn_th_2099)) with
                                | (_ , true) ->
                                    self.t0_2103 <- x_2140 ;
                                    self.r_2132 <- true ;
                                    self.s_2131 <- At_bench_DownShifting_799
                                | (true , _) ->
                                    self.t0_2104 <- x_2140 ;
                                    self.r_2132 <- true ;
                                    self.s_2131 <- At_bench_UpShifting_800
                                | _ -> self.r_2132 <- false  end)
                     | At_bench_DownShifting_799 ->
                         (if self.r_2132 then ()) ;
                         (begin match (((>) x_2140 
                                            (MyOp.translate self.t0_2103 
                                                            At_common.twait))
                                       , ((>) mph_2112  dn_th_2099)) with
                                | (_ , true) ->
                                    self.r_2132 <- true ;
                                    self.s_2131 <- At_bench_SteadyState_798
                                | (true , _) ->
                                    shiftp_2134 := true ;
                                    shiftv_2133 := At_common.DOWN ;
                                    self.r_2132 <- true ;
                                    self.s_2131 <- At_bench_SteadyState_798
                                | _ -> self.r_2132 <- false  end)
                     | At_bench_UpShifting_800 ->
                         (if self.r_2132 then ()) ;
                         (begin match (((>) x_2140 
                                            (MyOp.translate self.t0_2104 
                                                            At_common.twait))
                                       , ((<) mph_2112  up_th_2101)) with
                                | (_ , true) ->
                                    self.r_2132 <- true ;
                                    self.s_2131 <- At_bench_SteadyState_798
                                | (true , _) ->
                                    shiftp_2134 := true ;
                                    shiftv_2133 := At_common.UP ;
                                    self.r_2132 <- true ;
                                    self.s_2131 <- At_bench_SteadyState_798
                                | _ -> self.r_2132 <- false  end)
                      end) ;
              (begin match self.s_2129 with
                     | At_bench_First_794 ->
                         (if self.r_2130 then ()) ;
                         (begin match (!shiftv_2133 , !shiftp_2134) with
                                | (At_common.UP , true) ->
                                    self.nx_2149 <- Autotransd.gear2 ;
                                    self.r_2130 <- true ;
                                    self.s_2129 <- At_bench_Second_795
                                | _ -> self.r_2130 <- false  end)
                     | At_bench_Second_795 ->
                         (if self.r_2130 then ()) ;
                         (begin match (!shiftv_2133 , !shiftp_2134) with
                                | (At_common.DOWN , true) ->
                                    self.nx_2149 <- Autotransd.gear1 ;
                                    self.r_2130 <- true ;
                                    self.s_2129 <- At_bench_First_794
                                | (At_common.UP , true) ->
                                    self.nx_2149 <- Autotransd.gear3 ;
                                    self.r_2130 <- true ;
                                    self.s_2129 <- At_bench_Third_796
                                | _ -> self.r_2130 <- false  end)
                     | At_bench_Third_796 ->
                         (if self.r_2130 then ()) ;
                         (begin match (!shiftv_2133 , !shiftp_2134) with
                                | (At_common.DOWN , true) ->
                                    self.nx_2149 <- Autotransd.gear2 ;
                                    self.r_2130 <- true ;
                                    self.s_2129 <- At_bench_Second_795
                                | (At_common.UP , true) ->
                                    self.nx_2149 <- Autotransd.gear4 ;
                                    self.r_2130 <- true ;
                                    self.s_2129 <- At_bench_Fourth_797
                                | _ -> self.r_2130 <- false  end)
                     | At_bench_Fourth_797 ->
                         (if self.r_2130 then ()) ;
                         (begin match (!shiftv_2133 , !shiftp_2134) with
                                | (At_common.DOWN , true) ->
                                    self.nx_2149 <- Autotransd.gear3 ;
                                    self.r_2130 <- true ;
                                    self.s_2129 <- At_bench_Third_796
                                | _ -> self.r_2130 <- false  end)
                      end) ;
              (let (te_2086:MyOp.t) =
                   At_common.lookup_engine (throttle_2067 , x_2095) in
               let (drpm_2084:MyOp.t) = MyOp.(-) te_2086  ti_2078 in
               let (dx_2088:MyOp.t) =
                   MyOp.scale drpm_2084  At_common.engine_feedback_gain in
               self.m_2147 <- MyOp.(+) x_2095  (MyOp.( * ) dx_2088  x_2146) ;
               self.m_2144 <- x_2140 ;
               (let (x_2138:MyOp.t) = self.m_2137 in
                self.m_2139 <- x_2138 ;
                self.m_2137 <- MyOp.(+) x_2138  tstep'_2070 ;
                (rob_2063 , ((||) x_2162  x_2167))))))))))))):MyOp.t * bool) in
  Cnode { alloc = autotrans_at6b_alloc; copy = autotrans_at6b_copy ;
                                        reset = autotrans_at6b_reset ;
                                        step = autotrans_at6b_step }
type ('w ,
      'v ,
      'u ,
      't ,
      's ,
      'r ,
      'q ,
      'p ,
      'o ,
      'n , 'm , 'l , 'k , 'j , 'i , 'h , 'g , 'f , 'e , 'd , 'c , 'b , 'a) _autotrans_at6c =
  { mutable i_2313 : 'w ;
    mutable i_2312 : 'v ;
    mutable i_2282 : 'u ;
    mutable m_2279 : 't ;
    mutable m_2277 : 's ;
    mutable m_2274 : 'r ;
    mutable m_2271 : 'q ;
    mutable m_2269 : 'p ;
    mutable m_2266 : 'o ;
    mutable m_2264 : 'n ;
    mutable nx_2263 : 'm ;
    mutable m_2261 : 'l ;
    mutable m_2258 : 'k ;
    mutable m_2253 : 'j ;
    mutable m_2251 : 'i ;
    mutable r_2246 : 'h ;
    mutable s_2245 : 'g ;
    mutable r_2244 : 'f ;
    mutable s_2243 : 'e ;
    mutable t0_2218 : 'd ;
    mutable t0_2217 : 'c ; mutable i_2284 : 'b ; mutable go_up_2283 : 'a }

let autotrans_at6c (tstep_2172:float) = 
  let Cnode { alloc = i_2313_alloc; copy = i_2313_copy ;
                                    step = i_2313_step ; reset = i_2313_reset } = 
  Discrete_obs_fad.always_timed 20.  in 
  let Cnode { alloc = i_2312_alloc; copy = i_2312_copy ;
                                    step = i_2312_step ; reset = i_2312_reset } = 
  Discrete_obs_fad.once_timed 30.  in
  let autotrans_at6c_alloc _ =
    ();
    { i_2282 = (false:bool) ;
      m_2279 = (create ():MyOp.t) ;
      m_2277 = (create ():MyOp.t) ;
      m_2274 = (create ():MyOp.t) ;
      m_2271 = (create ():MyOp.t) ;
      m_2269 = (create ():MyOp.t) ;
      m_2266 = (create ():MyOp.t) ;
      m_2264 = (create ():MyOp.t) ;
      nx_2263 = (create ():MyOp.t) ;
      m_2261 = (create ():MyOp.t) ;
      m_2258 = (create ():MyOp.t) ;
      m_2253 = (create ():MyOp.t) ;
      m_2251 = (create ():MyOp.t) ;
      r_2246 = (false:bool) ;
      s_2245 = (At_bench_UpShifting_882:state__9636) ;
      r_2244 = (false:bool) ;
      s_2243 = (At_bench_Fourth_879:state__9635) ;
      t0_2218 = (create ():MyOp.t) ;
      t0_2217 = (create ():MyOp.t) ;
      i_2284 = (false:bool) ; go_up_2283 = (false:bool);
      i_2313 = i_2313_alloc () (* discrete *)  ;
      i_2312 = i_2312_alloc () (* discrete *)  } in
  let autotrans_at6c_copy source dest =
    dest.i_2282 <- source.i_2282 ;
    dest.m_2279 <- source.m_2279 ;
    dest.m_2277 <- source.m_2277 ;
    dest.m_2274 <- source.m_2274 ;
    dest.m_2271 <- source.m_2271 ;
    dest.m_2269 <- source.m_2269 ;
    dest.m_2266 <- source.m_2266 ;
    dest.m_2264 <- source.m_2264 ;
    dest.nx_2263 <- source.nx_2263 ;
    dest.m_2261 <- source.m_2261 ;
    dest.m_2258 <- source.m_2258 ;
    dest.m_2253 <- source.m_2253 ;
    dest.m_2251 <- source.m_2251 ;
    dest.r_2246 <- source.r_2246 ;
    dest.s_2245 <- source.s_2245 ;
    dest.r_2244 <- source.r_2244 ;
    dest.s_2243 <- source.s_2243 ;
    dest.t0_2218 <- source.t0_2218 ;
    dest.t0_2217 <- source.t0_2217 ;
    dest.i_2284 <- source.i_2284 ; dest.go_up_2283 <- source.go_up_2283;
    i_2313_copy source.i_2313 dest.i_2313 (* discrete *) ;
    i_2312_copy source.i_2312 dest.i_2312 (* discrete *) in
  let autotrans_at6c_reset self  =
    ((self.i_2282 <- true ;
      i_2313_reset self.i_2313  ;
      i_2312_reset self.i_2312  ;
      self.r_2246 <- false ;
      self.s_2245 <- At_bench_SteadyState_880 ;
      self.i_2284 <- true ;
      self.r_2244 <- false ; self.s_2243 <- At_bench_First_876):unit) in 
  let autotrans_at6c_step self (inp_2171:(MyOp.t)Array.t) =
    ((let shiftp_2248 = ref (false:bool) in
      let shiftv_2247 = ref (At_common.DOWN:At_common.shift) in
      (if self.i_2282 then self.m_2277 <- MyOp.make 0.) ;
      (let (x_2278:MyOp.t) = self.m_2277 in
       let (x_2281:bool) =
           if self.i_2282
           then false
           else
             (&&) ((>=) x_2278  (MyOp.make 20.)) 
                  ((<) self.m_2279  (MyOp.make 20.)) in
       (if self.i_2282 then self.nx_2263 <- Autotransd.gear1) ;
       (let (gear_2216:MyOp.t) = self.nx_2263 in
        let (x_2276:bool) =
            if self.i_2282 then false else (<>) gear_2216  self.m_2274 in
        let (final_drive_ratio_2224:MyOp.t) =
            MyOp.scale self.m_2264  At_common.p_final_drive_ratio in
        let (aux1_2222:MyOp.t) = MyOp.(-) final_drive_ratio_2224  self.m_2269 in
        let (vehicle_inertia_2233:MyOp.t) =
            MyOp.scale aux1_2222  At_common.iv_inv in
        (if self.i_2282 then self.m_2253 <- MyOp.make 0.) ;
        (let (x_2254:MyOp.t) = self.m_2253 in
         let (x_2268:MyOp.t) =
             if self.i_2282 then x_2254 else MyOp.(-) x_2254  self.m_2266 in
         let (x_2273:MyOp.t) =
             if self.i_2282
             then MyOp.make At_common.p_initial_wheel_speed
             else
               MyOp.(+) self.m_2271 
                        (MyOp.( * ) vehicle_inertia_2233  x_2268) in
         let (x0_2204:MyOp.t) = MyOp.make 1000. in
         (if self.i_2282 then self.m_2261 <- x0_2204) ;
         (let (x_2260:MyOp.t) =
              if self.i_2282 then x_2254 else MyOp.(-) x_2254  self.m_2258 in
          let (tstep'_2184:MyOp.t) = MyOp.make tstep_2172 in
          (if self.i_2282 then self.m_2251 <- tstep'_2184) ;
          self.i_2282 <- false ;
          self.m_2277 <- MyOp.(+) x_2278  tstep'_2184 ;
          self.m_2279 <- x_2278 ;
          (let (xmin_2206:MyOp.t) = MyOp.make 600. in
           let (xmax_2205:MyOp.t) = MyOp.make 6000. in
           let (x_2262:MyOp.t) = self.m_2261 in
           let (x_2209:MyOp.t) =
               MyOp.max xmin_2206  (MyOp.min xmax_2205  x_2262) in
           let (linear_speed_2225:MyOp.t) =
               MyOp.scale x_2273  At_common.l_speed_coef in
           let (mph_2226:MyOp.t) =
               MyOp.scale linear_speed_2225  At_common.p_mph in
           let (outp_2176:(MyOp.t)Array.t) =
               Array.of_list ((::) (x_2209 ,
                                    ((::) (gear_2216 ,
                                           ((::) (mph_2226 , ([]))))))) in
           let (rpm_2237:MyOp.t) =
               MyOp.(/) (Array.get outp_2176  0)  (MyOp.make 5000.) in
           let (speed_2238:MyOp.t) =
               MyOp.(/) (Array.get outp_2176  2)  (MyOp.make 120.) in
           let (rpm_max_2239:MyOp.t) = MyOp.make ((/.) 3000.  5000.) in
           let (speed_max_2240:MyOp.t) = MyOp.make ((/.) 65.  120.) in
           let (rob_2177:MyOp.t) =
               Discrete_obs_fad.q_or ((i_2312_step self.i_2312
                                         (tstep'_2184 ,
                                          (Discrete_obs_fad.q_gt (rpm_2237 ,
                                                                  rpm_max_2239))))
                                      ,
                                      (i_2313_step self.i_2313
                                         (tstep'_2184 ,
                                          (Discrete_obs_fad.q_lt (speed_2238
                                                                  ,
                                                                  speed_max_2240))))) in
           self.m_2274 <- gear_2216 ;
           (let (trans_rpm_2232:MyOp.t) =
                MyOp.scale x_2273  At_common.p_final_drive_ratio in
            let ((ti_2192:MyOp.t) , (out_torque_2189:MyOp.t)) =
                At_common.transmission (x_2209 , gear_2216 , trans_rpm_2232) in
            self.m_2264 <- out_torque_2189 ;
            self.m_2271 <- x_2273 ;
            (let (brake_2173:MyOp.t) = Array.get inp_2171  1 in
             let (road_load_2227:MyOp.t) =
                 MyOp.translate (MyOp.scale (MyOp.sqr mph_2226) 
                                            At_common.p_aerodynamic_drag) 
                                At_common.p_drag_friction in
             let (brake_2223:MyOp.t) = MyOp.(+) brake_2173  road_load_2227 in
             let (sgn_2228:MyOp.t) =
                 if (>=) mph_2226  (MyOp.make 0.)
                 then MyOp.make 1.
                 else MyOp.make (-1.) in
             let (signed_load_2229:MyOp.t) = MyOp.( * ) sgn_2228  brake_2223 in
             self.m_2269 <- signed_load_2229 ;
             self.m_2266 <- x_2254 ;
             (let (throttle_2181:MyOp.t) = Array.get inp_2171  0 in
              let (dn_th_2213:MyOp.t) =
                  At_common.lookup_interpdn (throttle_2181 , gear_2216) in
              let (up_th_2215:MyOp.t) =
                  At_common.lookup_interpup (throttle_2181 , gear_2216) in
              (begin match self.s_2245 with
                     | At_bench_SteadyState_880 ->
                         (if self.r_2246 then self.i_2284 <- true) ;
                         (if self.i_2284 then
                          self.go_up_2283 <- (>) (MyOp.make (Random.float 1.))
                                                  (MyOp.make 0.5)) ;
                         self.i_2284 <- false ;
                         (begin match (((>) mph_2226  up_th_2215) ,
                                       ((<) mph_2226  dn_th_2213)) with
                                | (_ , true) ->
                                    self.t0_2217 <- x_2254 ;
                                    self.r_2246 <- true ;
                                    self.s_2245 <- At_bench_DownShifting_881
                                | (true , _) ->
                                    self.t0_2218 <- x_2254 ;
                                    self.r_2246 <- true ;
                                    self.s_2245 <- At_bench_UpShifting_882
                                | _ -> self.r_2246 <- false  end)
                     | At_bench_DownShifting_881 ->
                         (if self.r_2246 then ()) ;
                         (begin match (((>) x_2254 
                                            (MyOp.translate self.t0_2217 
                                                            At_common.twait))
                                       , ((>) mph_2226  dn_th_2213)) with
                                | (_ , true) ->
                                    self.r_2246 <- true ;
                                    self.s_2245 <- At_bench_SteadyState_880
                                | (true , _) ->
                                    shiftp_2248 := true ;
                                    shiftv_2247 := At_common.DOWN ;
                                    self.r_2246 <- true ;
                                    self.s_2245 <- At_bench_SteadyState_880
                                | _ -> self.r_2246 <- false  end)
                     | At_bench_UpShifting_882 ->
                         (if self.r_2246 then ()) ;
                         (begin match (((>) x_2254 
                                            (MyOp.translate self.t0_2218 
                                                            At_common.twait))
                                       , ((<) mph_2226  up_th_2215)) with
                                | (_ , true) ->
                                    self.r_2246 <- true ;
                                    self.s_2245 <- At_bench_SteadyState_880
                                | (true , _) ->
                                    shiftp_2248 := true ;
                                    shiftv_2247 := At_common.UP ;
                                    self.r_2246 <- true ;
                                    self.s_2245 <- At_bench_SteadyState_880
                                | _ -> self.r_2246 <- false  end)
                      end) ;
              (begin match self.s_2243 with
                     | At_bench_First_876 ->
                         (if self.r_2244 then ()) ;
                         (begin match (!shiftv_2247 , !shiftp_2248) with
                                | (At_common.UP , true) ->
                                    self.nx_2263 <- Autotransd.gear2 ;
                                    self.r_2244 <- true ;
                                    self.s_2243 <- At_bench_Second_877
                                | _ -> self.r_2244 <- false  end)
                     | At_bench_Second_877 ->
                         (if self.r_2244 then ()) ;
                         (begin match (!shiftv_2247 , !shiftp_2248) with
                                | (At_common.DOWN , true) ->
                                    self.nx_2263 <- Autotransd.gear1 ;
                                    self.r_2244 <- true ;
                                    self.s_2243 <- At_bench_First_876
                                | (At_common.UP , true) ->
                                    self.nx_2263 <- Autotransd.gear3 ;
                                    self.r_2244 <- true ;
                                    self.s_2243 <- At_bench_Third_878
                                | _ -> self.r_2244 <- false  end)
                     | At_bench_Third_878 ->
                         (if self.r_2244 then ()) ;
                         (begin match (!shiftv_2247 , !shiftp_2248) with
                                | (At_common.DOWN , true) ->
                                    self.nx_2263 <- Autotransd.gear2 ;
                                    self.r_2244 <- true ;
                                    self.s_2243 <- At_bench_Second_877
                                | (At_common.UP , true) ->
                                    self.nx_2263 <- Autotransd.gear4 ;
                                    self.r_2244 <- true ;
                                    self.s_2243 <- At_bench_Fourth_879
                                | _ -> self.r_2244 <- false  end)
                     | At_bench_Fourth_879 ->
                         (if self.r_2244 then ()) ;
                         (begin match (!shiftv_2247 , !shiftp_2248) with
                                | (At_common.DOWN , true) ->
                                    self.nx_2263 <- Autotransd.gear3 ;
                                    self.r_2244 <- true ;
                                    self.s_2243 <- At_bench_Third_878
                                | _ -> self.r_2244 <- false  end)
                      end) ;
              (let (te_2200:MyOp.t) =
                   At_common.lookup_engine (throttle_2181 , x_2209) in
               let (drpm_2198:MyOp.t) = MyOp.(-) te_2200  ti_2192 in
               let (dx_2202:MyOp.t) =
                   MyOp.scale drpm_2198  At_common.engine_feedback_gain in
               self.m_2261 <- MyOp.(+) x_2209  (MyOp.( * ) dx_2202  x_2260) ;
               self.m_2258 <- x_2254 ;
               (let (x_2252:MyOp.t) = self.m_2251 in
                self.m_2253 <- x_2252 ;
                self.m_2251 <- MyOp.(+) x_2252  tstep'_2184 ;
                (rob_2177 , ((||) x_2276  x_2281))))))))))))):MyOp.t * bool) in
  Cnode { alloc = autotrans_at6c_alloc; copy = autotrans_at6c_copy ;
                                        reset = autotrans_at6c_reset ;
                                        step = autotrans_at6c_step }
