(* The Zélus compiler, version 2.0
  (lundi 25 mai 2020, 14:33:03 (UTC+0200)) *)
open Ztypes
type state__3864 = Autotransd_modes_I_214
type state__3863 =
Autotransd_modes_UpShifting_246
| Autotransd_modes_DownShifting_245 | Autotransd_modes_SteadyState_244 
type state__3862 =
Autotransd_modes_Fourth_243
| Autotransd_modes_Third_242
| Autotransd_modes_Second_241 | Autotransd_modes_First_240 
type state__3861 =
Autotransd_modes_UpShifting_171
| Autotransd_modes_DownShifting_170 | Autotransd_modes_SteadyState_169 
type state__3860 =
Autotransd_modes_Fourth_168
| Autotransd_modes_Third_167
| Autotransd_modes_Second_166 | Autotransd_modes_First_165 
type state__3859 =
Autotransd_modes_UpShifting_125
| Autotransd_modes_DownShifting_124 | Autotransd_modes_SteadyState_123 
type state__3858 =
Autotransd_modes_Fourth_122
| Autotransd_modes_Third_121
| Autotransd_modes_Second_120 | Autotransd_modes_First_119 
type state__3857 =
Autotransd_modes_Fourth_108
| Autotransd_modes_Third_107
| Autotransd_modes_Second_106 | Autotransd_modes_First_105 
open MyOp
let zero_val = MyOp.make 0.

let gear1 = MyOp.make 1.

let gear2 = MyOp.make 2.

let gear3 = MyOp.make 3.

let gear4 = MyOp.make 4.

let string_of_op_t (v_387:MyOp.t) =
  string_of_float (MyOp.get v_387)

