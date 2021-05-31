(* The Zélus compiler, version 2.0
  (jeudi 4 juin 2020, 17:57:12 (UTC+0200)) *)
open Ztypes
open MyOp
open Wt_common
open Wt_params
let saturate ((low_654:MyOp.t) , (high_653:MyOp.t) , (v_655:MyOp.t)) =
  MyOp.min (MyOp.max v_655  low_654)  high_653

type _transport_delay = unit

let transport_delay  = 
   let transport_delay_alloc _ = () in
  let transport_delay_reset self  =
    ((()):unit) in 
  let transport_delay_step self ((t_657:'a6252) ,
                                 (delay_656:'a6251) , (y0_658:'a6259)) =
    (y0_658:'a) in
  Node { alloc = transport_delay_alloc; reset = transport_delay_reset ;
                                        step = transport_delay_step }
type ('e , 'd , 'c , 'b , 'a) _rate_limiter =
  { mutable i_680 : 'e ;
    mutable m_675 : 'd ;
    mutable m_673 : 'c ; mutable m_671 : 'b ; mutable m_668 : 'a }

let rate_limiter  = 
  
  let rate_limiter_alloc _ =
    ();
    { i_680 = (false:bool) ;
      m_675 = (MyOp.create ():MyOp.t) ;
      m_673 = (MyOp.create ():MyOp.t) ;
      m_671 = (MyOp.create ():MyOp.t) ; m_668 = (MyOp.create ():MyOp.t) } in
  let rate_limiter_reset self  =
    (self.i_680 <- true:unit) in 
  let rate_limiter_step self ((t_662:MyOp.t) ,
                              (rising_661:MyOp.t) ,
                              (falling_660:MyOp.t) ,
                              (y0_664:'a6265) , (x_663:MyOp.t)) =
    ((let (x_670:MyOp.t) =
          if self.i_680 then t_662 else MyOp.(-) t_662  self.m_668 in
      let (x_677:MyOp.t) =
          MyOp.(+) (MyOp.( * ) x_670  falling_660)  self.m_675 in
      let (x_678:MyOp.t) =
          MyOp.(+) (MyOp.( * ) x_670  rising_661)  self.m_673 in
      let (rate_665:MyOp.t) = MyOp.(/) (MyOp.(-) x_663  self.m_671)  x_670 in
      let (x_679:MyOp.t) =
          if self.i_680
          then x_663
          else
            if (>) rate_665  rising_661
            then x_678
            else if (<) rate_665  falling_660 then x_677 else x_663 in
      self.i_680 <- false ;
      self.m_675 <- x_679 ;
      self.m_673 <- x_679 ; self.m_671 <- x_679 ; self.m_668 <- t_662 ; x_679):
    MyOp.t) in
  Node { alloc = rate_limiter_alloc; reset = rate_limiter_reset ;
                                     step = rate_limiter_step }
type ('c , 'b , 'a) _collective_pitch_with_anti_windup =
  { mutable i_701 : 'c ; mutable m_699 : 'b ; mutable m_696 : 'a }

let collective_pitch_with_anti_windup  = 
  
  let collective_pitch_with_anti_windup_alloc _ =
    ();
    { i_701 = (false:bool) ;
      m_699 = (MyOp.create ():MyOp.t) ; m_696 = (MyOp.create ():MyOp.t) } in
  let collective_pitch_with_anti_windup_reset self  =
    (self.i_701 <- true:unit) in 
  let collective_pitch_with_anti_windup_step self ((t_684:MyOp.t) ,
                                                   (e_681:MyOp.t) ,
                                                   (gs_682:MyOp.t) ,
                                                   (params_683:Wt_params.params)) =
    ((let (y0_694:MyOp.t) =
          MyOp.( * ) params_683.Wt_params.pitch.Wt_params.theta0 
                     (MyOp.translate (MyOp.(/) params_683.Wt_params.pitch.Wt_params.theta0
                                               
                                               params_683.Wt_params.pitch.Wt_params.cpc.Wt_params.gS_factor)
                                      1.) in
      (if self.i_701 then self.m_699 <- y0_694) ;
      (let (x_698:MyOp.t) =
           if self.i_701 then t_684 else MyOp.(-) t_684  self.m_696 in
       self.i_701 <- false ;
       (let (e1_685:MyOp.t) =
            MyOp.( * ) e_681 
                       params_683.Wt_params.pitch.Wt_params.cpc.Wt_params.kP in
        let (x_700:MyOp.t) = self.m_699 in
        let (e4_688:MyOp.t) = MyOp.(+) e1_685  x_700 in
        let (theta_d'_690:MyOp.t) = MyOp.( * ) gs_682  e4_688 in
        let (theta_d_689:MyOp.t) =
            saturate (params_683.Wt_params.pitch.Wt_params.min ,
                      params_683.Wt_params.pitch.Wt_params.max , theta_d'_690) in
        let (e2_686:MyOp.t) =
            MyOp.(-) e1_685 
                     (MyOp.( * ) (MyOp.(-) theta_d'_690  theta_d_689) 
                                 params_683.Wt_params.pitch.Wt_params.cpc.Wt_params.antiWindUp) in
        let (x_693:MyOp.t) =
            MyOp.(/) e2_686 
                     params_683.Wt_params.pitch.Wt_params.cpc.Wt_params.tI in
        self.m_699 <- MyOp.(+) (MyOp.( * ) x_693  x_698)  x_700 ;
        self.m_696 <- t_684 ; theta_d_689))):MyOp.t) in
  Node { alloc = collective_pitch_with_anti_windup_alloc; reset = collective_pitch_with_anti_windup_reset
                                                          ;
                                                          step = collective_pitch_with_anti_windup_step }
type ('d , 'c , 'b , 'a) _coll_pitch_controller =
  { mutable i_732 : 'd ;
    mutable m_730 : 'c ; mutable m_727 : 'b ; mutable m_725 : 'a }

let coll_pitch_controller  = 
  
  let coll_pitch_controller_alloc _ =
    ();
    { i_732 = (false:bool) ;
      m_730 = (MyOp.create ():MyOp.t) ;
      m_727 = (MyOp.create ():MyOp.t) ; m_725 = (MyOp.create ():MyOp.t) } in
  let coll_pitch_controller_reset self  =
    (self.i_732 <- true:unit) in 
  let coll_pitch_controller_step self ((t_705:MyOp.t) ,
                                       (omega_g_702:MyOp.t) ,
                                       (theta_in_706:MyOp.t) ,
                                       (omega_g_rated_703:MyOp.t) ,
                                       (params_704:Wt_params.params)) =
    ((let (y0_723:MyOp.t) =
          MyOp.( * ) params_704.Wt_params.pitch.Wt_params.theta0 
                     (MyOp.translate (MyOp.(/) params_704.Wt_params.pitch.Wt_params.theta0
                                               
                                               params_704.Wt_params.pitch.Wt_params.cpc.Wt_params.gS_factor)
                                      1.) in
      (if self.i_732 then self.m_730 <- y0_723) ;
      (let (x_729:MyOp.t) =
           if self.i_732 then t_705 else MyOp.(-) t_705  self.m_727 in
       (if self.i_732 then
        self.m_725 <- params_704.Wt_params.pitch.Wt_params.theta0) ;
       self.i_732 <- false ;
       (let (e_707:MyOp.t) = MyOp.(-) omega_g_702  omega_g_rated_703 in
        let (e1_714:MyOp.t) =
            MyOp.( * ) e_707 
                       params_704.Wt_params.pitch.Wt_params.cpc.Wt_params.kP in
        let (x_726:MyOp.t) = self.m_725 in
        let (gs_708:MyOp.t) =
            MyOp.inv (MyOp.translate (MyOp.(/) x_726 
                                               params_704.Wt_params.pitch.Wt_params.cpc.Wt_params.gS_factor)
                                      1.) in
        let (x_731:MyOp.t) = self.m_730 in
        let (e4_717:MyOp.t) = MyOp.(+) e1_714  x_731 in
        let (theta_d'_719:MyOp.t) = MyOp.( * ) gs_708  e4_717 in
        let (theta_d_718:MyOp.t) =
            saturate (params_704.Wt_params.pitch.Wt_params.min ,
                      params_704.Wt_params.pitch.Wt_params.max , theta_d'_719) in
        let (e2_715:MyOp.t) =
            MyOp.(-) e1_714 
                     (MyOp.( * ) (MyOp.(-) theta_d'_719  theta_d_718) 
                                 params_704.Wt_params.pitch.Wt_params.cpc.Wt_params.antiWindUp) in
        let (x_722:MyOp.t) =
            MyOp.(/) e2_715 
                     params_704.Wt_params.pitch.Wt_params.cpc.Wt_params.tI in
        self.m_730 <- MyOp.(+) (MyOp.( * ) x_722  x_729)  x_731 ;
        self.m_727 <- t_705 ; self.m_725 <- theta_in_706 ; theta_d_718))):
    MyOp.t) in
  Node { alloc = coll_pitch_controller_alloc; reset = coll_pitch_controller_reset
                                              ;
                                              step = coll_pitch_controller_step }
type ('c , 'b , 'a) _filter_pitch =
  { mutable i_748 : 'c ; mutable m_746 : 'b ; mutable m_743 : 'a }

let filter_pitch  = 
  
  let filter_pitch_alloc _ =
    ();
    { i_748 = (false:bool) ;
      m_746 = (MyOp.create ():MyOp.t) ; m_743 = (MyOp.create ():MyOp.t) } in
  let filter_pitch_reset self  =
    (self.i_748 <- true:unit) in 
  let filter_pitch_step self ((t_734:MyOp.t) ,
                              (u_735:MyOp.t) , (params_733:Wt_params.params)) =
    ((let (y0_741:MyOp.t) = params_733.Wt_params.pitch.Wt_params.theta0 in
      (if self.i_748 then self.m_746 <- y0_741) ;
      (let (x_745:MyOp.t) =
           if self.i_748 then t_734 else MyOp.(-) t_734  self.m_743 in
       self.i_748 <- false ;
       (let (x_747:MyOp.t) = self.m_746 in
        let (dy_736:MyOp.t) =
            MyOp.(/) (MyOp.(-) u_735  x_747) 
                     params_733.Wt_params.pitch.Wt_params.pitch_filterConstant in
        self.m_746 <- MyOp.(+) (MyOp.( * ) dy_736  x_745)  x_747 ;
        self.m_743 <- t_734 ; x_747))):MyOp.t) in
  Node { alloc = filter_pitch_alloc; reset = filter_pitch_reset ;
                                     step = filter_pitch_step }
type ('c , 'b , 'a) _filter_drehzahl =
  { mutable i_764 : 'c ; mutable m_762 : 'b ; mutable m_759 : 'a }

let filter_drehzahl  = 
  
  let filter_drehzahl_alloc _ =
    ();
    { i_764 = (false:bool) ;
      m_762 = (MyOp.create ():MyOp.t) ; m_759 = (MyOp.create ():MyOp.t) } in
  let filter_drehzahl_reset self  =
    (self.i_764 <- true:unit) in 
  let filter_drehzahl_step self ((t_750:MyOp.t) ,
                                 (u_751:MyOp.t) ,
                                 (params_749:Wt_params.params)) =
    ((let (y0_757:MyOp.t) = params_749.Wt_params.omega_g0 in
      (if self.i_764 then self.m_762 <- y0_757) ;
      (let (x_761:MyOp.t) =
           if self.i_764 then t_750 else MyOp.(-) t_750  self.m_759 in
       self.i_764 <- false ;
       (let (x_763:MyOp.t) = self.m_762 in
        let (dy_752:MyOp.t) =
            MyOp.(/) (MyOp.(-) u_751  x_763) 
                     params_749.Wt_params.vscontrol.Wt_params.vs_filterConstant in
        self.m_762 <- MyOp.(+) (MyOp.( * ) dy_752  x_761)  x_763 ;
        self.m_759 <- t_750 ; x_763))):MyOp.t) in
  Node { alloc = filter_drehzahl_alloc; reset = filter_drehzahl_reset ;
                                        step = filter_drehzahl_step }
let torque_controller ((omega_g_765:MyOp.t) ,
                       (theta_d_767:MyOp.t) , (params_766:Wt_params.params)) =
  let (mg_d_768:MyOp.t) =
      if (||) ((>=) omega_g_765 
                    params_766.Wt_params.vscontrol.Wt_params.rtGnSp) 
              ((>=) theta_d_767 
                    params_766.Wt_params.vscontrol.Wt_params.rgn3MP)
      then
        MyOp.(/) params_766.Wt_params.vscontrol.Wt_params.rtPwr  omega_g_765
      else
        if (<=) omega_g_765  params_766.Wt_params.vscontrol.Wt_params.ctInSp
        then MyOp.make 0.
        else
          if (<) omega_g_765  params_766.Wt_params.vscontrol.Wt_params.rgn2Sp
          then
            MyOp.( * ) params_766.Wt_params.vscontrol.Wt_params.slope15 
                       (MyOp.(-) omega_g_765 
                                 params_766.Wt_params.vscontrol.Wt_params.ctInSp)
          else
            if (<) omega_g_765 
                   params_766.Wt_params.vscontrol.Wt_params.trGnSp
            then
              MyOp.( * ) (MyOp.( * ) params_766.Wt_params.vscontrol.Wt_params.rgn2K
                                      omega_g_765)  omega_g_765
            else
              MyOp.( * ) params_766.Wt_params.vscontrol.Wt_params.slope25 
                         (MyOp.(-) omega_g_765 
                                   params_766.Wt_params.vscontrol.Wt_params.sySp) in
  mg_d_768

type ('d , 'c , 'b , 'a) _scnd_order_lag_pitch =
  { mutable i_791 : 'd ;
    mutable m_789 : 'c ; mutable m_787 : 'b ; mutable m_784 : 'a }

let scnd_order_lag_pitch  = 
  
  let scnd_order_lag_pitch_alloc _ =
    ();
    { i_791 = (false:bool) ;
      m_789 = (MyOp.create ():MyOp.t) ;
      m_787 = (MyOp.create ():MyOp.t) ; m_784 = (MyOp.create ():MyOp.t) } in
  let scnd_order_lag_pitch_reset self  =
    (self.i_791 <- true:unit) in 
  let scnd_order_lag_pitch_step self ((t_770:MyOp.t) ,
                                      (theta_d_771:MyOp.t) ,
                                      (params_769:Wt_params.params)) =
    ((let (y0_782:MyOp.t) = params_769.Wt_params.pitch.Wt_params.thetaDot0 in
      (if self.i_791 then self.m_789 <- y0_782) ;
      (let (y0_778:MyOp.t) = params_769.Wt_params.pitch.Wt_params.theta0 in
       (if self.i_791 then self.m_787 <- y0_778) ;
       (let (x_786:MyOp.t) =
            if self.i_791 then t_770 else MyOp.(-) t_770  self.m_784 in
        self.i_791 <- false ;
        (let (x_790:MyOp.t) = self.m_789 in
         let (x_788:MyOp.t) = self.m_787 in
         let (ddtheta_772:MyOp.t) =
             MyOp.(-) (MyOp.( * ) (MyOp.(-) theta_d_771  x_788) 
                                  (MyOp.pow params_769.Wt_params.pitch.Wt_params.omega
                                             2.)) 
                      (MyOp.( * ) (MyOp.( * ) x_790 
                                              (MyOp.scale params_769.Wt_params.pitch.Wt_params.xi
                                                           2.)) 
                                  params_769.Wt_params.pitch.Wt_params.omega) in
         self.m_789 <- MyOp.(+) (MyOp.( * ) ddtheta_772  x_786)  x_790 ;
         self.m_787 <- MyOp.(+) (MyOp.( * ) x_790  x_786)  x_788 ;
         self.m_784 <- t_770 ; x_788)))):MyOp.t) in
  Node { alloc = scnd_order_lag_pitch_alloc; reset = scnd_order_lag_pitch_reset
                                             ;
                                             step = scnd_order_lag_pitch_step }
type ('c , 'b , 'a) _fst_order_lag_pitch =
  { mutable i_807 : 'c ; mutable m_805 : 'b ; mutable m_802 : 'a }

let fst_order_lag_pitch  = 
  
  let fst_order_lag_pitch_alloc _ =
    ();
    { i_807 = (false:bool) ;
      m_805 = (MyOp.create ():MyOp.t) ; m_802 = (MyOp.create ():MyOp.t) } in
  let fst_order_lag_pitch_reset self  =
    (self.i_807 <- true:unit) in 
  let fst_order_lag_pitch_step self ((t_793:MyOp.t) ,
                                     (theta_d_794:MyOp.t) ,
                                     (params_792:Wt_params.params)) =
    ((let (y0_800:MyOp.t) = params_792.Wt_params.pitch.Wt_params.theta0 in
      (if self.i_807 then self.m_805 <- y0_800) ;
      (let (x_804:MyOp.t) =
           if self.i_807 then t_793 else MyOp.(-) t_793  self.m_802 in
       self.i_807 <- false ;
       (let (x_806:MyOp.t) = self.m_805 in
        let (dtheta_795:MyOp.t) =
            MyOp.(/) (MyOp.( * ) (MyOp.(-) theta_d_794  x_806) 
                                 params_792.Wt_params.pitch.Wt_params.omega) 
                     (MyOp.scale params_792.Wt_params.pitch.Wt_params.xi  2.) in
        self.m_805 <- MyOp.(+) (MyOp.( * ) dtheta_795  x_804)  x_806 ;
        self.m_802 <- t_793 ; x_806))):MyOp.t) in
  Node { alloc = fst_order_lag_pitch_alloc; reset = fst_order_lag_pitch_reset
                                            ; step = fst_order_lag_pitch_step }
type _time_delay_pitch = unit

let time_delay_pitch  = 
   let time_delay_pitch_alloc _ = () in
  let time_delay_pitch_reset self  =
    ((()):unit) in 
  let time_delay_pitch_step self ((t_809:'a7073) ,
                                  (theta_d_810:'a7065) ,
                                  (params_808:Wt_params.params)) =
    ((let (y0_814:MyOp.t) = params_808.Wt_params.pitch.Wt_params.theta0 in
      y0_814):MyOp.t) in
  Node { alloc = time_delay_pitch_alloc; reset = time_delay_pitch_reset ;
                                         step = time_delay_pitch_step }
type ('d , 'c , 'b , 'a) _pitch_actuator_subsystem =
  { mutable i_1155 : 'd ;
    mutable i_1156 : 'c ; mutable i_1157 : 'b ; mutable result_821 : 'a }

let pitch_actuator_subsystem  = 
  let Node { alloc = i_1155_alloc; step = i_1155_step ; reset = i_1155_reset } = scnd_order_lag_pitch 
   in 
  let Node { alloc = i_1156_alloc; step = i_1156_step ; reset = i_1156_reset } = fst_order_lag_pitch 
   in 
  let Node { alloc = i_1157_alloc; step = i_1157_step ; reset = i_1157_reset } = time_delay_pitch 
   in
  let pitch_actuator_subsystem_alloc _ =
    ();
    { result_821 = (MyOp.create ():MyOp.t);
      i_1155 = i_1155_alloc () (* discrete *)  ;
      i_1156 = i_1156_alloc () (* discrete *)  ;
      i_1157 = i_1157_alloc () (* discrete *)  } in
  let pitch_actuator_subsystem_reset self  =
    (((i_1155_reset self.i_1155  ; i_1156_reset self.i_1156 ) ;
      i_1157_reset self.i_1157 ):unit) in 
  let pitch_actuator_subsystem_step self ((t_818:MyOp.t) ,
                                          (actuatorType_816:int) ,
                                          (theta_d_819:MyOp.t) ,
                                          (params_817:Wt_params.params)) =
    (((begin match actuatorType_816 with
             | 1 ->
                 self.result_821 <- i_1155_step self.i_1155
                                      (t_818 , theta_d_819 , params_817)
             | 2 ->
                 self.result_821 <- i_1156_step self.i_1156
                                      (t_818 , theta_d_819 , params_817)
             | 3 ->
                 self.result_821 <- i_1157_step self.i_1157
                                      (t_818 , theta_d_819 , params_817)
             | _ -> self.result_821 <- MyOp.make 0.  end) ; self.result_821):
    MyOp.t) in
  Node { alloc = pitch_actuator_subsystem_alloc; reset = pitch_actuator_subsystem_reset
                                                 ;
                                                 step = pitch_actuator_subsystem_step }
type ('e , 'd , 'c , 'b , 'a) _servo_elastic_subsystem =
  { mutable i_1158 : 'e ;
    mutable i_848 : 'd ;
    mutable m_846 : 'c ; mutable m_844 : 'b ; mutable m_841 : 'a }

let servo_elastic_subsystem  = 
  let Node { alloc = i_1158_alloc; step = i_1158_step ; reset = i_1158_reset } = Wt_common.integrate 
   in
  let servo_elastic_subsystem_alloc _ =
    ();
    { i_848 = (false:bool) ;
      m_846 = (MyOp.create ():MyOp.t) ;
      m_844 = (MyOp.create ():MyOp.t) ; m_841 = (MyOp.create ():MyOp.t);
      i_1158 = i_1158_alloc () (* discrete *)  } in
  let servo_elastic_subsystem_reset self  =
    ((self.i_848 <- true ; i_1158_reset self.i_1158 ):unit) in 
  let servo_elastic_subsystem_step self ((t_826:MyOp.t) ,
                                         (mg_d_824:MyOp.t) ,
                                         (ma_823:MyOp.t) ,
                                         (fa_822:MyOp.t) ,
                                         (params_825:Wt_params.params)) =
    ((let (y0_839:MyOp.t) = params_825.Wt_params.xt_dot0 in
      (if self.i_848 then self.m_846 <- y0_839) ;
      (let (y0_835:MyOp.t) = params_825.Wt_params.omega0 in
       (if self.i_848 then self.m_844 <- y0_835) ;
       (let (x_843:MyOp.t) =
            if self.i_848 then t_826 else MyOp.(-) t_826  self.m_841 in
        self.i_848 <- false ;
        (let (x_847:MyOp.t) = self.m_846 in
         let (xT_831:MyOp.t) =
             i_1158_step self.i_1158
               (x_843 , x_847 , params_825.Wt_params.xT0) in
         let (dxT_dot_828:MyOp.t) =
             MyOp.(/) (MyOp.(-) (MyOp.(-) fa_822 
                                          (MyOp.( * ) x_847 
                                                      params_825.Wt_params.cTe))
                                
                                (MyOp.( * ) (MyOp.(-) xT_831 
                                                      params_825.Wt_params.xT0)
                                             params_825.Wt_params.kTe)) 
                      params_825.Wt_params.mTe in
         self.m_846 <- MyOp.(+) (MyOp.( * ) dxT_dot_828  x_843)  x_847 ;
         (let (domega_827:MyOp.t) =
              MyOp.(/) (MyOp.(-) ma_823 
                                 (MyOp.(/) mg_d_824 
                                           params_825.Wt_params.gBRatio)) 
                       params_825.Wt_params.inertia in
          let (x_845:MyOp.t) = self.m_844 in
          self.m_844 <- MyOp.(+) (MyOp.( * ) domega_827  x_843)  x_845 ;
          self.m_841 <- t_826 ; (x_845 , x_847)))))):MyOp.t * MyOp.t) in
  Node { alloc = servo_elastic_subsystem_alloc; reset = servo_elastic_subsystem_reset
                                                ;
                                                step = servo_elastic_subsystem_step }
let cP_aeromapsPoly ((lambda_849:MyOp.t) , (theta_850:MyOp.t)) =
  MyOp.(+) (MyOp.(+) (MyOp.(+) (MyOp.(+) (MyOp.(+) (MyOp.(+) (MyOp.(+) 
                                                                (MyOp.(+) 
                                                                   (MyOp.(+) 
                                                                    (
                                                                    MyOp.scale 
                                                                    (
                                                                    MyOp.pow 
                                                                    lambda_849
                                                                     
                                                                    3.) 
                                                                    (-0.000464550681271))
                                                                    
                                                                    (
                                                                    MyOp.scale 
                                                                    (
                                                                    MyOp.( * ) 
                                                                    (
                                                                    MyOp.pow 
                                                                    lambda_849
                                                                     
                                                                    2.) 
                                                                    theta_850)
                                                                    
                                                                    (-0.074780487295)))
                                                                   
                                                                   (MyOp.scale 
                                                                    (
                                                                    MyOp.pow 
                                                                    lambda_849
                                                                     
                                                                    2.) 
                                                                    (-0.00245817585907)))
                                                                
                                                                (MyOp.scale 
                                                                   (MyOp.( * ) 
                                                                    lambda_849
                                                                    
                                                                    (
                                                                    MyOp.pow 
                                                                    theta_850
                                                                     
                                                                    2.)) 
                                                                   (-0.372740535667)))
                                                             
                                                             (MyOp.scale 
                                                                (MyOp.( * ) 
                                                                   lambda_849
                                                                    theta_850)
                                                                
                                                                0.0711147525909))
                                                   
                                                   (MyOp.scale lambda_849 
                                                               0.175932463832))
                                         
                                         (MyOp.scale (MyOp.pow theta_850  3.)
                                                      3.89808785329)) 
                               (MyOp.scale (MyOp.pow theta_850  2.) 
                                           (-3.51436345741))) 
                     (MyOp.scale theta_850  1.59939029665)) 
           (MyOp.make (-0.404129012121))

let cT_aeromapsPoly ((lambda_851:MyOp.t) , (theta_852:MyOp.t)) =
  MyOp.(+) (MyOp.(+) (MyOp.(+) (MyOp.(+) (MyOp.(+) (MyOp.(+) (MyOp.(+) 
                                                                (MyOp.(+) 
                                                                   (MyOp.(+) 
                                                                    (
                                                                    MyOp.scale 
                                                                    (
                                                                    MyOp.pow 
                                                                    lambda_851
                                                                     
                                                                    3.) 
                                                                    0.00168223358976)
                                                                    
                                                                    (
                                                                    MyOp.scale 
                                                                    (
                                                                    MyOp.( * ) 
                                                                    (
                                                                    MyOp.pow 
                                                                    lambda_851
                                                                     
                                                                    2.) 
                                                                    theta_852)
                                                                    
                                                                    (-0.00515118049598)))
                                                                   
                                                                   (MyOp.scale 
                                                                    (
                                                                    MyOp.pow 
                                                                    lambda_851
                                                                     
                                                                    2.) 
                                                                    (-0.0472197248104)))
                                                                
                                                                (MyOp.scale 
                                                                   (MyOp.( * ) 
                                                                    lambda_851
                                                                    
                                                                    (
                                                                    MyOp.pow 
                                                                    theta_852
                                                                     
                                                                    2.)) 
                                                                   1.16475825685))
                                                             
                                                             (MyOp.scale 
                                                                (MyOp.( * ) 
                                                                   lambda_851
                                                                    theta_852)
                                                                
                                                                (-1.52576164856)))
                                                   
                                                   (MyOp.scale lambda_851 
                                                               0.55320691852))
                                         
                                         (MyOp.scale (MyOp.pow theta_852  3.)
                                                      6.91427835251)) 
                               (MyOp.scale (MyOp.pow theta_852  2.) 
                                           (-10.9675429628))) 
                     (MyOp.scale theta_852  6.00063627825)) 
           (MyOp.make (-0.980172788619))

type _aeromapsPoly = unit

let aeromapsPoly  = 
   let aeromapsPoly_alloc _ = () in
  let aeromapsPoly_reset self  =
    ((()):unit) in 
  let aeromapsPoly_step self ((lambda_853:MyOp.t) , (theta_854:MyOp.t)) =
    ((let (cT_856:MyOp.t) = cT_aeromapsPoly (lambda_853 , theta_854) in
      let (cP_855:MyOp.t) = cP_aeromapsPoly (lambda_853 , theta_854) in
      (cP_855 , cT_856)):MyOp.t * MyOp.t) in
  Node { alloc = aeromapsPoly_alloc; reset = aeromapsPoly_reset ;
                                     step = aeromapsPoly_step }
type ('a) _aero_elastic_subsystem =
  { mutable i_1159 : 'a }

let aero_elastic_subsystem  = 
  let Node { alloc = i_1159_alloc; step = i_1159_step ; reset = i_1159_reset } = aeromapsPoly 
   in
  let aero_elastic_subsystem_alloc _ =
    ();{ i_1159 = i_1159_alloc () (* discrete *)  } in
  let aero_elastic_subsystem_reset self  =
    (i_1159_reset self.i_1159 :unit) in 
  let aero_elastic_subsystem_step self ((v0_860:MyOp.t) ,
                                        (theta_859:MyOp.t) ,
                                        (omega_857:MyOp.t) ,
                                        (xT_dot_861:MyOp.t) ,
                                        (params_858:Wt_params.params)) =
    ((let (v_rel_869:MyOp.t) = MyOp.(-) v0_860  xT_dot_861 in
      let (lambda_866:MyOp.t) =
          MyOp.(/) (MyOp.( * ) omega_857  params_858.Wt_params.rotor) 
                   v_rel_869 in
      let ((cP_862:MyOp.t) , (cT_863:MyOp.t)) =
          i_1159_step self.i_1159 (lambda_866 , theta_859) in
      let (fa'_865:MyOp.t) =
          MyOp.( * ) (MyOp.( * ) (MyOp.( * ) cT_863 
                                             (MyOp.scale params_858.Wt_params.rho
                                                          0.5)) 
                                 Wt_common.pi_t) 
                     (MyOp.pow params_858.Wt_params.rotor  2.) in
      let (fa_864:MyOp.t) =
          MyOp.( * ) (MyOp.( * ) fa'_865  v_rel_869)  v_rel_869 in
      let (ma'_868:MyOp.t) =
          MyOp.(/) (MyOp.( * ) (MyOp.( * ) (MyOp.( * ) cP_862 
                                                       (MyOp.scale params_858.Wt_params.rho
                                                                    0.5)) 
                                           Wt_common.pi_t) 
                               (MyOp.pow params_858.Wt_params.rotor  3.)) 
                   lambda_866 in
      let (ma_867:MyOp.t) =
          MyOp.( * ) (MyOp.( * ) ma'_868  v_rel_869)  v_rel_869 in
      (ma_867 , fa_864)):MyOp.t * MyOp.t) in
  Node { alloc = aero_elastic_subsystem_alloc; reset = aero_elastic_subsystem_reset
                                               ;
                                               step = aero_elastic_subsystem_step }
type ('g , 'f , 'e , 'd , 'c , 'b , 'a) _wind_turbine =
  { mutable i_1162 : 'g ;
    mutable i_1161 : 'f ;
    mutable i_1160 : 'e ;
    mutable i_906 : 'd ;
    mutable m_904 : 'c ; mutable m_902 : 'b ; mutable m_899 : 'a }

let wind_turbine  = 
  let Node { alloc = i_1162_alloc; step = i_1162_step ; reset = i_1162_reset } = pitch_actuator_subsystem 
   in 
  let Node { alloc = i_1161_alloc; step = i_1161_step ; reset = i_1161_reset } = aero_elastic_subsystem 
   in 
  let Node { alloc = i_1160_alloc; step = i_1160_step ; reset = i_1160_reset } = Wt_common.integrate 
   in
  let wind_turbine_alloc _ =
    ();
    { i_906 = (false:bool) ;
      m_904 = (MyOp.create ():MyOp.t) ;
      m_902 = (MyOp.create ():MyOp.t) ; m_899 = (MyOp.create ():MyOp.t);
      i_1162 = i_1162_alloc () (* discrete *)  ;
      i_1161 = i_1161_alloc () (* discrete *)  ;
      i_1160 = i_1160_alloc () (* discrete *)  } in
  let wind_turbine_reset self  =
    ((self.i_906 <- true ;
      i_1162_reset self.i_1162  ;
      i_1161_reset self.i_1161  ; i_1160_reset self.i_1160 ):unit) in 
  let wind_turbine_step self ((t_872:MyOp.t) ,
                              (v0_874:MyOp.t) ,
                              (theta_d_873:MyOp.t) ,
                              (mg_d_870:MyOp.t) ,
                              (params_871:Wt_params.params)) =
    ((let (y0_897:MyOp.t) = params_871.Wt_params.xt_dot0 in
      (if self.i_906 then self.m_904 <- y0_897) ;
      (let (y0_893:MyOp.t) = params_871.Wt_params.omega0 in
       (if self.i_906 then self.m_902 <- y0_893) ;
       (let (x_901:MyOp.t) =
            if self.i_906 then t_872 else MyOp.(-) t_872  self.m_899 in
        self.i_906 <- false ;
        (let (x_903:MyOp.t) = self.m_902 in
         let (x_905:MyOp.t) = self.m_904 in
         let (blade_pitch_angle_875:MyOp.t) =
             i_1162_step self.i_1162
               (t_872 ,
                params_871.Wt_params.pitch.Wt_params.actuatorType ,
                theta_d_873 , params_871) in
         let ((ma_877:MyOp.t) , (fa_876:MyOp.t)) =
             i_1161_step self.i_1161
               (v0_874 , blade_pitch_angle_875 , x_903 , x_905 , params_871) in
         let (xT_889:MyOp.t) =
             i_1160_step self.i_1160
               (x_901 , x_905 , params_871.Wt_params.xT0) in
         let (dxT_dot_886:MyOp.t) =
             MyOp.(/) (MyOp.(-) (MyOp.(-) fa_876 
                                          (MyOp.( * ) x_905 
                                                      params_871.Wt_params.cTe))
                                
                                (MyOp.( * ) (MyOp.(-) xT_889 
                                                      params_871.Wt_params.xT0)
                                             params_871.Wt_params.kTe)) 
                      params_871.Wt_params.mTe in
         self.m_904 <- MyOp.(+) (MyOp.( * ) dxT_dot_886  x_901)  x_905 ;
         (let (domega_885:MyOp.t) =
              MyOp.(/) (MyOp.(-) ma_877 
                                 (MyOp.(/) mg_d_870 
                                           params_871.Wt_params.gBRatio)) 
                       params_871.Wt_params.inertia in
          self.m_902 <- MyOp.(+) (MyOp.( * ) domega_885  x_901)  x_903 ;
          self.m_899 <- t_872 ; (blade_pitch_angle_875 , x_903)))))):
    MyOp.t * MyOp.t) in
  Node { alloc = wind_turbine_alloc; reset = wind_turbine_reset ;
                                     step = wind_turbine_step }
type ('q ,
      'p ,
      'o ,
      'n , 'm , 'l , 'k , 'j , 'i , 'h , 'g , 'f , 'e , 'd , 'c , 'b , 'a) _wt =
  { mutable i_1167 : 'q ;
    mutable i_1166 : 'p ;
    mutable i_1165 : 'o ;
    mutable i_1164 : 'n ;
    mutable i_1163 : 'm ;
    mutable i_1017 : 'l ;
    mutable m_1015 : 'k ;
    mutable m_1012 : 'j ;
    mutable m_1010 : 'i ;
    mutable m_1007 : 'h ;
    mutable m_1005 : 'g ;
    mutable m_1002 : 'f ;
    mutable m_1000 : 'e ;
    mutable m_998 : 'd ;
    mutable m_996 : 'c ; mutable m_993 : 'b ; mutable v0_0_920 : 'a }

let wt  = 
  let Node { alloc = i_1167_alloc; step = i_1167_step ; reset = i_1167_reset } = rate_limiter 
   in 
  let Node { alloc = i_1166_alloc; step = i_1166_step ; reset = i_1166_reset } = pitch_actuator_subsystem 
   in 
  let Node { alloc = i_1165_alloc; step = i_1165_step ; reset = i_1165_reset } = aero_elastic_subsystem 
   in 
  let Node { alloc = i_1164_alloc; step = i_1164_step ; reset = i_1164_reset } = Wt_common.integrate 
   in 
  let Node { alloc = i_1163_alloc; step = i_1163_step ; reset = i_1163_reset } = rate_limiter 
   in
  let wt_alloc _ =
    ();
    { i_1017 = (false:bool) ;
      m_1015 = (MyOp.create ():MyOp.t) ;
      m_1012 = (MyOp.create ():MyOp.t) ;
      m_1010 = (MyOp.create ():MyOp.t) ;
      m_1007 = (MyOp.create ():MyOp.t) ;
      m_1005 = (MyOp.create ():MyOp.t) ;
      m_1002 = (MyOp.create ():MyOp.t) ;
      m_1000 = (MyOp.create ():MyOp.t) ;
      m_998 = (MyOp.create ():MyOp.t) ;
      m_996 = (MyOp.create ():MyOp.t) ;
      m_993 = (MyOp.create ():MyOp.t) ; v0_0_920 = (MyOp.create ():MyOp.t);
      i_1167 = i_1167_alloc () (* discrete *)  ;
      i_1166 = i_1166_alloc () (* discrete *)  ;
      i_1165 = i_1165_alloc () (* discrete *)  ;
      i_1164 = i_1164_alloc () (* discrete *)  ;
      i_1163 = i_1163_alloc () (* discrete *)  } in
  let wt_reset self  =
    ((self.i_1017 <- true ;
      i_1167_reset self.i_1167  ;
      i_1166_reset self.i_1166  ;
      i_1165_reset self.i_1165  ;
      i_1164_reset self.i_1164  ; i_1163_reset self.i_1163 ):unit) in 
  let wt_step self ((t_907:MyOp.t) , (v0_908:MyOp.t)) =
    (((if self.i_1017 then self.v0_0_920 <- v0_908) ;
      (let (params_913:Wt_params.params) =
           Wt_params.get_default self.v0_0_920 in
       let (y0_991:MyOp.t) = params_913.Wt_params.omega_g0 in
       (if self.i_1017 then self.m_1015 <- y0_991) ;
       (let (x_1014:MyOp.t) =
            if self.i_1017 then t_907 else MyOp.(-) t_907  self.m_1012 in
        let (y0_981:MyOp.t) = params_913.Wt_params.pitch.Wt_params.theta0 in
        (if self.i_1017 then self.m_1010 <- y0_981) ;
        (let (x_1009:MyOp.t) =
             if self.i_1017 then t_907 else MyOp.(-) t_907  self.m_1007 in
         let (y0_971:MyOp.t) =
             MyOp.( * ) params_913.Wt_params.pitch.Wt_params.theta0 
                        (MyOp.translate (MyOp.(/) params_913.Wt_params.pitch.Wt_params.theta0
                                                  
                                                  params_913.Wt_params.pitch.Wt_params.cpc.Wt_params.gS_factor)
                                         1.) in
         (if self.i_1017 then self.m_1005 <- y0_971) ;
         (let (x_1004:MyOp.t) =
              if self.i_1017 then t_907 else MyOp.(-) t_907  self.m_1002 in
          (if self.i_1017 then
           self.m_1000 <- params_913.Wt_params.pitch.Wt_params.theta0) ;
          (let (y0_948:MyOp.t) = params_913.Wt_params.xt_dot0 in
           (if self.i_1017 then self.m_998 <- y0_948) ;
           (let (y0_944:MyOp.t) = params_913.Wt_params.omega0 in
            (if self.i_1017 then self.m_996 <- y0_944) ;
            (let (x_995:MyOp.t) =
                 if self.i_1017 then t_907 else MyOp.(-) t_907  self.m_993 in
             self.i_1017 <- false ;
             (let (rob_optim_914:MyOp.t) = MyOp.make 0. in
              let (x_997:MyOp.t) = self.m_996 in
              let (u_985:MyOp.t) =
                  MyOp.(/) x_997  params_913.Wt_params.gBRatio in
              let (x_1016:MyOp.t) = self.m_1015 in
              let (dy_986:MyOp.t) =
                  MyOp.(/) (MyOp.(-) u_985  x_1016) 
                           params_913.Wt_params.vscontrol.Wt_params.vs_filterConstant in
              self.m_1015 <- MyOp.(+) (MyOp.( * ) dy_986  x_1014)  x_1016 ;
              self.m_1012 <- t_907 ;
              (let (x_1001:MyOp.t) = self.m_1000 in
               let (gs_956:MyOp.t) =
                   MyOp.inv (MyOp.translate (MyOp.(/) x_1001 
                                                      params_913.Wt_params.pitch.Wt_params.cpc.Wt_params.gS_factor)
                                             1.) in
               let (omega_g_rated_951:MyOp.t) =
                   params_913.Wt_params.omega_g_rated in
               let (e_955:MyOp.t) = MyOp.(-) x_1016  omega_g_rated_951 in
               let (e1_962:MyOp.t) =
                   MyOp.( * ) e_955 
                              params_913.Wt_params.pitch.Wt_params.cpc.Wt_params.kP in
               let (x_1006:MyOp.t) = self.m_1005 in
               let (e4_965:MyOp.t) = MyOp.(+) e1_962  x_1006 in
               let (theta_d'_967:MyOp.t) = MyOp.( * ) gs_956  e4_965 in
               let (theta_d_966:MyOp.t) =
                   saturate (params_913.Wt_params.pitch.Wt_params.min ,
                             params_913.Wt_params.pitch.Wt_params.max ,
                             theta_d'_967) in
               let (theta_d_916:MyOp.t) =
                   i_1167_step self.i_1167
                     (t_907 ,
                      params_913.Wt_params.pitch.Wt_params.rateLimit ,
                      (MyOp.(~-) params_913.Wt_params.pitch.Wt_params.rateLimit)
                      ,
                      params_913.Wt_params.pitch.Wt_params.thetaDot0 ,
                      theta_d_966) in
               let (blade_pitch_angle_926:MyOp.t) =
                   i_1166_step self.i_1166
                     (t_907 ,
                      params_913.Wt_params.pitch.Wt_params.actuatorType ,
                      theta_d_916 , params_913) in
               let (x_1011:MyOp.t) = self.m_1010 in
               let (dy_976:MyOp.t) =
                   MyOp.(/) (MyOp.(-) blade_pitch_angle_926  x_1011) 
                            params_913.Wt_params.pitch.Wt_params.pitch_filterConstant in
               self.m_1010 <- MyOp.(+) (MyOp.( * ) dy_976  x_1009)  x_1011 ;
               self.m_1007 <- t_907 ;
               (let (e2_963:MyOp.t) =
                    MyOp.(-) e1_962 
                             (MyOp.( * ) (MyOp.(-) theta_d'_967  theta_d_966)
                                         
                                         params_913.Wt_params.pitch.Wt_params.cpc.Wt_params.antiWindUp) in
                let (x_970:MyOp.t) =
                    MyOp.(/) e2_963 
                             params_913.Wt_params.pitch.Wt_params.cpc.Wt_params.tI in
                self.m_1005 <- MyOp.(+) (MyOp.( * ) x_970  x_1004)  x_1006 ;
                self.m_1002 <- t_907 ;
                self.m_1000 <- blade_pitch_angle_926 ;
                (let (x_999:MyOp.t) = self.m_998 in
                 let ((ma_928:MyOp.t) , (fa_927:MyOp.t)) =
                     i_1165_step self.i_1165
                       (v0_908 ,
                        blade_pitch_angle_926 , x_997 , x_999 , params_913) in
                 let (xT_940:MyOp.t) =
                     i_1164_step self.i_1164
                       (x_995 , x_999 , params_913.Wt_params.xT0) in
                 let (dxT_dot_937:MyOp.t) =
                     MyOp.(/) (MyOp.(-) (MyOp.(-) fa_927 
                                                  (MyOp.( * ) x_999 
                                                              params_913.Wt_params.cTe))
                                        
                                        (MyOp.( * ) (MyOp.(-) xT_940 
                                                              params_913.Wt_params.xT0)
                                                     params_913.Wt_params.kTe))
                               params_913.Wt_params.mTe in
                 self.m_998 <- MyOp.(+) (MyOp.( * ) dxT_dot_937  x_995) 
                                        x_999 ;
                 (let (mg_d_910:MyOp.t) =
                      torque_controller (x_1016 , theta_d_916 , params_913) in
                  let (torque_aux_919:MyOp.t) =
                      i_1163_step self.i_1163
                        (t_907 ,
                         params_913.Wt_params.vscontrol.Wt_params.maxRat ,
                         (MyOp.(~-) params_913.Wt_params.vscontrol.Wt_params.maxRat)
                         , (MyOp.make 0.) , mg_d_910) in
                  let (torque_918:MyOp.t) =
                      saturate (MyOp.neg_infinity ,
                                params_913.Wt_params.vscontrol.Wt_params.maxTq
                                , torque_aux_919) in
                  let (domega_936:MyOp.t) =
                      MyOp.(/) (MyOp.(-) ma_928 
                                         (MyOp.(/) torque_918 
                                                   params_913.Wt_params.gBRatio))
                                params_913.Wt_params.inertia in
                  self.m_996 <- MyOp.(+) (MyOp.( * ) domega_936  x_995) 
                                         x_997 ;
                  self.m_993 <- t_907 ;
                  ((Wt_common.rad2deg x_1011) ,
                   (Wt_common.radPs2rpm x_997) ,
                   (Wt_common.radPs2rpm x_1016) ,
                   (Wt_common.rad2deg theta_d_916) ,
                   (Wt_common.rad2deg blade_pitch_angle_926) ,
                   mg_d_910 , rob_optim_914)))))))))))))):MyOp.t *
                                                          MyOp.t *
                                                          MyOp.t *
                                                          MyOp.t *
                                                          MyOp.t *
                                                          MyOp.t * MyOp.t) in
  Node { alloc = wt_alloc; reset = wt_reset ; step = wt_step }
open Scope
let print_results ((t_1022:MyOp.t) ,
                   (theta_1023:MyOp.t) ,
                   (omega_1020:MyOp.t) ,
                   (omega_g_1021:MyOp.t) ,
                   (theta_d_1024:MyOp.t) ,
                   (blade_pitch_angle_1018:MyOp.t) , (mg_d_1019:'a8362)) =
  let _ = print_endline ((^) "t = "  (string_of_float (MyOp.get t_1022))) in
  let _ =
      print_endline ((^) "theta = "  (string_of_float (MyOp.get theta_1023))) in
  let _ =
      print_endline ((^) "omega = "  (string_of_float (MyOp.get omega_1020))) in
  let _ =
      print_endline ((^) "omega_g = " 
                         (string_of_float (MyOp.get omega_g_1021))) in
  let _ =
      print_endline ((^) "theta_d = " 
                         (string_of_float (MyOp.get theta_d_1024))) in
  let _ =
      print_endline ((^) "blade_pitch_angle = " 
                         (string_of_float (MyOp.get blade_pitch_angle_1018))) in
  let _ =
      print_endline ((^) "mg_d = " 
                         (string_of_float (MyOp.get blade_pitch_angle_1018))) in
  print_newline ()

let tstep = 0.01

type ('x ,
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
  { mutable i_1178 : 'x ;
    mutable i_1177 : 'w ;
    mutable i_1176 : 'v ;
    mutable i_1175 : 'u ;
    mutable i_1174 : 't ;
    mutable i_1173 : 's ;
    mutable i_1172 : 'r ;
    mutable i_1171 : 'q ;
    mutable i_1170 : 'p ;
    mutable i_1169 : 'o ;
    mutable i_1168 : 'n ;
    mutable i_1154 : 'm ;
    mutable m_1152 : 'l ;
    mutable m_1149 : 'k ;
    mutable m_1147 : 'j ;
    mutable m_1144 : 'i ;
    mutable m_1142 : 'h ;
    mutable m_1139 : 'g ;
    mutable m_1137 : 'f ;
    mutable m_1135 : 'e ;
    mutable m_1133 : 'd ;
    mutable m_1130 : 'c ; mutable m_1128 : 'b ; mutable v0_0_1050 : 'a }

let main  = 
  let Node { alloc = i_1178_alloc; step = i_1178_step ; reset = i_1178_reset } = rate_limiter 
   in 
  let Node { alloc = i_1177_alloc; step = i_1177_step ; reset = i_1177_reset } = pitch_actuator_subsystem 
   in 
  let Node { alloc = i_1176_alloc; step = i_1176_step ; reset = i_1176_reset } = aero_elastic_subsystem 
   in 
  let Node { alloc = i_1175_alloc; step = i_1175_step ; reset = i_1175_reset } = Wt_common.integrate 
   in 
  let Node { alloc = i_1174_alloc; step = i_1174_step ; reset = i_1174_reset } = rate_limiter 
   in 
  let Node { alloc = i_1173_alloc; step = i_1173_step ; reset = i_1173_reset } = Scope.scope 
   in 
  let Node { alloc = i_1172_alloc; step = i_1172_step ; reset = i_1172_reset } = Scope.scope 
   in 
  let Node { alloc = i_1171_alloc; step = i_1171_step ; reset = i_1171_reset } = Scope.scope 
   in 
  let Node { alloc = i_1170_alloc; step = i_1170_step ; reset = i_1170_reset } = Scope.scope 
   in 
  let Node { alloc = i_1169_alloc; step = i_1169_step ; reset = i_1169_reset } = Scope.scope3 
   in 
  let Node { alloc = i_1168_alloc; step = i_1168_step ; reset = i_1168_reset } = Scope.windown 
   in
  let main_alloc _ =
    ();
    { i_1154 = (false:bool) ;
      m_1152 = (MyOp.create ():MyOp.t) ;
      m_1149 = (MyOp.create ():MyOp.t) ;
      m_1147 = (MyOp.create ():MyOp.t) ;
      m_1144 = (MyOp.create ():MyOp.t) ;
      m_1142 = (MyOp.create ():MyOp.t) ;
      m_1139 = (MyOp.create ():MyOp.t) ;
      m_1137 = (MyOp.create ():MyOp.t) ;
      m_1135 = (MyOp.create ():MyOp.t) ;
      m_1133 = (MyOp.create ():MyOp.t) ;
      m_1130 = (MyOp.create ():MyOp.t) ;
      m_1128 = (MyOp.create ():MyOp.t) ; v0_0_1050 = (MyOp.create ():MyOp.t);
      i_1178 = i_1178_alloc () (* discrete *)  ;
      i_1177 = i_1177_alloc () (* discrete *)  ;
      i_1176 = i_1176_alloc () (* discrete *)  ;
      i_1175 = i_1175_alloc () (* discrete *)  ;
      i_1174 = i_1174_alloc () (* discrete *)  ;
      i_1173 = i_1173_alloc () (* discrete *)  ;
      i_1172 = i_1172_alloc () (* discrete *)  ;
      i_1171 = i_1171_alloc () (* discrete *)  ;
      i_1170 = i_1170_alloc () (* discrete *)  ;
      i_1169 = i_1169_alloc () (* discrete *)  ;
      i_1168 = i_1168_alloc () (* discrete *)  } in
  let main_reset self  =
    ((self.i_1154 <- true ;
      i_1178_reset self.i_1178  ;
      i_1177_reset self.i_1177  ;
      i_1176_reset self.i_1176  ;
      i_1175_reset self.i_1175  ;
      i_1174_reset self.i_1174  ;
      i_1173_reset self.i_1173  ;
      i_1172_reset self.i_1172  ;
      i_1171_reset self.i_1171  ;
      i_1170_reset self.i_1170  ;
      i_1169_reset self.i_1169  ; i_1168_reset self.i_1168 ):unit) in 
  let main_step self () =
    ((let (y0_1028:MyOp.t) = MyOp.make 0. in
      (if self.i_1154 then self.m_1128 <- y0_1028) ;
      (let (x_1129:MyOp.t) = self.m_1128 in
       let (v0_1030:MyOp.t) =
           if (>) x_1129  (MyOp.make 1.)
           then MyOp.make 14.
           else MyOp.make 10. in
       (if self.i_1154 then self.v0_0_1050 <- v0_1030) ;
       (let (params_1043:Wt_params.params) =
            Wt_params.get_default self.v0_0_1050 in
        let (y0_1121:MyOp.t) = params_1043.Wt_params.omega_g0 in
        (if self.i_1154 then self.m_1152 <- y0_1121) ;
        (let (x_1151:MyOp.t) =
             if self.i_1154 then x_1129 else MyOp.(-) x_1129  self.m_1149 in
         let (y0_1111:MyOp.t) = params_1043.Wt_params.pitch.Wt_params.theta0 in
         (if self.i_1154 then self.m_1147 <- y0_1111) ;
         (let (x_1146:MyOp.t) =
              if self.i_1154 then x_1129 else MyOp.(-) x_1129  self.m_1144 in
          let (y0_1101:MyOp.t) =
              MyOp.( * ) params_1043.Wt_params.pitch.Wt_params.theta0 
                         (MyOp.translate (MyOp.(/) params_1043.Wt_params.pitch.Wt_params.theta0
                                                   
                                                   params_1043.Wt_params.pitch.Wt_params.cpc.Wt_params.gS_factor)
                                          1.) in
          (if self.i_1154 then self.m_1142 <- y0_1101) ;
          (let (x_1141:MyOp.t) =
               if self.i_1154 then x_1129 else MyOp.(-) x_1129  self.m_1139 in
           (if self.i_1154 then
            self.m_1137 <- params_1043.Wt_params.pitch.Wt_params.theta0) ;
           (let (y0_1078:MyOp.t) = params_1043.Wt_params.xt_dot0 in
            (if self.i_1154 then self.m_1135 <- y0_1078) ;
            (let (y0_1074:MyOp.t) = params_1043.Wt_params.omega0 in
             (if self.i_1154 then self.m_1133 <- y0_1074) ;
             (let (x_1132:MyOp.t) =
                  if self.i_1154
                  then x_1129
                  else MyOp.(-) x_1129  self.m_1130 in
              self.i_1154 <- false ;
              (let (tstep_1026:MyOp.t) = MyOp.make tstep in
               let (x_1027:MyOp.t) = MyOp.make 1. in
               self.m_1128 <- MyOp.(+) (MyOp.( * ) x_1027  tstep_1026) 
                                       x_1129 ;
               (let (x_1134:MyOp.t) = self.m_1133 in
                let (u_1115:MyOp.t) =
                    MyOp.(/) x_1134  params_1043.Wt_params.gBRatio in
                let (x_1153:MyOp.t) = self.m_1152 in
                let (dy_1116:MyOp.t) =
                    MyOp.(/) (MyOp.(-) u_1115  x_1153) 
                             params_1043.Wt_params.vscontrol.Wt_params.vs_filterConstant in
                self.m_1152 <- MyOp.(+) (MyOp.( * ) dy_1116  x_1151)  x_1153
                ;
                self.m_1149 <- x_1129 ;
                (let (x_1138:MyOp.t) = self.m_1137 in
                 let (gs_1086:MyOp.t) =
                     MyOp.inv (MyOp.translate (MyOp.(/) x_1138 
                                                        params_1043.Wt_params.pitch.Wt_params.cpc.Wt_params.gS_factor)
                                               1.) in
                 let (omega_g_rated_1081:MyOp.t) =
                     params_1043.Wt_params.omega_g_rated in
                 let (e_1085:MyOp.t) = MyOp.(-) x_1153  omega_g_rated_1081 in
                 let (e1_1092:MyOp.t) =
                     MyOp.( * ) e_1085 
                                params_1043.Wt_params.pitch.Wt_params.cpc.Wt_params.kP in
                 let (x_1143:MyOp.t) = self.m_1142 in
                 let (e4_1095:MyOp.t) = MyOp.(+) e1_1092  x_1143 in
                 let (theta_d'_1097:MyOp.t) = MyOp.( * ) gs_1086  e4_1095 in
                 let (theta_d_1096:MyOp.t) =
                     saturate (params_1043.Wt_params.pitch.Wt_params.min ,
                               params_1043.Wt_params.pitch.Wt_params.max ,
                               theta_d'_1097) in
                 let (theta_d_1046:MyOp.t) =
                     i_1178_step self.i_1178
                       (x_1129 ,
                        params_1043.Wt_params.pitch.Wt_params.rateLimit ,
                        (MyOp.(~-) params_1043.Wt_params.pitch.Wt_params.rateLimit)
                        ,
                        params_1043.Wt_params.pitch.Wt_params.thetaDot0 ,
                        theta_d_1096) in
                 let (blade_pitch_angle_1056:MyOp.t) =
                     i_1177_step self.i_1177
                       (x_1129 ,
                        params_1043.Wt_params.pitch.Wt_params.actuatorType ,
                        theta_d_1046 , params_1043) in
                 let (x_1148:MyOp.t) = self.m_1147 in
                 let (dy_1106:MyOp.t) =
                     MyOp.(/) (MyOp.(-) blade_pitch_angle_1056  x_1148) 
                              params_1043.Wt_params.pitch.Wt_params.pitch_filterConstant in
                 self.m_1147 <- MyOp.(+) (MyOp.( * ) dy_1106  x_1146)  x_1148
                 ;
                 self.m_1144 <- x_1129 ;
                 (let (e2_1093:MyOp.t) =
                      MyOp.(-) e1_1092 
                               (MyOp.( * ) (MyOp.(-) theta_d'_1097 
                                                     theta_d_1096) 
                                           params_1043.Wt_params.pitch.Wt_params.cpc.Wt_params.antiWindUp) in
                  let (x_1100:MyOp.t) =
                      MyOp.(/) e2_1093 
                               params_1043.Wt_params.pitch.Wt_params.cpc.Wt_params.tI in
                  self.m_1142 <- MyOp.(+) (MyOp.( * ) x_1100  x_1141)  x_1143
                  ;
                  self.m_1139 <- x_1129 ;
                  self.m_1137 <- blade_pitch_angle_1056 ;
                  (let (x_1136:MyOp.t) = self.m_1135 in
                   let ((ma_1058:MyOp.t) , (fa_1057:MyOp.t)) =
                       i_1176_step self.i_1176
                         (v0_1030 ,
                          blade_pitch_angle_1056 ,
                          x_1134 , x_1136 , params_1043) in
                   let (xT_1070:MyOp.t) =
                       i_1175_step self.i_1175
                         (x_1132 , x_1136 , params_1043.Wt_params.xT0) in
                   let (dxT_dot_1067:MyOp.t) =
                       MyOp.(/) (MyOp.(-) (MyOp.(-) fa_1057 
                                                    (MyOp.( * ) x_1136 
                                                                params_1043.Wt_params.cTe))
                                          
                                          (MyOp.( * ) (MyOp.(-) xT_1070 
                                                                params_1043.Wt_params.xT0)
                                                      
                                                      params_1043.Wt_params.kTe))
                                 params_1043.Wt_params.mTe in
                   self.m_1135 <- MyOp.(+) (MyOp.( * ) dxT_dot_1067  x_1132) 
                                           x_1136 ;
                   (let (mg_d_1040:MyOp.t) =
                        torque_controller (x_1153 ,
                                           theta_d_1046 , params_1043) in
                    let (torque_aux_1049:MyOp.t) =
                        i_1174_step self.i_1174
                          (x_1129 ,
                           params_1043.Wt_params.vscontrol.Wt_params.maxRat ,
                           (MyOp.(~-) params_1043.Wt_params.vscontrol.Wt_params.maxRat)
                           , (MyOp.make 0.) , mg_d_1040) in
                    let (torque_1048:MyOp.t) =
                        saturate (MyOp.neg_infinity ,
                                  params_1043.Wt_params.vscontrol.Wt_params.maxTq
                                  , torque_aux_1049) in
                    let (domega_1066:MyOp.t) =
                        MyOp.(/) (MyOp.(-) ma_1058 
                                           (MyOp.(/) torque_1048 
                                                     params_1043.Wt_params.gBRatio))
                                  params_1043.Wt_params.inertia in
                    self.m_1133 <- MyOp.(+) (MyOp.( * ) domega_1066  x_1132) 
                                            x_1134 ;
                    self.m_1130 <- x_1129 ;
                    (let (theta_1035:MyOp.t) = Wt_common.rad2deg x_1148 in
                     let (theta_d_1036:MyOp.t) =
                         Wt_common.rad2deg theta_d_1046 in
                     let (blade_pitch_angle_1031:MyOp.t) =
                         Wt_common.rad2deg blade_pitch_angle_1056 in
                     let (omega_g_1034:MyOp.t) = Wt_common.radPs2rpm x_1153 in
                     let (omega_1033:MyOp.t) = Wt_common.radPs2rpm x_1134 in
                     let (s1_1123:Gtkplot.scope) =
                         i_1173_step self.i_1173
                           (8. ,
                            16. , ("v0" , Scope.linear , (MyOp.get v0_1030))) in
                     let (s2_1124:Gtkplot.scope) =
                         i_1172_step self.i_1172
                           (10. ,
                            13. ,
                            ("omega" , Scope.linear , (MyOp.get omega_1033))) in
                     let (s3_1125:Gtkplot.scope) =
                         i_1171_step self.i_1171
                           (1000. ,
                            1300. ,
                            ("omega_g" ,
                             Scope.linear , (MyOp.get omega_g_1034))) in
                     let (s4_1126:Gtkplot.scope) =
                         i_1170_step self.i_1170
                           (25000. ,
                            50000. ,
                            ("mg_d" , Scope.linear , (MyOp.get mg_d_1040))) in
                     let (s5_1127:Gtkplot.scope) =
                         i_1169_step self.i_1169
                           (0. ,
                            13. ,
                            ("theta" , Scope.linear , (MyOp.get theta_1035))
                            ,
                            ("theta_d" ,
                             Scope.linear , (MyOp.get theta_d_1036)) ,
                            ("blade_pitch_angle" ,
                             Scope.linear , (MyOp.get blade_pitch_angle_1031))) in
                     i_1168_step self.i_1168
                       ("Wind Turbine" ,
                        630. ,
                        (MyOp.get x_1129) ,
                        ((::) (s1_1123 ,
                               ((::) (s2_1124 ,
                                      ((::) (s3_1125 ,
                                             ((::) (s4_1126 ,
                                                    ((::) (s5_1127 , ([])))))))))))))))))))))))))))):
    unit) in
  Node { alloc = main_alloc; reset = main_reset ; step = main_step }
