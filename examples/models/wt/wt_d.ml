(* The Zélus compiler, version 2.1
  (vendredi 25 septembre 2020, 16:45:09 (UTC+0200)) *)
open Ztypes
open FadFloat
open Wt_common
open Wt_params
let saturate ((low_497:FadFloat.t) ,
              (high_496:FadFloat.t) , (v_498:FadFloat.t)) =
  FadFloat.min (FadFloat.max v_498  low_497)  high_496

type _transport_delay = unit

let transport_delay  = 
   let transport_delay_alloc _ = () in
  let transport_delay_reset self  =
    ((()):unit) in 
  let transport_delay_step self ((t_500:'a5171) ,
                                 (delay_499:'a5170) , (y0_501:'a5178)) =
    (y0_501:'a) in
  Node { alloc = transport_delay_alloc; reset = transport_delay_reset ;
                                        step = transport_delay_step }
type ('e , 'd , 'c , 'b , 'a) _rate_limiter =
  { mutable i_523 : 'e ;
    mutable m_518 : 'd ;
    mutable m_516 : 'c ; mutable m_514 : 'b ; mutable m_511 : 'a }

let rate_limiter  = 
  
  let rate_limiter_alloc _ =
    ();
    { i_523 = (false:bool) ;
      m_518 = (FadFloat.create ():FadFloat.t) ;
      m_516 = (FadFloat.create ():FadFloat.t) ;
      m_514 = (FadFloat.create ():FadFloat.t) ; m_511 = (FadFloat.create ():FadFloat.t) } in
  let rate_limiter_reset self  =
    (self.i_523 <- true:unit) in 
  let rate_limiter_step self ((t_505:FadFloat.t) ,
                              (rising_504:FadFloat.t) ,
                              (falling_503:FadFloat.t) ,
                              (y0_507:'a5184) , (x_506:FadFloat.t)) =
    ((let (x_513:FadFloat.t) =
          if self.i_523 then t_505 else FadFloat.(-) t_505  self.m_511 in
      let (x_520:FadFloat.t) =
          FadFloat.(+) (FadFloat.( * ) x_513  falling_503)  self.m_518 in
      let (x_521:FadFloat.t) =
          FadFloat.(+) (FadFloat.( * ) x_513  rising_504)  self.m_516 in
      let (rate_508:FadFloat.t) =
          FadFloat.(/) (FadFloat.(-) x_506  self.m_514)  x_513 in
      let (x_522:FadFloat.t) =
          if self.i_523
          then x_506
          else
            if (>) rate_508  rising_504
            then x_521
            else if (<) rate_508  falling_503 then x_520 else x_506 in
      self.i_523 <- false ;
      self.m_518 <- x_522 ;
      self.m_516 <- x_522 ; self.m_514 <- x_522 ; self.m_511 <- t_505 ; x_522):
    FadFloat.t) in
  Node { alloc = rate_limiter_alloc; reset = rate_limiter_reset ;
                                     step = rate_limiter_step }
type ('c , 'b , 'a) _collective_pitch_with_anti_windup =
  { mutable i_544 : 'c ; mutable m_542 : 'b ; mutable m_539 : 'a }

let collective_pitch_with_anti_windup  = 
  
  let collective_pitch_with_anti_windup_alloc _ =
    ();
    { i_544 = (false:bool) ;
      m_542 = (FadFloat.create ():FadFloat.t) ; m_539 = (FadFloat.create ():FadFloat.t) } in
  let collective_pitch_with_anti_windup_reset self  =
    (self.i_544 <- true:unit) in 
  let collective_pitch_with_anti_windup_step self ((t_527:FadFloat.t) ,
                                                   (e_524:FadFloat.t) ,
                                                   (gs_525:FadFloat.t) ,
                                                   (params_526:Wt_params.params)) =
    ((let (y0_537:FadFloat.t) =
          FadFloat.( * ) params_526.Wt_params.pitch.Wt_params.theta0 
                         (FadFloat.translate (FadFloat.(/) params_526.Wt_params.pitch.Wt_params.theta0
                                                           
                                                           params_526.Wt_params.pitch.Wt_params.cpc.Wt_params.gS_factor)
                                              1.) in
      (if self.i_544 then self.m_542 <- y0_537) ;
      (let (x_541:FadFloat.t) =
           if self.i_544 then t_527 else FadFloat.(-) t_527  self.m_539 in
       self.i_544 <- false ;
       (let (e1_528:FadFloat.t) =
            FadFloat.( * ) e_524 
                           params_526.Wt_params.pitch.Wt_params.cpc.Wt_params.kP in
        let (x_543:FadFloat.t) = self.m_542 in
        let (e4_531:FadFloat.t) = FadFloat.(+) e1_528  x_543 in
        let (theta_d'_533:FadFloat.t) = FadFloat.( * ) gs_525  e4_531 in
        let (theta_d_532:FadFloat.t) =
            saturate (params_526.Wt_params.pitch.Wt_params.min ,
                      params_526.Wt_params.pitch.Wt_params.max , theta_d'_533) in
        let (e2_529:FadFloat.t) =
            FadFloat.(-) e1_528 
                         (FadFloat.( * ) (FadFloat.(-) theta_d'_533 
                                                       theta_d_532) 
                                         params_526.Wt_params.pitch.Wt_params.cpc.Wt_params.antiWindUp) in
        let (x_536:FadFloat.t) =
            FadFloat.(/) e2_529 
                         params_526.Wt_params.pitch.Wt_params.cpc.Wt_params.tI in
        self.m_542 <- FadFloat.(+) (FadFloat.( * ) x_536  x_541)  x_543 ;
        self.m_539 <- t_527 ; theta_d_532))):FadFloat.t) in
  Node { alloc = collective_pitch_with_anti_windup_alloc; reset = collective_pitch_with_anti_windup_reset
                                                          ;
                                                          step = collective_pitch_with_anti_windup_step }
type ('d , 'c , 'b , 'a) _coll_pitch_controller =
  { mutable i_575 : 'd ;
    mutable m_573 : 'c ; mutable m_570 : 'b ; mutable m_568 : 'a }

let coll_pitch_controller  = 
  
  let coll_pitch_controller_alloc _ =
    ();
    { i_575 = (false:bool) ;
      m_573 = (FadFloat.create ():FadFloat.t) ;
      m_570 = (FadFloat.create ():FadFloat.t) ; m_568 = (FadFloat.create ():FadFloat.t) } in
  let coll_pitch_controller_reset self  =
    (self.i_575 <- true:unit) in 
  let coll_pitch_controller_step self ((t_548:FadFloat.t) ,
                                       (omega_g_545:FadFloat.t) ,
                                       (theta_in_549:FadFloat.t) ,
                                       (omega_g_rated_546:FadFloat.t) ,
                                       (params_547:Wt_params.params)) =
    ((let (y0_566:FadFloat.t) =
          FadFloat.( * ) params_547.Wt_params.pitch.Wt_params.theta0 
                         (FadFloat.translate (FadFloat.(/) params_547.Wt_params.pitch.Wt_params.theta0
                                                           
                                                           params_547.Wt_params.pitch.Wt_params.cpc.Wt_params.gS_factor)
                                              1.) in
      (if self.i_575 then self.m_573 <- y0_566) ;
      (let (x_572:FadFloat.t) =
           if self.i_575 then t_548 else FadFloat.(-) t_548  self.m_570 in
       (if self.i_575 then
        self.m_568 <- params_547.Wt_params.pitch.Wt_params.theta0) ;
       self.i_575 <- false ;
       (let (e_550:FadFloat.t) = FadFloat.(-) omega_g_545  omega_g_rated_546 in
        let (e1_557:FadFloat.t) =
            FadFloat.( * ) e_550 
                           params_547.Wt_params.pitch.Wt_params.cpc.Wt_params.kP in
        let (x_569:FadFloat.t) = self.m_568 in
        let (gs_551:FadFloat.t) =
            FadFloat.inv (FadFloat.translate (FadFloat.(/) x_569 
                                                           params_547.Wt_params.pitch.Wt_params.cpc.Wt_params.gS_factor)
                                              1.) in
        let (x_574:FadFloat.t) = self.m_573 in
        let (e4_560:FadFloat.t) = FadFloat.(+) e1_557  x_574 in
        let (theta_d'_562:FadFloat.t) = FadFloat.( * ) gs_551  e4_560 in
        let (theta_d_561:FadFloat.t) =
            saturate (params_547.Wt_params.pitch.Wt_params.min ,
                      params_547.Wt_params.pitch.Wt_params.max , theta_d'_562) in
        let (e2_558:FadFloat.t) =
            FadFloat.(-) e1_557 
                         (FadFloat.( * ) (FadFloat.(-) theta_d'_562 
                                                       theta_d_561) 
                                         params_547.Wt_params.pitch.Wt_params.cpc.Wt_params.antiWindUp) in
        let (x_565:FadFloat.t) =
            FadFloat.(/) e2_558 
                         params_547.Wt_params.pitch.Wt_params.cpc.Wt_params.tI in
        self.m_573 <- FadFloat.(+) (FadFloat.( * ) x_565  x_572)  x_574 ;
        self.m_570 <- t_548 ; self.m_568 <- theta_in_549 ; theta_d_561))):
    FadFloat.t) in
  Node { alloc = coll_pitch_controller_alloc; reset = coll_pitch_controller_reset
                                              ;
                                              step = coll_pitch_controller_step }
type ('c , 'b , 'a) _filter_pitch =
  { mutable i_591 : 'c ; mutable m_589 : 'b ; mutable m_586 : 'a }

let filter_pitch  = 
  
  let filter_pitch_alloc _ =
    ();
    { i_591 = (false:bool) ;
      m_589 = (FadFloat.create ():FadFloat.t) ; m_586 = (FadFloat.create ():FadFloat.t) } in
  let filter_pitch_reset self  =
    (self.i_591 <- true:unit) in 
  let filter_pitch_step self ((t_577:FadFloat.t) ,
                              (u_578:FadFloat.t) ,
                              (params_576:Wt_params.params)) =
    ((let (y0_584:FadFloat.t) = params_576.Wt_params.pitch.Wt_params.theta0 in
      (if self.i_591 then self.m_589 <- y0_584) ;
      (let (x_588:FadFloat.t) =
           if self.i_591 then t_577 else FadFloat.(-) t_577  self.m_586 in
       self.i_591 <- false ;
       (let (x_590:FadFloat.t) = self.m_589 in
        let (dy_579:FadFloat.t) =
            FadFloat.(/) (FadFloat.(-) u_578  x_590) 
                         params_576.Wt_params.pitch.Wt_params.pitch_filterConstant in
        self.m_589 <- FadFloat.(+) (FadFloat.( * ) dy_579  x_588)  x_590 ;
        self.m_586 <- t_577 ; x_590))):FadFloat.t) in
  Node { alloc = filter_pitch_alloc; reset = filter_pitch_reset ;
                                     step = filter_pitch_step }
type ('c , 'b , 'a) _filter_drehzahl =
  { mutable i_607 : 'c ; mutable m_605 : 'b ; mutable m_602 : 'a }

let filter_drehzahl  = 
  
  let filter_drehzahl_alloc _ =
    ();
    { i_607 = (false:bool) ;
      m_605 = (FadFloat.create ():FadFloat.t) ; m_602 = (FadFloat.create ():FadFloat.t) } in
  let filter_drehzahl_reset self  =
    (self.i_607 <- true:unit) in 
  let filter_drehzahl_step self ((t_593:FadFloat.t) ,
                                 (u_594:FadFloat.t) ,
                                 (params_592:Wt_params.params)) =
    ((let (y0_600:FadFloat.t) = params_592.Wt_params.omega_g0 in
      (if self.i_607 then self.m_605 <- y0_600) ;
      (let (x_604:FadFloat.t) =
           if self.i_607 then t_593 else FadFloat.(-) t_593  self.m_602 in
       self.i_607 <- false ;
       (let (x_606:FadFloat.t) = self.m_605 in
        let (dy_595:FadFloat.t) =
            FadFloat.(/) (FadFloat.(-) u_594  x_606) 
                         params_592.Wt_params.vscontrol.Wt_params.vs_filterConstant in
        self.m_605 <- FadFloat.(+) (FadFloat.( * ) dy_595  x_604)  x_606 ;
        self.m_602 <- t_593 ; x_606))):FadFloat.t) in
  Node { alloc = filter_drehzahl_alloc; reset = filter_drehzahl_reset ;
                                        step = filter_drehzahl_step }
let torque_controller ((omega_g_608:FadFloat.t) ,
                       (theta_d_610:FadFloat.t) ,
                       (params_609:Wt_params.params)) =
  let (mg_d_611:FadFloat.t) =
      if (||) ((>=) omega_g_608 
                    params_609.Wt_params.vscontrol.Wt_params.rtGnSp) 
              ((>=) theta_d_610 
                    params_609.Wt_params.vscontrol.Wt_params.rgn3MP)
      then
        FadFloat.(/) params_609.Wt_params.vscontrol.Wt_params.rtPwr 
                     omega_g_608
      else
        if (<=) omega_g_608  params_609.Wt_params.vscontrol.Wt_params.ctInSp
        then FadFloat.make 0.
        else
          if (<) omega_g_608  params_609.Wt_params.vscontrol.Wt_params.rgn2Sp
          then
            FadFloat.( * ) params_609.Wt_params.vscontrol.Wt_params.slope15 
                           (FadFloat.(-) omega_g_608 
                                         params_609.Wt_params.vscontrol.Wt_params.ctInSp)
          else
            if (<) omega_g_608 
                   params_609.Wt_params.vscontrol.Wt_params.trGnSp
            then
              FadFloat.( * ) (FadFloat.( * ) params_609.Wt_params.vscontrol.Wt_params.rgn2K
                                              omega_g_608)  omega_g_608
            else
              FadFloat.( * ) params_609.Wt_params.vscontrol.Wt_params.slope25
                             
                             (FadFloat.(-) omega_g_608 
                                           params_609.Wt_params.vscontrol.Wt_params.sySp) in
  mg_d_611

type ('d , 'c , 'b , 'a) _scnd_order_lag_pitch =
  { mutable i_634 : 'd ;
    mutable m_632 : 'c ; mutable m_630 : 'b ; mutable m_627 : 'a }

let scnd_order_lag_pitch  = 
  
  let scnd_order_lag_pitch_alloc _ =
    ();
    { i_634 = (false:bool) ;
      m_632 = (FadFloat.create ():FadFloat.t) ;
      m_630 = (FadFloat.create ():FadFloat.t) ; m_627 = (FadFloat.create ():FadFloat.t) } in
  let scnd_order_lag_pitch_reset self  =
    (self.i_634 <- true:unit) in 
  let scnd_order_lag_pitch_step self ((t_613:FadFloat.t) ,
                                      (theta_d_614:FadFloat.t) ,
                                      (params_612:Wt_params.params)) =
    ((let (y0_625:FadFloat.t) =
          params_612.Wt_params.pitch.Wt_params.thetaDot0 in
      (if self.i_634 then self.m_632 <- y0_625) ;
      (let (y0_621:FadFloat.t) = params_612.Wt_params.pitch.Wt_params.theta0 in
       (if self.i_634 then self.m_630 <- y0_621) ;
       (let (x_629:FadFloat.t) =
            if self.i_634 then t_613 else FadFloat.(-) t_613  self.m_627 in
        self.i_634 <- false ;
        (let (x_633:FadFloat.t) = self.m_632 in
         let (x_631:FadFloat.t) = self.m_630 in
         let (ddtheta_615:FadFloat.t) =
             FadFloat.(-) (FadFloat.( * ) (FadFloat.(-) theta_d_614  x_631) 
                                          (FadFloat.pow params_612.Wt_params.pitch.Wt_params.omega
                                                         2.)) 
                          (FadFloat.( * ) (FadFloat.( * ) x_633 
                                                          (FadFloat.scale 
                                                             params_612.Wt_params.pitch.Wt_params.xi
                                                              2.)) 
                                          params_612.Wt_params.pitch.Wt_params.omega) in
         self.m_632 <- FadFloat.(+) (FadFloat.( * ) ddtheta_615  x_629) 
                                    x_633 ;
         self.m_630 <- FadFloat.(+) (FadFloat.( * ) x_633  x_629)  x_631 ;
         self.m_627 <- t_613 ; x_631)))):FadFloat.t) in
  Node { alloc = scnd_order_lag_pitch_alloc; reset = scnd_order_lag_pitch_reset
                                             ;
                                             step = scnd_order_lag_pitch_step }
type ('c , 'b , 'a) _fst_order_lag_pitch =
  { mutable i_650 : 'c ; mutable m_648 : 'b ; mutable m_645 : 'a }

let fst_order_lag_pitch  = 
  
  let fst_order_lag_pitch_alloc _ =
    ();
    { i_650 = (false:bool) ;
      m_648 = (FadFloat.create ():FadFloat.t) ; m_645 = (FadFloat.create ():FadFloat.t) } in
  let fst_order_lag_pitch_reset self  =
    (self.i_650 <- true:unit) in 
  let fst_order_lag_pitch_step self ((t_636:FadFloat.t) ,
                                     (theta_d_637:FadFloat.t) ,
                                     (params_635:Wt_params.params)) =
    ((let (y0_643:FadFloat.t) = params_635.Wt_params.pitch.Wt_params.theta0 in
      (if self.i_650 then self.m_648 <- y0_643) ;
      (let (x_647:FadFloat.t) =
           if self.i_650 then t_636 else FadFloat.(-) t_636  self.m_645 in
       self.i_650 <- false ;
       (let (x_649:FadFloat.t) = self.m_648 in
        let (dtheta_638:FadFloat.t) =
            FadFloat.(/) (FadFloat.( * ) (FadFloat.(-) theta_d_637  x_649) 
                                         params_635.Wt_params.pitch.Wt_params.omega)
                         
                         (FadFloat.scale params_635.Wt_params.pitch.Wt_params.xi
                                          2.) in
        self.m_648 <- FadFloat.(+) (FadFloat.( * ) dtheta_638  x_647)  x_649
        ; self.m_645 <- t_636 ; x_649))):FadFloat.t) in
  Node { alloc = fst_order_lag_pitch_alloc; reset = fst_order_lag_pitch_reset
                                            ; step = fst_order_lag_pitch_step }
type _time_delay_pitch = unit

let time_delay_pitch  = 
   let time_delay_pitch_alloc _ = () in
  let time_delay_pitch_reset self  =
    ((()):unit) in 
  let time_delay_pitch_step self ((t_652:'a5992) ,
                                  (theta_d_653:'a5984) ,
                                  (params_651:Wt_params.params)) =
    ((let (y0_657:FadFloat.t) = params_651.Wt_params.pitch.Wt_params.theta0 in
      y0_657):FadFloat.t) in
  Node { alloc = time_delay_pitch_alloc; reset = time_delay_pitch_reset ;
                                         step = time_delay_pitch_step }
type ('d , 'c , 'b , 'a) _pitch_actuator_subsystem =
  { mutable i_861 : 'd ;
    mutable i_862 : 'c ; mutable i_863 : 'b ; mutable result_664 : 'a }

let pitch_actuator_subsystem  = 
  let Node { alloc = i_861_alloc; step = i_861_step ; reset = i_861_reset } = scnd_order_lag_pitch 
   in 
  let Node { alloc = i_862_alloc; step = i_862_step ; reset = i_862_reset } = fst_order_lag_pitch 
   in 
  let Node { alloc = i_863_alloc; step = i_863_step ; reset = i_863_reset } = time_delay_pitch 
   in
  let pitch_actuator_subsystem_alloc _ =
    ();
    { result_664 = (FadFloat.create ():FadFloat.t);
      i_861 = i_861_alloc () (* discrete *)  ;
      i_862 = i_862_alloc () (* discrete *)  ;
      i_863 = i_863_alloc () (* discrete *)  } in
  let pitch_actuator_subsystem_reset self  =
    (((i_861_reset self.i_861  ; i_862_reset self.i_862 ) ;
      i_863_reset self.i_863 ):unit) in 
  let pitch_actuator_subsystem_step self ((t_661:FadFloat.t) ,
                                          (actuatorType_659:int) ,
                                          (theta_d_662:FadFloat.t) ,
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
             | _ -> self.result_664 <- FadFloat.make 0.  end) ;
      self.result_664):FadFloat.t) in
  Node { alloc = pitch_actuator_subsystem_alloc; reset = pitch_actuator_subsystem_reset
                                                 ;
                                                 step = pitch_actuator_subsystem_step }
type ('e , 'd , 'c , 'b , 'a) _servo_elastic_subsystem =
  { mutable i_864 : 'e ;
    mutable i_691 : 'd ;
    mutable m_689 : 'c ; mutable m_687 : 'b ; mutable m_684 : 'a }

let servo_elastic_subsystem  = 
  let Node { alloc = i_864_alloc; step = i_864_step ; reset = i_864_reset } = Wt_common.integrate 
   in
  let servo_elastic_subsystem_alloc _ =
    ();
    { i_691 = (false:bool) ;
      m_689 = (FadFloat.create ():FadFloat.t) ;
      m_687 = (FadFloat.create ():FadFloat.t) ; m_684 = (FadFloat.create ():FadFloat.t);
      i_864 = i_864_alloc () (* discrete *)  } in
  let servo_elastic_subsystem_reset self  =
    ((self.i_691 <- true ; i_864_reset self.i_864 ):unit) in 
  let servo_elastic_subsystem_step self ((t_669:FadFloat.t) ,
                                         (mg_d_667:FadFloat.t) ,
                                         (ma_666:FadFloat.t) ,
                                         (fa_665:FadFloat.t) ,
                                         (params_668:Wt_params.params)) =
    ((let (y0_682:FadFloat.t) = params_668.Wt_params.xt_dot0 in
      (if self.i_691 then self.m_689 <- y0_682) ;
      (let (y0_678:FadFloat.t) = params_668.Wt_params.omega0 in
       (if self.i_691 then self.m_687 <- y0_678) ;
       (let (x_686:FadFloat.t) =
            if self.i_691 then t_669 else FadFloat.(-) t_669  self.m_684 in
        self.i_691 <- false ;
        (let (x_690:FadFloat.t) = self.m_689 in
         let (xT_674:FadFloat.t) =
             i_864_step self.i_864 (x_686 , x_690 , params_668.Wt_params.xT0) in
         let (dxT_dot_671:FadFloat.t) =
             FadFloat.(/) (FadFloat.(-) (FadFloat.(-) fa_665 
                                                      (FadFloat.( * ) 
                                                         x_690 
                                                         params_668.Wt_params.cTe))
                                        
                                        (FadFloat.( * ) (FadFloat.(-) 
                                                           xT_674 
                                                           params_668.Wt_params.xT0)
                                                        
                                                        params_668.Wt_params.kTe))
                           params_668.Wt_params.mTe in
         self.m_689 <- FadFloat.(+) (FadFloat.( * ) dxT_dot_671  x_686) 
                                    x_690 ;
         (let (domega_670:FadFloat.t) =
              FadFloat.(/) (FadFloat.(-) ma_666 
                                         (FadFloat.(/) mg_d_667 
                                                       params_668.Wt_params.gBRatio))
                            params_668.Wt_params.inertia in
          let (x_688:FadFloat.t) = self.m_687 in
          self.m_687 <- FadFloat.(+) (FadFloat.( * ) domega_670  x_686) 
                                     x_688 ;
          self.m_684 <- t_669 ; (x_688 , x_690)))))):FadFloat.t * FadFloat.t) in
  Node { alloc = servo_elastic_subsystem_alloc; reset = servo_elastic_subsystem_reset
                                                ;
                                                step = servo_elastic_subsystem_step }
let cP_aeromapsPoly ((lambda_692:FadFloat.t) , (theta_693:FadFloat.t)) =
  FadFloat.(+) (FadFloat.(+) (FadFloat.(+) (FadFloat.(+) (FadFloat.(+) 
                                                            (FadFloat.(+) 
                                                               (FadFloat.(+) 
                                                                  (FadFloat.(+) 
                                                                    (
                                                                    FadFloat.(+) 
                                                                    (
                                                                    FadFloat.scale 
                                                                    (
                                                                    FadFloat.pow 
                                                                    lambda_692
                                                                     
                                                                    3.) 
                                                                    (-0.000464550681271))
                                                                    
                                                                    (
                                                                    FadFloat.scale 
                                                                    (
                                                                    FadFloat.( * ) 
                                                                    (
                                                                    FadFloat.pow 
                                                                    lambda_692
                                                                     
                                                                    2.) 
                                                                    theta_693)
                                                                    
                                                                    (-0.074780487295)))
                                                                    
                                                                    (
                                                                    FadFloat.scale 
                                                                    (
                                                                    FadFloat.pow 
                                                                    lambda_692
                                                                     
                                                                    2.) 
                                                                    (-0.00245817585907)))
                                                                  
                                                                  (FadFloat.scale 
                                                                    (
                                                                    FadFloat.( * ) 
                                                                    lambda_692
                                                                    
                                                                    (
                                                                    FadFloat.pow 
                                                                    theta_693
                                                                     
                                                                    2.)) 
                                                                    (-0.372740535667)))
                                                               
                                                               (FadFloat.scale 
                                                                  (FadFloat.( * ) 
                                                                    lambda_692
                                                                    
                                                                    theta_693)
                                                                  
                                                                  0.0711147525909))
                                                            
                                                            (FadFloat.scale 
                                                               lambda_692 
                                                               0.175932463832))
                                                         
                                                         (FadFloat.scale 
                                                            (FadFloat.pow 
                                                               theta_693  3.)
                                                             3.89808785329)) 
                                           (FadFloat.scale (FadFloat.pow 
                                                              theta_693  2.) 
                                                           (-3.51436345741)))
                              (FadFloat.scale theta_693  1.59939029665)) 
               (FadFloat.make (-0.404129012121))

let cT_aeromapsPoly ((lambda_694:FadFloat.t) , (theta_695:FadFloat.t)) =
  FadFloat.(+) (FadFloat.(+) (FadFloat.(+) (FadFloat.(+) (FadFloat.(+) 
                                                            (FadFloat.(+) 
                                                               (FadFloat.(+) 
                                                                  (FadFloat.(+) 
                                                                    (
                                                                    FadFloat.(+) 
                                                                    (
                                                                    FadFloat.scale 
                                                                    (
                                                                    FadFloat.pow 
                                                                    lambda_694
                                                                     
                                                                    3.) 
                                                                    0.00168223358976)
                                                                    
                                                                    (
                                                                    FadFloat.scale 
                                                                    (
                                                                    FadFloat.( * ) 
                                                                    (
                                                                    FadFloat.pow 
                                                                    lambda_694
                                                                     
                                                                    2.) 
                                                                    theta_695)
                                                                    
                                                                    (-0.00515118049598)))
                                                                    
                                                                    (
                                                                    FadFloat.scale 
                                                                    (
                                                                    FadFloat.pow 
                                                                    lambda_694
                                                                     
                                                                    2.) 
                                                                    (-0.0472197248104)))
                                                                  
                                                                  (FadFloat.scale 
                                                                    (
                                                                    FadFloat.( * ) 
                                                                    lambda_694
                                                                    
                                                                    (
                                                                    FadFloat.pow 
                                                                    theta_695
                                                                     
                                                                    2.)) 
                                                                    1.16475825685))
                                                               
                                                               (FadFloat.scale 
                                                                  (FadFloat.( * ) 
                                                                    lambda_694
                                                                    
                                                                    theta_695)
                                                                  
                                                                  (-1.52576164856)))
                                                            
                                                            (FadFloat.scale 
                                                               lambda_694 
                                                               0.55320691852))
                                                         
                                                         (FadFloat.scale 
                                                            (FadFloat.pow 
                                                               theta_695  3.)
                                                             6.91427835251)) 
                                           (FadFloat.scale (FadFloat.pow 
                                                              theta_695  2.) 
                                                           (-10.9675429628)))
                              (FadFloat.scale theta_695  6.00063627825)) 
               (FadFloat.make (-0.980172788619))

type _aeromapsPoly = unit

let aeromapsPoly  = 
   let aeromapsPoly_alloc _ = () in
  let aeromapsPoly_reset self  =
    ((()):unit) in 
  let aeromapsPoly_step self ((lambda_696:FadFloat.t) ,
                              (theta_697:FadFloat.t)) =
    ((let (cT_699:FadFloat.t) = cT_aeromapsPoly (lambda_696 , theta_697) in
      let (cP_698:FadFloat.t) = cP_aeromapsPoly (lambda_696 , theta_697) in
      (cP_698 , cT_699)):FadFloat.t * FadFloat.t) in
  Node { alloc = aeromapsPoly_alloc; reset = aeromapsPoly_reset ;
                                     step = aeromapsPoly_step }
type ('a) _aero_elastic_subsystem =
  { mutable i_865 : 'a }

let aero_elastic_subsystem  = 
  let Node { alloc = i_865_alloc; step = i_865_step ; reset = i_865_reset } = aeromapsPoly 
   in
  let aero_elastic_subsystem_alloc _ =
    ();{ i_865 = i_865_alloc () (* discrete *)  } in
  let aero_elastic_subsystem_reset self  =
    (i_865_reset self.i_865 :unit) in 
  let aero_elastic_subsystem_step self ((v0_703:FadFloat.t) ,
                                        (theta_702:FadFloat.t) ,
                                        (omega_700:FadFloat.t) ,
                                        (xT_dot_704:FadFloat.t) ,
                                        (params_701:Wt_params.params)) =
    ((let (v_rel_712:FadFloat.t) = FadFloat.(-) v0_703  xT_dot_704 in
      let (lambda_709:FadFloat.t) =
          FadFloat.(/) (FadFloat.( * ) omega_700  params_701.Wt_params.rotor)
                        v_rel_712 in
      let ((cP_705:FadFloat.t) , (cT_706:FadFloat.t)) =
          i_865_step self.i_865 (lambda_709 , theta_702) in
      let (fa'_708:FadFloat.t) =
          FadFloat.( * ) (FadFloat.( * ) (FadFloat.( * ) cT_706 
                                                         (FadFloat.scale 
                                                            params_701.Wt_params.rho
                                                             0.5)) 
                                         Wt_common.pi_t) 
                         (FadFloat.pow params_701.Wt_params.rotor  2.) in
      let (fa_707:FadFloat.t) =
          FadFloat.( * ) (FadFloat.( * ) fa'_708  v_rel_712)  v_rel_712 in
      let (ma'_711:FadFloat.t) =
          FadFloat.(/) (FadFloat.( * ) (FadFloat.( * ) (FadFloat.( * ) 
                                                          cP_705 
                                                          (FadFloat.scale 
                                                             params_701.Wt_params.rho
                                                              0.5)) 
                                                       Wt_common.pi_t) 
                                       (FadFloat.pow params_701.Wt_params.rotor
                                                      3.))  lambda_709 in
      let (ma_710:FadFloat.t) =
          FadFloat.( * ) (FadFloat.( * ) ma'_711  v_rel_712)  v_rel_712 in
      (ma_710 , fa_707)):FadFloat.t * FadFloat.t) in
  Node { alloc = aero_elastic_subsystem_alloc; reset = aero_elastic_subsystem_reset
                                               ;
                                               step = aero_elastic_subsystem_step }
type ('g , 'f , 'e , 'd , 'c , 'b , 'a) _wind_turbine =
  { mutable i_868 : 'g ;
    mutable i_867 : 'f ;
    mutable i_866 : 'e ;
    mutable i_749 : 'd ;
    mutable m_747 : 'c ; mutable m_745 : 'b ; mutable m_742 : 'a }

let wind_turbine  = 
  let Node { alloc = i_868_alloc; step = i_868_step ; reset = i_868_reset } = pitch_actuator_subsystem 
   in 
  let Node { alloc = i_867_alloc; step = i_867_step ; reset = i_867_reset } = aero_elastic_subsystem 
   in 
  let Node { alloc = i_866_alloc; step = i_866_step ; reset = i_866_reset } = Wt_common.integrate 
   in
  let wind_turbine_alloc _ =
    ();
    { i_749 = (false:bool) ;
      m_747 = (FadFloat.create ():FadFloat.t) ;
      m_745 = (FadFloat.create ():FadFloat.t) ; m_742 = (FadFloat.create ():FadFloat.t);
      i_868 = i_868_alloc () (* discrete *)  ;
      i_867 = i_867_alloc () (* discrete *)  ;
      i_866 = i_866_alloc () (* discrete *)  } in
  let wind_turbine_reset self  =
    ((self.i_749 <- true ;
      i_868_reset self.i_868  ;
      i_867_reset self.i_867  ; i_866_reset self.i_866 ):unit) in 
  let wind_turbine_step self ((t_715:FadFloat.t) ,
                              (v0_717:FadFloat.t) ,
                              (theta_d_716:FadFloat.t) ,
                              (mg_d_713:FadFloat.t) ,
                              (params_714:Wt_params.params)) =
    ((let (y0_740:FadFloat.t) = params_714.Wt_params.xt_dot0 in
      (if self.i_749 then self.m_747 <- y0_740) ;
      (let (y0_736:FadFloat.t) = params_714.Wt_params.omega0 in
       (if self.i_749 then self.m_745 <- y0_736) ;
       (let (x_744:FadFloat.t) =
            if self.i_749 then t_715 else FadFloat.(-) t_715  self.m_742 in
        self.i_749 <- false ;
        (let (x_746:FadFloat.t) = self.m_745 in
         let (x_748:FadFloat.t) = self.m_747 in
         let (blade_pitch_angle_718:FadFloat.t) =
             i_868_step self.i_868
               (t_715 ,
                params_714.Wt_params.pitch.Wt_params.actuatorType ,
                theta_d_716 , params_714) in
         let ((ma_720:FadFloat.t) , (fa_719:FadFloat.t)) =
             i_867_step self.i_867
               (v0_717 , blade_pitch_angle_718 , x_746 , x_748 , params_714) in
         let (xT_732:FadFloat.t) =
             i_866_step self.i_866 (x_744 , x_748 , params_714.Wt_params.xT0) in
         let (dxT_dot_729:FadFloat.t) =
             FadFloat.(/) (FadFloat.(-) (FadFloat.(-) fa_719 
                                                      (FadFloat.( * ) 
                                                         x_748 
                                                         params_714.Wt_params.cTe))
                                        
                                        (FadFloat.( * ) (FadFloat.(-) 
                                                           xT_732 
                                                           params_714.Wt_params.xT0)
                                                        
                                                        params_714.Wt_params.kTe))
                           params_714.Wt_params.mTe in
         self.m_747 <- FadFloat.(+) (FadFloat.( * ) dxT_dot_729  x_744) 
                                    x_748 ;
         (let (domega_728:FadFloat.t) =
              FadFloat.(/) (FadFloat.(-) ma_720 
                                         (FadFloat.(/) mg_d_713 
                                                       params_714.Wt_params.gBRatio))
                            params_714.Wt_params.inertia in
          self.m_745 <- FadFloat.(+) (FadFloat.( * ) domega_728  x_744) 
                                     x_746 ;
          self.m_742 <- t_715 ; (blade_pitch_angle_718 , x_746)))))):
    FadFloat.t * FadFloat.t) in
  Node { alloc = wind_turbine_alloc; reset = wind_turbine_reset ;
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
  let Node { alloc = i_873_alloc; step = i_873_step ; reset = i_873_reset } = rate_limiter 
   in 
  let Node { alloc = i_872_alloc; step = i_872_step ; reset = i_872_reset } = pitch_actuator_subsystem 
   in 
  let Node { alloc = i_871_alloc; step = i_871_step ; reset = i_871_reset } = aero_elastic_subsystem 
   in 
  let Node { alloc = i_870_alloc; step = i_870_step ; reset = i_870_reset } = Wt_common.integrate 
   in 
  let Node { alloc = i_869_alloc; step = i_869_step ; reset = i_869_reset } = rate_limiter 
   in
  let wt_alloc _ =
    ();
    { i_860 = (false:bool) ;
      m_858 = (FadFloat.create ():FadFloat.t) ;
      m_855 = (FadFloat.create ():FadFloat.t) ;
      m_853 = (FadFloat.create ():FadFloat.t) ;
      m_850 = (FadFloat.create ():FadFloat.t) ;
      m_848 = (FadFloat.create ():FadFloat.t) ;
      m_845 = (FadFloat.create ():FadFloat.t) ;
      m_843 = (FadFloat.create ():FadFloat.t) ;
      m_841 = (FadFloat.create ():FadFloat.t) ;
      m_839 = (FadFloat.create ():FadFloat.t) ;
      m_836 = (FadFloat.create ():FadFloat.t) ;
      v0_0_763 = (FadFloat.create ():FadFloat.t);
      i_873 = i_873_alloc () (* discrete *)  ;
      i_872 = i_872_alloc () (* discrete *)  ;
      i_871 = i_871_alloc () (* discrete *)  ;
      i_870 = i_870_alloc () (* discrete *)  ;
      i_869 = i_869_alloc () (* discrete *)  } in
  let wt_reset self  =
    ((self.i_860 <- true ;
      i_873_reset self.i_873  ;
      i_872_reset self.i_872  ;
      i_871_reset self.i_871  ;
      i_870_reset self.i_870  ; i_869_reset self.i_869 ):unit) in 
  let wt_step self ((t_750:FadFloat.t) , (v0_751:FadFloat.t)) =
    (((if self.i_860 then self.v0_0_763 <- v0_751) ;
      (let (params_756:Wt_params.params) =
           Wt_params.get_default self.v0_0_763 in
       let (y0_834:FadFloat.t) = params_756.Wt_params.omega_g0 in
       (if self.i_860 then self.m_858 <- y0_834) ;
       (let (x_857:FadFloat.t) =
            if self.i_860 then t_750 else FadFloat.(-) t_750  self.m_855 in
        let (y0_824:FadFloat.t) = params_756.Wt_params.pitch.Wt_params.theta0 in
        (if self.i_860 then self.m_853 <- y0_824) ;
        (let (x_852:FadFloat.t) =
             if self.i_860 then t_750 else FadFloat.(-) t_750  self.m_850 in
         let (y0_814:FadFloat.t) =
             FadFloat.( * ) params_756.Wt_params.pitch.Wt_params.theta0 
                            (FadFloat.translate (FadFloat.(/) params_756.Wt_params.pitch.Wt_params.theta0
                                                              
                                                              params_756.Wt_params.pitch.Wt_params.cpc.Wt_params.gS_factor)
                                                 1.) in
         (if self.i_860 then self.m_848 <- y0_814) ;
         (let (x_847:FadFloat.t) =
              if self.i_860 then t_750 else FadFloat.(-) t_750  self.m_845 in
          (if self.i_860 then
           self.m_843 <- params_756.Wt_params.pitch.Wt_params.theta0) ;
          (let (y0_791:FadFloat.t) = params_756.Wt_params.xt_dot0 in
           (if self.i_860 then self.m_841 <- y0_791) ;
           (let (y0_787:FadFloat.t) = params_756.Wt_params.omega0 in
            (if self.i_860 then self.m_839 <- y0_787) ;
            (let (x_838:FadFloat.t) =
                 if self.i_860 then t_750 else FadFloat.(-) t_750  self.m_836 in
             self.i_860 <- false ;
             (let (rob_optim_757:FadFloat.t) = FadFloat.make 0. in
              let (x_840:FadFloat.t) = self.m_839 in
              let (u_828:FadFloat.t) =
                  FadFloat.(/) x_840  params_756.Wt_params.gBRatio in
              let (x_859:FadFloat.t) = self.m_858 in
              let (dy_829:FadFloat.t) =
                  FadFloat.(/) (FadFloat.(-) u_828  x_859) 
                               params_756.Wt_params.vscontrol.Wt_params.vs_filterConstant in
              self.m_858 <- FadFloat.(+) (FadFloat.( * ) dy_829  x_857) 
                                         x_859 ;
              self.m_855 <- t_750 ;
              (let (x_844:FadFloat.t) = self.m_843 in
               let (gs_799:FadFloat.t) =
                   FadFloat.inv (FadFloat.translate (FadFloat.(/) x_844 
                                                                  params_756.Wt_params.pitch.Wt_params.cpc.Wt_params.gS_factor)
                                                     1.) in
               let (omega_g_rated_794:FadFloat.t) =
                   params_756.Wt_params.omega_g_rated in
               let (e_798:FadFloat.t) = FadFloat.(-) x_859  omega_g_rated_794 in
               let (e1_805:FadFloat.t) =
                   FadFloat.( * ) e_798 
                                  params_756.Wt_params.pitch.Wt_params.cpc.Wt_params.kP in
               let (x_849:FadFloat.t) = self.m_848 in
               let (e4_808:FadFloat.t) = FadFloat.(+) e1_805  x_849 in
               let (theta_d'_810:FadFloat.t) = FadFloat.( * ) gs_799  e4_808 in
               let (theta_d_809:FadFloat.t) =
                   saturate (params_756.Wt_params.pitch.Wt_params.min ,
                             params_756.Wt_params.pitch.Wt_params.max ,
                             theta_d'_810) in
               let (theta_d_759:FadFloat.t) =
                   i_873_step self.i_873
                     (t_750 ,
                      params_756.Wt_params.pitch.Wt_params.rateLimit ,
                      (FadFloat.(~-) params_756.Wt_params.pitch.Wt_params.rateLimit)
                      ,
                      params_756.Wt_params.pitch.Wt_params.thetaDot0 ,
                      theta_d_809) in
               let (blade_pitch_angle_769:FadFloat.t) =
                   i_872_step self.i_872
                     (t_750 ,
                      params_756.Wt_params.pitch.Wt_params.actuatorType ,
                      theta_d_759 , params_756) in
               let (x_854:FadFloat.t) = self.m_853 in
               let (dy_819:FadFloat.t) =
                   FadFloat.(/) (FadFloat.(-) blade_pitch_angle_769  x_854) 
                                params_756.Wt_params.pitch.Wt_params.pitch_filterConstant in
               self.m_853 <- FadFloat.(+) (FadFloat.( * ) dy_819  x_852) 
                                          x_854 ;
               self.m_850 <- t_750 ;
               (let (e2_806:FadFloat.t) =
                    FadFloat.(-) e1_805 
                                 (FadFloat.( * ) (FadFloat.(-) theta_d'_810 
                                                               theta_d_809) 
                                                 params_756.Wt_params.pitch.Wt_params.cpc.Wt_params.antiWindUp) in
                let (x_813:FadFloat.t) =
                    FadFloat.(/) e2_806 
                                 params_756.Wt_params.pitch.Wt_params.cpc.Wt_params.tI in
                self.m_848 <- FadFloat.(+) (FadFloat.( * ) x_813  x_847) 
                                           x_849 ;
                self.m_845 <- t_750 ;
                self.m_843 <- blade_pitch_angle_769 ;
                (let (x_842:FadFloat.t) = self.m_841 in
                 let ((ma_771:FadFloat.t) , (fa_770:FadFloat.t)) =
                     i_871_step self.i_871
                       (v0_751 ,
                        blade_pitch_angle_769 , x_840 , x_842 , params_756) in
                 let (xT_783:FadFloat.t) =
                     i_870_step self.i_870
                       (x_838 , x_842 , params_756.Wt_params.xT0) in
                 let (dxT_dot_780:FadFloat.t) =
                     FadFloat.(/) (FadFloat.(-) (FadFloat.(-) fa_770 
                                                              (FadFloat.( * ) 
                                                                 x_842 
                                                                 params_756.Wt_params.cTe))
                                                
                                                (FadFloat.( * ) (FadFloat.(-) 
                                                                   xT_783 
                                                                   params_756.Wt_params.xT0)
                                                                
                                                                params_756.Wt_params.kTe))
                                   params_756.Wt_params.mTe in
                 self.m_841 <- FadFloat.(+) (FadFloat.( * ) dxT_dot_780 
                                                            x_838)  x_842 ;
                 (let (mg_d_753:FadFloat.t) =
                      torque_controller (x_859 , theta_d_759 , params_756) in
                  let (torque_aux_762:FadFloat.t) =
                      i_869_step self.i_869
                        (t_750 ,
                         params_756.Wt_params.vscontrol.Wt_params.maxRat ,
                         (FadFloat.(~-) params_756.Wt_params.vscontrol.Wt_params.maxRat)
                         , (FadFloat.make 0.) , mg_d_753) in
                  let (torque_761:FadFloat.t) =
                      saturate (FadFloat.neg_infinity ,
                                params_756.Wt_params.vscontrol.Wt_params.maxTq
                                , torque_aux_762) in
                  let (domega_779:FadFloat.t) =
                      FadFloat.(/) (FadFloat.(-) ma_771 
                                                 (FadFloat.(/) torque_761 
                                                               params_756.Wt_params.gBRatio))
                                    params_756.Wt_params.inertia in
                  self.m_839 <- FadFloat.(+) (FadFloat.( * ) domega_779 
                                                             x_838)  
                                             x_840 ;
                  self.m_836 <- t_750 ;
                  ((Wt_common.rad2deg x_854) ,
                   (Wt_common.radPs2rpm x_840) ,
                   (Wt_common.radPs2rpm x_859) ,
                   (Wt_common.rad2deg theta_d_759) ,
                   (Wt_common.rad2deg blade_pitch_angle_769) ,
                   mg_d_753 , rob_optim_757)))))))))))))):FadFloat.t *
                                                          FadFloat.t *
                                                          FadFloat.t *
                                                          FadFloat.t *
                                                          FadFloat.t *
                                                          FadFloat.t *
                                                          FadFloat.t) in
  Node { alloc = wt_alloc; reset = wt_reset ; step = wt_step }
