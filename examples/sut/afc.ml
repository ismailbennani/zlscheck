(* The Zélus compiler, version 2.1
  (vendredi 25 septembre 2020, 18:02:26 (UTC+0200)) *)
open Ztypes
type state__2284 = Afc_Main_71 | Afc_Init_70 
open FadFloat
open Discrete_obs_fad
type ('l , 'k , 'j , 'i , 'h , 'g , 'f , 'e , 'd , 'c , 'b , 'a) _afc1 =
  { mutable i_236 : 'l ;
    mutable i_169 : 'k ;
    mutable m_166 : 'j ;
    mutable m_163 : 'i ;
    mutable r_162 : 'h ;
    mutable s_161 : 'g ;
    mutable rise_or_fall_init_160 : 'f ;
    mutable result_159 : 'e ;
    mutable i_173 : 'd ;
    mutable m_171 : 'c ; mutable i_177 : 'b ; mutable m_175 : 'a }

let afc1  = 
  let Node { alloc = i_236_alloc; step = i_236_step ; reset = i_236_reset } = 
  Discrete_obs_fad.always_timed 5.  in
  let afc1_alloc _ =
    ();
    { i_169 = (false:bool) ;
      m_166 = (create ():FadFloat.t) ;
      m_163 = (create ():FadFloat.t) ;
      r_162 = (false:bool) ;
      s_161 = (Afc_Main_71:state__2284) ;
      rise_or_fall_init_160 = (create ():FadFloat.t) ;
      result_159 = (create ():FadFloat.t) ;
      i_173 = (false:bool) ;
      m_171 = (create ():FadFloat.t) ;
      i_177 = (false:bool) ; m_175 = (create ():FadFloat.t);
      i_236 = i_236_alloc () (* discrete *)  } in
  let afc1_reset self  =
    ((self.i_169 <- true ;
      self.r_162 <- false ;
      self.s_161 <- Afc_Init_70 ;
      self.i_173 <- true ; self.i_177 <- true ; i_236_reset self.i_236 ):
    unit) in 
  let afc1_step self ((tstep_150:FadFloat.t) ,
                      (inp_148:(FadFloat.t)Array.t) ,
                      (outp_149:(FadFloat.t)Array.t)) =
    ((let (throttle_151:FadFloat.t) = Array.get inp_148  0 in
      let (throttle_40_153:FadFloat.t) =
          Discrete_obs_fad.q_ge (throttle_151 , (FadFloat.make 40.)) in
      let (x_165:FadFloat.t) =
          if self.i_169
          then FadFloat.make (-10000.)
          else Discrete_obs_fad.q_and (throttle_40_153 , self.m_163) in
      let (throttle_8_8_154:FadFloat.t) =
          Discrete_obs_fad.q_le (throttle_151 , (FadFloat.make 8.8)) in
      let (x_168:FadFloat.t) =
          if self.i_169
          then FadFloat.make (-10000.)
          else Discrete_obs_fad.q_and (throttle_8_8_154 , self.m_166) in
      self.i_169 <- false ;
      self.m_163 <- throttle_8_8_154 ;
      self.m_166 <- throttle_40_153 ;
      (let (mu_152:FadFloat.t) = Array.get outp_149  3 in
       let (abs_mu_0_008_155:FadFloat.t) =
           Discrete_obs_fad.q_le ((Discrete_obs_fad.abs mu_152) ,
                                  (FadFloat.make 0.008)) in
       let (rise_or_fall_158:FadFloat.t) =
           Discrete_obs_fad.q_or (x_165 , x_168) in
       (begin match self.s_161 with
              | Afc_Init_70 ->
                  (if self.r_162 then self.i_173 <- true) ;
                  (if self.i_173 then self.m_171 <- FadFloat.make 0.) ;
                  self.i_173 <- false ;
                  (let (x_172:FadFloat.t) = self.m_171 in
                   self.m_171 <- FadFloat.(+) x_172  tstep_150 ;
                   self.result_159 <- FadFloat.make 10000. ;
                   (begin match ((Discrete_obs_fad.isTrue rise_or_fall_158) ,
                                 ((>=) x_172  (FadFloat.make 11.))) with
                          | (true , true) ->
                              self.rise_or_fall_init_160 <- rise_or_fall_158
                              ;
                              self.r_162 <- true ; self.s_161 <- Afc_Main_71
                          | _ -> self.r_162 <- false  end))
              | Afc_Main_71 ->
                  (if self.r_162 then
                   (self.i_177 <- true ; i_236_reset self.i_236 )) ;
                  (if self.i_177 then self.m_175 <- FadFloat.make 0.) ;
                  self.i_177 <- false ;
                  (let (x_176:FadFloat.t) = self.m_175 in
                   self.m_175 <- FadFloat.(+) x_176  tstep_150 ;
                   self.result_159 <- Discrete_obs_fad.implies (self.rise_or_fall_init_160
                                                                ,
                                                                (i_236_step self.i_236
                                                                   (tstep_150
                                                                    ,
                                                                    (
                                                                    Discrete_obs_fad.implies 
                                                                    (
                                                                    (
                                                                    Discrete_obs_fad.q_gt 
                                                                    (
                                                                    x_176 ,
                                                                    (
                                                                    FadFloat.make 
                                                                    1.))) ,
                                                                    abs_mu_0_008_155)))))
                   ;
                   (begin match Discrete_obs_fad.isTrue rise_or_fall_158 with
                          | true ->
                              self.rise_or_fall_init_160 <- rise_or_fall_158
                              ;
                              self.r_162 <- true ; self.s_161 <- Afc_Main_71
                          | _ -> self.r_162 <- false  end))
               end) ; self.result_159)):FadFloat.t) in
  Node { alloc = afc1_alloc; reset = afc1_reset ; step = afc1_step }
type ('c , 'b , 'a) _afc2 =
  { mutable i_237 : 'c ; mutable i_186 : 'b ; mutable m_184 : 'a }

let afc2  = 
  let Node { alloc = i_237_alloc; step = i_237_step ; reset = i_237_reset } = 
  Discrete_obs_fad.always_timed 50.  in
  let afc2_alloc _ =
    ();
    { i_186 = (false:bool) ; m_184 = (create ():FadFloat.t);
      i_237 = i_237_alloc () (* discrete *)  } in
  let afc2_reset self  =
    ((self.i_186 <- true ; i_237_reset self.i_237 ):unit) in 
  let afc2_step self ((tstep_180:FadFloat.t) ,
                      (inp_178:'a2017) , (outp_179:(FadFloat.t)Array.t)) =
    (((if self.i_186 then self.m_184 <- FadFloat.make 0.) ;
      self.i_186 <- false ;
      (let (x_185:FadFloat.t) = self.m_184 in
       self.m_184 <- FadFloat.(+) x_185  tstep_180 ;
       (let (mu_182:FadFloat.t) = Array.get outp_179  2 in
        let (abs_mu_183:FadFloat.t) = Discrete_obs_fad.abs mu_182 in
        i_237_step self.i_237
          (tstep_180 ,
           (Discrete_obs_fad.implies ((Discrete_obs_fad.q_ge (x_185 ,
                                                              (FadFloat.make 
                                                                 11.02))) ,
                                      (Discrete_obs_fad.q_lt (abs_mu_183 ,
                                                              (FadFloat.make 
                                                                 0.007))))))))):
    FadFloat.t) in
  Node { alloc = afc2_alloc; reset = afc2_reset ; step = afc2_step }
type ('g , 'f , 'e , 'd , 'c , 'b , 'a) _afc_afc1 =
  { mutable i_239 : 'g ;
    mutable i_238 : 'f ;
    mutable i_217 : 'e ;
    mutable m_214 : 'd ;
    mutable m_211 : 'c ; mutable m_207 : 'b ; mutable engine_191 : 'a }

let afc_afc1 (tstep_188:float) = 
  let Node { alloc = i_239_alloc; step = i_239_step ; reset = i_239_reset } = 
  Afc_d.afc tstep_188  in 
  let Node { alloc = i_238_alloc; step = i_238_step ; reset = i_238_reset } = afc1 
   in
  let afc_afc1_alloc _ =
    ();
    { i_217 = (false:bool) ;
      m_214 = (create ():FadFloat.t) ;
      m_211 = (create ():FadFloat.t) ;
      m_207 = (create ():FadFloat.t) ;
      engine_191 = (create ():FadFloat.t);
      i_239 = i_239_alloc () (* discrete *)  ;
      i_238 = i_238_alloc () (* discrete *)  } in
  let afc_afc1_reset self  =
    ((self.i_217 <- true ; i_239_reset self.i_239  ; i_238_reset self.i_238 ):
    unit) in 
  let afc_afc1_step self (inp_187:(FadFloat.t)Array.t) =
    ((let (throttle_203:FadFloat.t) = Array.get inp_187  0 in
      let (throttle_8_8_205:FadFloat.t) =
          Discrete_obs_fad.q_le (throttle_203 , (FadFloat.make 8.8)) in
      let (x_216:FadFloat.t) =
          if self.i_217
          then FadFloat.make (-10000.)
          else Discrete_obs_fad.q_and (throttle_8_8_205 , self.m_214) in
      let (throttle_40_204:FadFloat.t) =
          Discrete_obs_fad.q_ge (throttle_203 , (FadFloat.make 40.)) in
      let (x_213:FadFloat.t) =
          if self.i_217
          then FadFloat.make (-10000.)
          else Discrete_obs_fad.q_and (throttle_40_204 , self.m_211) in
      let (tstep'_206:FadFloat.t) = FadFloat.make tstep_188 in
      (if self.i_217 then self.m_207 <- tstep'_206) ;
      (if self.i_217 then self.engine_191 <- Array.get inp_187  1) ;
      self.i_217 <- false ;
      (let (rob_optim_200:FadFloat.t) =
           if (>) throttle_203  (FadFloat.make 40.)
           then Discrete_obs_fad.q_not x_216
           else
             if (<) throttle_203  (FadFloat.make 8.8)
             then Discrete_obs_fad.q_not x_213
             else
               if (>) (FadFloat.make (Random.float 1.))  (FadFloat.make 0.5)
               then Discrete_obs_fad.q_not x_216
               else Discrete_obs_fad.q_not x_213 in
       let ((abf_189:FadFloat.t) ,
            (abf_ref_190:FadFloat.t) ,
            (mu_194:FadFloat.t) , (mode_193:FadFloat.t)) =
           i_239_step self.i_239 (throttle_203 , self.engine_191) in
       let (outp_196:(FadFloat.t)Array.t) =
           Array.of_list ((::) (self.engine_191 ,
                                ((::) (abf_189 ,
                                       ((::) (abf_ref_190 ,
                                              ((::) (mu_194 ,
                                                     ((::) (mode_193 , ([]))))))))))) in
       let (rob_spec_201:FadFloat.t) =
           i_238_step self.i_238 (tstep'_206 , inp_187 , outp_196) in
       let (rob_199:FadFloat.t) =
           if Discrete_obs_fad.isFalse rob_spec_201
           then rob_spec_201
           else
             if Discrete_obs_fad.isTrue rob_optim_200
             then rob_optim_200
             else rob_spec_201 in
       self.m_214 <- throttle_40_204 ;
       self.m_211 <- throttle_8_8_205 ;
       (let (x_208:FadFloat.t) = self.m_207 in
        self.m_207 <- FadFloat.(+) x_208  tstep'_206 ;
        ((FadFloat.get x_208) , outp_196 , rob_199)))):float *
                                                       FadFloat.t Array.t *
                                                       FadFloat.t) in
  Node { alloc = afc_afc1_alloc; reset = afc_afc1_reset ;
                                 step = afc_afc1_step }
type ('e , 'd , 'c , 'b , 'a) _afc_afc2 =
  { mutable i_241 : 'e ;
    mutable i_240 : 'd ;
    mutable i_235 : 'c ; mutable m_231 : 'b ; mutable engine_222 : 'a }

let afc_afc2 (tstep_219:float) = 
  let Node { alloc = i_241_alloc; step = i_241_step ; reset = i_241_reset } = 
  Afc_d.afc tstep_219  in 
  let Node { alloc = i_240_alloc; step = i_240_step ; reset = i_240_reset } = afc2 
   in
  let afc_afc2_alloc _ =
    ();
    { i_235 = (false:bool) ;
      m_231 = (create ():FadFloat.t) ;
      engine_222 = (create ():FadFloat.t);
      i_241 = i_241_alloc () (* discrete *)  ;
      i_240 = i_240_alloc () (* discrete *)  } in
  let afc_afc2_reset self  =
    ((self.i_235 <- true ; i_241_reset self.i_241  ; i_240_reset self.i_240 ):
    unit) in 
  let afc_afc2_step self (inp_218:(FadFloat.t)Array.t) =
    ((let (tstep'_230:FadFloat.t) = FadFloat.make tstep_219 in
      (if self.i_235 then self.m_231 <- tstep'_230) ;
      (if self.i_235 then self.engine_222 <- Array.get inp_218  1) ;
      self.i_235 <- false ;
      (let (throttle_229:FadFloat.t) = Array.get inp_218  0 in
       let ((abf_220:FadFloat.t) ,
            (abf_ref_221:FadFloat.t) ,
            (mu_224:FadFloat.t) , (mode_223:FadFloat.t)) =
           i_241_step self.i_241 (throttle_229 , self.engine_222) in
       let (outp_226:(FadFloat.t)Array.t) =
           Array.of_list ((::) (abf_220 ,
                                ((::) (abf_ref_221 ,
                                       ((::) (mu_224 ,
                                              ((::) (mode_223 , ([]))))))))) in
       let (rob_227:FadFloat.t) =
           i_240_step self.i_240 (tstep'_230 , inp_218 , outp_226) in
       let (x_232:FadFloat.t) = self.m_231 in
       self.m_231 <- FadFloat.(+) x_232  tstep'_230 ;
       ((FadFloat.get x_232) , outp_226 , rob_227))):float *
                                                     FadFloat.t Array.t *
                                                     FadFloat.t) in
  Node { alloc = afc_afc2_alloc; reset = afc_afc2_reset ;
                                 step = afc_afc2_step }
