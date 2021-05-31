(* The Zélus compiler, version 2.0
  (jeudi 4 juin 2020, 17:57:12 (UTC+0200)) *)
open Ztypes
open MyOp
open Scope
open Discrete_obs_fad
type ('g , 'f , 'e , 'd , 'c , 'b , 'a) _autotransd =
  { mutable i_294 : 'g ;
    mutable i_293 : 'f ;
    mutable i_292 : 'e ;
    mutable i_291 : 'd ;
    mutable i_290 : 'c ; mutable i_289 : 'b ; mutable m_208 : 'a }

let autotransd  = 
  let Node { alloc = i_294_alloc; step = i_294_step ; reset = i_294_reset } = Scope.scope2 
   in 
  let Node { alloc = i_293_alloc; step = i_293_step ; reset = i_293_reset } = Scope.scope4 
   in 
  let Node { alloc = i_292_alloc; step = i_292_step ; reset = i_292_reset } = Scope.scope 
   in 
  let Node { alloc = i_291_alloc; step = i_291_step ; reset = i_291_reset } = Scope.scope2 
   in 
  let Node { alloc = i_290_alloc; step = i_290_step ; reset = i_290_reset } = Scope.scope2 
   in 
  let Node { alloc = i_289_alloc; step = i_289_step ; reset = i_289_reset } = Scope.window5 
   in
  let autotransd_alloc _ =
    ();
    { m_208 = (42:int);
      i_294 = i_294_alloc () (* discrete *)  ;
      i_293 = i_293_alloc () (* discrete *)  ;
      i_292 = i_292_alloc () (* discrete *)  ;
      i_291 = i_291_alloc () (* discrete *)  ;
      i_290 = i_290_alloc () (* discrete *)  ;
      i_289 = i_289_alloc () (* discrete *)  } in
  let autotransd_reset self  =
    ((self.m_208 <- 0 ;
      i_294_reset self.i_294  ;
      i_293_reset self.i_293  ;
      i_292_reset self.i_292  ;
      i_291_reset self.i_291  ;
      i_290_reset self.i_290  ; i_289_reset self.i_289 ):unit) in 
  let autotransd_step self ((times_191:(float)Array.t) ,
                            (inp_190:((MyOp.t)Array.t)Array.t)) =
    ((let (x_209:int) = self.m_208 in
      let (cur_inp_193:(MyOp.t)Array.t) = Array.get inp_190  x_209 in
      let (rob_197:MyOp.t) = Array.get cur_inp_193  5 in
      let (s5_207:Gtkplot.scope) =
          i_294_step self.i_294
            ((-4.) ,
             4. ,
             ("rob" , Scope.linear , (MyOp.get rob_197)) ,
             ("" , Scope.linear , 0.)) in
      let (gear_195:MyOp.t) = Array.get cur_inp_193  3 in
      let (throttle_201:MyOp.t) = Array.get cur_inp_193  0 in
      let (dn_th_194:MyOp.t) =
          Common_myop.lookup_interpdn (throttle_201 , gear_195) in
      let (up_th_202:MyOp.t) =
          Common_myop.lookup_interpup (throttle_201 , gear_195) in
      let (speed_199:MyOp.t) = Array.get cur_inp_193  4 in
      let (s4_206:Gtkplot.scope) =
          i_293_step self.i_293
            (0. ,
             130. ,
             ("speed" , Scope.linear , (MyOp.get speed_199)) ,
             ("up_th" , Scope.linear , (MyOp.get up_th_202)) ,
             ("dn_th" , Scope.linear , (MyOp.get dn_th_194)) ,
             ("35" , Scope.linear , 35.)) in
      let (s3_205:Gtkplot.scope) =
          i_292_step self.i_292
            (0. , 4. , ("gear" , Scope.linear , (MyOp.get gear_195))) in
      let (rpm_198:MyOp.t) = Array.get cur_inp_193  2 in
      let (s2_204:Gtkplot.scope) =
          i_291_step self.i_291
            (0. ,
             5000. ,
             ("rpm" , Scope.linear , (MyOp.get rpm_198)) ,
             ("3000" , Scope.linear , 3000.)) in
      let (brake_192:MyOp.t) = Array.get cur_inp_193  1 in
      let (s1_203:Gtkplot.scope) =
          i_290_step self.i_290
            (0. ,
             350. ,
             ("throttle" , Scope.linear , (MyOp.get throttle_201)) ,
             ("brake" , Scope.linear , (MyOp.get brake_192))) in
      let (t_200:float) = Array.get times_191  x_209 in
      let () =
          i_289_step self.i_289
            ("Autotrans" ,
             30. , t_200 , s1_203 , s2_204 , s3_205 , s4_206 , s5_207) in
      self.m_208 <- Stdlib.(+) x_209  1 ; ()):unit) in
  Node { alloc = autotransd_alloc; reset = autotransd_reset ;
                                   step = autotransd_step }
let rtod = 57.29578

type ('f , 'e , 'd , 'c , 'b , 'a) _f16 =
  { mutable i_299 : 'f ;
    mutable i_298 : 'e ;
    mutable i_297 : 'd ;
    mutable i_296 : 'c ; mutable i_295 : 'b ; mutable m_230 : 'a }

let f16  = 
  let Node { alloc = i_299_alloc; step = i_299_step ; reset = i_299_reset } = Scope.scope 
   in 
  let Node { alloc = i_298_alloc; step = i_298_step ; reset = i_298_reset } = Scope.scopen 
   in 
  let Node { alloc = i_297_alloc; step = i_297_step ; reset = i_297_reset } = Scope.scope2 
   in 
  let Node { alloc = i_296_alloc; step = i_296_step ; reset = i_296_reset } = Scope.scope 
   in 
  let Node { alloc = i_295_alloc; step = i_295_step ; reset = i_295_reset } = Scope.window4 
   in
  let f16_alloc _ =
    ();
    { m_230 = (42:int);
      i_299 = i_299_alloc () (* discrete *)  ;
      i_298 = i_298_alloc () (* discrete *)  ;
      i_297 = i_297_alloc () (* discrete *)  ;
      i_296 = i_296_alloc () (* discrete *)  ;
      i_295 = i_295_alloc () (* discrete *)  } in
  let f16_reset self  =
    ((self.m_230 <- 0 ;
      i_299_reset self.i_299  ;
      i_298_reset self.i_298  ;
      i_297_reset self.i_297  ;
      i_296_reset self.i_296  ; i_295_reset self.i_295 ):unit) in 
  let f16_step self ((times_211:(float)Array.t) ,
                     (inp_210:((MyOp.t)Array.t)Array.t)) =
    ((let (x_231:int) = self.m_230 in
      let (cur_inp_215:(MyOp.t)Array.t) = Array.get inp_210  x_231 in
      let (alt_213:float) = MyOp.get (Array.get cur_inp_215  3) in
      let (s1_226:Gtkplot.scope) =
          i_299_step self.i_299
            (0. , 15000. , ("altitude" , Scope.linear , alt_213)) in
      let (r_221:float) = MyOp.get (Array.get cur_inp_215  12) in
      let (q_220:float) = MyOp.get (Array.get cur_inp_215  11) in
      let (p_217:float) = MyOp.get (Array.get cur_inp_215  10) in
      let (psi_219:float) = MyOp.get (Array.get cur_inp_215  9) in
      let (theta_224:float) = MyOp.get (Array.get cur_inp_215  8) in
      let (phi_218:float) = MyOp.get (Array.get cur_inp_215  7) in
      let (s2_227:Gtkplot.scope) =
          i_298_step self.i_298
            ((-90.) ,
             90. ,
             ((::) (("Roll phi (deg)" , Scope.linear , (( *. ) rtod  phi_218))
                    ,
                    ((::) (("Roll rate (deg/s)" ,
                            Scope.linear , (( *. ) rtod  p_217)) ,
                           ((::) (("Pitch theta (deg)" ,
                                   Scope.linear , (( *. ) rtod  theta_224)) ,
                                  ((::) (("Pitch rate (deg/s)" ,
                                          Scope.linear , (( *. ) rtod  q_220))
                                         ,
                                         ((::) (("Yaw psi (deg)" ,
                                                 Scope.linear ,
                                                 (( *. ) rtod  psi_219)) ,
                                                ((::) (("Yaw rate (deg/s)" ,
                                                        Scope.linear ,
                                                        (( *. ) rtod  r_221))
                                                       , ([])))))))))))))) in
      let (beta_214:float) = MyOp.get (Array.get cur_inp_215  5) in
      let (alpha_212:float) = MyOp.get (Array.get cur_inp_215  4) in
      let (s3_228:Gtkplot.scope) =
          i_297_step self.i_297
            ((-30.) ,
             50. ,
             ("alpha (deg)" , Scope.linear , (( *. ) rtod  alpha_212)) ,
             ("beta (deg)" , Scope.linear , (( *. ) rtod  beta_214))) in
      let (vt_225:float) = MyOp.get (Array.get cur_inp_215  6) in
      let (s4_229:Gtkplot.scope) =
          i_296_step self.i_296
            (0. , 600. , ("vt (ft/sec)" , Scope.linear , vt_225)) in
      let (t_223:float) = Array.get times_211  x_231 in
      let () =
          i_295_step self.i_295
            ("Controlled F16" ,
             15. , t_223 , s1_226 , s2_227 , s3_228 , s4_229) in
      self.m_230 <- Stdlib.(+) x_231  1 ; ()):unit) in
  Node { alloc = f16_alloc; reset = f16_reset ; step = f16_step }
type ('g , 'f , 'e , 'd , 'c , 'b , 'a) _cc =
  { mutable i_305 : 'g ;
    mutable i_304 : 'f ;
    mutable i_303 : 'e ;
    mutable i_302 : 'd ;
    mutable i_301 : 'c ; mutable i_300 : 'b ; mutable m_250 : 'a }

let cc  = 
  let Node { alloc = i_305_alloc; step = i_305_step ; reset = i_305_reset } = Scope.scope2 
   in 
  let Node { alloc = i_304_alloc; step = i_304_step ; reset = i_304_reset } = Scope.scopen 
   in 
  let Node { alloc = i_303_alloc; step = i_303_step ; reset = i_303_reset } = Scope.scope3 
   in 
  let Node { alloc = i_302_alloc; step = i_302_step ; reset = i_302_reset } = Scope.scope3 
   in 
  let Node { alloc = i_301_alloc; step = i_301_step ; reset = i_301_reset } = Scope.scope2 
   in 
  let Node { alloc = i_300_alloc; step = i_300_step ; reset = i_300_reset } = Scope.window5 
   in
  let cc_alloc _ =
    ();
    { m_250 = (42:int);
      i_305 = i_305_alloc () (* discrete *)  ;
      i_304 = i_304_alloc () (* discrete *)  ;
      i_303 = i_303_alloc () (* discrete *)  ;
      i_302 = i_302_alloc () (* discrete *)  ;
      i_301 = i_301_alloc () (* discrete *)  ;
      i_300 = i_300_alloc () (* discrete *)  } in
  let cc_reset self  =
    ((self.m_250 <- 0 ;
      i_305_reset self.i_305  ;
      i_304_reset self.i_304  ;
      i_303_reset self.i_303  ;
      i_302_reset self.i_302  ;
      i_301_reset self.i_301  ; i_300_reset self.i_300 ):unit) in 
  let cc_step self ((times_233:(float)Array.t) ,
                    (inp_232:((MyOp.t)Array.t)Array.t)) =
    ((let (x_251:int) = self.m_250 in
      let (cur_inp_240:(MyOp.t)Array.t) = Array.get inp_232  x_251 in
      let (brake_234:float) = MyOp.get (Array.get cur_inp_240  1) in
      let (throttle_244:float) = MyOp.get (Array.get cur_inp_240  0) in
      let (s1_245:Gtkplot.scope) =
          i_305_step self.i_305
            (0. ,
             1. ,
             ("throttle" , Scope.linear , throttle_244) ,
             ("brake" , Scope.linear , brake_234)) in
      let (c5_239:float) = MyOp.get (Array.get cur_inp_240  6) in
      let (c4_238:float) = MyOp.get (Array.get cur_inp_240  5) in
      let (c3_237:float) = MyOp.get (Array.get cur_inp_240  4) in
      let (c2_236:float) = MyOp.get (Array.get cur_inp_240  3) in
      let (c1_235:float) = MyOp.get (Array.get cur_inp_240  2) in
      let (s2_246:Gtkplot.scope) =
          i_304_step self.i_304
            ((-400.) ,
             50. ,
             ((::) (("c1" , Scope.linear , c1_235) ,
                    ((::) (("c2" , Scope.linear , c2_236) ,
                           ((::) (("c3" , Scope.linear , c3_237) ,
                                  ((::) (("c4" , Scope.linear , c4_238) ,
                                         ((::) (("c5" , Scope.linear , c5_239)
                                                , ([])))))))))))) in
      let (s2'_247:Gtkplot.scope) =
          i_303_step self.i_303
            (0. ,
             50. ,
             ("c2 - c1" , Scope.linear , ((-.) c2_236  c1_235)) ,
             ("zero" , Scope.linear , 0.) , ("20" , Scope.linear , 20.)) in
      let (s2''_248:Gtkplot.scope) =
          i_302_step self.i_302
            (0. ,
             50. ,
             ("c5 - c4" , Scope.linear , ((-.) c5_239  c4_238)) ,
             ("zero" , Scope.linear , 0.) , ("40" , Scope.linear , 40.)) in
      let (rob_242:float) = MyOp.get (Array.get cur_inp_240  7) in
      let (s3_249:Gtkplot.scope) =
          i_301_step self.i_301
            ((-50.) ,
             50. ,
             ("rob" , Scope.linear , rob_242) , ("zero" , Scope.linear , 0.)) in
      let (t_243:float) = Array.get times_233  x_251 in
      let () =
          i_300_step self.i_300
            ("Chasing cars" ,
             100. , t_243 , s1_245 , s2_246 , s2'_247 , s2''_248 , s3_249) in
      self.m_250 <- Stdlib.(+) x_251  10 ; ()):unit) in
  Node { alloc = cc_alloc; reset = cc_reset ; step = cc_step }
type ('g , 'f , 'e , 'd , 'c , 'b , 'a) _wt =
  { mutable i_311 : 'g ;
    mutable i_310 : 'f ;
    mutable i_309 : 'e ;
    mutable i_308 : 'd ;
    mutable i_307 : 'c ; mutable i_306 : 'b ; mutable m_269 : 'a }

let wt  = 
  let Node { alloc = i_311_alloc; step = i_311_step ; reset = i_311_reset } = Scope.scope 
   in 
  let Node { alloc = i_310_alloc; step = i_310_step ; reset = i_310_reset } = Scope.scope2 
   in 
  let Node { alloc = i_309_alloc; step = i_309_step ; reset = i_309_reset } = Scope.scope 
   in 
  let Node { alloc = i_308_alloc; step = i_308_step ; reset = i_308_reset } = Scope.scope3 
   in 
  let Node { alloc = i_307_alloc; step = i_307_step ; reset = i_307_reset } = Scope.scope3 
   in 
  let Node { alloc = i_306_alloc; step = i_306_step ; reset = i_306_reset } = Scope.windown 
   in
  let wt_alloc _ =
    ();
    { m_269 = (42:int);
      i_311 = i_311_alloc () (* discrete *)  ;
      i_310 = i_310_alloc () (* discrete *)  ;
      i_309 = i_309_alloc () (* discrete *)  ;
      i_308 = i_308_alloc () (* discrete *)  ;
      i_307 = i_307_alloc () (* discrete *)  ;
      i_306 = i_306_alloc () (* discrete *)  } in
  let wt_reset self  =
    ((self.m_269 <- 0 ;
      i_311_reset self.i_311  ;
      i_310_reset self.i_310  ;
      i_309_reset self.i_309  ;
      i_308_reset self.i_308  ;
      i_307_reset self.i_307  ; i_306_reset self.i_306 ):unit) in 
  let wt_step self ((times_253:(float)Array.t) ,
                    (inp_252:((MyOp.t)Array.t)Array.t)) =
    ((let (x_270:int) = self.m_269 in
      let (cur_inp_255:(MyOp.t)Array.t) = Array.get inp_252  x_270 in
      let (v0_263:float) = MyOp.get (Array.get cur_inp_255  0) in
      let (s1_264:Gtkplot.scope) =
          i_311_step self.i_311 (8. , 16. , ("v0" , Scope.linear , v0_263)) in
      let (omega_258:float) = MyOp.get (Array.get cur_inp_255  2) in
      let (s2_265:Gtkplot.scope) =
          i_310_step self.i_310
            (10. ,
             13. ,
             ("omega" , Scope.linear , omega_258) ,
             ("14.3" , Scope.linear , 14.3)) in
      let (omega_g_259:float) = MyOp.get (Array.get cur_inp_255  3) in
      let (s3_266:Gtkplot.scope) =
          i_309_step self.i_309
            (1000. , 1300. , ("omega_g" , Scope.linear , omega_g_259)) in
      let (mg_d_256:float) = MyOp.get (Array.get cur_inp_255  6) in
      let (s4_267:Gtkplot.scope) =
          i_308_step self.i_308
            (25000. ,
             50000. ,
             ("mg_d" , Scope.linear , mg_d_256) ,
             ("21000." , Scope.linear , 21000.) ,
             ("47500." , Scope.linear , 47500.)) in
      let (blade_pitch_angle_254:float) = MyOp.get (Array.get cur_inp_255  5) in
      let (theta_d_262:float) = MyOp.get (Array.get cur_inp_255  4) in
      let (theta_261:float) = MyOp.get (Array.get cur_inp_255  1) in
      let (s5_268:Gtkplot.scope) =
          i_307_step self.i_307
            (0. ,
             13. ,
             ("theta" , Scope.linear , theta_261) ,
             ("theta_d" , Scope.linear , theta_d_262) ,
             ("blade_pitch_angle" , Scope.linear , blade_pitch_angle_254)) in
      let (t_260:float) = Array.get times_253  x_270 in
      let () =
          i_306_step self.i_306
            ("Wind Turbine" ,
             630. ,
             t_260 ,
             ((::) (s1_264 ,
                    ((::) (s2_265 ,
                           ((::) (s3_266 ,
                                  ((::) (s4_267 , ((::) (s5_268 , ([])))))))))))) in
      self.m_269 <- Stdlib.(+) x_270  50 ; ()):unit) in
  Node { alloc = wt_alloc; reset = wt_reset ; step = wt_step }
type ('g , 'f , 'e , 'd , 'c , 'b , 'a) _afc =
  { mutable i_317 : 'g ;
    mutable i_316 : 'f ;
    mutable i_315 : 'e ;
    mutable i_314 : 'd ;
    mutable i_313 : 'c ; mutable i_312 : 'b ; mutable m_287 : 'a }

let afc  = 
  let Node { alloc = i_317_alloc; step = i_317_step ; reset = i_317_reset } = Scope.scope 
   in 
  let Node { alloc = i_316_alloc; step = i_316_step ; reset = i_316_reset } = Scope.scope 
   in 
  let Node { alloc = i_315_alloc; step = i_315_step ; reset = i_315_reset } = Scope.scope2 
   in 
  let Node { alloc = i_314_alloc; step = i_314_step ; reset = i_314_reset } = Scope.scope 
   in 
  let Node { alloc = i_313_alloc; step = i_313_step ; reset = i_313_reset } = Scope.scope 
   in 
  let Node { alloc = i_312_alloc; step = i_312_step ; reset = i_312_reset } = Scope.windown 
   in
  let afc_alloc _ =
    ();
    { m_287 = (42:int);
      i_317 = i_317_alloc () (* discrete *)  ;
      i_316 = i_316_alloc () (* discrete *)  ;
      i_315 = i_315_alloc () (* discrete *)  ;
      i_314 = i_314_alloc () (* discrete *)  ;
      i_313 = i_313_alloc () (* discrete *)  ;
      i_312 = i_312_alloc () (* discrete *)  } in
  let afc_reset self  =
    ((self.m_287 <- 0 ;
      i_317_reset self.i_317  ;
      i_316_reset self.i_316  ;
      i_315_reset self.i_315  ;
      i_314_reset self.i_314  ;
      i_313_reset self.i_313  ; i_312_reset self.i_312 ):unit) in 
  let afc_step self ((times_272:(float)Array.t) ,
                     (inp_271:((MyOp.t)Array.t)Array.t)) =
    ((let (x_288:int) = self.m_287 in
      let (cur_inp_275:(MyOp.t)Array.t) = Array.get inp_271  x_288 in
      let (throttle_281:float) = MyOp.get (Array.get cur_inp_275  0) in
      let (s1_282:Gtkplot.scope) =
          i_317_step self.i_317
            (0. , 85. , ("throttle" , Scope.linear , throttle_281)) in
      let (engine_276:float) = MyOp.get (Array.get cur_inp_275  1) in
      let (s2_283:Gtkplot.scope) =
          i_316_step self.i_316
            (900. , 1100. , ("engine" , Scope.linear , engine_276)) in
      let (abf_ref_274:float) = MyOp.get (Array.get cur_inp_275  3) in
      let (abf_273:float) = MyOp.get (Array.get cur_inp_275  2) in
      let (s3_284:Gtkplot.scope) =
          i_315_step self.i_315
            (0. ,
             15. ,
             ("abf" , Scope.linear , abf_273) ,
             ("abf_ref" , Scope.linear , abf_ref_274)) in
      let (mu_278:float) = MyOp.get (Array.get cur_inp_275  4) in
      let (s4_285:Gtkplot.scope) =
          i_314_step self.i_314
            ((-0.1) , 0.1 , ("mu" , Scope.linear , mu_278)) in
      let (mode_277:float) = MyOp.get (Array.get cur_inp_275  5) in
      let (s5_286:Gtkplot.scope) =
          i_313_step self.i_313
            (0. , 2. , ("mode" , Scope.linear , mode_277)) in
      let (t_280:float) = Array.get times_272  x_288 in
      let () =
          i_312_step self.i_312
            ("Abstract fuel control" ,
             50. ,
             t_280 ,
             ((::) (s1_282 ,
                    ((::) (s2_283 ,
                           ((::) (s3_284 ,
                                  ((::) (s4_285 , ((::) (s5_286 , ([])))))))))))) in
      self.m_287 <- Stdlib.(+) x_288  2000 ; ()):unit) in
  Node { alloc = afc_alloc; reset = afc_reset ; step = afc_step }
