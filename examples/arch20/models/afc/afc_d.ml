(* The Zélus compiler, version 2.0
  (jeudi 4 juin 2020, 17:57:12 (UTC+0200)) *)
open Ztypes
open MyOp
open Afc_utils
type ('b , 'a) _integrate =
  { mutable i_754 : 'b ; mutable m_752 : 'a }

let integrate  = 
  
  let integrate_alloc _ =
    ();{ i_754 = (false:bool) ; m_752 = (Obj.magic ():MyOp.t) } in
  let integrate_reset self  =
    (self.i_754 <- true:unit) in 
  let integrate_step self ((tstep_749:MyOp.t) ,
                           (dy_748:MyOp.t) , (y0_750:MyOp.t)) =
    (((if self.i_754 then self.m_752 <- y0_750) ;
      self.i_754 <- false ;
      (let (x_753:MyOp.t) = self.m_752 in
       self.m_752 <- MyOp.(+) (MyOp.( * ) tstep_749  dy_748)  x_753 ; x_753)):
    MyOp.t) in
  Node { alloc = integrate_alloc; reset = integrate_reset ;
                                  step = integrate_step }
let saturate ((low_756:MyOp.t) , (high_755:MyOp.t) , (v_757:MyOp.t)) =
  MyOp.min (MyOp.max v_757  low_756)  high_755

type ('b , 'a) _step =
  { mutable i_769 : 'b ; mutable m_767 : 'a }

