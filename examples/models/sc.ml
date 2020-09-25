(* The Zélus compiler, version 2.1
  (vendredi 25 septembre 2020, 16:45:09 (UTC+0200)) *)
open Ztypes
open FadFloat
open Discrete_obs_fad
type ('c , 'b , 'a) _sc1 =
  { mutable i_199 : 'c ; mutable i_119 : 'b ; mutable m_117 : 'a }

let sc1  = 
  let Node { alloc = i_199_alloc; step = i_199_step ; reset = i_199_reset } = 
  Discrete_obs_fad.always_timed 35.  in
  let sc1_alloc _ =
    ();
    { i_119 = (false:bool) ; m_117 = (create ():FadFloat.t);
      i_199 = i_199_alloc () (* discrete *)  } in
  let sc1_reset self  =
    ((self.i_119 <- true ; i_199_reset self.i_199 ):unit) in 
  let sc1_step self ((tstep_111:FadFloat.t) , (outp_110:(FadFloat.t)Array.t)) =
    (((if self.i_119 then self.m_117 <- FadFloat.make 0.) ;
      self.i_119 <- false ;
      (let (x_118:FadFloat.t) = self.m_117 in
       self.m_117 <- FadFloat.(+) x_118  tstep_111 ;
       (let (t_ge_30_114:FadFloat.t) =
            Discrete_obs_fad.q_ge (x_118 , (FadFloat.make 30.)) in
        let (p_113:FadFloat.t) = Array.get outp_110  3 in
        let (p_in_range_116:FadFloat.t) =
            Discrete_obs_fad.q_and ((Discrete_obs_fad.q_ge (p_113 ,
                                                            (FadFloat.make 
                                                               87.))) ,
                                    (Discrete_obs_fad.q_le (p_113 ,
                                                            (FadFloat.make 
                                                               87.5)))) in
        i_199_step self.i_199
          (tstep_111 ,
           (Discrete_obs_fad.implies (t_ge_30_114 , p_in_range_116)))))):
    FadFloat.t) in
  Node { alloc = sc1_alloc; reset = sc1_reset ; step = sc1_step }
type ('k , 'j , 'i , 'h , 'g , 'f , 'e , 'd , 'c , 'b , 'a) _sc_sc1 =
  { mutable i_202 : 'k ;
    mutable i_201 : 'j ;
    mutable i_200 : 'i ;
    mutable i_198 : 'h ;
    mutable m_196 : 'g ;
    mutable m_194 : 'f ;
    mutable m_192 : 'e ;
    mutable m_190 : 'd ;
    mutable m_186 : 'c ; mutable tcw_140 : 'b ; mutable tstep'_131 : 'a }

let sc_sc1 (tstep_121:float) = 
  let Node { alloc = i_202_alloc; step = i_202_step ; reset = i_202_reset } = sc1 
   in 
  let Node { alloc = i_201_alloc; step = i_201_step ; reset = i_201_reset } = Sc_d.step 
   in 
  let Node { alloc = i_200_alloc; step = i_200_step ; reset = i_200_reset } = Sc_d.nnet 
   in
  let sc_sc1_alloc _ =
    ();
    { i_198 = (false:bool) ;
      m_196 = (create ():FadFloat.t) ;
      m_194 = (create ():FadFloat.t) ;
      m_192 = (create ():FadFloat.t) ;
      m_190 = (create ():FadFloat.t) ;
      m_186 = (create ():FadFloat.t) ;
      tcw_140 = (create ():FadFloat.t) ;
      tstep'_131 = (create ():FadFloat.t);
      i_202 = i_202_alloc () (* discrete *)  ;
      i_201 = i_201_alloc () (* discrete *)  ;
      i_200 = i_200_alloc () (* discrete *)  } in
  let sc_sc1_reset self  =
    ((self.i_198 <- true ;
      i_202_reset self.i_202  ;
      i_201_reset self.i_201  ; i_200_reset self.i_200 ):unit) in 
  let sc_sc1_step self (inp_120:(FadFloat.t)Array.t) =
    ((let (y0_180:FadFloat.t) = FadFloat.make Sc_utils.fcw_setpoint in
      (if self.i_198 then self.m_196 <- y0_180) ;
      (let (y0_174:FadFloat.t) = FadFloat.make Sc_utils.temp_setpoint in
       (if self.i_198 then self.m_194 <- y0_174) ;
       (let (y0_170:FadFloat.t) = FadFloat.make Sc_utils.p_setpoint in
        (if self.i_198 then self.m_192 <- y0_170) ;
        (let (y0_162:FadFloat.t) = FadFloat.make Sc_utils.p_setpoint in
         (if self.i_198 then self.m_190 <- y0_162) ;
         (if self.i_198 then self.tcw_140 <- FadFloat.make 60.) ;
         (if self.i_198 then self.tstep'_131 <- FadFloat.make tstep_121) ;
         (if self.i_198 then self.m_186 <- self.tstep'_131) ;
         self.i_198 <- false ;
         (let (x_195:FadFloat.t) = self.m_194 in
          let (x_197:FadFloat.t) = self.m_196 in
          let (x_193:FadFloat.t) = self.m_192 in
          let (temp_c_157:FadFloat.t) = Sc_utils.lookup_p_t x_193 in
          let (dTm_149:FadFloat.t) =
              FadFloat.(/) (FadFloat.(-) x_195  self.tcw_140) 
                           (FadFloat.log (FadFloat.(/) (FadFloat.(-) 
                                                          temp_c_157 
                                                          self.tcw_140) 
                                                       (FadFloat.(-) 
                                                          temp_c_157  x_195))) in
          let (q_155:FadFloat.t) =
              FadFloat.(/) dTm_149 
                           (FadFloat.translate (FadFloat.scale (FadFloat.inv 
                                                                  (FadFloat.pow 
                                                                    x_197 
                                                                    0.8)) 
                                                               0.0872924756542)
                                                0.00073786772008) in
          let (x_191:FadFloat.t) = self.m_190 in
          let (outp_125:(FadFloat.t)Array.t) =
              Array.of_list ((::) (x_195 ,
                                   ((::) (x_197 ,
                                          ((::) (q_155 ,
                                                 ((::) (x_191 , ([]))))))))) in
          let (rob_128:FadFloat.t) =
              i_202_step self.i_202 (self.tstep'_131 , outp_125) in
          let (nnet_input_136:FadFloat.t) =
              FadFloat.(-) x_191 
                           (i_201_step self.i_201
                              (self.tstep'_131 ,
                               (FadFloat.make 90.) ,
                               (FadFloat.make 2.) , (FadFloat.make 87.))) in
          let (nnet_output_137:FadFloat.t) =
              i_200_step self.i_200 (self.tstep'_131 , nnet_input_136) in
          let (aux_fcw_147:FadFloat.t) =
              Sc_d.saturate ((FadFloat.make 0.) ,
                             (FadFloat.make 200.) ,
                             (FadFloat.translate nnet_output_137 
                                                 Sc_utils.fcw_setpoint)) in
          let (denom1_176:FadFloat.t) = FadFloat.make 1. in
          let (denom2_177:FadFloat.t) = FadFloat.make 1. in
          let (dy_182:FadFloat.t) =
              FadFloat.( * ) (FadFloat.inv denom1_176) 
                             (FadFloat.(-) aux_fcw_147 
                                           (FadFloat.( * ) x_197  denom2_177)) in
          self.m_196 <- FadFloat.(+) x_197 
                                     (FadFloat.( * ) self.tstep'_131  dy_182)
          ;
          (let (dtemp_151:FadFloat.t) =
               FadFloat.scale (FadFloat.(+) (FadFloat.scale q_155 
                                                            ((/.) 1.  4.2)) 
                                            (FadFloat.( * ) (FadFloat.(-) 
                                                               self.tcw_140 
                                                               x_195)  
                                                            x_197)) 
                              ((/.) 1.  Sc_utils.cw_holdup) in
           self.m_194 <- FadFloat.(+) x_195 
                                      (FadFloat.( * ) self.tstep'_131 
                                                      dtemp_151) ;
           (let (fs_123:FadFloat.t) = Array.get inp_120  0 in
            let (fc_152:FadFloat.t) =
                FadFloat.(/) q_155  (Sc_utils.lookup_lambda x_193) in
            let (daux_p_150:FadFloat.t) =
                FadFloat.scale (FadFloat.( * ) (FadFloat.(-) fs_123  fc_152) 
                                               temp_c_157) 
                               ((/.) 0.461526  Sc_utils.volume) in
            self.m_192 <- FadFloat.(+) x_193 
                                       (FadFloat.( * ) self.tstep'_131 
                                                       daux_p_150) ;
            (let (denom1_158:FadFloat.t) =
                 FadFloat.make ((/.) Sc_utils.actuator_time_constant  2.) in
             let (denom2_159:FadFloat.t) = FadFloat.make 1. in
             let (dy_164:FadFloat.t) =
                 FadFloat.( * ) (FadFloat.inv denom1_158) 
                                (FadFloat.(-) x_193 
                                              (FadFloat.( * ) x_191 
                                                              denom2_159)) in
             self.m_190 <- FadFloat.(+) x_191 
                                        (FadFloat.( * ) self.tstep'_131 
                                                        dy_164) ;
             (let (x_187:FadFloat.t) = self.m_186 in
              self.m_186 <- FadFloat.(+) x_187  self.tstep'_131 ;
              ((FadFloat.get x_187) ,
               outp_125 , (FadFloat.translate rob_128  0.007))))))))))):
    float * FadFloat.t Array.t * FadFloat.t) in
  Node { alloc = sc_sc1_alloc; reset = sc_sc1_reset ; step = sc_sc1_step }