type ('c , 'b , 'a) _integrate_and_saturate =
  { mutable i_402 : 'c ; mutable m_399 : 'b ; mutable m_396 : 'a }

let integrate_and_saturate  = 
  
  let integrate_and_saturate_alloc _ =
    ();
    { i_402 = (false:bool) ;
      m_399 = (create ():MyOp.t) ; m_396 = (create ():MyOp.t) } in
  let integrate_and_saturate_reset self  =
    (self.i_402 <- true:unit) in 
  let integrate_and_saturate_step self ((t_389:MyOp.t) ,
                                        (dx_388:MyOp.t) ,
                                        (x0_390:MyOp.t) ,
                                        (xmin_392:MyOp.t) , (xmax_391:MyOp.t)) =
    ((let (x_398:MyOp.t) =
          if self.i_402 then t_389 else MyOp.(-) t_389  self.m_396 in
      let (x_401:MyOp.t) =
          if self.i_402
          then x0_390
          else MyOp.(+) self.m_399  (MyOp.( * ) dx_388  x_398) in
      self.i_402 <- false ;
      (let (x_395:MyOp.t) = MyOp.max xmin_392  (MyOp.min xmax_391  x_401) in
       self.m_399 <- x_401 ; self.m_396 <- t_389 ; x_395)):MyOp.t) in
  Node { alloc = integrate_and_saturate_alloc; reset = integrate_and_saturate_reset
                                               ;
                                               step = integrate_and_saturate_step }
type ('b , 'a) _engine =
  { mutable i_654 : 'b ; mutable m_410 : 'a }

let engine  = 
  let Node { alloc = i_654_alloc; step = i_654_step ; reset = i_654_reset } = integrate_and_saturate 
   in
  let engine_alloc _ =
    ();
    { m_410 = (create ():MyOp.t);i_654 = i_654_alloc () (* discrete *)  } in
  let engine_reset self  =
    (i_654_reset self.i_654 :unit) in 
  let engine_step self ((t_403:MyOp.t) ,
                        (ti_405:MyOp.t) , (throttle_404:MyOp.t)) =
    ((let (te_408:MyOp.t) =
          Common_myop.lookup_engine (throttle_404 , self.m_410) in
      let (drpm_406:MyOp.t) = MyOp.(-) te_408  ti_405 in
      let (rpm_407:MyOp.t) =
          i_654_step self.i_654
            (t_403 ,
             (MyOp.scale drpm_406  Common_myop.engine_feedback_gain) ,
             (MyOp.make 1000.) , (MyOp.make 600.) , (MyOp.make 6000.)) in
      self.m_410 <- rpm_407 ; rpm_407):MyOp.t) in
  Node { alloc = engine_alloc; reset = engine_reset ; step = engine_step }
type ('d , 'c , 'b , 'a) _gearlogic =
  { mutable i_422 : 'd ;
    mutable nx_421 : 'c ; mutable r_420 : 'b ; mutable s_419 : 'a }

let gearlogic  = 
  
  let gearlogic_alloc _ =
    ();
    { i_422 = (false:bool) ;
      nx_421 = (create ():MyOp.t) ;
      r_420 = (false:bool) ;
      s_419 = (Autotransd_modes_Fourth_108:state__3857) } in
  let gearlogic_reset self  =
    ((self.i_422 <- true ;
      self.r_420 <- false ; self.s_419 <- Autotransd_modes_First_105):
    unit) in 
  let gearlogic_step self ((shiftv_416:Common_myop.shift) , (shiftp_417:bool)) =
    (((if self.i_422 then self.nx_421 <- gear1) ;
      self.i_422 <- false ;
      (let (gear_418:MyOp.t) = self.nx_421 in
       (begin match self.s_419 with
              | Autotransd_modes_First_105 ->
                  (if self.r_420 then ()) ;
                  (begin match (shiftv_416 , shiftp_417) with
                         | (Common_myop.UP , true) ->
                             self.nx_421 <- gear2 ;
                             self.r_420 <- true ;
                             self.s_419 <- Autotransd_modes_Second_106
                         | _ -> self.r_420 <- false  end)
              | Autotransd_modes_Second_106 ->
                  (if self.r_420 then ()) ;
                  (begin match (shiftv_416 , shiftp_417) with
                         | (Common_myop.DOWN , true) ->
                             self.nx_421 <- gear1 ;
                             self.r_420 <- true ;
                             self.s_419 <- Autotransd_modes_First_105
                         | (Common_myop.UP , true) ->
                             self.nx_421 <- gear3 ;
                             self.r_420 <- true ;
                             self.s_419 <- Autotransd_modes_Third_107
                         | _ -> self.r_420 <- false  end)
              | Autotransd_modes_Third_107 ->
                  (if self.r_420 then ()) ;
                  (begin match (shiftv_416 , shiftp_417) with
                         | (Common_myop.DOWN , true) ->
                             self.nx_421 <- gear2 ;
                             self.r_420 <- true ;
                             self.s_419 <- Autotransd_modes_Second_106
                         | (Common_myop.UP , true) ->
                             self.nx_421 <- gear4 ;
                             self.r_420 <- true ;
                             self.s_419 <- Autotransd_modes_Fourth_108
                         | _ -> self.r_420 <- false  end)
              | Autotransd_modes_Fourth_108 ->
                  (if self.r_420 then ()) ;
                  (begin match (shiftv_416 , shiftp_417) with
                         | (Common_myop.DOWN , true) ->
                             self.nx_421 <- gear3 ;
                             self.r_420 <- true ;
                             self.s_419 <- Autotransd_modes_Third_107
                         | _ -> self.r_420 <- false  end)
               end) ; gear_418)):MyOp.t) in
  Node { alloc = gearlogic_alloc; reset = gearlogic_reset ;
                                  step = gearlogic_step }
type ('k , 'j , 'i , 'h , 'g , 'f , 'e , 'd , 'c , 'b , 'a) _shiftlogic =
  { mutable i_442 : 'k ;
    mutable nx_441 : 'j ;
    mutable r_436 : 'i ;
    mutable s_435 : 'h ;
    mutable r_434 : 'g ;
    mutable s_433 : 'f ;
    mutable t0_432 : 'e ;
    mutable t0_431 : 'd ;
    mutable rob_428 : 'c ; mutable i_444 : 'b ; mutable go_up_443 : 'a }

let shiftlogic  = 
  
  let shiftlogic_alloc _ =
    ();
    { i_442 = (false:bool) ;
      nx_441 = (create ():MyOp.t) ;
      r_436 = (false:bool) ;
      s_435 = (Autotransd_modes_UpShifting_125:state__3859) ;
      r_434 = (false:bool) ;
      s_433 = (Autotransd_modes_Fourth_122:state__3858) ;
      t0_432 = (create ():MyOp.t) ;
      t0_431 = (create ():MyOp.t) ;
      rob_428 = (create ():MyOp.t) ;
      i_444 = (false:bool) ; go_up_443 = (false:bool) } in
  let shiftlogic_reset self  =
    ((self.i_442 <- true ;
      self.r_436 <- false ;
      self.s_435 <- Autotransd_modes_SteadyState_123 ;
      self.i_444 <- true ;
      self.r_434 <- false ; self.s_433 <- Autotransd_modes_First_119):
    unit) in 
  let shiftlogic_step self ((t_424:MyOp.t) ,
                            (speed_423:MyOp.t) , (throttle_425:MyOp.t)) =
    ((let shiftp_438 = ref (false:bool) in
      let shiftv_437 = ref (Common_myop.DOWN:Common_myop.shift) in
      (if self.i_442 then self.nx_441 <- gear1) ;
      self.i_442 <- false ;
      (let (gear_430:MyOp.t) = self.nx_441 in
       let (dn_th_426:MyOp.t) =
           Common_myop.lookup_interpdn (throttle_425 , gear_430) in
       let (up_th_429:MyOp.t) =
           Common_myop.lookup_interpup (throttle_425 , gear_430) in
       (begin match self.s_435 with
              | Autotransd_modes_SteadyState_123 ->
                  (if self.r_436 then self.i_444 <- true) ;
                  (if self.i_444 then
                   self.go_up_443 <- (>) (MyOp.make (Random.float 1.)) 
                                         (MyOp.make 0.5)) ;
                  self.i_444 <- false ;
                  self.rob_428 <- (if self.go_up_443
                                   then MyOp.(-) up_th_429  speed_423
                                   else MyOp.(-) speed_423  dn_th_426) ;
                  (begin match (((>) speed_423  up_th_429) ,
                                ((<) speed_423  dn_th_426)) with
                         | (_ , true) ->
                             self.t0_431 <- t_424 ;
                             self.r_436 <- true ;
                             self.s_435 <- Autotransd_modes_DownShifting_124
                         | (true , _) ->
                             self.t0_432 <- t_424 ;
                             self.r_436 <- true ;
                             self.s_435 <- Autotransd_modes_UpShifting_125
                         | _ -> self.r_436 <- false  end)
              | Autotransd_modes_DownShifting_124 ->
                  (if self.r_436 then ()) ;
                  self.rob_428 <- zero_val ;
                  (begin match (((>) t_424 
                                     (MyOp.translate self.t0_431 
                                                     Common_myop.twait)) ,
                                ((>) speed_423  dn_th_426)) with
                         | (_ , true) ->
                             self.r_436 <- true ;
                             self.s_435 <- Autotransd_modes_SteadyState_123
                         | (true , _) ->
                             shiftp_438 := true ;
                             shiftv_437 := Common_myop.DOWN ;
                             self.r_436 <- true ;
                             self.s_435 <- Autotransd_modes_SteadyState_123
                         | _ -> self.r_436 <- false  end)
              | Autotransd_modes_UpShifting_125 ->
                  (if self.r_436 then ()) ;
                  self.rob_428 <- zero_val ;
                  (begin match (((>) t_424 
                                     (MyOp.translate self.t0_432 
                                                     Common_myop.twait)) ,
                                ((<) speed_423  up_th_429)) with
                         | (_ , true) ->
                             self.r_436 <- true ;
                             self.s_435 <- Autotransd_modes_SteadyState_123
                         | (true , _) ->
                             shiftp_438 := true ;
                             shiftv_437 := Common_myop.UP ;
                             self.r_436 <- true ;
                             self.s_435 <- Autotransd_modes_SteadyState_123
                         | _ -> self.r_436 <- false  end)
               end) ;
       (begin match self.s_433 with
              | Autotransd_modes_First_119 ->
                  (if self.r_434 then ()) ;
                  (begin match (!shiftv_437 , !shiftp_438) with
                         | (Common_myop.UP , true) ->
                             self.nx_441 <- gear2 ;
                             self.r_434 <- true ;
                             self.s_433 <- Autotransd_modes_Second_120
                         | _ -> self.r_434 <- false  end)
              | Autotransd_modes_Second_120 ->
                  (if self.r_434 then ()) ;
                  (begin match (!shiftv_437 , !shiftp_438) with
                         | (Common_myop.DOWN , true) ->
                             self.nx_441 <- gear1 ;
                             self.r_434 <- true ;
                             self.s_433 <- Autotransd_modes_First_119
                         | (Common_myop.UP , true) ->
                             self.nx_441 <- gear3 ;
                             self.r_434 <- true ;
                             self.s_433 <- Autotransd_modes_Third_121
                         | _ -> self.r_434 <- false  end)
              | Autotransd_modes_Third_121 ->
                  (if self.r_434 then ()) ;
                  (begin match (!shiftv_437 , !shiftp_438) with
                         | (Common_myop.DOWN , true) ->
                             self.nx_441 <- gear2 ;
                             self.r_434 <- true ;
                             self.s_433 <- Autotransd_modes_Second_120
                         | (Common_myop.UP , true) ->
                             self.nx_441 <- gear4 ;
                             self.r_434 <- true ;
                             self.s_433 <- Autotransd_modes_Fourth_122
                         | _ -> self.r_434 <- false  end)
              | Autotransd_modes_Fourth_122 ->
                  (if self.r_434 then ()) ;
                  (begin match (!shiftv_437 , !shiftp_438) with
                         | (Common_myop.DOWN , true) ->
                             self.nx_441 <- gear3 ;
                             self.r_434 <- true ;
                             self.s_433 <- Autotransd_modes_Third_121
                         | _ -> self.r_434 <- false  end)
               end) ; (gear_430 , self.rob_428))):MyOp.t * MyOp.t) in
  Node { alloc = shiftlogic_alloc; reset = shiftlogic_reset ;
                                   step = shiftlogic_step }
type ('d , 'c , 'b , 'a) _vehicle =
  { mutable i_469 : 'd ;
    mutable m_466 : 'c ; mutable m_464 : 'b ; mutable m_461 : 'a }

let vehicle  = 
  
  let vehicle_alloc _ =
    ();
    { i_469 = (false:bool) ;
      m_466 = (create ():MyOp.t) ;
      m_464 = (create ():MyOp.t) ; m_461 = (create ():MyOp.t) } in
  let vehicle_reset self  =
    (self.i_469 <- true:unit) in 
  let vehicle_step self ((t_447:MyOp.t) ,
                         (out_torque_446:MyOp.t) , (brake_torque_445:MyOp.t)) =
    ((let (final_drive_ratio_450:MyOp.t) =
          MyOp.scale out_torque_446  Common_myop.p_final_drive_ratio in
      let (aux1_448:MyOp.t) = MyOp.(-) final_drive_ratio_450  self.m_464 in
      let (vehicle_inertia_459:MyOp.t) =
          MyOp.scale aux1_448  Common_myop.iv_inv in
      let (x_463:MyOp.t) =
          if self.i_469 then t_447 else MyOp.(-) t_447  self.m_461 in
      let (x_468:MyOp.t) =
          if self.i_469
          then MyOp.make Common_myop.p_initial_wheel_speed
          else MyOp.(+) self.m_466  (MyOp.( * ) vehicle_inertia_459  x_463) in
      self.i_469 <- false ;
      (let (linear_speed_451:MyOp.t) =
           MyOp.scale x_468  Common_myop.l_speed_coef in
       let (mph_452:MyOp.t) = MyOp.scale linear_speed_451  Common_myop.p_mph in
       let (trans_rpm_458:MyOp.t) =
           MyOp.scale x_468  Common_myop.p_final_drive_ratio in
       self.m_466 <- x_468 ;
       (let (road_load_453:MyOp.t) =
            MyOp.translate (MyOp.scale (MyOp.sqr mph_452) 
                                       Common_myop.p_aerodynamic_drag) 
                           Common_myop.p_drag_friction in
        let (brake_449:MyOp.t) = MyOp.(+) brake_torque_445  road_load_453 in
        let (sgn_454:MyOp.t) =
            if (>=) mph_452  zero_val then MyOp.make 1. else MyOp.make (-1.) in
        let (signed_load_455:MyOp.t) = MyOp.( * ) sgn_454  brake_449 in
        self.m_464 <- signed_load_455 ;
        self.m_461 <- t_447 ; (mph_452 , trans_rpm_458)))):MyOp.t * MyOp.t) in
  Node { alloc = vehicle_alloc; reset = vehicle_reset ; step = vehicle_step }
open Scope
type ('q ,
      'p ,
      'o ,
      'n , 'm , 'l , 'k , 'j , 'i , 'h , 'g , 'f , 'e , 'd , 'c , 'b , 'a) _autotrans =
  { mutable i_655 : 'q ;
    mutable i_540 : 'p ;
    mutable m_537 : 'o ;
    mutable m_535 : 'n ;
    mutable m_532 : 'm ;
    mutable m_530 : 'l ;
    mutable m_528 : 'k ;
    mutable nx_527 : 'j ;
    mutable r_522 : 'i ;
    mutable s_521 : 'h ;
    mutable r_520 : 'g ;
    mutable s_519 : 'f ;
    mutable t0_489 : 'e ;
    mutable t0_488 : 'd ;
    mutable rob_485 : 'c ; mutable i_542 : 'b ; mutable go_up_541 : 'a }

let autotrans  = 
  let Node { alloc = i_655_alloc; step = i_655_step ; reset = i_655_reset } = engine 
   in
  let autotrans_alloc _ =
    ();
    { i_540 = (false:bool) ;
      m_537 = (create ():MyOp.t) ;
      m_535 = (create ():MyOp.t) ;
      m_532 = (create ():MyOp.t) ;
      m_530 = (create ():MyOp.t) ;
      m_528 = (create ():MyOp.t) ;
      nx_527 = (create ():MyOp.t) ;
      r_522 = (false:bool) ;
      s_521 = (Autotransd_modes_UpShifting_171:state__3861) ;
      r_520 = (false:bool) ;
      s_519 = (Autotransd_modes_Fourth_168:state__3860) ;
      t0_489 = (create ():MyOp.t) ;
      t0_488 = (create ():MyOp.t) ;
      rob_485 = (create ():MyOp.t) ;
      i_542 = (false:bool) ; go_up_541 = (false:bool);
      i_655 = i_655_alloc () (* discrete *)  } in
  let autotrans_reset self  =
    ((self.i_540 <- true ;
      i_655_reset self.i_655  ;
      self.r_522 <- false ;
      self.s_521 <- Autotransd_modes_SteadyState_169 ;
      self.i_542 <- true ;
      self.r_520 <- false ; self.s_519 <- Autotransd_modes_First_165):
    unit) in 
  let autotrans_step self ((t_471:MyOp.t) ,
                           ((throttle_472:MyOp.t) , (brake_torque_470:MyOp.t))) =
    ((let shiftp_524 = ref (false:bool) in
      let shiftv_523 = ref (Common_myop.DOWN:Common_myop.shift) in
      (if self.i_540 then self.nx_527 <- gear1) ;
      (let (gear_487:MyOp.t) = self.nx_527 in
       let (gear_lookup_500:MyOp.t) = Common_myop.lookup_gear gear_487 in
       let (nin_501:MyOp.t) = MyOp.( * ) self.m_530  gear_lookup_500 in
       let ((ti_494:MyOp.t) , (turbine_torque_496:MyOp.t)) =
           Common_myop.torque_converter (self.m_528 , nin_501) in
       let (tout_502:MyOp.t) = MyOp.( * ) turbine_torque_496  gear_lookup_500 in
       let (final_drive_ratio_508:MyOp.t) =
           MyOp.scale tout_502  Common_myop.p_final_drive_ratio in
       let (aux1_506:MyOp.t) = MyOp.(-) final_drive_ratio_508  self.m_535 in
       let (vehicle_inertia_517:MyOp.t) =
           MyOp.scale aux1_506  Common_myop.iv_inv in
       let (x_534:MyOp.t) =
           if self.i_540 then t_471 else MyOp.(-) t_471  self.m_532 in
       let (x_539:MyOp.t) =
           if self.i_540
           then MyOp.make Common_myop.p_initial_wheel_speed
           else MyOp.(+) self.m_537  (MyOp.( * ) vehicle_inertia_517  x_534) in
       self.i_540 <- false ;
       self.m_537 <- x_539 ;
       (let (linear_speed_509:MyOp.t) =
            MyOp.scale x_539  Common_myop.l_speed_coef in
        let (mph_510:MyOp.t) = MyOp.scale linear_speed_509  Common_myop.p_mph in
        let (road_load_511:MyOp.t) =
            MyOp.translate (MyOp.scale (MyOp.sqr mph_510) 
                                       Common_myop.p_aerodynamic_drag) 
                           Common_myop.p_drag_friction in
        let (brake_507:MyOp.t) = MyOp.(+) brake_torque_470  road_load_511 in
        let (sgn_512:MyOp.t) =
            if (>=) mph_510  zero_val then MyOp.make 1. else MyOp.make (-1.) in
        let (signed_load_513:MyOp.t) = MyOp.( * ) sgn_512  brake_507 in
        self.m_535 <- signed_load_513 ;
        self.m_532 <- t_471 ;
        (let (trans_rpm_516:MyOp.t) =
             MyOp.scale x_539  Common_myop.p_final_drive_ratio in
         self.m_530 <- trans_rpm_516 ;
         (let (rpm_476:MyOp.t) =
              i_655_step self.i_655 (t_471 , ti_494 , throttle_472) in
          self.m_528 <- rpm_476 ;
          (let (dn_th_483:MyOp.t) =
               Common_myop.lookup_interpdn (throttle_472 , gear_487) in
           let (up_th_486:MyOp.t) =
               Common_myop.lookup_interpup (throttle_472 , gear_487) in
           (begin match self.s_521 with
                  | Autotransd_modes_SteadyState_169 ->
                      (if self.r_522 then self.i_542 <- true) ;
                      (if self.i_542 then
                       self.go_up_541 <- (>) (MyOp.make (Random.float 1.)) 
                                             (MyOp.make 0.5)) ;
                      self.i_542 <- false ;
                      self.rob_485 <- (if self.go_up_541
                                       then MyOp.(-) up_th_486  mph_510
                                       else MyOp.(-) mph_510  dn_th_483) ;
                      (begin match (((>) mph_510  up_th_486) ,
                                    ((<) mph_510  dn_th_483)) with
                             | (_ , true) ->
                                 self.t0_488 <- t_471 ;
                                 self.r_522 <- true ;
                                 self.s_521 <- Autotransd_modes_DownShifting_170
                             | (true , _) ->
                                 self.t0_489 <- t_471 ;
                                 self.r_522 <- true ;
                                 self.s_521 <- Autotransd_modes_UpShifting_171
                             | _ -> self.r_522 <- false  end)
                  | Autotransd_modes_DownShifting_170 ->
                      (if self.r_522 then ()) ;
                      self.rob_485 <- zero_val ;
                      (begin match (((>) t_471 
                                         (MyOp.translate self.t0_488 
                                                         Common_myop.twait))
                                    , ((>) mph_510  dn_th_483)) with
                             | (_ , true) ->
                                 self.r_522 <- true ;
                                 self.s_521 <- Autotransd_modes_SteadyState_169
                             | (true , _) ->
                                 shiftp_524 := true ;
                                 shiftv_523 := Common_myop.DOWN ;
                                 self.r_522 <- true ;
                                 self.s_521 <- Autotransd_modes_SteadyState_169
                             | _ -> self.r_522 <- false  end)
                  | Autotransd_modes_UpShifting_171 ->
                      (if self.r_522 then ()) ;
                      self.rob_485 <- zero_val ;
                      (begin match (((>) t_471 
                                         (MyOp.translate self.t0_489 
                                                         Common_myop.twait))
                                    , ((<) mph_510  up_th_486)) with
                             | (_ , true) ->
                                 self.r_522 <- true ;
                                 self.s_521 <- Autotransd_modes_SteadyState_169
                             | (true , _) ->
                                 shiftp_524 := true ;
                                 shiftv_523 := Common_myop.UP ;
                                 self.r_522 <- true ;
                                 self.s_521 <- Autotransd_modes_SteadyState_169
                             | _ -> self.r_522 <- false  end)
                   end) ;
           (begin match self.s_519 with
                  | Autotransd_modes_First_165 ->
                      (if self.r_520 then ()) ;
                      (begin match (!shiftv_523 , !shiftp_524) with
                             | (Common_myop.UP , true) ->
                                 self.nx_527 <- gear2 ;
                                 self.r_520 <- true ;
                                 self.s_519 <- Autotransd_modes_Second_166
                             | _ -> self.r_520 <- false  end)
                  | Autotransd_modes_Second_166 ->
                      (if self.r_520 then ()) ;
                      (begin match (!shiftv_523 , !shiftp_524) with
                             | (Common_myop.DOWN , true) ->
                                 self.nx_527 <- gear1 ;
                                 self.r_520 <- true ;
                                 self.s_519 <- Autotransd_modes_First_165
                             | (Common_myop.UP , true) ->
                                 self.nx_527 <- gear3 ;
                                 self.r_520 <- true ;
                                 self.s_519 <- Autotransd_modes_Third_167
                             | _ -> self.r_520 <- false  end)
                  | Autotransd_modes_Third_167 ->
                      (if self.r_520 then ()) ;
                      (begin match (!shiftv_523 , !shiftp_524) with
                             | (Common_myop.DOWN , true) ->
                                 self.nx_527 <- gear2 ;
                                 self.r_520 <- true ;
                                 self.s_519 <- Autotransd_modes_Second_166
                             | (Common_myop.UP , true) ->
                                 self.nx_527 <- gear4 ;
                                 self.r_520 <- true ;
                                 self.s_519 <- Autotransd_modes_Fourth_168
                             | _ -> self.r_520 <- false  end)
                  | Autotransd_modes_Fourth_168 ->
                      (if self.r_520 then ()) ;
                      (begin match (!shiftv_523 , !shiftp_524) with
                             | (Common_myop.DOWN , true) ->
                                 self.nx_527 <- gear3 ;
                                 self.r_520 <- true ;
                                 self.s_519 <- Autotransd_modes_Third_167
                             | _ -> self.r_520 <- false  end)
                   end) ; ((rpm_476 , gear_487 , mph_510) , self.rob_485))))))):
    (MyOp.t * MyOp.t * MyOp.t) * MyOp.t) in
  Node { alloc = autotrans_alloc; reset = autotrans_reset ;
                                  step = autotrans_step }
open Discrete_obs_fad
type ('a) _phi =
  { mutable i_656 : 'a }

let phi  = 
  let Node { alloc = i_656_alloc; step = i_656_step ; reset = i_656_reset } = 
  Discrete_obs_fad.always_timed 10.  in
  let phi_alloc _ =
    ();{ i_656 = i_656_alloc () (* discrete *)  } in
  let phi_reset self  =
    (i_656_reset self.i_656 :unit) in 
  let phi_step self (((tstep_548:float) ,
                      ((throttle_547:MyOp.t) , (brake_543:MyOp.t)) ,
                      ((rpm_545:MyOp.t) ,
                       (gear_544:MyOp.t) , (speed_546:MyOp.t))): (float  *
                                                                  (MyOp.t  *
                                                                   MyOp.t)  *
                                                                  (MyOp.t  *
                                                                   MyOp.t  *
                                                                   MyOp.t))) =
    (i_656_step self.i_656
       ((MyOp.make tstep_548) ,
        (Discrete_obs_fad.q_lt (rpm_545 , (MyOp.make 4750.)))):MyOp.t) in
  Node { alloc = phi_alloc; reset = phi_reset ; step = phi_step }
type ('g1 ,
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
      'n , 'm , 'l , 'k , 'j , 'i , 'h , 'g , 'f , 'e , 'd , 'c , 'b , 'a) _main =
  { mutable i_664 : 'g1 ;
    mutable i_663 : 'f1 ;
    mutable i_662 : 'e1 ;
    mutable i_661 : 'd1 ;
    mutable i_660 : 'c1 ;
    mutable i_659 : 'b1 ;
    mutable i_658 : 'a1 ;
    mutable i_657 : 'z ;
    mutable i_647 : 'y ;
    mutable m_644 : 'x ;
    mutable m_641 : 'w ;
    mutable m_639 : 'v ;
    mutable m_636 : 'u ;
    mutable m_634 : 't ;
    mutable m_632 : 's ;
    mutable nx_631 : 'r ;
    mutable m_629 : 'q ;
    mutable r_624 : 'p ;
    mutable s_623 : 'o ;
    mutable r_622 : 'n ;
    mutable s_621 : 'm ;
    mutable r_620 : 'l ;
    mutable s_619 : 'k ;
    mutable t0_576 : 'j ;
    mutable t0_575 : 'i ;
    mutable rob_572 : 'h ;
    mutable th_552 : 'g ;
    mutable br_551 : 'f ;
    mutable i_651 : 'e ;
    mutable m_649 : 'd ;
    mutable local_t_648 : 'c ; mutable i_653 : 'b ; mutable go_up_652 : 'a }

let main  = 
  let Node { alloc = i_664_alloc; step = i_664_step ; reset = i_664_reset } = engine 
   in 
  let Node { alloc = i_663_alloc; step = i_663_step ; reset = i_663_reset } = 
  Discrete_obs_fad.always_timed 10.  in 
  let Node { alloc = i_662_alloc; step = i_662_step ; reset = i_662_reset } = Scope.scope2 
   in 
  let Node { alloc = i_661_alloc; step = i_661_step ; reset = i_661_reset } = Scope.scope 
   in 
  let Node { alloc = i_660_alloc; step = i_660_step ; reset = i_660_reset } = Scope.scope 
   in 
  let Node { alloc = i_659_alloc; step = i_659_step ; reset = i_659_reset } = Scope.scope 
   in 
  let Node { alloc = i_658_alloc; step = i_658_step ; reset = i_658_reset } = Scope.scope4 
   in 
  let Node { alloc = i_657_alloc; step = i_657_step ; reset = i_657_reset } = Scope.windown 
   in
  let main_alloc _ =
    ();
    { i_647 = (false:bool) ;
      m_644 = (false:bool) ;
      m_641 = (create ():MyOp.t) ;
      m_639 = (create ():MyOp.t) ;
      m_636 = (create ():MyOp.t) ;
      m_634 = (create ():MyOp.t) ;
      m_632 = (create ():MyOp.t) ;
      nx_631 = (create ():MyOp.t) ;
      m_629 = (42.:float) ;
      r_624 = (false:bool) ;
      s_623 = (Autotransd_modes_I_214:state__3864) ;
      r_622 = (false:bool) ;
      s_621 = (Autotransd_modes_UpShifting_246:state__3863) ;
      r_620 = (false:bool) ;
      s_619 = (Autotransd_modes_Fourth_243:state__3862) ;
      t0_576 = (create ():MyOp.t) ;
      t0_575 = (create ():MyOp.t) ;
      rob_572 = (create ():MyOp.t) ;
      th_552 = (create ():MyOp.t) ;
      br_551 = (create ():MyOp.t) ;
      i_651 = (false:bool) ;
      m_649 = (42.:float) ;
      local_t_648 = (42.:float) ;
      i_653 = (false:bool) ; go_up_652 = (false:bool);
      i_664 = i_664_alloc () (* discrete *)  ;
      i_663 = i_663_alloc () (* discrete *)  ;
      i_662 = i_662_alloc () (* discrete *)  ;
      i_661 = i_661_alloc () (* discrete *)  ;
      i_660 = i_660_alloc () (* discrete *)  ;
      i_659 = i_659_alloc () (* discrete *)  ;
      i_658 = i_658_alloc () (* discrete *)  ;
      i_657 = i_657_alloc () (* discrete *)  } in
  let main_reset self  =
    ((self.i_647 <- true ;
      self.m_629 <- 0. ;
      self.r_624 <- false ;
      self.s_623 <- Autotransd_modes_I_214 ;
      self.i_651 <- true ;
      self.m_649 <- 0. ;
      self.r_622 <- false ;
      self.s_621 <- Autotransd_modes_SteadyState_244 ;
      self.i_653 <- true ;
      i_664_reset self.i_664  ;
      i_663_reset self.i_663  ;
      self.r_620 <- false ;
      self.s_619 <- Autotransd_modes_First_240 ;
      i_662_reset self.i_662  ;
      i_661_reset self.i_661  ;
      i_660_reset self.i_660  ;
      i_659_reset self.i_659  ;
      i_658_reset self.i_658  ; i_657_reset self.i_657 ):unit) in 
  let main_step self () =
    ((let shiftp_626 = ref (false:bool) in
      let shiftv_625 = ref (Common_myop.DOWN:Common_myop.shift) in
      (if self.i_647 then self.nx_631 <- gear1) ;
      (let (gear_574:MyOp.t) = self.nx_631 in
       let (gear_lookup_587:MyOp.t) = Common_myop.lookup_gear gear_574 in
       let (nin_588:MyOp.t) = MyOp.( * ) self.m_634  gear_lookup_587 in
       let ((ti_581:MyOp.t) , (turbine_torque_583:MyOp.t)) =
           Common_myop.torque_converter (self.m_632 , nin_588) in
       let (tout_589:MyOp.t) = MyOp.( * ) turbine_torque_583  gear_lookup_587 in
       let (final_drive_ratio_595:MyOp.t) =
           MyOp.scale tout_589  Common_myop.p_final_drive_ratio in
       let (aux1_593:MyOp.t) = MyOp.(-) final_drive_ratio_595  self.m_639 in
       let (vehicle_inertia_604:MyOp.t) =
           MyOp.scale aux1_593  Common_myop.iv_inv in
       let (x_630:float) = self.m_629 in
       let (t_550:float) = (+.) x_630  0.01 in
       let (t_558:MyOp.t) = MyOp.make t_550 in
       let (x_638:MyOp.t) =
           if self.i_647 then t_558 else MyOp.(-) t_558  self.m_636 in
       let (x_643:MyOp.t) =
           if self.i_647
           then MyOp.make Common_myop.p_initial_wheel_speed
           else MyOp.(+) self.m_641  (MyOp.( * ) vehicle_inertia_604  x_638) in
       (begin match self.s_623 with
              | Autotransd_modes_I_214 ->
                  (if self.r_624 then (self.i_651 <- true ; self.m_649 <- 0.))
                  ;
                  (if self.i_651 then self.br_551 <- MyOp.make 0.) ;
                  (if self.i_651 then self.th_552 <- MyOp.make 100.) ;
                  self.i_651 <- false ;
                  (let (x_650:float) = self.m_649 in
                   self.local_t_648 <- (+.) x_650  0.01 ;
                   self.m_649 <- self.local_t_648 ;
                   (begin match (>=) (MyOp.make self.local_t_648) 
                                     (MyOp.make 5.) with
                          | true ->
                              self.r_624 <- true ;
                              self.s_623 <- Autotransd_modes_I_214
                          | _ -> self.r_624 <- false  end)) end) ;
       (let (linear_speed_596:MyOp.t) =
            MyOp.scale x_643  Common_myop.l_speed_coef in
        let (mph_597:MyOp.t) = MyOp.scale linear_speed_596  Common_myop.p_mph in
        let (dn_th_570:MyOp.t) =
            Common_myop.lookup_interpdn (self.th_552 , gear_574) in
        let (up_th_573:MyOp.t) =
            Common_myop.lookup_interpup (self.th_552 , gear_574) in
        (begin match self.s_621 with
               | Autotransd_modes_SteadyState_244 ->
                   (if self.r_622 then self.i_653 <- true) ;
                   (if self.i_653 then
                    self.go_up_652 <- (>) (MyOp.make (Random.float 1.)) 
                                          (MyOp.make 0.5)) ;
                   self.i_653 <- false ;
                   self.rob_572 <- (if self.go_up_652
                                    then MyOp.(-) up_th_573  mph_597
                                    else MyOp.(-) mph_597  dn_th_570) ;
                   (begin match (((>) mph_597  up_th_573) ,
                                 ((<) mph_597  dn_th_570)) with
                          | (_ , true) ->
                              self.t0_575 <- t_558 ;
                              self.r_622 <- true ;
                              self.s_621 <- Autotransd_modes_DownShifting_245
                          | (true , _) ->
                              self.t0_576 <- t_558 ;
                              self.r_622 <- true ;
                              self.s_621 <- Autotransd_modes_UpShifting_246
                          | _ -> self.r_622 <- false  end)
               | Autotransd_modes_DownShifting_245 ->
                   (if self.r_622 then ()) ;
                   self.rob_572 <- zero_val ;
                   (begin match (((>) t_558 
                                      (MyOp.translate self.t0_575 
                                                      Common_myop.twait)) ,
                                 ((>) mph_597  dn_th_570)) with
                          | (_ , true) ->
                              self.r_622 <- true ;
                              self.s_621 <- Autotransd_modes_SteadyState_244
                          | (true , _) ->
                              shiftp_626 := true ;
                              shiftv_625 := Common_myop.DOWN ;
                              self.r_622 <- true ;
                              self.s_621 <- Autotransd_modes_SteadyState_244
                          | _ -> self.r_622 <- false  end)
               | Autotransd_modes_UpShifting_246 ->
                   (if self.r_622 then ()) ;
                   self.rob_572 <- zero_val ;
                   (begin match (((>) t_558 
                                      (MyOp.translate self.t0_576 
                                                      Common_myop.twait)) ,
                                 ((<) mph_597  up_th_573)) with
                          | (_ , true) ->
                              self.r_622 <- true ;
                              self.s_621 <- Autotransd_modes_SteadyState_244
                          | (true , _) ->
                              shiftp_626 := true ;
                              shiftv_625 := Common_myop.UP ;
                              self.r_622 <- true ;
                              self.s_621 <- Autotransd_modes_SteadyState_244
                          | _ -> self.r_622 <- false  end)
                end) ;
        (let (rpm_563:MyOp.t) =
             i_664_step self.i_664 (t_558 , ti_581 , self.th_552) in
         let (((tstep_612:float) , (_ , _) , ((rpm_609:MyOp.t) , _ , _)): 
             (float  * (MyOp.t  * MyOp.t)  * (MyOp.t  * MyOp.t  * MyOp.t))) =
             (0.01 ,
              (self.th_552 , self.br_551) , (rpm_563 , gear_574 , mph_597)) in
         let (rob_606:MyOp.t) =
             i_663_step self.i_663
               ((MyOp.make tstep_612) ,
                (Discrete_obs_fad.q_lt (rpm_609 , (MyOp.make 4750.)))) in
         let (x_646:bool) =
             if self.i_647
             then (<) rob_606  (MyOp.make 0.)
             else (||) self.m_644  ((<) rob_606  (MyOp.make 0.)) in
         self.i_647 <- false ;
         self.m_629 <- t_550 ;
         self.m_641 <- x_643 ;
         (let (road_load_598:MyOp.t) =
              MyOp.translate (MyOp.scale (MyOp.sqr mph_597) 
                                         Common_myop.p_aerodynamic_drag) 
                             Common_myop.p_drag_friction in
          let (brake_594:MyOp.t) = MyOp.(+) self.br_551  road_load_598 in
          let (sgn_599:MyOp.t) =
              if (>=) mph_597  zero_val
              then MyOp.make 1.
              else MyOp.make (-1.) in
          let (signed_load_600:MyOp.t) = MyOp.( * ) sgn_599  brake_594 in
          self.m_639 <- signed_load_600 ;
          self.m_636 <- t_558 ;
          (let (trans_rpm_603:MyOp.t) =
               MyOp.scale x_643  Common_myop.p_final_drive_ratio in
           self.m_634 <- trans_rpm_603 ;
           self.m_632 <- rpm_563 ;
           (begin match self.s_619 with
                  | Autotransd_modes_First_240 ->
                      (if self.r_620 then ()) ;
                      (begin match (!shiftv_625 , !shiftp_626) with
                             | (Common_myop.UP , true) ->
                                 self.nx_631 <- gear2 ;
                                 self.r_620 <- true ;
                                 self.s_619 <- Autotransd_modes_Second_241
                             | _ -> self.r_620 <- false  end)
                  | Autotransd_modes_Second_241 ->
                      (if self.r_620 then ()) ;
                      (begin match (!shiftv_625 , !shiftp_626) with
                             | (Common_myop.DOWN , true) ->
                                 self.nx_631 <- gear1 ;
                                 self.r_620 <- true ;
                                 self.s_619 <- Autotransd_modes_First_240
                             | (Common_myop.UP , true) ->
                                 self.nx_631 <- gear3 ;
                                 self.r_620 <- true ;
                                 self.s_619 <- Autotransd_modes_Third_242
                             | _ -> self.r_620 <- false  end)
                  | Autotransd_modes_Third_242 ->
                      (if self.r_620 then ()) ;
                      (begin match (!shiftv_625 , !shiftp_626) with
                             | (Common_myop.DOWN , true) ->
                                 self.nx_631 <- gear2 ;
                                 self.r_620 <- true ;
                                 self.s_619 <- Autotransd_modes_Second_241
                             | (Common_myop.UP , true) ->
                                 self.nx_631 <- gear4 ;
                                 self.r_620 <- true ;
                                 self.s_619 <- Autotransd_modes_Fourth_243
                             | _ -> self.r_620 <- false  end)
                  | Autotransd_modes_Fourth_243 ->
                      (if self.r_620 then ()) ;
                      (begin match (!shiftv_625 , !shiftp_626) with
                             | (Common_myop.DOWN , true) ->
                                 self.nx_631 <- gear3 ;
                                 self.r_620 <- true ;
                                 self.s_619 <- Autotransd_modes_Third_242
                             | _ -> self.r_620 <- false  end)
                   end) ;
           self.m_644 <- x_646 ;
           (let (s1_614:Gtkplot.scope) =
                i_662_step self.i_662
                  (0. ,
                   350. ,
                   ("throttle" , Scope.linear , (MyOp.get self.th_552)) ,
                   ("brake" , Scope.linear , (MyOp.get self.br_551))) in
            let (s2_615:Gtkplot.scope) =
                i_661_step self.i_661
                  (0. , 5000. , ("rpm" , Scope.linear , (MyOp.get rpm_563))) in
            let (s3_616:Gtkplot.scope) =
                i_660_step self.i_660
                  (0. , 4. , ("gear" , Scope.linear , (MyOp.get gear_574))) in
            let (s4_617:Gtkplot.scope) =
                i_659_step self.i_659
                  (0. , 130. , ("speed" , Scope.linear , (MyOp.get mph_597))) in
            let (s5_618:Gtkplot.scope) =
                i_658_step self.i_658
                  ((-120.) ,
                   120. ,
                   ("rob" , Scope.linear , (MyOp.get rob_606)) ,
                   ("fals?" ,
                    Scope.linear , (if x_646 then 120. else (-120.))) ,
                   ("mode_rob" , Scope.linear , (MyOp.get self.rob_572)) ,
                   ("" , Scope.linear , 0.)) in
            i_657_step self.i_657
              ("Autotrans" ,
               30. ,
               t_550 ,
               ((::) (s1_614 ,
                      ((::) (s2_615 ,
                             ((::) (s3_616 ,
                                    ((::) (s4_617 , ((::) (s5_618 , ([]))))))))))))))))))):
    unit) in
  Node { alloc = main_alloc; reset = main_reset ; step = main_step }
