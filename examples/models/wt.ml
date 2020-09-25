(* The Zélus compiler, version 2.1
  (vendredi 25 septembre 2020, 16:45:09 (UTC+0200)) *)
open Ztypes
open FadFloat
open Discrete_obs_fad
type ('c , 'b , 'a) _wt1 =
  { mutable i_1168 : 'c ; mutable i_628 : 'b ; mutable m_626 : 'a }

let wt1  = 
  let Node { alloc = i_1168_alloc; step = i_1168_step ; reset = i_1168_reset } = 
  Discrete_obs_fad.always_timed 630.  in
  let wt1_alloc _ =
    ();
    { i_628 = (false:bool) ; m_626 = (create ():FadFloat.t);
      i_1168 = i_1168_alloc () (* discrete *)  } in
  let wt1_reset self  =
    ((self.i_628 <- true ; i_1168_reset self.i_1168 ):unit) in 
  let wt1_step self ((tstep_623:FadFloat.t) , (outp_622:(FadFloat.t)Array.t)) =
    (((if self.i_628 then self.m_626 <- FadFloat.make 0.) ;
      self.i_628 <- false ;
      (let (x_627:FadFloat.t) = self.m_626 in
       self.m_626 <- FadFloat.(+) x_627  tstep_623 ;
       (let (blade_pitch_angle_625:FadFloat.t) = Array.get outp_622  4 in
        i_1168_step self.i_1168
          (tstep_623 ,
           (Discrete_obs_fad.implies ((Discrete_obs_fad.q_ge (x_627 ,
                                                              (FadFloat.make 
                                                                 30.))) ,
                                      (Discrete_obs_fad.q_le (blade_pitch_angle_625
                                                              ,
                                                              (FadFloat.make 
                                                                 14.2))))))))):
    FadFloat.t) in
  Node { alloc = wt1_alloc; reset = wt1_reset ; step = wt1_step }
type ('c , 'b , 'a) _wt2 =
  { mutable i_1169 : 'c ; mutable i_635 : 'b ; mutable m_633 : 'a }

let wt2  = 
  let Node { alloc = i_1169_alloc; step = i_1169_step ; reset = i_1169_reset } = 
  Discrete_obs_fad.always_timed 630.  in
  let wt2_alloc _ =
    ();
    { i_635 = (false:bool) ; m_633 = (create ():FadFloat.t);
      i_1169 = i_1169_alloc () (* discrete *)  } in
  let wt2_reset self  =
    ((self.i_635 <- true ; i_1169_reset self.i_1169 ):unit) in 
  let wt2_step self ((tstep_630:FadFloat.t) , (outp_629:(FadFloat.t)Array.t)) =
    (((if self.i_635 then self.m_633 <- FadFloat.make 0.) ;
      self.i_635 <- false ;
      (let (x_634:FadFloat.t) = self.m_633 in
       self.m_633 <- FadFloat.(+) x_634  tstep_630 ;
       (let (mg_d_632:FadFloat.t) = Array.get outp_629  5 in
        i_1169_step self.i_1169
          (tstep_630 ,
           (Discrete_obs_fad.implies ((Discrete_obs_fad.q_ge (x_634 ,
                                                              (FadFloat.make 
                                                                 30.))) ,
                                      (Discrete_obs_fad.q_and ((Discrete_obs_fad.q_ge 
                                                                  (mg_d_632 ,
                                                                   (FadFloat.make 
                                                                    21000.)))
                                                               ,
                                                               (Discrete_obs_fad.q_le 
                                                                  (mg_d_632 ,
                                                                   (FadFloat.make 
                                                                    47500.))))))))))):
    FadFloat.t) in
  Node { alloc = wt2_alloc; reset = wt2_reset ; step = wt2_step }
type ('c , 'b , 'a) _wt3 =
  { mutable i_1170 : 'c ; mutable i_642 : 'b ; mutable m_640 : 'a }

let wt3  = 
  let Node { alloc = i_1170_alloc; step = i_1170_step ; reset = i_1170_reset } = 
  Discrete_obs_fad.always_timed 630.  in
  let wt3_alloc _ =
    ();
    { i_642 = (false:bool) ; m_640 = (create ():FadFloat.t);
      i_1170 = i_1170_alloc () (* discrete *)  } in
  let wt3_reset self  =
    ((self.i_642 <- true ; i_1170_reset self.i_1170 ):unit) in 
  let wt3_step self ((tstep_637:FadFloat.t) , (outp_636:(FadFloat.t)Array.t)) =
    (((if self.i_642 then self.m_640 <- FadFloat.make 0.) ;
      self.i_642 <- false ;
      (let (x_641:FadFloat.t) = self.m_640 in
       self.m_640 <- FadFloat.(+) x_641  tstep_637 ;
       (let (omega_639:FadFloat.t) = Array.get outp_636  1 in
        i_1170_step self.i_1170
          (tstep_637 ,
           (Discrete_obs_fad.implies ((Discrete_obs_fad.q_ge (x_641 ,
                                                              (FadFloat.make 
                                                                 30.))) ,
                                      (Discrete_obs_fad.q_le (omega_639 ,
                                                              (FadFloat.make 
                                                                 14.3))))))))):
    FadFloat.t) in
  Node { alloc = wt3_alloc; reset = wt3_reset ; step = wt3_step }
type ('d , 'c , 'b , 'a) _wt4 =
  { mutable i_1172 : 'd ;
    mutable i_1171 : 'c ; mutable i_651 : 'b ; mutable m_649 : 'a }

let wt4  = 
  let Node { alloc = i_1172_alloc; step = i_1172_step ; reset = i_1172_reset } = 
  Discrete_obs_fad.always_timed 630.  in 
  let Node { alloc = i_1171_alloc; step = i_1171_step ; reset = i_1171_reset } = 
  Discrete_obs_fad.bounded_recurrence 5.  in
  let wt4_alloc _ =
    ();
    { i_651 = (false:bool) ; m_649 = (create ():FadFloat.t);
      i_1172 = i_1172_alloc () (* discrete *)  ;
      i_1171 = i_1171_alloc () (* discrete *)  } in
  let wt4_reset self  =
    ((self.i_651 <- true ;
      i_1172_reset self.i_1172  ; i_1171_reset self.i_1171 ):unit) in 
  let wt4_step self ((tstep_644:FadFloat.t) , (outp_643:(FadFloat.t)Array.t)) =
    (((if self.i_651 then self.m_649 <- FadFloat.make 0.) ;
      self.i_651 <- false ;
      (let (x_650:FadFloat.t) = self.m_649 in
       self.m_649 <- FadFloat.(+) x_650  tstep_644 ;
       (let (theta_d_646:FadFloat.t) = Array.get outp_643  3 in
        let (blade_pitch_angle_647:FadFloat.t) = Array.get outp_643  4 in
        let (dif_648:FadFloat.t) =
            Discrete_obs_fad.abs (FadFloat.(-) blade_pitch_angle_647 
                                               theta_d_646) in
        i_1172_step self.i_1172
          (tstep_644 ,
           (Discrete_obs_fad.implies ((Discrete_obs_fad.q_ge (x_650 ,
                                                              (FadFloat.make 
                                                                 35.))) ,
                                      (i_1171_step self.i_1171
                                         (tstep_644 ,
                                          (Discrete_obs_fad.q_le (dif_648 ,
                                                                  (FadFloat.make 
                                                                    1.6))))))))))):
    FadFloat.t) in
  Node { alloc = wt4_alloc; reset = wt4_reset ; step = wt4_step }
type ('u ,
      't ,
      's ,
      'r ,
      'q ,
      'p ,
      'o ,
      'n , 'm , 'l , 'k , 'j , 'i , 'h , 'g , 'f , 'e , 'd , 'c , 'b , 'a) _wt_wt1 =
  { mutable i_1178 : 'u ;
    mutable i_1177 : 't ;
    mutable i_1176 : 's ;
    mutable i_1175 : 'r ;
    mutable i_1174 : 'q ;
    mutable i_1173 : 'p ;
    mutable i_780 : 'o ;
    mutable m_778 : 'n ;
    mutable m_775 : 'm ;
    mutable m_773 : 'l ;
    mutable m_770 : 'k ;
    mutable m_768 : 'j ;
    mutable m_765 : 'i ;
    mutable m_763 : 'h ;
    mutable m_761 : 'g ;
    mutable m_759 : 'f ;
    mutable m_756 : 'e ;
    mutable m_754 : 'd ;
    mutable m_752 : 'c ; mutable v0_0_679 : 'b ; mutable tstep'_664 : 'a }

let wt_wt1 (tstep_653:float) = 
  let Node { alloc = i_1178_alloc; step = i_1178_step ; reset = i_1178_reset } = Wt_d.rate_limiter 
   in 
  let Node { alloc = i_1177_alloc; step = i_1177_step ; reset = i_1177_reset } = Wt_d.pitch_actuator_subsystem 
   in 
  let Node { alloc = i_1176_alloc; step = i_1176_step ; reset = i_1176_reset } = wt1 
   in 
  let Node { alloc = i_1175_alloc; step = i_1175_step ; reset = i_1175_reset } = Wt_d.aero_elastic_subsystem 
   in 
  let Node { alloc = i_1174_alloc; step = i_1174_step ; reset = i_1174_reset } = Wt_common.integrate 
   in 
  let Node { alloc = i_1173_alloc; step = i_1173_step ; reset = i_1173_reset } = Wt_d.rate_limiter 
   in
  let wt_wt1_alloc _ =
    ();
    { i_780 = (false:bool) ;
      m_778 = (create ():FadFloat.t) ;
      m_775 = (create ():FadFloat.t) ;
      m_773 = (create ():FadFloat.t) ;
      m_770 = (create ():FadFloat.t) ;
      m_768 = (create ():FadFloat.t) ;
      m_765 = (create ():FadFloat.t) ;
      m_763 = (create ():FadFloat.t) ;
      m_761 = (create ():FadFloat.t) ;
      m_759 = (create ():FadFloat.t) ;
      m_756 = (create ():FadFloat.t) ;
      m_754 = (create ():FadFloat.t) ;
      m_752 = (create ():FadFloat.t) ;
      v0_0_679 = (create ():FadFloat.t) ;
      tstep'_664 = (create ():FadFloat.t);
      i_1178 = i_1178_alloc () (* discrete *)  ;
      i_1177 = i_1177_alloc () (* discrete *)  ;
      i_1176 = i_1176_alloc () (* discrete *)  ;
      i_1175 = i_1175_alloc () (* discrete *)  ;
      i_1174 = i_1174_alloc () (* discrete *)  ;
      i_1173 = i_1173_alloc () (* discrete *)  } in
  let wt_wt1_reset self  =
    ((self.i_780 <- true ;
      i_1178_reset self.i_1178  ;
      i_1177_reset self.i_1177  ;
      i_1176_reset self.i_1176  ;
      i_1175_reset self.i_1175  ;
      i_1174_reset self.i_1174  ; i_1173_reset self.i_1173 ):unit) in 
  let wt_wt1_step self (inp_652:(FadFloat.t)Array.t) =
    ((let (v0_665:FadFloat.t) = Array.get inp_652  0 in
      (if self.i_780 then self.v0_0_679 <- v0_665) ;
      (let (params_672:Wt_params.params) =
           Wt_params.get_default self.v0_0_679 in
       let (y0_750:FadFloat.t) = params_672.Wt_params.omega_g0 in
       (if self.i_780 then self.m_778 <- y0_750) ;
       (if self.i_780 then self.m_754 <- FadFloat.make 0.) ;
       (let (x_755:FadFloat.t) = self.m_754 in
        let (x_777:FadFloat.t) =
            if self.i_780 then x_755 else FadFloat.(-) x_755  self.m_775 in
        let (y0_740:FadFloat.t) = params_672.Wt_params.pitch.Wt_params.theta0 in
        (if self.i_780 then self.m_773 <- y0_740) ;
        (let (x_772:FadFloat.t) =
             if self.i_780 then x_755 else FadFloat.(-) x_755  self.m_770 in
         let (y0_730:FadFloat.t) =
             FadFloat.( * ) params_672.Wt_params.pitch.Wt_params.theta0 
                            (FadFloat.translate (FadFloat.(/) params_672.Wt_params.pitch.Wt_params.theta0
                                                              
                                                              params_672.Wt_params.pitch.Wt_params.cpc.Wt_params.gS_factor)
                                                 1.) in
         (if self.i_780 then self.m_768 <- y0_730) ;
         (let (x_767:FadFloat.t) =
              if self.i_780 then x_755 else FadFloat.(-) x_755  self.m_765 in
          (if self.i_780 then
           self.m_763 <- params_672.Wt_params.pitch.Wt_params.theta0) ;
          (let (y0_707:FadFloat.t) = params_672.Wt_params.xt_dot0 in
           (if self.i_780 then self.m_761 <- y0_707) ;
           (let (y0_703:FadFloat.t) = params_672.Wt_params.omega0 in
            (if self.i_780 then self.m_759 <- y0_703) ;
            (let (x_758:FadFloat.t) =
                 if self.i_780 then x_755 else FadFloat.(-) x_755  self.m_756 in
             (if self.i_780 then self.tstep'_664 <- FadFloat.make tstep_653)
             ;
             (if self.i_780 then self.m_752 <- self.tstep'_664) ;
             self.i_780 <- false ;
             (let (x_774:FadFloat.t) = self.m_773 in
              let (theta_662:FadFloat.t) = Wt_common.rad2deg x_774 in
              let (x_760:FadFloat.t) = self.m_759 in
              let (omega_657:FadFloat.t) = Wt_common.radPs2rpm x_760 in
              let (x_779:FadFloat.t) = self.m_778 in
              let (omega_g_658:FadFloat.t) = Wt_common.radPs2rpm x_779 in
              let (x_764:FadFloat.t) = self.m_763 in
              let (gs_715:FadFloat.t) =
                  FadFloat.inv (FadFloat.translate (FadFloat.(/) x_764 
                                                                 params_672.Wt_params.pitch.Wt_params.cpc.Wt_params.gS_factor)
                                                    1.) in
              let (omega_g_rated_710:FadFloat.t) =
                  params_672.Wt_params.omega_g_rated in
              let (e_714:FadFloat.t) = FadFloat.(-) x_779  omega_g_rated_710 in
              let (e1_721:FadFloat.t) =
                  FadFloat.( * ) e_714 
                                 params_672.Wt_params.pitch.Wt_params.cpc.Wt_params.kP in
              let (x_769:FadFloat.t) = self.m_768 in
              let (e4_724:FadFloat.t) = FadFloat.(+) e1_721  x_769 in
              let (theta_d'_726:FadFloat.t) = FadFloat.( * ) gs_715  e4_724 in
              let (theta_d_725:FadFloat.t) =
                  Wt_d.saturate (params_672.Wt_params.pitch.Wt_params.min ,
                                 params_672.Wt_params.pitch.Wt_params.max ,
                                 theta_d'_726) in
              let (theta_d_675:FadFloat.t) =
                  i_1178_step self.i_1178
                    (x_755 ,
                     params_672.Wt_params.pitch.Wt_params.rateLimit ,
                     (FadFloat.(~-) params_672.Wt_params.pitch.Wt_params.rateLimit)
                     ,
                     params_672.Wt_params.pitch.Wt_params.thetaDot0 ,
                     theta_d_725) in
              let (theta_d_663:FadFloat.t) = Wt_common.rad2deg theta_d_675 in
              let (blade_pitch_angle_685:FadFloat.t) =
                  i_1177_step self.i_1177
                    (x_755 ,
                     params_672.Wt_params.pitch.Wt_params.actuatorType ,
                     theta_d_675 , params_672) in
              let (blade_pitch_angle_654:FadFloat.t) =
                  Wt_common.rad2deg blade_pitch_angle_685 in
              let (mg_d_669:FadFloat.t) =
                  Wt_d.torque_controller (x_779 , theta_d_675 , params_672) in
              let (outp_659:(FadFloat.t)Array.t) =
                  Array.of_list ((::) (theta_662 ,
                                       ((::) (omega_657 ,
                                              ((::) (omega_g_658 ,
                                                     ((::) (theta_d_663 ,
                                                            ((::) (blade_pitch_angle_654
                                                                   ,
                                                                   ((::) 
                                                                    (
                                                                    mg_d_669
                                                                    , 
                                                                    ([]))))))))))))) in
              let (rob_660:FadFloat.t) =
                  i_1176_step self.i_1176 (self.tstep'_664 , outp_659) in
              let (u_744:FadFloat.t) =
                  FadFloat.(/) x_760  params_672.Wt_params.gBRatio in
              let (dy_745:FadFloat.t) =
                  FadFloat.(/) (FadFloat.(-) u_744  x_779) 
                               params_672.Wt_params.vscontrol.Wt_params.vs_filterConstant in
              self.m_778 <- FadFloat.(+) (FadFloat.( * ) dy_745  x_777) 
                                         x_779 ;
              self.m_775 <- x_755 ;
              (let (dy_735:FadFloat.t) =
                   FadFloat.(/) (FadFloat.(-) blade_pitch_angle_685  x_774) 
                                params_672.Wt_params.pitch.Wt_params.pitch_filterConstant in
               self.m_773 <- FadFloat.(+) (FadFloat.( * ) dy_735  x_772) 
                                          x_774 ;
               self.m_770 <- x_755 ;
               (let (e2_722:FadFloat.t) =
                    FadFloat.(-) e1_721 
                                 (FadFloat.( * ) (FadFloat.(-) theta_d'_726 
                                                               theta_d_725) 
                                                 params_672.Wt_params.pitch.Wt_params.cpc.Wt_params.antiWindUp) in
                let (x_729:FadFloat.t) =
                    FadFloat.(/) e2_722 
                                 params_672.Wt_params.pitch.Wt_params.cpc.Wt_params.tI in
                self.m_768 <- FadFloat.(+) (FadFloat.( * ) x_729  x_767) 
                                           x_769 ;
                self.m_765 <- x_755 ;
                self.m_763 <- blade_pitch_angle_685 ;
                (let (x_762:FadFloat.t) = self.m_761 in
                 let ((ma_687:FadFloat.t) , (fa_686:FadFloat.t)) =
                     i_1175_step self.i_1175
                       (v0_665 ,
                        blade_pitch_angle_685 , x_760 , x_762 , params_672) in
                 let (xT_699:FadFloat.t) =
                     i_1174_step self.i_1174
                       (x_758 , x_762 , params_672.Wt_params.xT0) in
                 let (dxT_dot_696:FadFloat.t) =
                     FadFloat.(/) (FadFloat.(-) (FadFloat.(-) fa_686 
                                                              (FadFloat.( * ) 
                                                                 x_762 
                                                                 params_672.Wt_params.cTe))
                                                
                                                (FadFloat.( * ) (FadFloat.(-) 
                                                                   xT_699 
                                                                   params_672.Wt_params.xT0)
                                                                
                                                                params_672.Wt_params.kTe))
                                   params_672.Wt_params.mTe in
                 self.m_761 <- FadFloat.(+) (FadFloat.( * ) dxT_dot_696 
                                                            x_758)  x_762 ;
                 (let (torque_aux_678:FadFloat.t) =
                      i_1173_step self.i_1173
                        (x_755 ,
                         params_672.Wt_params.vscontrol.Wt_params.maxRat ,
                         (FadFloat.(~-) params_672.Wt_params.vscontrol.Wt_params.maxRat)
                         , (FadFloat.make 0.) , mg_d_669) in
                  let (torque_677:FadFloat.t) =
                      Wt_d.saturate (FadFloat.neg_infinity ,
                                     params_672.Wt_params.vscontrol.Wt_params.maxTq
                                     , torque_aux_678) in
                  let (domega_695:FadFloat.t) =
                      FadFloat.(/) (FadFloat.(-) ma_687 
                                                 (FadFloat.(/) torque_677 
                                                               params_672.Wt_params.gBRatio))
                                    params_672.Wt_params.inertia in
                  self.m_759 <- FadFloat.(+) (FadFloat.( * ) domega_695 
                                                             x_758)  
                                             x_760 ;
                  self.m_756 <- x_755 ;
                  (let (x_753:FadFloat.t) = self.m_752 in
                   self.m_754 <- x_753 ;
                   self.m_752 <- FadFloat.(+) x_753  self.tstep'_664 ;
                   ((FadFloat.get x_753) ,
                    outp_659 , (FadFloat.translate rob_660  0.1)))))))))))))))):
    float * FadFloat.t Array.t * FadFloat.t) in
  Node { alloc = wt_wt1_alloc; reset = wt_wt1_reset ; step = wt_wt1_step }
type ('u ,
      't ,
      's ,
      'r ,
      'q ,
      'p ,
      'o ,
      'n , 'm , 'l , 'k , 'j , 'i , 'h , 'g , 'f , 'e , 'd , 'c , 'b , 'a) _wt_wt2 =
  { mutable i_1184 : 'u ;
    mutable i_1183 : 't ;
    mutable i_1182 : 's ;
    mutable i_1181 : 'r ;
    mutable i_1180 : 'q ;
    mutable i_1179 : 'p ;
    mutable i_909 : 'o ;
    mutable m_907 : 'n ;
    mutable m_904 : 'm ;
    mutable m_902 : 'l ;
    mutable m_899 : 'k ;
    mutable m_897 : 'j ;
    mutable m_894 : 'i ;
    mutable m_892 : 'h ;
    mutable m_890 : 'g ;
    mutable m_888 : 'f ;
    mutable m_885 : 'e ;
    mutable m_883 : 'd ;
    mutable m_881 : 'c ; mutable v0_0_808 : 'b ; mutable tstep'_793 : 'a }

let wt_wt2 (tstep_782:float) = 
  let Node { alloc = i_1184_alloc; step = i_1184_step ; reset = i_1184_reset } = Wt_d.rate_limiter 
   in 
  let Node { alloc = i_1183_alloc; step = i_1183_step ; reset = i_1183_reset } = Wt_d.pitch_actuator_subsystem 
   in 
  let Node { alloc = i_1182_alloc; step = i_1182_step ; reset = i_1182_reset } = wt2 
   in 
  let Node { alloc = i_1181_alloc; step = i_1181_step ; reset = i_1181_reset } = Wt_d.aero_elastic_subsystem 
   in 
  let Node { alloc = i_1180_alloc; step = i_1180_step ; reset = i_1180_reset } = Wt_common.integrate 
   in 
  let Node { alloc = i_1179_alloc; step = i_1179_step ; reset = i_1179_reset } = Wt_d.rate_limiter 
   in
  let wt_wt2_alloc _ =
    ();
    { i_909 = (false:bool) ;
      m_907 = (create ():FadFloat.t) ;
      m_904 = (create ():FadFloat.t) ;
      m_902 = (create ():FadFloat.t) ;
      m_899 = (create ():FadFloat.t) ;
      m_897 = (create ():FadFloat.t) ;
      m_894 = (create ():FadFloat.t) ;
      m_892 = (create ():FadFloat.t) ;
      m_890 = (create ():FadFloat.t) ;
      m_888 = (create ():FadFloat.t) ;
      m_885 = (create ():FadFloat.t) ;
      m_883 = (create ():FadFloat.t) ;
      m_881 = (create ():FadFloat.t) ;
      v0_0_808 = (create ():FadFloat.t) ;
      tstep'_793 = (create ():FadFloat.t);
      i_1184 = i_1184_alloc () (* discrete *)  ;
      i_1183 = i_1183_alloc () (* discrete *)  ;
      i_1182 = i_1182_alloc () (* discrete *)  ;
      i_1181 = i_1181_alloc () (* discrete *)  ;
      i_1180 = i_1180_alloc () (* discrete *)  ;
      i_1179 = i_1179_alloc () (* discrete *)  } in
  let wt_wt2_reset self  =
    ((self.i_909 <- true ;
      i_1184_reset self.i_1184  ;
      i_1183_reset self.i_1183  ;
      i_1182_reset self.i_1182  ;
      i_1181_reset self.i_1181  ;
      i_1180_reset self.i_1180  ; i_1179_reset self.i_1179 ):unit) in 
  let wt_wt2_step self (inp_781:(FadFloat.t)Array.t) =
    ((let (v0_794:FadFloat.t) = Array.get inp_781  0 in
      (if self.i_909 then self.v0_0_808 <- v0_794) ;
      (let (params_801:Wt_params.params) =
           Wt_params.get_default self.v0_0_808 in
       let (y0_879:FadFloat.t) = params_801.Wt_params.omega_g0 in
       (if self.i_909 then self.m_907 <- y0_879) ;
       (if self.i_909 then self.m_883 <- FadFloat.make 0.) ;
       (let (x_884:FadFloat.t) = self.m_883 in
        let (x_906:FadFloat.t) =
            if self.i_909 then x_884 else FadFloat.(-) x_884  self.m_904 in
        let (y0_869:FadFloat.t) = params_801.Wt_params.pitch.Wt_params.theta0 in
        (if self.i_909 then self.m_902 <- y0_869) ;
        (let (x_901:FadFloat.t) =
             if self.i_909 then x_884 else FadFloat.(-) x_884  self.m_899 in
         let (y0_859:FadFloat.t) =
             FadFloat.( * ) params_801.Wt_params.pitch.Wt_params.theta0 
                            (FadFloat.translate (FadFloat.(/) params_801.Wt_params.pitch.Wt_params.theta0
                                                              
                                                              params_801.Wt_params.pitch.Wt_params.cpc.Wt_params.gS_factor)
                                                 1.) in
         (if self.i_909 then self.m_897 <- y0_859) ;
         (let (x_896:FadFloat.t) =
              if self.i_909 then x_884 else FadFloat.(-) x_884  self.m_894 in
          (if self.i_909 then
           self.m_892 <- params_801.Wt_params.pitch.Wt_params.theta0) ;
          (let (y0_836:FadFloat.t) = params_801.Wt_params.xt_dot0 in
           (if self.i_909 then self.m_890 <- y0_836) ;
           (let (y0_832:FadFloat.t) = params_801.Wt_params.omega0 in
            (if self.i_909 then self.m_888 <- y0_832) ;
            (let (x_887:FadFloat.t) =
                 if self.i_909 then x_884 else FadFloat.(-) x_884  self.m_885 in
             (if self.i_909 then self.tstep'_793 <- FadFloat.make tstep_782)
             ;
             (if self.i_909 then self.m_881 <- self.tstep'_793) ;
             self.i_909 <- false ;
             (let (x_903:FadFloat.t) = self.m_902 in
              let (theta_791:FadFloat.t) = Wt_common.rad2deg x_903 in
              let (x_889:FadFloat.t) = self.m_888 in
              let (omega_786:FadFloat.t) = Wt_common.radPs2rpm x_889 in
              let (x_908:FadFloat.t) = self.m_907 in
              let (omega_g_787:FadFloat.t) = Wt_common.radPs2rpm x_908 in
              let (x_893:FadFloat.t) = self.m_892 in
              let (gs_844:FadFloat.t) =
                  FadFloat.inv (FadFloat.translate (FadFloat.(/) x_893 
                                                                 params_801.Wt_params.pitch.Wt_params.cpc.Wt_params.gS_factor)
                                                    1.) in
              let (omega_g_rated_839:FadFloat.t) =
                  params_801.Wt_params.omega_g_rated in
              let (e_843:FadFloat.t) = FadFloat.(-) x_908  omega_g_rated_839 in
              let (e1_850:FadFloat.t) =
                  FadFloat.( * ) e_843 
                                 params_801.Wt_params.pitch.Wt_params.cpc.Wt_params.kP in
              let (x_898:FadFloat.t) = self.m_897 in
              let (e4_853:FadFloat.t) = FadFloat.(+) e1_850  x_898 in
              let (theta_d'_855:FadFloat.t) = FadFloat.( * ) gs_844  e4_853 in
              let (theta_d_854:FadFloat.t) =
                  Wt_d.saturate (params_801.Wt_params.pitch.Wt_params.min ,
                                 params_801.Wt_params.pitch.Wt_params.max ,
                                 theta_d'_855) in
              let (theta_d_804:FadFloat.t) =
                  i_1184_step self.i_1184
                    (x_884 ,
                     params_801.Wt_params.pitch.Wt_params.rateLimit ,
                     (FadFloat.(~-) params_801.Wt_params.pitch.Wt_params.rateLimit)
                     ,
                     params_801.Wt_params.pitch.Wt_params.thetaDot0 ,
                     theta_d_854) in
              let (theta_d_792:FadFloat.t) = Wt_common.rad2deg theta_d_804 in
              let (blade_pitch_angle_814:FadFloat.t) =
                  i_1183_step self.i_1183
                    (x_884 ,
                     params_801.Wt_params.pitch.Wt_params.actuatorType ,
                     theta_d_804 , params_801) in
              let (blade_pitch_angle_783:FadFloat.t) =
                  Wt_common.rad2deg blade_pitch_angle_814 in
              let (mg_d_798:FadFloat.t) =
                  Wt_d.torque_controller (x_908 , theta_d_804 , params_801) in
              let (outp_788:(FadFloat.t)Array.t) =
                  Array.of_list ((::) (theta_791 ,
                                       ((::) (omega_786 ,
                                              ((::) (omega_g_787 ,
                                                     ((::) (theta_d_792 ,
                                                            ((::) (blade_pitch_angle_783
                                                                   ,
                                                                   ((::) 
                                                                    (
                                                                    mg_d_798
                                                                    , 
                                                                    ([]))))))))))))) in
              let (rob_789:FadFloat.t) =
                  i_1182_step self.i_1182 (self.tstep'_793 , outp_788) in
              let (u_873:FadFloat.t) =
                  FadFloat.(/) x_889  params_801.Wt_params.gBRatio in
              let (dy_874:FadFloat.t) =
                  FadFloat.(/) (FadFloat.(-) u_873  x_908) 
                               params_801.Wt_params.vscontrol.Wt_params.vs_filterConstant in
              self.m_907 <- FadFloat.(+) (FadFloat.( * ) dy_874  x_906) 
                                         x_908 ;
              self.m_904 <- x_884 ;
              (let (dy_864:FadFloat.t) =
                   FadFloat.(/) (FadFloat.(-) blade_pitch_angle_814  x_903) 
                                params_801.Wt_params.pitch.Wt_params.pitch_filterConstant in
               self.m_902 <- FadFloat.(+) (FadFloat.( * ) dy_864  x_901) 
                                          x_903 ;
               self.m_899 <- x_884 ;
               (let (e2_851:FadFloat.t) =
                    FadFloat.(-) e1_850 
                                 (FadFloat.( * ) (FadFloat.(-) theta_d'_855 
                                                               theta_d_854) 
                                                 params_801.Wt_params.pitch.Wt_params.cpc.Wt_params.antiWindUp) in
                let (x_858:FadFloat.t) =
                    FadFloat.(/) e2_851 
                                 params_801.Wt_params.pitch.Wt_params.cpc.Wt_params.tI in
                self.m_897 <- FadFloat.(+) (FadFloat.( * ) x_858  x_896) 
                                           x_898 ;
                self.m_894 <- x_884 ;
                self.m_892 <- blade_pitch_angle_814 ;
                (let (x_891:FadFloat.t) = self.m_890 in
                 let ((ma_816:FadFloat.t) , (fa_815:FadFloat.t)) =
                     i_1181_step self.i_1181
                       (v0_794 ,
                        blade_pitch_angle_814 , x_889 , x_891 , params_801) in
                 let (xT_828:FadFloat.t) =
                     i_1180_step self.i_1180
                       (x_887 , x_891 , params_801.Wt_params.xT0) in
                 let (dxT_dot_825:FadFloat.t) =
                     FadFloat.(/) (FadFloat.(-) (FadFloat.(-) fa_815 
                                                              (FadFloat.( * ) 
                                                                 x_891 
                                                                 params_801.Wt_params.cTe))
                                                
                                                (FadFloat.( * ) (FadFloat.(-) 
                                                                   xT_828 
                                                                   params_801.Wt_params.xT0)
                                                                
                                                                params_801.Wt_params.kTe))
                                   params_801.Wt_params.mTe in
                 self.m_890 <- FadFloat.(+) (FadFloat.( * ) dxT_dot_825 
                                                            x_887)  x_891 ;
                 (let (torque_aux_807:FadFloat.t) =
                      i_1179_step self.i_1179
                        (x_884 ,
                         params_801.Wt_params.vscontrol.Wt_params.maxRat ,
                         (FadFloat.(~-) params_801.Wt_params.vscontrol.Wt_params.maxRat)
                         , (FadFloat.make 0.) , mg_d_798) in
                  let (torque_806:FadFloat.t) =
                      Wt_d.saturate (FadFloat.neg_infinity ,
                                     params_801.Wt_params.vscontrol.Wt_params.maxTq
                                     , torque_aux_807) in
                  let (domega_824:FadFloat.t) =
                      FadFloat.(/) (FadFloat.(-) ma_816 
                                                 (FadFloat.(/) torque_806 
                                                               params_801.Wt_params.gBRatio))
                                    params_801.Wt_params.inertia in
                  self.m_888 <- FadFloat.(+) (FadFloat.( * ) domega_824 
                                                             x_887)  
                                             x_889 ;
                  self.m_885 <- x_884 ;
                  (let (x_882:FadFloat.t) = self.m_881 in
                   self.m_883 <- x_882 ;
                   self.m_881 <- FadFloat.(+) x_882  self.tstep'_793 ;
                   ((FadFloat.get x_882) , outp_788 , rob_789))))))))))))))):
    float * FadFloat.t Array.t * FadFloat.t) in
  Node { alloc = wt_wt2_alloc; reset = wt_wt2_reset ; step = wt_wt2_step }
type ('u ,
      't ,
      's ,
      'r ,
      'q ,
      'p ,
      'o ,
      'n , 'm , 'l , 'k , 'j , 'i , 'h , 'g , 'f , 'e , 'd , 'c , 'b , 'a) _wt_wt3 =
  { mutable i_1190 : 'u ;
    mutable i_1189 : 't ;
    mutable i_1188 : 's ;
    mutable i_1187 : 'r ;
    mutable i_1186 : 'q ;
    mutable i_1185 : 'p ;
    mutable i_1038 : 'o ;
    mutable m_1036 : 'n ;
    mutable m_1033 : 'm ;
    mutable m_1031 : 'l ;
    mutable m_1028 : 'k ;
    mutable m_1026 : 'j ;
    mutable m_1023 : 'i ;
    mutable m_1021 : 'h ;
    mutable m_1019 : 'g ;
    mutable m_1017 : 'f ;
    mutable m_1014 : 'e ;
    mutable m_1012 : 'd ;
    mutable m_1010 : 'c ; mutable v0_0_937 : 'b ; mutable tstep'_922 : 'a }

let wt_wt3 (tstep_911:float) = 
  let Node { alloc = i_1190_alloc; step = i_1190_step ; reset = i_1190_reset } = Wt_d.rate_limiter 
   in 
  let Node { alloc = i_1189_alloc; step = i_1189_step ; reset = i_1189_reset } = Wt_d.pitch_actuator_subsystem 
   in 
  let Node { alloc = i_1188_alloc; step = i_1188_step ; reset = i_1188_reset } = wt3 
   in 
  let Node { alloc = i_1187_alloc; step = i_1187_step ; reset = i_1187_reset } = Wt_d.aero_elastic_subsystem 
   in 
  let Node { alloc = i_1186_alloc; step = i_1186_step ; reset = i_1186_reset } = Wt_common.integrate 
   in 
  let Node { alloc = i_1185_alloc; step = i_1185_step ; reset = i_1185_reset } = Wt_d.rate_limiter 
   in
  let wt_wt3_alloc _ =
    ();
    { i_1038 = (false:bool) ;
      m_1036 = (create ():FadFloat.t) ;
      m_1033 = (create ():FadFloat.t) ;
      m_1031 = (create ():FadFloat.t) ;
      m_1028 = (create ():FadFloat.t) ;
      m_1026 = (create ():FadFloat.t) ;
      m_1023 = (create ():FadFloat.t) ;
      m_1021 = (create ():FadFloat.t) ;
      m_1019 = (create ():FadFloat.t) ;
      m_1017 = (create ():FadFloat.t) ;
      m_1014 = (create ():FadFloat.t) ;
      m_1012 = (create ():FadFloat.t) ;
      m_1010 = (create ():FadFloat.t) ;
      v0_0_937 = (create ():FadFloat.t) ;
      tstep'_922 = (create ():FadFloat.t);
      i_1190 = i_1190_alloc () (* discrete *)  ;
      i_1189 = i_1189_alloc () (* discrete *)  ;
      i_1188 = i_1188_alloc () (* discrete *)  ;
      i_1187 = i_1187_alloc () (* discrete *)  ;
      i_1186 = i_1186_alloc () (* discrete *)  ;
      i_1185 = i_1185_alloc () (* discrete *)  } in
  let wt_wt3_reset self  =
    ((self.i_1038 <- true ;
      i_1190_reset self.i_1190  ;
      i_1189_reset self.i_1189  ;
      i_1188_reset self.i_1188  ;
      i_1187_reset self.i_1187  ;
      i_1186_reset self.i_1186  ; i_1185_reset self.i_1185 ):unit) in 
  let wt_wt3_step self (inp_910:(FadFloat.t)Array.t) =
    ((let (v0_923:FadFloat.t) = Array.get inp_910  0 in
      (if self.i_1038 then self.v0_0_937 <- v0_923) ;
      (let (params_930:Wt_params.params) =
           Wt_params.get_default self.v0_0_937 in
       let (y0_1008:FadFloat.t) = params_930.Wt_params.omega_g0 in
       (if self.i_1038 then self.m_1036 <- y0_1008) ;
       (if self.i_1038 then self.m_1012 <- FadFloat.make 0.) ;
       (let (x_1013:FadFloat.t) = self.m_1012 in
        let (x_1035:FadFloat.t) =
            if self.i_1038 then x_1013 else FadFloat.(-) x_1013  self.m_1033 in
        let (y0_998:FadFloat.t) = params_930.Wt_params.pitch.Wt_params.theta0 in
        (if self.i_1038 then self.m_1031 <- y0_998) ;
        (let (x_1030:FadFloat.t) =
             if self.i_1038 then x_1013 else FadFloat.(-) x_1013  self.m_1028 in
         let (y0_988:FadFloat.t) =
             FadFloat.( * ) params_930.Wt_params.pitch.Wt_params.theta0 
                            (FadFloat.translate (FadFloat.(/) params_930.Wt_params.pitch.Wt_params.theta0
                                                              
                                                              params_930.Wt_params.pitch.Wt_params.cpc.Wt_params.gS_factor)
                                                 1.) in
         (if self.i_1038 then self.m_1026 <- y0_988) ;
         (let (x_1025:FadFloat.t) =
              if self.i_1038
              then x_1013
              else FadFloat.(-) x_1013  self.m_1023 in
          (if self.i_1038 then
           self.m_1021 <- params_930.Wt_params.pitch.Wt_params.theta0) ;
          (let (y0_965:FadFloat.t) = params_930.Wt_params.xt_dot0 in
           (if self.i_1038 then self.m_1019 <- y0_965) ;
           (let (y0_961:FadFloat.t) = params_930.Wt_params.omega0 in
            (if self.i_1038 then self.m_1017 <- y0_961) ;
            (let (x_1016:FadFloat.t) =
                 if self.i_1038
                 then x_1013
                 else FadFloat.(-) x_1013  self.m_1014 in
             (if self.i_1038 then self.tstep'_922 <- FadFloat.make tstep_911)
             ;
             (if self.i_1038 then self.m_1010 <- self.tstep'_922) ;
             self.i_1038 <- false ;
             (let (x_1032:FadFloat.t) = self.m_1031 in
              let (theta_920:FadFloat.t) = Wt_common.rad2deg x_1032 in
              let (x_1018:FadFloat.t) = self.m_1017 in
              let (omega_915:FadFloat.t) = Wt_common.radPs2rpm x_1018 in
              let (x_1037:FadFloat.t) = self.m_1036 in
              let (omega_g_916:FadFloat.t) = Wt_common.radPs2rpm x_1037 in
              let (x_1022:FadFloat.t) = self.m_1021 in
              let (gs_973:FadFloat.t) =
                  FadFloat.inv (FadFloat.translate (FadFloat.(/) x_1022 
                                                                 params_930.Wt_params.pitch.Wt_params.cpc.Wt_params.gS_factor)
                                                    1.) in
              let (omega_g_rated_968:FadFloat.t) =
                  params_930.Wt_params.omega_g_rated in
              let (e_972:FadFloat.t) = FadFloat.(-) x_1037  omega_g_rated_968 in
              let (e1_979:FadFloat.t) =
                  FadFloat.( * ) e_972 
                                 params_930.Wt_params.pitch.Wt_params.cpc.Wt_params.kP in
              let (x_1027:FadFloat.t) = self.m_1026 in
              let (e4_982:FadFloat.t) = FadFloat.(+) e1_979  x_1027 in
              let (theta_d'_984:FadFloat.t) = FadFloat.( * ) gs_973  e4_982 in
              let (theta_d_983:FadFloat.t) =
                  Wt_d.saturate (params_930.Wt_params.pitch.Wt_params.min ,
                                 params_930.Wt_params.pitch.Wt_params.max ,
                                 theta_d'_984) in
              let (theta_d_933:FadFloat.t) =
                  i_1190_step self.i_1190
                    (x_1013 ,
                     params_930.Wt_params.pitch.Wt_params.rateLimit ,
                     (FadFloat.(~-) params_930.Wt_params.pitch.Wt_params.rateLimit)
                     ,
                     params_930.Wt_params.pitch.Wt_params.thetaDot0 ,
                     theta_d_983) in
              let (theta_d_921:FadFloat.t) = Wt_common.rad2deg theta_d_933 in
              let (blade_pitch_angle_943:FadFloat.t) =
                  i_1189_step self.i_1189
                    (x_1013 ,
                     params_930.Wt_params.pitch.Wt_params.actuatorType ,
                     theta_d_933 , params_930) in
              let (blade_pitch_angle_912:FadFloat.t) =
                  Wt_common.rad2deg blade_pitch_angle_943 in
              let (mg_d_927:FadFloat.t) =
                  Wt_d.torque_controller (x_1037 , theta_d_933 , params_930) in
              let (outp_917:(FadFloat.t)Array.t) =
                  Array.of_list ((::) (theta_920 ,
                                       ((::) (omega_915 ,
                                              ((::) (omega_g_916 ,
                                                     ((::) (theta_d_921 ,
                                                            ((::) (blade_pitch_angle_912
                                                                   ,
                                                                   ((::) 
                                                                    (
                                                                    mg_d_927
                                                                    , 
                                                                    ([]))))))))))))) in
              let (rob_918:FadFloat.t) =
                  i_1188_step self.i_1188 (self.tstep'_922 , outp_917) in
              let (u_1002:FadFloat.t) =
                  FadFloat.(/) x_1018  params_930.Wt_params.gBRatio in
              let (dy_1003:FadFloat.t) =
                  FadFloat.(/) (FadFloat.(-) u_1002  x_1037) 
                               params_930.Wt_params.vscontrol.Wt_params.vs_filterConstant in
              self.m_1036 <- FadFloat.(+) (FadFloat.( * ) dy_1003  x_1035) 
                                          x_1037 ;
              self.m_1033 <- x_1013 ;
              (let (dy_993:FadFloat.t) =
                   FadFloat.(/) (FadFloat.(-) blade_pitch_angle_943  x_1032) 
                                params_930.Wt_params.pitch.Wt_params.pitch_filterConstant in
               self.m_1031 <- FadFloat.(+) (FadFloat.( * ) dy_993  x_1030) 
                                           x_1032 ;
               self.m_1028 <- x_1013 ;
               (let (e2_980:FadFloat.t) =
                    FadFloat.(-) e1_979 
                                 (FadFloat.( * ) (FadFloat.(-) theta_d'_984 
                                                               theta_d_983) 
                                                 params_930.Wt_params.pitch.Wt_params.cpc.Wt_params.antiWindUp) in
                let (x_987:FadFloat.t) =
                    FadFloat.(/) e2_980 
                                 params_930.Wt_params.pitch.Wt_params.cpc.Wt_params.tI in
                self.m_1026 <- FadFloat.(+) (FadFloat.( * ) x_987  x_1025) 
                                            x_1027 ;
                self.m_1023 <- x_1013 ;
                self.m_1021 <- blade_pitch_angle_943 ;
                (let (x_1020:FadFloat.t) = self.m_1019 in
                 let ((ma_945:FadFloat.t) , (fa_944:FadFloat.t)) =
                     i_1187_step self.i_1187
                       (v0_923 ,
                        blade_pitch_angle_943 , x_1018 , x_1020 , params_930) in
                 let (xT_957:FadFloat.t) =
                     i_1186_step self.i_1186
                       (x_1016 , x_1020 , params_930.Wt_params.xT0) in
                 let (dxT_dot_954:FadFloat.t) =
                     FadFloat.(/) (FadFloat.(-) (FadFloat.(-) fa_944 
                                                              (FadFloat.( * ) 
                                                                 x_1020 
                                                                 params_930.Wt_params.cTe))
                                                
                                                (FadFloat.( * ) (FadFloat.(-) 
                                                                   xT_957 
                                                                   params_930.Wt_params.xT0)
                                                                
                                                                params_930.Wt_params.kTe))
                                   params_930.Wt_params.mTe in
                 self.m_1019 <- FadFloat.(+) (FadFloat.( * ) dxT_dot_954 
                                                             x_1016)  
                                             x_1020 ;
                 (let (torque_aux_936:FadFloat.t) =
                      i_1185_step self.i_1185
                        (x_1013 ,
                         params_930.Wt_params.vscontrol.Wt_params.maxRat ,
                         (FadFloat.(~-) params_930.Wt_params.vscontrol.Wt_params.maxRat)
                         , (FadFloat.make 0.) , mg_d_927) in
                  let (torque_935:FadFloat.t) =
                      Wt_d.saturate (FadFloat.neg_infinity ,
                                     params_930.Wt_params.vscontrol.Wt_params.maxTq
                                     , torque_aux_936) in
                  let (domega_953:FadFloat.t) =
                      FadFloat.(/) (FadFloat.(-) ma_945 
                                                 (FadFloat.(/) torque_935 
                                                               params_930.Wt_params.gBRatio))
                                    params_930.Wt_params.inertia in
                  self.m_1017 <- FadFloat.(+) (FadFloat.( * ) domega_953 
                                                              x_1016)  
                                              x_1018 ;
                  self.m_1014 <- x_1013 ;
                  (let (x_1011:FadFloat.t) = self.m_1010 in
                   self.m_1012 <- x_1011 ;
                   self.m_1010 <- FadFloat.(+) x_1011  self.tstep'_922 ;
                   ((FadFloat.get x_1011) ,
                    outp_917 , (FadFloat.(+) rob_918  (FadFloat.make 0.1))))))))))))))))):
    float * FadFloat.t Array.t * FadFloat.t) in
  Node { alloc = wt_wt3_alloc; reset = wt_wt3_reset ; step = wt_wt3_step }
type ('u ,
      't ,
      's ,
      'r ,
      'q ,
      'p ,
      'o ,
      'n , 'm , 'l , 'k , 'j , 'i , 'h , 'g , 'f , 'e , 'd , 'c , 'b , 'a) _wt_wt4 =
  { mutable i_1196 : 'u ;
    mutable i_1195 : 't ;
    mutable i_1194 : 's ;
    mutable i_1193 : 'r ;
    mutable i_1192 : 'q ;
    mutable i_1191 : 'p ;
    mutable i_1167 : 'o ;
    mutable m_1165 : 'n ;
    mutable m_1162 : 'm ;
    mutable m_1160 : 'l ;
    mutable m_1157 : 'k ;
    mutable m_1155 : 'j ;
    mutable m_1152 : 'i ;
    mutable m_1150 : 'h ;
    mutable m_1148 : 'g ;
    mutable m_1146 : 'f ;
    mutable m_1143 : 'e ;
    mutable m_1141 : 'd ;
    mutable m_1139 : 'c ; mutable v0_0_1066 : 'b ; mutable tstep'_1051 : 'a }

let wt_wt4 (tstep_1040:float) = 
  let Node { alloc = i_1196_alloc; step = i_1196_step ; reset = i_1196_reset } = Wt_d.rate_limiter 
   in 
  let Node { alloc = i_1195_alloc; step = i_1195_step ; reset = i_1195_reset } = Wt_d.pitch_actuator_subsystem 
   in 
  let Node { alloc = i_1194_alloc; step = i_1194_step ; reset = i_1194_reset } = wt4 
   in 
  let Node { alloc = i_1193_alloc; step = i_1193_step ; reset = i_1193_reset } = Wt_d.aero_elastic_subsystem 
   in 
  let Node { alloc = i_1192_alloc; step = i_1192_step ; reset = i_1192_reset } = Wt_common.integrate 
   in 
  let Node { alloc = i_1191_alloc; step = i_1191_step ; reset = i_1191_reset } = Wt_d.rate_limiter 
   in
  let wt_wt4_alloc _ =
    ();
    { i_1167 = (false:bool) ;
      m_1165 = (create ():FadFloat.t) ;
      m_1162 = (create ():FadFloat.t) ;
      m_1160 = (create ():FadFloat.t) ;
      m_1157 = (create ():FadFloat.t) ;
      m_1155 = (create ():FadFloat.t) ;
      m_1152 = (create ():FadFloat.t) ;
      m_1150 = (create ():FadFloat.t) ;
      m_1148 = (create ():FadFloat.t) ;
      m_1146 = (create ():FadFloat.t) ;
      m_1143 = (create ():FadFloat.t) ;
      m_1141 = (create ():FadFloat.t) ;
      m_1139 = (create ():FadFloat.t) ;
      v0_0_1066 = (create ():FadFloat.t) ;
      tstep'_1051 = (create ():FadFloat.t);
      i_1196 = i_1196_alloc () (* discrete *)  ;
      i_1195 = i_1195_alloc () (* discrete *)  ;
      i_1194 = i_1194_alloc () (* discrete *)  ;
      i_1193 = i_1193_alloc () (* discrete *)  ;
      i_1192 = i_1192_alloc () (* discrete *)  ;
      i_1191 = i_1191_alloc () (* discrete *)  } in
  let wt_wt4_reset self  =
    ((self.i_1167 <- true ;
      i_1196_reset self.i_1196  ;
      i_1195_reset self.i_1195  ;
      i_1194_reset self.i_1194  ;
      i_1193_reset self.i_1193  ;
      i_1192_reset self.i_1192  ; i_1191_reset self.i_1191 ):unit) in 
  let wt_wt4_step self (inp_1039:(FadFloat.t)Array.t) =
    ((let (v0_1052:FadFloat.t) = Array.get inp_1039  0 in
      (if self.i_1167 then self.v0_0_1066 <- v0_1052) ;
      (let (params_1059:Wt_params.params) =
           Wt_params.get_default self.v0_0_1066 in
       let (y0_1137:FadFloat.t) = params_1059.Wt_params.omega_g0 in
       (if self.i_1167 then self.m_1165 <- y0_1137) ;
       (if self.i_1167 then self.m_1141 <- FadFloat.make 0.) ;
       (let (x_1142:FadFloat.t) = self.m_1141 in
        let (x_1164:FadFloat.t) =
            if self.i_1167 then x_1142 else FadFloat.(-) x_1142  self.m_1162 in
        let (y0_1127:FadFloat.t) =
            params_1059.Wt_params.pitch.Wt_params.theta0 in
        (if self.i_1167 then self.m_1160 <- y0_1127) ;
        (let (x_1159:FadFloat.t) =
             if self.i_1167 then x_1142 else FadFloat.(-) x_1142  self.m_1157 in
         let (y0_1117:FadFloat.t) =
             FadFloat.( * ) params_1059.Wt_params.pitch.Wt_params.theta0 
                            (FadFloat.translate (FadFloat.(/) params_1059.Wt_params.pitch.Wt_params.theta0
                                                              
                                                              params_1059.Wt_params.pitch.Wt_params.cpc.Wt_params.gS_factor)
                                                 1.) in
         (if self.i_1167 then self.m_1155 <- y0_1117) ;
         (let (x_1154:FadFloat.t) =
              if self.i_1167
              then x_1142
              else FadFloat.(-) x_1142  self.m_1152 in
          (if self.i_1167 then
           self.m_1150 <- params_1059.Wt_params.pitch.Wt_params.theta0) ;
          (let (y0_1094:FadFloat.t) = params_1059.Wt_params.xt_dot0 in
           (if self.i_1167 then self.m_1148 <- y0_1094) ;
           (let (y0_1090:FadFloat.t) = params_1059.Wt_params.omega0 in
            (if self.i_1167 then self.m_1146 <- y0_1090) ;
            (let (x_1145:FadFloat.t) =
                 if self.i_1167
                 then x_1142
                 else FadFloat.(-) x_1142  self.m_1143 in
             (if self.i_1167 then
              self.tstep'_1051 <- FadFloat.make tstep_1040) ;
             (if self.i_1167 then self.m_1139 <- self.tstep'_1051) ;
             self.i_1167 <- false ;
             (let (x_1161:FadFloat.t) = self.m_1160 in
              let (theta_1049:FadFloat.t) = Wt_common.rad2deg x_1161 in
              let (x_1147:FadFloat.t) = self.m_1146 in
              let (omega_1044:FadFloat.t) = Wt_common.radPs2rpm x_1147 in
              let (x_1166:FadFloat.t) = self.m_1165 in
              let (omega_g_1045:FadFloat.t) = Wt_common.radPs2rpm x_1166 in
              let (x_1151:FadFloat.t) = self.m_1150 in
              let (gs_1102:FadFloat.t) =
                  FadFloat.inv (FadFloat.translate (FadFloat.(/) x_1151 
                                                                 params_1059.Wt_params.pitch.Wt_params.cpc.Wt_params.gS_factor)
                                                    1.) in
              let (omega_g_rated_1097:FadFloat.t) =
                  params_1059.Wt_params.omega_g_rated in
              let (e_1101:FadFloat.t) =
                  FadFloat.(-) x_1166  omega_g_rated_1097 in
              let (e1_1108:FadFloat.t) =
                  FadFloat.( * ) e_1101 
                                 params_1059.Wt_params.pitch.Wt_params.cpc.Wt_params.kP in
              let (x_1156:FadFloat.t) = self.m_1155 in
              let (e4_1111:FadFloat.t) = FadFloat.(+) e1_1108  x_1156 in
              let (theta_d'_1113:FadFloat.t) =
                  FadFloat.( * ) gs_1102  e4_1111 in
              let (theta_d_1112:FadFloat.t) =
                  Wt_d.saturate (params_1059.Wt_params.pitch.Wt_params.min ,
                                 params_1059.Wt_params.pitch.Wt_params.max ,
                                 theta_d'_1113) in
              let (theta_d_1062:FadFloat.t) =
                  i_1196_step self.i_1196
                    (x_1142 ,
                     params_1059.Wt_params.pitch.Wt_params.rateLimit ,
                     (FadFloat.(~-) params_1059.Wt_params.pitch.Wt_params.rateLimit)
                     ,
                     params_1059.Wt_params.pitch.Wt_params.thetaDot0 ,
                     theta_d_1112) in
              let (theta_d_1050:FadFloat.t) = Wt_common.rad2deg theta_d_1062 in
              let (blade_pitch_angle_1072:FadFloat.t) =
                  i_1195_step self.i_1195
                    (x_1142 ,
                     params_1059.Wt_params.pitch.Wt_params.actuatorType ,
                     theta_d_1062 , params_1059) in
              let (blade_pitch_angle_1041:FadFloat.t) =
                  Wt_common.rad2deg blade_pitch_angle_1072 in
              let (mg_d_1056:FadFloat.t) =
                  Wt_d.torque_controller (x_1166 , theta_d_1062 , params_1059) in
              let (outp_1046:(FadFloat.t)Array.t) =
                  Array.of_list ((::) (theta_1049 ,
                                       ((::) (omega_1044 ,
                                              ((::) (omega_g_1045 ,
                                                     ((::) (theta_d_1050 ,
                                                            ((::) (blade_pitch_angle_1041
                                                                   ,
                                                                   ((::) 
                                                                    (
                                                                    mg_d_1056
                                                                    , 
                                                                    ([]))))))))))))) in
              let (rob_1047:FadFloat.t) =
                  i_1194_step self.i_1194 (self.tstep'_1051 , outp_1046) in
              let (u_1131:FadFloat.t) =
                  FadFloat.(/) x_1147  params_1059.Wt_params.gBRatio in
              let (dy_1132:FadFloat.t) =
                  FadFloat.(/) (FadFloat.(-) u_1131  x_1166) 
                               params_1059.Wt_params.vscontrol.Wt_params.vs_filterConstant in
              self.m_1165 <- FadFloat.(+) (FadFloat.( * ) dy_1132  x_1164) 
                                          x_1166 ;
              self.m_1162 <- x_1142 ;
              (let (dy_1122:FadFloat.t) =
                   FadFloat.(/) (FadFloat.(-) blade_pitch_angle_1072  x_1161)
                                
                                params_1059.Wt_params.pitch.Wt_params.pitch_filterConstant in
               self.m_1160 <- FadFloat.(+) (FadFloat.( * ) dy_1122  x_1159) 
                                           x_1161 ;
               self.m_1157 <- x_1142 ;
               (let (e2_1109:FadFloat.t) =
                    FadFloat.(-) e1_1108 
                                 (FadFloat.( * ) (FadFloat.(-) theta_d'_1113 
                                                               theta_d_1112) 
                                                 params_1059.Wt_params.pitch.Wt_params.cpc.Wt_params.antiWindUp) in
                let (x_1116:FadFloat.t) =
                    FadFloat.(/) e2_1109 
                                 params_1059.Wt_params.pitch.Wt_params.cpc.Wt_params.tI in
                self.m_1155 <- FadFloat.(+) (FadFloat.( * ) x_1116  x_1154) 
                                            x_1156 ;
                self.m_1152 <- x_1142 ;
                self.m_1150 <- blade_pitch_angle_1072 ;
                (let (x_1149:FadFloat.t) = self.m_1148 in
                 let ((ma_1074:FadFloat.t) , (fa_1073:FadFloat.t)) =
                     i_1193_step self.i_1193
                       (v0_1052 ,
                        blade_pitch_angle_1072 ,
                        x_1147 , x_1149 , params_1059) in
                 let (xT_1086:FadFloat.t) =
                     i_1192_step self.i_1192
                       (x_1145 , x_1149 , params_1059.Wt_params.xT0) in
                 let (dxT_dot_1083:FadFloat.t) =
                     FadFloat.(/) (FadFloat.(-) (FadFloat.(-) fa_1073 
                                                              (FadFloat.( * ) 
                                                                 x_1149 
                                                                 params_1059.Wt_params.cTe))
                                                
                                                (FadFloat.( * ) (FadFloat.(-) 
                                                                   xT_1086 
                                                                   params_1059.Wt_params.xT0)
                                                                
                                                                params_1059.Wt_params.kTe))
                                   params_1059.Wt_params.mTe in
                 self.m_1148 <- FadFloat.(+) (FadFloat.( * ) dxT_dot_1083 
                                                             x_1145)  
                                             x_1149 ;
                 (let (torque_aux_1065:FadFloat.t) =
                      i_1191_step self.i_1191
                        (x_1142 ,
                         params_1059.Wt_params.vscontrol.Wt_params.maxRat ,
                         (FadFloat.(~-) params_1059.Wt_params.vscontrol.Wt_params.maxRat)
                         , (FadFloat.make 0.) , mg_d_1056) in
                  let (torque_1064:FadFloat.t) =
                      Wt_d.saturate (FadFloat.neg_infinity ,
                                     params_1059.Wt_params.vscontrol.Wt_params.maxTq
                                     , torque_aux_1065) in
                  let (domega_1082:FadFloat.t) =
                      FadFloat.(/) (FadFloat.(-) ma_1074 
                                                 (FadFloat.(/) torque_1064 
                                                               params_1059.Wt_params.gBRatio))
                                    params_1059.Wt_params.inertia in
                  self.m_1146 <- FadFloat.(+) (FadFloat.( * ) domega_1082 
                                                              x_1145)  
                                              x_1147 ;
                  self.m_1143 <- x_1142 ;
                  (let (x_1140:FadFloat.t) = self.m_1139 in
                   self.m_1141 <- x_1140 ;
                   self.m_1139 <- FadFloat.(+) x_1140  self.tstep'_1051 ;
                   ((FadFloat.get x_1140) , outp_1046 , rob_1047))))))))))))))):
    float * FadFloat.t Array.t * FadFloat.t) in
  Node { alloc = wt_wt4_alloc; reset = wt_wt4_reset ; step = wt_wt4_step }
