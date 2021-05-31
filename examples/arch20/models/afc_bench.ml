(* The Zélus compiler, version 2.0
  (jeudi 4 juin 2020, 17:57:12 (UTC+0200)) *)
open Ztypes
open MyOp
open Discrete_obs_fad
type ('g , 'f , 'e , 'd , 'c , 'b , 'a) _afc1 =
  { mutable i_183 : 'g ;
    mutable i_137 : 'f ;
    mutable i_136 : 'e ;
    mutable m_134 : 'd ;
    mutable m_131 : 'c ; mutable m_128 : 'b ; mutable result_126 : 'a }

let afc1  = 
  let Node { alloc = i_183_alloc; step = i_183_step ; reset = i_183_reset } = 
  Discrete_obs_fad.always_timed 5.  in
  let afc1_alloc _ =
    ();
    { i_137 = (false:bool) ;
      i_136 = (false:bool) ;
      m_134 = (create ():MyOp.t) ;
      m_131 = (create ():MyOp.t) ;
      m_128 = (create ():MyOp.t) ; result_126 = (create ():MyOp.t);
      i_183 = i_183_alloc () (* discrete *)  } in
  let afc1_reset self  =
    ((self.i_136 <- true ; self.i_137 <- true ; i_183_reset self.i_183 ):
    unit) in 
  let afc1_step self ((tstep_117:MyOp.t) ,
                      (inp_115:(MyOp.t)Array.t) , (outp_116:(MyOp.t)Array.t)) =
    ((let (throttle_118:MyOp.t) = Array.get inp_115  0 in
      let (throttle_40_120:MyOp.t) =
          Discrete_obs_fad.q_ge (throttle_118 , (MyOp.make 40.)) in
      let (x_130:MyOp.t) =
          if self.i_136
          then Discrete_obs_fad.q_false
          else Discrete_obs_fad.q_and (throttle_40_120 , self.m_128) in
      let (throttle_8_8_121:MyOp.t) =
          Discrete_obs_fad.q_le (throttle_118 , (MyOp.make 8.8)) in
      let (x_133:MyOp.t) =
          if self.i_136
          then Discrete_obs_fad.q_false
          else Discrete_obs_fad.q_and (throttle_8_8_121 , self.m_131) in
      self.i_136 <- false ;
      self.m_128 <- throttle_8_8_121 ;
      self.m_131 <- throttle_40_120 ;
      (let (mu_119:MyOp.t) = Array.get outp_116  2 in
       let (abs_mu_0_008_122:MyOp.t) =
           Discrete_obs_fad.q_le ((Discrete_obs_fad.abs mu_119) ,
                                  (MyOp.make 0.008)) in
       let (rise_or_fall_125:MyOp.t) = Discrete_obs_fad.q_or (x_130 , x_133) in
       (if Discrete_obs_fad.isTrue rise_or_fall_125 then
        (self.i_137 <- true ; i_183_reset self.i_183 )) ;
       (if self.i_137 then self.m_134 <- MyOp.make 0.) ;
       self.i_137 <- false ;
       (let (x_135:MyOp.t) = self.m_134 in
        self.m_134 <- MyOp.(+) x_135  tstep_117 ;
        self.result_126 <- i_183_step self.i_183
                             (tstep_117 ,
                              (Discrete_obs_fad.implies ((Discrete_obs_fad.q_ge 
                                                            (x_135 ,
                                                             (MyOp.make 1.)))
                                                         , abs_mu_0_008_122)))
        ; self.result_126))):MyOp.t) in
  Node { alloc = afc1_alloc; reset = afc1_reset ; step = afc1_step }
type ('c , 'b , 'a) _afc2 =
  { mutable i_184 : 'c ; mutable i_146 : 'b ; mutable m_144 : 'a }

let afc2  = 
  let Node { alloc = i_184_alloc; step = i_184_step ; reset = i_184_reset } = 
  Discrete_obs_fad.always_timed 50.  in
  let afc2_alloc _ =
    ();
    { i_146 = (false:bool) ; m_144 = (create ():MyOp.t);
      i_184 = i_184_alloc () (* discrete *)  } in
  let afc2_reset self  =
    ((self.i_146 <- true ; i_184_reset self.i_184 ):unit) in 
  let afc2_step self ((tstep_140:MyOp.t) ,
                      (inp_138:'a1457) , (outp_139:(MyOp.t)Array.t)) =
    (((if self.i_146 then self.m_144 <- MyOp.make 0.) ;
      self.i_146 <- false ;
      (let (x_145:MyOp.t) = self.m_144 in
       self.m_144 <- MyOp.(+) x_145  tstep_140 ;
       (let (mu_142:MyOp.t) = Array.get outp_139  2 in
        let (abs_mu_143:MyOp.t) = Discrete_obs_fad.abs mu_142 in
        i_184_step self.i_184
          (tstep_140 ,
           (Discrete_obs_fad.implies ((Discrete_obs_fad.q_ge (x_145 ,
                                                              (MyOp.make 11.)))
                                      ,
                                      (Discrete_obs_fad.q_lt (abs_mu_143 ,
                                                              (MyOp.make 
                                                                 0.007))))))))):
    MyOp.t) in
  Node { alloc = afc2_alloc; reset = afc2_reset ; step = afc2_step }
type ('e , 'd , 'c , 'b , 'a) _afc_afc1 =
  { mutable i_186 : 'e ;
    mutable i_185 : 'd ;
    mutable i_164 : 'c ; mutable m_160 : 'b ; mutable engine_151 : 'a }

let afc_afc1 (tstep_148:float) = 
  let Node { alloc = i_186_alloc; step = i_186_step ; reset = i_186_reset } = 
  Afc_d.afc tstep_148  in 
  let Node { alloc = i_185_alloc; step = i_185_step ; reset = i_185_reset } = afc1 
   in
  let afc_afc1_alloc _ =
    ();
    { i_164 = (false:bool) ;
      m_160 = (create ():MyOp.t) ; engine_151 = (create ():MyOp.t);
      i_186 = i_186_alloc () (* discrete *)  ;
      i_185 = i_185_alloc () (* discrete *)  } in
  let afc_afc1_reset self  =
    ((self.i_164 <- true ; i_186_reset self.i_186  ; i_185_reset self.i_185 ):
    unit) in 
  let afc_afc1_step self (inp_147:(MyOp.t)Array.t) =
    ((let (tstep'_159:MyOp.t) = MyOp.make tstep_148 in
      (if self.i_164 then self.m_160 <- tstep'_159) ;
      (if self.i_164 then self.engine_151 <- Array.get inp_147  1) ;
      self.i_164 <- false ;
      (let (throttle_158:MyOp.t) = Array.get inp_147  0 in
       let ((abf_149:MyOp.t) ,
            (abf_ref_150:MyOp.t) , (mu_153:MyOp.t) , (mode_152:MyOp.t)) =
           i_186_step self.i_186 (throttle_158 , self.engine_151) in
       let (outp_155:(MyOp.t)Array.t) =
           Array.of_list ((::) (abf_149 ,
                                ((::) (abf_ref_150 ,
                                       ((::) (mu_153 ,
                                              ((::) (mode_152 , ([]))))))))) in
       let (rob_156:MyOp.t) =
           i_185_step self.i_185 (tstep'_159 , inp_147 , outp_155) in
       let (x_161:MyOp.t) = self.m_160 in
       self.m_160 <- MyOp.(+) x_161  tstep'_159 ;
       ((MyOp.get x_161) , outp_155 , rob_156))):float *
                                                 MyOp.t Array.t * MyOp.t) in
  Node { alloc = afc_afc1_alloc; reset = afc_afc1_reset ;
                                 step = afc_afc1_step }
type ('e , 'd , 'c , 'b , 'a) _afc_afc2 =
  { mutable i_188 : 'e ;
    mutable i_187 : 'd ;
    mutable i_182 : 'c ; mutable m_178 : 'b ; mutable engine_169 : 'a }

let afc_afc2 (tstep_166:float) = 
  let Node { alloc = i_188_alloc; step = i_188_step ; reset = i_188_reset } = 
  Afc_d.afc tstep_166  in 
  let Node { alloc = i_187_alloc; step = i_187_step ; reset = i_187_reset } = afc2 
   in
  let afc_afc2_alloc _ =
    ();
    { i_182 = (false:bool) ;
      m_178 = (create ():MyOp.t) ; engine_169 = (create ():MyOp.t);
      i_188 = i_188_alloc () (* discrete *)  ;
      i_187 = i_187_alloc () (* discrete *)  } in
  let afc_afc2_reset self  =
    ((self.i_182 <- true ; i_188_reset self.i_188  ; i_187_reset self.i_187 ):
    unit) in 
  let afc_afc2_step self (inp_165:(MyOp.t)Array.t) =
    ((let (tstep'_177:MyOp.t) = MyOp.make tstep_166 in
      (if self.i_182 then self.m_178 <- tstep'_177) ;
      (if self.i_182 then self.engine_169 <- Array.get inp_165  1) ;
      self.i_182 <- false ;
      (let (throttle_176:MyOp.t) = Array.get inp_165  0 in
       let ((abf_167:MyOp.t) ,
            (abf_ref_168:MyOp.t) , (mu_171:MyOp.t) , (mode_170:MyOp.t)) =
           i_188_step self.i_188 (throttle_176 , self.engine_169) in
       let (outp_173:(MyOp.t)Array.t) =
           Array.of_list ((::) (abf_167 ,
                                ((::) (abf_ref_168 ,
                                       ((::) (mu_171 ,
                                              ((::) (mode_170 , ([]))))))))) in
       let (rob_174:MyOp.t) =
           i_187_step self.i_187 (tstep'_177 , inp_165 , outp_173) in
       let (x_179:MyOp.t) = self.m_178 in
       self.m_178 <- MyOp.(+) x_179  tstep'_177 ;
       ((MyOp.get x_179) , outp_173 , rob_174))):float *
                                                 MyOp.t Array.t * MyOp.t) in
  Node { alloc = afc_afc2_alloc; reset = afc_afc2_reset ;
                                 step = afc_afc2_step }
