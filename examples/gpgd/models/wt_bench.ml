(* The Zélus compiler, version 2.1
  (jeudi 27 août 2020, 15:59:00 (UTC+0200)) *)
open Ztypes
open MyOp
open Discrete_obs_fad
type ('c , 'b , 'a) _wt1 =
  { mutable i_1168 : 'c ; mutable i_628 : 'b ; mutable m_626 : 'a }

let wt1  = 
  let Cnode { alloc = i_1168_alloc; copy = i_1168_copy ;
                                    step = i_1168_step ; reset = i_1168_reset } = 
  Discrete_obs_fad.always_timed 630.  in
  let wt1_alloc _ =
    ();
    { i_628 = (false:bool) ; m_626 = (create ():MyOp.t);
      i_1168 = i_1168_alloc () (* discrete *)  } in
  let wt1_copy source dest =
    dest.i_628 <- source.i_628 ; dest.m_626 <- source.m_626;
    i_1168_copy source.i_1168 dest.i_1168 (* discrete *) in
  let wt1_reset self  =
    ((self.i_628 <- true ; i_1168_reset self.i_1168 ):unit) in 
  let wt1_step self ((tstep_623:MyOp.t) , (outp_622:(MyOp.t)Array.t)) =
    (((if self.i_628 then self.m_626 <- MyOp.make 0.) ;
      self.i_628 <- false ;
      (let (x_627:MyOp.t) = self.m_626 in
       self.m_626 <- MyOp.(+) x_627  tstep_623 ;
       (let (blade_pitch_angle_625:MyOp.t) = Array.get outp_622  4 in
        i_1168_step self.i_1168
          (tstep_623 ,
           (Discrete_obs_fad.implies ((Discrete_obs_fad.q_ge (x_627 ,
                                                              (MyOp.make 30.)))
                                      ,
                                      (Discrete_obs_fad.q_le (blade_pitch_angle_625
                                                              ,
                                                              (MyOp.make 14.2))))))))):
    MyOp.t) in
  Cnode { alloc = wt1_alloc; copy = wt1_copy ;
                             reset = wt1_reset ; step = wt1_step }
type ('c , 'b , 'a) _wt2 =
  { mutable i_1169 : 'c ; mutable i_635 : 'b ; mutable m_633 : 'a }

let wt2  = 
  let Cnode { alloc = i_1169_alloc; copy = i_1169_copy ;
                                    step = i_1169_step ; reset = i_1169_reset } = 
  Discrete_obs_fad.always_timed 630.  in
  let wt2_alloc _ =
    ();
    { i_635 = (false:bool) ; m_633 = (create ():MyOp.t);
      i_1169 = i_1169_alloc () (* discrete *)  } in
  let wt2_copy source dest =
    dest.i_635 <- source.i_635 ; dest.m_633 <- source.m_633;
    i_1169_copy source.i_1169 dest.i_1169 (* discrete *) in
  let wt2_reset self  =
    ((self.i_635 <- true ; i_1169_reset self.i_1169 ):unit) in 
  let wt2_step self ((tstep_630:MyOp.t) , (outp_629:(MyOp.t)Array.t)) =
    (((if self.i_635 then self.m_633 <- MyOp.make 0.) ;
      self.i_635 <- false ;
      (let (x_634:MyOp.t) = self.m_633 in
       self.m_633 <- MyOp.(+) x_634  tstep_630 ;
       (let (mg_d_632:MyOp.t) = Array.get outp_629  5 in
        i_1169_step self.i_1169
          (tstep_630 ,
           (Discrete_obs_fad.implies ((Discrete_obs_fad.q_ge (x_634 ,
                                                              (MyOp.make 30.)))
                                      ,
                                      (Discrete_obs_fad.q_and ((Discrete_obs_fad.q_ge 
                                                                  (mg_d_632 ,
                                                                   (MyOp.make 
                                                                    21000.)))
                                                               ,
                                                               (Discrete_obs_fad.q_le 
                                                                  (mg_d_632 ,
                                                                   (MyOp.make 
                                                                    47500.))))))))))):
    MyOp.t) in
  Cnode { alloc = wt2_alloc; copy = wt2_copy ;
                             reset = wt2_reset ; step = wt2_step }
type ('c , 'b , 'a) _wt3 =
  { mutable i_1170 : 'c ; mutable i_642 : 'b ; mutable m_640 : 'a }

let wt3  = 
  let Cnode { alloc = i_1170_alloc; copy = i_1170_copy ;
                                    step = i_1170_step ; reset = i_1170_reset } = 
  Discrete_obs_fad.always_timed 630.  in
  let wt3_alloc _ =
    ();
    { i_642 = (false:bool) ; m_640 = (create ():MyOp.t);
      i_1170 = i_1170_alloc () (* discrete *)  } in
  let wt3_copy source dest =
    dest.i_642 <- source.i_642 ; dest.m_640 <- source.m_640;
    i_1170_copy source.i_1170 dest.i_1170 (* discrete *) in
  let wt3_reset self  =
    ((self.i_642 <- true ; i_1170_reset self.i_1170 ):unit) in 
  let wt3_step self ((tstep_637:MyOp.t) , (outp_636:(MyOp.t)Array.t)) =
    (((if self.i_642 then self.m_640 <- MyOp.make 0.) ;
      self.i_642 <- false ;
      (let (x_641:MyOp.t) = self.m_640 in
       self.m_640 <- MyOp.(+) x_641  tstep_637 ;
       (let (omega_639:MyOp.t) = Array.get outp_636  1 in
        i_1170_step self.i_1170
          (tstep_637 ,
           (Discrete_obs_fad.implies ((Discrete_obs_fad.q_ge (x_641 ,
                                                              (MyOp.make 30.)))
                                      ,
                                      (Discrete_obs_fad.q_le (omega_639 ,
                                                              (MyOp.make 14.3))))))))):
    MyOp.t) in
  Cnode { alloc = wt3_alloc; copy = wt3_copy ;
                             reset = wt3_reset ; step = wt3_step }
type ('d , 'c , 'b , 'a) _wt4 =
  { mutable i_1172 : 'd ;
    mutable i_1171 : 'c ; mutable i_651 : 'b ; mutable m_649 : 'a }

let wt4  = 
  let Cnode { alloc = i_1172_alloc; copy = i_1172_copy ;
                                    step = i_1172_step ; reset = i_1172_reset } = 
  Discrete_obs_fad.always_timed 630.  in 
  let Cnode { alloc = i_1171_alloc; copy = i_1171_copy ;
                                    step = i_1171_step ; reset = i_1171_reset } = 
  Discrete_obs_fad.bounded_recurrence 5.  in
  let wt4_alloc _ =
    ();
    { i_651 = (false:bool) ; m_649 = (create ():MyOp.t);
      i_1172 = i_1172_alloc () (* discrete *)  ;
      i_1171 = i_1171_alloc () (* discrete *)  } in
  let wt4_copy source dest =
    dest.i_651 <- source.i_651 ; dest.m_649 <- source.m_649;
    i_1172_copy source.i_1172 dest.i_1172 (* discrete *) ;
    i_1171_copy source.i_1171 dest.i_1171 (* discrete *) in
  let wt4_reset self  =
    ((self.i_651 <- true ;
      i_1172_reset self.i_1172  ; i_1171_reset self.i_1171 ):unit) in 
  let wt4_step self ((tstep_644:MyOp.t) , (outp_643:(MyOp.t)Array.t)) =
    (((if self.i_651 then self.m_649 <- MyOp.make 0.) ;
      self.i_651 <- false ;
      (let (x_650:MyOp.t) = self.m_649 in
       self.m_649 <- MyOp.(+) x_650  tstep_644 ;
       (let (theta_d_646:MyOp.t) = Array.get outp_643  3 in
        let (blade_pitch_angle_647:MyOp.t) = Array.get outp_643  4 in
        let (dif_648:MyOp.t) =
            Discrete_obs_fad.abs (MyOp.(-) blade_pitch_angle_647  theta_d_646) in
        i_1172_step self.i_1172
          (tstep_644 ,
           (Discrete_obs_fad.implies ((Discrete_obs_fad.q_ge (x_650 ,
                                                              (MyOp.make 35.)))
                                      ,
                                      (i_1171_step self.i_1171
                                         (tstep_644 ,
                                          (Discrete_obs_fad.q_le (dif_648 ,
                                                                  (MyOp.make 
                                                                    1.6))))))))))):
    MyOp.t) in
  Cnode { alloc = wt4_alloc; copy = wt4_copy ;
                             reset = wt4_reset ; step = wt4_step }
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
  let Cnode { alloc = i_1178_alloc; copy = i_1178_copy ;
                                    step = i_1178_step ; reset = i_1178_reset } = Wt_d.rate_limiter 
   in 
  let Cnode { alloc = i_1177_alloc; copy = i_1177_copy ;
                                    step = i_1177_step ; reset = i_1177_reset } = Wt_d.pitch_actuator_subsystem 
   in 
  let Cnode { alloc = i_1176_alloc; copy = i_1176_copy ;
                                    step = i_1176_step ; reset = i_1176_reset } = wt1 
   in 
  let Cnode { alloc = i_1175_alloc; copy = i_1175_copy ;
                                    step = i_1175_step ; reset = i_1175_reset } = Wt_d.aero_elastic_subsystem 
   in 
  let Cnode { alloc = i_1174_alloc; copy = i_1174_copy ;
                                    step = i_1174_step ; reset = i_1174_reset } = Wt_common.integrate 
   in 
  let Cnode { alloc = i_1173_alloc; copy = i_1173_copy ;
                                    step = i_1173_step ; reset = i_1173_reset } = Wt_d.rate_limiter 
   in
  let wt_wt1_alloc _ =
    ();
    { i_780 = (false:bool) ;
      m_778 = (create ():MyOp.t) ;
      m_775 = (create ():MyOp.t) ;
      m_773 = (create ():MyOp.t) ;
      m_770 = (create ():MyOp.t) ;
      m_768 = (create ():MyOp.t) ;
      m_765 = (create ():MyOp.t) ;
      m_763 = (create ():MyOp.t) ;
      m_761 = (create ():MyOp.t) ;
      m_759 = (create ():MyOp.t) ;
      m_756 = (create ():MyOp.t) ;
      m_754 = (create ():MyOp.t) ;
      m_752 = (create ():MyOp.t) ;
      v0_0_679 = (create ():MyOp.t) ; tstep'_664 = (create ():MyOp.t);
      i_1178 = i_1178_alloc () (* discrete *)  ;
      i_1177 = i_1177_alloc () (* discrete *)  ;
      i_1176 = i_1176_alloc () (* discrete *)  ;
      i_1175 = i_1175_alloc () (* discrete *)  ;
      i_1174 = i_1174_alloc () (* discrete *)  ;
      i_1173 = i_1173_alloc () (* discrete *)  } in
  let wt_wt1_copy source dest =
    dest.i_780 <- source.i_780 ;
    dest.m_778 <- source.m_778 ;
    dest.m_775 <- source.m_775 ;
    dest.m_773 <- source.m_773 ;
    dest.m_770 <- source.m_770 ;
    dest.m_768 <- source.m_768 ;
    dest.m_765 <- source.m_765 ;
    dest.m_763 <- source.m_763 ;
    dest.m_761 <- source.m_761 ;
    dest.m_759 <- source.m_759 ;
    dest.m_756 <- source.m_756 ;
    dest.m_754 <- source.m_754 ;
    dest.m_752 <- source.m_752 ;
    dest.v0_0_679 <- source.v0_0_679 ; dest.tstep'_664 <- source.tstep'_664;
    i_1178_copy source.i_1178 dest.i_1178 (* discrete *) ;
    i_1177_copy source.i_1177 dest.i_1177 (* discrete *) ;
    i_1176_copy source.i_1176 dest.i_1176 (* discrete *) ;
    i_1175_copy source.i_1175 dest.i_1175 (* discrete *) ;
    i_1174_copy source.i_1174 dest.i_1174 (* discrete *) ;
    i_1173_copy source.i_1173 dest.i_1173 (* discrete *) in
  let wt_wt1_reset self  =
    ((self.i_780 <- true ;
      i_1178_reset self.i_1178  ;
      i_1177_reset self.i_1177  ;
      i_1176_reset self.i_1176  ;
      i_1175_reset self.i_1175  ;
      i_1174_reset self.i_1174  ; i_1173_reset self.i_1173 ):unit) in 
  let wt_wt1_step self (inp_652:(MyOp.t)Array.t) =
    ((let (v0_665:MyOp.t) = Array.get inp_652  0 in
      (if self.i_780 then self.v0_0_679 <- v0_665) ;
      (let (params_672:Wt_params.params) =
           Wt_params.get_default self.v0_0_679 in
       let (y0_750:MyOp.t) = params_672.Wt_params.omega_g0 in
       (if self.i_780 then self.m_778 <- y0_750) ;
       (if self.i_780 then self.m_754 <- MyOp.make 0.) ;
       (let (x_755:MyOp.t) = self.m_754 in
        let (x_777:MyOp.t) =
            if self.i_780 then x_755 else MyOp.(-) x_755  self.m_775 in
        let (y0_740:MyOp.t) = params_672.Wt_params.pitch.Wt_params.theta0 in
        (if self.i_780 then self.m_773 <- y0_740) ;
        (let (x_772:MyOp.t) =
             if self.i_780 then x_755 else MyOp.(-) x_755  self.m_770 in
         let (y0_730:MyOp.t) =
             MyOp.( * ) params_672.Wt_params.pitch.Wt_params.theta0 
                        (MyOp.translate (MyOp.(/) params_672.Wt_params.pitch.Wt_params.theta0
                                                  
                                                  params_672.Wt_params.pitch.Wt_params.cpc.Wt_params.gS_factor)
                                         1.) in
         (if self.i_780 then self.m_768 <- y0_730) ;
         (let (x_767:MyOp.t) =
              if self.i_780 then x_755 else MyOp.(-) x_755  self.m_765 in
          (if self.i_780 then
           self.m_763 <- params_672.Wt_params.pitch.Wt_params.theta0) ;
          (let (y0_707:MyOp.t) = params_672.Wt_params.xt_dot0 in
           (if self.i_780 then self.m_761 <- y0_707) ;
           (let (y0_703:MyOp.t) = params_672.Wt_params.omega0 in
            (if self.i_780 then self.m_759 <- y0_703) ;
            (let (x_758:MyOp.t) =
                 if self.i_780 then x_755 else MyOp.(-) x_755  self.m_756 in
             (if self.i_780 then self.tstep'_664 <- MyOp.make tstep_653) ;
             (if self.i_780 then self.m_752 <- self.tstep'_664) ;
             self.i_780 <- false ;
             (let (x_774:MyOp.t) = self.m_773 in
              let (theta_662:MyOp.t) = Wt_common.rad2deg x_774 in
              let (x_760:MyOp.t) = self.m_759 in
              let (omega_657:MyOp.t) = Wt_common.radPs2rpm x_760 in
              let (x_779:MyOp.t) = self.m_778 in
              let (omega_g_658:MyOp.t) = Wt_common.radPs2rpm x_779 in
              let (x_764:MyOp.t) = self.m_763 in
              let (gs_715:MyOp.t) =
                  MyOp.inv (MyOp.translate (MyOp.(/) x_764 
                                                     params_672.Wt_params.pitch.Wt_params.cpc.Wt_params.gS_factor)
                                            1.) in
              let (omega_g_rated_710:MyOp.t) =
                  params_672.Wt_params.omega_g_rated in
              let (e_714:MyOp.t) = MyOp.(-) x_779  omega_g_rated_710 in
              let (e1_721:MyOp.t) =
                  MyOp.( * ) e_714 
                             params_672.Wt_params.pitch.Wt_params.cpc.Wt_params.kP in
              let (x_769:MyOp.t) = self.m_768 in
              let (e4_724:MyOp.t) = MyOp.(+) e1_721  x_769 in
              let (theta_d'_726:MyOp.t) = MyOp.( * ) gs_715  e4_724 in
              let (theta_d_725:MyOp.t) =
                  Wt_d.saturate (params_672.Wt_params.pitch.Wt_params.min ,
                                 params_672.Wt_params.pitch.Wt_params.max ,
                                 theta_d'_726) in
              let (theta_d_675:MyOp.t) =
                  i_1178_step self.i_1178
                    (x_755 ,
                     params_672.Wt_params.pitch.Wt_params.rateLimit ,
                     (MyOp.(~-) params_672.Wt_params.pitch.Wt_params.rateLimit)
                     ,
                     params_672.Wt_params.pitch.Wt_params.thetaDot0 ,
                     theta_d_725) in
              let (theta_d_663:MyOp.t) = Wt_common.rad2deg theta_d_675 in
              let (blade_pitch_angle_685:MyOp.t) =
                  i_1177_step self.i_1177
                    (x_755 ,
                     params_672.Wt_params.pitch.Wt_params.actuatorType ,
                     theta_d_675 , params_672) in
              let (blade_pitch_angle_654:MyOp.t) =
                  Wt_common.rad2deg blade_pitch_angle_685 in
              let (mg_d_669:MyOp.t) =
                  Wt_d.torque_controller (x_779 , theta_d_675 , params_672) in
              let (outp_659:(MyOp.t)Array.t) =
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
              let (rob_660:MyOp.t) =
                  i_1176_step self.i_1176 (self.tstep'_664 , outp_659) in
              let (u_744:MyOp.t) =
                  MyOp.(/) x_760  params_672.Wt_params.gBRatio in
              let (dy_745:MyOp.t) =
                  MyOp.(/) (MyOp.(-) u_744  x_779) 
                           params_672.Wt_params.vscontrol.Wt_params.vs_filterConstant in
              self.m_778 <- MyOp.(+) (MyOp.( * ) dy_745  x_777)  x_779 ;
              self.m_775 <- x_755 ;
              (let (dy_735:MyOp.t) =
                   MyOp.(/) (MyOp.(-) blade_pitch_angle_685  x_774) 
                            params_672.Wt_params.pitch.Wt_params.pitch_filterConstant in
               self.m_773 <- MyOp.(+) (MyOp.( * ) dy_735  x_772)  x_774 ;
               self.m_770 <- x_755 ;
               (let (e2_722:MyOp.t) =
                    MyOp.(-) e1_721 
                             (MyOp.( * ) (MyOp.(-) theta_d'_726  theta_d_725)
                                         
                                         params_672.Wt_params.pitch.Wt_params.cpc.Wt_params.antiWindUp) in
                let (x_729:MyOp.t) =
                    MyOp.(/) e2_722 
                             params_672.Wt_params.pitch.Wt_params.cpc.Wt_params.tI in
                self.m_768 <- MyOp.(+) (MyOp.( * ) x_729  x_767)  x_769 ;
                self.m_765 <- x_755 ;
                self.m_763 <- blade_pitch_angle_685 ;
                (let (x_762:MyOp.t) = self.m_761 in
                 let ((ma_687:MyOp.t) , (fa_686:MyOp.t)) =
                     i_1175_step self.i_1175
                       (v0_665 ,
                        blade_pitch_angle_685 , x_760 , x_762 , params_672) in
                 let (xT_699:MyOp.t) =
                     i_1174_step self.i_1174
                       (x_758 , x_762 , params_672.Wt_params.xT0) in
                 let (dxT_dot_696:MyOp.t) =
                     MyOp.(/) (MyOp.(-) (MyOp.(-) fa_686 
                                                  (MyOp.( * ) x_762 
                                                              params_672.Wt_params.cTe))
                                        
                                        (MyOp.( * ) (MyOp.(-) xT_699 
                                                              params_672.Wt_params.xT0)
                                                     params_672.Wt_params.kTe))
                               params_672.Wt_params.mTe in
                 self.m_761 <- MyOp.(+) (MyOp.( * ) dxT_dot_696  x_758) 
                                        x_762 ;
                 (let (torque_aux_678:MyOp.t) =
                      i_1173_step self.i_1173
                        (x_755 ,
                         params_672.Wt_params.vscontrol.Wt_params.maxRat ,
                         (MyOp.(~-) params_672.Wt_params.vscontrol.Wt_params.maxRat)
                         , (MyOp.make 0.) , mg_d_669) in
                  let (torque_677:MyOp.t) =
                      Wt_d.saturate (MyOp.neg_infinity ,
                                     params_672.Wt_params.vscontrol.Wt_params.maxTq
                                     , torque_aux_678) in
                  let (domega_695:MyOp.t) =
                      MyOp.(/) (MyOp.(-) ma_687 
                                         (MyOp.(/) torque_677 
                                                   params_672.Wt_params.gBRatio))
                                params_672.Wt_params.inertia in
                  self.m_759 <- MyOp.(+) (MyOp.( * ) domega_695  x_758) 
                                         x_760 ;
                  self.m_756 <- x_755 ;
                  (let (x_753:MyOp.t) = self.m_752 in
                   self.m_754 <- x_753 ;
                   self.m_752 <- MyOp.(+) x_753  self.tstep'_664 ;
                   ((MyOp.get x_753) ,
                    outp_659 , (MyOp.translate rob_660  0.1)))))))))))))))):
    float * MyOp.t Array.t * MyOp.t) in
  Cnode { alloc = wt_wt1_alloc; copy = wt_wt1_copy ;
                                reset = wt_wt1_reset ; step = wt_wt1_step }
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
  let Cnode { alloc = i_1184_alloc; copy = i_1184_copy ;
                                    step = i_1184_step ; reset = i_1184_reset } = Wt_d.rate_limiter 
   in 
  let Cnode { alloc = i_1183_alloc; copy = i_1183_copy ;
                                    step = i_1183_step ; reset = i_1183_reset } = Wt_d.pitch_actuator_subsystem 
   in 
  let Cnode { alloc = i_1182_alloc; copy = i_1182_copy ;
                                    step = i_1182_step ; reset = i_1182_reset } = wt2 
   in 
  let Cnode { alloc = i_1181_alloc; copy = i_1181_copy ;
                                    step = i_1181_step ; reset = i_1181_reset } = Wt_d.aero_elastic_subsystem 
   in 
  let Cnode { alloc = i_1180_alloc; copy = i_1180_copy ;
                                    step = i_1180_step ; reset = i_1180_reset } = Wt_common.integrate 
   in 
  let Cnode { alloc = i_1179_alloc; copy = i_1179_copy ;
                                    step = i_1179_step ; reset = i_1179_reset } = Wt_d.rate_limiter 
   in
  let wt_wt2_alloc _ =
    ();
    { i_909 = (false:bool) ;
      m_907 = (create ():MyOp.t) ;
      m_904 = (create ():MyOp.t) ;
      m_902 = (create ():MyOp.t) ;
      m_899 = (create ():MyOp.t) ;
      m_897 = (create ():MyOp.t) ;
      m_894 = (create ():MyOp.t) ;
      m_892 = (create ():MyOp.t) ;
      m_890 = (create ():MyOp.t) ;
      m_888 = (create ():MyOp.t) ;
      m_885 = (create ():MyOp.t) ;
      m_883 = (create ():MyOp.t) ;
      m_881 = (create ():MyOp.t) ;
      v0_0_808 = (create ():MyOp.t) ; tstep'_793 = (create ():MyOp.t);
      i_1184 = i_1184_alloc () (* discrete *)  ;
      i_1183 = i_1183_alloc () (* discrete *)  ;
      i_1182 = i_1182_alloc () (* discrete *)  ;
      i_1181 = i_1181_alloc () (* discrete *)  ;
      i_1180 = i_1180_alloc () (* discrete *)  ;
      i_1179 = i_1179_alloc () (* discrete *)  } in
  let wt_wt2_copy source dest =
    dest.i_909 <- source.i_909 ;
    dest.m_907 <- source.m_907 ;
    dest.m_904 <- source.m_904 ;
    dest.m_902 <- source.m_902 ;
    dest.m_899 <- source.m_899 ;
    dest.m_897 <- source.m_897 ;
    dest.m_894 <- source.m_894 ;
    dest.m_892 <- source.m_892 ;
    dest.m_890 <- source.m_890 ;
    dest.m_888 <- source.m_888 ;
    dest.m_885 <- source.m_885 ;
    dest.m_883 <- source.m_883 ;
    dest.m_881 <- source.m_881 ;
    dest.v0_0_808 <- source.v0_0_808 ; dest.tstep'_793 <- source.tstep'_793;
    i_1184_copy source.i_1184 dest.i_1184 (* discrete *) ;
    i_1183_copy source.i_1183 dest.i_1183 (* discrete *) ;
    i_1182_copy source.i_1182 dest.i_1182 (* discrete *) ;
    i_1181_copy source.i_1181 dest.i_1181 (* discrete *) ;
    i_1180_copy source.i_1180 dest.i_1180 (* discrete *) ;
    i_1179_copy source.i_1179 dest.i_1179 (* discrete *) in
  let wt_wt2_reset self  =
    ((self.i_909 <- true ;
      i_1184_reset self.i_1184  ;
      i_1183_reset self.i_1183  ;
      i_1182_reset self.i_1182  ;
      i_1181_reset self.i_1181  ;
      i_1180_reset self.i_1180  ; i_1179_reset self.i_1179 ):unit) in 
  let wt_wt2_step self (inp_781:(MyOp.t)Array.t) =
    ((let (v0_794:MyOp.t) = Array.get inp_781  0 in
      (if self.i_909 then self.v0_0_808 <- v0_794) ;
      (let (params_801:Wt_params.params) =
           Wt_params.get_default self.v0_0_808 in
       let (y0_879:MyOp.t) = params_801.Wt_params.omega_g0 in
       (if self.i_909 then self.m_907 <- y0_879) ;
       (if self.i_909 then self.m_883 <- MyOp.make 0.) ;
       (let (x_884:MyOp.t) = self.m_883 in
        let (x_906:MyOp.t) =
            if self.i_909 then x_884 else MyOp.(-) x_884  self.m_904 in
        let (y0_869:MyOp.t) = params_801.Wt_params.pitch.Wt_params.theta0 in
        (if self.i_909 then self.m_902 <- y0_869) ;
        (let (x_901:MyOp.t) =
             if self.i_909 then x_884 else MyOp.(-) x_884  self.m_899 in
         let (y0_859:MyOp.t) =
             MyOp.( * ) params_801.Wt_params.pitch.Wt_params.theta0 
                        (MyOp.translate (MyOp.(/) params_801.Wt_params.pitch.Wt_params.theta0
                                                  
                                                  params_801.Wt_params.pitch.Wt_params.cpc.Wt_params.gS_factor)
                                         1.) in
         (if self.i_909 then self.m_897 <- y0_859) ;
         (let (x_896:MyOp.t) =
              if self.i_909 then x_884 else MyOp.(-) x_884  self.m_894 in
          (if self.i_909 then
           self.m_892 <- params_801.Wt_params.pitch.Wt_params.theta0) ;
          (let (y0_836:MyOp.t) = params_801.Wt_params.xt_dot0 in
           (if self.i_909 then self.m_890 <- y0_836) ;
           (let (y0_832:MyOp.t) = params_801.Wt_params.omega0 in
            (if self.i_909 then self.m_888 <- y0_832) ;
            (let (x_887:MyOp.t) =
                 if self.i_909 then x_884 else MyOp.(-) x_884  self.m_885 in
             (if self.i_909 then self.tstep'_793 <- MyOp.make tstep_782) ;
             (if self.i_909 then self.m_881 <- self.tstep'_793) ;
             self.i_909 <- false ;
             (let (x_903:MyOp.t) = self.m_902 in
              let (theta_791:MyOp.t) = Wt_common.rad2deg x_903 in
              let (x_889:MyOp.t) = self.m_888 in
              let (omega_786:MyOp.t) = Wt_common.radPs2rpm x_889 in
              let (x_908:MyOp.t) = self.m_907 in
              let (omega_g_787:MyOp.t) = Wt_common.radPs2rpm x_908 in
              let (x_893:MyOp.t) = self.m_892 in
              let (gs_844:MyOp.t) =
                  MyOp.inv (MyOp.translate (MyOp.(/) x_893 
                                                     params_801.Wt_params.pitch.Wt_params.cpc.Wt_params.gS_factor)
                                            1.) in
              let (omega_g_rated_839:MyOp.t) =
                  params_801.Wt_params.omega_g_rated in
              let (e_843:MyOp.t) = MyOp.(-) x_908  omega_g_rated_839 in
              let (e1_850:MyOp.t) =
                  MyOp.( * ) e_843 
                             params_801.Wt_params.pitch.Wt_params.cpc.Wt_params.kP in
              let (x_898:MyOp.t) = self.m_897 in
              let (e4_853:MyOp.t) = MyOp.(+) e1_850  x_898 in
              let (theta_d'_855:MyOp.t) = MyOp.( * ) gs_844  e4_853 in
              let (theta_d_854:MyOp.t) =
                  Wt_d.saturate (params_801.Wt_params.pitch.Wt_params.min ,
                                 params_801.Wt_params.pitch.Wt_params.max ,
                                 theta_d'_855) in
              let (theta_d_804:MyOp.t) =
                  i_1184_step self.i_1184
                    (x_884 ,
                     params_801.Wt_params.pitch.Wt_params.rateLimit ,
                     (MyOp.(~-) params_801.Wt_params.pitch.Wt_params.rateLimit)
                     ,
                     params_801.Wt_params.pitch.Wt_params.thetaDot0 ,
                     theta_d_854) in
              let (theta_d_792:MyOp.t) = Wt_common.rad2deg theta_d_804 in
              let (blade_pitch_angle_814:MyOp.t) =
                  i_1183_step self.i_1183
                    (x_884 ,
                     params_801.Wt_params.pitch.Wt_params.actuatorType ,
                     theta_d_804 , params_801) in
              let (blade_pitch_angle_783:MyOp.t) =
                  Wt_common.rad2deg blade_pitch_angle_814 in
              let (mg_d_798:MyOp.t) =
                  Wt_d.torque_controller (x_908 , theta_d_804 , params_801) in
              let (outp_788:(MyOp.t)Array.t) =
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
              let (rob_789:MyOp.t) =
                  i_1182_step self.i_1182 (self.tstep'_793 , outp_788) in
              let (u_873:MyOp.t) =
                  MyOp.(/) x_889  params_801.Wt_params.gBRatio in
              let (dy_874:MyOp.t) =
                  MyOp.(/) (MyOp.(-) u_873  x_908) 
                           params_801.Wt_params.vscontrol.Wt_params.vs_filterConstant in
              self.m_907 <- MyOp.(+) (MyOp.( * ) dy_874  x_906)  x_908 ;
              self.m_904 <- x_884 ;
              (let (dy_864:MyOp.t) =
                   MyOp.(/) (MyOp.(-) blade_pitch_angle_814  x_903) 
                            params_801.Wt_params.pitch.Wt_params.pitch_filterConstant in
               self.m_902 <- MyOp.(+) (MyOp.( * ) dy_864  x_901)  x_903 ;
               self.m_899 <- x_884 ;
               (let (e2_851:MyOp.t) =
                    MyOp.(-) e1_850 
                             (MyOp.( * ) (MyOp.(-) theta_d'_855  theta_d_854)
                                         
                                         params_801.Wt_params.pitch.Wt_params.cpc.Wt_params.antiWindUp) in
                let (x_858:MyOp.t) =
                    MyOp.(/) e2_851 
                             params_801.Wt_params.pitch.Wt_params.cpc.Wt_params.tI in
                self.m_897 <- MyOp.(+) (MyOp.( * ) x_858  x_896)  x_898 ;
                self.m_894 <- x_884 ;
                self.m_892 <- blade_pitch_angle_814 ;
                (let (x_891:MyOp.t) = self.m_890 in
                 let ((ma_816:MyOp.t) , (fa_815:MyOp.t)) =
                     i_1181_step self.i_1181
                       (v0_794 ,
                        blade_pitch_angle_814 , x_889 , x_891 , params_801) in
                 let (xT_828:MyOp.t) =
                     i_1180_step self.i_1180
                       (x_887 , x_891 , params_801.Wt_params.xT0) in
                 let (dxT_dot_825:MyOp.t) =
                     MyOp.(/) (MyOp.(-) (MyOp.(-) fa_815 
                                                  (MyOp.( * ) x_891 
                                                              params_801.Wt_params.cTe))
                                        
                                        (MyOp.( * ) (MyOp.(-) xT_828 
                                                              params_801.Wt_params.xT0)
                                                     params_801.Wt_params.kTe))
                               params_801.Wt_params.mTe in
                 self.m_890 <- MyOp.(+) (MyOp.( * ) dxT_dot_825  x_887) 
                                        x_891 ;
                 (let (torque_aux_807:MyOp.t) =
                      i_1179_step self.i_1179
                        (x_884 ,
                         params_801.Wt_params.vscontrol.Wt_params.maxRat ,
                         (MyOp.(~-) params_801.Wt_params.vscontrol.Wt_params.maxRat)
                         , (MyOp.make 0.) , mg_d_798) in
                  let (torque_806:MyOp.t) =
                      Wt_d.saturate (MyOp.neg_infinity ,
                                     params_801.Wt_params.vscontrol.Wt_params.maxTq
                                     , torque_aux_807) in
                  let (domega_824:MyOp.t) =
                      MyOp.(/) (MyOp.(-) ma_816 
                                         (MyOp.(/) torque_806 
                                                   params_801.Wt_params.gBRatio))
                                params_801.Wt_params.inertia in
                  self.m_888 <- MyOp.(+) (MyOp.( * ) domega_824  x_887) 
                                         x_889 ;
                  self.m_885 <- x_884 ;
                  (let (x_882:MyOp.t) = self.m_881 in
                   self.m_883 <- x_882 ;
                   self.m_881 <- MyOp.(+) x_882  self.tstep'_793 ;
                   ((MyOp.get x_882) , outp_788 , rob_789))))))))))))))):
    float * MyOp.t Array.t * MyOp.t) in
  Cnode { alloc = wt_wt2_alloc; copy = wt_wt2_copy ;
                                reset = wt_wt2_reset ; step = wt_wt2_step }
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
  let Cnode { alloc = i_1190_alloc; copy = i_1190_copy ;
                                    step = i_1190_step ; reset = i_1190_reset } = Wt_d.rate_limiter 
   in 
  let Cnode { alloc = i_1189_alloc; copy = i_1189_copy ;
                                    step = i_1189_step ; reset = i_1189_reset } = Wt_d.pitch_actuator_subsystem 
   in 
  let Cnode { alloc = i_1188_alloc; copy = i_1188_copy ;
                                    step = i_1188_step ; reset = i_1188_reset } = wt3 
   in 
  let Cnode { alloc = i_1187_alloc; copy = i_1187_copy ;
                                    step = i_1187_step ; reset = i_1187_reset } = Wt_d.aero_elastic_subsystem 
   in 
  let Cnode { alloc = i_1186_alloc; copy = i_1186_copy ;
                                    step = i_1186_step ; reset = i_1186_reset } = Wt_common.integrate 
   in 
  let Cnode { alloc = i_1185_alloc; copy = i_1185_copy ;
                                    step = i_1185_step ; reset = i_1185_reset } = Wt_d.rate_limiter 
   in
  let wt_wt3_alloc _ =
    ();
    { i_1038 = (false:bool) ;
      m_1036 = (create ():MyOp.t) ;
      m_1033 = (create ():MyOp.t) ;
      m_1031 = (create ():MyOp.t) ;
      m_1028 = (create ():MyOp.t) ;
      m_1026 = (create ():MyOp.t) ;
      m_1023 = (create ():MyOp.t) ;
      m_1021 = (create ():MyOp.t) ;
      m_1019 = (create ():MyOp.t) ;
      m_1017 = (create ():MyOp.t) ;
      m_1014 = (create ():MyOp.t) ;
      m_1012 = (create ():MyOp.t) ;
      m_1010 = (create ():MyOp.t) ;
      v0_0_937 = (create ():MyOp.t) ; tstep'_922 = (create ():MyOp.t);
      i_1190 = i_1190_alloc () (* discrete *)  ;
      i_1189 = i_1189_alloc () (* discrete *)  ;
      i_1188 = i_1188_alloc () (* discrete *)  ;
      i_1187 = i_1187_alloc () (* discrete *)  ;
      i_1186 = i_1186_alloc () (* discrete *)  ;
      i_1185 = i_1185_alloc () (* discrete *)  } in
  let wt_wt3_copy source dest =
    dest.i_1038 <- source.i_1038 ;
    dest.m_1036 <- source.m_1036 ;
    dest.m_1033 <- source.m_1033 ;
    dest.m_1031 <- source.m_1031 ;
    dest.m_1028 <- source.m_1028 ;
    dest.m_1026 <- source.m_1026 ;
    dest.m_1023 <- source.m_1023 ;
    dest.m_1021 <- source.m_1021 ;
    dest.m_1019 <- source.m_1019 ;
    dest.m_1017 <- source.m_1017 ;
    dest.m_1014 <- source.m_1014 ;
    dest.m_1012 <- source.m_1012 ;
    dest.m_1010 <- source.m_1010 ;
    dest.v0_0_937 <- source.v0_0_937 ; dest.tstep'_922 <- source.tstep'_922;
    i_1190_copy source.i_1190 dest.i_1190 (* discrete *) ;
    i_1189_copy source.i_1189 dest.i_1189 (* discrete *) ;
    i_1188_copy source.i_1188 dest.i_1188 (* discrete *) ;
    i_1187_copy source.i_1187 dest.i_1187 (* discrete *) ;
    i_1186_copy source.i_1186 dest.i_1186 (* discrete *) ;
    i_1185_copy source.i_1185 dest.i_1185 (* discrete *) in
  let wt_wt3_reset self  =
    ((self.i_1038 <- true ;
      i_1190_reset self.i_1190  ;
      i_1189_reset self.i_1189  ;
      i_1188_reset self.i_1188  ;
      i_1187_reset self.i_1187  ;
      i_1186_reset self.i_1186  ; i_1185_reset self.i_1185 ):unit) in 
  let wt_wt3_step self (inp_910:(MyOp.t)Array.t) =
    ((let (v0_923:MyOp.t) = Array.get inp_910  0 in
      (if self.i_1038 then self.v0_0_937 <- v0_923) ;
      (let (params_930:Wt_params.params) =
           Wt_params.get_default self.v0_0_937 in
       let (y0_1008:MyOp.t) = params_930.Wt_params.omega_g0 in
       (if self.i_1038 then self.m_1036 <- y0_1008) ;
       (if self.i_1038 then self.m_1012 <- MyOp.make 0.) ;
       (let (x_1013:MyOp.t) = self.m_1012 in
        let (x_1035:MyOp.t) =
            if self.i_1038 then x_1013 else MyOp.(-) x_1013  self.m_1033 in
        let (y0_998:MyOp.t) = params_930.Wt_params.pitch.Wt_params.theta0 in
        (if self.i_1038 then self.m_1031 <- y0_998) ;
        (let (x_1030:MyOp.t) =
             if self.i_1038 then x_1013 else MyOp.(-) x_1013  self.m_1028 in
         let (y0_988:MyOp.t) =
             MyOp.( * ) params_930.Wt_params.pitch.Wt_params.theta0 
                        (MyOp.translate (MyOp.(/) params_930.Wt_params.pitch.Wt_params.theta0
                                                  
                                                  params_930.Wt_params.pitch.Wt_params.cpc.Wt_params.gS_factor)
                                         1.) in
         (if self.i_1038 then self.m_1026 <- y0_988) ;
         (let (x_1025:MyOp.t) =
              if self.i_1038 then x_1013 else MyOp.(-) x_1013  self.m_1023 in
          (if self.i_1038 then
           self.m_1021 <- params_930.Wt_params.pitch.Wt_params.theta0) ;
          (let (y0_965:MyOp.t) = params_930.Wt_params.xt_dot0 in
           (if self.i_1038 then self.m_1019 <- y0_965) ;
           (let (y0_961:MyOp.t) = params_930.Wt_params.omega0 in
            (if self.i_1038 then self.m_1017 <- y0_961) ;
            (let (x_1016:MyOp.t) =
                 if self.i_1038 then x_1013 else MyOp.(-) x_1013  self.m_1014 in
             (if self.i_1038 then self.tstep'_922 <- MyOp.make tstep_911) ;
             (if self.i_1038 then self.m_1010 <- self.tstep'_922) ;
             self.i_1038 <- false ;
             (let (x_1032:MyOp.t) = self.m_1031 in
              let (theta_920:MyOp.t) = Wt_common.rad2deg x_1032 in
              let (x_1018:MyOp.t) = self.m_1017 in
              let (omega_915:MyOp.t) = Wt_common.radPs2rpm x_1018 in
              let (x_1037:MyOp.t) = self.m_1036 in
              let (omega_g_916:MyOp.t) = Wt_common.radPs2rpm x_1037 in
              let (x_1022:MyOp.t) = self.m_1021 in
              let (gs_973:MyOp.t) =
                  MyOp.inv (MyOp.translate (MyOp.(/) x_1022 
                                                     params_930.Wt_params.pitch.Wt_params.cpc.Wt_params.gS_factor)
                                            1.) in
              let (omega_g_rated_968:MyOp.t) =
                  params_930.Wt_params.omega_g_rated in
              let (e_972:MyOp.t) = MyOp.(-) x_1037  omega_g_rated_968 in
              let (e1_979:MyOp.t) =
                  MyOp.( * ) e_972 
                             params_930.Wt_params.pitch.Wt_params.cpc.Wt_params.kP in
              let (x_1027:MyOp.t) = self.m_1026 in
              let (e4_982:MyOp.t) = MyOp.(+) e1_979  x_1027 in
              let (theta_d'_984:MyOp.t) = MyOp.( * ) gs_973  e4_982 in
              let (theta_d_983:MyOp.t) =
                  Wt_d.saturate (params_930.Wt_params.pitch.Wt_params.min ,
                                 params_930.Wt_params.pitch.Wt_params.max ,
                                 theta_d'_984) in
              let (theta_d_933:MyOp.t) =
                  i_1190_step self.i_1190
                    (x_1013 ,
                     params_930.Wt_params.pitch.Wt_params.rateLimit ,
                     (MyOp.(~-) params_930.Wt_params.pitch.Wt_params.rateLimit)
                     ,
                     params_930.Wt_params.pitch.Wt_params.thetaDot0 ,
                     theta_d_983) in
              let (theta_d_921:MyOp.t) = Wt_common.rad2deg theta_d_933 in
              let (blade_pitch_angle_943:MyOp.t) =
                  i_1189_step self.i_1189
                    (x_1013 ,
                     params_930.Wt_params.pitch.Wt_params.actuatorType ,
                     theta_d_933 , params_930) in
              let (blade_pitch_angle_912:MyOp.t) =
                  Wt_common.rad2deg blade_pitch_angle_943 in
              let (mg_d_927:MyOp.t) =
                  Wt_d.torque_controller (x_1037 , theta_d_933 , params_930) in
              let (outp_917:(MyOp.t)Array.t) =
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
              let (rob_918:MyOp.t) =
                  i_1188_step self.i_1188 (self.tstep'_922 , outp_917) in
              let (u_1002:MyOp.t) =
                  MyOp.(/) x_1018  params_930.Wt_params.gBRatio in
              let (dy_1003:MyOp.t) =
                  MyOp.(/) (MyOp.(-) u_1002  x_1037) 
                           params_930.Wt_params.vscontrol.Wt_params.vs_filterConstant in
              self.m_1036 <- MyOp.(+) (MyOp.( * ) dy_1003  x_1035)  x_1037 ;
              self.m_1033 <- x_1013 ;
              (let (dy_993:MyOp.t) =
                   MyOp.(/) (MyOp.(-) blade_pitch_angle_943  x_1032) 
                            params_930.Wt_params.pitch.Wt_params.pitch_filterConstant in
               self.m_1031 <- MyOp.(+) (MyOp.( * ) dy_993  x_1030)  x_1032 ;
               self.m_1028 <- x_1013 ;
               (let (e2_980:MyOp.t) =
                    MyOp.(-) e1_979 
                             (MyOp.( * ) (MyOp.(-) theta_d'_984  theta_d_983)
                                         
                                         params_930.Wt_params.pitch.Wt_params.cpc.Wt_params.antiWindUp) in
                let (x_987:MyOp.t) =
                    MyOp.(/) e2_980 
                             params_930.Wt_params.pitch.Wt_params.cpc.Wt_params.tI in
                self.m_1026 <- MyOp.(+) (MyOp.( * ) x_987  x_1025)  x_1027 ;
                self.m_1023 <- x_1013 ;
                self.m_1021 <- blade_pitch_angle_943 ;
                (let (x_1020:MyOp.t) = self.m_1019 in
                 let ((ma_945:MyOp.t) , (fa_944:MyOp.t)) =
                     i_1187_step self.i_1187
                       (v0_923 ,
                        blade_pitch_angle_943 , x_1018 , x_1020 , params_930) in
                 let (xT_957:MyOp.t) =
                     i_1186_step self.i_1186
                       (x_1016 , x_1020 , params_930.Wt_params.xT0) in
                 let (dxT_dot_954:MyOp.t) =
                     MyOp.(/) (MyOp.(-) (MyOp.(-) fa_944 
                                                  (MyOp.( * ) x_1020 
                                                              params_930.Wt_params.cTe))
                                        
                                        (MyOp.( * ) (MyOp.(-) xT_957 
                                                              params_930.Wt_params.xT0)
                                                     params_930.Wt_params.kTe))
                               params_930.Wt_params.mTe in
                 self.m_1019 <- MyOp.(+) (MyOp.( * ) dxT_dot_954  x_1016) 
                                         x_1020 ;
                 (let (torque_aux_936:MyOp.t) =
                      i_1185_step self.i_1185
                        (x_1013 ,
                         params_930.Wt_params.vscontrol.Wt_params.maxRat ,
                         (MyOp.(~-) params_930.Wt_params.vscontrol.Wt_params.maxRat)
                         , (MyOp.make 0.) , mg_d_927) in
                  let (torque_935:MyOp.t) =
                      Wt_d.saturate (MyOp.neg_infinity ,
                                     params_930.Wt_params.vscontrol.Wt_params.maxTq
                                     , torque_aux_936) in
                  let (domega_953:MyOp.t) =
                      MyOp.(/) (MyOp.(-) ma_945 
                                         (MyOp.(/) torque_935 
                                                   params_930.Wt_params.gBRatio))
                                params_930.Wt_params.inertia in
                  self.m_1017 <- MyOp.(+) (MyOp.( * ) domega_953  x_1016) 
                                          x_1018 ;
                  self.m_1014 <- x_1013 ;
                  (let (x_1011:MyOp.t) = self.m_1010 in
                   self.m_1012 <- x_1011 ;
                   self.m_1010 <- MyOp.(+) x_1011  self.tstep'_922 ;
                   ((MyOp.get x_1011) ,
                    outp_917 , (MyOp.(+) rob_918  (MyOp.make 0.1))))))))))))))))):
    float * MyOp.t Array.t * MyOp.t) in
  Cnode { alloc = wt_wt3_alloc; copy = wt_wt3_copy ;
                                reset = wt_wt3_reset ; step = wt_wt3_step }
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
  let Cnode { alloc = i_1196_alloc; copy = i_1196_copy ;
                                    step = i_1196_step ; reset = i_1196_reset } = Wt_d.rate_limiter 
   in 
  let Cnode { alloc = i_1195_alloc; copy = i_1195_copy ;
                                    step = i_1195_step ; reset = i_1195_reset } = Wt_d.pitch_actuator_subsystem 
   in 
  let Cnode { alloc = i_1194_alloc; copy = i_1194_copy ;
                                    step = i_1194_step ; reset = i_1194_reset } = wt4 
   in 
  let Cnode { alloc = i_1193_alloc; copy = i_1193_copy ;
                                    step = i_1193_step ; reset = i_1193_reset } = Wt_d.aero_elastic_subsystem 
   in 
  let Cnode { alloc = i_1192_alloc; copy = i_1192_copy ;
                                    step = i_1192_step ; reset = i_1192_reset } = Wt_common.integrate 
   in 
  let Cnode { alloc = i_1191_alloc; copy = i_1191_copy ;
                                    step = i_1191_step ; reset = i_1191_reset } = Wt_d.rate_limiter 
   in
  let wt_wt4_alloc _ =
    ();
    { i_1167 = (false:bool) ;
      m_1165 = (create ():MyOp.t) ;
      m_1162 = (create ():MyOp.t) ;
      m_1160 = (create ():MyOp.t) ;
      m_1157 = (create ():MyOp.t) ;
      m_1155 = (create ():MyOp.t) ;
      m_1152 = (create ():MyOp.t) ;
      m_1150 = (create ():MyOp.t) ;
      m_1148 = (create ():MyOp.t) ;
      m_1146 = (create ():MyOp.t) ;
      m_1143 = (create ():MyOp.t) ;
      m_1141 = (create ():MyOp.t) ;
      m_1139 = (create ():MyOp.t) ;
      v0_0_1066 = (create ():MyOp.t) ; tstep'_1051 = (create ():MyOp.t);
      i_1196 = i_1196_alloc () (* discrete *)  ;
      i_1195 = i_1195_alloc () (* discrete *)  ;
      i_1194 = i_1194_alloc () (* discrete *)  ;
      i_1193 = i_1193_alloc () (* discrete *)  ;
      i_1192 = i_1192_alloc () (* discrete *)  ;
      i_1191 = i_1191_alloc () (* discrete *)  } in
  let wt_wt4_copy source dest =
    dest.i_1167 <- source.i_1167 ;
    dest.m_1165 <- source.m_1165 ;
    dest.m_1162 <- source.m_1162 ;
    dest.m_1160 <- source.m_1160 ;
    dest.m_1157 <- source.m_1157 ;
    dest.m_1155 <- source.m_1155 ;
    dest.m_1152 <- source.m_1152 ;
    dest.m_1150 <- source.m_1150 ;
    dest.m_1148 <- source.m_1148 ;
    dest.m_1146 <- source.m_1146 ;
    dest.m_1143 <- source.m_1143 ;
    dest.m_1141 <- source.m_1141 ;
    dest.m_1139 <- source.m_1139 ;
    dest.v0_0_1066 <- source.v0_0_1066 ;
    dest.tstep'_1051 <- source.tstep'_1051;
    i_1196_copy source.i_1196 dest.i_1196 (* discrete *) ;
    i_1195_copy source.i_1195 dest.i_1195 (* discrete *) ;
    i_1194_copy source.i_1194 dest.i_1194 (* discrete *) ;
    i_1193_copy source.i_1193 dest.i_1193 (* discrete *) ;
    i_1192_copy source.i_1192 dest.i_1192 (* discrete *) ;
    i_1191_copy source.i_1191 dest.i_1191 (* discrete *) in
  let wt_wt4_reset self  =
    ((self.i_1167 <- true ;
      i_1196_reset self.i_1196  ;
      i_1195_reset self.i_1195  ;
      i_1194_reset self.i_1194  ;
      i_1193_reset self.i_1193  ;
      i_1192_reset self.i_1192  ; i_1191_reset self.i_1191 ):unit) in 
  let wt_wt4_step self (inp_1039:(MyOp.t)Array.t) =
    ((let (v0_1052:MyOp.t) = Array.get inp_1039  0 in
      (if self.i_1167 then self.v0_0_1066 <- v0_1052) ;
      (let (params_1059:Wt_params.params) =
           Wt_params.get_default self.v0_0_1066 in
       let (y0_1137:MyOp.t) = params_1059.Wt_params.omega_g0 in
       (if self.i_1167 then self.m_1165 <- y0_1137) ;
       (if self.i_1167 then self.m_1141 <- MyOp.make 0.) ;
       (let (x_1142:MyOp.t) = self.m_1141 in
        let (x_1164:MyOp.t) =
            if self.i_1167 then x_1142 else MyOp.(-) x_1142  self.m_1162 in
        let (y0_1127:MyOp.t) = params_1059.Wt_params.pitch.Wt_params.theta0 in
        (if self.i_1167 then self.m_1160 <- y0_1127) ;
        (let (x_1159:MyOp.t) =
             if self.i_1167 then x_1142 else MyOp.(-) x_1142  self.m_1157 in
         let (y0_1117:MyOp.t) =
             MyOp.( * ) params_1059.Wt_params.pitch.Wt_params.theta0 
                        (MyOp.translate (MyOp.(/) params_1059.Wt_params.pitch.Wt_params.theta0
                                                  
                                                  params_1059.Wt_params.pitch.Wt_params.cpc.Wt_params.gS_factor)
                                         1.) in
         (if self.i_1167 then self.m_1155 <- y0_1117) ;
         (let (x_1154:MyOp.t) =
              if self.i_1167 then x_1142 else MyOp.(-) x_1142  self.m_1152 in
          (if self.i_1167 then
           self.m_1150 <- params_1059.Wt_params.pitch.Wt_params.theta0) ;
          (let (y0_1094:MyOp.t) = params_1059.Wt_params.xt_dot0 in
           (if self.i_1167 then self.m_1148 <- y0_1094) ;
           (let (y0_1090:MyOp.t) = params_1059.Wt_params.omega0 in
            (if self.i_1167 then self.m_1146 <- y0_1090) ;
            (let (x_1145:MyOp.t) =
                 if self.i_1167 then x_1142 else MyOp.(-) x_1142  self.m_1143 in
             (if self.i_1167 then self.tstep'_1051 <- MyOp.make tstep_1040) ;
             (if self.i_1167 then self.m_1139 <- self.tstep'_1051) ;
             self.i_1167 <- false ;
             (let (x_1161:MyOp.t) = self.m_1160 in
              let (theta_1049:MyOp.t) = Wt_common.rad2deg x_1161 in
              let (x_1147:MyOp.t) = self.m_1146 in
              let (omega_1044:MyOp.t) = Wt_common.radPs2rpm x_1147 in
              let (x_1166:MyOp.t) = self.m_1165 in
              let (omega_g_1045:MyOp.t) = Wt_common.radPs2rpm x_1166 in
              let (x_1151:MyOp.t) = self.m_1150 in
              let (gs_1102:MyOp.t) =
                  MyOp.inv (MyOp.translate (MyOp.(/) x_1151 
                                                     params_1059.Wt_params.pitch.Wt_params.cpc.Wt_params.gS_factor)
                                            1.) in
              let (omega_g_rated_1097:MyOp.t) =
                  params_1059.Wt_params.omega_g_rated in
              let (e_1101:MyOp.t) = MyOp.(-) x_1166  omega_g_rated_1097 in
              let (e1_1108:MyOp.t) =
                  MyOp.( * ) e_1101 
                             params_1059.Wt_params.pitch.Wt_params.cpc.Wt_params.kP in
              let (x_1156:MyOp.t) = self.m_1155 in
              let (e4_1111:MyOp.t) = MyOp.(+) e1_1108  x_1156 in
              let (theta_d'_1113:MyOp.t) = MyOp.( * ) gs_1102  e4_1111 in
              let (theta_d_1112:MyOp.t) =
                  Wt_d.saturate (params_1059.Wt_params.pitch.Wt_params.min ,
                                 params_1059.Wt_params.pitch.Wt_params.max ,
                                 theta_d'_1113) in
              let (theta_d_1062:MyOp.t) =
                  i_1196_step self.i_1196
                    (x_1142 ,
                     params_1059.Wt_params.pitch.Wt_params.rateLimit ,
                     (MyOp.(~-) params_1059.Wt_params.pitch.Wt_params.rateLimit)
                     ,
                     params_1059.Wt_params.pitch.Wt_params.thetaDot0 ,
                     theta_d_1112) in
              let (theta_d_1050:MyOp.t) = Wt_common.rad2deg theta_d_1062 in
              let (blade_pitch_angle_1072:MyOp.t) =
                  i_1195_step self.i_1195
                    (x_1142 ,
                     params_1059.Wt_params.pitch.Wt_params.actuatorType ,
                     theta_d_1062 , params_1059) in
              let (blade_pitch_angle_1041:MyOp.t) =
                  Wt_common.rad2deg blade_pitch_angle_1072 in
              let (mg_d_1056:MyOp.t) =
                  Wt_d.torque_controller (x_1166 , theta_d_1062 , params_1059) in
              let (outp_1046:(MyOp.t)Array.t) =
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
              let (rob_1047:MyOp.t) =
                  i_1194_step self.i_1194 (self.tstep'_1051 , outp_1046) in
              let (u_1131:MyOp.t) =
                  MyOp.(/) x_1147  params_1059.Wt_params.gBRatio in
              let (dy_1132:MyOp.t) =
                  MyOp.(/) (MyOp.(-) u_1131  x_1166) 
                           params_1059.Wt_params.vscontrol.Wt_params.vs_filterConstant in
              self.m_1165 <- MyOp.(+) (MyOp.( * ) dy_1132  x_1164)  x_1166 ;
              self.m_1162 <- x_1142 ;
              (let (dy_1122:MyOp.t) =
                   MyOp.(/) (MyOp.(-) blade_pitch_angle_1072  x_1161) 
                            params_1059.Wt_params.pitch.Wt_params.pitch_filterConstant in
               self.m_1160 <- MyOp.(+) (MyOp.( * ) dy_1122  x_1159)  x_1161 ;
               self.m_1157 <- x_1142 ;
               (let (e2_1109:MyOp.t) =
                    MyOp.(-) e1_1108 
                             (MyOp.( * ) (MyOp.(-) theta_d'_1113 
                                                   theta_d_1112) 
                                         params_1059.Wt_params.pitch.Wt_params.cpc.Wt_params.antiWindUp) in
                let (x_1116:MyOp.t) =
                    MyOp.(/) e2_1109 
                             params_1059.Wt_params.pitch.Wt_params.cpc.Wt_params.tI in
                self.m_1155 <- MyOp.(+) (MyOp.( * ) x_1116  x_1154)  x_1156 ;
                self.m_1152 <- x_1142 ;
                self.m_1150 <- blade_pitch_angle_1072 ;
                (let (x_1149:MyOp.t) = self.m_1148 in
                 let ((ma_1074:MyOp.t) , (fa_1073:MyOp.t)) =
                     i_1193_step self.i_1193
                       (v0_1052 ,
                        blade_pitch_angle_1072 ,
                        x_1147 , x_1149 , params_1059) in
                 let (xT_1086:MyOp.t) =
                     i_1192_step self.i_1192
                       (x_1145 , x_1149 , params_1059.Wt_params.xT0) in
                 let (dxT_dot_1083:MyOp.t) =
                     MyOp.(/) (MyOp.(-) (MyOp.(-) fa_1073 
                                                  (MyOp.( * ) x_1149 
                                                              params_1059.Wt_params.cTe))
                                        
                                        (MyOp.( * ) (MyOp.(-) xT_1086 
                                                              params_1059.Wt_params.xT0)
                                                    
                                                    params_1059.Wt_params.kTe))
                               params_1059.Wt_params.mTe in
                 self.m_1148 <- MyOp.(+) (MyOp.( * ) dxT_dot_1083  x_1145) 
                                         x_1149 ;
                 (let (torque_aux_1065:MyOp.t) =
                      i_1191_step self.i_1191
                        (x_1142 ,
                         params_1059.Wt_params.vscontrol.Wt_params.maxRat ,
                         (MyOp.(~-) params_1059.Wt_params.vscontrol.Wt_params.maxRat)
                         , (MyOp.make 0.) , mg_d_1056) in
                  let (torque_1064:MyOp.t) =
                      Wt_d.saturate (MyOp.neg_infinity ,
                                     params_1059.Wt_params.vscontrol.Wt_params.maxTq
                                     , torque_aux_1065) in
                  let (domega_1082:MyOp.t) =
                      MyOp.(/) (MyOp.(-) ma_1074 
                                         (MyOp.(/) torque_1064 
                                                   params_1059.Wt_params.gBRatio))
                                params_1059.Wt_params.inertia in
                  self.m_1146 <- MyOp.(+) (MyOp.( * ) domega_1082  x_1145) 
                                          x_1147 ;
                  self.m_1143 <- x_1142 ;
                  (let (x_1140:MyOp.t) = self.m_1139 in
                   self.m_1141 <- x_1140 ;
                   self.m_1139 <- MyOp.(+) x_1140  self.tstep'_1051 ;
                   ((MyOp.get x_1140) , outp_1046 , rob_1047))))))))))))))):
    float * MyOp.t Array.t * MyOp.t) in
  Cnode { alloc = wt_wt4_alloc; copy = wt_wt4_copy ;
                                reset = wt_wt4_reset ; step = wt_wt4_step }
