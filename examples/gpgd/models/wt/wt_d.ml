(* The Zélus compiler, version 2.1
  (jeudi 27 août 2020, 15:59:00 (UTC+0200)) *)
open Ztypes
open MyOp
open Wt_common
open Wt_params
let saturate ((low_497:MyOp.t) , (high_496:MyOp.t) , (v_498:MyOp.t)) =
  MyOp.min (MyOp.max v_498  low_497)  high_496

type _transport_delay = unit

let transport_delay  = 
   let transport_delay_alloc _ = () in
  let transport_delay_copy source dest = () in
  let transport_delay_reset self  =
    ((()):unit) in 
  let transport_delay_step self ((t_500:'a5171) ,
                                 (delay_499:'a5170) , (y0_501:'a5178)) =
    (y0_501:'a) in
  Cnode { alloc = transport_delay_alloc; copy = transport_delay_copy ;
                                         reset = transport_delay_reset ;
                                         step = transport_delay_step }
type ('e , 'd , 'c , 'b , 'a) _rate_limiter =
  { mutable i_523 : 'e ;
    mutable m_518 : 'd ;
    mutable m_516 : 'c ; mutable m_514 : 'b ; mutable m_511 : 'a }

let rate_limiter  = 
  
  let rate_limiter_alloc _ =
    ();
    { i_523 = (false:bool) ;
      m_518 = (MyOp.create ():MyOp.t) ;
      m_516 = (MyOp.create ():MyOp.t) ;
      m_514 = (MyOp.create ():MyOp.t) ; m_511 = (MyOp.create ():MyOp.t) } in
  let rate_limiter_copy source dest =
    dest.i_523 <- source.i_523 ;
    dest.m_518 <- source.m_518 ;
    dest.m_516 <- source.m_516 ;
    dest.m_514 <- source.m_514 ; dest.m_511 <- source.m_511 in
  let rate_limiter_reset self  =
    (self.i_523 <- true:unit) in 
  let rate_limiter_step self ((t_505:MyOp.t) ,
                              (rising_504:MyOp.t) ,
                              (falling_503:MyOp.t) ,
                              (y0_507:'a5184) , (x_506:MyOp.t)) =
    ((let (x_513:MyOp.t) =
          if self.i_523 then t_505 else MyOp.(-) t_505  self.m_511 in
      let (x_520:MyOp.t) =
          MyOp.(+) (MyOp.( * ) x_513  falling_503)  self.m_518 in
      let (x_521:MyOp.t) =
          MyOp.(+) (MyOp.( * ) x_513  rising_504)  self.m_516 in
      let (rate_508:MyOp.t) = MyOp.(/) (MyOp.(-) x_506  self.m_514)  x_513 in
      let (x_522:MyOp.t) =
          if self.i_523
          then x_506
          else
            if (>) rate_508  rising_504
            then x_521
            else if (<) rate_508  falling_503 then x_520 else x_506 in
      self.i_523 <- false ;
      self.m_518 <- x_522 ;
      self.m_516 <- x_522 ; self.m_514 <- x_522 ; self.m_511 <- t_505 ; x_522):
    MyOp.t) in
  Cnode { alloc = rate_limiter_alloc; copy = rate_limiter_copy ;
                                      reset = rate_limiter_reset ;
                                      step = rate_limiter_step }
type ('c , 'b , 'a) _collective_pitch_with_anti_windup =
  { mutable i_544 : 'c ; mutable m_542 : 'b ; mutable m_539 : 'a }

let collective_pitch_with_anti_windup  = 
  
  let collective_pitch_with_anti_windup_alloc _ =
    ();
    { i_544 = (false:bool) ;
      m_542 = (MyOp.create ():MyOp.t) ; m_539 = (MyOp.create ():MyOp.t) } in
  let collective_pitch_with_anti_windup_copy source dest =
    dest.i_544 <- source.i_544 ;
    dest.m_542 <- source.m_542 ; dest.m_539 <- source.m_539 in
  let collective_pitch_with_anti_windup_reset self  =
    (self.i_544 <- true:unit) in 
  let collective_pitch_with_anti_windup_step self ((t_527:MyOp.t) ,
                                                   (e_524:MyOp.t) ,
                                                   (gs_525:MyOp.t) ,
                                                   (params_526:Wt_params.params)) =
    ((let (y0_537:MyOp.t) =
          MyOp.( * ) params_526.Wt_params.pitch.Wt_params.theta0 
                     (MyOp.translate (MyOp.(/) params_526.Wt_params.pitch.Wt_params.theta0
                                               
                                               params_526.Wt_params.pitch.Wt_params.cpc.Wt_params.gS_factor)
                                      1.) in
      (if self.i_544 then self.m_542 <- y0_537) ;
      (let (x_541:MyOp.t) =
           if self.i_544 then t_527 else MyOp.(-) t_527  self.m_539 in
       self.i_544 <- false ;
       (let (e1_528:MyOp.t) =
            MyOp.( * ) e_524 
                       params_526.Wt_params.pitch.Wt_params.cpc.Wt_params.kP in
        let (x_543:MyOp.t) = self.m_542 in
        let (e4_531:MyOp.t) = MyOp.(+) e1_528  x_543 in
        let (theta_d'_533:MyOp.t) = MyOp.( * ) gs_525  e4_531 in
        let (theta_d_532:MyOp.t) =
            saturate (params_526.Wt_params.pitch.Wt_params.min ,
                      params_526.Wt_params.pitch.Wt_params.max , theta_d'_533) in
        let (e2_529:MyOp.t) =
            MyOp.(-) e1_528 
                     (MyOp.( * ) (MyOp.(-) theta_d'_533  theta_d_532) 
                                 params_526.Wt_params.pitch.Wt_params.cpc.Wt_params.antiWindUp) in
        let (x_536:MyOp.t) =
            MyOp.(/) e2_529 
                     params_526.Wt_params.pitch.Wt_params.cpc.Wt_params.tI in
        self.m_542 <- MyOp.(+) (MyOp.( * ) x_536  x_541)  x_543 ;
        self.m_539 <- t_527 ; theta_d_532))):MyOp.t) in
  Cnode { alloc = collective_pitch_with_anti_windup_alloc; copy = collective_pitch_with_anti_windup_copy
                                                           ;
                                                           reset = collective_pitch_with_anti_windup_reset
                                                           ;
                                                           step = collective_pitch_with_anti_windup_step }
type ('d , 'c , 'b , 'a) _coll_pitch_controller =
  { mutable i_575 : 'd ;
    mutable m_573 : 'c ; mutable m_570 : 'b ; mutable m_568 : 'a }

let coll_pitch_controller  = 
  
  let coll_pitch_controller_alloc _ =
    ();
    { i_575 = (false:bool) ;
      m_573 = (MyOp.create ():MyOp.t) ;
      m_570 = (MyOp.create ():MyOp.t) ; m_568 = (MyOp.create ():MyOp.t) } in
  let coll_pitch_controller_copy source dest =
    dest.i_575 <- source.i_575 ;
    dest.m_573 <- source.m_573 ;
    dest.m_570 <- source.m_570 ; dest.m_568 <- source.m_568 in
  let coll_pitch_controller_reset self  =
    (self.i_575 <- true:unit) in 
  let coll_pitch_controller_step self ((t_548:MyOp.t) ,
                                       (omega_g_545:MyOp.t) ,
                                       (theta_in_549:MyOp.t) ,
                                       (omega_g_rated_546:MyOp.t) ,
                                       (params_547:Wt_params.params)) =
    ((let (y0_566:MyOp.t) =
          MyOp.( * ) params_547.Wt_params.pitch.Wt_params.theta0 
                     (MyOp.translate (MyOp.(/) params_547.Wt_params.pitch.Wt_params.theta0
                                               
                                               params_547.Wt_params.pitch.Wt_params.cpc.Wt_params.gS_factor)
                                      1.) in
      (if self.i_575 then self.m_573 <- y0_566) ;
      (let (x_572:MyOp.t) =
           if self.i_575 then t_548 else MyOp.(-) t_548  self.m_570 in
       (if self.i_575 then
        self.m_568 <- params_547.Wt_params.pitch.Wt_params.theta0) ;
       self.i_575 <- false ;
       (let (e_550:MyOp.t) = MyOp.(-) omega_g_545  omega_g_rated_546 in
        let (e1_557:MyOp.t) =
            MyOp.( * ) e_550 
                       params_547.Wt_params.pitch.Wt_params.cpc.Wt_params.kP in
        let (x_569:MyOp.t) = self.m_568 in
        let (gs_551:MyOp.t) =
            MyOp.inv (MyOp.translate (MyOp.(/) x_569 
                                               params_547.Wt_params.pitch.Wt_params.cpc.Wt_params.gS_factor)
                                      1.) in
        let (x_574:MyOp.t) = self.m_573 in
        let (e4_560:MyOp.t) = MyOp.(+) e1_557  x_574 in
        let (theta_d'_562:MyOp.t) = MyOp.( * ) gs_551  e4_560 in
        let (theta_d_561:MyOp.t) =
            saturate (params_547.Wt_params.pitch.Wt_params.min ,
                      params_547.Wt_params.pitch.Wt_params.max , theta_d'_562) in
        let (e2_558:MyOp.t) =
            MyOp.(-) e1_557 
                     (MyOp.( * ) (MyOp.(-) theta_d'_562  theta_d_561) 
                                 params_547.Wt_params.pitch.Wt_params.cpc.Wt_params.antiWindUp) in
        let (x_565:MyOp.t) =
            MyOp.(/) e2_558 
                     params_547.Wt_params.pitch.Wt_params.cpc.Wt_params.tI in
        self.m_573 <- MyOp.(+) (MyOp.( * ) x_565  x_572)  x_574 ;
        self.m_570 <- t_548 ; self.m_568 <- theta_in_549 ; theta_d_561))):
    MyOp.t) in
  Cnode { alloc = coll_pitch_controller_alloc; copy = coll_pitch_controller_copy
                                               ;
                                               reset = coll_pitch_controller_reset
                                               ;
                                               step = coll_pitch_controller_step }
type ('c , 'b , 'a) _filter_pitch =
  { mutable i_591 : 'c ; mutable m_589 : 'b ; mutable m_586 : 'a }

let filter_pitch  = 
  
  let filter_pitch_alloc _ =
    ();
    { i_591 = (false:bool) ;
      m_589 = (MyOp.create ():MyOp.t) ; m_586 = (MyOp.create ():MyOp.t) } in
  let filter_pitch_copy source dest =
    dest.i_591 <- source.i_591 ;
    dest.m_589 <- source.m_589 ; dest.m_586 <- source.m_586 in
  let filter_pitch_reset self  =
    (self.i_591 <- true:unit) in 
  let filter_pitch_step self ((t_577:MyOp.t) ,
                              (u_578:MyOp.t) , (params_576:Wt_params.params)) =
    ((let (y0_584:MyOp.t) = params_576.Wt_params.pitch.Wt_params.theta0 in
      (if self.i_591 then self.m_589 <- y0_584) ;
      (let (x_588:MyOp.t) =
           if self.i_591 then t_577 else MyOp.(-) t_577  self.m_586 in
       self.i_591 <- false ;
       (let (x_590:MyOp.t) = self.m_589 in
        let (dy_579:MyOp.t) =
            MyOp.(/) (MyOp.(-) u_578  x_590) 
                     params_576.Wt_params.pitch.Wt_params.pitch_filterConstant in
        self.m_589 <- MyOp.(+) (MyOp.( * ) dy_579  x_588)  x_590 ;
        self.m_586 <- t_577 ; x_590))):MyOp.t) in
  Cnode { alloc = filter_pitch_alloc; copy = filter_pitch_copy ;
                                      reset = filter_pitch_reset ;
                                      step = filter_pitch_step }
type ('c , 'b , 'a) _filter_drehzahl =
  { mutable i_607 : 'c ; mutable m_605 : 'b ; mutable m_602 : 'a }

let filter_drehzahl  = 
  
  let filter_drehzahl_alloc _ =
    ();
    { i_607 = (false:bool) ;
      m_605 = (MyOp.create ():MyOp.t) ; m_602 = (MyOp.create ():MyOp.t) } in
  let filter_drehzahl_copy source dest =
    dest.i_607 <- source.i_607 ;
    dest.m_605 <- source.m_605 ; dest.m_602 <- source.m_602 in
  let filter_drehzahl_reset self  =
    (self.i_607 <- true:unit) in 
  let filter_drehzahl_step self ((t_593:MyOp.t) ,
                                 (u_594:MyOp.t) ,
                                 (params_592:Wt_params.params)) =
    ((let (y0_600:MyOp.t) = params_592.Wt_params.omega_g0 in
      (if self.i_607 then self.m_605 <- y0_600) ;
      (let (x_604:MyOp.t) =
           if self.i_607 then t_593 else MyOp.(-) t_593  self.m_602 in
       self.i_607 <- false ;
       (let (x_606:MyOp.t) = self.m_605 in
        let (dy_595:MyOp.t) =
            MyOp.(/) (MyOp.(-) u_594  x_606) 
                     params_592.Wt_params.vscontrol.Wt_params.vs_filterConstant in
        self.m_605 <- MyOp.(+) (MyOp.( * ) dy_595  x_604)  x_606 ;
        self.m_602 <- t_593 ; x_606))):MyOp.t) in
  Cnode { alloc = filter_drehzahl_alloc; copy = filter_drehzahl_copy ;
                                         reset = filter_drehzahl_reset ;
                                         step = filter_drehzahl_step }
let torque_controller ((omega_g_608:MyOp.t) ,
                       (theta_d_610:MyOp.t) , (params_609:Wt_params.params)) =
  let (mg_d_611:MyOp.t) =
      if (||) ((>=) omega_g_608 
                    params_609.Wt_params.vscontrol.Wt_params.rtGnSp) 
              ((>=) theta_d_610 
                    params_609.Wt_params.vscontrol.Wt_params.rgn3MP)
      then
        MyOp.(/) params_609.Wt_params.vscontrol.Wt_params.rtPwr  omega_g_608
      else
        if (<=) omega_g_608  params_609.Wt_params.vscontrol.Wt_params.ctInSp
        then MyOp.make 0.
        else
          if (<) omega_g_608  params_609.Wt_params.vscontrol.Wt_params.rgn2Sp
          then
            MyOp.( * ) params_609.Wt_params.vscontrol.Wt_params.slope15 
                       (MyOp.(-) omega_g_608 
                                 params_609.Wt_params.vscontrol.Wt_params.ctInSp)
          else
            if (<) omega_g_608 
                   params_609.Wt_params.vscontrol.Wt_params.trGnSp
            then
              MyOp.( * ) (MyOp.( * ) params_609.Wt_params.vscontrol.Wt_params.rgn2K
                                      omega_g_608)  omega_g_608
            else
              MyOp.( * ) params_609.Wt_params.vscontrol.Wt_params.slope25 
                         (MyOp.(-) omega_g_608 
                                   params_609.Wt_params.vscontrol.Wt_params.sySp) in
  mg_d_611

type ('d , 'c , 'b , 'a) _scnd_order_lag_pitch =
  { mutable i_634 : 'd ;
    mutable m_632 : 'c ; mutable m_630 : 'b ; mutable m_627 : 'a }

let scnd_order_lag_pitch  = 
  
  let scnd_order_lag_pitch_alloc _ =
    ();
    { i_634 = (false:bool) ;
      m_632 = (MyOp.create ():MyOp.t) ;
      m_630 = (MyOp.create ():MyOp.t) ; m_627 = (MyOp.create ():MyOp.t) } in
  let scnd_order_lag_pitch_copy source dest =
    dest.i_634 <- source.i_634 ;
    dest.m_632 <- source.m_632 ;
    dest.m_630 <- source.m_630 ; dest.m_627 <- source.m_627 in
  let scnd_order_lag_pitch_reset self  =
    (self.i_634 <- true:unit) in 
  let scnd_order_lag_pitch_step self ((t_613:MyOp.t) ,
                                      (theta_d_614:MyOp.t) ,
                                      (params_612:Wt_params.params)) =
    ((let (y0_625:MyOp.t) = params_612.Wt_params.pitch.Wt_params.thetaDot0 in
      (if self.i_634 then self.m_632 <- y0_625) ;
      (let (y0_621:MyOp.t) = params_612.Wt_params.pitch.Wt_params.theta0 in
       (if self.i_634 then self.m_630 <- y0_621) ;
       (let (x_629:MyOp.t) =
            if self.i_634 then t_613 else MyOp.(-) t_613  self.m_627 in
        self.i_634 <- false ;
        (let (x_633:MyOp.t) = self.m_632 in
         let (x_631:MyOp.t) = self.m_630 in
         let (ddtheta_615:MyOp.t) =
             MyOp.(-) (MyOp.( * ) (MyOp.(-) theta_d_614  x_631) 
                                  (MyOp.pow params_612.Wt_params.pitch.Wt_params.omega
                                             2.)) 
                      (MyOp.( * ) (MyOp.( * ) x_633 
                                              (MyOp.scale params_612.Wt_params.pitch.Wt_params.xi
                                                           2.)) 
                                  params_612.Wt_params.pitch.Wt_params.omega) in
         self.m_632 <- MyOp.(+) (MyOp.( * ) ddtheta_615  x_629)  x_633 ;
         self.m_630 <- MyOp.(+) (MyOp.( * ) x_633  x_629)  x_631 ;
         self.m_627 <- t_613 ; x_631)))):MyOp.t) in
  Cnode { alloc = scnd_order_lag_pitch_alloc; copy = scnd_order_lag_pitch_copy
                                              ;
                                              reset = scnd_order_lag_pitch_reset
                                              ;
                                              step = scnd_order_lag_pitch_step }
type ('c , 'b , 'a) _fst_order_lag_pitch =
  { mutable i_650 : 'c ; mutable m_648 : 'b ; mutable m_645 : 'a }

let fst_order_lag_pitch  = 
  
  let fst_order_lag_pitch_alloc _ =
    ();
    { i_650 = (false:bool) ;
      m_648 = (MyOp.create ():MyOp.t) ; m_645 = (MyOp.create ():MyOp.t) } in
  let fst_order_lag_pitch_copy source dest =
    dest.i_650 <- source.i_650 ;
    dest.m_648 <- source.m_648 ; dest.m_645 <- source.m_645 in
  let fst_order_lag_pitch_reset self  =
    (self.i_650 <- true:unit) in 
  let fst_order_lag_pitch_step self ((t_636:MyOp.t) ,
                                     (theta_d_637:MyOp.t) ,
                                     (params_635:Wt_params.params)) =
    ((let (y0_643:MyOp.t) = params_635.Wt_params.pitch.Wt_params.theta0 in
      (if self.i_650 then self.m_648 <- y0_643) ;
      (let (x_647:MyOp.t) =
           if self.i_650 then t_636 else MyOp.(-) t_636  self.m_645 in
       self.i_650 <- false ;
       (let (x_649:MyOp.t) = self.m_648 in
        let (dtheta_638:MyOp.t) =
            MyOp.(/) (MyOp.( * ) (MyOp.(-) theta_d_637  x_649) 
                                 params_635.Wt_params.pitch.Wt_params.omega) 
                     (MyOp.scale params_635.Wt_params.pitch.Wt_params.xi  2.) in
        self.m_648 <- MyOp.(+) (MyOp.( * ) dtheta_638  x_647)  x_649 ;
        self.m_645 <- t_636 ; x_649))):MyOp.t) in
  Cnode { alloc = fst_order_lag_pitch_alloc; copy = fst_order_lag_pitch_copy
                                             ;
                                             reset = fst_order_lag_pitch_reset
                                             ;
                                             step = fst_order_lag_pitch_step }
type _time_delay_pitch = unit

let time_delay_pitch  = 
   let time_delay_pitch_alloc _ = () in
  let time_delay_pitch_copy source dest = () in
  let time_delay_pitch_reset self  =
    ((()):unit) in 
  let time_delay_pitch_step self ((t_652:'a5992) ,
                                  (theta_d_653:'a5984) ,
                                  (params_651:Wt_params.params)) =
    ((let (y0_657:MyOp.t) = params_651.Wt_params.pitch.Wt_params.theta0 in
      y0_657):MyOp.t) in
  Cnode { alloc = time_delay_pitch_alloc; copy = time_delay_pitch_copy ;
                                          reset = time_delay_pitch_reset ;
                                          step = time_delay_pitch_step }
type ('d , 'c , 'b , 'a) _pitch_actuator_subsystem =
  { mutable i_861 : 'd ;
    mutable i_862 : 'c ; mutable i_863 : 'b ; mutable result_664 : 'a }

let pitch_actuator_subsystem  = 
  let Cnode { alloc = i_861_alloc; copy = i_861_copy ;
                                   step = i_861_step ; reset = i_861_reset } = scnd_order_lag_pitch 
   in 
  let Cnode { alloc = i_862_alloc; copy = i_862_copy ;
                                   step = i_862_step ; reset = i_862_reset } = fst_order_lag_pitch 
   in 
  let Cnode { alloc = i_863_alloc; copy = i_863_copy ;
                                   step = i_863_step ; reset = i_863_reset } = time_delay_pitch 
   in
  let pitch_actuator_subsystem_alloc _ =
    ();
    { result_664 = (MyOp.create ():MyOp.t);
      i_861 = i_861_alloc () (* discrete *)  ;
      i_862 = i_862_alloc () (* discrete *)  ;
      i_863 = i_863_alloc () (* discrete *)  } in
  let pitch_actuator_subsystem_copy source dest =
    dest.result_664 <- source.result_664;
    i_861_copy source.i_861 dest.i_861 (* discrete *) ;
    i_862_copy source.i_862 dest.i_862 (* discrete *) ;
    i_863_copy source.i_863 dest.i_863 (* discrete *) in
  let pitch_actuator_subsystem_reset self  =
    (((i_861_reset self.i_861  ; i_862_reset self.i_862 ) ;
      i_863_reset self.i_863 ):unit) in 
  let pitch_actuator_subsystem_step self ((t_661:MyOp.t) ,
                                          (actuatorType_659:int) ,
                                          (theta_d_662:MyOp.t) ,
                                          (params_660:Wt_params.params)) =
    (((begin match actuatorType_659 with
             | 1 ->
                 self.result_664 <- i_861_step self.i_861
                                      (t_661 , theta_d_662 , params_660)
             | 2 ->
                 self.result_664 <- i_862_step self.i_862
                                      (t_661 , theta_d_662 , params_660)
             | 3 ->
                 self.result_664 <- i_863_step self.i_863
                                      (t_661 , theta_d_662 , params_660)
             | _ -> self.result_664 <- MyOp.make 0.  end) ; self.result_664):
    MyOp.t) in
  Cnode { alloc = pitch_actuator_subsystem_alloc; copy = pitch_actuator_subsystem_copy
                                                  ;
                                                  reset = pitch_actuator_subsystem_reset
                                                  ;
                                                  step = pitch_actuator_subsystem_step }
type ('e , 'd , 'c , 'b , 'a) _servo_elastic_subsystem =
  { mutable i_864 : 'e ;
    mutable i_691 : 'd ;
    mutable m_689 : 'c ; mutable m_687 : 'b ; mutable m_684 : 'a }

let servo_elastic_subsystem  = 
  let Cnode { alloc = i_864_alloc; copy = i_864_copy ;
                                   step = i_864_step ; reset = i_864_reset } = Wt_common.integrate 
   in
  let servo_elastic_subsystem_alloc _ =
    ();
    { i_691 = (false:bool) ;
      m_689 = (MyOp.create ():MyOp.t) ;
      m_687 = (MyOp.create ():MyOp.t) ; m_684 = (MyOp.create ():MyOp.t);
      i_864 = i_864_alloc () (* discrete *)  } in
  let servo_elastic_subsystem_copy source dest =
    dest.i_691 <- source.i_691 ;
    dest.m_689 <- source.m_689 ;
    dest.m_687 <- source.m_687 ; dest.m_684 <- source.m_684;
    i_864_copy source.i_864 dest.i_864 (* discrete *) in
  let servo_elastic_subsystem_reset self  =
    ((self.i_691 <- true ; i_864_reset self.i_864 ):unit) in 
  let servo_elastic_subsystem_step self ((t_669:MyOp.t) ,
                                         (mg_d_667:MyOp.t) ,
                                         (ma_666:MyOp.t) ,
                                         (fa_665:MyOp.t) ,
                                         (params_668:Wt_params.params)) =
    ((let (y0_682:MyOp.t) = params_668.Wt_params.xt_dot0 in
      (if self.i_691 then self.m_689 <- y0_682) ;
      (let (y0_678:MyOp.t) = params_668.Wt_params.omega0 in
       (if self.i_691 then self.m_687 <- y0_678) ;
       (let (x_686:MyOp.t) =
            if self.i_691 then t_669 else MyOp.(-) t_669  self.m_684 in
        self.i_691 <- false ;
        (let (x_690:MyOp.t) = self.m_689 in
         let (xT_674:MyOp.t) =
             i_864_step self.i_864 (x_686 , x_690 , params_668.Wt_params.xT0) in
         let (dxT_dot_671:MyOp.t) =
             MyOp.(/) (MyOp.(-) (MyOp.(-) fa_665 
                                          (MyOp.( * ) x_690 
                                                      params_668.Wt_params.cTe))
                                
                                (MyOp.( * ) (MyOp.(-) xT_674 
                                                      params_668.Wt_params.xT0)
                                             params_668.Wt_params.kTe)) 
                      params_668.Wt_params.mTe in
         self.m_689 <- MyOp.(+) (MyOp.( * ) dxT_dot_671  x_686)  x_690 ;
         (let (domega_670:MyOp.t) =
              MyOp.(/) (MyOp.(-) ma_666 
                                 (MyOp.(/) mg_d_667 
                                           params_668.Wt_params.gBRatio)) 
                       params_668.Wt_params.inertia in
          let (x_688:MyOp.t) = self.m_687 in
          self.m_687 <- MyOp.(+) (MyOp.( * ) domega_670  x_686)  x_688 ;
          self.m_684 <- t_669 ; (x_688 , x_690)))))):MyOp.t * MyOp.t) in
  Cnode { alloc = servo_elastic_subsystem_alloc; copy = servo_elastic_subsystem_copy
                                                 ;
                                                 reset = servo_elastic_subsystem_reset
                                                 ;
                                                 step = servo_elastic_subsystem_step }
let cP_aeromapsPoly ((lambda_692:MyOp.t) , (theta_693:MyOp.t)) =
  MyOp.(+) (MyOp.(+) (MyOp.(+) (MyOp.(+) (MyOp.(+) (MyOp.(+) (MyOp.(+) 
                                                                (MyOp.(+) 
                                                                   (MyOp.(+) 
                                                                    (
                                                                    MyOp.scale 
                                                                    (
                                                                    MyOp.pow 
                                                                    lambda_692
                                                                     
                                                                    3.) 
                                                                    (-0.000464550681271))
                                                                    
                                                                    (
                                                                    MyOp.scale 
                                                                    (
                                                                    MyOp.( * ) 
                                                                    (
                                                                    MyOp.pow 
                                                                    lambda_692
                                                                     
                                                                    2.) 
                                                                    theta_693)
                                                                    
                                                                    (-0.074780487295)))
                                                                   
                                                                   (MyOp.scale 
                                                                    (
                                                                    MyOp.pow 
                                                                    lambda_692
                                                                     
                                                                    2.) 
                                                                    (-0.00245817585907)))
                                                                
                                                                (MyOp.scale 
                                                                   (MyOp.( * ) 
                                                                    lambda_692
                                                                    
                                                                    (
                                                                    MyOp.pow 
                                                                    theta_693
                                                                     
                                                                    2.)) 
                                                                   (-0.372740535667)))
                                                             
                                                             (MyOp.scale 
                                                                (MyOp.( * ) 
                                                                   lambda_692
                                                                    theta_693)
                                                                
                                                                0.0711147525909))
                                                   
                                                   (MyOp.scale lambda_692 
                                                               0.175932463832))
                                         
                                         (MyOp.scale (MyOp.pow theta_693  3.)
                                                      3.89808785329)) 
                               (MyOp.scale (MyOp.pow theta_693  2.) 
                                           (-3.51436345741))) 
                     (MyOp.scale theta_693  1.59939029665)) 
           (MyOp.make (-0.404129012121))

let cT_aeromapsPoly ((lambda_694:MyOp.t) , (theta_695:MyOp.t)) =
  MyOp.(+) (MyOp.(+) (MyOp.(+) (MyOp.(+) (MyOp.(+) (MyOp.(+) (MyOp.(+) 
                                                                (MyOp.(+) 
                                                                   (MyOp.(+) 
                                                                    (
                                                                    MyOp.scale 
                                                                    (
                                                                    MyOp.pow 
                                                                    lambda_694
                                                                     
                                                                    3.) 
                                                                    0.00168223358976)
                                                                    
                                                                    (
                                                                    MyOp.scale 
                                                                    (
                                                                    MyOp.( * ) 
                                                                    (
                                                                    MyOp.pow 
                                                                    lambda_694
                                                                     
                                                                    2.) 
                                                                    theta_695)
                                                                    
                                                                    (-0.00515118049598)))
                                                                   
                                                                   (MyOp.scale 
                                                                    (
                                                                    MyOp.pow 
                                                                    lambda_694
                                                                     
                                                                    2.) 
                                                                    (-0.0472197248104)))
                                                                
                                                                (MyOp.scale 
                                                                   (MyOp.( * ) 
                                                                    lambda_694
                                                                    
                                                                    (
                                                                    MyOp.pow 
                                                                    theta_695
                                                                     
                                                                    2.)) 
                                                                   1.16475825685))
                                                             
                                                             (MyOp.scale 
                                                                (MyOp.( * ) 
                                                                   lambda_694
                                                                    theta_695)
                                                                
                                                                (-1.52576164856)))
                                                   
                                                   (MyOp.scale lambda_694 
                                                               0.55320691852))
                                         
                                         (MyOp.scale (MyOp.pow theta_695  3.)
                                                      6.91427835251)) 
                               (MyOp.scale (MyOp.pow theta_695  2.) 
                                           (-10.9675429628))) 
                     (MyOp.scale theta_695  6.00063627825)) 
           (MyOp.make (-0.980172788619))

type _aeromapsPoly = unit

let aeromapsPoly  = 
   let aeromapsPoly_alloc _ = () in let aeromapsPoly_copy source dest = () in
  let aeromapsPoly_reset self  =
    ((()):unit) in 
  let aeromapsPoly_step self ((lambda_696:MyOp.t) , (theta_697:MyOp.t)) =
    ((let (cT_699:MyOp.t) = cT_aeromapsPoly (lambda_696 , theta_697) in
      let (cP_698:MyOp.t) = cP_aeromapsPoly (lambda_696 , theta_697) in
      (cP_698 , cT_699)):MyOp.t * MyOp.t) in
  Cnode { alloc = aeromapsPoly_alloc; copy = aeromapsPoly_copy ;
                                      reset = aeromapsPoly_reset ;
                                      step = aeromapsPoly_step }
type ('a) _aero_elastic_subsystem =
  { mutable i_865 : 'a }

let aero_elastic_subsystem  = 
  let Cnode { alloc = i_865_alloc; copy = i_865_copy ;
                                   step = i_865_step ; reset = i_865_reset } = aeromapsPoly 
   in
  let aero_elastic_subsystem_alloc _ =
    ();{ i_865 = i_865_alloc () (* discrete *)  } in
  let aero_elastic_subsystem_copy source dest =
    i_865_copy source.i_865 dest.i_865 (* discrete *) in
  let aero_elastic_subsystem_reset self  =
    (i_865_reset self.i_865 :unit) in 
  let aero_elastic_subsystem_step self ((v0_703:MyOp.t) ,
                                        (theta_702:MyOp.t) ,
                                        (omega_700:MyOp.t) ,
                                        (xT_dot_704:MyOp.t) ,
                                        (params_701:Wt_params.params)) =
    ((let (v_rel_712:MyOp.t) = MyOp.(-) v0_703  xT_dot_704 in
      let (lambda_709:MyOp.t) =
          MyOp.(/) (MyOp.( * ) omega_700  params_701.Wt_params.rotor) 
                   v_rel_712 in
      let ((cP_705:MyOp.t) , (cT_706:MyOp.t)) =
          i_865_step self.i_865 (lambda_709 , theta_702) in
      let (fa'_708:MyOp.t) =
          MyOp.( * ) (MyOp.( * ) (MyOp.( * ) cT_706 
                                             (MyOp.scale params_701.Wt_params.rho
                                                          0.5)) 
                                 Wt_common.pi_t) 
                     (MyOp.pow params_701.Wt_params.rotor  2.) in
      let (fa_707:MyOp.t) =
          MyOp.( * ) (MyOp.( * ) fa'_708  v_rel_712)  v_rel_712 in
      let (ma'_711:MyOp.t) =
          MyOp.(/) (MyOp.( * ) (MyOp.( * ) (MyOp.( * ) cP_705 
                                                       (MyOp.scale params_701.Wt_params.rho
                                                                    0.5)) 
                                           Wt_common.pi_t) 
                               (MyOp.pow params_701.Wt_params.rotor  3.)) 
                   lambda_709 in
      let (ma_710:MyOp.t) =
          MyOp.( * ) (MyOp.( * ) ma'_711  v_rel_712)  v_rel_712 in
      (ma_710 , fa_707)):MyOp.t * MyOp.t) in
  Cnode { alloc = aero_elastic_subsystem_alloc; copy = aero_elastic_subsystem_copy
                                                ;
                                                reset = aero_elastic_subsystem_reset
                                                ;
                                                step = aero_elastic_subsystem_step }
type ('g , 'f , 'e , 'd , 'c , 'b , 'a) _wind_turbine =
  { mutable i_868 : 'g ;
    mutable i_867 : 'f ;
    mutable i_866 : 'e ;
    mutable i_749 : 'd ;
    mutable m_747 : 'c ; mutable m_745 : 'b ; mutable m_742 : 'a }

let wind_turbine  = 
  let Cnode { alloc = i_868_alloc; copy = i_868_copy ;
                                   step = i_868_step ; reset = i_868_reset } = pitch_actuator_subsystem 
   in 
  let Cnode { alloc = i_867_alloc; copy = i_867_copy ;
                                   step = i_867_step ; reset = i_867_reset } = aero_elastic_subsystem 
   in 
  let Cnode { alloc = i_866_alloc; copy = i_866_copy ;
                                   step = i_866_step ; reset = i_866_reset } = Wt_common.integrate 
   in
  let wind_turbine_alloc _ =
    ();
    { i_749 = (false:bool) ;
      m_747 = (MyOp.create ():MyOp.t) ;
      m_745 = (MyOp.create ():MyOp.t) ; m_742 = (MyOp.create ():MyOp.t);
      i_868 = i_868_alloc () (* discrete *)  ;
      i_867 = i_867_alloc () (* discrete *)  ;
      i_866 = i_866_alloc () (* discrete *)  } in
  let wind_turbine_copy source dest =
    dest.i_749 <- source.i_749 ;
    dest.m_747 <- source.m_747 ;
    dest.m_745 <- source.m_745 ; dest.m_742 <- source.m_742;
    i_868_copy source.i_868 dest.i_868 (* discrete *) ;
    i_867_copy source.i_867 dest.i_867 (* discrete *) ;
    i_866_copy source.i_866 dest.i_866 (* discrete *) in
  let wind_turbine_reset self  =
    ((self.i_749 <- true ;
      i_868_reset self.i_868  ;
      i_867_reset self.i_867  ; i_866_reset self.i_866 ):unit) in 
  let wind_turbine_step self ((t_715:MyOp.t) ,
                              (v0_717:MyOp.t) ,
                              (theta_d_716:MyOp.t) ,
                              (mg_d_713:MyOp.t) ,
                              (params_714:Wt_params.params)) =
    ((let (y0_740:MyOp.t) = params_714.Wt_params.xt_dot0 in
      (if self.i_749 then self.m_747 <- y0_740) ;
      (let (y0_736:MyOp.t) = params_714.Wt_params.omega0 in
       (if self.i_749 then self.m_745 <- y0_736) ;
       (let (x_744:MyOp.t) =
            if self.i_749 then t_715 else MyOp.(-) t_715  self.m_742 in
        self.i_749 <- false ;
        (let (x_746:MyOp.t) = self.m_745 in
         let (x_748:MyOp.t) = self.m_747 in
         let (blade_pitch_angle_718:MyOp.t) =
             i_868_step self.i_868
               (t_715 ,
                params_714.Wt_params.pitch.Wt_params.actuatorType ,
                theta_d_716 , params_714) in
         let ((ma_720:MyOp.t) , (fa_719:MyOp.t)) =
             i_867_step self.i_867
               (v0_717 , blade_pitch_angle_718 , x_746 , x_748 , params_714) in
         let (xT_732:MyOp.t) =
             i_866_step self.i_866 (x_744 , x_748 , params_714.Wt_params.xT0) in
         let (dxT_dot_729:MyOp.t) =
             MyOp.(/) (MyOp.(-) (MyOp.(-) fa_719 
                                          (MyOp.( * ) x_748 
                                                      params_714.Wt_params.cTe))
                                
                                (MyOp.( * ) (MyOp.(-) xT_732 
                                                      params_714.Wt_params.xT0)
                                             params_714.Wt_params.kTe)) 
                      params_714.Wt_params.mTe in
         self.m_747 <- MyOp.(+) (MyOp.( * ) dxT_dot_729  x_744)  x_748 ;
         (let (domega_728:MyOp.t) =
              MyOp.(/) (MyOp.(-) ma_720 
                                 (MyOp.(/) mg_d_713 
                                           params_714.Wt_params.gBRatio)) 
                       params_714.Wt_params.inertia in
          self.m_745 <- MyOp.(+) (MyOp.( * ) domega_728  x_744)  x_746 ;
          self.m_742 <- t_715 ; (blade_pitch_angle_718 , x_746)))))):
    MyOp.t * MyOp.t) in
  Cnode { alloc = wind_turbine_alloc; copy = wind_turbine_copy ;
                                      reset = wind_turbine_reset ;
                                      step = wind_turbine_step }
type ('q ,
      'p ,
      'o ,
      'n , 'm , 'l , 'k , 'j , 'i , 'h , 'g , 'f , 'e , 'd , 'c , 'b , 'a) _wt =
  { mutable i_873 : 'q ;
    mutable i_872 : 'p ;
    mutable i_871 : 'o ;
    mutable i_870 : 'n ;
    mutable i_869 : 'm ;
    mutable i_860 : 'l ;
    mutable m_858 : 'k ;
    mutable m_855 : 'j ;
    mutable m_853 : 'i ;
    mutable m_850 : 'h ;
    mutable m_848 : 'g ;
    mutable m_845 : 'f ;
    mutable m_843 : 'e ;
    mutable m_841 : 'd ;
    mutable m_839 : 'c ; mutable m_836 : 'b ; mutable v0_0_763 : 'a }

let wt  = 
  let Cnode { alloc = i_873_alloc; copy = i_873_copy ;
                                   step = i_873_step ; reset = i_873_reset } = rate_limiter 
   in 
  let Cnode { alloc = i_872_alloc; copy = i_872_copy ;
                                   step = i_872_step ; reset = i_872_reset } = pitch_actuator_subsystem 
   in 
  let Cnode { alloc = i_871_alloc; copy = i_871_copy ;
                                   step = i_871_step ; reset = i_871_reset } = aero_elastic_subsystem 
   in 
  let Cnode { alloc = i_870_alloc; copy = i_870_copy ;
                                   step = i_870_step ; reset = i_870_reset } = Wt_common.integrate 
   in 
  let Cnode { alloc = i_869_alloc; copy = i_869_copy ;
                                   step = i_869_step ; reset = i_869_reset } = rate_limiter 
   in
  let wt_alloc _ =
    ();
    { i_860 = (false:bool) ;
      m_858 = (MyOp.create ():MyOp.t) ;
      m_855 = (MyOp.create ():MyOp.t) ;
      m_853 = (MyOp.create ():MyOp.t) ;
      m_850 = (MyOp.create ():MyOp.t) ;
      m_848 = (MyOp.create ():MyOp.t) ;
      m_845 = (MyOp.create ():MyOp.t) ;
      m_843 = (MyOp.create ():MyOp.t) ;
      m_841 = (MyOp.create ():MyOp.t) ;
      m_839 = (MyOp.create ():MyOp.t) ;
      m_836 = (MyOp.create ():MyOp.t) ; v0_0_763 = (MyOp.create ():MyOp.t);
      i_873 = i_873_alloc () (* discrete *)  ;
      i_872 = i_872_alloc () (* discrete *)  ;
      i_871 = i_871_alloc () (* discrete *)  ;
      i_870 = i_870_alloc () (* discrete *)  ;
      i_869 = i_869_alloc () (* discrete *)  } in
  let wt_copy source dest =
    dest.i_860 <- source.i_860 ;
    dest.m_858 <- source.m_858 ;
    dest.m_855 <- source.m_855 ;
    dest.m_853 <- source.m_853 ;
    dest.m_850 <- source.m_850 ;
    dest.m_848 <- source.m_848 ;
    dest.m_845 <- source.m_845 ;
    dest.m_843 <- source.m_843 ;
    dest.m_841 <- source.m_841 ;
    dest.m_839 <- source.m_839 ;
    dest.m_836 <- source.m_836 ; dest.v0_0_763 <- source.v0_0_763;
    i_873_copy source.i_873 dest.i_873 (* discrete *) ;
    i_872_copy source.i_872 dest.i_872 (* discrete *) ;
    i_871_copy source.i_871 dest.i_871 (* discrete *) ;
    i_870_copy source.i_870 dest.i_870 (* discrete *) ;
    i_869_copy source.i_869 dest.i_869 (* discrete *) in
  let wt_reset self  =
    ((self.i_860 <- true ;
      i_873_reset self.i_873  ;
      i_872_reset self.i_872  ;
      i_871_reset self.i_871  ;
      i_870_reset self.i_870  ; i_869_reset self.i_869 ):unit) in 
  let wt_step self ((t_750:MyOp.t) , (v0_751:MyOp.t)) =
    (((if self.i_860 then self.v0_0_763 <- v0_751) ;
      (let (params_756:Wt_params.params) =
           Wt_params.get_default self.v0_0_763 in
       let (y0_834:MyOp.t) = params_756.Wt_params.omega_g0 in
       (if self.i_860 then self.m_858 <- y0_834) ;
       (let (x_857:MyOp.t) =
            if self.i_860 then t_750 else MyOp.(-) t_750  self.m_855 in
        let (y0_824:MyOp.t) = params_756.Wt_params.pitch.Wt_params.theta0 in
        (if self.i_860 then self.m_853 <- y0_824) ;
        (let (x_852:MyOp.t) =
             if self.i_860 then t_750 else MyOp.(-) t_750  self.m_850 in
         let (y0_814:MyOp.t) =
             MyOp.( * ) params_756.Wt_params.pitch.Wt_params.theta0 
                        (MyOp.translate (MyOp.(/) params_756.Wt_params.pitch.Wt_params.theta0
                                                  
                                                  params_756.Wt_params.pitch.Wt_params.cpc.Wt_params.gS_factor)
                                         1.) in
         (if self.i_860 then self.m_848 <- y0_814) ;
         (let (x_847:MyOp.t) =
              if self.i_860 then t_750 else MyOp.(-) t_750  self.m_845 in
          (if self.i_860 then
           self.m_843 <- params_756.Wt_params.pitch.Wt_params.theta0) ;
          (let (y0_791:MyOp.t) = params_756.Wt_params.xt_dot0 in
           (if self.i_860 then self.m_841 <- y0_791) ;
           (let (y0_787:MyOp.t) = params_756.Wt_params.omega0 in
            (if self.i_860 then self.m_839 <- y0_787) ;
            (let (x_838:MyOp.t) =
                 if self.i_860 then t_750 else MyOp.(-) t_750  self.m_836 in
             self.i_860 <- false ;
             (let (rob_optim_757:MyOp.t) = MyOp.make 0. in
              let (x_840:MyOp.t) = self.m_839 in
              let (u_828:MyOp.t) =
                  MyOp.(/) x_840  params_756.Wt_params.gBRatio in
              let (x_859:MyOp.t) = self.m_858 in
              let (dy_829:MyOp.t) =
                  MyOp.(/) (MyOp.(-) u_828  x_859) 
                           params_756.Wt_params.vscontrol.Wt_params.vs_filterConstant in
              self.m_858 <- MyOp.(+) (MyOp.( * ) dy_829  x_857)  x_859 ;
              self.m_855 <- t_750 ;
              (let (x_844:MyOp.t) = self.m_843 in
               let (gs_799:MyOp.t) =
                   MyOp.inv (MyOp.translate (MyOp.(/) x_844 
                                                      params_756.Wt_params.pitch.Wt_params.cpc.Wt_params.gS_factor)
                                             1.) in
               let (omega_g_rated_794:MyOp.t) =
                   params_756.Wt_params.omega_g_rated in
               let (e_798:MyOp.t) = MyOp.(-) x_859  omega_g_rated_794 in
               let (e1_805:MyOp.t) =
                   MyOp.( * ) e_798 
                              params_756.Wt_params.pitch.Wt_params.cpc.Wt_params.kP in
               let (x_849:MyOp.t) = self.m_848 in
               let (e4_808:MyOp.t) = MyOp.(+) e1_805  x_849 in
               let (theta_d'_810:MyOp.t) = MyOp.( * ) gs_799  e4_808 in
               let (theta_d_809:MyOp.t) =
                   saturate (params_756.Wt_params.pitch.Wt_params.min ,
                             params_756.Wt_params.pitch.Wt_params.max ,
                             theta_d'_810) in
               let (theta_d_759:MyOp.t) =
                   i_873_step self.i_873
                     (t_750 ,
                      params_756.Wt_params.pitch.Wt_params.rateLimit ,
                      (MyOp.(~-) params_756.Wt_params.pitch.Wt_params.rateLimit)
                      ,
                      params_756.Wt_params.pitch.Wt_params.thetaDot0 ,
                      theta_d_809) in
               let (blade_pitch_angle_769:MyOp.t) =
                   i_872_step self.i_872
                     (t_750 ,
                      params_756.Wt_params.pitch.Wt_params.actuatorType ,
                      theta_d_759 , params_756) in
               let (x_854:MyOp.t) = self.m_853 in
               let (dy_819:MyOp.t) =
                   MyOp.(/) (MyOp.(-) blade_pitch_angle_769  x_854) 
                            params_756.Wt_params.pitch.Wt_params.pitch_filterConstant in
               self.m_853 <- MyOp.(+) (MyOp.( * ) dy_819  x_852)  x_854 ;
               self.m_850 <- t_750 ;
               (let (e2_806:MyOp.t) =
                    MyOp.(-) e1_805 
                             (MyOp.( * ) (MyOp.(-) theta_d'_810  theta_d_809)
                                         
                                         params_756.Wt_params.pitch.Wt_params.cpc.Wt_params.antiWindUp) in
                let (x_813:MyOp.t) =
                    MyOp.(/) e2_806 
                             params_756.Wt_params.pitch.Wt_params.cpc.Wt_params.tI in
                self.m_848 <- MyOp.(+) (MyOp.( * ) x_813  x_847)  x_849 ;
                self.m_845 <- t_750 ;
                self.m_843 <- blade_pitch_angle_769 ;
                (let (x_842:MyOp.t) = self.m_841 in
                 let ((ma_771:MyOp.t) , (fa_770:MyOp.t)) =
                     i_871_step self.i_871
                       (v0_751 ,
                        blade_pitch_angle_769 , x_840 , x_842 , params_756) in
                 let (xT_783:MyOp.t) =
                     i_870_step self.i_870
                       (x_838 , x_842 , params_756.Wt_params.xT0) in
                 let (dxT_dot_780:MyOp.t) =
                     MyOp.(/) (MyOp.(-) (MyOp.(-) fa_770 
                                                  (MyOp.( * ) x_842 
                                                              params_756.Wt_params.cTe))
                                        
                                        (MyOp.( * ) (MyOp.(-) xT_783 
                                                              params_756.Wt_params.xT0)
                                                     params_756.Wt_params.kTe))
                               params_756.Wt_params.mTe in
                 self.m_841 <- MyOp.(+) (MyOp.( * ) dxT_dot_780  x_838) 
                                        x_842 ;
                 (let (mg_d_753:MyOp.t) =
                      torque_controller (x_859 , theta_d_759 , params_756) in
                  let (torque_aux_762:MyOp.t) =
                      i_869_step self.i_869
                        (t_750 ,
                         params_756.Wt_params.vscontrol.Wt_params.maxRat ,
                         (MyOp.(~-) params_756.Wt_params.vscontrol.Wt_params.maxRat)
                         , (MyOp.make 0.) , mg_d_753) in
                  let (torque_761:MyOp.t) =
                      saturate (MyOp.neg_infinity ,
                                params_756.Wt_params.vscontrol.Wt_params.maxTq
                                , torque_aux_762) in
                  let (domega_779:MyOp.t) =
                      MyOp.(/) (MyOp.(-) ma_771 
                                         (MyOp.(/) torque_761 
                                                   params_756.Wt_params.gBRatio))
                                params_756.Wt_params.inertia in
                  self.m_839 <- MyOp.(+) (MyOp.( * ) domega_779  x_838) 
                                         x_840 ;
                  self.m_836 <- t_750 ;
                  ((Wt_common.rad2deg x_854) ,
                   (Wt_common.radPs2rpm x_840) ,
                   (Wt_common.radPs2rpm x_859) ,
                   (Wt_common.rad2deg theta_d_759) ,
                   (Wt_common.rad2deg blade_pitch_angle_769) ,
                   mg_d_753 , rob_optim_757)))))))))))))):MyOp.t *
                                                          MyOp.t *
                                                          MyOp.t *
                                                          MyOp.t *
                                                          MyOp.t *
                                                          MyOp.t * MyOp.t) in
  Cnode { alloc = wt_alloc; copy = wt_copy ;
                            reset = wt_reset ; step = wt_step }
