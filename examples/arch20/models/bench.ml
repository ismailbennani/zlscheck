(* The Zélus compiler, version 2.0
  (lundi 25 mai 2020, 14:33:03 (UTC+0200)) *)
open Ztypes
open MyOp
open Discrete_obs_fad
type ('a) _phi1 =
  { mutable i_581 : 'a }

let phi1 (tstep_369:float) = 
  let Node { alloc = i_581_alloc; step = i_581_step ; reset = i_581_reset } = 
  Discrete_obs_fad.always_timed 20.  in
  let phi1_alloc _ =
    ();{ i_581 = i_581_alloc () (* discrete *)  } in
  let phi1_reset self  =
    (i_581_reset self.i_581 :unit) in 
  let phi1_step self ((inp_367:'a4720) , (outp_368:(MyOp.t)Array.t)) =
    ((let (speed_370:MyOp.t) = Array.get outp_368  2 in
      i_581_step self.i_581
        ((MyOp.make tstep_369) ,
         (Discrete_obs_fad.q_lt (speed_370 , (MyOp.make 120.))))):MyOp.t) in
  Node { alloc = phi1_alloc; reset = phi1_reset ; step = phi1_step }
type ('a) _phi2 =
  { mutable i_582 : 'a }

let phi2 (tstep_373:float) = 
  let Node { alloc = i_582_alloc; step = i_582_step ; reset = i_582_reset } = 
  Discrete_obs_fad.always_timed 10.  in
  let phi2_alloc _ =
    ();{ i_582 = i_582_alloc () (* discrete *)  } in
  let phi2_reset self  =
    (i_582_reset self.i_582 :unit) in 
  let phi2_step self ((inp_371:'a4744) , (outp_372:(MyOp.t)Array.t)) =
    ((let (rpm_374:MyOp.t) = Array.get outp_372  0 in
      i_582_step self.i_582
        ((MyOp.make tstep_373) ,
         (Discrete_obs_fad.q_lt (rpm_374 , (MyOp.make 4750.))))):MyOp.t) in
  Node { alloc = phi2_alloc; reset = phi2_reset ; step = phi2_step }
type ('e , 'd , 'c , 'b , 'a) _phi5 =
  { mutable i_585 : 'e ;
    mutable i_584 : 'd ;
    mutable i_583 : 'c ; mutable i_384 : 'b ; mutable m_382 : 'a }

let phi5 (tstep_378:float)  (geari_375:float) = 
  let Node { alloc = i_585_alloc; step = i_585_step ; reset = i_585_reset } = Discrete_obs_fad.q_up 
   in 
  let Node { alloc = i_584_alloc; step = i_584_step ; reset = i_584_reset } = 
  Discrete_obs_fad.always_timed 30.  in 
  let Node { alloc = i_583_alloc; step = i_583_step ; reset = i_583_reset } = 
  Discrete_obs_fad.alwaysBfromA_timed 2.5  in
  let phi5_alloc _ =
    ();
    { i_384 = (false:bool) ; m_382 = (create ():MyOp.t);
      i_585 = i_585_alloc () (* discrete *)  ;
      i_584 = i_584_alloc () (* discrete *)  ;
      i_583 = i_583_alloc () (* discrete *)  } in
  let phi5_reset self  =
    ((self.i_384 <- true ;
      i_585_reset self.i_585  ;
      i_584_reset self.i_584  ; i_583_reset self.i_583 ):unit) in 
  let phi5_step self ((inp_376:'a4769) , (outp_377:(MyOp.t)Array.t)) =
    (((if self.i_384 then self.m_382 <- Discrete_obs_fad.q_true) ;
      self.i_384 <- false ;
      (let (x_383:MyOp.t) = self.m_382 in
       self.m_382 <- Discrete_obs_fad.q_false ;
       (let (gear_379:MyOp.t) = Array.get outp_377  1 in
        let (switch_381:MyOp.t) =
            Discrete_obs_fad.q_and ((Discrete_obs_fad.q_not x_383) ,
                                    (i_585_step self.i_585
                                       (Discrete_obs_fad.q_eqi (gear_379 ,
                                                                (MyOp.make 
                                                                   geari_375))))) in
        i_584_step self.i_584
          ((MyOp.make tstep_378) ,
           (i_583_step self.i_583
              ((MyOp.make tstep_378) ,
               switch_381 ,
               (Discrete_obs_fad.q_eqi (gear_379 , (MyOp.make geari_375))))))))):
    MyOp.t) in
  Node { alloc = phi5_alloc; reset = phi5_reset ; step = phi5_step }
type ('e , 'd , 'c , 'b , 'a) _phi51 =
  { mutable i_588 : 'e ;
    mutable i_587 : 'd ;
    mutable i_586 : 'c ; mutable i_397 : 'b ; mutable m_395 : 'a }

let phi51 (tstep_387:float) = 
  let Node { alloc = i_588_alloc; step = i_588_step ; reset = i_588_reset } = Discrete_obs_fad.q_up 
   in 
  let Node { alloc = i_587_alloc; step = i_587_step ; reset = i_587_reset } = 
  Discrete_obs_fad.always_timed 30.  in 
  let Node { alloc = i_586_alloc; step = i_586_step ; reset = i_586_reset } = 
  Discrete_obs_fad.alwaysBfromA_timed 2.5  in
  let phi51_alloc _ =
    ();
    { i_397 = (false:bool) ; m_395 = (create ():MyOp.t);
      i_588 = i_588_alloc () (* discrete *)  ;
      i_587 = i_587_alloc () (* discrete *)  ;
      i_586 = i_586_alloc () (* discrete *)  } in
  let phi51_reset self  =
    ((self.i_397 <- true ;
      i_588_reset self.i_588  ;
      i_587_reset self.i_587  ; i_586_reset self.i_586 ):unit) in 
  let phi51_step self ((inp_385:'a4815) , (outp_386:(MyOp.t)Array.t)) =
    (((if self.i_397 then self.m_395 <- Discrete_obs_fad.q_true) ;
      self.i_397 <- false ;
      (let (x_396:MyOp.t) = self.m_395 in
       self.m_395 <- Discrete_obs_fad.q_false ;
       (let (gear_392:MyOp.t) = Array.get outp_386  1 in
        let (switch_394:MyOp.t) =
            Discrete_obs_fad.q_and ((Discrete_obs_fad.q_not x_396) ,
                                    (i_588_step self.i_588
                                       (Discrete_obs_fad.q_eqi (gear_392 ,
                                                                (MyOp.make 1.))))) in
        i_587_step self.i_587
          ((MyOp.make tstep_387) ,
           (i_586_step self.i_586
              ((MyOp.make tstep_387) ,
               switch_394 ,
               (Discrete_obs_fad.q_eqi (gear_392 , (MyOp.make 1.))))))))):
    MyOp.t) in
  Node { alloc = phi51_alloc; reset = phi51_reset ; step = phi51_step }
type ('e , 'd , 'c , 'b , 'a) _phi52 =
  { mutable i_591 : 'e ;
    mutable i_590 : 'd ;
    mutable i_589 : 'c ; mutable i_410 : 'b ; mutable m_408 : 'a }

let phi52 (tstep_400:float) = 
  let Node { alloc = i_591_alloc; step = i_591_step ; reset = i_591_reset } = Discrete_obs_fad.q_up 
   in 
  let Node { alloc = i_590_alloc; step = i_590_step ; reset = i_590_reset } = 
  Discrete_obs_fad.always_timed 30.  in 
  let Node { alloc = i_589_alloc; step = i_589_step ; reset = i_589_reset } = 
  Discrete_obs_fad.alwaysBfromA_timed 2.5  in
  let phi52_alloc _ =
    ();
    { i_410 = (false:bool) ; m_408 = (create ():MyOp.t);
      i_591 = i_591_alloc () (* discrete *)  ;
      i_590 = i_590_alloc () (* discrete *)  ;
      i_589 = i_589_alloc () (* discrete *)  } in
  let phi52_reset self  =
    ((self.i_410 <- true ;
      i_591_reset self.i_591  ;
      i_590_reset self.i_590  ; i_589_reset self.i_589 ):unit) in 
  let phi52_step self ((inp_398:'a4859) , (outp_399:(MyOp.t)Array.t)) =
    (((if self.i_410 then self.m_408 <- Discrete_obs_fad.q_true) ;
      self.i_410 <- false ;
      (let (x_409:MyOp.t) = self.m_408 in
       self.m_408 <- Discrete_obs_fad.q_false ;
       (let (gear_405:MyOp.t) = Array.get outp_399  1 in
        let (switch_407:MyOp.t) =
            Discrete_obs_fad.q_and ((Discrete_obs_fad.q_not x_409) ,
                                    (i_591_step self.i_591
                                       (Discrete_obs_fad.q_eqi (gear_405 ,
                                                                (MyOp.make 2.))))) in
        i_590_step self.i_590
          ((MyOp.make tstep_400) ,
           (i_589_step self.i_589
              ((MyOp.make tstep_400) ,
               switch_407 ,
               (Discrete_obs_fad.q_eqi (gear_405 , (MyOp.make 2.))))))))):
    MyOp.t) in
  Node { alloc = phi52_alloc; reset = phi52_reset ; step = phi52_step }
type ('e , 'd , 'c , 'b , 'a) _phi53 =
  { mutable i_594 : 'e ;
    mutable i_593 : 'd ;
    mutable i_592 : 'c ; mutable i_423 : 'b ; mutable m_421 : 'a }

let phi53 (tstep_413:float) = 
  let Node { alloc = i_594_alloc; step = i_594_step ; reset = i_594_reset } = Discrete_obs_fad.q_up 
   in 
  let Node { alloc = i_593_alloc; step = i_593_step ; reset = i_593_reset } = 
  Discrete_obs_fad.always_timed 30.  in 
  let Node { alloc = i_592_alloc; step = i_592_step ; reset = i_592_reset } = 
  Discrete_obs_fad.alwaysBfromA_timed 2.5  in
  let phi53_alloc _ =
    ();
    { i_423 = (false:bool) ; m_421 = (create ():MyOp.t);
      i_594 = i_594_alloc () (* discrete *)  ;
      i_593 = i_593_alloc () (* discrete *)  ;
      i_592 = i_592_alloc () (* discrete *)  } in
  let phi53_reset self  =
    ((self.i_423 <- true ;
      i_594_reset self.i_594  ;
      i_593_reset self.i_593  ; i_592_reset self.i_592 ):unit) in 
  let phi53_step self ((inp_411:'a4903) , (outp_412:(MyOp.t)Array.t)) =
    (((if self.i_423 then self.m_421 <- Discrete_obs_fad.q_true) ;
      self.i_423 <- false ;
      (let (x_422:MyOp.t) = self.m_421 in
       self.m_421 <- Discrete_obs_fad.q_false ;
       (let (gear_418:MyOp.t) = Array.get outp_412  1 in
        let (switch_420:MyOp.t) =
            Discrete_obs_fad.q_and ((Discrete_obs_fad.q_not x_422) ,
                                    (i_594_step self.i_594
                                       (Discrete_obs_fad.q_eqi (gear_418 ,
                                                                (MyOp.make 3.))))) in
        i_593_step self.i_593
          ((MyOp.make tstep_413) ,
           (i_592_step self.i_592
              ((MyOp.make tstep_413) ,
               switch_420 ,
               (Discrete_obs_fad.q_eqi (gear_418 , (MyOp.make 3.))))))))):
    MyOp.t) in
  Node { alloc = phi53_alloc; reset = phi53_reset ; step = phi53_step }
type ('e , 'd , 'c , 'b , 'a) _phi54 =
  { mutable i_597 : 'e ;
    mutable i_596 : 'd ;
    mutable i_595 : 'c ; mutable i_436 : 'b ; mutable m_434 : 'a }

let phi54 (tstep_426:float) = 
  let Node { alloc = i_597_alloc; step = i_597_step ; reset = i_597_reset } = Discrete_obs_fad.q_up 
   in 
  let Node { alloc = i_596_alloc; step = i_596_step ; reset = i_596_reset } = 
  Discrete_obs_fad.always_timed 30.  in 
  let Node { alloc = i_595_alloc; step = i_595_step ; reset = i_595_reset } = 
  Discrete_obs_fad.alwaysBfromA_timed 2.5  in
  let phi54_alloc _ =
    ();
    { i_436 = (false:bool) ; m_434 = (create ():MyOp.t);
      i_597 = i_597_alloc () (* discrete *)  ;
      i_596 = i_596_alloc () (* discrete *)  ;
      i_595 = i_595_alloc () (* discrete *)  } in
  let phi54_reset self  =
    ((self.i_436 <- true ;
      i_597_reset self.i_597  ;
      i_596_reset self.i_596  ; i_595_reset self.i_595 ):unit) in 
  let phi54_step self ((inp_424:'a4947) , (outp_425:(MyOp.t)Array.t)) =
    (((if self.i_436 then self.m_434 <- Discrete_obs_fad.q_true) ;
      self.i_436 <- false ;
      (let (x_435:MyOp.t) = self.m_434 in
       self.m_434 <- Discrete_obs_fad.q_false ;
       (let (gear_431:MyOp.t) = Array.get outp_425  1 in
        let (switch_433:MyOp.t) =
            Discrete_obs_fad.q_and ((Discrete_obs_fad.q_not x_435) ,
                                    (i_597_step self.i_597
                                       (Discrete_obs_fad.q_eqi (gear_431 ,
                                                                (MyOp.make 4.))))) in
        i_596_step self.i_596
          ((MyOp.make tstep_426) ,
           (i_595_step self.i_595
              ((MyOp.make tstep_426) ,
               switch_433 ,
               (Discrete_obs_fad.q_eqi (gear_431 , (MyOp.make 4.))))))))):
    MyOp.t) in
  Node { alloc = phi54_alloc; reset = phi54_reset ; step = phi54_step }
type ('b , 'a) _phi6 =
  { mutable i_599 : 'b ; mutable i_598 : 'a }

let phi6 (tstep_441:float)  ((t_440:float) , (s_439:float)) = 
  let Node { alloc = i_599_alloc; step = i_599_step ; reset = i_599_reset } = 
  Discrete_obs_fad.always_timed t_440  in 
  let Node { alloc = i_598_alloc; step = i_598_step ; reset = i_598_reset } = 
  Discrete_obs_fad.always_timed 30.  in
  let phi6_alloc _ =
    ();
    { i_599 = i_599_alloc () (* discrete *)  ;
      i_598 = i_598_alloc () (* discrete *)  } in
  let phi6_reset self  =
    ((i_599_reset self.i_599  ; i_598_reset self.i_598 ):unit) in 
  let phi6_step self ((inp_437:'a4985) , (outp_438:(MyOp.t)Array.t)) =
    ((let (rpm_442:MyOp.t) = Array.get outp_438  0 in
      let (speed_443:MyOp.t) = Array.get outp_438  2 in
      Discrete_obs_fad.implies ((i_598_step self.i_598
                                   ((MyOp.make tstep_441) ,
                                    (Discrete_obs_fad.q_lt (rpm_442 ,
                                                            (MyOp.make 3000.)))))
                                ,
                                (i_599_step self.i_599
                                   ((MyOp.make tstep_441) ,
                                    (Discrete_obs_fad.q_lt (speed_443 ,
                                                            (MyOp.make s_439))))))):
    MyOp.t) in
  Node { alloc = phi6_alloc; reset = phi6_reset ; step = phi6_step }
type ('b , 'a) _phi6a =
  { mutable i_601 : 'b ; mutable i_600 : 'a }

let phi6a (tstep_446:float) = 
  let Node { alloc = i_601_alloc; step = i_601_step ; reset = i_601_reset } = 
  Discrete_obs_fad.always_timed 4.  in 
  let Node { alloc = i_600_alloc; step = i_600_step ; reset = i_600_reset } = 
  Discrete_obs_fad.always_timed 30.  in
  let phi6a_alloc _ =
    ();
    { i_601 = i_601_alloc () (* discrete *)  ;
      i_600 = i_600_alloc () (* discrete *)  } in
  let phi6a_reset self  =
    ((i_601_reset self.i_601  ; i_600_reset self.i_600 ):unit) in 
  let phi6a_step self ((inp_444:'a5029) , (outp_445:(MyOp.t)Array.t)) =
    ((let (rpm_447:MyOp.t) = Array.get outp_445  0 in
      let (speed_448:MyOp.t) = Array.get outp_445  2 in
      Discrete_obs_fad.implies ((i_600_step self.i_600
                                   ((MyOp.make tstep_446) ,
                                    (Discrete_obs_fad.q_lt (rpm_447 ,
                                                            (MyOp.make 3000.)))))
                                ,
                                (i_601_step self.i_601
                                   ((MyOp.make tstep_446) ,
                                    (Discrete_obs_fad.q_lt (speed_448 ,
                                                            (MyOp.make 35.))))))):
    MyOp.t) in
  Node { alloc = phi6a_alloc; reset = phi6a_reset ; step = phi6a_step }
type ('b , 'a) _phi6b =
  { mutable i_603 : 'b ; mutable i_602 : 'a }

let phi6b (tstep_451:float) = 
  let Node { alloc = i_603_alloc; step = i_603_step ; reset = i_603_reset } = 
  Discrete_obs_fad.always_timed 8.  in 
  let Node { alloc = i_602_alloc; step = i_602_step ; reset = i_602_reset } = 
  Discrete_obs_fad.always_timed 30.  in
  let phi6b_alloc _ =
    ();
    { i_603 = i_603_alloc () (* discrete *)  ;
      i_602 = i_602_alloc () (* discrete *)  } in
  let phi6b_reset self  =
    ((i_603_reset self.i_603  ; i_602_reset self.i_602 ):unit) in 
  let phi6b_step self ((inp_449:'a5068) , (outp_450:(MyOp.t)Array.t)) =
    ((let (rpm_452:MyOp.t) = Array.get outp_450  0 in
      let (speed_453:MyOp.t) = Array.get outp_450  2 in
      Discrete_obs_fad.implies ((i_602_step self.i_602
                                   ((MyOp.make tstep_451) ,
                                    (Discrete_obs_fad.q_lt (rpm_452 ,
                                                            (MyOp.make 3000.)))))
                                ,
                                (i_603_step self.i_603
                                   ((MyOp.make tstep_451) ,
                                    (Discrete_obs_fad.q_lt (speed_453 ,
                                                            (MyOp.make 50.))))))):
    MyOp.t) in
  Node { alloc = phi6b_alloc; reset = phi6b_reset ; step = phi6b_step }
type ('b , 'a) _phi6c =
  { mutable i_605 : 'b ; mutable i_604 : 'a }

let phi6c (tstep_456:float) = 
  let Node { alloc = i_605_alloc; step = i_605_step ; reset = i_605_reset } = 
  Discrete_obs_fad.always_timed 20.  in 
  let Node { alloc = i_604_alloc; step = i_604_step ; reset = i_604_reset } = 
  Discrete_obs_fad.always_timed 30.  in
  let phi6c_alloc _ =
    ();
    { i_605 = i_605_alloc () (* discrete *)  ;
      i_604 = i_604_alloc () (* discrete *)  } in
  let phi6c_reset self  =
    ((i_605_reset self.i_605  ; i_604_reset self.i_604 ):unit) in 
  let phi6c_step self ((inp_454:'a5107) , (outp_455:(MyOp.t)Array.t)) =
    ((let (rpm_457:MyOp.t) = Array.get outp_455  0 in
      let (speed_458:MyOp.t) = Array.get outp_455  2 in
      Discrete_obs_fad.implies ((i_604_step self.i_604
                                   ((MyOp.make tstep_456) ,
                                    (Discrete_obs_fad.q_lt (rpm_457 ,
                                                            (MyOp.make 3000.)))))
                                ,
                                (i_605_step self.i_605
                                   ((MyOp.make tstep_456) ,
                                    (Discrete_obs_fad.q_lt (speed_458 ,
                                                            (MyOp.make 65.))))))):
    MyOp.t) in
  Node { alloc = phi6c_alloc; reset = phi6c_reset ; step = phi6c_step }
type ('c , 'b , 'a) _autotrans_phi1 =
  { mutable i_607 : 'c ; mutable i_606 : 'b ; mutable m_469 : 'a }

let autotrans_phi1 (tstep_460:float) = 
  let Node { alloc = i_607_alloc; step = i_607_step ; reset = i_607_reset } = Autotransd.autotrans 
   in 
  let Node { alloc = i_606_alloc; step = i_606_step ; reset = i_606_reset } = 
  phi1 tstep_460  in
  let autotrans_phi1_alloc _ =
    ();
    { m_469 = (42.:float);
      i_607 = i_607_alloc () (* discrete *)  ;
      i_606 = i_606_alloc () (* discrete *)  } in
  let autotrans_phi1_reset self  =
    ((self.m_469 <- 0. ; i_607_reset self.i_607  ; i_606_reset self.i_606 ):
    unit) in 
  let autotrans_phi1_step self (inp_459:(MyOp.t)Array.t) =
    ((let (x_470:float) = self.m_469 in
      let (brake_461:MyOp.t) = Array.get inp_459  1 in
      let (throttle_468:MyOp.t) = Array.get inp_459  0 in
      let ((rpm_465:MyOp.t) , (gear_462:MyOp.t) , (speed_466:MyOp.t)) =
          i_607_step self.i_607
            ((MyOp.make x_470) , (throttle_468 , brake_461)) in
      let (outp_463:(MyOp.t)Array.t) =
          Array.of_list ((::) (rpm_465 ,
                               ((::) (gear_462 , ((::) (speed_466 , ([]))))))) in
      let (rob_464:MyOp.t) = i_606_step self.i_606 (inp_459 , outp_463) in
      self.m_469 <- (+.) x_470  tstep_460 ; (x_470 , rob_464)):float * MyOp.t) in
  Node { alloc = autotrans_phi1_alloc; reset = autotrans_phi1_reset ;
                                       step = autotrans_phi1_step }
type ('c , 'b , 'a) _autotrans_phi2 =
  { mutable i_609 : 'c ; mutable i_608 : 'b ; mutable m_481 : 'a }

let autotrans_phi2 (tstep_472:float) = 
  let Node { alloc = i_609_alloc; step = i_609_step ; reset = i_609_reset } = Autotransd.autotrans 
   in 
  let Node { alloc = i_608_alloc; step = i_608_step ; reset = i_608_reset } = 
  phi2 tstep_472  in
  let autotrans_phi2_alloc _ =
    ();
    { m_481 = (42.:float);
      i_609 = i_609_alloc () (* discrete *)  ;
      i_608 = i_608_alloc () (* discrete *)  } in
  let autotrans_phi2_reset self  =
    ((self.m_481 <- 0. ; i_609_reset self.i_609  ; i_608_reset self.i_608 ):
    unit) in 
  let autotrans_phi2_step self (inp_471:(MyOp.t)Array.t) =
    ((let (x_482:float) = self.m_481 in
      let (brake_473:MyOp.t) = Array.get inp_471  1 in
      let (throttle_480:MyOp.t) = Array.get inp_471  0 in
      let ((rpm_477:MyOp.t) , (gear_474:MyOp.t) , (speed_478:MyOp.t)) =
          i_609_step self.i_609
            ((MyOp.make x_482) , (throttle_480 , brake_473)) in
      let (outp_475:(MyOp.t)Array.t) =
          Array.of_list ((::) (rpm_477 ,
                               ((::) (gear_474 , ((::) (speed_478 , ([]))))))) in
      let (rob_476:MyOp.t) = i_608_step self.i_608 (inp_471 , outp_475) in
      self.m_481 <- (+.) x_482  tstep_472 ; (x_482 , rob_476)):float * MyOp.t) in
  Node { alloc = autotrans_phi2_alloc; reset = autotrans_phi2_reset ;
                                       step = autotrans_phi2_step }
type ('c , 'b , 'a) _autotrans_phi51 =
  { mutable i_611 : 'c ; mutable i_610 : 'b ; mutable m_495 : 'a }

let autotrans_phi51 (tstep_484:float) = 
  let Node { alloc = i_611_alloc; step = i_611_step ; reset = i_611_reset } = Autotransd_modes.autotrans 
   in 
  let Node { alloc = i_610_alloc; step = i_610_step ; reset = i_610_reset } = 
  phi51 tstep_484  in
  let autotrans_phi51_alloc _ =
    ();
    { m_495 = (42.:float);
      i_611 = i_611_alloc () (* discrete *)  ;
      i_610 = i_610_alloc () (* discrete *)  } in
  let autotrans_phi51_reset self  =
    ((self.m_495 <- 0. ; i_611_reset self.i_611  ; i_610_reset self.i_610 ):
    unit) in 
  let autotrans_phi51_step self (inp_483:(MyOp.t)Array.t) =
    ((let (x_496:float) = self.m_495 in
      let (brake_485:MyOp.t) = Array.get inp_483  1 in
      let (throttle_494:MyOp.t) = Array.get inp_483  0 in
      let (((rpm_491:MyOp.t) , (gear_486:MyOp.t) , (speed_492:MyOp.t)) ,
           (rob_optim_489:MyOp.t)) =
          i_611_step self.i_611
            ((MyOp.make x_496) , (throttle_494 , brake_485)) in
      let (outp_487:(MyOp.t)Array.t) =
          Array.of_list ((::) (rpm_491 ,
                               ((::) (gear_486 , ((::) (speed_492 , ([]))))))) in
      let (rob_spec_490:MyOp.t) = i_610_step self.i_610 (inp_483 , outp_487) in
      let (rob_488:MyOp.t) =
          if Discrete_obs_fad.isFalse rob_spec_490
          then rob_spec_490
          else
            if Discrete_obs_fad.isTrue rob_optim_489
            then rob_optim_489
            else rob_spec_490 in
      self.m_495 <- (+.) x_496  tstep_484 ; (x_496 , rob_488)):float * MyOp.t) in
  Node { alloc = autotrans_phi51_alloc; reset = autotrans_phi51_reset ;
                                        step = autotrans_phi51_step }
type ('c , 'b , 'a) _autotrans_phi52 =
  { mutable i_613 : 'c ; mutable i_612 : 'b ; mutable m_509 : 'a }

let autotrans_phi52 (tstep_498:float) = 
  let Node { alloc = i_613_alloc; step = i_613_step ; reset = i_613_reset } = Autotransd_modes.autotrans 
   in 
  let Node { alloc = i_612_alloc; step = i_612_step ; reset = i_612_reset } = 
  phi52 tstep_498  in
  let autotrans_phi52_alloc _ =
    ();
    { m_509 = (42.:float);
      i_613 = i_613_alloc () (* discrete *)  ;
      i_612 = i_612_alloc () (* discrete *)  } in
  let autotrans_phi52_reset self  =
    ((self.m_509 <- 0. ; i_613_reset self.i_613  ; i_612_reset self.i_612 ):
    unit) in 
  let autotrans_phi52_step self (inp_497:(MyOp.t)Array.t) =
    ((let (x_510:float) = self.m_509 in
      let (brake_499:MyOp.t) = Array.get inp_497  1 in
      let (throttle_508:MyOp.t) = Array.get inp_497  0 in
      let (((rpm_505:MyOp.t) , (gear_500:MyOp.t) , (speed_506:MyOp.t)) ,
           (rob_optim_503:MyOp.t)) =
          i_613_step self.i_613
            ((MyOp.make x_510) , (throttle_508 , brake_499)) in
      let (outp_501:(MyOp.t)Array.t) =
          Array.of_list ((::) (rpm_505 ,
                               ((::) (gear_500 , ((::) (speed_506 , ([]))))))) in
      let (rob_spec_504:MyOp.t) = i_612_step self.i_612 (inp_497 , outp_501) in
      let (rob_502:MyOp.t) =
          if Discrete_obs_fad.isFalse rob_spec_504
          then rob_spec_504
          else
            if Discrete_obs_fad.isTrue rob_optim_503
            then rob_optim_503
            else rob_spec_504 in
      self.m_509 <- (+.) x_510  tstep_498 ; (x_510 , rob_502)):float * MyOp.t) in
  Node { alloc = autotrans_phi52_alloc; reset = autotrans_phi52_reset ;
                                        step = autotrans_phi52_step }
type ('c , 'b , 'a) _autotrans_phi53 =
  { mutable i_615 : 'c ; mutable i_614 : 'b ; mutable m_523 : 'a }

let autotrans_phi53 (tstep_512:float) = 
  let Node { alloc = i_615_alloc; step = i_615_step ; reset = i_615_reset } = Autotransd_modes.autotrans 
   in 
  let Node { alloc = i_614_alloc; step = i_614_step ; reset = i_614_reset } = 
  phi53 tstep_512  in
  let autotrans_phi53_alloc _ =
    ();
    { m_523 = (42.:float);
      i_615 = i_615_alloc () (* discrete *)  ;
      i_614 = i_614_alloc () (* discrete *)  } in
  let autotrans_phi53_reset self  =
    ((self.m_523 <- 0. ; i_615_reset self.i_615  ; i_614_reset self.i_614 ):
    unit) in 
  let autotrans_phi53_step self (inp_511:(MyOp.t)Array.t) =
    ((let (x_524:float) = self.m_523 in
      let (brake_513:MyOp.t) = Array.get inp_511  1 in
      let (throttle_522:MyOp.t) = Array.get inp_511  0 in
      let (((rpm_519:MyOp.t) , (gear_514:MyOp.t) , (speed_520:MyOp.t)) ,
           (rob_optim_517:MyOp.t)) =
          i_615_step self.i_615
            ((MyOp.make x_524) , (throttle_522 , brake_513)) in
      let (outp_515:(MyOp.t)Array.t) =
          Array.of_list ((::) (rpm_519 ,
                               ((::) (gear_514 , ((::) (speed_520 , ([]))))))) in
      let (rob_spec_518:MyOp.t) = i_614_step self.i_614 (inp_511 , outp_515) in
      let (rob_516:MyOp.t) =
          if Discrete_obs_fad.isFalse rob_spec_518
          then rob_spec_518
          else
            if Discrete_obs_fad.isTrue rob_optim_517
            then rob_optim_517
            else rob_spec_518 in
      self.m_523 <- (+.) x_524  tstep_512 ; (x_524 , rob_516)):float * MyOp.t) in
  Node { alloc = autotrans_phi53_alloc; reset = autotrans_phi53_reset ;
                                        step = autotrans_phi53_step }
type ('c , 'b , 'a) _autotrans_phi54 =
  { mutable i_617 : 'c ; mutable i_616 : 'b ; mutable m_537 : 'a }

let autotrans_phi54 (tstep_526:float) = 
  let Node { alloc = i_617_alloc; step = i_617_step ; reset = i_617_reset } = Autotransd_modes.autotrans 
   in 
  let Node { alloc = i_616_alloc; step = i_616_step ; reset = i_616_reset } = 
  phi54 tstep_526  in
  let autotrans_phi54_alloc _ =
    ();
    { m_537 = (42.:float);
      i_617 = i_617_alloc () (* discrete *)  ;
      i_616 = i_616_alloc () (* discrete *)  } in
  let autotrans_phi54_reset self  =
    ((self.m_537 <- 0. ; i_617_reset self.i_617  ; i_616_reset self.i_616 ):
    unit) in 
  let autotrans_phi54_step self (inp_525:(MyOp.t)Array.t) =
    ((let (x_538:float) = self.m_537 in
      let (brake_527:MyOp.t) = Array.get inp_525  1 in
      let (throttle_536:MyOp.t) = Array.get inp_525  0 in
      let (((rpm_533:MyOp.t) , (gear_528:MyOp.t) , (speed_534:MyOp.t)) ,
           (rob_optim_531:MyOp.t)) =
          i_617_step self.i_617
            ((MyOp.make x_538) , (throttle_536 , brake_527)) in
      let (outp_529:(MyOp.t)Array.t) =
          Array.of_list ((::) (rpm_533 ,
                               ((::) (gear_528 , ((::) (speed_534 , ([]))))))) in
      let (rob_spec_532:MyOp.t) = i_616_step self.i_616 (inp_525 , outp_529) in
      let (rob_530:MyOp.t) =
          if Discrete_obs_fad.isFalse rob_spec_532
          then rob_spec_532
          else
            if Discrete_obs_fad.isTrue rob_optim_531
            then rob_optim_531
            else rob_spec_532 in
      self.m_537 <- (+.) x_538  tstep_526 ; (x_538 , rob_530)):float * MyOp.t) in
  Node { alloc = autotrans_phi54_alloc; reset = autotrans_phi54_reset ;
                                        step = autotrans_phi54_step }
type ('c , 'b , 'a) _autotrans_phi6a =
  { mutable i_619 : 'c ; mutable i_618 : 'b ; mutable m_549 : 'a }

let autotrans_phi6a (tstep_540:float) = 
  let Node { alloc = i_619_alloc; step = i_619_step ; reset = i_619_reset } = Autotransd.autotrans 
   in 
  let Node { alloc = i_618_alloc; step = i_618_step ; reset = i_618_reset } = 
  phi6a tstep_540  in
  let autotrans_phi6a_alloc _ =
    ();
    { m_549 = (42.:float);
      i_619 = i_619_alloc () (* discrete *)  ;
      i_618 = i_618_alloc () (* discrete *)  } in
  let autotrans_phi6a_reset self  =
    ((self.m_549 <- 0. ; i_619_reset self.i_619  ; i_618_reset self.i_618 ):
    unit) in 
  let autotrans_phi6a_step self (inp_539:(MyOp.t)Array.t) =
    ((let (x_550:float) = self.m_549 in
      let (brake_541:MyOp.t) = Array.get inp_539  1 in
      let (throttle_548:MyOp.t) = Array.get inp_539  0 in
      let ((rpm_545:MyOp.t) , (gear_542:MyOp.t) , (speed_546:MyOp.t)) =
          i_619_step self.i_619
            ((MyOp.make x_550) , (throttle_548 , brake_541)) in
      let (outp_543:(MyOp.t)Array.t) =
          Array.of_list ((::) (rpm_545 ,
                               ((::) (gear_542 , ((::) (speed_546 , ([]))))))) in
      let (rob_544:MyOp.t) = i_618_step self.i_618 (inp_539 , outp_543) in
      self.m_549 <- (+.) x_550  tstep_540 ; (x_550 , rob_544)):float * MyOp.t) in
  Node { alloc = autotrans_phi6a_alloc; reset = autotrans_phi6a_reset ;
                                        step = autotrans_phi6a_step }
type ('c , 'b , 'a) _autotrans_phi6b =
  { mutable i_621 : 'c ; mutable i_620 : 'b ; mutable m_561 : 'a }

let autotrans_phi6b (tstep_552:float) = 
  let Node { alloc = i_621_alloc; step = i_621_step ; reset = i_621_reset } = Autotransd.autotrans 
   in 
  let Node { alloc = i_620_alloc; step = i_620_step ; reset = i_620_reset } = 
  phi6b tstep_552  in
  let autotrans_phi6b_alloc _ =
    ();
    { m_561 = (42.:float);
      i_621 = i_621_alloc () (* discrete *)  ;
      i_620 = i_620_alloc () (* discrete *)  } in
  let autotrans_phi6b_reset self  =
    ((self.m_561 <- 0. ; i_621_reset self.i_621  ; i_620_reset self.i_620 ):
    unit) in 
  let autotrans_phi6b_step self (inp_551:(MyOp.t)Array.t) =
    ((let (x_562:float) = self.m_561 in
      let (brake_553:MyOp.t) = Array.get inp_551  1 in
      let (throttle_560:MyOp.t) = Array.get inp_551  0 in
      let ((rpm_557:MyOp.t) , (gear_554:MyOp.t) , (speed_558:MyOp.t)) =
          i_621_step self.i_621
            ((MyOp.make x_562) , (throttle_560 , brake_553)) in
      let (outp_555:(MyOp.t)Array.t) =
          Array.of_list ((::) (rpm_557 ,
                               ((::) (gear_554 , ((::) (speed_558 , ([]))))))) in
      let (rob_556:MyOp.t) = i_620_step self.i_620 (inp_551 , outp_555) in
      self.m_561 <- (+.) x_562  tstep_552 ; (x_562 , rob_556)):float * MyOp.t) in
  Node { alloc = autotrans_phi6b_alloc; reset = autotrans_phi6b_reset ;
                                        step = autotrans_phi6b_step }
type ('c , 'b , 'a) _autotrans_phi6c =
  { mutable i_623 : 'c ; mutable i_622 : 'b ; mutable m_573 : 'a }

let autotrans_phi6c (tstep_564:float) = 
  let Node { alloc = i_623_alloc; step = i_623_step ; reset = i_623_reset } = Autotransd.autotrans 
   in 
  let Node { alloc = i_622_alloc; step = i_622_step ; reset = i_622_reset } = 
  phi6c tstep_564  in
  let autotrans_phi6c_alloc _ =
    ();
    { m_573 = (42.:float);
      i_623 = i_623_alloc () (* discrete *)  ;
      i_622 = i_622_alloc () (* discrete *)  } in
  let autotrans_phi6c_reset self  =
    ((self.m_573 <- 0. ; i_623_reset self.i_623  ; i_622_reset self.i_622 ):
    unit) in 
  let autotrans_phi6c_step self (inp_563:(MyOp.t)Array.t) =
    ((let (x_574:float) = self.m_573 in
      let (brake_565:MyOp.t) = Array.get inp_563  1 in
      let (throttle_572:MyOp.t) = Array.get inp_563  0 in
      let ((rpm_569:MyOp.t) , (gear_566:MyOp.t) , (speed_570:MyOp.t)) =
          i_623_step self.i_623
            ((MyOp.make x_574) , (throttle_572 , brake_565)) in
      let (outp_567:(MyOp.t)Array.t) =
          Array.of_list ((::) (rpm_569 ,
                               ((::) (gear_566 , ((::) (speed_570 , ([]))))))) in
      let (rob_568:MyOp.t) = i_622_step self.i_622 (inp_563 , outp_567) in
      self.m_573 <- (+.) x_574  tstep_564 ; (x_574 , rob_568)):float * MyOp.t) in
  Node { alloc = autotrans_phi6c_alloc; reset = autotrans_phi6c_reset ;
                                        step = autotrans_phi6c_step }
type ('b , 'a) _sanity_check =
  { mutable i_624 : 'b ; mutable m_579 : 'a }

let sanity_check (tstep_576:float) = 
  let Node { alloc = i_624_alloc; step = i_624_step ; reset = i_624_reset } = Sanity_check.model 
   in
  let sanity_check_alloc _ =
    ();{ m_579 = (42.:float);i_624 = i_624_alloc () (* discrete *)  } in
  let sanity_check_reset self  =
    ((i_624_reset self.i_624  ; self.m_579 <- 0.):unit) in 
  let sanity_check_step self (inp_575:('a5798)Array.t) =
    ((let (rob_577:'a5798) = i_624_step self.i_624 inp_575 in
      let (x_580:float) = self.m_579 in
      self.m_579 <- (+.) x_580  tstep_576 ; (x_580 , rob_577)):float * 'a) in
  Node { alloc = sanity_check_alloc; reset = sanity_check_reset ;
                                     step = sanity_check_step }