let step  = 
  
  let step_alloc _ =
    ();{ i_769 = (false:bool) ; m_767 = (Obj.magic ():MyOp.t) } in
  let step_reset self  =
    (self.i_769 <- true:unit) in 
  let step_step self ((tstep_759:MyOp.t) ,
                      (y0_760:'a6450) , (t0_758:MyOp.t) , (y1_761:'a6450)) =
    ((let (y0_765:MyOp.t) = MyOp.make 0. in
      (if self.i_769 then self.m_767 <- y0_765) ;
      self.i_769 <- false ;
      (let (dy_763:MyOp.t) = MyOp.make 1. in
       let (x_768:MyOp.t) = self.m_767 in
       self.m_767 <- MyOp.(+) (MyOp.( * ) tstep_759  dy_763)  x_768 ;
       ((if (<=) x_768  t0_758 then y0_760 else y1_761)))):'a) in
  Node { alloc = step_alloc; reset = step_reset ; step = step_step }
type ('c , 'b , 'a) _pulse_gen =
  { mutable i_785 : 'c ; mutable m_783 : 'b ; mutable pulse_width_780 : 'a }

let pulse_gen  = 
  
  let pulse_gen_alloc _ =
    ();
    { i_785 = (false:bool) ;
      m_783 = (Obj.magic ():MyOp.t) ; pulse_width_780 = (Obj.magic ():MyOp.t) } in
  let pulse_gen_reset self  =
    (self.i_785 <- true:unit) in 
  let pulse_gen_step self ((tstep_773:MyOp.t) ,
                           (a_770:MyOp.t) ,
                           (p_772:MyOp.t) ,
                           (w_774:MyOp.t) , (delay_771:MyOp.t)) =
    ((let (y0_778:MyOp.t) = MyOp.make 0. in
      (if self.i_785 then self.m_783 <- y0_778) ;
      (if self.i_785 then self.pulse_width_780 <- MyOp.( * ) p_772  w_774) ;
      self.i_785 <- false ;
      (let (dy_776:MyOp.t) = MyOp.make 1. in
       let (x_784:MyOp.t) = self.m_783 in
       self.m_783 <- MyOp.(+) (MyOp.( * ) tstep_773  dy_776)  x_784 ;
       (let (pulse_rel_781:MyOp.t) =
            MyOp.mod_t (MyOp.(-) x_784  delay_771)  p_772 in
        let (pulse_is_on_782:bool) = (<=) pulse_rel_781  self.pulse_width_780 in
        if (&&) ((>=) x_784  delay_771)  pulse_is_on_782
        then a_770
        else MyOp.make 0.))):MyOp.t) in
  Node { alloc = pulse_gen_alloc; reset = pulse_gen_reset ;
                                  step = pulse_gen_step }
type _over_under_shoot = unit

let over_under_shoot  = 
   let over_under_shoot_alloc _ = () in
  let over_under_shoot_reset self  =
    ((()):unit) in 
  let over_under_shoot_step self ((abf_786:MyOp.t) , (abf_ref_787:MyOp.t)) =
    ((let (e_788:MyOp.t) =
          if (=) abf_ref_787  (MyOp.make 0.)
          then MyOp.make 0.
          else MyOp.translate (MyOp.(/) abf_786  abf_ref_787)  (-1.) in
      e_788):MyOp.t) in
  Node { alloc = over_under_shoot_alloc; reset = over_under_shoot_reset ;
                                         step = over_under_shoot_step }
type ('c , 'b , 'a) _rms_error =
  { mutable i_1325 : 'c ; mutable i_800 : 'b ; mutable m_798 : 'a }

let rms_error  = 
  let Node { alloc = i_1325_alloc; step = i_1325_step ; reset = i_1325_reset } = step 
   in
  let rms_error_alloc _ =
    ();
    { i_800 = (false:bool) ; m_798 = (Obj.magic ():MyOp.t);
      i_1325 = i_1325_alloc () (* discrete *)  } in
  let rms_error_reset self  =
    ((self.i_800 <- true ; i_1325_reset self.i_1325 ):unit) in 
  let rms_error_step self ((tstep_791:MyOp.t) ,
                           (abf_789:MyOp.t) , (abf_ref_790:MyOp.t)) =
    ((let (y0_796:MyOp.t) = MyOp.make 0. in
      (if self.i_800 then self.m_798 <- y0_796) ;
      self.i_800 <- false ;
      (let (de_792:MyOp.t) =
           MyOp.( * ) (MyOp.pow (MyOp.(-) abf_789  abf_ref_790)  2.) 
                      (i_1325_step self.i_1325
                         (tstep_791 ,
                          (MyOp.make 0.) , (MyOp.make 10.) , (MyOp.make 1.))) in
       let (x_799:MyOp.t) = self.m_798 in
       self.m_798 <- MyOp.(+) (MyOp.( * ) tstep_791  de_792)  x_799 ;
       (let (e_793:MyOp.t) =
            MyOp.sqrt (MyOp.scale x_799 
                                  ((/.) 1.  ((-.) Afc_utils.simTime  10.))) in
        e_793))):MyOp.t) in
  Node { alloc = rms_error_alloc; reset = rms_error_reset ;
                                  step = rms_error_step }
type ('c , 'b , 'a) _calculate_error =
  { mutable i_1326 : 'c ; mutable i_1327 : 'b ; mutable result_806 : 'a }

let calculate_error  = 
  let Node { alloc = i_1326_alloc; step = i_1326_step ; reset = i_1326_reset } = over_under_shoot 
   in 
  let Node { alloc = i_1327_alloc; step = i_1327_step ; reset = i_1327_reset } = rms_error 
   in
  let calculate_error_alloc _ =
    ();
    { result_806 = (Obj.magic ():MyOp.t);
      i_1326 = i_1326_alloc () (* discrete *)  ;
      i_1327 = i_1327_alloc () (* discrete *)  } in
  let calculate_error_reset self  =
    ((i_1326_reset self.i_1326  ; i_1327_reset self.i_1327 ):unit) in 
  let calculate_error_step self ((tstep_804:MyOp.t) ,
                                 (abf_801:MyOp.t) ,
                                 (spec_num_803:int) , (abf_ref_802:MyOp.t)) =
    (((begin match spec_num_803 with
             | 1 ->
                 self.result_806 <- i_1326_step self.i_1326
                                      (abf_801 , abf_ref_802)
             | 2 ->
                 self.result_806 <- i_1327_step self.i_1327
                                      (tstep_804 , abf_801 , abf_ref_802)
             | _ -> self.result_806 <- MyOp.make 0.  end) ; self.result_806):
    MyOp.t) in
  Node { alloc = calculate_error_alloc; reset = calculate_error_reset ;
                                        step = calculate_error_step }
type ('b , 'a) _vv_stub =
  { mutable i_1329 : 'b ; mutable i_1328 : 'a }

let vv_stub  = 
  let Node { alloc = i_1329_alloc; step = i_1329_step ; reset = i_1329_reset } = calculate_error 
   in 
  let Node { alloc = i_1328_alloc; step = i_1328_step ; reset = i_1328_reset } = integrate 
   in
  let vv_stub_alloc _ =
    ();
    { i_1329 = i_1329_alloc () (* discrete *)  ;
      i_1328 = i_1328_alloc () (* discrete *)  } in
  let vv_stub_reset self  =
    ((i_1329_reset self.i_1329  ; i_1328_reset self.i_1328 ):unit) in 
  let vv_stub_step self ((tstep_809:MyOp.t) ,
                         (abf_807:MyOp.t) , (abf_ref_808:MyOp.t)) =
    ((let (x_812:MyOp.t) =
          i_1329_step self.i_1329
            (tstep_809 , abf_807 , Afc_utils.spec_num , abf_ref_808) in
      let (t_811:MyOp.t) =
          i_1328_step self.i_1328
            (tstep_809 , (MyOp.make 1.) , (MyOp.make 0.)) in
      let (s_aux_out_810:MyOp.t) =
          if (>=) t_811  (MyOp.make 1.) then x_812 else MyOp.make 0. in
      s_aux_out_810):MyOp.t) in
  Node { alloc = vv_stub_alloc; reset = vv_stub_reset ; step = vv_stub_step }
type _throttle = unit

let throttle  = 
   let throttle_alloc _ = () in
  let throttle_reset self  =
    ((()):unit) in 
  let throttle_step self ((throttle_angle_815:MyOp.t) ,
                          (manifold_pressure_814:MyOp.t) ,
                          (atmospheric_pressure_813:MyOp.t)) =
    ((let (flow_direction_818:MyOp.t) =
          if (>) (MyOp.(-) atmospheric_pressure_813  manifold_pressure_814) 
                 (MyOp.make 0.)
          then MyOp.make 1.
          else
            if (<) (MyOp.(-) atmospheric_pressure_813  manifold_pressure_814)
                    (MyOp.make 0.)
            then MyOp.make (-1.)
            else MyOp.make 0. in
      let (pratio_820:MyOp.t) =
          MyOp.min (MyOp.(/) manifold_pressure_814  atmospheric_pressure_813)
                   
                   (MyOp.(/) atmospheric_pressure_813  manifold_pressure_814) in
      let (sonic_flow_821:MyOp.t) = MyOp.make 1. in
      let (g_pratio_819:MyOp.t) =
          MyOp.scale (MyOp.sqrt (MyOp.(-) pratio_820 
                                          (MyOp.( * ) pratio_820  pratio_820)))
                      2. in
      let (aux_816:MyOp.t) =
          if (>=) pratio_820  (MyOp.make 0.5)
          then g_pratio_819
          else sonic_flow_821 in
      let (f_angle_817:MyOp.t) =
          MyOp.translate (MyOp.(+) (MyOp.(+) (MyOp.scale throttle_angle_815 
                                                         (-0.05231)) 
                                             (MyOp.scale (MyOp.( * ) 
                                                            throttle_angle_815
                                                            
                                                            throttle_angle_815)
                                                          0.10299)) 
                                   (MyOp.scale (MyOp.( * ) (MyOp.( * ) 
                                                              throttle_angle_815
                                                              
                                                              throttle_angle_815)
                                                           
                                                           throttle_angle_815)
                                                (-0.00063)))  2.821 in
      let (throttle_flow_822:MyOp.t) =
          MyOp.( * ) (MyOp.( * ) f_angle_817  aux_816)  flow_direction_818 in
      throttle_flow_822):MyOp.t) in
  Node { alloc = throttle_alloc; reset = throttle_reset ;
                                 step = throttle_step }
type ('b , 'a) _intake_manifold =
  { mutable i_836 : 'b ; mutable m_834 : 'a }

let intake_manifold  = 
  
  let intake_manifold_alloc _ =
    ();{ i_836 = (false:bool) ; m_834 = (Obj.magic ():MyOp.t) } in
  let intake_manifold_reset self  =
    (self.i_836 <- true:unit) in 
  let intake_manifold_step self ((tstep_825:MyOp.t) ,
                                 (throttle_flow_824:MyOp.t) ,
                                 (omega_823:MyOp.t)) =
    ((let (y0_832:MyOp.t) = MyOp.make 0.982 in
      (if self.i_836 then self.m_834 <- y0_832) ;
      self.i_836 <- false ;
      (let (x_835:MyOp.t) = self.m_834 in
       let (pumping_829:MyOp.t) =
           MyOp.translate (MyOp.(+) (MyOp.(-) (MyOp.scale (MyOp.( * ) 
                                                             x_835  omega_823)
                                                           0.08979) 
                                              (MyOp.scale (MyOp.( * ) 
                                                             (MyOp.( * ) 
                                                                omega_823 
                                                                x_835)  
                                                             x_835)  
                                                          0.0337)) 
                                    (MyOp.scale (MyOp.( * ) (MyOp.( * ) 
                                                               x_835 
                                                               omega_823) 
                                                            omega_823) 
                                                0.0001))  (-0.366) in
       let (cyl_air_826:MyOp.t) = MyOp.scale pumping_829  0.9 in
       let (dmanifold_pressure_827:MyOp.t) =
           MyOp.scale (MyOp.(-) throttle_flow_824  cyl_air_826)  0.41328 in
       self.m_834 <- MyOp.(+) (MyOp.( * ) tstep_825  dmanifold_pressure_827) 
                              x_835 ; (cyl_air_826 , x_835))):MyOp.t * MyOp.t) in
  Node { alloc = intake_manifold_alloc; reset = intake_manifold_reset ;
                                        step = intake_manifold_step }
type ('b , 'a) _af_sensor =
  { mutable i_846 : 'b ; mutable m_844 : 'a }

let af_sensor  = 
  
  let af_sensor_alloc _ =
    ();{ i_846 = (false:bool) ; m_844 = (Obj.magic ():MyOp.t) } in
  let af_sensor_reset self  =
    (self.i_846 <- true:unit) in 
  let af_sensor_step self ((tstep_837:MyOp.t) , (x_838:MyOp.t)) =
    ((let (y0_842:MyOp.t) = MyOp.make 14.7 in
      (if self.i_846 then self.m_844 <- y0_842) ;
      self.i_846 <- false ;
      (let (x_845:MyOp.t) = self.m_844 in
       let (dy_840:MyOp.t) = MyOp.scale (MyOp.(-) x_838  x_845)  50. in
       self.m_844 <- MyOp.(+) (MyOp.( * ) tstep_837  dy_840)  x_845 ;
       MyOp.scale x_845  Afc_utils.af_sensor_tol)):MyOp.t) in
  Node { alloc = af_sensor_alloc; reset = af_sensor_reset ;
                                  step = af_sensor_step }
type ('e , 'd , 'c , 'b , 'a) _cylinder_exhaust =
  { mutable i_1331 : 'e ;
    mutable i_1330 : 'd ;
    mutable i_875 : 'c ; mutable m_873 : 'b ; mutable m_871 : 'a }

let cylinder_exhaust  = 
  let Node { alloc = i_1331_alloc; step = i_1331_step ; reset = i_1331_reset } = integrate 
   in 
  let Node { alloc = i_1330_alloc; step = i_1330_step ; reset = i_1330_reset } = Afc_utils.fuel_transport_delay 
   in
  let cylinder_exhaust_alloc _ =
    ();
    { i_875 = (false:bool) ;
      m_873 = (Obj.magic ():MyOp.t) ; m_871 = (Obj.magic ():MyOp.t);
      i_1331 = i_1331_alloc () (* discrete *)  ;
      i_1330 = i_1330_alloc () (* discrete *)  } in
  let cylinder_exhaust_reset self  =
    ((self.i_875 <- true ;
      i_1331_reset self.i_1331  ; i_1330_reset self.i_1330 ):unit) in 
  let cylinder_exhaust_step self ((tstep_851:MyOp.t) ,
                                  (cyl_air_847:MyOp.t) ,
                                  (cyl_fuel_848:MyOp.t) ,
                                  (omega_849:MyOp.t) ,
                                  (sensor_fault_850:MyOp.t)) =
    ((let (y0_869:MyOp.t) = MyOp.make 14.7 in
      (if self.i_875 then self.m_873 <- y0_869) ;
      (let (y0_865:MyOp.t) = MyOp.make 14.7 in
       (if self.i_875 then self.m_871 <- y0_865) ;
       self.i_875 <- false ;
       (let (cur_abf_854:MyOp.t) = MyOp.(/) cyl_air_847  cyl_fuel_848 in
        let (cyl_air_charge_855:MyOp.t) =
            MyOp.scale (MyOp.(/) cyl_air_847  omega_849)  Afc_utils.pi in
        let (delay_856:MyOp.t) =
            Afc_utils.lookup_delay ((MyOp.scale omega_849  Afc_utils.rad2rpm)
                                    , cyl_air_charge_855) in
        let (t_859:MyOp.t) =
            i_1331_step self.i_1331
              (tstep_851 , (MyOp.make 1.) , (MyOp.make 0.)) in
        let (delayed_857:MyOp.t) =
            i_1330_step self.i_1330 (t_859 , cur_abf_854 , delay_856) in
        let (x_874:MyOp.t) = self.m_873 in
        let (dy_867:MyOp.t) = MyOp.scale (MyOp.(-) delayed_857  x_874)  10. in
        self.m_873 <- MyOp.(+) (MyOp.( * ) tstep_851  dy_867)  x_874 ;
        (let (x_872:MyOp.t) = self.m_871 in
         let (dy_863:MyOp.t) = MyOp.scale (MyOp.(-) x_874  x_872)  50. in
         self.m_871 <- MyOp.(+) (MyOp.( * ) tstep_851  dy_863)  x_872 ;
         (let (abf_852:MyOp.t) = MyOp.scale x_872  Afc_utils.af_sensor_tol in
          let (abf_meas_853:MyOp.t) =
              if (>=) sensor_fault_850  (MyOp.make 0.5)
              then MyOp.make (-1.)
              else abf_852 in
          (abf_meas_853 , cyl_air_charge_855 , abf_852)))))):MyOp.t *
                                                             MyOp.t * MyOp.t) in
  Node { alloc = cylinder_exhaust_alloc; reset = cylinder_exhaust_reset ;
                                         step = cylinder_exhaust_step }
type ('b , 'a) _wall_wetting =
  { mutable i_893 : 'b ; mutable m_891 : 'a }

let wall_wetting  = 
  
  let wall_wetting_alloc _ =
    ();{ i_893 = (false:bool) ; m_891 = (Obj.magic ():MyOp.t) } in
  let wall_wetting_reset self  =
    (self.i_893 <- true:unit) in 
  let wall_wetting_step self ((tstep_879:MyOp.t) ,
                              (fuel_injected_877:MyOp.t) ,
                              (omega_878:MyOp.t) ,
                              (cyl_air_charge_876:MyOp.t)) =
    ((let (y0_889:MyOp.t) = MyOp.make 0.0112 in
      (if self.i_893 then self.m_891 <- y0_889) ;
      self.i_893 <- false ;
      (let (tau_ww_tolerance_886:MyOp.t) =
           Afc_utils.lookup_tau_ww (omega_878 , cyl_air_charge_876) in
       let (x_892:MyOp.t) = self.m_891 in
       let (fuel_puddle_evap_883:MyOp.t) =
           MyOp.(/) x_892  tau_ww_tolerance_886 in
       let (kappa_tolerance_885:MyOp.t) =
           Afc_utils.lookup_kappa ((MyOp.scale omega_878  Afc_utils.rad2rpm)
                                   , cyl_air_charge_876) in
       let (daux_882:MyOp.t) =
           MyOp.(-) (MyOp.( * ) fuel_injected_877 
                                (MyOp.(-) (MyOp.make 1.)  kappa_tolerance_885))
                     fuel_puddle_evap_883 in
       self.m_891 <- MyOp.(+) (MyOp.( * ) tstep_879  daux_882)  x_892 ;
       (let (fuel_vapor_884:MyOp.t) =
            MyOp.( * ) kappa_tolerance_885  fuel_injected_877 in
        let (cyl_fuel_881:MyOp.t) =
            MyOp.(+) fuel_vapor_884  fuel_puddle_evap_883 in
        cyl_fuel_881))):MyOp.t) in
  Node { alloc = wall_wetting_alloc; reset = wall_wetting_reset ;
                                     step = wall_wetting_step }
type ('b , 'a) _fup =
  { mutable i_900 : 'b ; mutable m_897 : 'a }

let fup  = 
   let fup_alloc _ =
     ();{ i_900 = (false:bool) ; m_897 = (false:bool) } in
  let fup_reset self  =
    (self.i_900 <- true:unit) in 
  let fup_step self (x_894:MyOp.t) =
    ((let (b'_896:bool) = (>) x_894  (MyOp.make 0.5) in
      let (x_899:bool) =
          if self.i_900 then false else (&&) b'_896  (not self.m_897) in
      self.i_900 <- false ; self.m_897 <- b'_896 ; x_899):bool) in
  Node { alloc = fup_alloc; reset = fup_reset ; step = fup_step }
type ('a) _sensor_failure_detection =
  { mutable m_903 : 'a }

let sensor_failure_detection  = 
   let sensor_failure_detection_alloc _ =
     ();{ m_903 = (false:bool) } in
  let sensor_failure_detection_reset self  =
    (self.m_903 <- false:unit) in 
  let sensor_failure_detection_step self (abf_901:MyOp.t) =
    ((let (x_904:bool) = self.m_903 in
      let (fail_on_902:bool) = (||) ((<=) abf_901  (MyOp.make (-1.)))  x_904 in
      self.m_903 <- fail_on_902 ; fail_on_902):bool) in
  Node { alloc = sensor_failure_detection_alloc; reset = sensor_failure_detection_reset
                                                 ;
                                                 step = sensor_failure_detection_step }
type ('c , 'b , 'a) _normal_mode_detection =
  { mutable i_913 : 'c ; mutable m_911 : 'b ; mutable m_909 : 'a }

let normal_mode_detection  = 
  
  let normal_mode_detection_alloc _ =
    ();
    { i_913 = (false:bool) ;
      m_911 = (false:bool) ; m_909 = (Obj.magic ():MyOp.t) } in
  let normal_mode_detection_reset self  =
    ((self.i_913 <- true ; self.m_911 <- false):unit) in 
  let normal_mode_detection_step self () =
    (((if self.i_913 then self.m_909 <- MyOp.make 0.) ;
      self.i_913 <- false ;
      (let (x_912:bool) = self.m_911 in
       let (x_910:MyOp.t) = self.m_909 in
       let (normal_mode_start_time_906:MyOp.t) = MyOp.make 10. in
       let (normal_mode_905:bool) =
           (||) ((>=) x_910  normal_mode_start_time_906)  x_912 in
       self.m_911 <- normal_mode_905 ;
       (let (samp_time_907:MyOp.t) = MyOp.make 0.01 in
        self.m_909 <- MyOp.(+) x_910  samp_time_907 ; normal_mode_905))):
    bool) in
  Node { alloc = normal_mode_detection_alloc; reset = normal_mode_detection_reset
                                              ;
                                              step = normal_mode_detection_step }
type ('b , 'a) _power_mode_detection =
  { mutable m_919 : 'b ; mutable m_917 : 'a }

let power_mode_detection  = 
  
  let power_mode_detection_alloc _ =
    ();{ m_919 = (false:bool) ; m_917 = (false:bool) } in
  let power_mode_detection_reset self  =
    ((self.m_919 <- false ; self.m_917 <- false):unit) in 
  let power_mode_detection_step self (throttle_angle_914:MyOp.t) =
    ((let (x_920:bool) = self.m_919 in
      let (thresh_916:MyOp.t) =
          if x_920 then MyOp.make 50. else MyOp.make 70. in
      let (x_918:bool) = self.m_917 in
      let (power_on_915:bool) =
          (||) ((>=) throttle_angle_914  thresh_916)  x_918 in
      self.m_919 <- power_on_915 ; self.m_917 <- power_on_915 ; power_on_915):
    bool) in
  Node { alloc = power_mode_detection_alloc; reset = power_mode_detection_reset
                                             ;
                                             step = power_mode_detection_step }
type _feedforward_controller = unit

let feedforward_controller  = 
   let feedforward_controller_alloc _ = () in
  let feedforward_controller_reset self  =
    ((()):unit) in 
  let feedforward_controller_step self ((estimated_cyl_air_flow_922:MyOp.t) ,
                                        (abf_ref_921:MyOp.t)) =
    ((let (desired_fuel_mass_923:MyOp.t) =
          MyOp.(/) estimated_cyl_air_flow_922  abf_ref_921 in
      desired_fuel_mass_923):MyOp.t) in
  Node { alloc = feedforward_controller_alloc; reset = feedforward_controller_reset
                                               ;
                                               step = feedforward_controller_step }
type ('b , 'a) _air_estimation =
  { mutable i_931 : 'b ; mutable m_929 : 'a }

let air_estimation  = 
  
  let air_estimation_alloc _ =
    ();{ i_931 = (false:bool) ; m_929 = (Obj.magic ():MyOp.t) } in
  let air_estimation_reset self  =
    (self.i_931 <- true:unit) in 
  let air_estimation_step self ((throttle_flow_925:MyOp.t) ,
                                (engine_speed_924:MyOp.t)) =
    (((if self.i_931 then self.m_929 <- MyOp.make 0.982) ;
      self.i_931 <- false ;
      (let (x_930:MyOp.t) = self.m_929 in
       let (estimated_cyl_air_flow_928:MyOp.t) =
           MyOp.translate (MyOp.(+) (MyOp.(-) (MyOp.scale (MyOp.( * ) 
                                                             engine_speed_924
                                                              x_930)  
                                                          0.08979) 
                                              (MyOp.scale (MyOp.( * ) 
                                                             (MyOp.( * ) 
                                                                x_930  x_930)
                                                             
                                                             engine_speed_924)
                                                           0.0337)) 
                                    (MyOp.scale (MyOp.( * ) (MyOp.( * ) 
                                                               engine_speed_924
                                                               
                                                               engine_speed_924)
                                                             x_930)  
                                                0.0001))  (-0.366) in
       let (aux'_927:MyOp.t) =
           MyOp.(+) x_930 
                    (MyOp.scale (MyOp.(-) throttle_flow_925 
                                          estimated_cyl_air_flow_928) 
                                (( *. ) 0.01  0.41328)) in
       self.m_929 <- aux'_927 ; estimated_cyl_air_flow_928)):MyOp.t) in
  Node { alloc = air_estimation_alloc; reset = air_estimation_reset ;
                                       step = air_estimation_step }
type ('b , 'a) _feedback_PI_controller =
  { mutable i_939 : 'b ; mutable m_936 : 'a }

let feedback_PI_controller  = 
  
  let feedback_PI_controller_alloc _ =
    ();{ i_939 = (false:bool) ; m_936 = (Obj.magic ():MyOp.t) } in
  let feedback_PI_controller_reset self  =
    (self.i_939 <- true:unit) in 
  let feedback_PI_controller_step self ((abf_ref_933:MyOp.t) ,
                                        (abf_meas_932:MyOp.t)) =
    ((let (x_938:MyOp.t) =
          if self.i_939
          then MyOp.make 0.
          else
            MyOp.(+) self.m_936 
                     (MyOp.scale (MyOp.(-) abf_meas_932  abf_ref_933) 
                                 (( *. ) 0.01  0.14)) in
      self.i_939 <- false ;
      self.m_936 <- x_938 ;
      (let (closed_loop_fuel_trim_935:MyOp.t) =
           MyOp.(+) (MyOp.scale (MyOp.(-) abf_meas_932  abf_ref_933)  0.04) 
                    x_938 in
       closed_loop_fuel_trim_935)):MyOp.t) in
  Node { alloc = feedback_PI_controller_alloc; reset = feedback_PI_controller_reset
                                               ;
                                               step = feedback_PI_controller_step }
type ('q ,
      'p ,
      'o ,
      'n , 'm , 'l , 'k , 'j , 'i , 'h , 'g , 'f , 'e , 'd , 'c , 'b , 'a) _af_controller =
  { mutable i_1337 : 'q ;
    mutable i_1336 : 'p ;
    mutable i_1335 : 'o ;
    mutable i_1334 : 'n ;
    mutable i_1333 : 'm ;
    mutable i_1332 : 'l ;
    mutable i_979 : 'k ;
    mutable m_977 : 'j ;
    mutable m_975 : 'i ;
    mutable pulse_width_969 : 'h ;
    mutable mode_947 : 'g ;
    mutable commanded_fuel_946 : 'f ;
    mutable abf_ref_945 : 'e ;
    mutable i_1003 : 'd ;
    mutable m_1001 : 'c ; mutable m_999 : 'b ; mutable m_996 : 'a }

let af_controller  = 
  let Node { alloc = i_1337_alloc; step = i_1337_step ; reset = i_1337_reset } = power_mode_detection 
   in 
  let Node { alloc = i_1336_alloc; step = i_1336_step ; reset = i_1336_reset } = sensor_failure_detection 
   in 
  let Node { alloc = i_1335_alloc; step = i_1335_step ; reset = i_1335_reset } = feedback_PI_controller 
   in 
  let Node { alloc = i_1334_alloc; step = i_1334_step ; reset = i_1334_reset } = feedforward_controller 
   in 
  let Node { alloc = i_1333_alloc; step = i_1333_step ; reset = i_1333_reset } = fup 
   in 
  let Node { alloc = i_1332_alloc; step = i_1332_step ; reset = i_1332_reset } = fup 
   in
  let af_controller_alloc _ =
    ();
    { i_979 = (false:bool) ;
      m_977 = (Obj.magic ():MyOp.t) ;
      m_975 = (Obj.magic ():MyOp.t) ;
      pulse_width_969 = (Obj.magic ():MyOp.t) ;
      mode_947 = (Obj.magic ():MyOp.t) ;
      commanded_fuel_946 = (Obj.magic ():MyOp.t) ;
      abf_ref_945 = (Obj.magic ():MyOp.t) ;
      i_1003 = (false:bool) ;
      m_1001 = (false:bool) ;
      m_999 = (Obj.magic ():MyOp.t) ; m_996 = (Obj.magic ():MyOp.t);
      i_1337 = i_1337_alloc () (* discrete *)  ;
      i_1336 = i_1336_alloc () (* discrete *)  ;
      i_1335 = i_1335_alloc () (* discrete *)  ;
      i_1334 = i_1334_alloc () (* discrete *)  ;
      i_1333 = i_1333_alloc () (* discrete *)  ;
      i_1332 = i_1332_alloc () (* discrete *)  } in
  let af_controller_reset self  =
    ((self.i_979 <- true ;
      self.i_1003 <- true ;
      self.m_1001 <- false ;
      i_1337_reset self.i_1337  ;
      i_1336_reset self.i_1336  ;
      i_1335_reset self.i_1335  ;
      i_1334_reset self.i_1334  ;
      i_1333_reset self.i_1333  ; i_1332_reset self.i_1332 ):unit) in 
  let af_controller_step self ((tstep_944:MyOp.t) ,
                               (engine_speed_941:MyOp.t) ,
                               (throttle_angle_942:MyOp.t) ,
                               (throttle_flow_943:MyOp.t) ,
                               (abf_meas_940:MyOp.t)) =
    (((if self.i_979 then self.abf_ref_945 <- MyOp.make 0.) ;
      (if self.i_979 then self.mode_947 <- MyOp.make 0.) ;
      (if self.i_979 then self.commanded_fuel_946 <- MyOp.make 0.1726) ;
      (let (y0_967:MyOp.t) = MyOp.make 0. in
       (if self.i_979 then self.m_977 <- y0_967) ;
       (let (p_961:MyOp.t) = MyOp.make 0.01 in
        let (w_963:MyOp.t) = MyOp.make 0.5 in
        (if self.i_979 then self.pulse_width_969 <- MyOp.( * ) p_961  w_963)
        ;
        (let (y0_957:MyOp.t) = MyOp.make 0. in
         (if self.i_979 then self.m_975 <- y0_957) ;
         self.i_979 <- false ;
         (let (a_959:MyOp.t) = MyOp.make 1. in
          let (delay_960:MyOp.t) = MyOp.make 0.01 in
          let (x_978:MyOp.t) = self.m_977 in
          let (pulse_rel_970:MyOp.t) =
              MyOp.mod_t (MyOp.(-) x_978  delay_960)  p_961 in
          let (pulse_is_on_971:bool) =
              (<=) pulse_rel_970  self.pulse_width_969 in
          let (trigger_10ms_948:MyOp.t) =
              if (&&) ((>=) x_978  delay_960)  pulse_is_on_971
              then a_959
              else MyOp.make 0. in
          let (y0_952:MyOp.t) = MyOp.make 0. in
          let (t0_950:MyOp.t) = MyOp.make 0.001 in
          let (y1_953:MyOp.t) = MyOp.make 1. in
          let (x_976:MyOp.t) = self.m_975 in
          let (trigger_pwon_949:MyOp.t) =
              if (<=) x_976  t0_950 then y0_952 else y1_953 in
          (begin match ((i_1332_step self.i_1332 trigger_10ms_948) ,
                        (i_1333_step self.i_1333 trigger_pwon_949) ,
                        ((<) trigger_10ms_948  (MyOp.make 0.5))) with
                 | (_ , true , true) ->
                     self.abf_ref_945 <- MyOp.make 14.7 ;
                     self.mode_947 <- MyOp.make 1. ;
                     self.commanded_fuel_946 <- MyOp.make 0.1726
                 | (true , _ , _) ->
                     (if self.i_1003 then self.m_999 <- MyOp.make 0.) ;
                     (if self.i_1003 then self.m_996 <- MyOp.make 0.982) ;
                     self.i_1003 <- false ;
                     (let (x_1002:bool) = self.m_1001 in
                      let (x_1000:MyOp.t) = self.m_999 in
                      let (normal_mode_start_time_993:MyOp.t) = MyOp.make 10. in
                      let (normal_mode_992:bool) =
                          (||) ((>=) x_1000  normal_mode_start_time_993) 
                               x_1002 in
                      self.m_1001 <- normal_mode_992 ;
                      (let (samp_time_994:MyOp.t) = MyOp.make 0.01 in
                       self.m_999 <- MyOp.(+) x_1000  samp_time_994 ;
                       (let (x_997:MyOp.t) = self.m_996 in
                        let (estimated_cyl_air_flow_991:MyOp.t) =
                            MyOp.translate (MyOp.(+) (MyOp.(-) (MyOp.scale 
                                                                  (MyOp.( * ) 
                                                                    engine_speed_941
                                                                     
                                                                    x_997) 
                                                                  0.08979) 
                                                               (MyOp.scale 
                                                                  (MyOp.( * ) 
                                                                    (
                                                                    MyOp.( * ) 
                                                                    x_997 
                                                                    x_997) 
                                                                    engine_speed_941)
                                                                   0.0337)) 
                                                     (MyOp.scale (MyOp.( * ) 
                                                                    (
                                                                    MyOp.( * ) 
                                                                    engine_speed_941
                                                                    
                                                                    engine_speed_941)
                                                                     
                                                                    x_997) 
                                                                 0.0001)) 
                                           (-0.366) in
                        let (aux'_990:MyOp.t) =
                            MyOp.(+) x_997 
                                     (MyOp.scale (MyOp.(-) throttle_flow_943 
                                                           estimated_cyl_air_flow_991)
                                                  (( *. ) 0.01  0.41328)) in
                        self.m_996 <- aux'_990 ;
                        (let (power_on_986:bool) =
                             i_1337_step self.i_1337 throttle_angle_942 in
                         let (fail_on_984:bool) =
                             i_1336_step self.i_1336 abf_meas_940 in
                         self.mode_947 <- (if (||) ((||) fail_on_984 
                                                         (not normal_mode_992))
                                                    power_on_986
                                           then MyOp.make 1.
                                           else MyOp.make 0.) ;
                         self.abf_ref_945 <- (if (&&) normal_mode_992 
                                                      power_on_986
                                              then MyOp.make 12.5
                                              else MyOp.make 14.7) ;
                         (let (x_998:MyOp.t) =
                              MyOp.translate (i_1335_step self.i_1335
                                                (self.abf_ref_945 ,
                                                 abf_meas_940))  1. in
                          let (fb_fuel_983:MyOp.t) =
                              if (>) self.mode_947  (MyOp.make 0.5)
                              then MyOp.make 1.
                              else x_998 in
                          let (fb_fuel_sat_982:MyOp.t) =
                              saturate ((MyOp.make 0.) ,
                                        MyOp.infinity , fb_fuel_983) in
                          let (desired_fuel_mass_981:MyOp.t) =
                              i_1334_step self.i_1334
                                (estimated_cyl_air_flow_991 ,
                                 self.abf_ref_945) in
                          self.commanded_fuel_946 <- saturate ((MyOp.make 
                                                                  0.13) ,
                                                               (MyOp.make 
                                                                  1.66) ,
                                                               (MyOp.( * ) 
                                                                  desired_fuel_mass_981
                                                                  
                                                                  fb_fuel_sat_982)))))))
                 | _ -> ()  end) ;
          (let (dy_965:MyOp.t) = MyOp.make 1. in
           self.m_977 <- MyOp.(+) (MyOp.( * ) tstep_944  dy_965)  x_978 ;
           (let (dy_955:MyOp.t) = MyOp.make 1. in
            self.m_975 <- MyOp.(+) (MyOp.( * ) tstep_944  dy_955)  x_976 ;
            (self.commanded_fuel_946 , self.mode_947 , self.abf_ref_945)))))))):
    MyOp.t * MyOp.t * MyOp.t) in
  Node { alloc = af_controller_alloc; reset = af_controller_reset ;
                                      step = af_controller_step }
type ('b , 'a) _model_1_transfer_fn =
  { mutable i_1014 : 'b ; mutable m_1012 : 'a }

let model_1_transfer_fn  = 
  
  let model_1_transfer_fn_alloc _ =
    ();{ i_1014 = (false:bool) ; m_1012 = (Obj.magic ():MyOp.t) } in
  let model_1_transfer_fn_reset self  =
    (self.i_1014 <- true:unit) in 
  let model_1_transfer_fn_step self ((tstep_1004:MyOp.t) , (x_1005:MyOp.t)) =
    ((let (y0_1010:MyOp.t) = MyOp.make 0. in
      (if self.i_1014 then self.m_1012 <- y0_1010) ;
      self.i_1014 <- false ;
      (let (x_1013:MyOp.t) = self.m_1012 in
       let (dy_1006:MyOp.t) = MyOp.scale (MyOp.(-) x_1005  x_1013)  10. in
       self.m_1012 <- MyOp.(+) (MyOp.( * ) tstep_1004  dy_1006)  x_1013 ;
       x_1013)):MyOp.t) in
  Node { alloc = model_1_transfer_fn_alloc; reset = model_1_transfer_fn_reset
                                            ; step = model_1_transfer_fn_step }
let atmospheric_pressure = MyOp.make 1.

type ('z ,
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
      'n , 'm , 'l , 'k , 'j , 'i , 'h , 'g , 'f , 'e , 'd , 'c , 'b , 'a) _model_1 =
  { mutable i_1347 : 'z ;
    mutable i_1346 : 'y ;
    mutable i_1345 : 'x ;
    mutable i_1344 : 'w ;
    mutable i_1343 : 'v ;
    mutable i_1342 : 'u ;
    mutable i_1341 : 't ;
    mutable i_1340 : 's ;
    mutable i_1339 : 'r ;
    mutable i_1338 : 'q ;
    mutable i_1134 : 'p ;
    mutable m_1132 : 'o ;
    mutable m_1130 : 'n ;
    mutable m_1128 : 'm ;
    mutable m_1126 : 'l ;
    mutable m_1124 : 'k ;
    mutable m_1122 : 'j ;
    mutable m_1120 : 'i ;
    mutable pulse_width_1114 : 'h ;
    mutable mode_1092 : 'g ;
    mutable commanded_fuel_1091 : 'f ;
    mutable abf_ref_1090 : 'e ;
    mutable i_1158 : 'd ;
    mutable m_1156 : 'c ; mutable m_1154 : 'b ; mutable m_1151 : 'a }

let model_1  = 
  let Node { alloc = i_1347_alloc; step = i_1347_step ; reset = i_1347_reset } = throttle 
   in 
  let Node { alloc = i_1346_alloc; step = i_1346_step ; reset = i_1346_reset } = power_mode_detection 
   in 
  let Node { alloc = i_1345_alloc; step = i_1345_step ; reset = i_1345_reset } = sensor_failure_detection 
   in 
  let Node { alloc = i_1344_alloc; step = i_1344_step ; reset = i_1344_reset } = feedback_PI_controller 
   in 
  let Node { alloc = i_1343_alloc; step = i_1343_step ; reset = i_1343_reset } = feedforward_controller 
   in 
  let Node { alloc = i_1342_alloc; step = i_1342_step ; reset = i_1342_reset } = fup 
   in 
  let Node { alloc = i_1341_alloc; step = i_1341_step ; reset = i_1341_reset } = fup 
   in 
  let Node { alloc = i_1340_alloc; step = i_1340_step ; reset = i_1340_reset } = wall_wetting 
   in 
  let Node { alloc = i_1339_alloc; step = i_1339_step ; reset = i_1339_reset } = integrate 
   in 
  let Node { alloc = i_1338_alloc; step = i_1338_step ; reset = i_1338_reset } = Afc_utils.fuel_transport_delay 
   in
  let model_1_alloc _ =
    ();
    { i_1134 = (false:bool) ;
      m_1132 = (Obj.magic ():MyOp.t) ;
      m_1130 = (Obj.magic ():MyOp.t) ;
      m_1128 = (Obj.magic ():MyOp.t) ;
      m_1126 = (Obj.magic ():MyOp.t) ;
      m_1124 = (Obj.magic ():MyOp.t) ;
      m_1122 = (Obj.magic ():MyOp.t) ;
      m_1120 = (Obj.magic ():MyOp.t) ;
      pulse_width_1114 = (Obj.magic ():MyOp.t) ;
      mode_1092 = (Obj.magic ():MyOp.t) ;
      commanded_fuel_1091 = (Obj.magic ():MyOp.t) ;
      abf_ref_1090 = (Obj.magic ():MyOp.t) ;
      i_1158 = (false:bool) ;
      m_1156 = (false:bool) ;
      m_1154 = (Obj.magic ():MyOp.t) ; m_1151 = (Obj.magic ():MyOp.t);
      i_1347 = i_1347_alloc () (* discrete *)  ;
      i_1346 = i_1346_alloc () (* discrete *)  ;
      i_1345 = i_1345_alloc () (* discrete *)  ;
      i_1344 = i_1344_alloc () (* discrete *)  ;
      i_1343 = i_1343_alloc () (* discrete *)  ;
      i_1342 = i_1342_alloc () (* discrete *)  ;
      i_1341 = i_1341_alloc () (* discrete *)  ;
      i_1340 = i_1340_alloc () (* discrete *)  ;
      i_1339 = i_1339_alloc () (* discrete *)  ;
      i_1338 = i_1338_alloc () (* discrete *)  } in
  let model_1_reset self  =
    ((self.i_1134 <- true ;
      i_1347_reset self.i_1347  ;
      self.i_1158 <- true ;
      self.m_1156 <- false ;
      i_1346_reset self.i_1346  ;
      i_1345_reset self.i_1345  ;
      i_1344_reset self.i_1344  ;
      i_1343_reset self.i_1343  ;
      i_1342_reset self.i_1342  ;
      i_1341_reset self.i_1341  ;
      i_1340_reset self.i_1340  ;
      i_1339_reset self.i_1339  ; i_1338_reset self.i_1338 ):unit) in 
  let model_1_step self ((tstep_1017:MyOp.t) ,
                         (throttle_in_1016:MyOp.t) ,
                         (engine_speed_1015:MyOp.t)) =
    (((if self.i_1134 then self.abf_ref_1090 <- MyOp.make 0.) ;
      (if self.i_1134 then self.mode_1092 <- MyOp.make 0.) ;
      (if self.i_1134 then self.commanded_fuel_1091 <- MyOp.make 0.1726) ;
      (let (y0_1112:MyOp.t) = MyOp.make 0. in
       (if self.i_1134 then self.m_1132 <- y0_1112) ;
       (let (p_1106:MyOp.t) = MyOp.make 0.01 in
        let (w_1108:MyOp.t) = MyOp.make 0.5 in
        (if self.i_1134 then
         self.pulse_width_1114 <- MyOp.( * ) p_1106  w_1108) ;
        (let (y0_1102:MyOp.t) = MyOp.make 0. in
         (if self.i_1134 then self.m_1130 <- y0_1102) ;
         (let (y0_1083:MyOp.t) = MyOp.make 0. in
          (if self.i_1134 then self.m_1128 <- y0_1083) ;
          (let (y0_1074:MyOp.t) = MyOp.make 14.7 in
           (if self.i_1134 then self.m_1126 <- y0_1074) ;
           (let (y0_1070:MyOp.t) = MyOp.make 14.7 in
            (if self.i_1134 then self.m_1124 <- y0_1070) ;
            (let (y0_1050:MyOp.t) = MyOp.make 0.982 in
             (if self.i_1134 then self.m_1122 <- y0_1050) ;
             (let (y0_1039:MyOp.t) = MyOp.make 0. in
              (if self.i_1134 then self.m_1120 <- y0_1039) ;
              self.i_1134 <- false ;
              (let (dy_1110:MyOp.t) = MyOp.make 1. in
               let (x_1133:MyOp.t) = self.m_1132 in
               self.m_1132 <- MyOp.(+) (MyOp.( * ) tstep_1017  dy_1110) 
                                       x_1133 ;
               (let (dy_1100:MyOp.t) = MyOp.make 1. in
                let (x_1131:MyOp.t) = self.m_1130 in
                self.m_1130 <- MyOp.(+) (MyOp.( * ) tstep_1017  dy_1100) 
                                        x_1131 ;
                (let (omega_1029:MyOp.t) =
                     MyOp.scale (saturate ((MyOp.make 900.) ,
                                           (MyOp.make 1100.) ,
                                           engine_speed_1015)) 
                                Afc_utils.rpm2rad in
                 let (x_1121:MyOp.t) = self.m_1120 in
                 let (throttle_angle_1030:MyOp.t) =
                     saturate ((MyOp.make 0.) ,
                               (MyOp.make 90.) , (MyOp.translate x_1121  8.8)) in
                 let (x_1123:MyOp.t) = self.m_1122 in
                 let (throttle_flow_1032:MyOp.t) =
                     i_1347_step self.i_1347
                       (throttle_angle_1030 , x_1123 , atmospheric_pressure) in
                 let (throttle_flow_1088:MyOp.t) =
                     MyOp.scale throttle_flow_1032  Afc_utils.maf_sensor_tol in
                 let (y0_1078:MyOp.t) = MyOp.make 0. in
                 let (t0_1076:MyOp.t) = MyOp.make Afc_utils.fault_time in
                 let (y1_1079:MyOp.t) = MyOp.make 1. in
                 let (x_1129:MyOp.t) = self.m_1128 in
                 let (af_sensor_1021:MyOp.t) =
                     if (<=) x_1129  t0_1076 then y0_1078 else y1_1079 in
                 let (x_1125:MyOp.t) = self.m_1124 in
                 let (abf_1057:MyOp.t) =
                     MyOp.scale x_1125  Afc_utils.af_sensor_tol in
                 let (abf_meas_1058:MyOp.t) =
                     if (>=) af_sensor_1021  (MyOp.make 0.5)
                     then MyOp.make (-1.)
                     else abf_1057 in
                 let (abf_meas_1085:MyOp.t) =
                     MyOp.scale abf_meas_1058  Afc_utils.af_sensor_tol in
                 let (a_1104:MyOp.t) = MyOp.make 1. in
                 let (delay_1105:MyOp.t) = MyOp.make 0.01 in
                 let (pulse_rel_1115:MyOp.t) =
                     MyOp.mod_t (MyOp.(-) x_1133  delay_1105)  p_1106 in
                 let (pulse_is_on_1116:bool) =
                     (<=) pulse_rel_1115  self.pulse_width_1114 in
                 let (trigger_10ms_1093:MyOp.t) =
                     if (&&) ((>=) x_1133  delay_1105)  pulse_is_on_1116
                     then a_1104
                     else MyOp.make 0. in
                 let (y0_1097:MyOp.t) = MyOp.make 0. in
                 let (t0_1095:MyOp.t) = MyOp.make 0.001 in
                 let (y1_1098:MyOp.t) = MyOp.make 1. in
                 let (trigger_pwon_1094:MyOp.t) =
                     if (<=) x_1131  t0_1095 then y0_1097 else y1_1098 in
                 (begin match ((i_1341_step self.i_1341 trigger_10ms_1093) ,
                               (i_1342_step self.i_1342 trigger_pwon_1094) ,
                               ((<) trigger_10ms_1093  (MyOp.make 0.5))) with
                        | (_ , true , true) ->
                            self.abf_ref_1090 <- MyOp.make 14.7 ;
                            self.mode_1092 <- MyOp.make 1. ;
                            self.commanded_fuel_1091 <- MyOp.make 0.1726
                        | (true , _ , _) ->
                            (if self.i_1158 then self.m_1154 <- MyOp.make 0.)
                            ;
                            (if self.i_1158 then
                             self.m_1151 <- MyOp.make 0.982) ;
                            self.i_1158 <- false ;
                            (let (x_1157:bool) = self.m_1156 in
                             let (x_1155:MyOp.t) = self.m_1154 in
                             let (normal_mode_start_time_1148:MyOp.t) =
                                 MyOp.make 10. in
                             let (normal_mode_1147:bool) =
                                 (||) ((>=) x_1155 
                                            normal_mode_start_time_1148) 
                                      x_1157 in
                             self.m_1156 <- normal_mode_1147 ;
                             (let (samp_time_1149:MyOp.t) = MyOp.make 0.01 in
                              self.m_1154 <- MyOp.(+) x_1155  samp_time_1149
                              ;
                              (let (x_1152:MyOp.t) = self.m_1151 in
                               let (estimated_cyl_air_flow_1146:MyOp.t) =
                                   MyOp.translate (MyOp.(+) (MyOp.(-) 
                                                               (MyOp.scale 
                                                                  (MyOp.( * ) 
                                                                    omega_1029
                                                                     
                                                                    x_1152) 
                                                                  0.08979) 
                                                               (MyOp.scale 
                                                                  (MyOp.( * ) 
                                                                    (
                                                                    MyOp.( * ) 
                                                                    x_1152 
                                                                    x_1152) 
                                                                    omega_1029)
                                                                   0.0337)) 
                                                            (MyOp.scale 
                                                               (MyOp.( * ) 
                                                                  (MyOp.( * ) 
                                                                    omega_1029
                                                                    
                                                                    omega_1029)
                                                                   x_1152) 
                                                               0.0001)) 
                                                  (-0.366) in
                               let (aux'_1145:MyOp.t) =
                                   MyOp.(+) x_1152 
                                            (MyOp.scale (MyOp.(-) throttle_flow_1088
                                                                  
                                                                  estimated_cyl_air_flow_1146)
                                                        
                                                        (( *. ) 0.01  0.41328)) in
                               self.m_1151 <- aux'_1145 ;
                               (let (power_on_1141:bool) =
                                    i_1346_step self.i_1346
                                      throttle_angle_1030 in
                                let (fail_on_1139:bool) =
                                    i_1345_step self.i_1345 abf_meas_1085 in
                                self.mode_1092 <- (if (||) ((||) fail_on_1139
                                                                 
                                                                 (not 
                                                                    normal_mode_1147))
                                                            power_on_1141
                                                   then MyOp.make 1.
                                                   else MyOp.make 0.) ;
                                self.abf_ref_1090 <- (if (&&) normal_mode_1147
                                                               power_on_1141
                                                      then MyOp.make 12.5
                                                      else MyOp.make 14.7) ;
                                (let (x_1153:MyOp.t) =
                                     MyOp.translate (i_1344_step self.i_1344
                                                       (self.abf_ref_1090 ,
                                                        abf_meas_1085))  
                                                    1. in
                                 let (fb_fuel_1138:MyOp.t) =
                                     if (>) self.mode_1092  (MyOp.make 0.5)
                                     then MyOp.make 1.
                                     else x_1153 in
                                 let (fb_fuel_sat_1137:MyOp.t) =
                                     saturate ((MyOp.make 0.) ,
                                               MyOp.infinity , fb_fuel_1138) in
                                 let (desired_fuel_mass_1136:MyOp.t) =
                                     i_1343_step self.i_1343
                                       (estimated_cyl_air_flow_1146 ,
                                        self.abf_ref_1090) in
                                 self.commanded_fuel_1091 <- saturate 
                                                               ((MyOp.make 
                                                                   0.13) ,
                                                                (MyOp.make 
                                                                   1.66) ,
                                                                (MyOp.( * ) 
                                                                   desired_fuel_mass_1136
                                                                   
                                                                   fb_fuel_sat_1137)))))))
                        | _ -> ()  end) ;
                 (let (dy_1081:MyOp.t) = MyOp.make 1. in
                  self.m_1128 <- MyOp.(+) (MyOp.( * ) tstep_1017  dy_1081) 
                                          x_1129 ;
                  (let (pumping_1047:MyOp.t) =
                       MyOp.translate (MyOp.(+) (MyOp.(-) (MyOp.scale 
                                                             (MyOp.( * ) 
                                                                x_1123 
                                                                omega_1029) 
                                                             0.08979) 
                                                          (MyOp.scale 
                                                             (MyOp.( * ) 
                                                                (MyOp.( * ) 
                                                                   omega_1029
                                                                    x_1123) 
                                                                x_1123) 
                                                             0.0337)) 
                                                (MyOp.scale (MyOp.( * ) 
                                                               (MyOp.( * ) 
                                                                  x_1123 
                                                                  omega_1029)
                                                                omega_1029) 
                                                            0.0001)) 
                                      (-0.366) in
                   let (cyl_air_1044:MyOp.t) = MyOp.scale pumping_1047  0.9 in
                   let (fuel_injected_1026:MyOp.t) =
                       MyOp.scale self.commanded_fuel_1091 
                                  Afc_utils.fuel_inj_tol in
                   let (cyl_air_charge_1060:MyOp.t) =
                       MyOp.scale (MyOp.(/) cyl_air_1044  omega_1029) 
                                  Afc_utils.pi in
                   let (cyl_fuel_1025:MyOp.t) =
                       i_1340_step self.i_1340
                         (tstep_1017 ,
                          fuel_injected_1026 ,
                          omega_1029 , cyl_air_charge_1060) in
                   let (cur_abf_1059:MyOp.t) =
                       MyOp.(/) cyl_air_1044  cyl_fuel_1025 in
                   let (delay_1061:MyOp.t) =
                       Afc_utils.lookup_delay ((MyOp.scale omega_1029 
                                                           Afc_utils.rad2rpm)
                                               , cyl_air_charge_1060) in
                   let (t_1064:MyOp.t) =
                       i_1339_step self.i_1339
                         (tstep_1017 , (MyOp.make 1.) , (MyOp.make 0.)) in
                   let (delayed_1062:MyOp.t) =
                       i_1338_step self.i_1338
                         (t_1064 , cur_abf_1059 , delay_1061) in
                   let (x_1127:MyOp.t) = self.m_1126 in
                   let (dy_1072:MyOp.t) =
                       MyOp.scale (MyOp.(-) delayed_1062  x_1127)  10. in
                   self.m_1126 <- MyOp.(+) (MyOp.( * ) tstep_1017  dy_1072) 
                                           x_1127 ;
                   (let (dy_1068:MyOp.t) =
                        MyOp.scale (MyOp.(-) x_1127  x_1125)  50. in
                    self.m_1124 <- MyOp.(+) (MyOp.( * ) tstep_1017  dy_1068) 
                                            x_1125 ;
                    (let (dmanifold_pressure_1045:MyOp.t) =
                         MyOp.scale (MyOp.(-) throttle_flow_1032 
                                              cyl_air_1044)  0.41328 in
                     self.m_1122 <- MyOp.(+) (MyOp.( * ) tstep_1017 
                                                         dmanifold_pressure_1045)
                                              x_1123 ;
                     (let (dy_1035:MyOp.t) =
                          MyOp.scale (MyOp.(-) throttle_in_1016  x_1121)  10. in
                      self.m_1120 <- MyOp.(+) (MyOp.( * ) tstep_1017  dy_1035)
                                               x_1121 ;
                      (abf_1057 , self.abf_ref_1090 , self.mode_1092)))))))))))))))))):
    MyOp.t * MyOp.t * MyOp.t) in
  Node { alloc = model_1_alloc; reset = model_1_reset ; step = model_1_step }
type ('b1 ,
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
      'n , 'm , 'l , 'k , 'j , 'i , 'h , 'g , 'f , 'e , 'd , 'c , 'b , 'a) _afc =
  { mutable i_1358 : 'b1 ;
    mutable i_1357 : 'a1 ;
    mutable i_1356 : 'z ;
    mutable i_1355 : 'y ;
    mutable i_1354 : 'x ;
    mutable i_1353 : 'w ;
    mutable i_1352 : 'v ;
    mutable i_1351 : 'u ;
    mutable i_1350 : 't ;
    mutable i_1349 : 's ;
    mutable i_1348 : 'r ;
    mutable i_1286 : 'q ;
    mutable m_1284 : 'p ;
    mutable m_1282 : 'o ;
    mutable m_1280 : 'n ;
    mutable m_1278 : 'm ;
    mutable m_1276 : 'l ;
    mutable m_1274 : 'k ;
    mutable m_1272 : 'j ;
    mutable pulse_width_1266 : 'i ;
    mutable mode_1244 : 'h ;
    mutable commanded_fuel_1243 : 'g ;
    mutable abf_ref_1242 : 'f ;
    mutable tstep'_1166 : 'e ;
    mutable i_1310 : 'd ;
    mutable m_1308 : 'c ; mutable m_1306 : 'b ; mutable m_1303 : 'a }

let afc (tstep_1161:float) = 
  let Node { alloc = i_1358_alloc; step = i_1358_step ; reset = i_1358_reset } = throttle 
   in 
  let Node { alloc = i_1357_alloc; step = i_1357_step ; reset = i_1357_reset } = power_mode_detection 
   in 
  let Node { alloc = i_1356_alloc; step = i_1356_step ; reset = i_1356_reset } = sensor_failure_detection 
   in 
  let Node { alloc = i_1355_alloc; step = i_1355_step ; reset = i_1355_reset } = feedback_PI_controller 
   in 
  let Node { alloc = i_1354_alloc; step = i_1354_step ; reset = i_1354_reset } = feedforward_controller 
   in 
  let Node { alloc = i_1353_alloc; step = i_1353_step ; reset = i_1353_reset } = fup 
   in 
  let Node { alloc = i_1352_alloc; step = i_1352_step ; reset = i_1352_reset } = fup 
   in 
  let Node { alloc = i_1351_alloc; step = i_1351_step ; reset = i_1351_reset } = wall_wetting 
   in 
  let Node { alloc = i_1350_alloc; step = i_1350_step ; reset = i_1350_reset } = integrate 
   in 
  let Node { alloc = i_1349_alloc; step = i_1349_step ; reset = i_1349_reset } = Afc_utils.fuel_transport_delay 
   in 
  let Node { alloc = i_1348_alloc; step = i_1348_step ; reset = i_1348_reset } = vv_stub 
   in
  let afc_alloc _ =
    ();
    { i_1286 = (false:bool) ;
      m_1284 = (Obj.magic ():MyOp.t) ;
      m_1282 = (Obj.magic ():MyOp.t) ;
      m_1280 = (Obj.magic ():MyOp.t) ;
      m_1278 = (Obj.magic ():MyOp.t) ;
      m_1276 = (Obj.magic ():MyOp.t) ;
      m_1274 = (Obj.magic ():MyOp.t) ;
      m_1272 = (Obj.magic ():MyOp.t) ;
      pulse_width_1266 = (Obj.magic ():MyOp.t) ;
      mode_1244 = (Obj.magic ():MyOp.t) ;
      commanded_fuel_1243 = (Obj.magic ():MyOp.t) ;
      abf_ref_1242 = (Obj.magic ():MyOp.t) ;
      tstep'_1166 = (Obj.magic ():MyOp.t) ;
      i_1310 = (false:bool) ;
      m_1308 = (false:bool) ;
      m_1306 = (Obj.magic ():MyOp.t) ; m_1303 = (Obj.magic ():MyOp.t);
      i_1358 = i_1358_alloc () (* discrete *)  ;
      i_1357 = i_1357_alloc () (* discrete *)  ;
      i_1356 = i_1356_alloc () (* discrete *)  ;
      i_1355 = i_1355_alloc () (* discrete *)  ;
      i_1354 = i_1354_alloc () (* discrete *)  ;
      i_1353 = i_1353_alloc () (* discrete *)  ;
      i_1352 = i_1352_alloc () (* discrete *)  ;
      i_1351 = i_1351_alloc () (* discrete *)  ;
      i_1350 = i_1350_alloc () (* discrete *)  ;
      i_1349 = i_1349_alloc () (* discrete *)  ;
      i_1348 = i_1348_alloc () (* discrete *)  } in
  let afc_reset self  =
    ((self.i_1286 <- true ;
      i_1358_reset self.i_1358  ;
      self.i_1310 <- true ;
      self.m_1308 <- false ;
      i_1357_reset self.i_1357  ;
      i_1356_reset self.i_1356  ;
      i_1355_reset self.i_1355  ;
      i_1354_reset self.i_1354  ;
      i_1353_reset self.i_1353  ;
      i_1352_reset self.i_1352  ;
      i_1351_reset self.i_1351  ;
      i_1350_reset self.i_1350  ;
      i_1349_reset self.i_1349  ; i_1348_reset self.i_1348 ):unit) in 
  let afc_step self ((throttle_1160:MyOp.t) , (engine_1159:MyOp.t)) =
    (((if self.i_1286 then self.abf_ref_1242 <- MyOp.make 0.) ;
      (if self.i_1286 then self.mode_1244 <- MyOp.make 0.) ;
      (if self.i_1286 then self.commanded_fuel_1243 <- MyOp.make 0.1726) ;
      (let (y0_1264:MyOp.t) = MyOp.make 0. in
       (if self.i_1286 then self.m_1284 <- y0_1264) ;
       (let (p_1258:MyOp.t) = MyOp.make 0.01 in
        let (w_1260:MyOp.t) = MyOp.make 0.5 in
        (if self.i_1286 then
         self.pulse_width_1266 <- MyOp.( * ) p_1258  w_1260) ;
        (let (y0_1254:MyOp.t) = MyOp.make 0. in
         (if self.i_1286 then self.m_1282 <- y0_1254) ;
         (let (y0_1235:MyOp.t) = MyOp.make 0. in
          (if self.i_1286 then self.m_1280 <- y0_1235) ;
          (let (y0_1226:MyOp.t) = MyOp.make 14.7 in
           (if self.i_1286 then self.m_1278 <- y0_1226) ;
           (let (y0_1222:MyOp.t) = MyOp.make 14.7 in
            (if self.i_1286 then self.m_1276 <- y0_1222) ;
            (let (y0_1202:MyOp.t) = MyOp.make 0.982 in
             (if self.i_1286 then self.m_1274 <- y0_1202) ;
             (let (y0_1191:MyOp.t) = MyOp.make 0. in
              (if self.i_1286 then self.m_1272 <- y0_1191) ;
              (if self.i_1286 then self.tstep'_1166 <- MyOp.make tstep_1161)
              ;
              self.i_1286 <- false ;
              (let (dy_1262:MyOp.t) = MyOp.make 1. in
               let (x_1285:MyOp.t) = self.m_1284 in
               self.m_1284 <- MyOp.(+) (MyOp.( * ) self.tstep'_1166  dy_1262)
                                        x_1285 ;
               (let (dy_1252:MyOp.t) = MyOp.make 1. in
                let (x_1283:MyOp.t) = self.m_1282 in
                self.m_1282 <- MyOp.(+) (MyOp.( * ) self.tstep'_1166  dy_1252)
                                         x_1283 ;
                (let (dy_1233:MyOp.t) = MyOp.make 1. in
                 let (x_1281:MyOp.t) = self.m_1280 in
                 self.m_1280 <- MyOp.(+) (MyOp.( * ) self.tstep'_1166 
                                                     dy_1233)  x_1281 ;
                 (let (omega_1181:MyOp.t) =
                      MyOp.scale (saturate ((MyOp.make 900.) ,
                                            (MyOp.make 1100.) , engine_1159))
                                  Afc_utils.rpm2rad in
                  let (x_1275:MyOp.t) = self.m_1274 in
                  let (pumping_1199:MyOp.t) =
                      MyOp.translate (MyOp.(+) (MyOp.(-) (MyOp.scale 
                                                            (MyOp.( * ) 
                                                               x_1275 
                                                               omega_1181) 
                                                            0.08979) 
                                                         (MyOp.scale 
                                                            (MyOp.( * ) 
                                                               (MyOp.( * ) 
                                                                  omega_1181 
                                                                  x_1275) 
                                                               x_1275) 
                                                            0.0337)) 
                                               (MyOp.scale (MyOp.( * ) 
                                                              (MyOp.( * ) 
                                                                 x_1275 
                                                                 omega_1181) 
                                                              omega_1181) 
                                                           0.0001))  
                                     (-0.366) in
                  let (cyl_air_1196:MyOp.t) = MyOp.scale pumping_1199  0.9 in
                  let (x_1273:MyOp.t) = self.m_1272 in
                  let (throttle_angle_1182:MyOp.t) =
                      saturate ((MyOp.make 0.) ,
                                (MyOp.make 90.) ,
                                (MyOp.translate x_1273  8.8)) in
                  let (throttle_flow_1184:MyOp.t) =
                      i_1358_step self.i_1358
                        (throttle_angle_1182 , x_1275 , atmospheric_pressure) in
                  let (throttle_flow_1240:MyOp.t) =
                      MyOp.scale throttle_flow_1184  Afc_utils.maf_sensor_tol in
                  let (y0_1230:MyOp.t) = MyOp.make 0. in
                  let (t0_1228:MyOp.t) = MyOp.make Afc_utils.fault_time in
                  let (y1_1231:MyOp.t) = MyOp.make 1. in
                  let (af_sensor_1173:MyOp.t) =
                      if (<=) x_1281  t0_1228 then y0_1230 else y1_1231 in
                  let (x_1277:MyOp.t) = self.m_1276 in
                  let (abf_1209:MyOp.t) =
                      MyOp.scale x_1277  Afc_utils.af_sensor_tol in
                  let (abf_meas_1210:MyOp.t) =
                      if (>=) af_sensor_1173  (MyOp.make 0.5)
                      then MyOp.make (-1.)
                      else abf_1209 in
                  let (abf_meas_1237:MyOp.t) =
                      MyOp.scale abf_meas_1210  Afc_utils.af_sensor_tol in
                  let (a_1256:MyOp.t) = MyOp.make 1. in
                  let (delay_1257:MyOp.t) = MyOp.make 0.01 in
                  let (pulse_rel_1267:MyOp.t) =
                      MyOp.mod_t (MyOp.(-) x_1285  delay_1257)  p_1258 in
                  let (pulse_is_on_1268:bool) =
                      (<=) pulse_rel_1267  self.pulse_width_1266 in
                  let (trigger_10ms_1245:MyOp.t) =
                      if (&&) ((>=) x_1285  delay_1257)  pulse_is_on_1268
                      then a_1256
                      else MyOp.make 0. in
                  let (y0_1249:MyOp.t) = MyOp.make 0. in
                  let (t0_1247:MyOp.t) = MyOp.make 0.001 in
                  let (y1_1250:MyOp.t) = MyOp.make 1. in
                  let (trigger_pwon_1246:MyOp.t) =
                      if (<=) x_1283  t0_1247 then y0_1249 else y1_1250 in
                  (begin match ((i_1352_step self.i_1352 trigger_10ms_1245) ,
                                (i_1353_step self.i_1353 trigger_pwon_1246) ,
                                ((<) trigger_10ms_1245  (MyOp.make 0.5))) with
                         | (_ , true , true) ->
                             self.abf_ref_1242 <- MyOp.make 14.7 ;
                             self.mode_1244 <- MyOp.make 1. ;
                             self.commanded_fuel_1243 <- MyOp.make 0.1726
                         | (true , _ , _) ->
                             (if self.i_1310 then self.m_1306 <- MyOp.make 0.)
                             ;
                             (if self.i_1310 then
                              self.m_1303 <- MyOp.make 0.982) ;
                             self.i_1310 <- false ;
                             (let (x_1309:bool) = self.m_1308 in
                              let (x_1307:MyOp.t) = self.m_1306 in
                              let (normal_mode_start_time_1300:MyOp.t) =
                                  MyOp.make 10. in
                              let (normal_mode_1299:bool) =
                                  (||) ((>=) x_1307 
                                             normal_mode_start_time_1300) 
                                       x_1309 in
                              self.m_1308 <- normal_mode_1299 ;
                              (let (samp_time_1301:MyOp.t) = MyOp.make 0.01 in
                               self.m_1306 <- MyOp.(+) x_1307  samp_time_1301
                               ;
                               (let (x_1304:MyOp.t) = self.m_1303 in
                                let (estimated_cyl_air_flow_1298:MyOp.t) =
                                    MyOp.translate (MyOp.(+) (MyOp.(-) 
                                                                (MyOp.scale 
                                                                   (MyOp.( * ) 
                                                                    omega_1181
                                                                     
                                                                    x_1304) 
                                                                   0.08979) 
                                                                (MyOp.scale 
                                                                   (MyOp.( * ) 
                                                                    (
                                                                    MyOp.( * ) 
                                                                    x_1304 
                                                                    x_1304) 
                                                                    omega_1181)
                                                                    0.0337)) 
                                                             (MyOp.scale 
                                                                (MyOp.( * ) 
                                                                   (MyOp.( * ) 
                                                                    omega_1181
                                                                    
                                                                    omega_1181)
                                                                    x_1304) 
                                                                0.0001)) 
                                                   (-0.366) in
                                let (aux'_1297:MyOp.t) =
                                    MyOp.(+) x_1304 
                                             (MyOp.scale (MyOp.(-) throttle_flow_1240
                                                                   
                                                                   estimated_cyl_air_flow_1298)
                                                         
                                                         (( *. ) 0.01 
                                                                 0.41328)) in
                                self.m_1303 <- aux'_1297 ;
                                (let (power_on_1293:bool) =
                                     i_1357_step self.i_1357
                                       throttle_angle_1182 in
                                 let (fail_on_1291:bool) =
                                     i_1356_step self.i_1356 abf_meas_1237 in
                                 self.mode_1244 <- (if (||) ((||) fail_on_1291
                                                                  
                                                                  (not 
                                                                    normal_mode_1299))
                                                             power_on_1293
                                                    then MyOp.make 1.
                                                    else MyOp.make 0.) ;
                                 self.abf_ref_1242 <- (if (&&) normal_mode_1299
                                                                power_on_1293
                                                       then MyOp.make 12.5
                                                       else MyOp.make 14.7) ;
                                 (let (x_1305:MyOp.t) =
                                      MyOp.translate (i_1355_step self.i_1355
                                                        (self.abf_ref_1242 ,
                                                         abf_meas_1237))  
                                                     1. in
                                  let (fb_fuel_1290:MyOp.t) =
                                      if (>) self.mode_1244  (MyOp.make 0.5)
                                      then MyOp.make 1.
                                      else x_1305 in
                                  let (fb_fuel_sat_1289:MyOp.t) =
                                      saturate ((MyOp.make 0.) ,
                                                MyOp.infinity , fb_fuel_1290) in
                                  let (desired_fuel_mass_1288:MyOp.t) =
                                      i_1354_step self.i_1354
                                        (estimated_cyl_air_flow_1298 ,
                                         self.abf_ref_1242) in
                                  self.commanded_fuel_1243 <- saturate 
                                                                ((MyOp.make 
                                                                    0.13) ,
                                                                 (MyOp.make 
                                                                    1.66) ,
                                                                 (MyOp.( * ) 
                                                                    desired_fuel_mass_1288
                                                                    
                                                                    fb_fuel_sat_1289)))))))
                         | _ -> ()  end) ;
                  (let (fuel_injected_1178:MyOp.t) =
                       MyOp.scale self.commanded_fuel_1243 
                                  Afc_utils.fuel_inj_tol in
                   let (cyl_air_charge_1212:MyOp.t) =
                       MyOp.scale (MyOp.(/) cyl_air_1196  omega_1181) 
                                  Afc_utils.pi in
                   let (cyl_fuel_1177:MyOp.t) =
                       i_1351_step self.i_1351
                         (self.tstep'_1166 ,
                          fuel_injected_1178 ,
                          omega_1181 , cyl_air_charge_1212) in
                   let (cur_abf_1211:MyOp.t) =
                       MyOp.(/) cyl_air_1196  cyl_fuel_1177 in
                   let (delay_1213:MyOp.t) =
                       Afc_utils.lookup_delay ((MyOp.scale omega_1181 
                                                           Afc_utils.rad2rpm)
                                               , cyl_air_charge_1212) in
                   let (t_1216:MyOp.t) =
                       i_1350_step self.i_1350
                         (self.tstep'_1166 , (MyOp.make 1.) , (MyOp.make 0.)) in
                   let (delayed_1214:MyOp.t) =
                       i_1349_step self.i_1349
                         (t_1216 , cur_abf_1211 , delay_1213) in
                   let (x_1279:MyOp.t) = self.m_1278 in
                   let (dy_1224:MyOp.t) =
                       MyOp.scale (MyOp.(-) delayed_1214  x_1279)  10. in
                   self.m_1278 <- MyOp.(+) (MyOp.( * ) self.tstep'_1166 
                                                       dy_1224)  x_1279 ;
                   (let (dy_1220:MyOp.t) =
                        MyOp.scale (MyOp.(-) x_1279  x_1277)  50. in
                    self.m_1276 <- MyOp.(+) (MyOp.( * ) self.tstep'_1166 
                                                        dy_1220)  x_1277 ;
                    (let (dmanifold_pressure_1197:MyOp.t) =
                         MyOp.scale (MyOp.(-) throttle_flow_1184 
                                              cyl_air_1196)  0.41328 in
                     self.m_1274 <- MyOp.(+) (MyOp.( * ) self.tstep'_1166 
                                                         dmanifold_pressure_1197)
                                              x_1275 ;
                     (let (dy_1187:MyOp.t) =
                          MyOp.scale (MyOp.(-) throttle_1160  x_1273)  10. in
                      self.m_1272 <- MyOp.(+) (MyOp.( * ) self.tstep'_1166 
                                                          dy_1187)  x_1273 ;
                      (let (mu_1165:MyOp.t) =
                           i_1348_step self.i_1348
                             (self.tstep'_1166 , abf_1209 , self.abf_ref_1242) in
                       (abf_1209 ,
                        self.abf_ref_1242 , mu_1165 , self.mode_1244))))))))))))))))))):
    MyOp.t * MyOp.t * MyOp.t * MyOp.t) in
  Node { alloc = afc_alloc; reset = afc_reset ; step = afc_step }
open Scope
let tstep = 5e-05

type _print_dump = unit

let print_dump  = 
   let print_dump_alloc _ = () in
  let print_dump_reset self  =
    ((()):unit) in 
  let print_dump_step self ((t_1316:float) ,
                            (throttle_1317:float) ,
                            (engine_1313:float) ,
                            (abf_1311:float) ,
                            (abf_ref_1312:float) ,
                            (mu_1315:float) , (mode_1314:float)) =
    ((let _ = print_float t_1316 in
      let _ = print_string "," in
      let _ = print_float throttle_1317 in
      let _ = print_string "," in
      let _ = print_float engine_1313 in
      let _ = print_string "," in
      let _ = print_float abf_1311 in
      let _ = print_string "," in
      let _ = print_float abf_ref_1312 in
      let _ = print_string "," in
      let _ = print_float mu_1315 in
      let _ = print_string "," in
      let _ = print_float mode_1314 in
      print_string "\n"):unit) in
  Node { alloc = print_dump_alloc; reset = print_dump_reset ;
                                   step = print_dump_step }
type ('b , 'a) _main =
  { mutable i_1360 : 'b ; mutable i_1359 : 'a }

let main  = 
  let Node { alloc = i_1360_alloc; step = i_1360_step ; reset = i_1360_reset } = integrate 
   in 
  let Node { alloc = i_1359_alloc; step = i_1359_step ; reset = i_1359_reset } = 
  afc tstep  in
  let main_alloc _ =
    ();
    { i_1360 = i_1360_alloc () (* discrete *)  ;
      i_1359 = i_1359_alloc () (* discrete *)  } in
  let main_reset self  =
    ((i_1360_reset self.i_1360  ; i_1359_reset self.i_1359 ):unit) in 
  let main_step self () =
    ((let (t_1318:MyOp.t) =
          i_1360_step self.i_1360
            ((MyOp.make tstep) , (MyOp.make 1.) , (MyOp.make 0.)) in
      let (throttle_1319:MyOp.t) = MyOp.make 80. in
      let (engine_1320:MyOp.t) = MyOp.make 1100. in
      let ((abf_1321:MyOp.t) ,
           (abf_ref_1322:MyOp.t) , (mu_1324:MyOp.t) , (mode_1323:MyOp.t)) =
          i_1359_step self.i_1359 (throttle_1319 , engine_1320) in
      let _ =
          print_string ((^) "t = " 
                            ((^) (string_of_float (MyOp.get t_1318))  "\r")) in
      flush stdout):unit) in
  Node { alloc = main_alloc; reset = main_reset ; step = main_step }
