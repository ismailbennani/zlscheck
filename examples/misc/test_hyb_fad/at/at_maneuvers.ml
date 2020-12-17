(* The Zélus compiler, version 2.1
  (jeudi 17 décembre 2020, 16:00:27 (UTC+0100)) *)
open Ztypes
type state__1193 =
At_maneuvers_State4_85
| At_maneuvers_State3_84 | At_maneuvers_State2_83 | At_maneuvers_State1_82 
type state__1192 =
At_maneuvers_State4_69
| At_maneuvers_State3_68 | At_maneuvers_State2_67 | At_maneuvers_State1_66 
type ('g , 'f , 'e , 'd , 'c , 'b , 'a) _passing_maneuver_c =
  { mutable major_139 : 'g ;
    mutable x_149 : 'f ;
    mutable h_148 : 'e ;
    mutable h_146 : 'd ;
    mutable nx_144 : 'c ; mutable r_143 : 'b ; mutable s_142 : 'a }

let passing_maneuver_c (cstate_204:Ztypes.cstate) = 
  
  let passing_maneuver_c_alloc _ =
    cstate_204.cmax <- (+) cstate_204.cmax  1 ;
    cstate_204.zmax <- (+) cstate_204.zmax  1;
    { major_139 = false ;
      x_149 = { zin = false; zout = 1. } ;
      h_148 = 42. ;
      h_146 = (42.:float) ;
      nx_144 = { pos = 42.; der = 0. } ;
      r_143 = (false:bool) ; s_142 = (At_maneuvers_State4_69:state__1192) } in
  let passing_maneuver_c_step self ((time_138:float) , ()) =
    ((let (cindex_205:int) = cstate_204.cindex in
      let cpos_207 = ref (cindex_205:int) in
      let (zindex_206:int) = cstate_204.zindex in
      let zpos_208 = ref (zindex_206:int) in
      cstate_204.cindex <- (+) cstate_204.cindex  1 ;
      cstate_204.zindex <- (+) cstate_204.zindex  1 ;
      self.major_139 <- cstate_204.major ;
      (if cstate_204.major then
       for i_1 = cindex_205 to 0 do Zls.set cstate_204.dvec  i_1  0. done
       else ((self.nx_144.pos <- Zls.get cstate_204.cvec  !cpos_207 ;
              cpos_207 := (+) !cpos_207  1))) ;
      (let (result_209:(float  * float)) =
           let h_147 = ref (infinity:float) in
           let encore_145 = ref (false:bool) in
           let (throttle_141:float) = self.nx_144.pos in
           (begin match self.s_142 with
                  | At_maneuvers_State1_66 ->
                      (if self.r_143 then ()) ;
                      self.x_149.zout <- (-.) 40.  throttle_141 ;
                      (begin match self.x_149.zin with
                             | true ->
                                 encore_145 := true ;
                                 self.r_143 <- true ;
                                 self.s_142 <- At_maneuvers_State2_67
                             | _ -> self.r_143 <- false  end)
                  | At_maneuvers_State2_67 ->
                      (if self.r_143 then ()) ;
                      self.x_149.zout <- (-.) throttle_141  100. ;
                      (begin match self.x_149.zin with
                             | true ->
                                 encore_145 := true ;
                                 self.r_143 <- true ;
                                 self.s_142 <- At_maneuvers_State3_68
                             | _ -> self.r_143 <- false  end)
                  | At_maneuvers_State3_68 ->
                      (if self.r_143 then ()) ;
                      self.x_149.zout <- (~-.) throttle_141 ;
                      (begin match self.x_149.zin with
                             | true ->
                                 encore_145 := true ;
                                 self.nx_144.pos <- 0. ;
                                 self.r_143 <- true ;
                                 self.s_142 <- At_maneuvers_State4_69
                             | _ -> self.r_143 <- false  end)
                  | At_maneuvers_State4_69 ->
                      (if self.r_143 then ()) ; self.r_143 <- false
                   end) ;
           self.h_146 <- (if !encore_145 then 0. else infinity) ;
           h_147 := min !h_147  self.h_146 ;
           self.h_148 <- !h_147 ;
           (begin match self.s_142 with
                  | At_maneuvers_State1_66 ->
                      (if self.r_143 then ()) ;
                      self.nx_144.der <- (/.) (-20.)  14.9
                  | At_maneuvers_State2_67 ->
                      (if self.r_143 then ()) ; self.nx_144.der <- 600.
                  | At_maneuvers_State3_68 ->
                      (if self.r_143 then ()) ;
                      self.nx_144.der <- (/.) ((-.) 58.8235  100.) 
                                              ((-.) 50.  15.)
                  | At_maneuvers_State4_69 ->
                      (if self.r_143 then ()) ; self.nx_144.der <- 0.
                   end) ; (throttle_141 , 0.) in
       cstate_204.horizon <- min cstate_204.horizon  self.h_148 ;
       cpos_207 := cindex_205 ;
       (if cstate_204.major then
        (((Zls.set cstate_204.cvec  !cpos_207  self.nx_144.pos ;
           cpos_207 := (+) !cpos_207  1)) ; ((self.x_149.zin <- false)))
        else (((self.x_149.zin <- Zls.get_zin cstate_204.zinvec  !zpos_208 ;
                zpos_208 := (+) !zpos_208  1)) ;
              zpos_208 := zindex_206 ;
              ((Zls.set cstate_204.zoutvec  !zpos_208  self.x_149.zout ;
                zpos_208 := (+) !zpos_208  1)) ;
              ((Zls.set cstate_204.dvec  !cpos_207  self.nx_144.der ;
                cpos_207 := (+) !cpos_207  1)))) ; result_209)):float * float) in
  
  let passing_maneuver_c_reset self  =
    ((self.r_143 <- false ;
      self.s_142 <- At_maneuvers_State1_66 ; self.nx_144.pos <- 60.):
    unit) in
  Node { alloc = passing_maneuver_c_alloc; step = passing_maneuver_c_step ;
                                           reset = passing_maneuver_c_reset }
type ('b , 'a) _gradual_acceleration_c =
  { mutable major_153 : 'b ; mutable throttle_154 : 'a }

let gradual_acceleration_c (cstate_210:Ztypes.cstate) = 
  
  let gradual_acceleration_c_alloc _ =
    cstate_210.cmax <- (+) cstate_210.cmax  1;
    { major_153 = false ; throttle_154 = { pos = 42.; der = 0. } } in
  let gradual_acceleration_c_step self ((time_152:float) , ()) =
    ((let (cindex_211:int) = cstate_210.cindex in
      let cpos_213 = ref (cindex_211:int) in
      cstate_210.cindex <- (+) cstate_210.cindex  1 ;
      self.major_153 <- cstate_210.major ;
      (if cstate_210.major then
       for i_1 = cindex_211 to 0 do Zls.set cstate_210.dvec  i_1  0. done
       else ((self.throttle_154.pos <- Zls.get cstate_210.cvec  !cpos_213 ;
              cpos_213 := (+) !cpos_213  1))) ;
      (let (result_215:(float  * float)) =
           self.throttle_154.der <- (/.) ((-.) 24.  13.4)  50. ;
           (self.throttle_154.pos , 0.) in
       cpos_213 := cindex_211 ;
       (if cstate_210.major then
        (((Zls.set cstate_210.cvec  !cpos_213  self.throttle_154.pos ;
           cpos_213 := (+) !cpos_213  1)))
        else (((Zls.set cstate_210.dvec  !cpos_213  self.throttle_154.der ;
                cpos_213 := (+) !cpos_213  1)))) ; result_215)):float * float) in
  
  let gradual_acceleration_c_reset self  =
    (self.throttle_154.pos <- 13.4:unit) in
  Node { alloc = gradual_acceleration_c_alloc; step = gradual_acceleration_c_step
                                               ;
                                               reset = gradual_acceleration_c_reset }
type ('h , 'g , 'f , 'e , 'd , 'c , 'b , 'a) _hard_braking_c =
  { mutable major_156 : 'h ;
    mutable h_167 : 'g ;
    mutable h_165 : 'f ;
    mutable x_163 : 'e ;
    mutable x_162 : 'd ;
    mutable throttle_159 : 'c ;
    mutable t_158 : 'b ; mutable brake_torque_157 : 'a }

let hard_braking_c (cstate_216:Ztypes.cstate) = 
  
  let hard_braking_c_alloc _ =
    cstate_216.cmax <- (+) cstate_216.cmax  1 ;
    cstate_216.zmax <- (+) cstate_216.zmax  2;
    { major_156 = false ;
      h_167 = 42. ;
      h_165 = (42.:float) ;
      x_163 = { zin = false; zout = 1. } ;
      x_162 = { zin = false; zout = 1. } ;
      throttle_159 = (42.:float) ;
      t_158 = { pos = 42.; der = 0. } ; brake_torque_157 = (42.:float) } in
  let hard_braking_c_step self ((time_155:float) , ()) =
    ((let (cindex_217:int) = cstate_216.cindex in
      let cpos_219 = ref (cindex_217:int) in
      let (zindex_218:int) = cstate_216.zindex in
      let zpos_220 = ref (zindex_218:int) in
      cstate_216.cindex <- (+) cstate_216.cindex  1 ;
      cstate_216.zindex <- (+) cstate_216.zindex  2 ;
      self.major_156 <- cstate_216.major ;
      (if cstate_216.major then
       for i_1 = cindex_217 to 0 do Zls.set cstate_216.dvec  i_1  0. done
       else ((self.t_158.pos <- Zls.get cstate_216.cvec  !cpos_219 ;
              cpos_219 := (+) !cpos_219  1))) ;
      (let (result_221:(float  * float)) =
           let h_166 = ref (infinity:float) in
           let encore_164 = ref (false:bool) in
           (begin match self.x_163.zin with
                  | true ->
                      encore_164 := true ; self.brake_torque_157 <- 325.
                  | _ -> ()  end) ;
           (begin match self.x_162.zin with
                  | true -> encore_164 := true ; self.throttle_159 <- 1.
                  | _ -> ()  end) ;
           self.h_165 <- (if !encore_164 then 0. else infinity) ;
           h_166 := min !h_166  self.h_165 ;
           self.h_167 <- !h_166 ;
           self.x_163.zout <- (-.) self.t_158.pos  10. ;
           self.x_162.zout <- (-.) self.t_158.pos  5.1 ;
           self.t_158.der <- 1. ; (self.throttle_159 , self.brake_torque_157) in
       cstate_216.horizon <- min cstate_216.horizon  self.h_167 ;
       cpos_219 := cindex_217 ;
       (if cstate_216.major then
        (((Zls.set cstate_216.cvec  !cpos_219  self.t_158.pos ;
           cpos_219 := (+) !cpos_219  1)) ;
         ((self.x_163.zin <- false) ; (self.x_162.zin <- false)))
        else (((self.x_163.zin <- Zls.get_zin cstate_216.zinvec  !zpos_220 ;
                zpos_220 := (+) !zpos_220  1) ;
               (self.x_162.zin <- Zls.get_zin cstate_216.zinvec  !zpos_220 ;
                zpos_220 := (+) !zpos_220  1)) ;
              zpos_220 := zindex_218 ;
              ((Zls.set cstate_216.zoutvec  !zpos_220  self.x_163.zout ;
                zpos_220 := (+) !zpos_220  1) ;
               (Zls.set cstate_216.zoutvec  !zpos_220  self.x_162.zout ;
                zpos_220 := (+) !zpos_220  1)) ;
              ((Zls.set cstate_216.dvec  !cpos_219  self.t_158.der ;
                cpos_219 := (+) !cpos_219  1)))) ; result_221)):float * float) in
  
  let hard_braking_c_reset self  =
    ((self.brake_torque_157 <- 0. ;
      self.throttle_159 <- 50. ; self.t_158.pos <- 0.):unit) in
  Node { alloc = hard_braking_c_alloc; step = hard_braking_c_step ;
                                       reset = hard_braking_c_reset }
type ('g , 'f , 'e , 'd , 'c , 'b , 'a) _coasting_c =
  { mutable major_169 : 'g ;
    mutable h_178 : 'f ;
    mutable h_176 : 'e ;
    mutable x_174 : 'd ;
    mutable throttle_172 : 'c ;
    mutable t_171 : 'b ; mutable brake_torque_170 : 'a }

let coasting_c (cstate_222:Ztypes.cstate) = 
  
  let coasting_c_alloc _ =
    cstate_222.cmax <- (+) cstate_222.cmax  1 ;
    cstate_222.zmax <- (+) cstate_222.zmax  1;
    { major_169 = false ;
      h_178 = 42. ;
      h_176 = (42.:float) ;
      x_174 = { zin = false; zout = 1. } ;
      throttle_172 = (42.:float) ;
      t_171 = { pos = 42.; der = 0. } ; brake_torque_170 = (42.:float) } in
  let coasting_c_step self ((time_168:float) , ()) =
    ((let (cindex_223:int) = cstate_222.cindex in
      let cpos_225 = ref (cindex_223:int) in
      let (zindex_224:int) = cstate_222.zindex in
      let zpos_226 = ref (zindex_224:int) in
      cstate_222.cindex <- (+) cstate_222.cindex  1 ;
      cstate_222.zindex <- (+) cstate_222.zindex  1 ;
      self.major_169 <- cstate_222.major ;
      (if cstate_222.major then
       for i_1 = cindex_223 to 0 do Zls.set cstate_222.dvec  i_1  0. done
       else ((self.t_171.pos <- Zls.get cstate_222.cvec  !cpos_225 ;
              cpos_225 := (+) !cpos_225  1))) ;
      (let (result_227:(float  * float)) =
           let h_177 = ref (infinity:float) in
           let encore_175 = ref (false:bool) in
           (begin match self.x_174.zin with
                  | true -> encore_175 := true ; self.throttle_172 <- 1.
                  | _ -> ()  end) ;
           self.h_176 <- (if !encore_175 then 0. else infinity) ;
           h_177 := min !h_177  self.h_176 ;
           self.h_178 <- !h_177 ;
           self.x_174.zout <- (-.) self.t_171.pos  4.8 ;
           self.t_171.der <- 1. ; (self.throttle_172 , self.brake_torque_170) in
       cstate_222.horizon <- min cstate_222.horizon  self.h_178 ;
       cpos_225 := cindex_223 ;
       (if cstate_222.major then
        (((Zls.set cstate_222.cvec  !cpos_225  self.t_171.pos ;
           cpos_225 := (+) !cpos_225  1)) ; ((self.x_174.zin <- false)))
        else (((self.x_174.zin <- Zls.get_zin cstate_222.zinvec  !zpos_226 ;
                zpos_226 := (+) !zpos_226  1)) ;
              zpos_226 := zindex_224 ;
              ((Zls.set cstate_222.zoutvec  !zpos_226  self.x_174.zout ;
                zpos_226 := (+) !zpos_226  1)) ;
              ((Zls.set cstate_222.dvec  !cpos_225  self.t_171.der ;
                cpos_225 := (+) !cpos_225  1)))) ; result_227)):float * float) in
  
  let coasting_c_reset self  =
    ((self.throttle_172 <- 80. ;
      self.t_171.pos <- 0. ; self.brake_torque_170 <- 0.):unit) in
  Node { alloc = coasting_c_alloc; step = coasting_c_step ;
                                   reset = coasting_c_reset }
type ('g , 'f , 'e , 'd , 'c , 'b , 'a) _passing_maneuver_d =
  { mutable i_194 : 'g ;
    mutable m_191 : 'f ;
    mutable m_189 : 'e ;
    mutable m_186 : 'd ;
    mutable r_185 : 'c ; mutable s_184 : 'b ; mutable dthrottle_181 : 'a }

let passing_maneuver_d  = 
  
  let passing_maneuver_d_alloc _ =
    ();
    { i_194 = (false:bool) ;
      m_191 = (42.:float) ;
      m_189 = (42.:float) ;
      m_186 = (42.:float) ;
      r_185 = (false:bool) ;
      s_184 = (At_maneuvers_State4_85:state__1193) ;
      dthrottle_181 = (42.:float) } in
  let passing_maneuver_d_reset self  =
    ((self.i_194 <- true ;
      self.r_185 <- false ; self.s_184 <- At_maneuvers_State1_82):unit) in 
  let passing_maneuver_d_step self (t_179:float) =
    ((let (x_188:float) =
          if self.i_194 then t_179 else (-.) t_179  self.m_186 in
      let (x_193:float) =
          if self.i_194
          then 60.
          else (+.) self.m_189  (( *. ) self.m_191  x_188) in
      self.i_194 <- false ;
      (begin match self.s_184 with
             | At_maneuvers_State1_82 ->
                 (if self.r_185 then ()) ;
                 (begin match (<) x_193  40. with
                        | true ->
                            self.r_185 <- true ;
                            self.s_184 <- At_maneuvers_State2_83
                        | _ -> self.r_185 <- false  end)
             | At_maneuvers_State2_83 ->
                 (if self.r_185 then ()) ;
                 (begin match (>) x_193  100. with
                        | true ->
                            self.r_185 <- true ;
                            self.s_184 <- At_maneuvers_State3_84
                        | _ -> self.r_185 <- false  end)
             | At_maneuvers_State3_84 ->
                 (if self.r_185 then ()) ;
                 (begin match (<=) x_193  0. with
                        | true ->
                            self.r_185 <- true ;
                            self.s_184 <- At_maneuvers_State4_85
                        | _ -> self.r_185 <- false  end)
             | At_maneuvers_State4_85 ->
                 (if self.r_185 then ()) ; self.r_185 <- false
              end) ;
      (begin match self.s_184 with
             | At_maneuvers_State1_82 ->
                 (if self.r_185 then ()) ;
                 self.dthrottle_181 <- (/.) (-20.)  14.9
             | At_maneuvers_State2_83 ->
                 (if self.r_185 then ()) ; self.dthrottle_181 <- 600.
             | At_maneuvers_State3_84 ->
                 (if self.r_185 then ()) ;
                 self.dthrottle_181 <- (/.) ((-.) 58.8235  100.) 
                                            ((-.) 50.  15.)
             | At_maneuvers_State4_85 ->
                 (if self.r_185 then ()) ; self.dthrottle_181 <- 0.
              end) ;
      self.m_191 <- self.dthrottle_181 ;
      self.m_189 <- x_193 ; self.m_186 <- t_179 ; (x_193 , 0.)):float * float) in
  Node { alloc = passing_maneuver_d_alloc; reset = passing_maneuver_d_reset ;
                                           step = passing_maneuver_d_step }
type _gradual_acceleration_d = unit

let gradual_acceleration_d  = 
   let gradual_acceleration_d_alloc _ = () in
  let gradual_acceleration_d_reset self  =
    ((()):unit) in 
  let gradual_acceleration_d_step self (t_195:float) =
    ((let (derthrottle_196:float) = (/.) ((-.) 24.  13.4)  50. in
      let (throttle_197:float) = (+.) (( *. ) derthrottle_196  t_195)  13.4 in
      (throttle_197 , 0.)):float * float) in
  Node { alloc = gradual_acceleration_d_alloc; reset = gradual_acceleration_d_reset
                                               ;
                                               step = gradual_acceleration_d_step }
type _hard_braking_d = unit

let hard_braking_d  = 
   let hard_braking_d_alloc _ = () in
  let hard_braking_d_reset self  =
    ((()):unit) in 
  let hard_braking_d_step self (t_198:float) =
    ((let (brake_torque_199:float) = if (>=) t_198  10. then 325. else 0. in
      let (throttle_200:float) = if (>=) t_198  5.1 then 1. else 50. in
      (throttle_200 , brake_torque_199)):float * float) in
  Node { alloc = hard_braking_d_alloc; reset = hard_braking_d_reset ;
                                       step = hard_braking_d_step }
type _coasting_d = unit

let coasting_d  = 
   let coasting_d_alloc _ = () in
  let coasting_d_reset self  =
    ((()):unit) in 
  let coasting_d_step self (t_201:float) =
    ((let (throttle_203:float) = if (>=) t_201  4.8 then 1. else 80. in
      (throttle_203 , 0.)):float * float) in
  Node { alloc = coasting_d_alloc; reset = coasting_d_reset ;
                                   step = coasting_d_step }
