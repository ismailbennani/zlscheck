(* The Zélus compiler, version 2.1
  (vendredi 25 septembre 2020, 16:45:09 (UTC+0200)) *)
open Ztypes
type state__1753 = F16_Done_80 | F16_Pull_79 | F16_Roll_78 | F16_Start_77 
open FadFloat
open Discrete_obs_fad
open F16_types
type ('a) _f16_phi =
  { mutable i_386 : 'a }

let f16_phi  = 
  let Node { alloc = i_386_alloc; step = i_386_step ; reset = i_386_reset } = 
  Discrete_obs_fad.always_timed 15.  in
  let f16_phi_alloc _ =
    ();{ i_386 = i_386_alloc () (* discrete *)  } in
  let f16_phi_reset self  =
    (i_386_reset self.i_386 :unit) in 
  let f16_phi_step self ((tstep_204:FadFloat.t) , (alt_203:FadFloat.t)) =
    (i_386_step self.i_386
       (tstep_204 , (Discrete_obs_fad.q_gt (alt_203 , (FadFloat.make 0.)))):
    FadFloat.t) in
  Node { alloc = f16_phi_alloc; reset = f16_phi_reset ; step = f16_phi_step }
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
      'n , 'm , 'l , 'k , 'j , 'i , 'h , 'g , 'f , 'e , 'd , 'c , 'b , 'a) _f16 =
  { mutable i_388 : 'b1 ;
    mutable i_387 : 'a1 ;
    mutable i_381 : 'z ;
    mutable m_379 : 'y ;
    mutable m_377 : 'x ;
    mutable m_375 : 'w ;
    mutable m_373 : 'v ;
    mutable m_371 : 'u ;
    mutable m_369 : 't ;
    mutable m_367 : 's ;
    mutable m_365 : 'r ;
    mutable m_363 : 'q ;
    mutable m_361 : 'p ;
    mutable m_359 : 'o ;
    mutable m_357 : 'n ;
    mutable m_355 : 'm ;
    mutable m_353 : 'l ;
    mutable m_351 : 'k ;
    mutable m_349 : 'j ;
    mutable m_347 : 'i ;
    mutable m_345 : 'h ;
    mutable r_342 : 'g ;
    mutable s_341 : 'f ;
    mutable state_263 : 'e ;
    mutable wings_are_level_384 : 'd ;
    mutable rate_is_small_383 : 'c ;
    mutable radsFromWingsLevel_382 : 'b ; mutable radsFromNoseLevel_385 : 'a }

let f16 (tstep_206:float) = 
  let Node { alloc = i_388_alloc; step = i_388_step ; reset = i_388_reset } = f16_phi 
   in 
  let Node { alloc = i_387_alloc; step = i_387_step ; reset = i_387_reset } = Subf16_model.derivatives 
   in
  let f16_alloc _ =
    ();
    { i_381 = (false:bool) ;
      m_379 = (create ():FadFloat.t) ;
      m_377 = (create ():FadFloat.t) ;
      m_375 = (create ():FadFloat.t) ;
      m_373 = (create ():FadFloat.t) ;
      m_371 = (create ():FadFloat.t) ;
      m_369 = (create ():FadFloat.t) ;
      m_367 = (create ():FadFloat.t) ;
      m_365 = (create ():FadFloat.t) ;
      m_363 = (create ():FadFloat.t) ;
      m_361 = (create ():FadFloat.t) ;
      m_359 = (create ():FadFloat.t) ;
      m_357 = (create ():FadFloat.t) ;
      m_355 = (create ():FadFloat.t) ;
      m_353 = (create ():FadFloat.t) ;
      m_351 = (create ():FadFloat.t) ;
      m_349 = (create ():FadFloat.t) ;
      m_347 = (create ():FadFloat.t) ;
      m_345 = (42.:float) ;
      r_342 = (false:bool) ;
      s_341 = (F16_Done_80:state__1753) ;
      state_263 = (GcasAutopilot.Done:GcasAutopilot.state) ;
      wings_are_level_384 = (false:bool) ;
      rate_is_small_383 = (false:bool) ;
      radsFromWingsLevel_382 = (create ():FadFloat.t) ;
      radsFromNoseLevel_385 = (create ():FadFloat.t);
      i_388 = i_388_alloc () (* discrete *)  ;
      i_387 = i_387_alloc () (* discrete *)  } in
  let f16_reset self  =
    ((self.i_381 <- true ;
      i_388_reset self.i_388  ;
      self.r_342 <- false ;
      self.s_341 <- F16_Start_77 ; i_387_reset self.i_387 ):unit) in 
  let f16_step self (inp_205:(FadFloat.t)Array.t) =
    ((let (phi_209:FadFloat.t) = Array.get inp_205  0 in
      let (theta_212:FadFloat.t) = Array.get inp_205  1 in
      let (psi_210:FadFloat.t) = Array.get inp_205  2 in
      let (initial_cond_220:F16_types.solver_state) =
          { F16_types.f16 =
            { F16_types.vt = (FadFloat.make 540.) ;
              F16_types.alpha = (FadFloat.scale Constants.dtor  2.1215) ;
              F16_types.beta = (FadFloat.make 0.) ;
              F16_types.phi = phi_209 ;
              F16_types.theta = theta_212 ;
              F16_types.psi = psi_210 ;
              F16_types.p = (FadFloat.make 0.) ;
              F16_types.q = (FadFloat.make 0.) ;
              F16_types.r = (FadFloat.make 0.) ;
              F16_types.x9 = (FadFloat.make 0.) ;
              F16_types.x10 = (FadFloat.make 0.) ;
              F16_types.alt = (FadFloat.make 4040.) ;
              F16_types.power = (FadFloat.make 9.) } ;
            F16_types.nz = (FadFloat.make 0.) ;
            F16_types.ps = (FadFloat.make 0.) ;
            F16_types.ny_r = (FadFloat.make 0.) } in
      let (x0_339:FadFloat.t) = initial_cond_220.F16_types.ny_r in
      (if self.i_381 then self.m_379 <- x0_339) ;
      (let (x0_335:FadFloat.t) = initial_cond_220.F16_types.ps in
       (if self.i_381 then self.m_377 <- x0_335) ;
       (let (x0_331:FadFloat.t) = initial_cond_220.F16_types.nz in
        (if self.i_381 then self.m_375 <- x0_331) ;
        (let (x0_327:FadFloat.t) =
             initial_cond_220.F16_types.f16.F16_types.power in
         (if self.i_381 then self.m_373 <- x0_327) ;
         (let (x0_323:FadFloat.t) =
              initial_cond_220.F16_types.f16.F16_types.alt in
          (if self.i_381 then self.m_371 <- x0_323) ;
          (let (x0_319:FadFloat.t) =
               initial_cond_220.F16_types.f16.F16_types.x10 in
           (if self.i_381 then self.m_369 <- x0_319) ;
           (let (x0_315:FadFloat.t) =
                initial_cond_220.F16_types.f16.F16_types.x9 in
            (if self.i_381 then self.m_367 <- x0_315) ;
            (let (x0_311:FadFloat.t) =
                 initial_cond_220.F16_types.f16.F16_types.r in
             (if self.i_381 then self.m_365 <- x0_311) ;
             (let (x0_307:FadFloat.t) =
                  initial_cond_220.F16_types.f16.F16_types.q in
              (if self.i_381 then self.m_363 <- x0_307) ;
              (let (x0_303:FadFloat.t) =
                   initial_cond_220.F16_types.f16.F16_types.p in
               (if self.i_381 then self.m_361 <- x0_303) ;
               (let (x0_299:FadFloat.t) =
                    initial_cond_220.F16_types.f16.F16_types.psi in
                (if self.i_381 then self.m_359 <- x0_299) ;
                (let (x0_295:FadFloat.t) =
                     initial_cond_220.F16_types.f16.F16_types.theta in
                 (if self.i_381 then self.m_357 <- x0_295) ;
                 (let (x0_291:FadFloat.t) =
                      initial_cond_220.F16_types.f16.F16_types.phi in
                  (if self.i_381 then self.m_355 <- x0_291) ;
                  (let (x0_287:FadFloat.t) =
                       initial_cond_220.F16_types.f16.F16_types.beta in
                   (if self.i_381 then self.m_353 <- x0_287) ;
                   (let (x0_283:FadFloat.t) =
                        initial_cond_220.F16_types.f16.F16_types.alpha in
                    (if self.i_381 then self.m_351 <- x0_283) ;
                    (let (x0_279:FadFloat.t) =
                         initial_cond_220.F16_types.f16.F16_types.vt in
                     (if self.i_381 then self.m_349 <- x0_279) ;
                     (let (x0_261:FadFloat.t) = FadFloat.make 0. in
                      (if self.i_381 then self.m_347 <- x0_261) ;
                      (if self.i_381 then self.m_345 <- tstep_206) ;
                      self.i_381 <- false ;
                      (let (x_380:FadFloat.t) = self.m_379 in
                       let (x_378:FadFloat.t) = self.m_377 in
                       let (x_376:FadFloat.t) = self.m_375 in
                       let (x_374:FadFloat.t) = self.m_373 in
                       let (x_372:FadFloat.t) = self.m_371 in
                       let (x_370:FadFloat.t) = self.m_369 in
                       let (x_368:FadFloat.t) = self.m_367 in
                       let (x_366:FadFloat.t) = self.m_365 in
                       let (x_364:FadFloat.t) = self.m_363 in
                       let (x_362:FadFloat.t) = self.m_361 in
                       let (x_360:FadFloat.t) = self.m_359 in
                       let (x_358:FadFloat.t) = self.m_357 in
                       let (x_356:FadFloat.t) = self.m_355 in
                       let (x_354:FadFloat.t) = self.m_353 in
                       let (x_352:FadFloat.t) = self.m_351 in
                       let (x_350:FadFloat.t) = self.m_349 in
                       let (f16_state_231:F16_types.f16_state) =
                           { F16_types.vt = x_350 ;
                             F16_types.alpha = x_352 ;
                             F16_types.beta = x_354 ;
                             F16_types.phi = x_356 ;
                             F16_types.theta = x_358 ;
                             F16_types.psi = x_360 ;
                             F16_types.p = x_362 ;
                             F16_types.q = x_364 ;
                             F16_types.r = x_366 ;
                             F16_types.x9 = x_368 ;
                             F16_types.x10 = x_370 ;
                             F16_types.alt = x_372 ; F16_types.power = x_374 } in
                       let (x_245:F16_types.solver_state) =
                           { F16_types.f16 = f16_state_231 ;
                             F16_types.nz = x_376 ;
                             F16_types.ps = x_378 ; F16_types.ny_r = x_380 } in
                       let (tstep'_213:FadFloat.t) = FadFloat.make tstep_206 in
                       let (rob_211:FadFloat.t) =
                           i_388_step self.i_388
                             (tstep'_213 , x_245.F16_types.f16.F16_types.alt) in
                       let (outp_208:(FadFloat.t)Array.t) =
                           Array.of_list ((::) (x_245.F16_types.f16.F16_types.alt
                                                ,
                                                ((::) (x_245.F16_types.f16.F16_types.alpha
                                                       ,
                                                       ((::) (x_245.F16_types.f16.F16_types.beta
                                                              ,
                                                              ((::) (
                                                                    x_245.F16_types.f16.F16_types.vt
                                                                    ,
                                                                    (
                                                                    (::) 
                                                                    (
                                                                    x_245.F16_types.f16.F16_types.phi
                                                                    ,
                                                                    (
                                                                    (::) 
                                                                    (
                                                                    x_245.F16_types.f16.F16_types.theta
                                                                    ,
                                                                    (
                                                                    (::) 
                                                                    (
                                                                    x_245.F16_types.f16.F16_types.psi
                                                                    ,
                                                                    (
                                                                    (::) 
                                                                    (
                                                                    x_245.F16_types.f16.F16_types.p
                                                                    ,
                                                                    (
                                                                    (::) 
                                                                    (
                                                                    x_245.F16_types.f16.F16_types.q
                                                                    ,
                                                                    (
                                                                    (::) 
                                                                    (
                                                                    x_245.F16_types.f16.F16_types.r
                                                                    , 
                                                                    ([]))))))))))))))))))))) in
                       let (alpha_253:FadFloat.t) =
                           x_245.F16_types.f16.F16_types.alpha in
                       let (phi_255:FadFloat.t) =
                           x_245.F16_types.f16.F16_types.phi in
                       let (theta_256:FadFloat.t) =
                           x_245.F16_types.f16.F16_types.theta in
                       let (p_254:FadFloat.t) =
                           x_245.F16_types.f16.F16_types.p in
                       let (x_348:FadFloat.t) = self.m_347 in
                       (begin match self.s_341 with
                              | F16_Start_77 ->
                                  (if self.r_342 then ()) ;
                                  self.state_263 <- GcasAutopilot.Start ;
                                  (begin match (((>) x_348 
                                                     GcasAutopilot.man_start)
                                                ,
                                                ((&&) ((&&) ((>) x_348 
                                                                 GcasAutopilot.man_start)
                                                            
                                                            ((<) (FadFloat.abs 
                                                                    p_254) 
                                                                 GcasAutopilot.eps_p))
                                                      
                                                      ((<) (FadFloat.abs 
                                                              (FadFloat.(-) 
                                                                 phi_255 
                                                                 (FadFloat.( * ) 
                                                                    Constants.pi
                                                                    
                                                                    (
                                                                    F16_utils.round 
                                                                    (
                                                                    FadFloat.(/) 
                                                                    phi_255 
                                                                    Constants.pi)))))
                                                           
                                                           GcasAutopilot.eps_phi))
                                                ,
                                                ((&&) ((>) x_348 
                                                           GcasAutopilot.man_start)
                                                      
                                                      ((>) (FadFloat.(-) 
                                                              (FadFloat.(-) 
                                                                 theta_256 
                                                                 alpha_253) 
                                                              (FadFloat.( * ) 
                                                                 GcasAutopilot.twopi
                                                                 
                                                                 (F16_utils.round 
                                                                    (
                                                                    FadFloat.(/) 
                                                                    (
                                                                    FadFloat.(-) 
                                                                    theta_256
                                                                    
                                                                    alpha_253)
                                                                    
                                                                    GcasAutopilot.twopi))))
                                                           
                                                           GcasAutopilot.path_goal))) with
                                         | (_ , _ , true) ->
                                             self.r_342 <- true ;
                                             self.s_341 <- F16_Done_80
                                         | (_ , true , _) ->
                                             self.r_342 <- true ;
                                             self.s_341 <- F16_Pull_79
                                         | (true , _ , _) ->
                                             self.r_342 <- true ;
                                             self.s_341 <- F16_Roll_78
                                         | _ -> self.r_342 <- false  end)
                              | F16_Roll_78 ->
                                  (if self.r_342 then ()) ;
                                  self.state_263 <- GcasAutopilot.Roll ;
                                  self.radsFromWingsLevel_382 <- F16_utils.round 
                                                                   (FadFloat.(/) 
                                                                    phi_255 
                                                                    GcasAutopilot.twopi)
                                  ;
                                  self.rate_is_small_383 <- (<) (FadFloat.abs 
                                                                   p_254) 
                                                                GcasAutopilot.eps_p
                                  ;
                                  self.wings_are_level_384 <- (<) (FadFloat.abs 
                                                                    (
                                                                    FadFloat.(-) 
                                                                    phi_255 
                                                                    (
                                                                    FadFloat.( * ) 
                                                                    GcasAutopilot.twopi
                                                                    
                                                                    self.radsFromWingsLevel_382)))
                                                                  
                                                                  GcasAutopilot.eps_phi
                                  ;
                                  (begin match (&&) self.wings_are_level_384 
                                                    self.rate_is_small_383 with
                                         | true ->
                                             self.r_342 <- true ;
                                             self.s_341 <- F16_Pull_79
                                         | _ -> self.r_342 <- false  end)
                              | F16_Pull_79 ->
                                  (if self.r_342 then ()) ;
                                  self.state_263 <- GcasAutopilot.Pull ;
                                  self.radsFromNoseLevel_385 <- F16_utils.round 
                                                                  (FadFloat.(/) 
                                                                    (
                                                                    FadFloat.(-) 
                                                                    theta_256
                                                                    
                                                                    alpha_253)
                                                                    
                                                                    GcasAutopilot.twopi)
                                  ;
                                  (begin match (>) (FadFloat.(-) (FadFloat.(-) 
                                                                    theta_256
                                                                    
                                                                    alpha_253)
                                                                 
                                                                 (FadFloat.( * ) 
                                                                    GcasAutopilot.twopi
                                                                    
                                                                    self.radsFromNoseLevel_385))
                                                    GcasAutopilot.path_goal with
                                         | true ->
                                             self.r_342 <- true ;
                                             self.s_341 <- F16_Done_80
                                         | _ -> self.r_342 <- false  end)
                              | F16_Done_80 ->
                                  (if self.r_342 then ()) ;
                                  self.state_263 <- GcasAutopilot.Done ;
                                  self.r_342 <- false
                               end) ;
                       (let (u_ref_265:F16_types.ref_ctrl) =
                            GcasAutopilot.get_u_ref (self.state_263 ,
                                                     F16_types.defaultCtrlLimits
                                                     ,
                                                     LowLevelController.x_equil
                                                     , x_245.F16_types.f16) in
                        let ((x_ctrl_267:F16_types.solver_state) ,
                             (u_deg_266:F16_types.input)) =
                            LowLevelController.get_u_deg (F16_types.defaultCtrlLimits
                                                          ,
                                                          u_ref_265.F16_types.thtlc_ref
                                                          , x_245) in
                        let ((xd_model_270:F16_types.f16_state) ,
                             (ny_268:FadFloat.t) , (nz_269:FadFloat.t)) =
                            i_387_step self.i_387
                              (x_245.F16_types.f16 , u_deg_266) in
                        let (ps_271:FadFloat.t) =
                            FadFloat.(+) (FadFloat.( * ) x_ctrl_267.F16_types.f16.F16_types.p
                                                         
                                                         (FadFloat.cos 
                                                            x_ctrl_267.F16_types.f16.F16_types.alpha))
                                         
                                         (FadFloat.( * ) x_ctrl_267.F16_types.f16.F16_types.r
                                                         
                                                         (FadFloat.sin 
                                                            x_ctrl_267.F16_types.f16.F16_types.alpha)) in
                        let (ny_r_272:FadFloat.t) =
                            FadFloat.(+) ny_268 
                                         x_ctrl_267.F16_types.f16.F16_types.r in
                        let ((nzd_274:FadFloat.t) ,
                             (psd_275:FadFloat.t) , (ny_rd_273:FadFloat.t)) =
                            LowLevelController.get_integrator_derivatives 
                              (u_ref_265 , nz_269 , ps_271 , ny_r_272) in
                        let (xd_248:F16_types.solver_state) =
                            { F16_types.f16 = xd_model_270 ;
                              F16_types.nz = nzd_274 ;
                              F16_types.ps = psd_275 ;
                              F16_types.ny_r = ny_rd_273 } in
                        let (dx_337:FadFloat.t) = xd_248.F16_types.ny_r in
                        self.m_379 <- FadFloat.(+) x_380 
                                                   (FadFloat.( * ) tstep'_213
                                                                    dx_337) ;
                        (let (dx_333:FadFloat.t) = xd_248.F16_types.ps in
                         self.m_377 <- FadFloat.(+) x_378 
                                                    (FadFloat.( * ) tstep'_213
                                                                     
                                                                    dx_333) ;
                         (let (dx_329:FadFloat.t) = xd_248.F16_types.nz in
                          self.m_375 <- FadFloat.(+) x_376 
                                                     (FadFloat.( * ) 
                                                        tstep'_213  dx_329) ;
                          (let (dx_325:FadFloat.t) =
                               xd_248.F16_types.f16.F16_types.power in
                           self.m_373 <- FadFloat.(+) x_374 
                                                      (FadFloat.( * ) 
                                                         tstep'_213  dx_325)
                           ;
                           (let (dx_321:FadFloat.t) =
                                xd_248.F16_types.f16.F16_types.alt in
                            self.m_371 <- FadFloat.(+) x_372 
                                                       (FadFloat.( * ) 
                                                          tstep'_213  dx_321)
                            ;
                            (let (dx_317:FadFloat.t) =
                                 xd_248.F16_types.f16.F16_types.x10 in
                             self.m_369 <- FadFloat.(+) x_370 
                                                        (FadFloat.( * ) 
                                                           tstep'_213  dx_317)
                             ;
                             (let (dx_313:FadFloat.t) =
                                  xd_248.F16_types.f16.F16_types.x9 in
                              self.m_367 <- FadFloat.(+) x_368 
                                                         (FadFloat.( * ) 
                                                            tstep'_213 
                                                            dx_313) ;
                              (let (dx_309:FadFloat.t) =
                                   xd_248.F16_types.f16.F16_types.r in
                               self.m_365 <- FadFloat.(+) x_366 
                                                          (FadFloat.( * ) 
                                                             tstep'_213 
                                                             dx_309) ;
                               (let (dx_305:FadFloat.t) =
                                    xd_248.F16_types.f16.F16_types.q in
                                self.m_363 <- FadFloat.(+) x_364 
                                                           (FadFloat.( * ) 
                                                              tstep'_213 
                                                              dx_305) ;
                                (let (dx_301:FadFloat.t) =
                                     xd_248.F16_types.f16.F16_types.p in
                                 self.m_361 <- FadFloat.(+) x_362 
                                                            (FadFloat.( * ) 
                                                               tstep'_213 
                                                               dx_301) ;
                                 (let (dx_297:FadFloat.t) =
                                      xd_248.F16_types.f16.F16_types.psi in
                                  self.m_359 <- FadFloat.(+) x_360 
                                                             (FadFloat.( * ) 
                                                                tstep'_213 
                                                                dx_297) ;
                                  (let (dx_293:FadFloat.t) =
                                       xd_248.F16_types.f16.F16_types.theta in
                                   self.m_357 <- FadFloat.(+) x_358 
                                                              (FadFloat.( * ) 
                                                                 tstep'_213 
                                                                 dx_293) ;
                                   (let (dx_289:FadFloat.t) =
                                        xd_248.F16_types.f16.F16_types.phi in
                                    self.m_355 <- FadFloat.(+) x_356 
                                                               (FadFloat.( * ) 
                                                                  tstep'_213 
                                                                  dx_289) ;
                                    (let (dx_285:FadFloat.t) =
                                         xd_248.F16_types.f16.F16_types.beta in
                                     self.m_353 <- FadFloat.(+) x_354 
                                                                (FadFloat.( * ) 
                                                                   tstep'_213
                                                                    dx_285) ;
                                     (let (dx_281:FadFloat.t) =
                                          xd_248.F16_types.f16.F16_types.alpha in
                                      self.m_351 <- FadFloat.(+) x_352 
                                                                 (FadFloat.( * ) 
                                                                    tstep'_213
                                                                     
                                                                    dx_281) ;
                                      (let (dx_277:FadFloat.t) =
                                           xd_248.F16_types.f16.F16_types.vt in
                                       self.m_349 <- FadFloat.(+) x_350 
                                                                  (FadFloat.( * ) 
                                                                    tstep'_213
                                                                     
                                                                    dx_277) ;
                                       (let (dx_259:FadFloat.t) =
                                            FadFloat.make 1. in
                                        self.m_347 <- FadFloat.(+) x_348 
                                                                   (FadFloat.( * ) 
                                                                    tstep'_213
                                                                     
                                                                    dx_259) ;
                                        (let (x_346:float) = self.m_345 in
                                         self.m_345 <- (+.) x_346  tstep_206
                                         ;
                                         (x_346 ,
                                          outp_208 ,
                                          (FadFloat.translate rob_211  10.)))))))))))))))))))))))))))))))))))))):
    float * FadFloat.t Array.t * FadFloat.t) in
  Node { alloc = f16_alloc; reset = f16_reset ; step = f16_step }
