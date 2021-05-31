(* The Zélus compiler, version 2.0
  (jeudi 4 juin 2020, 17:57:12 (UTC+0200)) *)
open Ztypes
type state__8775 =
Cc_bench_Braking_900 | Cc_bench_Keeping_899 | Cc_bench_Chasing_898 
type state__8774 =
Cc_bench_Braking_877 | Cc_bench_Keeping_876 | Cc_bench_Chasing_875 
type state__8773 =
Cc_bench_Braking_854 | Cc_bench_Keeping_853 | Cc_bench_Chasing_852 
type state__8772 =
Cc_bench_Braking_831 | Cc_bench_Keeping_830 | Cc_bench_Chasing_829 
type state__8771 =
Cc_bench_Err_753
| Cc_bench_Alwaysp_752 | Cc_bench_Okp_751 | Cc_bench_Notp_750 
type state__8770 =
Cc_bench_Braking_741 | Cc_bench_Keeping_740 | Cc_bench_Chasing_739 
type state__8769 =
Cc_bench_Braking_718 | Cc_bench_Keeping_717 | Cc_bench_Chasing_716 
type state__8768 =
Cc_bench_Braking_695 | Cc_bench_Keeping_694 | Cc_bench_Chasing_693 
type state__8767 =
Cc_bench_Braking_672 | Cc_bench_Keeping_671 | Cc_bench_Chasing_670 
type state__8766 =
Cc_bench_Braking_597 | Cc_bench_Keeping_596 | Cc_bench_Chasing_595 
type state__8765 =
Cc_bench_Braking_574 | Cc_bench_Keeping_573 | Cc_bench_Chasing_572 
type state__8764 =
Cc_bench_Braking_551 | Cc_bench_Keeping_550 | Cc_bench_Chasing_549 
type state__8763 =
Cc_bench_Braking_528 | Cc_bench_Keeping_527 | Cc_bench_Chasing_526 
type state__8762 =
Cc_bench_Braking_453 | Cc_bench_Keeping_452 | Cc_bench_Chasing_451 
type state__8761 =
Cc_bench_Braking_430 | Cc_bench_Keeping_429 | Cc_bench_Chasing_428 
type state__8760 =
Cc_bench_Braking_407 | Cc_bench_Keeping_406 | Cc_bench_Chasing_405 
type state__8759 =
Cc_bench_Braking_384 | Cc_bench_Keeping_383 | Cc_bench_Chasing_382 
type state__8758 =
Cc_bench_Braking_309 | Cc_bench_Keeping_308 | Cc_bench_Chasing_307 
type state__8757 =
Cc_bench_Braking_286 | Cc_bench_Keeping_285 | Cc_bench_Chasing_284 
type state__8756 =
Cc_bench_Braking_263 | Cc_bench_Keeping_262 | Cc_bench_Chasing_261 
type state__8755 =
Cc_bench_Braking_240 | Cc_bench_Keeping_239 | Cc_bench_Chasing_238 
type state__8754 =
Cc_bench_Err_153
| Cc_bench_Alwaysp_152 | Cc_bench_Okp_151 | Cc_bench_Notp_150 
type state__8753 =
Cc_bench_Err_143
| Cc_bench_Evp2_142 | Cc_bench_Evp2_strict_141 | Cc_bench_Alwp1_140 
open MyOp
open Discrete_obs_fad
let q_true = MyOp.make 10.

let q_false = MyOp.make (-10.)

type ('a) _cc1 =
  { mutable i_2287 : 'a }

let cc1  = 
  let Node { alloc = i_2287_alloc; step = i_2287_step ; reset = i_2287_reset } = 
  Discrete_obs_fad.always_timed 100.  in
  let cc1_alloc _ =
    ();{ i_2287 = i_2287_alloc () (* discrete *)  } in
  let cc1_reset self  =
    (i_2287_reset self.i_2287 :unit) in 
  let cc1_step self ((tstep_1264:MyOp.t) ,
                     (c4_1262:MyOp.t) , (c5_1263:MyOp.t)) =
    (i_2287_step self.i_2287
       (tstep_1264 ,
        (Discrete_obs_fad.q_le ((MyOp.(-) c5_1263  c4_1262) , (MyOp.make 40.)))):
    MyOp.t) in
  Node { alloc = cc1_alloc; reset = cc1_reset ; step = cc1_step }
type ('b , 'a) _cc2 =
  { mutable i_2289 : 'b ; mutable i_2288 : 'a }

let cc2  = 
  let Node { alloc = i_2289_alloc; step = i_2289_step ; reset = i_2289_reset } = 
  Discrete_obs_fad.always_timed 100.  in 
  let Node { alloc = i_2288_alloc; step = i_2288_step ; reset = i_2288_reset } = 
  Discrete_obs_fad.bounded_recurrence 30.  in
  let cc2_alloc _ =
    ();
    { i_2289 = i_2289_alloc () (* discrete *)  ;
      i_2288 = i_2288_alloc () (* discrete *)  } in
  let cc2_reset self  =
    ((i_2289_reset self.i_2289  ; i_2288_reset self.i_2288 ):unit) in 
  let cc2_step self ((tstep_1267:MyOp.t) ,
                     (c4_1265:MyOp.t) , (c5_1266:MyOp.t)) =
    (i_2289_step self.i_2289
       (tstep_1267 ,
        (i_2288_step self.i_2288
           (tstep_1267 ,
            (Discrete_obs_fad.q_ge ((MyOp.(-) c5_1266  c4_1265) ,
                                    (MyOp.make 15.)))))):MyOp.t) in
  Node { alloc = cc2_alloc; reset = cc2_reset ; step = cc2_step }
type ('d , 'c , 'b , 'a) _cc3 =
  { mutable i_2290 : 'd ;
    mutable r_1278 : 'c ; mutable s_1277 : 'b ; mutable ok_1274 : 'a }

let cc3  = 
  let Node { alloc = i_2290_alloc; step = i_2290_step ; reset = i_2290_reset } = 
  Discrete_obs_fad.bounded_recurrence 20.  in
  let cc3_alloc _ =
    ();
    { r_1278 = (false:bool) ;
      s_1277 = (Cc_bench_Err_143:state__8753) ;
      ok_1274 = (create ():MyOp.t);
      i_2290 = i_2290_alloc () (* discrete *)  } in
  let cc3_reset self  =
    ((self.r_1278 <- false ;
      self.s_1277 <- Cc_bench_Alwp1_140 ; i_2290_reset self.i_2290 ):
    unit) in 
  let cc3_step self ((tstep_1272:MyOp.t) ,
                     (c1_1268:MyOp.t) ,
                     (c2_1269:MyOp.t) , (c4_1270:MyOp.t) , (c5_1271:MyOp.t)) =
    ((let (p2_1276:MyOp.t) =
          Discrete_obs_fad.q_ge ((MyOp.(-) c5_1271  c4_1270) ,
                                 (MyOp.make 40.)) in
      let (evp2_1273:MyOp.t) = i_2290_step self.i_2290 (tstep_1272 , p2_1276) in
      let (p1_1275:MyOp.t) =
          Discrete_obs_fad.q_le ((MyOp.(-) c2_1269  c1_1268) ,
                                 (MyOp.make 21.)) in
      (begin match self.s_1277 with
             | Cc_bench_Alwp1_140 ->
                 (if self.r_1278 then ()) ;
                 self.ok_1274 <- q_true ;
                 (begin match Discrete_obs_fad.isFalse p1_1275 with
                        | true ->
                            self.r_1278 <- true ;
                            self.s_1277 <- Cc_bench_Evp2_strict_141
                        | _ -> self.r_1278 <- false  end)
             | Cc_bench_Evp2_strict_141 ->
                 (if self.r_1278 then ()) ;
                 self.ok_1274 <- q_true ;
                 (begin match ((Discrete_obs_fad.isFalse evp2_1273) ,
                               (Discrete_obs_fad.isTrue p2_1276) ,
                               (Discrete_obs_fad.isTrue p1_1275) ,
                               (Discrete_obs_fad.isTrue p2_1276) ,
                               (Discrete_obs_fad.isFalse p1_1275)) with
                        | (_ , _ , _ , true , true) ->
                            self.r_1278 <- true ;
                            self.s_1277 <- Cc_bench_Evp2_142
                        | (_ , true , true , _ , _) ->
                            self.r_1278 <- true ;
                            self.s_1277 <- Cc_bench_Alwp1_140
                        | (true , _ , _ , _ , _) ->
                            self.r_1278 <- true ;
                            self.s_1277 <- Cc_bench_Err_143
                        | _ -> self.r_1278 <- false  end)
             | Cc_bench_Evp2_142 ->
                 (if self.r_1278 then ()) ;
                 self.ok_1274 <- q_true ;
                 (begin match ((Discrete_obs_fad.isFalse evp2_1273) ,
                               (Discrete_obs_fad.isTrue p1_1275)) with
                        | (_ , true) ->
                            self.r_1278 <- true ;
                            self.s_1277 <- Cc_bench_Alwp1_140
                        | (true , _) ->
                            self.r_1278 <- true ;
                            self.s_1277 <- Cc_bench_Err_143
                        | _ -> self.r_1278 <- false  end)
             | Cc_bench_Err_143 ->
                 (if self.r_1278 then ()) ;
                 self.ok_1274 <- q_false ; self.r_1278 <- false
              end) ; self.ok_1274):MyOp.t) in
  Node { alloc = cc3_alloc; reset = cc3_reset ; step = cc3_step }
type ('j , 'i , 'h , 'g , 'f , 'e , 'd , 'c , 'b , 'a) _cc4 =
  { mutable i_1292 : 'j ;
    mutable m_1290 : 'i ;
    mutable r_1289 : 'h ;
    mutable s_1288 : 'g ;
    mutable t1_1287 : 'f ;
    mutable t0_1286 : 'e ;
    mutable t0_1285 : 'd ;
    mutable ok_1282 : 'c ;
    mutable local_t_1293 : 'b ; mutable local_t_1294 : 'a }

let cc4  = 
  
  let cc4_alloc _ =
    ();
    { i_1292 = (false:bool) ;
      m_1290 = (create ():MyOp.t) ;
      r_1289 = (false:bool) ;
      s_1288 = (Cc_bench_Err_153:state__8754) ;
      t1_1287 = (create ():MyOp.t) ;
      t0_1286 = (create ():MyOp.t) ;
      t0_1285 = (create ():MyOp.t) ;
      ok_1282 = (create ():MyOp.t) ;
      local_t_1293 = (create ():MyOp.t) ;
      local_t_1294 = (create ():MyOp.t) } in
  let cc4_reset self  =
    ((self.i_1292 <- true ;
      self.r_1289 <- false ; self.s_1288 <- Cc_bench_Notp_150):unit) in 
  let cc4_step self ((tstep_1281:MyOp.t) ,
                     (c4_1279:MyOp.t) , (c5_1280:MyOp.t)) =
    (((if self.i_1292 then self.m_1290 <- MyOp.make 0.) ;
      (let (x_1291:MyOp.t) = self.m_1290 in
       (if self.i_1292 then self.t0_1285 <- x_1291) ;
       self.i_1292 <- false ;
       (let (p_1283:MyOp.t) =
            Discrete_obs_fad.q_ge ((MyOp.(-) c5_1280  c4_1279) ,
                                   (MyOp.make 8.)) in
        (begin match self.s_1288 with
               | Cc_bench_Notp_150 ->
                   (if self.r_1289 then ()) ;
                   self.ok_1282 <- q_true ;
                   self.local_t_1293 <- MyOp.(-) x_1291  self.t0_1285 ;
                   (begin match (((>) self.local_t_1293  (MyOp.make 30.)) ,
                                 (Discrete_obs_fad.isTrue p_1283) ,
                                 ((<=) self.local_t_1293  (MyOp.make 30.))) with
                          | (_ , true , true) ->
                              self.t1_1287 <- x_1291 ;
                              self.t0_1286 <- self.t0_1285 ;
                              self.r_1289 <- true ;
                              self.s_1288 <- Cc_bench_Okp_151
                          | (true , _ , _) ->
                              self.r_1289 <- true ;
                              self.s_1288 <- Cc_bench_Err_153
                          | _ -> self.r_1289 <- false  end)
               | Cc_bench_Okp_151 ->
                   (if self.r_1289 then ()) ;
                   self.ok_1282 <- q_true ;
                   self.local_t_1294 <- MyOp.(-) x_1291  self.t1_1287 ;
                   (begin match ((Discrete_obs_fad.isFalse p_1283) ,
                                 ((>=) self.local_t_1294  (MyOp.make 5.)) ,
                                 (Discrete_obs_fad.isTrue p_1283)) with
                          | (_ , true , true) ->
                              self.r_1289 <- true ;
                              self.s_1288 <- Cc_bench_Alwaysp_152
                          | (true , _ , _) ->
                              self.t0_1285 <- self.t0_1286 ;
                              self.r_1289 <- true ;
                              self.s_1288 <- Cc_bench_Notp_150
                          | _ -> self.r_1289 <- false  end)
               | Cc_bench_Alwaysp_152 ->
                   (if self.r_1289 then ()) ;
                   self.ok_1282 <- q_true ;
                   (begin match Discrete_obs_fad.isFalse p_1283 with
                          | true ->
                              self.t0_1285 <- MyOp.(-) x_1291  (MyOp.make 5.)
                              ;
                              self.r_1289 <- true ;
                              self.s_1288 <- Cc_bench_Notp_150
                          | _ -> self.r_1289 <- false  end)
               | Cc_bench_Err_153 ->
                   (if self.r_1289 then ()) ;
                   self.ok_1282 <- q_false ; self.r_1289 <- false
                end) ;
        self.m_1290 <- MyOp.(+) tstep_1281  x_1291 ; self.ok_1282))):
    MyOp.t) in
  Node { alloc = cc4_alloc; reset = cc4_reset ; step = cc4_step }
type ('e , 'd , 'c , 'b , 'a) _cc5 =
  { mutable i_2292 : 'e ;
    mutable i_2291 : 'd ;
    mutable i_1306 : 'c ;
    mutable m_1304 : 'b ; mutable sliding_window_1302 : 'a }

let cc5  = 
  let Node { alloc = i_2292_alloc; step = i_2292_step ; reset = i_2292_reset } = 
  Discrete_obs_fad.always_timed 100.  in 
  let Node { alloc = i_2291_alloc; step = i_2291_step ; reset = i_2291_reset } = 
  Discrete_obs_fad.bounded_recurrence 8.  in
  let cc5_alloc _ =
    ();
    { i_1306 = (false:bool) ;
      m_1304 = (create ():MyOp.t) ;
      sliding_window_1302 = (Obj.magic ():Cc_prop.state);
      i_2292 = i_2292_alloc () (* discrete *)  ;
      i_2291 = i_2291_alloc () (* discrete *)  } in
  let cc5_reset self  =
    ((self.i_1306 <- true ;
      i_2292_reset self.i_2292  ; i_2291_reset self.i_2291 ):unit) in 
  let cc5_step self ((tstep_1299:MyOp.t) ,
                     (c1_1295:MyOp.t) ,
                     (c2_1296:MyOp.t) , (c4_1297:MyOp.t) , (c5_1298:MyOp.t)) =
    (((if self.i_1306 then self.sliding_window_1302 <- Cc_prop.create ()) ;
      (if self.i_1306 then self.m_1304 <- MyOp.make 0.) ;
      self.i_1306 <- false ;
      (let (x_1305:MyOp.t) = self.m_1304 in
       let (impl_1300:MyOp.t) =
           Cc_prop.cc5_sliding_window self.sliding_window_1302 
                                      (x_1305 ,
                                       c1_1295 , c2_1296 , c4_1297 , c5_1298) in
       let (ok_1301:MyOp.t) =
           i_2292_step self.i_2292
             (tstep_1299 , (i_2291_step self.i_2291 (tstep_1299 , impl_1300))) in
       self.m_1304 <- MyOp.(+) tstep_1299  x_1305 ; ok_1301)):MyOp.t) in
  Node { alloc = cc5_alloc; reset = cc5_reset ; step = cc5_step }
type ('s1 ,
      'r1 ,
      'q1 ,
      'p1 ,
      'o1 ,
      'n1 ,
      'm1 ,
      'l1 ,
      'k1 ,
      'j1 ,
      'i1 ,
      'h1 ,
      'g1 ,
      'f1 ,
      'e1 ,
      'd1 ,
      'c1 ,
      'b1 ,
      'a1 ,
      'z ,
      'y ,
      'x ,
      'w ,
      'v ,
      'u ,
      't ,
      's ,
      'r ,
      'q ,
      'p ,
      'o ,
      'n , 'm , 'l , 'k , 'j , 'i , 'h , 'g , 'f , 'e , 'd , 'c , 'b , 'a) _cc_cc1 =
  { mutable i_2293 : 's1 ;
    mutable i_1494 : 'r1 ;
    mutable m_1492 : 'q1 ;
    mutable m_1490 : 'p1 ;
    mutable m_1488 : 'o1 ;
    mutable m_1485 : 'n1 ;
    mutable m_1483 : 'm1 ;
    mutable m_1481 : 'l1 ;
    mutable m_1478 : 'k1 ;
    mutable m_1476 : 'j1 ;
    mutable m_1474 : 'i1 ;
    mutable m_1471 : 'h1 ;
    mutable m_1469 : 'g1 ;
    mutable m_1467 : 'f1 ;
    mutable m_1464 : 'e1 ;
    mutable m_1462 : 'd1 ;
    mutable m_1460 : 'c1 ;
    mutable m_1457 : 'b1 ;
    mutable m_1455 : 'a1 ;
    mutable m_1453 : 'z ;
    mutable r_1434 : 'y ;
    mutable s_1433 : 'x ;
    mutable r_1432 : 'w ;
    mutable s_1431 : 'v ;
    mutable r_1430 : 'u ;
    mutable s_1429 : 't ;
    mutable r_1428 : 's ;
    mutable s_1427 : 'r ;
    mutable result_1425 : 'q ;
    mutable rob_1413 : 'p ;
    mutable dy_1412 : 'o ;
    mutable dv_1411 : 'n ;
    mutable rob_1395 : 'm ;
    mutable dy_1394 : 'l ;
    mutable dv_1393 : 'k ;
    mutable rob_1377 : 'j ;
    mutable dy_1376 : 'i ;
    mutable dv_1375 : 'h ;
    mutable rob_1359 : 'g ;
    mutable dy_1358 : 'f ;
    mutable dv_1357 : 'e ;
    mutable chase_1495 : 'd ;
    mutable chase_1496 : 'c ;
    mutable chase_1497 : 'b ; mutable chase_1498 : 'a }

let cc_cc1 (tstep_1308:float) = 
  let Node { alloc = i_2293_alloc; step = i_2293_step ; reset = i_2293_reset } = cc1 
   in
  let cc_cc1_alloc _ =
    ();
    { i_1494 = (false:bool) ;
      m_1492 = (42:int) ;
      m_1490 = (create ():MyOp.t) ;
      m_1488 = (create ():MyOp.t) ;
      m_1485 = (create ():MyOp.t) ;
      m_1483 = (create ():MyOp.t) ;
      m_1481 = (create ():MyOp.t) ;
      m_1478 = (create ():MyOp.t) ;
      m_1476 = (create ():MyOp.t) ;
      m_1474 = (create ():MyOp.t) ;
      m_1471 = (create ():MyOp.t) ;
      m_1469 = (create ():MyOp.t) ;
      m_1467 = (create ():MyOp.t) ;
      m_1464 = (create ():MyOp.t) ;
      m_1462 = (create ():MyOp.t) ;
      m_1460 = (create ():MyOp.t) ;
      m_1457 = (create ():MyOp.t) ;
      m_1455 = (create ():MyOp.t) ;
      m_1453 = (create ():MyOp.t) ;
      r_1434 = (false:bool) ;
      s_1433 = (Cc_bench_Braking_309:state__8758) ;
      r_1432 = (false:bool) ;
      s_1431 = (Cc_bench_Braking_286:state__8757) ;
      r_1430 = (false:bool) ;
      s_1429 = (Cc_bench_Braking_263:state__8756) ;
      r_1428 = (false:bool) ;
      s_1427 = (Cc_bench_Braking_240:state__8755) ;
      result_1425 = (42:int) ;
      rob_1413 = (create ():MyOp.t) ;
      dy_1412 = (create ():MyOp.t) ;
      dv_1411 = (create ():MyOp.t) ;
      rob_1395 = (create ():MyOp.t) ;
      dy_1394 = (create ():MyOp.t) ;
      dv_1393 = (create ():MyOp.t) ;
      rob_1377 = (create ():MyOp.t) ;
      dy_1376 = (create ():MyOp.t) ;
      dv_1375 = (create ():MyOp.t) ;
      rob_1359 = (create ():MyOp.t) ;
      dy_1358 = (create ():MyOp.t) ;
      dv_1357 = (create ():MyOp.t) ;
      chase_1495 = (false:bool) ;
      chase_1496 = (false:bool) ;
      chase_1497 = (false:bool) ; chase_1498 = (false:bool);
      i_2293 = i_2293_alloc () (* discrete *)  } in
  let cc_cc1_reset self  =
    ((self.i_1494 <- true ;
      i_2293_reset self.i_2293  ;
      self.r_1434 <- false ;
      self.s_1433 <- Cc_bench_Chasing_307 ;
      self.r_1432 <- false ;
      self.s_1431 <- Cc_bench_Chasing_284 ;
      self.r_1430 <- false ;
      self.s_1429 <- Cc_bench_Chasing_261 ;
      self.r_1428 <- false ; self.s_1427 <- Cc_bench_Chasing_238):unit) in 
  let cc_cc1_step self (inp_1307:(MyOp.t)Array.t) =
    ((let switchp_1452 = ref (false:bool) in
      let switchv_1451 = ref (():unit) in
      let switchp_1450 = ref (false:bool) in
      let switchv_1449 = ref (():unit) in
      let switchp_1448 = ref (false:bool) in
      let switchv_1447 = ref (():unit) in
      let switchp_1446 = ref (false:bool) in
      let switchv_1445 = ref (():unit) in
      (if self.i_1494 then self.m_1492 <- Stdlib.(+) (Random.int 4)  2) ;
      (let (x_1493:int) = self.m_1492 in
       (if self.i_1494 then self.result_1425 <- x_1493) ;
       (let (y0_1410:MyOp.t) = MyOp.make 40. in
        (if self.i_1494 then self.m_1490 <- y0_1410) ;
        (let (v0_1409:MyOp.t) = MyOp.make 0. in
         (if self.i_1494 then self.m_1488 <- v0_1409) ;
         (if self.i_1494 then self.m_1455 <- MyOp.make 0.) ;
         (let (x_1456:MyOp.t) = self.m_1455 in
          let (x_1487:MyOp.t) =
              if self.i_1494 then x_1456 else MyOp.(-) x_1456  self.m_1485 in
          let (y0_1392:MyOp.t) = MyOp.make 30. in
          (if self.i_1494 then self.m_1483 <- y0_1392) ;
          (let (v0_1391:MyOp.t) = MyOp.make 0. in
           (if self.i_1494 then self.m_1481 <- v0_1391) ;
           (let (x_1480:MyOp.t) =
                if self.i_1494 then x_1456 else MyOp.(-) x_1456  self.m_1478 in
            let (y0_1374:MyOp.t) = MyOp.make 20. in
            (if self.i_1494 then self.m_1476 <- y0_1374) ;
            (let (v0_1373:MyOp.t) = MyOp.make 0. in
             (if self.i_1494 then self.m_1474 <- v0_1373) ;
             (let (x_1473:MyOp.t) =
                  if self.i_1494
                  then x_1456
                  else MyOp.(-) x_1456  self.m_1471 in
              let (y0_1356:MyOp.t) = MyOp.make 10. in
              (if self.i_1494 then self.m_1469 <- y0_1356) ;
              (let (v0_1355:MyOp.t) = MyOp.make 0. in
               (if self.i_1494 then self.m_1467 <- v0_1355) ;
               (let (x_1466:MyOp.t) =
                    if self.i_1494
                    then x_1456
                    else MyOp.(-) x_1456  self.m_1464 in
                let (v0_1340:MyOp.t) = MyOp.make 0. in
                (if self.i_1494 then self.m_1462 <- v0_1340) ;
                (let (y0_1341:MyOp.t) = MyOp.make 0. in
                 (if self.i_1494 then self.m_1460 <- y0_1341) ;
                 (let (x_1459:MyOp.t) =
                      if self.i_1494
                      then x_1456
                      else MyOp.(-) x_1456  self.m_1457 in
                  let (tstep'_1322:MyOp.t) = MyOp.make tstep_1308 in
                  (if self.i_1494 then self.m_1453 <- tstep'_1322) ;
                  self.i_1494 <- false ;
                  (let (x_1484:MyOp.t) = self.m_1483 in
                   let (x_1491:MyOp.t) = self.m_1490 in
                   let (rob_spec_1319:MyOp.t) =
                       i_2293_step self.i_2293
                         (tstep'_1322 , x_1484 , x_1491) in
                   let (x_1489:MyOp.t) = self.m_1488 in
                   (begin match self.s_1433 with
                          | Cc_bench_Chasing_307 ->
                              (if self.r_1434 then ()) ;
                              self.rob_1413 <- MyOp.(-) (MyOp.(-) x_1491 
                                                                  x_1484) 
                                                        Cc_d.d2 ;
                              self.dy_1412 <- MyOp.(~-) x_1489 ;
                              self.dv_1411 <- MyOp.make 1. ;
                              (begin match (<=) (MyOp.(-) x_1491  x_1484) 
                                                Cc_d.d2 with
                                     | true ->
                                         switchp_1446 := true ;
                                         switchv_1445 := () ;
                                         self.r_1434 <- true ;
                                         self.s_1433 <- Cc_bench_Keeping_308
                                     | _ -> self.r_1434 <- false  end)
                          | Cc_bench_Keeping_308 ->
                              (if self.r_1434 then ()) ;
                              self.chase_1495 <- (>) (MyOp.make (Random.float 
                                                                   1.)) 
                                                     (MyOp.make 0.5) ;
                              self.rob_1413 <- (if self.chase_1495
                                                then
                                                  MyOp.(-) Cc_d.d1 
                                                           (MyOp.(-) 
                                                              x_1491  x_1484)
                                                else
                                                  MyOp.(-) (MyOp.(-) 
                                                              x_1491  x_1484)
                                                            Cc_d.d3) ;
                              self.dy_1412 <- x_1489 ;
                              self.dv_1411 <- MyOp.make 0. ;
                              (begin match (((<=) (MyOp.(-) x_1491  x_1484) 
                                                  Cc_d.d3) ,
                                            ((>=) (MyOp.(-) x_1491  x_1484) 
                                                  Cc_d.d1)) with
                                     | (_ , true) ->
                                         switchp_1446 := true ;
                                         switchv_1445 := () ;
                                         self.r_1434 <- true ;
                                         self.s_1433 <- Cc_bench_Chasing_307
                                     | (true , _) ->
                                         switchp_1446 := true ;
                                         switchv_1445 := () ;
                                         self.r_1434 <- true ;
                                         self.s_1433 <- Cc_bench_Braking_309
                                     | _ -> self.r_1434 <- false  end)
                          | Cc_bench_Braking_309 ->
                              (if self.r_1434 then ()) ;
                              self.rob_1413 <- MyOp.(-) Cc_d.d0 
                                                        (MyOp.(-) x_1491 
                                                                  x_1484) ;
                              self.dy_1412 <- MyOp.(~-) x_1489 ;
                              self.dv_1411 <- MyOp.(~-) x_1489 ;
                              (begin match (>=) (MyOp.(-) x_1491  x_1484) 
                                                Cc_d.d0 with
                                     | true ->
                                         switchp_1446 := true ;
                                         switchv_1445 := () ;
                                         self.r_1434 <- true ;
                                         self.s_1433 <- Cc_bench_Chasing_307
                                     | _ -> self.r_1434 <- false  end)
                           end) ;
                   (let (x_1477:MyOp.t) = self.m_1476 in
                    let (x_1482:MyOp.t) = self.m_1481 in
                    (begin match self.s_1431 with
                           | Cc_bench_Chasing_284 ->
                               (if self.r_1432 then ()) ;
                               self.rob_1395 <- MyOp.(-) (MyOp.(-) x_1484 
                                                                   x_1477) 
                                                         Cc_d.d2 ;
                               self.dy_1394 <- MyOp.(~-) x_1482 ;
                               self.dv_1393 <- MyOp.make 1. ;
                               (begin match (<=) (MyOp.(-) x_1484  x_1477) 
                                                 Cc_d.d2 with
                                      | true ->
                                          switchp_1448 := true ;
                                          switchv_1447 := () ;
                                          self.r_1432 <- true ;
                                          self.s_1431 <- Cc_bench_Keeping_285
                                      | _ -> self.r_1432 <- false  end)
                           | Cc_bench_Keeping_285 ->
                               (if self.r_1432 then ()) ;
                               self.chase_1496 <- (>) (MyOp.make (Random.float 
                                                                    1.)) 
                                                      (MyOp.make 0.5) ;
                               self.rob_1395 <- (if self.chase_1496
                                                 then
                                                   MyOp.(-) Cc_d.d1 
                                                            (MyOp.(-) 
                                                               x_1484  x_1477)
                                                 else
                                                   MyOp.(-) (MyOp.(-) 
                                                               x_1484  x_1477)
                                                             Cc_d.d3) ;
                               self.dy_1394 <- x_1482 ;
                               self.dv_1393 <- MyOp.make 0. ;
                               (begin match (((<=) (MyOp.(-) x_1484  x_1477) 
                                                   Cc_d.d3) ,
                                             ((>=) (MyOp.(-) x_1484  x_1477) 
                                                   Cc_d.d1)) with
                                      | (_ , true) ->
                                          switchp_1448 := true ;
                                          switchv_1447 := () ;
                                          self.r_1432 <- true ;
                                          self.s_1431 <- Cc_bench_Chasing_284
                                      | (true , _) ->
                                          switchp_1448 := true ;
                                          switchv_1447 := () ;
                                          self.r_1432 <- true ;
                                          self.s_1431 <- Cc_bench_Braking_286
                                      | _ -> self.r_1432 <- false  end)
                           | Cc_bench_Braking_286 ->
                               (if self.r_1432 then ()) ;
                               self.rob_1395 <- MyOp.(-) Cc_d.d0 
                                                         (MyOp.(-) x_1484 
                                                                   x_1477) ;
                               self.dy_1394 <- MyOp.(~-) x_1482 ;
                               self.dv_1393 <- MyOp.(~-) x_1482 ;
                               (begin match (>=) (MyOp.(-) x_1484  x_1477) 
                                                 Cc_d.d0 with
                                      | true ->
                                          switchp_1448 := true ;
                                          switchv_1447 := () ;
                                          self.r_1432 <- true ;
                                          self.s_1431 <- Cc_bench_Chasing_284
                                      | _ -> self.r_1432 <- false  end)
                            end) ;
                    (let (x_1470:MyOp.t) = self.m_1469 in
                     let (x_1475:MyOp.t) = self.m_1474 in
                     (begin match self.s_1429 with
                            | Cc_bench_Chasing_261 ->
                                (if self.r_1430 then ()) ;
                                self.rob_1377 <- MyOp.(-) (MyOp.(-) x_1477 
                                                                    x_1470) 
                                                          Cc_d.d2 ;
                                self.dy_1376 <- MyOp.(~-) x_1475 ;
                                self.dv_1375 <- MyOp.make 1. ;
                                (begin match (<=) (MyOp.(-) x_1477  x_1470) 
                                                  Cc_d.d2 with
                                       | true ->
                                           switchp_1450 := true ;
                                           switchv_1449 := () ;
                                           self.r_1430 <- true ;
                                           self.s_1429 <- Cc_bench_Keeping_262
                                       | _ -> self.r_1430 <- false  end)
                            | Cc_bench_Keeping_262 ->
                                (if self.r_1430 then ()) ;
                                self.chase_1497 <- (>) (MyOp.make (Random.float 
                                                                    1.)) 
                                                       (MyOp.make 0.5) ;
                                self.rob_1377 <- (if self.chase_1497
                                                  then
                                                    MyOp.(-) Cc_d.d1 
                                                             (MyOp.(-) 
                                                                x_1477 
                                                                x_1470)
                                                  else
                                                    MyOp.(-) (MyOp.(-) 
                                                                x_1477 
                                                                x_1470) 
                                                             Cc_d.d3) ;
                                self.dy_1376 <- x_1475 ;
                                self.dv_1375 <- MyOp.make 0. ;
                                (begin match (((<=) (MyOp.(-) x_1477  x_1470)
                                                     Cc_d.d3) ,
                                              ((>=) (MyOp.(-) x_1477  x_1470)
                                                     Cc_d.d1)) with
                                       | (_ , true) ->
                                           switchp_1450 := true ;
                                           switchv_1449 := () ;
                                           self.r_1430 <- true ;
                                           self.s_1429 <- Cc_bench_Chasing_261
                                       | (true , _) ->
                                           switchp_1450 := true ;
                                           switchv_1449 := () ;
                                           self.r_1430 <- true ;
                                           self.s_1429 <- Cc_bench_Braking_263
                                       | _ -> self.r_1430 <- false  end)
                            | Cc_bench_Braking_263 ->
                                (if self.r_1430 then ()) ;
                                self.rob_1377 <- MyOp.(-) Cc_d.d0 
                                                          (MyOp.(-) x_1477 
                                                                    x_1470) ;
                                self.dy_1376 <- MyOp.(~-) x_1475 ;
                                self.dv_1375 <- MyOp.(~-) x_1475 ;
                                (begin match (>=) (MyOp.(-) x_1477  x_1470) 
                                                  Cc_d.d0 with
                                       | true ->
                                           switchp_1450 := true ;
                                           switchv_1449 := () ;
                                           self.r_1430 <- true ;
                                           self.s_1429 <- Cc_bench_Chasing_261
                                       | _ -> self.r_1430 <- false  end)
                             end) ;
                     (let (x_1461:MyOp.t) = self.m_1460 in
                      let (x_1468:MyOp.t) = self.m_1467 in
                      (begin match self.s_1427 with
                             | Cc_bench_Chasing_238 ->
                                 (if self.r_1428 then ()) ;
                                 self.rob_1359 <- MyOp.(-) (MyOp.(-) 
                                                              x_1470  x_1461)
                                                            Cc_d.d2 ;
                                 self.dy_1358 <- MyOp.(~-) x_1468 ;
                                 self.dv_1357 <- MyOp.make 1. ;
                                 (begin match (<=) (MyOp.(-) x_1470  x_1461) 
                                                   Cc_d.d2 with
                                        | true ->
                                            switchp_1452 := true ;
                                            switchv_1451 := () ;
                                            self.r_1428 <- true ;
                                            self.s_1427 <- Cc_bench_Keeping_239
                                        | _ -> self.r_1428 <- false  end)
                             | Cc_bench_Keeping_239 ->
                                 (if self.r_1428 then ()) ;
                                 self.chase_1498 <- (>) (MyOp.make (Random.float 
                                                                    1.)) 
                                                        (MyOp.make 0.5) ;
                                 self.rob_1359 <- (if self.chase_1498
                                                   then
                                                     MyOp.(-) Cc_d.d1 
                                                              (MyOp.(-) 
                                                                 x_1470 
                                                                 x_1461)
                                                   else
                                                     MyOp.(-) (MyOp.(-) 
                                                                 x_1470 
                                                                 x_1461) 
                                                              Cc_d.d3) ;
                                 self.dy_1358 <- x_1468 ;
                                 self.dv_1357 <- MyOp.make 0. ;
                                 (begin match (((<=) (MyOp.(-) x_1470  x_1461)
                                                      Cc_d.d3) ,
                                               ((>=) (MyOp.(-) x_1470  x_1461)
                                                      Cc_d.d1)) with
                                        | (_ , true) ->
                                            switchp_1452 := true ;
                                            switchv_1451 := () ;
                                            self.r_1428 <- true ;
                                            self.s_1427 <- Cc_bench_Chasing_238
                                        | (true , _) ->
                                            switchp_1452 := true ;
                                            switchv_1451 := () ;
                                            self.r_1428 <- true ;
                                            self.s_1427 <- Cc_bench_Braking_240
                                        | _ -> self.r_1428 <- false  end)
                             | Cc_bench_Braking_240 ->
                                 (if self.r_1428 then ()) ;
                                 self.rob_1359 <- MyOp.(-) Cc_d.d0 
                                                           (MyOp.(-) 
                                                              x_1470  x_1461)
                                 ;
                                 self.dy_1358 <- MyOp.(~-) x_1468 ;
                                 self.dv_1357 <- MyOp.(~-) x_1468 ;
                                 (begin match (>=) (MyOp.(-) x_1470  x_1461) 
                                                   Cc_d.d0 with
                                        | true ->
                                            switchp_1452 := true ;
                                            switchv_1451 := () ;
                                            self.r_1428 <- true ;
                                            self.s_1427 <- Cc_bench_Chasing_238
                                        | _ -> self.r_1428 <- false  end)
                              end) ;
                      (let ((rob_trans_1336:MyOp.t) ,
                            ((switch_transv_1443:unit) , (copy_2282:bool))) =
                           if (=) (MyOp.integer x_1493)  (MyOp.integer 2)
                           then
                             (self.rob_1359 , (!switchv_1451 , !switchp_1452))
                           else
                             if (=) (MyOp.integer x_1493)  (MyOp.integer 3)
                             then
                               (self.rob_1377 ,
                                (!switchv_1449 , !switchp_1450))
                             else
                               if (=) (MyOp.integer x_1493)  (MyOp.integer 4)
                               then
                                 (self.rob_1395 ,
                                  (!switchv_1447 , !switchp_1448))
                               else
                                 (self.rob_1413 ,
                                  (!switchv_1445 , !switchp_1446)) in
                       let (rob_1317:MyOp.t) =
                           if Discrete_obs_fad.isFalse rob_spec_1319
                           then rob_spec_1319
                           else
                             if Discrete_obs_fad.isTrue rob_trans_1336
                             then rob_trans_1336
                             else rob_spec_1319 in
                       let (outp_1316:(MyOp.t)Array.t) =
                           Array.of_list ((::) (x_1461 ,
                                                ((::) (x_1470 ,
                                                       ((::) (x_1477 ,
                                                              ((::) (
                                                                    x_1484 ,
                                                                    (
                                                                    (::) 
                                                                    (
                                                                    x_1491 ,
                                                                    ([]))))))))))) in
                       (begin match (switch_transv_1443 , copy_2282) with
                              | (() , true) ->
                                  self.result_1425 <- Stdlib.(+) (Random.int 
                                                                    4)  
                                                                 2 | _ -> ()  end)
                       ;
                       self.m_1492 <- self.result_1425 ;
                       self.m_1490 <- MyOp.(+) x_1491 
                                               (MyOp.( * ) x_1487 
                                                           self.dy_1412) ;
                       self.m_1488 <- MyOp.(+) x_1489 
                                               (MyOp.( * ) x_1487 
                                                           self.dv_1411) ;
                       self.m_1485 <- x_1456 ;
                       self.m_1483 <- MyOp.(+) x_1484 
                                               (MyOp.( * ) x_1480 
                                                           self.dy_1394) ;
                       self.m_1481 <- MyOp.(+) x_1482 
                                               (MyOp.( * ) x_1480 
                                                           self.dv_1393) ;
                       self.m_1478 <- x_1456 ;
                       self.m_1476 <- MyOp.(+) x_1477 
                                               (MyOp.( * ) x_1473 
                                                           self.dy_1376) ;
                       self.m_1474 <- MyOp.(+) x_1475 
                                               (MyOp.( * ) x_1473 
                                                           self.dv_1375) ;
                       self.m_1471 <- x_1456 ;
                       self.m_1469 <- MyOp.(+) x_1470 
                                               (MyOp.( * ) x_1466 
                                                           self.dy_1358) ;
                       self.m_1467 <- MyOp.(+) x_1468 
                                               (MyOp.( * ) x_1466 
                                                           self.dv_1357) ;
                       self.m_1464 <- x_1456 ;
                       (let (throttle_1321:MyOp.t) = Array.get inp_1307  0 in
                        let (brake_1309:MyOp.t) = Array.get inp_1307  1 in
                        let (x_1463:MyOp.t) = self.m_1462 in
                        let (x_1350:MyOp.t) =
                            MyOp.(-) (MyOp.(~-) throttle_1321) 
                                     (MyOp.( * ) brake_1309  x_1463) in
                        self.m_1462 <- MyOp.(+) x_1463 
                                                (MyOp.( * ) x_1459  x_1350) ;
                        self.m_1460 <- MyOp.(+) x_1461 
                                                (MyOp.( * ) x_1459  x_1463) ;
                        self.m_1457 <- x_1456 ;
                        (let (x_1454:MyOp.t) = self.m_1453 in
                         self.m_1455 <- x_1454 ;
                         self.m_1453 <- MyOp.(+) x_1454  tstep'_1322 ;
                         ((MyOp.get x_1454) ,
                          outp_1316 , (MyOp.translate rob_1317  1.)))))))))))))))))))))):
    float * MyOp.t Array.t * MyOp.t) in
  Node { alloc = cc_cc1_alloc; reset = cc_cc1_reset ; step = cc_cc1_step }
type ('s1 ,
      'r1 ,
      'q1 ,
      'p1 ,
      'o1 ,
      'n1 ,
      'm1 ,
      'l1 ,
      'k1 ,
      'j1 ,
      'i1 ,
      'h1 ,
      'g1 ,
      'f1 ,
      'e1 ,
      'd1 ,
      'c1 ,
      'b1 ,
      'a1 ,
      'z ,
      'y ,
      'x ,
      'w ,
      'v ,
      'u ,
      't ,
      's ,
      'r ,
      'q ,
      'p ,
      'o ,
      'n , 'm , 'l , 'k , 'j , 'i , 'h , 'g , 'f , 'e , 'd , 'c , 'b , 'a) _cc_cc2 =
  { mutable i_2294 : 's1 ;
    mutable i_1686 : 'r1 ;
    mutable m_1684 : 'q1 ;
    mutable m_1682 : 'p1 ;
    mutable m_1680 : 'o1 ;
    mutable m_1677 : 'n1 ;
    mutable m_1675 : 'm1 ;
    mutable m_1673 : 'l1 ;
    mutable m_1670 : 'k1 ;
    mutable m_1668 : 'j1 ;
    mutable m_1666 : 'i1 ;
    mutable m_1663 : 'h1 ;
    mutable m_1661 : 'g1 ;
    mutable m_1659 : 'f1 ;
    mutable m_1656 : 'e1 ;
    mutable m_1654 : 'd1 ;
    mutable m_1652 : 'c1 ;
    mutable m_1649 : 'b1 ;
    mutable m_1647 : 'a1 ;
    mutable m_1645 : 'z ;
    mutable r_1626 : 'y ;
    mutable s_1625 : 'x ;
    mutable r_1624 : 'w ;
    mutable s_1623 : 'v ;
    mutable r_1622 : 'u ;
    mutable s_1621 : 't ;
    mutable r_1620 : 's ;
    mutable s_1619 : 'r ;
    mutable result_1617 : 'q ;
    mutable rob_1605 : 'p ;
    mutable dy_1604 : 'o ;
    mutable dv_1603 : 'n ;
    mutable rob_1587 : 'm ;
    mutable dy_1586 : 'l ;
    mutable dv_1585 : 'k ;
    mutable rob_1569 : 'j ;
    mutable dy_1568 : 'i ;
    mutable dv_1567 : 'h ;
    mutable rob_1551 : 'g ;
    mutable dy_1550 : 'f ;
    mutable dv_1549 : 'e ;
    mutable chase_1687 : 'd ;
    mutable chase_1688 : 'c ;
    mutable chase_1689 : 'b ; mutable chase_1690 : 'a }

let cc_cc2 (tstep_1500:float) = 
  let Node { alloc = i_2294_alloc; step = i_2294_step ; reset = i_2294_reset } = cc2 
   in
  let cc_cc2_alloc _ =
    ();
    { i_1686 = (false:bool) ;
      m_1684 = (42:int) ;
      m_1682 = (create ():MyOp.t) ;
      m_1680 = (create ():MyOp.t) ;
      m_1677 = (create ():MyOp.t) ;
      m_1675 = (create ():MyOp.t) ;
      m_1673 = (create ():MyOp.t) ;
      m_1670 = (create ():MyOp.t) ;
      m_1668 = (create ():MyOp.t) ;
      m_1666 = (create ():MyOp.t) ;
      m_1663 = (create ():MyOp.t) ;
      m_1661 = (create ():MyOp.t) ;
      m_1659 = (create ():MyOp.t) ;
      m_1656 = (create ():MyOp.t) ;
      m_1654 = (create ():MyOp.t) ;
      m_1652 = (create ():MyOp.t) ;
      m_1649 = (create ():MyOp.t) ;
      m_1647 = (create ():MyOp.t) ;
      m_1645 = (create ():MyOp.t) ;
      r_1626 = (false:bool) ;
      s_1625 = (Cc_bench_Braking_453:state__8762) ;
      r_1624 = (false:bool) ;
      s_1623 = (Cc_bench_Braking_430:state__8761) ;
      r_1622 = (false:bool) ;
      s_1621 = (Cc_bench_Braking_407:state__8760) ;
      r_1620 = (false:bool) ;
      s_1619 = (Cc_bench_Braking_384:state__8759) ;
      result_1617 = (42:int) ;
      rob_1605 = (create ():MyOp.t) ;
      dy_1604 = (create ():MyOp.t) ;
      dv_1603 = (create ():MyOp.t) ;
      rob_1587 = (create ():MyOp.t) ;
      dy_1586 = (create ():MyOp.t) ;
      dv_1585 = (create ():MyOp.t) ;
      rob_1569 = (create ():MyOp.t) ;
      dy_1568 = (create ():MyOp.t) ;
      dv_1567 = (create ():MyOp.t) ;
      rob_1551 = (create ():MyOp.t) ;
      dy_1550 = (create ():MyOp.t) ;
      dv_1549 = (create ():MyOp.t) ;
      chase_1687 = (false:bool) ;
      chase_1688 = (false:bool) ;
      chase_1689 = (false:bool) ; chase_1690 = (false:bool);
      i_2294 = i_2294_alloc () (* discrete *)  } in
  let cc_cc2_reset self  =
    ((self.i_1686 <- true ;
      i_2294_reset self.i_2294  ;
      self.r_1626 <- false ;
      self.s_1625 <- Cc_bench_Chasing_451 ;
      self.r_1624 <- false ;
      self.s_1623 <- Cc_bench_Chasing_428 ;
      self.r_1622 <- false ;
      self.s_1621 <- Cc_bench_Chasing_405 ;
      self.r_1620 <- false ; self.s_1619 <- Cc_bench_Chasing_382):unit) in 
  let cc_cc2_step self (inp_1499:(MyOp.t)Array.t) =
    ((let switchp_1644 = ref (false:bool) in
      let switchv_1643 = ref (():unit) in
      let switchp_1642 = ref (false:bool) in
      let switchv_1641 = ref (():unit) in
      let switchp_1640 = ref (false:bool) in
      let switchv_1639 = ref (():unit) in
      let switchp_1638 = ref (false:bool) in
      let switchv_1637 = ref (():unit) in
      (if self.i_1686 then self.m_1684 <- Stdlib.(+) (Random.int 4)  2) ;
      (let (x_1685:int) = self.m_1684 in
       (if self.i_1686 then self.result_1617 <- x_1685) ;
       (let (y0_1602:MyOp.t) = MyOp.make 40. in
        (if self.i_1686 then self.m_1682 <- y0_1602) ;
        (let (v0_1601:MyOp.t) = MyOp.make 0. in
         (if self.i_1686 then self.m_1680 <- v0_1601) ;
         (if self.i_1686 then self.m_1647 <- MyOp.make 0.) ;
         (let (x_1648:MyOp.t) = self.m_1647 in
          let (x_1679:MyOp.t) =
              if self.i_1686 then x_1648 else MyOp.(-) x_1648  self.m_1677 in
          let (y0_1584:MyOp.t) = MyOp.make 30. in
          (if self.i_1686 then self.m_1675 <- y0_1584) ;
          (let (v0_1583:MyOp.t) = MyOp.make 0. in
           (if self.i_1686 then self.m_1673 <- v0_1583) ;
           (let (x_1672:MyOp.t) =
                if self.i_1686 then x_1648 else MyOp.(-) x_1648  self.m_1670 in
            let (y0_1566:MyOp.t) = MyOp.make 20. in
            (if self.i_1686 then self.m_1668 <- y0_1566) ;
            (let (v0_1565:MyOp.t) = MyOp.make 0. in
             (if self.i_1686 then self.m_1666 <- v0_1565) ;
             (let (x_1665:MyOp.t) =
                  if self.i_1686
                  then x_1648
                  else MyOp.(-) x_1648  self.m_1663 in
              let (y0_1548:MyOp.t) = MyOp.make 10. in
              (if self.i_1686 then self.m_1661 <- y0_1548) ;
              (let (v0_1547:MyOp.t) = MyOp.make 0. in
               (if self.i_1686 then self.m_1659 <- v0_1547) ;
               (let (x_1658:MyOp.t) =
                    if self.i_1686
                    then x_1648
                    else MyOp.(-) x_1648  self.m_1656 in
                let (v0_1532:MyOp.t) = MyOp.make 0. in
                (if self.i_1686 then self.m_1654 <- v0_1532) ;
                (let (y0_1533:MyOp.t) = MyOp.make 0. in
                 (if self.i_1686 then self.m_1652 <- y0_1533) ;
                 (let (x_1651:MyOp.t) =
                      if self.i_1686
                      then x_1648
                      else MyOp.(-) x_1648  self.m_1649 in
                  let (tstep'_1514:MyOp.t) = MyOp.make tstep_1500 in
                  (if self.i_1686 then self.m_1645 <- tstep'_1514) ;
                  self.i_1686 <- false ;
                  (let (x_1676:MyOp.t) = self.m_1675 in
                   let (x_1683:MyOp.t) = self.m_1682 in
                   let (rob_spec_1511:MyOp.t) =
                       i_2294_step self.i_2294
                         (tstep'_1514 , x_1676 , x_1683) in
                   let (x_1681:MyOp.t) = self.m_1680 in
                   (begin match self.s_1625 with
                          | Cc_bench_Chasing_451 ->
                              (if self.r_1626 then ()) ;
                              self.rob_1605 <- MyOp.(-) (MyOp.(-) x_1683 
                                                                  x_1676) 
                                                        Cc_d.d2 ;
                              self.dy_1604 <- MyOp.(~-) x_1681 ;
                              self.dv_1603 <- MyOp.make 1. ;
                              (begin match (<=) (MyOp.(-) x_1683  x_1676) 
                                                Cc_d.d2 with
                                     | true ->
                                         switchp_1638 := true ;
                                         switchv_1637 := () ;
                                         self.r_1626 <- true ;
                                         self.s_1625 <- Cc_bench_Keeping_452
                                     | _ -> self.r_1626 <- false  end)
                          | Cc_bench_Keeping_452 ->
                              (if self.r_1626 then ()) ;
                              self.chase_1687 <- (>) (MyOp.make (Random.float 
                                                                   1.)) 
                                                     (MyOp.make 0.5) ;
                              self.rob_1605 <- (if self.chase_1687
                                                then
                                                  MyOp.(-) Cc_d.d1 
                                                           (MyOp.(-) 
                                                              x_1683  x_1676)
                                                else
                                                  MyOp.(-) (MyOp.(-) 
                                                              x_1683  x_1676)
                                                            Cc_d.d3) ;
                              self.dy_1604 <- x_1681 ;
                              self.dv_1603 <- MyOp.make 0. ;
                              (begin match (((<=) (MyOp.(-) x_1683  x_1676) 
                                                  Cc_d.d3) ,
                                            ((>=) (MyOp.(-) x_1683  x_1676) 
                                                  Cc_d.d1)) with
                                     | (_ , true) ->
                                         switchp_1638 := true ;
                                         switchv_1637 := () ;
                                         self.r_1626 <- true ;
                                         self.s_1625 <- Cc_bench_Chasing_451
                                     | (true , _) ->
                                         switchp_1638 := true ;
                                         switchv_1637 := () ;
                                         self.r_1626 <- true ;
                                         self.s_1625 <- Cc_bench_Braking_453
                                     | _ -> self.r_1626 <- false  end)
                          | Cc_bench_Braking_453 ->
                              (if self.r_1626 then ()) ;
                              self.rob_1605 <- MyOp.(-) Cc_d.d0 
                                                        (MyOp.(-) x_1683 
                                                                  x_1676) ;
                              self.dy_1604 <- MyOp.(~-) x_1681 ;
                              self.dv_1603 <- MyOp.(~-) x_1681 ;
                              (begin match (>=) (MyOp.(-) x_1683  x_1676) 
                                                Cc_d.d0 with
                                     | true ->
                                         switchp_1638 := true ;
                                         switchv_1637 := () ;
                                         self.r_1626 <- true ;
                                         self.s_1625 <- Cc_bench_Chasing_451
                                     | _ -> self.r_1626 <- false  end)
                           end) ;
                   (let (x_1669:MyOp.t) = self.m_1668 in
                    let (x_1674:MyOp.t) = self.m_1673 in
                    (begin match self.s_1623 with
                           | Cc_bench_Chasing_428 ->
                               (if self.r_1624 then ()) ;
                               self.rob_1587 <- MyOp.(-) (MyOp.(-) x_1676 
                                                                   x_1669) 
                                                         Cc_d.d2 ;
                               self.dy_1586 <- MyOp.(~-) x_1674 ;
                               self.dv_1585 <- MyOp.make 1. ;
                               (begin match (<=) (MyOp.(-) x_1676  x_1669) 
                                                 Cc_d.d2 with
                                      | true ->
                                          switchp_1640 := true ;
                                          switchv_1639 := () ;
                                          self.r_1624 <- true ;
                                          self.s_1623 <- Cc_bench_Keeping_429
                                      | _ -> self.r_1624 <- false  end)
                           | Cc_bench_Keeping_429 ->
                               (if self.r_1624 then ()) ;
                               self.chase_1688 <- (>) (MyOp.make (Random.float 
                                                                    1.)) 
                                                      (MyOp.make 0.5) ;
                               self.rob_1587 <- (if self.chase_1688
                                                 then
                                                   MyOp.(-) Cc_d.d1 
                                                            (MyOp.(-) 
                                                               x_1676  x_1669)
                                                 else
                                                   MyOp.(-) (MyOp.(-) 
                                                               x_1676  x_1669)
                                                             Cc_d.d3) ;
                               self.dy_1586 <- x_1674 ;
                               self.dv_1585 <- MyOp.make 0. ;
                               (begin match (((<=) (MyOp.(-) x_1676  x_1669) 
                                                   Cc_d.d3) ,
                                             ((>=) (MyOp.(-) x_1676  x_1669) 
                                                   Cc_d.d1)) with
                                      | (_ , true) ->
                                          switchp_1640 := true ;
                                          switchv_1639 := () ;
                                          self.r_1624 <- true ;
                                          self.s_1623 <- Cc_bench_Chasing_428
                                      | (true , _) ->
                                          switchp_1640 := true ;
                                          switchv_1639 := () ;
                                          self.r_1624 <- true ;
                                          self.s_1623 <- Cc_bench_Braking_430
                                      | _ -> self.r_1624 <- false  end)
                           | Cc_bench_Braking_430 ->
                               (if self.r_1624 then ()) ;
                               self.rob_1587 <- MyOp.(-) Cc_d.d0 
                                                         (MyOp.(-) x_1676 
                                                                   x_1669) ;
                               self.dy_1586 <- MyOp.(~-) x_1674 ;
                               self.dv_1585 <- MyOp.(~-) x_1674 ;
                               (begin match (>=) (MyOp.(-) x_1676  x_1669) 
                                                 Cc_d.d0 with
                                      | true ->
                                          switchp_1640 := true ;
                                          switchv_1639 := () ;
                                          self.r_1624 <- true ;
                                          self.s_1623 <- Cc_bench_Chasing_428
                                      | _ -> self.r_1624 <- false  end)
                            end) ;
                    (let (x_1662:MyOp.t) = self.m_1661 in
                     let (x_1667:MyOp.t) = self.m_1666 in
                     (begin match self.s_1621 with
                            | Cc_bench_Chasing_405 ->
                                (if self.r_1622 then ()) ;
                                self.rob_1569 <- MyOp.(-) (MyOp.(-) x_1669 
                                                                    x_1662) 
                                                          Cc_d.d2 ;
                                self.dy_1568 <- MyOp.(~-) x_1667 ;
                                self.dv_1567 <- MyOp.make 1. ;
                                (begin match (<=) (MyOp.(-) x_1669  x_1662) 
                                                  Cc_d.d2 with
                                       | true ->
                                           switchp_1642 := true ;
                                           switchv_1641 := () ;
                                           self.r_1622 <- true ;
                                           self.s_1621 <- Cc_bench_Keeping_406
                                       | _ -> self.r_1622 <- false  end)
                            | Cc_bench_Keeping_406 ->
                                (if self.r_1622 then ()) ;
                                self.chase_1689 <- (>) (MyOp.make (Random.float 
                                                                    1.)) 
                                                       (MyOp.make 0.5) ;
                                self.rob_1569 <- (if self.chase_1689
                                                  then
                                                    MyOp.(-) Cc_d.d1 
                                                             (MyOp.(-) 
                                                                x_1669 
                                                                x_1662)
                                                  else
                                                    MyOp.(-) (MyOp.(-) 
                                                                x_1669 
                                                                x_1662) 
                                                             Cc_d.d3) ;
                                self.dy_1568 <- x_1667 ;
                                self.dv_1567 <- MyOp.make 0. ;
                                (begin match (((<=) (MyOp.(-) x_1669  x_1662)
                                                     Cc_d.d3) ,
                                              ((>=) (MyOp.(-) x_1669  x_1662)
                                                     Cc_d.d1)) with
                                       | (_ , true) ->
                                           switchp_1642 := true ;
                                           switchv_1641 := () ;
                                           self.r_1622 <- true ;
                                           self.s_1621 <- Cc_bench_Chasing_405
                                       | (true , _) ->
                                           switchp_1642 := true ;
                                           switchv_1641 := () ;
                                           self.r_1622 <- true ;
                                           self.s_1621 <- Cc_bench_Braking_407
                                       | _ -> self.r_1622 <- false  end)
                            | Cc_bench_Braking_407 ->
                                (if self.r_1622 then ()) ;
                                self.rob_1569 <- MyOp.(-) Cc_d.d0 
                                                          (MyOp.(-) x_1669 
                                                                    x_1662) ;
                                self.dy_1568 <- MyOp.(~-) x_1667 ;
                                self.dv_1567 <- MyOp.(~-) x_1667 ;
                                (begin match (>=) (MyOp.(-) x_1669  x_1662) 
                                                  Cc_d.d0 with
                                       | true ->
                                           switchp_1642 := true ;
                                           switchv_1641 := () ;
                                           self.r_1622 <- true ;
                                           self.s_1621 <- Cc_bench_Chasing_405
                                       | _ -> self.r_1622 <- false  end)
                             end) ;
                     (let (x_1653:MyOp.t) = self.m_1652 in
                      let (x_1660:MyOp.t) = self.m_1659 in
                      (begin match self.s_1619 with
                             | Cc_bench_Chasing_382 ->
                                 (if self.r_1620 then ()) ;
                                 self.rob_1551 <- MyOp.(-) (MyOp.(-) 
                                                              x_1662  x_1653)
                                                            Cc_d.d2 ;
                                 self.dy_1550 <- MyOp.(~-) x_1660 ;
                                 self.dv_1549 <- MyOp.make 1. ;
                                 (begin match (<=) (MyOp.(-) x_1662  x_1653) 
                                                   Cc_d.d2 with
                                        | true ->
                                            switchp_1644 := true ;
                                            switchv_1643 := () ;
                                            self.r_1620 <- true ;
                                            self.s_1619 <- Cc_bench_Keeping_383
                                        | _ -> self.r_1620 <- false  end)
                             | Cc_bench_Keeping_383 ->
                                 (if self.r_1620 then ()) ;
                                 self.chase_1690 <- (>) (MyOp.make (Random.float 
                                                                    1.)) 
                                                        (MyOp.make 0.5) ;
                                 self.rob_1551 <- (if self.chase_1690
                                                   then
                                                     MyOp.(-) Cc_d.d1 
                                                              (MyOp.(-) 
                                                                 x_1662 
                                                                 x_1653)
                                                   else
                                                     MyOp.(-) (MyOp.(-) 
                                                                 x_1662 
                                                                 x_1653) 
                                                              Cc_d.d3) ;
                                 self.dy_1550 <- x_1660 ;
                                 self.dv_1549 <- MyOp.make 0. ;
                                 (begin match (((<=) (MyOp.(-) x_1662  x_1653)
                                                      Cc_d.d3) ,
                                               ((>=) (MyOp.(-) x_1662  x_1653)
                                                      Cc_d.d1)) with
                                        | (_ , true) ->
                                            switchp_1644 := true ;
                                            switchv_1643 := () ;
                                            self.r_1620 <- true ;
                                            self.s_1619 <- Cc_bench_Chasing_382
                                        | (true , _) ->
                                            switchp_1644 := true ;
                                            switchv_1643 := () ;
                                            self.r_1620 <- true ;
                                            self.s_1619 <- Cc_bench_Braking_384
                                        | _ -> self.r_1620 <- false  end)
                             | Cc_bench_Braking_384 ->
                                 (if self.r_1620 then ()) ;
                                 self.rob_1551 <- MyOp.(-) Cc_d.d0 
                                                           (MyOp.(-) 
                                                              x_1662  x_1653)
                                 ;
                                 self.dy_1550 <- MyOp.(~-) x_1660 ;
                                 self.dv_1549 <- MyOp.(~-) x_1660 ;
                                 (begin match (>=) (MyOp.(-) x_1662  x_1653) 
                                                   Cc_d.d0 with
                                        | true ->
                                            switchp_1644 := true ;
                                            switchv_1643 := () ;
                                            self.r_1620 <- true ;
                                            self.s_1619 <- Cc_bench_Chasing_382
                                        | _ -> self.r_1620 <- false  end)
                              end) ;
                      (let ((rob_trans_1528:MyOp.t) ,
                            ((switch_transv_1635:unit) , (copy_2283:bool))) =
                           if (=) (MyOp.integer x_1685)  (MyOp.integer 2)
                           then
                             (self.rob_1551 , (!switchv_1643 , !switchp_1644))
                           else
                             if (=) (MyOp.integer x_1685)  (MyOp.integer 3)
                             then
                               (self.rob_1569 ,
                                (!switchv_1641 , !switchp_1642))
                             else
                               if (=) (MyOp.integer x_1685)  (MyOp.integer 4)
                               then
                                 (self.rob_1587 ,
                                  (!switchv_1639 , !switchp_1640))
                               else
                                 (self.rob_1605 ,
                                  (!switchv_1637 , !switchp_1638)) in
                       let (rob_1509:MyOp.t) =
                           if Discrete_obs_fad.isFalse rob_spec_1511
                           then rob_spec_1511
                           else
                             if Discrete_obs_fad.isTrue rob_trans_1528
                             then rob_trans_1528
                             else rob_spec_1511 in
                       let (outp_1508:(MyOp.t)Array.t) =
                           Array.of_list ((::) (x_1653 ,
                                                ((::) (x_1662 ,
                                                       ((::) (x_1669 ,
                                                              ((::) (
                                                                    x_1676 ,
                                                                    (
                                                                    (::) 
                                                                    (
                                                                    x_1683 ,
                                                                    ([]))))))))))) in
                       (begin match (switch_transv_1635 , copy_2283) with
                              | (() , true) ->
                                  self.result_1617 <- Stdlib.(+) (Random.int 
                                                                    4)  
                                                                 2 | _ -> ()  end)
                       ;
                       self.m_1684 <- self.result_1617 ;
                       self.m_1682 <- MyOp.(+) x_1683 
                                               (MyOp.( * ) x_1679 
                                                           self.dy_1604) ;
                       self.m_1680 <- MyOp.(+) x_1681 
                                               (MyOp.( * ) x_1679 
                                                           self.dv_1603) ;
                       self.m_1677 <- x_1648 ;
                       self.m_1675 <- MyOp.(+) x_1676 
                                               (MyOp.( * ) x_1672 
                                                           self.dy_1586) ;
                       self.m_1673 <- MyOp.(+) x_1674 
                                               (MyOp.( * ) x_1672 
                                                           self.dv_1585) ;
                       self.m_1670 <- x_1648 ;
                       self.m_1668 <- MyOp.(+) x_1669 
                                               (MyOp.( * ) x_1665 
                                                           self.dy_1568) ;
                       self.m_1666 <- MyOp.(+) x_1667 
                                               (MyOp.( * ) x_1665 
                                                           self.dv_1567) ;
                       self.m_1663 <- x_1648 ;
                       self.m_1661 <- MyOp.(+) x_1662 
                                               (MyOp.( * ) x_1658 
                                                           self.dy_1550) ;
                       self.m_1659 <- MyOp.(+) x_1660 
                                               (MyOp.( * ) x_1658 
                                                           self.dv_1549) ;
                       self.m_1656 <- x_1648 ;
                       (let (throttle_1513:MyOp.t) = Array.get inp_1499  0 in
                        let (brake_1501:MyOp.t) = Array.get inp_1499  1 in
                        let (x_1655:MyOp.t) = self.m_1654 in
                        let (x_1542:MyOp.t) =
                            MyOp.(-) (MyOp.(~-) throttle_1513) 
                                     (MyOp.( * ) brake_1501  x_1655) in
                        self.m_1654 <- MyOp.(+) x_1655 
                                                (MyOp.( * ) x_1651  x_1542) ;
                        self.m_1652 <- MyOp.(+) x_1653 
                                                (MyOp.( * ) x_1651  x_1655) ;
                        self.m_1649 <- x_1648 ;
                        (let (x_1646:MyOp.t) = self.m_1645 in
                         self.m_1647 <- x_1646 ;
                         self.m_1645 <- MyOp.(+) x_1646  tstep'_1514 ;
                         ((MyOp.get x_1646) , outp_1508 , rob_1509))))))))))))))))))))):
    float * MyOp.t Array.t * MyOp.t) in
  Node { alloc = cc_cc2_alloc; reset = cc_cc2_reset ; step = cc_cc2_step }
type ('s1 ,
      'r1 ,
      'q1 ,
      'p1 ,
      'o1 ,
      'n1 ,
      'm1 ,
      'l1 ,
      'k1 ,
      'j1 ,
      'i1 ,
      'h1 ,
      'g1 ,
      'f1 ,
      'e1 ,
      'd1 ,
      'c1 ,
      'b1 ,
      'a1 ,
      'z ,
      'y ,
      'x ,
      'w ,
      'v ,
      'u ,
      't ,
      's ,
      'r ,
      'q ,
      'p ,
      'o ,
      'n , 'm , 'l , 'k , 'j , 'i , 'h , 'g , 'f , 'e , 'd , 'c , 'b , 'a) _cc_cc3 =
  { mutable i_2295 : 's1 ;
    mutable i_1878 : 'r1 ;
    mutable m_1876 : 'q1 ;
    mutable m_1874 : 'p1 ;
    mutable m_1872 : 'o1 ;
    mutable m_1869 : 'n1 ;
    mutable m_1867 : 'm1 ;
    mutable m_1865 : 'l1 ;
    mutable m_1862 : 'k1 ;
    mutable m_1860 : 'j1 ;
    mutable m_1858 : 'i1 ;
    mutable m_1855 : 'h1 ;
    mutable m_1853 : 'g1 ;
    mutable m_1851 : 'f1 ;
    mutable m_1848 : 'e1 ;
    mutable m_1846 : 'd1 ;
    mutable m_1844 : 'c1 ;
    mutable m_1841 : 'b1 ;
    mutable m_1839 : 'a1 ;
    mutable m_1837 : 'z ;
    mutable r_1818 : 'y ;
    mutable s_1817 : 'x ;
    mutable r_1816 : 'w ;
    mutable s_1815 : 'v ;
    mutable r_1814 : 'u ;
    mutable s_1813 : 't ;
    mutable r_1812 : 's ;
    mutable s_1811 : 'r ;
    mutable result_1809 : 'q ;
    mutable rob_1797 : 'p ;
    mutable dy_1796 : 'o ;
    mutable dv_1795 : 'n ;
    mutable rob_1779 : 'm ;
    mutable dy_1778 : 'l ;
    mutable dv_1777 : 'k ;
    mutable rob_1761 : 'j ;
    mutable dy_1760 : 'i ;
    mutable dv_1759 : 'h ;
    mutable rob_1743 : 'g ;
    mutable dy_1742 : 'f ;
    mutable dv_1741 : 'e ;
    mutable chase_1879 : 'd ;
    mutable chase_1880 : 'c ;
    mutable chase_1881 : 'b ; mutable chase_1882 : 'a }

let cc_cc3 (tstep_1692:float) = 
  let Node { alloc = i_2295_alloc; step = i_2295_step ; reset = i_2295_reset } = cc3 
   in
  let cc_cc3_alloc _ =
    ();
    { i_1878 = (false:bool) ;
      m_1876 = (42:int) ;
      m_1874 = (create ():MyOp.t) ;
      m_1872 = (create ():MyOp.t) ;
      m_1869 = (create ():MyOp.t) ;
      m_1867 = (create ():MyOp.t) ;
      m_1865 = (create ():MyOp.t) ;
      m_1862 = (create ():MyOp.t) ;
      m_1860 = (create ():MyOp.t) ;
      m_1858 = (create ():MyOp.t) ;
      m_1855 = (create ():MyOp.t) ;
      m_1853 = (create ():MyOp.t) ;
      m_1851 = (create ():MyOp.t) ;
      m_1848 = (create ():MyOp.t) ;
      m_1846 = (create ():MyOp.t) ;
      m_1844 = (create ():MyOp.t) ;
      m_1841 = (create ():MyOp.t) ;
      m_1839 = (create ():MyOp.t) ;
      m_1837 = (create ():MyOp.t) ;
      r_1818 = (false:bool) ;
      s_1817 = (Cc_bench_Braking_597:state__8766) ;
      r_1816 = (false:bool) ;
      s_1815 = (Cc_bench_Braking_574:state__8765) ;
      r_1814 = (false:bool) ;
      s_1813 = (Cc_bench_Braking_551:state__8764) ;
      r_1812 = (false:bool) ;
      s_1811 = (Cc_bench_Braking_528:state__8763) ;
      result_1809 = (42:int) ;
      rob_1797 = (create ():MyOp.t) ;
      dy_1796 = (create ():MyOp.t) ;
      dv_1795 = (create ():MyOp.t) ;
      rob_1779 = (create ():MyOp.t) ;
      dy_1778 = (create ():MyOp.t) ;
      dv_1777 = (create ():MyOp.t) ;
      rob_1761 = (create ():MyOp.t) ;
      dy_1760 = (create ():MyOp.t) ;
      dv_1759 = (create ():MyOp.t) ;
      rob_1743 = (create ():MyOp.t) ;
      dy_1742 = (create ():MyOp.t) ;
      dv_1741 = (create ():MyOp.t) ;
      chase_1879 = (false:bool) ;
      chase_1880 = (false:bool) ;
      chase_1881 = (false:bool) ; chase_1882 = (false:bool);
      i_2295 = i_2295_alloc () (* discrete *)  } in
  let cc_cc3_reset self  =
    ((self.i_1878 <- true ;
      i_2295_reset self.i_2295  ;
      self.r_1818 <- false ;
      self.s_1817 <- Cc_bench_Chasing_595 ;
      self.r_1816 <- false ;
      self.s_1815 <- Cc_bench_Chasing_572 ;
      self.r_1814 <- false ;
      self.s_1813 <- Cc_bench_Chasing_549 ;
      self.r_1812 <- false ; self.s_1811 <- Cc_bench_Chasing_526):unit) in 
  let cc_cc3_step self (inp_1691:(MyOp.t)Array.t) =
    ((let switchp_1836 = ref (false:bool) in
      let switchv_1835 = ref (():unit) in
      let switchp_1834 = ref (false:bool) in
      let switchv_1833 = ref (():unit) in
      let switchp_1832 = ref (false:bool) in
      let switchv_1831 = ref (():unit) in
      let switchp_1830 = ref (false:bool) in
      let switchv_1829 = ref (():unit) in
      (if self.i_1878 then self.m_1876 <- Stdlib.(+) (Random.int 4)  2) ;
      (let (x_1877:int) = self.m_1876 in
       (if self.i_1878 then self.result_1809 <- x_1877) ;
       (let (y0_1794:MyOp.t) = MyOp.make 40. in
        (if self.i_1878 then self.m_1874 <- y0_1794) ;
        (let (v0_1793:MyOp.t) = MyOp.make 0. in
         (if self.i_1878 then self.m_1872 <- v0_1793) ;
         (if self.i_1878 then self.m_1839 <- MyOp.make 0.) ;
         (let (x_1840:MyOp.t) = self.m_1839 in
          let (x_1871:MyOp.t) =
              if self.i_1878 then x_1840 else MyOp.(-) x_1840  self.m_1869 in
          let (y0_1776:MyOp.t) = MyOp.make 30. in
          (if self.i_1878 then self.m_1867 <- y0_1776) ;
          (let (v0_1775:MyOp.t) = MyOp.make 0. in
           (if self.i_1878 then self.m_1865 <- v0_1775) ;
           (let (x_1864:MyOp.t) =
                if self.i_1878 then x_1840 else MyOp.(-) x_1840  self.m_1862 in
            let (y0_1758:MyOp.t) = MyOp.make 20. in
            (if self.i_1878 then self.m_1860 <- y0_1758) ;
            (let (v0_1757:MyOp.t) = MyOp.make 0. in
             (if self.i_1878 then self.m_1858 <- v0_1757) ;
             (let (x_1857:MyOp.t) =
                  if self.i_1878
                  then x_1840
                  else MyOp.(-) x_1840  self.m_1855 in
              let (y0_1740:MyOp.t) = MyOp.make 10. in
              (if self.i_1878 then self.m_1853 <- y0_1740) ;
              (let (v0_1739:MyOp.t) = MyOp.make 0. in
               (if self.i_1878 then self.m_1851 <- v0_1739) ;
               (let (x_1850:MyOp.t) =
                    if self.i_1878
                    then x_1840
                    else MyOp.(-) x_1840  self.m_1848 in
                let (v0_1724:MyOp.t) = MyOp.make 0. in
                (if self.i_1878 then self.m_1846 <- v0_1724) ;
                (let (y0_1725:MyOp.t) = MyOp.make 0. in
                 (if self.i_1878 then self.m_1844 <- y0_1725) ;
                 (let (x_1843:MyOp.t) =
                      if self.i_1878
                      then x_1840
                      else MyOp.(-) x_1840  self.m_1841 in
                  let (tstep'_1706:MyOp.t) = MyOp.make tstep_1692 in
                  (if self.i_1878 then self.m_1837 <- tstep'_1706) ;
                  self.i_1878 <- false ;
                  (let (x_1845:MyOp.t) = self.m_1844 in
                   let (x_1854:MyOp.t) = self.m_1853 in
                   let (x_1868:MyOp.t) = self.m_1867 in
                   let (x_1875:MyOp.t) = self.m_1874 in
                   let (rob_spec_1703:MyOp.t) =
                       i_2295_step self.i_2295
                         (tstep'_1706 , x_1845 , x_1854 , x_1868 , x_1875) in
                   let (x_1873:MyOp.t) = self.m_1872 in
                   (begin match self.s_1817 with
                          | Cc_bench_Chasing_595 ->
                              (if self.r_1818 then ()) ;
                              self.rob_1797 <- MyOp.(-) (MyOp.(-) x_1875 
                                                                  x_1868) 
                                                        Cc_d.d2 ;
                              self.dy_1796 <- MyOp.(~-) x_1873 ;
                              self.dv_1795 <- MyOp.make 1. ;
                              (begin match (<=) (MyOp.(-) x_1875  x_1868) 
                                                Cc_d.d2 with
                                     | true ->
                                         switchp_1830 := true ;
                                         switchv_1829 := () ;
                                         self.r_1818 <- true ;
                                         self.s_1817 <- Cc_bench_Keeping_596
                                     | _ -> self.r_1818 <- false  end)
                          | Cc_bench_Keeping_596 ->
                              (if self.r_1818 then ()) ;
                              self.chase_1879 <- (>) (MyOp.make (Random.float 
                                                                   1.)) 
                                                     (MyOp.make 0.5) ;
                              self.rob_1797 <- (if self.chase_1879
                                                then
                                                  MyOp.(-) Cc_d.d1 
                                                           (MyOp.(-) 
                                                              x_1875  x_1868)
                                                else
                                                  MyOp.(-) (MyOp.(-) 
                                                              x_1875  x_1868)
                                                            Cc_d.d3) ;
                              self.dy_1796 <- x_1873 ;
                              self.dv_1795 <- MyOp.make 0. ;
                              (begin match (((<=) (MyOp.(-) x_1875  x_1868) 
                                                  Cc_d.d3) ,
                                            ((>=) (MyOp.(-) x_1875  x_1868) 
                                                  Cc_d.d1)) with
                                     | (_ , true) ->
                                         switchp_1830 := true ;
                                         switchv_1829 := () ;
                                         self.r_1818 <- true ;
                                         self.s_1817 <- Cc_bench_Chasing_595
                                     | (true , _) ->
                                         switchp_1830 := true ;
                                         switchv_1829 := () ;
                                         self.r_1818 <- true ;
                                         self.s_1817 <- Cc_bench_Braking_597
                                     | _ -> self.r_1818 <- false  end)
                          | Cc_bench_Braking_597 ->
                              (if self.r_1818 then ()) ;
                              self.rob_1797 <- MyOp.(-) Cc_d.d0 
                                                        (MyOp.(-) x_1875 
                                                                  x_1868) ;
                              self.dy_1796 <- MyOp.(~-) x_1873 ;
                              self.dv_1795 <- MyOp.(~-) x_1873 ;
                              (begin match (>=) (MyOp.(-) x_1875  x_1868) 
                                                Cc_d.d0 with
                                     | true ->
                                         switchp_1830 := true ;
                                         switchv_1829 := () ;
                                         self.r_1818 <- true ;
                                         self.s_1817 <- Cc_bench_Chasing_595
                                     | _ -> self.r_1818 <- false  end)
                           end) ;
                   (let (x_1861:MyOp.t) = self.m_1860 in
                    let (x_1866:MyOp.t) = self.m_1865 in
                    (begin match self.s_1815 with
                           | Cc_bench_Chasing_572 ->
                               (if self.r_1816 then ()) ;
                               self.rob_1779 <- MyOp.(-) (MyOp.(-) x_1868 
                                                                   x_1861) 
                                                         Cc_d.d2 ;
                               self.dy_1778 <- MyOp.(~-) x_1866 ;
                               self.dv_1777 <- MyOp.make 1. ;
                               (begin match (<=) (MyOp.(-) x_1868  x_1861) 
                                                 Cc_d.d2 with
                                      | true ->
                                          switchp_1832 := true ;
                                          switchv_1831 := () ;
                                          self.r_1816 <- true ;
                                          self.s_1815 <- Cc_bench_Keeping_573
                                      | _ -> self.r_1816 <- false  end)
                           | Cc_bench_Keeping_573 ->
                               (if self.r_1816 then ()) ;
                               self.chase_1880 <- (>) (MyOp.make (Random.float 
                                                                    1.)) 
                                                      (MyOp.make 0.5) ;
                               self.rob_1779 <- (if self.chase_1880
                                                 then
                                                   MyOp.(-) Cc_d.d1 
                                                            (MyOp.(-) 
                                                               x_1868  x_1861)
                                                 else
                                                   MyOp.(-) (MyOp.(-) 
                                                               x_1868  x_1861)
                                                             Cc_d.d3) ;
                               self.dy_1778 <- x_1866 ;
                               self.dv_1777 <- MyOp.make 0. ;
                               (begin match (((<=) (MyOp.(-) x_1868  x_1861) 
                                                   Cc_d.d3) ,
                                             ((>=) (MyOp.(-) x_1868  x_1861) 
                                                   Cc_d.d1)) with
                                      | (_ , true) ->
                                          switchp_1832 := true ;
                                          switchv_1831 := () ;
                                          self.r_1816 <- true ;
                                          self.s_1815 <- Cc_bench_Chasing_572
                                      | (true , _) ->
                                          switchp_1832 := true ;
                                          switchv_1831 := () ;
                                          self.r_1816 <- true ;
                                          self.s_1815 <- Cc_bench_Braking_574
                                      | _ -> self.r_1816 <- false  end)
                           | Cc_bench_Braking_574 ->
                               (if self.r_1816 then ()) ;
                               self.rob_1779 <- MyOp.(-) Cc_d.d0 
                                                         (MyOp.(-) x_1868 
                                                                   x_1861) ;
                               self.dy_1778 <- MyOp.(~-) x_1866 ;
                               self.dv_1777 <- MyOp.(~-) x_1866 ;
                               (begin match (>=) (MyOp.(-) x_1868  x_1861) 
                                                 Cc_d.d0 with
                                      | true ->
                                          switchp_1832 := true ;
                                          switchv_1831 := () ;
                                          self.r_1816 <- true ;
                                          self.s_1815 <- Cc_bench_Chasing_572
                                      | _ -> self.r_1816 <- false  end)
                            end) ;
                    (let (x_1859:MyOp.t) = self.m_1858 in
                     (begin match self.s_1813 with
                            | Cc_bench_Chasing_549 ->
                                (if self.r_1814 then ()) ;
                                self.rob_1761 <- MyOp.(-) (MyOp.(-) x_1861 
                                                                    x_1854) 
                                                          Cc_d.d2 ;
                                self.dy_1760 <- MyOp.(~-) x_1859 ;
                                self.dv_1759 <- MyOp.make 1. ;
                                (begin match (<=) (MyOp.(-) x_1861  x_1854) 
                                                  Cc_d.d2 with
                                       | true ->
                                           switchp_1834 := true ;
                                           switchv_1833 := () ;
                                           self.r_1814 <- true ;
                                           self.s_1813 <- Cc_bench_Keeping_550
                                       | _ -> self.r_1814 <- false  end)
                            | Cc_bench_Keeping_550 ->
                                (if self.r_1814 then ()) ;
                                self.chase_1881 <- (>) (MyOp.make (Random.float 
                                                                    1.)) 
                                                       (MyOp.make 0.5) ;
                                self.rob_1761 <- (if self.chase_1881
                                                  then
                                                    MyOp.(-) Cc_d.d1 
                                                             (MyOp.(-) 
                                                                x_1861 
                                                                x_1854)
                                                  else
                                                    MyOp.(-) (MyOp.(-) 
                                                                x_1861 
                                                                x_1854) 
                                                             Cc_d.d3) ;
                                self.dy_1760 <- x_1859 ;
                                self.dv_1759 <- MyOp.make 0. ;
                                (begin match (((<=) (MyOp.(-) x_1861  x_1854)
                                                     Cc_d.d3) ,
                                              ((>=) (MyOp.(-) x_1861  x_1854)
                                                     Cc_d.d1)) with
                                       | (_ , true) ->
                                           switchp_1834 := true ;
                                           switchv_1833 := () ;
                                           self.r_1814 <- true ;
                                           self.s_1813 <- Cc_bench_Chasing_549
                                       | (true , _) ->
                                           switchp_1834 := true ;
                                           switchv_1833 := () ;
                                           self.r_1814 <- true ;
                                           self.s_1813 <- Cc_bench_Braking_551
                                       | _ -> self.r_1814 <- false  end)
                            | Cc_bench_Braking_551 ->
                                (if self.r_1814 then ()) ;
                                self.rob_1761 <- MyOp.(-) Cc_d.d0 
                                                          (MyOp.(-) x_1861 
                                                                    x_1854) ;
                                self.dy_1760 <- MyOp.(~-) x_1859 ;
                                self.dv_1759 <- MyOp.(~-) x_1859 ;
                                (begin match (>=) (MyOp.(-) x_1861  x_1854) 
                                                  Cc_d.d0 with
                                       | true ->
                                           switchp_1834 := true ;
                                           switchv_1833 := () ;
                                           self.r_1814 <- true ;
                                           self.s_1813 <- Cc_bench_Chasing_549
                                       | _ -> self.r_1814 <- false  end)
                             end) ;
                     (let (x_1852:MyOp.t) = self.m_1851 in
                      (begin match self.s_1811 with
                             | Cc_bench_Chasing_526 ->
                                 (if self.r_1812 then ()) ;
                                 self.rob_1743 <- MyOp.(-) (MyOp.(-) 
                                                              x_1854  x_1845)
                                                            Cc_d.d2 ;
                                 self.dy_1742 <- MyOp.(~-) x_1852 ;
                                 self.dv_1741 <- MyOp.make 1. ;
                                 (begin match (<=) (MyOp.(-) x_1854  x_1845) 
                                                   Cc_d.d2 with
                                        | true ->
                                            switchp_1836 := true ;
                                            switchv_1835 := () ;
                                            self.r_1812 <- true ;
                                            self.s_1811 <- Cc_bench_Keeping_527
                                        | _ -> self.r_1812 <- false  end)
                             | Cc_bench_Keeping_527 ->
                                 (if self.r_1812 then ()) ;
                                 self.chase_1882 <- (>) (MyOp.make (Random.float 
                                                                    1.)) 
                                                        (MyOp.make 0.5) ;
                                 self.rob_1743 <- (if self.chase_1882
                                                   then
                                                     MyOp.(-) Cc_d.d1 
                                                              (MyOp.(-) 
                                                                 x_1854 
                                                                 x_1845)
                                                   else
                                                     MyOp.(-) (MyOp.(-) 
                                                                 x_1854 
                                                                 x_1845) 
                                                              Cc_d.d3) ;
                                 self.dy_1742 <- x_1852 ;
                                 self.dv_1741 <- MyOp.make 0. ;
                                 (begin match (((<=) (MyOp.(-) x_1854  x_1845)
                                                      Cc_d.d3) ,
                                               ((>=) (MyOp.(-) x_1854  x_1845)
                                                      Cc_d.d1)) with
                                        | (_ , true) ->
                                            switchp_1836 := true ;
                                            switchv_1835 := () ;
                                            self.r_1812 <- true ;
                                            self.s_1811 <- Cc_bench_Chasing_526
                                        | (true , _) ->
                                            switchp_1836 := true ;
                                            switchv_1835 := () ;
                                            self.r_1812 <- true ;
                                            self.s_1811 <- Cc_bench_Braking_528
                                        | _ -> self.r_1812 <- false  end)
                             | Cc_bench_Braking_528 ->
                                 (if self.r_1812 then ()) ;
                                 self.rob_1743 <- MyOp.(-) Cc_d.d0 
                                                           (MyOp.(-) 
                                                              x_1854  x_1845)
                                 ;
                                 self.dy_1742 <- MyOp.(~-) x_1852 ;
                                 self.dv_1741 <- MyOp.(~-) x_1852 ;
                                 (begin match (>=) (MyOp.(-) x_1854  x_1845) 
                                                   Cc_d.d0 with
                                        | true ->
                                            switchp_1836 := true ;
                                            switchv_1835 := () ;
                                            self.r_1812 <- true ;
                                            self.s_1811 <- Cc_bench_Chasing_526
                                        | _ -> self.r_1812 <- false  end)
                              end) ;
                      (let ((rob_trans_1720:MyOp.t) ,
                            ((switch_transv_1827:unit) , (copy_2284:bool))) =
                           if (=) (MyOp.integer x_1877)  (MyOp.integer 2)
                           then
                             (self.rob_1743 , (!switchv_1835 , !switchp_1836))
                           else
                             if (=) (MyOp.integer x_1877)  (MyOp.integer 3)
                             then
                               (self.rob_1761 ,
                                (!switchv_1833 , !switchp_1834))
                             else
                               if (=) (MyOp.integer x_1877)  (MyOp.integer 4)
                               then
                                 (self.rob_1779 ,
                                  (!switchv_1831 , !switchp_1832))
                               else
                                 (self.rob_1797 ,
                                  (!switchv_1829 , !switchp_1830)) in
                       let (rob_1701:MyOp.t) =
                           if Discrete_obs_fad.isFalse rob_spec_1703
                           then rob_spec_1703
                           else
                             if Discrete_obs_fad.isTrue rob_trans_1720
                             then rob_trans_1720
                             else rob_spec_1703 in
                       let (outp_1700:(MyOp.t)Array.t) =
                           Array.of_list ((::) (x_1845 ,
                                                ((::) (x_1854 ,
                                                       ((::) (x_1861 ,
                                                              ((::) (
                                                                    x_1868 ,
                                                                    (
                                                                    (::) 
                                                                    (
                                                                    x_1875 ,
                                                                    ([]))))))))))) in
                       (begin match (switch_transv_1827 , copy_2284) with
                              | (() , true) ->
                                  self.result_1809 <- Stdlib.(+) (Random.int 
                                                                    4)  
                                                                 2 | _ -> ()  end)
                       ;
                       self.m_1876 <- self.result_1809 ;
                       self.m_1874 <- MyOp.(+) x_1875 
                                               (MyOp.( * ) x_1871 
                                                           self.dy_1796) ;
                       self.m_1872 <- MyOp.(+) x_1873 
                                               (MyOp.( * ) x_1871 
                                                           self.dv_1795) ;
                       self.m_1869 <- x_1840 ;
                       self.m_1867 <- MyOp.(+) x_1868 
                                               (MyOp.( * ) x_1864 
                                                           self.dy_1778) ;
                       self.m_1865 <- MyOp.(+) x_1866 
                                               (MyOp.( * ) x_1864 
                                                           self.dv_1777) ;
                       self.m_1862 <- x_1840 ;
                       self.m_1860 <- MyOp.(+) x_1861 
                                               (MyOp.( * ) x_1857 
                                                           self.dy_1760) ;
                       self.m_1858 <- MyOp.(+) x_1859 
                                               (MyOp.( * ) x_1857 
                                                           self.dv_1759) ;
                       self.m_1855 <- x_1840 ;
                       self.m_1853 <- MyOp.(+) x_1854 
                                               (MyOp.( * ) x_1850 
                                                           self.dy_1742) ;
                       self.m_1851 <- MyOp.(+) x_1852 
                                               (MyOp.( * ) x_1850 
                                                           self.dv_1741) ;
                       self.m_1848 <- x_1840 ;
                       (let (throttle_1705:MyOp.t) = Array.get inp_1691  0 in
                        let (brake_1693:MyOp.t) = Array.get inp_1691  1 in
                        let (x_1847:MyOp.t) = self.m_1846 in
                        let (x_1734:MyOp.t) =
                            MyOp.(-) (MyOp.(~-) throttle_1705) 
                                     (MyOp.( * ) brake_1693  x_1847) in
                        self.m_1846 <- MyOp.(+) x_1847 
                                                (MyOp.( * ) x_1843  x_1734) ;
                        self.m_1844 <- MyOp.(+) x_1845 
                                                (MyOp.( * ) x_1843  x_1847) ;
                        self.m_1841 <- x_1840 ;
                        (let (x_1838:MyOp.t) = self.m_1837 in
                         self.m_1839 <- x_1838 ;
                         self.m_1837 <- MyOp.(+) x_1838  tstep'_1706 ;
                         ((MyOp.get x_1838) , outp_1700 , rob_1701))))))))))))))))))))):
    float * MyOp.t Array.t * MyOp.t) in
  Node { alloc = cc_cc3_alloc; reset = cc_cc3_reset ; step = cc_cc3_step }
type ('a2 ,
      'z1 ,
      'y1 ,
      'x1 ,
      'w1 ,
      'v1 ,
      'u1 ,
      't1 ,
      's1 ,
      'r1 ,
      'q1 ,
      'p1 ,
      'o1 ,
      'n1 ,
      'm1 ,
      'l1 ,
      'k1 ,
      'j1 ,
      'i1 ,
      'h1 ,
      'g1 ,
      'f1 ,
      'e1 ,
      'd1 ,
      'c1 ,
      'b1 ,
      'a1 ,
      'z ,
      'y ,
      'x ,
      'w ,
      'v ,
      'u ,
      't ,
      's ,
      'r ,
      'q ,
      'p ,
      'o ,
      'n , 'm , 'l , 'k , 'j , 'i , 'h , 'g , 'f , 'e , 'd , 'c , 'b , 'a) _cc_cc4 =
  { mutable i_2083 : 'a2 ;
    mutable m_2081 : 'z1 ;
    mutable m_2079 : 'y1 ;
    mutable m_2077 : 'x1 ;
    mutable m_2075 : 'w1 ;
    mutable m_2072 : 'v1 ;
    mutable m_2070 : 'u1 ;
    mutable m_2068 : 't1 ;
    mutable m_2065 : 's1 ;
    mutable m_2063 : 'r1 ;
    mutable m_2061 : 'q1 ;
    mutable m_2058 : 'p1 ;
    mutable m_2056 : 'o1 ;
    mutable m_2054 : 'n1 ;
    mutable m_2051 : 'm1 ;
    mutable m_2049 : 'l1 ;
    mutable m_2047 : 'k1 ;
    mutable m_2044 : 'j1 ;
    mutable m_2042 : 'i1 ;
    mutable m_2040 : 'h1 ;
    mutable r_2021 : 'g1 ;
    mutable s_2020 : 'f1 ;
    mutable r_2019 : 'e1 ;
    mutable s_2018 : 'd1 ;
    mutable r_2017 : 'c1 ;
    mutable s_2016 : 'b1 ;
    mutable r_2015 : 'a1 ;
    mutable s_2014 : 'z ;
    mutable r_2013 : 'y ;
    mutable s_2012 : 'x ;
    mutable t1_2010 : 'w ;
    mutable t0_2009 : 'v ;
    mutable t0_2008 : 'u ;
    mutable ok_2005 : 't ;
    mutable result_2001 : 's ;
    mutable rob_1989 : 'r ;
    mutable dy_1988 : 'q ;
    mutable dv_1987 : 'p ;
    mutable rob_1971 : 'o ;
    mutable dy_1970 : 'n ;
    mutable dv_1969 : 'm ;
    mutable rob_1953 : 'l ;
    mutable dy_1952 : 'k ;
    mutable dv_1951 : 'j ;
    mutable rob_1935 : 'i ;
    mutable dy_1934 : 'h ;
    mutable dv_1933 : 'g ;
    mutable local_t_2084 : 'f ;
    mutable local_t_2085 : 'e ;
    mutable chase_2086 : 'd ;
    mutable chase_2087 : 'c ;
    mutable chase_2088 : 'b ; mutable chase_2089 : 'a }

let cc_cc4 (tstep_1884:float) = 
  
  let cc_cc4_alloc _ =
    ();
    { i_2083 = (false:bool) ;
      m_2081 = (create ():MyOp.t) ;
      m_2079 = (42:int) ;
      m_2077 = (create ():MyOp.t) ;
      m_2075 = (create ():MyOp.t) ;
      m_2072 = (create ():MyOp.t) ;
      m_2070 = (create ():MyOp.t) ;
      m_2068 = (create ():MyOp.t) ;
      m_2065 = (create ():MyOp.t) ;
      m_2063 = (create ():MyOp.t) ;
      m_2061 = (create ():MyOp.t) ;
      m_2058 = (create ():MyOp.t) ;
      m_2056 = (create ():MyOp.t) ;
      m_2054 = (create ():MyOp.t) ;
      m_2051 = (create ():MyOp.t) ;
      m_2049 = (create ():MyOp.t) ;
      m_2047 = (create ():MyOp.t) ;
      m_2044 = (create ():MyOp.t) ;
      m_2042 = (create ():MyOp.t) ;
      m_2040 = (create ():MyOp.t) ;
      r_2021 = (false:bool) ;
      s_2020 = (Cc_bench_Err_753:state__8771) ;
      r_2019 = (false:bool) ;
      s_2018 = (Cc_bench_Braking_741:state__8770) ;
      r_2017 = (false:bool) ;
      s_2016 = (Cc_bench_Braking_718:state__8769) ;
      r_2015 = (false:bool) ;
      s_2014 = (Cc_bench_Braking_695:state__8768) ;
      r_2013 = (false:bool) ;
      s_2012 = (Cc_bench_Braking_672:state__8767) ;
      t1_2010 = (create ():MyOp.t) ;
      t0_2009 = (create ():MyOp.t) ;
      t0_2008 = (create ():MyOp.t) ;
      ok_2005 = (create ():MyOp.t) ;
      result_2001 = (42:int) ;
      rob_1989 = (create ():MyOp.t) ;
      dy_1988 = (create ():MyOp.t) ;
      dv_1987 = (create ():MyOp.t) ;
      rob_1971 = (create ():MyOp.t) ;
      dy_1970 = (create ():MyOp.t) ;
      dv_1969 = (create ():MyOp.t) ;
      rob_1953 = (create ():MyOp.t) ;
      dy_1952 = (create ():MyOp.t) ;
      dv_1951 = (create ():MyOp.t) ;
      rob_1935 = (create ():MyOp.t) ;
      dy_1934 = (create ():MyOp.t) ;
      dv_1933 = (create ():MyOp.t) ;
      local_t_2084 = (create ():MyOp.t) ;
      local_t_2085 = (create ():MyOp.t) ;
      chase_2086 = (false:bool) ;
      chase_2087 = (false:bool) ;
      chase_2088 = (false:bool) ; chase_2089 = (false:bool) } in
  let cc_cc4_reset self  =
    ((self.i_2083 <- true ;
      self.r_2021 <- false ;
      self.s_2020 <- Cc_bench_Notp_750 ;
      self.r_2019 <- false ;
      self.s_2018 <- Cc_bench_Chasing_739 ;
      self.r_2017 <- false ;
      self.s_2016 <- Cc_bench_Chasing_716 ;
      self.r_2015 <- false ;
      self.s_2014 <- Cc_bench_Chasing_693 ;
      self.r_2013 <- false ; self.s_2012 <- Cc_bench_Chasing_670):unit) in 
  let cc_cc4_step self (inp_1883:(MyOp.t)Array.t) =
    ((let switchp_2039 = ref (false:bool) in
      let switchv_2038 = ref (():unit) in
      let switchp_2037 = ref (false:bool) in
      let switchv_2036 = ref (():unit) in
      let switchp_2035 = ref (false:bool) in
      let switchv_2034 = ref (():unit) in
      let switchp_2033 = ref (false:bool) in
      let switchv_2032 = ref (():unit) in
      (if self.i_2083 then self.m_2081 <- MyOp.make 0.) ;
      (let (x_2082:MyOp.t) = self.m_2081 in
       (if self.i_2083 then self.t0_2008 <- x_2082) ;
       (if self.i_2083 then self.m_2079 <- Stdlib.(+) (Random.int 4)  2) ;
       (let (x_2080:int) = self.m_2079 in
        (if self.i_2083 then self.result_2001 <- x_2080) ;
        (let (y0_1986:MyOp.t) = MyOp.make 40. in
         (if self.i_2083 then self.m_2077 <- y0_1986) ;
         (let (v0_1985:MyOp.t) = MyOp.make 0. in
          (if self.i_2083 then self.m_2075 <- v0_1985) ;
          (if self.i_2083 then self.m_2042 <- MyOp.make 0.) ;
          (let (x_2043:MyOp.t) = self.m_2042 in
           let (x_2074:MyOp.t) =
               if self.i_2083 then x_2043 else MyOp.(-) x_2043  self.m_2072 in
           let (y0_1968:MyOp.t) = MyOp.make 30. in
           (if self.i_2083 then self.m_2070 <- y0_1968) ;
           (let (v0_1967:MyOp.t) = MyOp.make 0. in
            (if self.i_2083 then self.m_2068 <- v0_1967) ;
            (let (x_2067:MyOp.t) =
                 if self.i_2083 then x_2043 else MyOp.(-) x_2043  self.m_2065 in
             let (y0_1950:MyOp.t) = MyOp.make 20. in
             (if self.i_2083 then self.m_2063 <- y0_1950) ;
             (let (v0_1949:MyOp.t) = MyOp.make 0. in
              (if self.i_2083 then self.m_2061 <- v0_1949) ;
              (let (x_2060:MyOp.t) =
                   if self.i_2083
                   then x_2043
                   else MyOp.(-) x_2043  self.m_2058 in
               let (y0_1932:MyOp.t) = MyOp.make 10. in
               (if self.i_2083 then self.m_2056 <- y0_1932) ;
               (let (v0_1931:MyOp.t) = MyOp.make 0. in
                (if self.i_2083 then self.m_2054 <- v0_1931) ;
                (let (x_2053:MyOp.t) =
                     if self.i_2083
                     then x_2043
                     else MyOp.(-) x_2043  self.m_2051 in
                 let (v0_1916:MyOp.t) = MyOp.make 0. in
                 (if self.i_2083 then self.m_2049 <- v0_1916) ;
                 (let (y0_1917:MyOp.t) = MyOp.make 0. in
                  (if self.i_2083 then self.m_2047 <- y0_1917) ;
                  (let (x_2046:MyOp.t) =
                       if self.i_2083
                       then x_2043
                       else MyOp.(-) x_2043  self.m_2044 in
                   let (tstep'_1898:MyOp.t) = MyOp.make tstep_1884 in
                   (if self.i_2083 then self.m_2040 <- tstep'_1898) ;
                   self.i_2083 <- false ;
                   (let (x_2071:MyOp.t) = self.m_2070 in
                    let (x_2078:MyOp.t) = self.m_2077 in
                    let (p_2006:MyOp.t) =
                        Discrete_obs_fad.q_ge ((MyOp.(-) x_2078  x_2071) ,
                                               (MyOp.make 8.)) in
                    (begin match self.s_2020 with
                           | Cc_bench_Notp_750 ->
                               (if self.r_2021 then ()) ;
                               self.ok_2005 <- q_true ;
                               self.local_t_2084 <- MyOp.(-) x_2082 
                                                             self.t0_2008 ;
                               (begin match (((>) self.local_t_2084 
                                                  (MyOp.make 30.)) ,
                                             (Discrete_obs_fad.isTrue p_2006)
                                             ,
                                             ((<=) self.local_t_2084 
                                                   (MyOp.make 30.))) with
                                      | (_ , true , true) ->
                                          self.t1_2010 <- x_2082 ;
                                          self.t0_2009 <- self.t0_2008 ;
                                          self.r_2021 <- true ;
                                          self.s_2020 <- Cc_bench_Okp_751
                                      | (true , _ , _) ->
                                          self.r_2021 <- true ;
                                          self.s_2020 <- Cc_bench_Err_753
                                      | _ -> self.r_2021 <- false  end)
                           | Cc_bench_Okp_751 ->
                               (if self.r_2021 then ()) ;
                               self.ok_2005 <- q_true ;
                               self.local_t_2085 <- MyOp.(-) x_2082 
                                                             self.t1_2010 ;
                               (begin match ((Discrete_obs_fad.isFalse p_2006)
                                             ,
                                             ((>=) self.local_t_2085 
                                                   (MyOp.make 5.)) ,
                                             (Discrete_obs_fad.isTrue p_2006)) with
                                      | (_ , true , true) ->
                                          self.r_2021 <- true ;
                                          self.s_2020 <- Cc_bench_Alwaysp_752
                                      | (true , _ , _) ->
                                          self.t0_2008 <- self.t0_2009 ;
                                          self.r_2021 <- true ;
                                          self.s_2020 <- Cc_bench_Notp_750
                                      | _ -> self.r_2021 <- false  end)
                           | Cc_bench_Alwaysp_752 ->
                               (if self.r_2021 then ()) ;
                               self.ok_2005 <- q_true ;
                               (begin match Discrete_obs_fad.isFalse p_2006 with
                                      | true ->
                                          self.t0_2008 <- MyOp.(-) x_2082 
                                                                   (MyOp.make 
                                                                    5.) ;
                                          self.r_2021 <- true ;
                                          self.s_2020 <- Cc_bench_Notp_750
                                      | _ -> self.r_2021 <- false  end)
                           | Cc_bench_Err_753 ->
                               (if self.r_2021 then ()) ;
                               self.ok_2005 <- q_false ; self.r_2021 <- false
                            end) ;
                    (let (x_2076:MyOp.t) = self.m_2075 in
                     (begin match self.s_2018 with
                            | Cc_bench_Chasing_739 ->
                                (if self.r_2019 then ()) ;
                                self.rob_1989 <- MyOp.(-) (MyOp.(-) x_2078 
                                                                    x_2071) 
                                                          Cc_d.d2 ;
                                self.dy_1988 <- MyOp.(~-) x_2076 ;
                                self.dv_1987 <- MyOp.make 1. ;
                                (begin match (<=) (MyOp.(-) x_2078  x_2071) 
                                                  Cc_d.d2 with
                                       | true ->
                                           switchp_2033 := true ;
                                           switchv_2032 := () ;
                                           self.r_2019 <- true ;
                                           self.s_2018 <- Cc_bench_Keeping_740
                                       | _ -> self.r_2019 <- false  end)
                            | Cc_bench_Keeping_740 ->
                                (if self.r_2019 then ()) ;
                                self.chase_2086 <- (>) (MyOp.make (Random.float 
                                                                    1.)) 
                                                       (MyOp.make 0.5) ;
                                self.rob_1989 <- (if self.chase_2086
                                                  then
                                                    MyOp.(-) Cc_d.d1 
                                                             (MyOp.(-) 
                                                                x_2078 
                                                                x_2071)
                                                  else
                                                    MyOp.(-) (MyOp.(-) 
                                                                x_2078 
                                                                x_2071) 
                                                             Cc_d.d3) ;
                                self.dy_1988 <- x_2076 ;
                                self.dv_1987 <- MyOp.make 0. ;
                                (begin match (((<=) (MyOp.(-) x_2078  x_2071)
                                                     Cc_d.d3) ,
                                              ((>=) (MyOp.(-) x_2078  x_2071)
                                                     Cc_d.d1)) with
                                       | (_ , true) ->
                                           switchp_2033 := true ;
                                           switchv_2032 := () ;
                                           self.r_2019 <- true ;
                                           self.s_2018 <- Cc_bench_Chasing_739
                                       | (true , _) ->
                                           switchp_2033 := true ;
                                           switchv_2032 := () ;
                                           self.r_2019 <- true ;
                                           self.s_2018 <- Cc_bench_Braking_741
                                       | _ -> self.r_2019 <- false  end)
                            | Cc_bench_Braking_741 ->
                                (if self.r_2019 then ()) ;
                                self.rob_1989 <- MyOp.(-) Cc_d.d0 
                                                          (MyOp.(-) x_2078 
                                                                    x_2071) ;
                                self.dy_1988 <- MyOp.(~-) x_2076 ;
                                self.dv_1987 <- MyOp.(~-) x_2076 ;
                                (begin match (>=) (MyOp.(-) x_2078  x_2071) 
                                                  Cc_d.d0 with
                                       | true ->
                                           switchp_2033 := true ;
                                           switchv_2032 := () ;
                                           self.r_2019 <- true ;
                                           self.s_2018 <- Cc_bench_Chasing_739
                                       | _ -> self.r_2019 <- false  end)
                             end) ;
                     (let (x_2064:MyOp.t) = self.m_2063 in
                      let (x_2069:MyOp.t) = self.m_2068 in
                      (begin match self.s_2016 with
                             | Cc_bench_Chasing_716 ->
                                 (if self.r_2017 then ()) ;
                                 self.rob_1971 <- MyOp.(-) (MyOp.(-) 
                                                              x_2071  x_2064)
                                                            Cc_d.d2 ;
                                 self.dy_1970 <- MyOp.(~-) x_2069 ;
                                 self.dv_1969 <- MyOp.make 1. ;
                                 (begin match (<=) (MyOp.(-) x_2071  x_2064) 
                                                   Cc_d.d2 with
                                        | true ->
                                            switchp_2035 := true ;
                                            switchv_2034 := () ;
                                            self.r_2017 <- true ;
                                            self.s_2016 <- Cc_bench_Keeping_717
                                        | _ -> self.r_2017 <- false  end)
                             | Cc_bench_Keeping_717 ->
                                 (if self.r_2017 then ()) ;
                                 self.chase_2087 <- (>) (MyOp.make (Random.float 
                                                                    1.)) 
                                                        (MyOp.make 0.5) ;
                                 self.rob_1971 <- (if self.chase_2087
                                                   then
                                                     MyOp.(-) Cc_d.d1 
                                                              (MyOp.(-) 
                                                                 x_2071 
                                                                 x_2064)
                                                   else
                                                     MyOp.(-) (MyOp.(-) 
                                                                 x_2071 
                                                                 x_2064) 
                                                              Cc_d.d3) ;
                                 self.dy_1970 <- x_2069 ;
                                 self.dv_1969 <- MyOp.make 0. ;
                                 (begin match (((<=) (MyOp.(-) x_2071  x_2064)
                                                      Cc_d.d3) ,
                                               ((>=) (MyOp.(-) x_2071  x_2064)
                                                      Cc_d.d1)) with
                                        | (_ , true) ->
                                            switchp_2035 := true ;
                                            switchv_2034 := () ;
                                            self.r_2017 <- true ;
                                            self.s_2016 <- Cc_bench_Chasing_716
                                        | (true , _) ->
                                            switchp_2035 := true ;
                                            switchv_2034 := () ;
                                            self.r_2017 <- true ;
                                            self.s_2016 <- Cc_bench_Braking_718
                                        | _ -> self.r_2017 <- false  end)
                             | Cc_bench_Braking_718 ->
                                 (if self.r_2017 then ()) ;
                                 self.rob_1971 <- MyOp.(-) Cc_d.d0 
                                                           (MyOp.(-) 
                                                              x_2071  x_2064)
                                 ;
                                 self.dy_1970 <- MyOp.(~-) x_2069 ;
                                 self.dv_1969 <- MyOp.(~-) x_2069 ;
                                 (begin match (>=) (MyOp.(-) x_2071  x_2064) 
                                                   Cc_d.d0 with
                                        | true ->
                                            switchp_2035 := true ;
                                            switchv_2034 := () ;
                                            self.r_2017 <- true ;
                                            self.s_2016 <- Cc_bench_Chasing_716
                                        | _ -> self.r_2017 <- false  end)
                              end) ;
                      (let (x_2057:MyOp.t) = self.m_2056 in
                       let (x_2062:MyOp.t) = self.m_2061 in
                       (begin match self.s_2014 with
                              | Cc_bench_Chasing_693 ->
                                  (if self.r_2015 then ()) ;
                                  self.rob_1953 <- MyOp.(-) (MyOp.(-) 
                                                               x_2064  x_2057)
                                                             Cc_d.d2 ;
                                  self.dy_1952 <- MyOp.(~-) x_2062 ;
                                  self.dv_1951 <- MyOp.make 1. ;
                                  (begin match (<=) (MyOp.(-) x_2064  x_2057)
                                                     Cc_d.d2 with
                                         | true ->
                                             switchp_2037 := true ;
                                             switchv_2036 := () ;
                                             self.r_2015 <- true ;
                                             self.s_2014 <- Cc_bench_Keeping_694
                                         | _ -> self.r_2015 <- false  end)
                              | Cc_bench_Keeping_694 ->
                                  (if self.r_2015 then ()) ;
                                  self.chase_2088 <- (>) (MyOp.make (
                                                                    Random.float 
                                                                    1.)) 
                                                         (MyOp.make 0.5) ;
                                  self.rob_1953 <- (if self.chase_2088
                                                    then
                                                      MyOp.(-) Cc_d.d1 
                                                               (MyOp.(-) 
                                                                  x_2064 
                                                                  x_2057)
                                                    else
                                                      MyOp.(-) (MyOp.(-) 
                                                                  x_2064 
                                                                  x_2057) 
                                                               Cc_d.d3) ;
                                  self.dy_1952 <- x_2062 ;
                                  self.dv_1951 <- MyOp.make 0. ;
                                  (begin match (((<=) (MyOp.(-) x_2064 
                                                                x_2057) 
                                                      Cc_d.d3) ,
                                                ((>=) (MyOp.(-) x_2064 
                                                                x_2057) 
                                                      Cc_d.d1)) with
                                         | (_ , true) ->
                                             switchp_2037 := true ;
                                             switchv_2036 := () ;
                                             self.r_2015 <- true ;
                                             self.s_2014 <- Cc_bench_Chasing_693
                                         | (true , _) ->
                                             switchp_2037 := true ;
                                             switchv_2036 := () ;
                                             self.r_2015 <- true ;
                                             self.s_2014 <- Cc_bench_Braking_695
                                         | _ -> self.r_2015 <- false  end)
                              | Cc_bench_Braking_695 ->
                                  (if self.r_2015 then ()) ;
                                  self.rob_1953 <- MyOp.(-) Cc_d.d0 
                                                            (MyOp.(-) 
                                                               x_2064  x_2057)
                                  ;
                                  self.dy_1952 <- MyOp.(~-) x_2062 ;
                                  self.dv_1951 <- MyOp.(~-) x_2062 ;
                                  (begin match (>=) (MyOp.(-) x_2064  x_2057)
                                                     Cc_d.d0 with
                                         | true ->
                                             switchp_2037 := true ;
                                             switchv_2036 := () ;
                                             self.r_2015 <- true ;
                                             self.s_2014 <- Cc_bench_Chasing_693
                                         | _ -> self.r_2015 <- false  end)
                               end) ;
                       (let (x_2048:MyOp.t) = self.m_2047 in
                        let (x_2055:MyOp.t) = self.m_2054 in
                        (begin match self.s_2012 with
                               | Cc_bench_Chasing_670 ->
                                   (if self.r_2013 then ()) ;
                                   self.rob_1935 <- MyOp.(-) (MyOp.(-) 
                                                                x_2057 
                                                                x_2048) 
                                                             Cc_d.d2 ;
                                   self.dy_1934 <- MyOp.(~-) x_2055 ;
                                   self.dv_1933 <- MyOp.make 1. ;
                                   (begin match (<=) (MyOp.(-) x_2057  x_2048)
                                                      Cc_d.d2 with
                                          | true ->
                                              switchp_2039 := true ;
                                              switchv_2038 := () ;
                                              self.r_2013 <- true ;
                                              self.s_2012 <- Cc_bench_Keeping_671
                                          | _ -> self.r_2013 <- false  end)
                               | Cc_bench_Keeping_671 ->
                                   (if self.r_2013 then ()) ;
                                   self.chase_2089 <- (>) (MyOp.make 
                                                             (Random.float 1.))
                                                           (MyOp.make 0.5) ;
                                   self.rob_1935 <- (if self.chase_2089
                                                     then
                                                       MyOp.(-) Cc_d.d1 
                                                                (MyOp.(-) 
                                                                   x_2057 
                                                                   x_2048)
                                                     else
                                                       MyOp.(-) (MyOp.(-) 
                                                                   x_2057 
                                                                   x_2048) 
                                                                Cc_d.d3) ;
                                   self.dy_1934 <- x_2055 ;
                                   self.dv_1933 <- MyOp.make 0. ;
                                   (begin match (((<=) (MyOp.(-) x_2057 
                                                                 x_2048) 
                                                       Cc_d.d3) ,
                                                 ((>=) (MyOp.(-) x_2057 
                                                                 x_2048) 
                                                       Cc_d.d1)) with
                                          | (_ , true) ->
                                              switchp_2039 := true ;
                                              switchv_2038 := () ;
                                              self.r_2013 <- true ;
                                              self.s_2012 <- Cc_bench_Chasing_670
                                          | (true , _) ->
                                              switchp_2039 := true ;
                                              switchv_2038 := () ;
                                              self.r_2013 <- true ;
                                              self.s_2012 <- Cc_bench_Braking_672
                                          | _ -> self.r_2013 <- false  end)
                               | Cc_bench_Braking_672 ->
                                   (if self.r_2013 then ()) ;
                                   self.rob_1935 <- MyOp.(-) Cc_d.d0 
                                                             (MyOp.(-) 
                                                                x_2057 
                                                                x_2048) ;
                                   self.dy_1934 <- MyOp.(~-) x_2055 ;
                                   self.dv_1933 <- MyOp.(~-) x_2055 ;
                                   (begin match (>=) (MyOp.(-) x_2057  x_2048)
                                                      Cc_d.d0 with
                                          | true ->
                                              switchp_2039 := true ;
                                              switchv_2038 := () ;
                                              self.r_2013 <- true ;
                                              self.s_2012 <- Cc_bench_Chasing_670
                                          | _ -> self.r_2013 <- false  end)
                                end) ;
                        (let ((rob_trans_1912:MyOp.t) ,
                              ((switch_transv_2030:unit) , (copy_2285:bool))) =
                             if (=) (MyOp.integer x_2080)  (MyOp.integer 2)
                             then
                               (self.rob_1935 ,
                                (!switchv_2038 , !switchp_2039))
                             else
                               if (=) (MyOp.integer x_2080)  (MyOp.integer 3)
                               then
                                 (self.rob_1953 ,
                                  (!switchv_2036 , !switchp_2037))
                               else
                                 if (=) (MyOp.integer x_2080) 
                                        (MyOp.integer 4)
                                 then
                                   (self.rob_1971 ,
                                    (!switchv_2034 , !switchp_2035))
                                 else
                                   (self.rob_1989 ,
                                    (!switchv_2032 , !switchp_2033)) in
                         let (rob_1893:MyOp.t) =
                             if Discrete_obs_fad.isFalse self.ok_2005
                             then self.ok_2005
                             else
                               if Discrete_obs_fad.isTrue rob_trans_1912
                               then rob_trans_1912
                               else self.ok_2005 in
                         self.m_2081 <- MyOp.(+) tstep'_1898  x_2082 ;
                         (let (outp_1892:(MyOp.t)Array.t) =
                              Array.of_list ((::) (x_2048 ,
                                                   ((::) (x_2057 ,
                                                          ((::) (x_2064 ,
                                                                 ((::) 
                                                                    (
                                                                    x_2071 ,
                                                                    (
                                                                    (::) 
                                                                    (
                                                                    x_2078 ,
                                                                    ([]))))))))))) in
                          (begin match (switch_transv_2030 , copy_2285) with
                                 | (() , true) ->
                                     self.result_2001 <- Stdlib.(+) (
                                                                    Random.int 
                                                                    4)  
                                                                    2
                                 | _ -> ()  end) ;
                          self.m_2079 <- self.result_2001 ;
                          self.m_2077 <- MyOp.(+) x_2078 
                                                  (MyOp.( * ) x_2074 
                                                              self.dy_1988) ;
                          self.m_2075 <- MyOp.(+) x_2076 
                                                  (MyOp.( * ) x_2074 
                                                              self.dv_1987) ;
                          self.m_2072 <- x_2043 ;
                          self.m_2070 <- MyOp.(+) x_2071 
                                                  (MyOp.( * ) x_2067 
                                                              self.dy_1970) ;
                          self.m_2068 <- MyOp.(+) x_2069 
                                                  (MyOp.( * ) x_2067 
                                                              self.dv_1969) ;
                          self.m_2065 <- x_2043 ;
                          self.m_2063 <- MyOp.(+) x_2064 
                                                  (MyOp.( * ) x_2060 
                                                              self.dy_1952) ;
                          self.m_2061 <- MyOp.(+) x_2062 
                                                  (MyOp.( * ) x_2060 
                                                              self.dv_1951) ;
                          self.m_2058 <- x_2043 ;
                          self.m_2056 <- MyOp.(+) x_2057 
                                                  (MyOp.( * ) x_2053 
                                                              self.dy_1934) ;
                          self.m_2054 <- MyOp.(+) x_2055 
                                                  (MyOp.( * ) x_2053 
                                                              self.dv_1933) ;
                          self.m_2051 <- x_2043 ;
                          (let (throttle_1897:MyOp.t) = Array.get inp_1883  0 in
                           let (brake_1885:MyOp.t) = Array.get inp_1883  1 in
                           let (x_2050:MyOp.t) = self.m_2049 in
                           let (x_1926:MyOp.t) =
                               MyOp.(-) (MyOp.(~-) throttle_1897) 
                                        (MyOp.( * ) brake_1885  x_2050) in
                           self.m_2049 <- MyOp.(+) x_2050 
                                                   (MyOp.( * ) x_2046  x_1926)
                           ;
                           self.m_2047 <- MyOp.(+) x_2048 
                                                   (MyOp.( * ) x_2046  x_2050)
                           ;
                           self.m_2044 <- x_2043 ;
                           (let (x_2041:MyOp.t) = self.m_2040 in
                            self.m_2042 <- x_2041 ;
                            self.m_2040 <- MyOp.(+) x_2041  tstep'_1898 ;
                            ((MyOp.get x_2041) , outp_1892 , rob_1893)))))))))))))))))))))))):
    float * MyOp.t Array.t * MyOp.t) in
  Node { alloc = cc_cc4_alloc; reset = cc_cc4_reset ; step = cc_cc4_step }
type ('s1 ,
      'r1 ,
      'q1 ,
      'p1 ,
      'o1 ,
      'n1 ,
      'm1 ,
      'l1 ,
      'k1 ,
      'j1 ,
      'i1 ,
      'h1 ,
      'g1 ,
      'f1 ,
      'e1 ,
      'd1 ,
      'c1 ,
      'b1 ,
      'a1 ,
      'z ,
      'y ,
      'x ,
      'w ,
      'v ,
      'u ,
      't ,
      's ,
      'r ,
      'q ,
      'p ,
      'o ,
      'n , 'm , 'l , 'k , 'j , 'i , 'h , 'g , 'f , 'e , 'd , 'c , 'b , 'a) _cc_cc5 =
  { mutable i_2296 : 's1 ;
    mutable i_2277 : 'r1 ;
    mutable m_2275 : 'q1 ;
    mutable m_2273 : 'p1 ;
    mutable m_2271 : 'o1 ;
    mutable m_2268 : 'n1 ;
    mutable m_2266 : 'm1 ;
    mutable m_2264 : 'l1 ;
    mutable m_2261 : 'k1 ;
    mutable m_2259 : 'j1 ;
    mutable m_2257 : 'i1 ;
    mutable m_2254 : 'h1 ;
    mutable m_2252 : 'g1 ;
    mutable m_2250 : 'f1 ;
    mutable m_2247 : 'e1 ;
    mutable m_2245 : 'd1 ;
    mutable m_2243 : 'c1 ;
    mutable m_2240 : 'b1 ;
    mutable m_2238 : 'a1 ;
    mutable m_2236 : 'z ;
    mutable r_2217 : 'y ;
    mutable s_2216 : 'x ;
    mutable r_2215 : 'w ;
    mutable s_2214 : 'v ;
    mutable r_2213 : 'u ;
    mutable s_2212 : 't ;
    mutable r_2211 : 's ;
    mutable s_2210 : 'r ;
    mutable result_2208 : 'q ;
    mutable rob_2196 : 'p ;
    mutable dy_2195 : 'o ;
    mutable dv_2194 : 'n ;
    mutable rob_2178 : 'm ;
    mutable dy_2177 : 'l ;
    mutable dv_2176 : 'k ;
    mutable rob_2160 : 'j ;
    mutable dy_2159 : 'i ;
    mutable dv_2158 : 'h ;
    mutable rob_2142 : 'g ;
    mutable dy_2141 : 'f ;
    mutable dv_2140 : 'e ;
    mutable chase_2278 : 'd ;
    mutable chase_2279 : 'c ;
    mutable chase_2280 : 'b ; mutable chase_2281 : 'a }

let cc_cc5 (tstep_2091:float) = 
  let Node { alloc = i_2296_alloc; step = i_2296_step ; reset = i_2296_reset } = cc5 
   in
  let cc_cc5_alloc _ =
    ();
    { i_2277 = (false:bool) ;
      m_2275 = (42:int) ;
      m_2273 = (create ():MyOp.t) ;
      m_2271 = (create ():MyOp.t) ;
      m_2268 = (create ():MyOp.t) ;
      m_2266 = (create ():MyOp.t) ;
      m_2264 = (create ():MyOp.t) ;
      m_2261 = (create ():MyOp.t) ;
      m_2259 = (create ():MyOp.t) ;
      m_2257 = (create ():MyOp.t) ;
      m_2254 = (create ():MyOp.t) ;
      m_2252 = (create ():MyOp.t) ;
      m_2250 = (create ():MyOp.t) ;
      m_2247 = (create ():MyOp.t) ;
      m_2245 = (create ():MyOp.t) ;
      m_2243 = (create ():MyOp.t) ;
      m_2240 = (create ():MyOp.t) ;
      m_2238 = (create ():MyOp.t) ;
      m_2236 = (create ():MyOp.t) ;
      r_2217 = (false:bool) ;
      s_2216 = (Cc_bench_Braking_900:state__8775) ;
      r_2215 = (false:bool) ;
      s_2214 = (Cc_bench_Braking_877:state__8774) ;
      r_2213 = (false:bool) ;
      s_2212 = (Cc_bench_Braking_854:state__8773) ;
      r_2211 = (false:bool) ;
      s_2210 = (Cc_bench_Braking_831:state__8772) ;
      result_2208 = (42:int) ;
      rob_2196 = (create ():MyOp.t) ;
      dy_2195 = (create ():MyOp.t) ;
      dv_2194 = (create ():MyOp.t) ;
      rob_2178 = (create ():MyOp.t) ;
      dy_2177 = (create ():MyOp.t) ;
      dv_2176 = (create ():MyOp.t) ;
      rob_2160 = (create ():MyOp.t) ;
      dy_2159 = (create ():MyOp.t) ;
      dv_2158 = (create ():MyOp.t) ;
      rob_2142 = (create ():MyOp.t) ;
      dy_2141 = (create ():MyOp.t) ;
      dv_2140 = (create ():MyOp.t) ;
      chase_2278 = (false:bool) ;
      chase_2279 = (false:bool) ;
      chase_2280 = (false:bool) ; chase_2281 = (false:bool);
      i_2296 = i_2296_alloc () (* discrete *)  } in
  let cc_cc5_reset self  =
    ((self.i_2277 <- true ;
      i_2296_reset self.i_2296  ;
      self.r_2217 <- false ;
      self.s_2216 <- Cc_bench_Chasing_898 ;
      self.r_2215 <- false ;
      self.s_2214 <- Cc_bench_Chasing_875 ;
      self.r_2213 <- false ;
      self.s_2212 <- Cc_bench_Chasing_852 ;
      self.r_2211 <- false ; self.s_2210 <- Cc_bench_Chasing_829):unit) in 
  let cc_cc5_step self (inp_2090:(MyOp.t)Array.t) =
    ((let switchp_2235 = ref (false:bool) in
      let switchv_2234 = ref (():unit) in
      let switchp_2233 = ref (false:bool) in
      let switchv_2232 = ref (():unit) in
      let switchp_2231 = ref (false:bool) in
      let switchv_2230 = ref (():unit) in
      let switchp_2229 = ref (false:bool) in
      let switchv_2228 = ref (():unit) in
      (if self.i_2277 then self.m_2275 <- Stdlib.(+) (Random.int 4)  2) ;
      (let (x_2276:int) = self.m_2275 in
       (if self.i_2277 then self.result_2208 <- x_2276) ;
       (let (y0_2193:MyOp.t) = MyOp.make 40. in
        (if self.i_2277 then self.m_2273 <- y0_2193) ;
        (let (v0_2192:MyOp.t) = MyOp.make 0. in
         (if self.i_2277 then self.m_2271 <- v0_2192) ;
         (if self.i_2277 then self.m_2238 <- MyOp.make 0.) ;
         (let (x_2239:MyOp.t) = self.m_2238 in
          let (x_2270:MyOp.t) =
              if self.i_2277 then x_2239 else MyOp.(-) x_2239  self.m_2268 in
          let (y0_2175:MyOp.t) = MyOp.make 30. in
          (if self.i_2277 then self.m_2266 <- y0_2175) ;
          (let (v0_2174:MyOp.t) = MyOp.make 0. in
           (if self.i_2277 then self.m_2264 <- v0_2174) ;
           (let (x_2263:MyOp.t) =
                if self.i_2277 then x_2239 else MyOp.(-) x_2239  self.m_2261 in
            let (y0_2157:MyOp.t) = MyOp.make 20. in
            (if self.i_2277 then self.m_2259 <- y0_2157) ;
            (let (v0_2156:MyOp.t) = MyOp.make 0. in
             (if self.i_2277 then self.m_2257 <- v0_2156) ;
             (let (x_2256:MyOp.t) =
                  if self.i_2277
                  then x_2239
                  else MyOp.(-) x_2239  self.m_2254 in
              let (y0_2139:MyOp.t) = MyOp.make 10. in
              (if self.i_2277 then self.m_2252 <- y0_2139) ;
              (let (v0_2138:MyOp.t) = MyOp.make 0. in
               (if self.i_2277 then self.m_2250 <- v0_2138) ;
               (let (x_2249:MyOp.t) =
                    if self.i_2277
                    then x_2239
                    else MyOp.(-) x_2239  self.m_2247 in
                let (v0_2123:MyOp.t) = MyOp.make 0. in
                (if self.i_2277 then self.m_2245 <- v0_2123) ;
                (let (y0_2124:MyOp.t) = MyOp.make 0. in
                 (if self.i_2277 then self.m_2243 <- y0_2124) ;
                 (let (x_2242:MyOp.t) =
                      if self.i_2277
                      then x_2239
                      else MyOp.(-) x_2239  self.m_2240 in
                  let (tstep'_2105:MyOp.t) = MyOp.make tstep_2091 in
                  (if self.i_2277 then self.m_2236 <- tstep'_2105) ;
                  self.i_2277 <- false ;
                  (let (x_2244:MyOp.t) = self.m_2243 in
                   let (x_2253:MyOp.t) = self.m_2252 in
                   let (x_2267:MyOp.t) = self.m_2266 in
                   let (x_2274:MyOp.t) = self.m_2273 in
                   let (rob_spec_2102:MyOp.t) =
                       i_2296_step self.i_2296
                         (tstep'_2105 , x_2244 , x_2253 , x_2267 , x_2274) in
                   let (x_2272:MyOp.t) = self.m_2271 in
                   (begin match self.s_2216 with
                          | Cc_bench_Chasing_898 ->
                              (if self.r_2217 then ()) ;
                              self.rob_2196 <- MyOp.(-) (MyOp.(-) x_2274 
                                                                  x_2267) 
                                                        Cc_d.d2 ;
                              self.dy_2195 <- MyOp.(~-) x_2272 ;
                              self.dv_2194 <- MyOp.make 1. ;
                              (begin match (<=) (MyOp.(-) x_2274  x_2267) 
                                                Cc_d.d2 with
                                     | true ->
                                         switchp_2229 := true ;
                                         switchv_2228 := () ;
                                         self.r_2217 <- true ;
                                         self.s_2216 <- Cc_bench_Keeping_899
                                     | _ -> self.r_2217 <- false  end)
                          | Cc_bench_Keeping_899 ->
                              (if self.r_2217 then ()) ;
                              self.chase_2278 <- (>) (MyOp.make (Random.float 
                                                                   1.)) 
                                                     (MyOp.make 0.5) ;
                              self.rob_2196 <- (if self.chase_2278
                                                then
                                                  MyOp.(-) Cc_d.d1 
                                                           (MyOp.(-) 
                                                              x_2274  x_2267)
                                                else
                                                  MyOp.(-) (MyOp.(-) 
                                                              x_2274  x_2267)
                                                            Cc_d.d3) ;
                              self.dy_2195 <- x_2272 ;
                              self.dv_2194 <- MyOp.make 0. ;
                              (begin match (((<=) (MyOp.(-) x_2274  x_2267) 
                                                  Cc_d.d3) ,
                                            ((>=) (MyOp.(-) x_2274  x_2267) 
                                                  Cc_d.d1)) with
                                     | (_ , true) ->
                                         switchp_2229 := true ;
                                         switchv_2228 := () ;
                                         self.r_2217 <- true ;
                                         self.s_2216 <- Cc_bench_Chasing_898
                                     | (true , _) ->
                                         switchp_2229 := true ;
                                         switchv_2228 := () ;
                                         self.r_2217 <- true ;
                                         self.s_2216 <- Cc_bench_Braking_900
                                     | _ -> self.r_2217 <- false  end)
                          | Cc_bench_Braking_900 ->
                              (if self.r_2217 then ()) ;
                              self.rob_2196 <- MyOp.(-) Cc_d.d0 
                                                        (MyOp.(-) x_2274 
                                                                  x_2267) ;
                              self.dy_2195 <- MyOp.(~-) x_2272 ;
                              self.dv_2194 <- MyOp.(~-) x_2272 ;
                              (begin match (>=) (MyOp.(-) x_2274  x_2267) 
                                                Cc_d.d0 with
                                     | true ->
                                         switchp_2229 := true ;
                                         switchv_2228 := () ;
                                         self.r_2217 <- true ;
                                         self.s_2216 <- Cc_bench_Chasing_898
                                     | _ -> self.r_2217 <- false  end)
                           end) ;
                   (let (x_2260:MyOp.t) = self.m_2259 in
                    let (x_2265:MyOp.t) = self.m_2264 in
                    (begin match self.s_2214 with
                           | Cc_bench_Chasing_875 ->
                               (if self.r_2215 then ()) ;
                               self.rob_2178 <- MyOp.(-) (MyOp.(-) x_2267 
                                                                   x_2260) 
                                                         Cc_d.d2 ;
                               self.dy_2177 <- MyOp.(~-) x_2265 ;
                               self.dv_2176 <- MyOp.make 1. ;
                               (begin match (<=) (MyOp.(-) x_2267  x_2260) 
                                                 Cc_d.d2 with
                                      | true ->
                                          switchp_2231 := true ;
                                          switchv_2230 := () ;
                                          self.r_2215 <- true ;
                                          self.s_2214 <- Cc_bench_Keeping_876
                                      | _ -> self.r_2215 <- false  end)
                           | Cc_bench_Keeping_876 ->
                               (if self.r_2215 then ()) ;
                               self.chase_2279 <- (>) (MyOp.make (Random.float 
                                                                    1.)) 
                                                      (MyOp.make 0.5) ;
                               self.rob_2178 <- (if self.chase_2279
                                                 then
                                                   MyOp.(-) Cc_d.d1 
                                                            (MyOp.(-) 
                                                               x_2267  x_2260)
                                                 else
                                                   MyOp.(-) (MyOp.(-) 
                                                               x_2267  x_2260)
                                                             Cc_d.d3) ;
                               self.dy_2177 <- x_2265 ;
                               self.dv_2176 <- MyOp.make 0. ;
                               (begin match (((<=) (MyOp.(-) x_2267  x_2260) 
                                                   Cc_d.d3) ,
                                             ((>=) (MyOp.(-) x_2267  x_2260) 
                                                   Cc_d.d1)) with
                                      | (_ , true) ->
                                          switchp_2231 := true ;
                                          switchv_2230 := () ;
                                          self.r_2215 <- true ;
                                          self.s_2214 <- Cc_bench_Chasing_875
                                      | (true , _) ->
                                          switchp_2231 := true ;
                                          switchv_2230 := () ;
                                          self.r_2215 <- true ;
                                          self.s_2214 <- Cc_bench_Braking_877
                                      | _ -> self.r_2215 <- false  end)
                           | Cc_bench_Braking_877 ->
                               (if self.r_2215 then ()) ;
                               self.rob_2178 <- MyOp.(-) Cc_d.d0 
                                                         (MyOp.(-) x_2267 
                                                                   x_2260) ;
                               self.dy_2177 <- MyOp.(~-) x_2265 ;
                               self.dv_2176 <- MyOp.(~-) x_2265 ;
                               (begin match (>=) (MyOp.(-) x_2267  x_2260) 
                                                 Cc_d.d0 with
                                      | true ->
                                          switchp_2231 := true ;
                                          switchv_2230 := () ;
                                          self.r_2215 <- true ;
                                          self.s_2214 <- Cc_bench_Chasing_875
                                      | _ -> self.r_2215 <- false  end)
                            end) ;
                    (let (x_2258:MyOp.t) = self.m_2257 in
                     (begin match self.s_2212 with
                            | Cc_bench_Chasing_852 ->
                                (if self.r_2213 then ()) ;
                                self.rob_2160 <- MyOp.(-) (MyOp.(-) x_2260 
                                                                    x_2253) 
                                                          Cc_d.d2 ;
                                self.dy_2159 <- MyOp.(~-) x_2258 ;
                                self.dv_2158 <- MyOp.make 1. ;
                                (begin match (<=) (MyOp.(-) x_2260  x_2253) 
                                                  Cc_d.d2 with
                                       | true ->
                                           switchp_2233 := true ;
                                           switchv_2232 := () ;
                                           self.r_2213 <- true ;
                                           self.s_2212 <- Cc_bench_Keeping_853
                                       | _ -> self.r_2213 <- false  end)
                            | Cc_bench_Keeping_853 ->
                                (if self.r_2213 then ()) ;
                                self.chase_2280 <- (>) (MyOp.make (Random.float 
                                                                    1.)) 
                                                       (MyOp.make 0.5) ;
                                self.rob_2160 <- (if self.chase_2280
                                                  then
                                                    MyOp.(-) Cc_d.d1 
                                                             (MyOp.(-) 
                                                                x_2260 
                                                                x_2253)
                                                  else
                                                    MyOp.(-) (MyOp.(-) 
                                                                x_2260 
                                                                x_2253) 
                                                             Cc_d.d3) ;
                                self.dy_2159 <- x_2258 ;
                                self.dv_2158 <- MyOp.make 0. ;
                                (begin match (((<=) (MyOp.(-) x_2260  x_2253)
                                                     Cc_d.d3) ,
                                              ((>=) (MyOp.(-) x_2260  x_2253)
                                                     Cc_d.d1)) with
                                       | (_ , true) ->
                                           switchp_2233 := true ;
                                           switchv_2232 := () ;
                                           self.r_2213 <- true ;
                                           self.s_2212 <- Cc_bench_Chasing_852
                                       | (true , _) ->
                                           switchp_2233 := true ;
                                           switchv_2232 := () ;
                                           self.r_2213 <- true ;
                                           self.s_2212 <- Cc_bench_Braking_854
                                       | _ -> self.r_2213 <- false  end)
                            | Cc_bench_Braking_854 ->
                                (if self.r_2213 then ()) ;
                                self.rob_2160 <- MyOp.(-) Cc_d.d0 
                                                          (MyOp.(-) x_2260 
                                                                    x_2253) ;
                                self.dy_2159 <- MyOp.(~-) x_2258 ;
                                self.dv_2158 <- MyOp.(~-) x_2258 ;
                                (begin match (>=) (MyOp.(-) x_2260  x_2253) 
                                                  Cc_d.d0 with
                                       | true ->
                                           switchp_2233 := true ;
                                           switchv_2232 := () ;
                                           self.r_2213 <- true ;
                                           self.s_2212 <- Cc_bench_Chasing_852
                                       | _ -> self.r_2213 <- false  end)
                             end) ;
                     (let (x_2251:MyOp.t) = self.m_2250 in
                      (begin match self.s_2210 with
                             | Cc_bench_Chasing_829 ->
                                 (if self.r_2211 then ()) ;
                                 self.rob_2142 <- MyOp.(-) (MyOp.(-) 
                                                              x_2253  x_2244)
                                                            Cc_d.d2 ;
                                 self.dy_2141 <- MyOp.(~-) x_2251 ;
                                 self.dv_2140 <- MyOp.make 1. ;
                                 (begin match (<=) (MyOp.(-) x_2253  x_2244) 
                                                   Cc_d.d2 with
                                        | true ->
                                            switchp_2235 := true ;
                                            switchv_2234 := () ;
                                            self.r_2211 <- true ;
                                            self.s_2210 <- Cc_bench_Keeping_830
                                        | _ -> self.r_2211 <- false  end)
                             | Cc_bench_Keeping_830 ->
                                 (if self.r_2211 then ()) ;
                                 self.chase_2281 <- (>) (MyOp.make (Random.float 
                                                                    1.)) 
                                                        (MyOp.make 0.5) ;
                                 self.rob_2142 <- (if self.chase_2281
                                                   then
                                                     MyOp.(-) Cc_d.d1 
                                                              (MyOp.(-) 
                                                                 x_2253 
                                                                 x_2244)
                                                   else
                                                     MyOp.(-) (MyOp.(-) 
                                                                 x_2253 
                                                                 x_2244) 
                                                              Cc_d.d3) ;
                                 self.dy_2141 <- x_2251 ;
                                 self.dv_2140 <- MyOp.make 0. ;
                                 (begin match (((<=) (MyOp.(-) x_2253  x_2244)
                                                      Cc_d.d3) ,
                                               ((>=) (MyOp.(-) x_2253  x_2244)
                                                      Cc_d.d1)) with
                                        | (_ , true) ->
                                            switchp_2235 := true ;
                                            switchv_2234 := () ;
                                            self.r_2211 <- true ;
                                            self.s_2210 <- Cc_bench_Chasing_829
                                        | (true , _) ->
                                            switchp_2235 := true ;
                                            switchv_2234 := () ;
                                            self.r_2211 <- true ;
                                            self.s_2210 <- Cc_bench_Braking_831
                                        | _ -> self.r_2211 <- false  end)
                             | Cc_bench_Braking_831 ->
                                 (if self.r_2211 then ()) ;
                                 self.rob_2142 <- MyOp.(-) Cc_d.d0 
                                                           (MyOp.(-) 
                                                              x_2253  x_2244)
                                 ;
                                 self.dy_2141 <- MyOp.(~-) x_2251 ;
                                 self.dv_2140 <- MyOp.(~-) x_2251 ;
                                 (begin match (>=) (MyOp.(-) x_2253  x_2244) 
                                                   Cc_d.d0 with
                                        | true ->
                                            switchp_2235 := true ;
                                            switchv_2234 := () ;
                                            self.r_2211 <- true ;
                                            self.s_2210 <- Cc_bench_Chasing_829
                                        | _ -> self.r_2211 <- false  end)
                              end) ;
                      (let ((rob_trans_2119:MyOp.t) ,
                            ((switch_transv_2226:unit) , (copy_2286:bool))) =
                           if (=) (MyOp.integer x_2276)  (MyOp.integer 2)
                           then
                             (self.rob_2142 , (!switchv_2234 , !switchp_2235))
                           else
                             if (=) (MyOp.integer x_2276)  (MyOp.integer 3)
                             then
                               (self.rob_2160 ,
                                (!switchv_2232 , !switchp_2233))
                             else
                               if (=) (MyOp.integer x_2276)  (MyOp.integer 4)
                               then
                                 (self.rob_2178 ,
                                  (!switchv_2230 , !switchp_2231))
                               else
                                 (self.rob_2196 ,
                                  (!switchv_2228 , !switchp_2229)) in
                       let (rob_2100:MyOp.t) =
                           if Discrete_obs_fad.isFalse rob_spec_2102
                           then rob_spec_2102
                           else
                             if Discrete_obs_fad.isTrue rob_trans_2119
                             then rob_trans_2119
                             else rob_spec_2102 in
                       let (outp_2099:(MyOp.t)Array.t) =
                           Array.of_list ((::) (x_2244 ,
                                                ((::) (x_2253 ,
                                                       ((::) (x_2260 ,
                                                              ((::) (
                                                                    x_2267 ,
                                                                    (
                                                                    (::) 
                                                                    (
                                                                    x_2274 ,
                                                                    ([]))))))))))) in
                       (begin match (switch_transv_2226 , copy_2286) with
                              | (() , true) ->
                                  self.result_2208 <- Stdlib.(+) (Random.int 
                                                                    4)  
                                                                 2 | _ -> ()  end)
                       ;
                       self.m_2275 <- self.result_2208 ;
                       self.m_2273 <- MyOp.(+) x_2274 
                                               (MyOp.( * ) x_2270 
                                                           self.dy_2195) ;
                       self.m_2271 <- MyOp.(+) x_2272 
                                               (MyOp.( * ) x_2270 
                                                           self.dv_2194) ;
                       self.m_2268 <- x_2239 ;
                       self.m_2266 <- MyOp.(+) x_2267 
                                               (MyOp.( * ) x_2263 
                                                           self.dy_2177) ;
                       self.m_2264 <- MyOp.(+) x_2265 
                                               (MyOp.( * ) x_2263 
                                                           self.dv_2176) ;
                       self.m_2261 <- x_2239 ;
                       self.m_2259 <- MyOp.(+) x_2260 
                                               (MyOp.( * ) x_2256 
                                                           self.dy_2159) ;
                       self.m_2257 <- MyOp.(+) x_2258 
                                               (MyOp.( * ) x_2256 
                                                           self.dv_2158) ;
                       self.m_2254 <- x_2239 ;
                       self.m_2252 <- MyOp.(+) x_2253 
                                               (MyOp.( * ) x_2249 
                                                           self.dy_2141) ;
                       self.m_2250 <- MyOp.(+) x_2251 
                                               (MyOp.( * ) x_2249 
                                                           self.dv_2140) ;
                       self.m_2247 <- x_2239 ;
                       (let (throttle_2104:MyOp.t) = Array.get inp_2090  0 in
                        let (brake_2092:MyOp.t) = Array.get inp_2090  1 in
                        let (x_2246:MyOp.t) = self.m_2245 in
                        let (x_2133:MyOp.t) =
                            MyOp.(-) (MyOp.(~-) throttle_2104) 
                                     (MyOp.( * ) brake_2092  x_2246) in
                        self.m_2245 <- MyOp.(+) x_2246 
                                                (MyOp.( * ) x_2242  x_2133) ;
                        self.m_2243 <- MyOp.(+) x_2244 
                                                (MyOp.( * ) x_2242  x_2246) ;
                        self.m_2240 <- x_2239 ;
                        (let (x_2237:MyOp.t) = self.m_2236 in
                         self.m_2238 <- x_2237 ;
                         self.m_2236 <- MyOp.(+) x_2237  tstep'_2105 ;
                         ((MyOp.get x_2237) , outp_2099 , rob_2100))))))))))))))))))))):
    float * MyOp.t Array.t * MyOp.t) in
  Node { alloc = cc_cc5_alloc; reset = cc_cc5_reset ; step = cc_cc5_step }
