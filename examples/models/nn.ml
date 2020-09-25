(* The Zélus compiler, version 2.1
  (vendredi 25 septembre 2020, 16:45:09 (UTC+0200)) *)
open Ztypes
type state__2578 =
Nn_Fals_226
| Nn_Hold_225 | Nn_Out_Bounds_224 | Nn_In_Bounds_223 | Nn_Init_222 
type state__2577 =
Nn_Fals_140
| Nn_Hold_139 | Nn_Out_Bounds_138 | Nn_In_Bounds_137 | Nn_Init_136 
type state__2576 =
Nn_Fals_54 | Nn_Hold_53 | Nn_Out_Bounds_52 | Nn_In_Bounds_51 | Nn_Init_50 
open FadFloat
open Discrete_obs_fad
type ('h , 'g , 'f , 'e , 'd , 'c , 'b , 'a) _nn1 =
  { mutable i_346 : 'h ;
    mutable m_344 : 'g ;
    mutable r_343 : 'f ;
    mutable s_342 : 'e ;
    mutable t1_341 : 'd ;
    mutable t0_340 : 'c ; mutable t0_339 : 'b ; mutable result_338 : 'a }

let nn1  = 
  
  let nn1_alloc _ =
    ();
    { i_346 = (false:bool) ;
      m_344 = (create ():FadFloat.t) ;
      r_343 = (false:bool) ;
      s_342 = (Nn_Fals_54:state__2576) ;
      t1_341 = (create ():FadFloat.t) ;
      t0_340 = (create ():FadFloat.t) ;
      t0_339 = (create ():FadFloat.t) ;
      result_338 = (create ():FadFloat.t) } in
  let nn1_reset self  =
    ((self.i_346 <- true ; self.r_343 <- false ; self.s_342 <- Nn_Init_50):
    unit) in 
  let nn1_step self ((tstep_333:FadFloat.t) ,
                     (alpha_329:FadFloat.t) ,
                     (beta_330:FadFloat.t) ,
                     (inp_331:(FadFloat.t)Array.t) ,
                     (outp_332:(FadFloat.t)Array.t)) =
    (((if self.i_346 then self.m_344 <- FadFloat.make 0.) ;
      self.i_346 <- false ;
      (let (x_345:FadFloat.t) = self.m_344 in
       self.m_344 <- FadFloat.(+) x_345  tstep_333 ;
       (let (ref_335:FadFloat.t) = Array.get inp_331  0 in
        let (pos_336:FadFloat.t) = Array.get outp_332  0 in
        let (in_bounds_337:FadFloat.t) =
            Discrete_obs_fad.q_lt ((Discrete_obs_fad.abs (FadFloat.(-) 
                                                            pos_336  ref_335))
                                   ,
                                   (FadFloat.(+) alpha_329 
                                                 (FadFloat.( * ) beta_330 
                                                                 (Discrete_obs_fad.abs 
                                                                    ref_335)))) in
        (begin match self.s_342 with
               | Nn_Init_50 ->
                   (if self.r_343 then ()) ;
                   self.result_338 <- FadFloat.make 1. ;
                   (begin match (((>=) x_345  (FadFloat.make 1.)) ,
                                 (Discrete_obs_fad.isFalse in_bounds_337) ,
                                 ((>=) x_345  (FadFloat.make 1.)) ,
                                 (Discrete_obs_fad.isTrue in_bounds_337)) with
                          | (_ , _ , true , true) ->
                              self.r_343 <- true ;
                              self.s_342 <- Nn_In_Bounds_51
                          | (true , true , _ , _) ->
                              self.t0_339 <- x_345 ;
                              self.r_343 <- true ;
                              self.s_342 <- Nn_Out_Bounds_52
                          | _ -> self.r_343 <- false  end)
               | Nn_In_Bounds_51 ->
                   (if self.r_343 then ()) ;
                   self.result_338 <- in_bounds_337 ;
                   (begin match Discrete_obs_fad.isFalse in_bounds_337 with
                          | true ->
                              self.t0_339 <- x_345 ;
                              self.r_343 <- true ;
                              self.s_342 <- Nn_Out_Bounds_52
                          | _ -> self.r_343 <- false  end)
               | Nn_Out_Bounds_52 ->
                   (if self.r_343 then ()) ;
                   self.result_338 <- in_bounds_337 ;
                   (begin match (((>) x_345 
                                      (FadFloat.translate self.t0_339  2.)) ,
                                 (Discrete_obs_fad.isTrue in_bounds_337)) with
                          | (_ , true) ->
                              self.t1_341 <- x_345 ;
                              self.t0_340 <- self.t0_339 ;
                              self.r_343 <- true ; self.s_342 <- Nn_Hold_53
                          | (true , _) ->
                              self.r_343 <- true ; self.s_342 <- Nn_Fals_54
                          | _ -> self.r_343 <- false  end)
               | Nn_Hold_53 ->
                   (if self.r_343 then ()) ;
                   self.result_338 <- in_bounds_337 ;
                   (begin match (((>=) x_345 
                                       (FadFloat.translate self.t1_341  1.))
                                 ,
                                 ((>) x_345 
                                      (FadFloat.translate self.t0_340  2.)) ,
                                 ((>=) x_345 
                                       (FadFloat.translate self.t1_341  1.))
                                 ,
                                 ((<=) x_345 
                                       (FadFloat.translate self.t0_340  2.))
                                 ,
                                 (Discrete_obs_fad.isFalse in_bounds_337) ,
                                 ((<) x_345 
                                      (FadFloat.translate self.t1_341  1.))) with
                          | (_ , _ , _ , _ , true , true) ->
                              self.t0_339 <- self.t0_340 ;
                              self.r_343 <- true ;
                              self.s_342 <- Nn_Out_Bounds_52
                          | (_ , _ , true , true , _ , _) ->
                              self.r_343 <- true ;
                              self.s_342 <- Nn_In_Bounds_51
                          | (true , true , _ , _ , _ , _) ->
                              self.r_343 <- true ; self.s_342 <- Nn_Fals_54
                          | _ -> self.r_343 <- false  end)
               | Nn_Fals_54 ->
                   (if self.r_343 then ()) ;
                   self.result_338 <- FadFloat.make (-1.) ;
                   self.r_343 <- false
                end) ; self.result_338))):FadFloat.t) in
  Node { alloc = nn1_alloc; reset = nn1_reset ; step = nn1_step }
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
      'n , 'm , 'l , 'k , 'j , 'i , 'h , 'g , 'f , 'e , 'd , 'c , 'b , 'a) _nn_nn1 =
  { mutable i_604 : 'z ;
    mutable i_603 : 'y ;
    mutable i_474 : 'x ;
    mutable m_472 : 'w ;
    mutable m_470 : 'v ;
    mutable m_465 : 'u ;
    mutable m_463 : 't ;
    mutable m_459 : 's ;
    mutable m_454 : 'r ;
    mutable m_452 : 'q ;
    mutable m_448 : 'p ;
    mutable m_444 : 'o ;
    mutable m_442 : 'n ;
    mutable m_440 : 'm ;
    mutable nx_439 : 'l ;
    mutable nx_438 : 'k ;
    mutable m_436 : 'j ;
    mutable m_434 : 'i ;
    mutable m_430 : 'h ;
    mutable r_429 : 'g ;
    mutable s_428 : 'f ;
    mutable t1_427 : 'e ;
    mutable t0_426 : 'd ;
    mutable t0_425 : 'c ; mutable result_424 : 'b ; mutable tstep'_356 : 'a }

let nn_nn1 (tstep_348:float) = 
  let Node { alloc = i_604_alloc; step = i_604_step ; reset = i_604_reset } = Nn_d.integrate 
   in 
  let Node { alloc = i_603_alloc; step = i_603_step ; reset = i_603_reset } = Nn_d.zero_order_hold 
   in
  let nn_nn1_alloc _ =
    ();
    { i_474 = (false:bool) ;
      m_472 = (create ():FadFloat.t) ;
      m_470 = (create ():FadFloat.t) ;
      m_465 = (create ():FadFloat.t) ;
      m_463 = (create ():FadFloat.t) ;
      m_459 = (create ():FadFloat.t) ;
      m_454 = (create ():FadFloat.t) ;
      m_452 = (create ():FadFloat.t) ;
      m_448 = (create ():FadFloat.t) ;
      m_444 = (create ():FadFloat.t) ;
      m_442 = (create ():FadFloat.t) ;
      m_440 = (create ():FadFloat.t) ;
      nx_439 = (create ():FadFloat.t) ;
      nx_438 = (create ():FadFloat.t) ;
      m_436 = (create ():FadFloat.t) ;
      m_434 = (create ():FadFloat.t) ;
      m_430 = (create ():FadFloat.t) ;
      r_429 = (false:bool) ;
      s_428 = (Nn_Fals_140:state__2577) ;
      t1_427 = (create ():FadFloat.t) ;
      t0_426 = (create ():FadFloat.t) ;
      t0_425 = (create ():FadFloat.t) ;
      result_424 = (create ():FadFloat.t) ;
      tstep'_356 = (create ():FadFloat.t);
      i_604 = i_604_alloc () (* discrete *)  ;
      i_603 = i_603_alloc () (* discrete *)  } in
  let nn_nn1_reset self  =
    ((self.i_474 <- true ;
      self.r_429 <- false ;
      self.s_428 <- Nn_Init_136 ;
      i_604_reset self.i_604  ; i_603_reset self.i_603 ):unit) in 
  let nn_nn1_step self (inp_347:(FadFloat.t)Array.t) =
    (((if self.i_474 then self.m_472 <- FadFloat.make 0.) ;
      (if self.i_474 then self.m_470 <- FadFloat.make 0.) ;
      (let (y0_413:FadFloat.t) = FadFloat.make 0. in
       (if self.i_474 then self.m_440 <- y0_413) ;
       (let (x_441:FadFloat.t) = self.m_440 in
        let (compute_404:bool) = (>) x_441  self.m_442 in
        let (x_469:FadFloat.t) =
            if self.i_474
            then FadFloat.make 0.
            else if compute_404 then self.m_463 else self.m_465 in
        let (x_471:FadFloat.t) = self.m_470 in
        let (x_462:FadFloat.t) =
            if self.i_474
            then x_471
            else if compute_404 then x_471 else self.m_459 in
        let (x_458:FadFloat.t) =
            if self.i_474
            then FadFloat.make 0.
            else if compute_404 then self.m_452 else self.m_454 in
        let (y0_372:FadFloat.t) = FadFloat.make 0.5 in
        (if self.i_474 then self.m_434 <- y0_372) ;
        (let (x_435:FadFloat.t) = self.m_434 in
         let (sig1_388:FadFloat.t) =
             if Nn_utils.normalize
             then Nn_d.normalize_in (Nn_utils.mint , Nn_utils.maxt , x_435)
             else x_435 in
         let (x_451:FadFloat.t) =
             if self.i_474
             then sig1_388
             else if compute_404 then sig1_388 else self.m_448 in
         let (x_447:FadFloat.t) =
             if self.i_474
             then FadFloat.make Nn_utils.ts
             else
               if compute_404
               then
                 FadFloat.scale (FadFloat.translate (FadFloat.floor (
                                                                    FadFloat.scale 
                                                                    x_441 
                                                                    (
                                                                    (/.) 
                                                                    1. 
                                                                    Nn_utils.ts)))
                                                     1.)  Nn_utils.ts
               else self.m_444 in
         let (lw_2_383:FadFloat.t) =
             Nn_d.mat_op (Nn_utils.iw3_1_1 ,
                          Nn_utils.iw3_1_2 ,
                          Nn_utils.iw3_1_3 ,
                          Nn_utils.iw3_1_4 ,
                          Nn_utils.iw3_2_1 ,
                          Nn_utils.iw3_2_2 ,
                          Nn_utils.iw3_2_3 ,
                          Nn_utils.iw3_2_4 ,
                          Nn_utils.iw3_3_1 ,
                          Nn_utils.iw3_3_2 ,
                          Nn_utils.iw3_3_3 ,
                          Nn_utils.iw3_3_4 ,
                          Nn_utils.iw3_4_1 ,
                          Nn_utils.iw3_4_2 ,
                          Nn_utils.iw3_4_3 ,
                          Nn_utils.iw3_4_4 ,
                          Nn_utils.iw3_5_1 ,
                          Nn_utils.iw3_5_2 ,
                          Nn_utils.iw3_5_3 ,
                          Nn_utils.iw3_5_4 ,
                          Nn_utils.iw3_6_1 ,
                          Nn_utils.iw3_6_2 ,
                          Nn_utils.iw3_6_3 ,
                          Nn_utils.iw3_6_4 ,
                          Nn_utils.iw3_7_1 ,
                          Nn_utils.iw3_7_2 ,
                          Nn_utils.iw3_7_3 ,
                          Nn_utils.iw3_7_4 ,
                          Nn_utils.iw3_8_1 ,
                          Nn_utils.iw3_8_2 ,
                          Nn_utils.iw3_8_3 ,
                          Nn_utils.iw3_8_4 ,
                          Nn_utils.iw3_9_1 ,
                          Nn_utils.iw3_9_2 ,
                          Nn_utils.iw3_9_3 ,
                          Nn_utils.iw3_9_4 ,
                          Nn_utils.b3_1 ,
                          Nn_utils.b3_2 ,
                          Nn_utils.b3_3 ,
                          Nn_utils.b3_4 ,
                          Nn_utils.b3_5 ,
                          Nn_utils.b3_6 ,
                          Nn_utils.b3_7 ,
                          Nn_utils.b3_8 ,
                          Nn_utils.b3_9 ,
                          Nn_utils.lw4_1 ,
                          Nn_utils.lw4_2 ,
                          Nn_utils.lw4_3 ,
                          Nn_utils.lw4_4 ,
                          Nn_utils.lw4_5 ,
                          Nn_utils.lw4_6 ,
                          Nn_utils.lw4_7 ,
                          Nn_utils.lw4_8 ,
                          Nn_utils.lw4_9 ,
                          Nn_utils.b4 ,
                          (( *. ) (( *. ) Nn_utils.lw6_5  Nn_utils.lw5) 
                                  Nn_utils.iw5) ,
                          x_451 , x_458 , x_462 , x_469) in
         let (lw_1_382:FadFloat.t) =
             Nn_d.mat_op (Nn_utils.iw1_1_1 ,
                          Nn_utils.iw1_1_2 ,
                          Nn_utils.iw1_1_3 ,
                          Nn_utils.iw1_1_4 ,
                          Nn_utils.iw1_2_1 ,
                          Nn_utils.iw1_2_2 ,
                          Nn_utils.iw1_2_3 ,
                          Nn_utils.iw1_2_4 ,
                          Nn_utils.iw1_3_1 ,
                          Nn_utils.iw1_3_2 ,
                          Nn_utils.iw1_3_3 ,
                          Nn_utils.iw1_3_4 ,
                          Nn_utils.iw1_4_1 ,
                          Nn_utils.iw1_4_2 ,
                          Nn_utils.iw1_4_3 ,
                          Nn_utils.iw1_4_4 ,
                          Nn_utils.iw1_5_1 ,
                          Nn_utils.iw1_5_2 ,
                          Nn_utils.iw1_5_3 ,
                          Nn_utils.iw1_5_4 ,
                          Nn_utils.iw1_6_1 ,
                          Nn_utils.iw1_6_2 ,
                          Nn_utils.iw1_6_3 ,
                          Nn_utils.iw1_6_4 ,
                          Nn_utils.iw1_7_1 ,
                          Nn_utils.iw1_7_2 ,
                          Nn_utils.iw1_7_3 ,
                          Nn_utils.iw1_7_4 ,
                          Nn_utils.iw1_8_1 ,
                          Nn_utils.iw1_8_2 ,
                          Nn_utils.iw1_8_3 ,
                          Nn_utils.iw1_8_4 ,
                          Nn_utils.iw1_9_1 ,
                          Nn_utils.iw1_9_2 ,
                          Nn_utils.iw1_9_3 ,
                          Nn_utils.iw1_9_4 ,
                          Nn_utils.b1_1 ,
                          Nn_utils.b1_2 ,
                          Nn_utils.b1_3 ,
                          Nn_utils.b1_4 ,
                          Nn_utils.b1_5 ,
                          Nn_utils.b1_6 ,
                          Nn_utils.b1_7 ,
                          Nn_utils.b1_8 ,
                          Nn_utils.b1_9 ,
                          Nn_utils.lw2_1 ,
                          Nn_utils.lw2_2 ,
                          Nn_utils.lw2_3 ,
                          Nn_utils.lw2_4 ,
                          Nn_utils.lw2_5 ,
                          Nn_utils.lw2_6 ,
                          Nn_utils.lw2_7 ,
                          Nn_utils.lw2_8 ,
                          Nn_utils.lw2_9 ,
                          Nn_utils.b2 ,
                          Nn_utils.lw6_2 , x_451 , x_458 , x_462 , x_469) in
         let (ref_353:FadFloat.t) = Array.get inp_347  0 in
         let (ref'_387:FadFloat.t) =
             if Nn_utils.normalize
             then Nn_d.normalize_in (Nn_utils.mint , Nn_utils.maxt , ref_353)
             else ref_353 in
         let (p_385:FadFloat.t) =
             FadFloat.(/) (FadFloat.(-) ref'_387  lw_1_382)  lw_2_383 in
         let (out1_384:FadFloat.t) =
             if Nn_utils.normalize
             then Nn_d.normalize_out (Nn_utils.minp , Nn_utils.maxp , p_385)
             else p_385 in
         let (x_396:FadFloat.t) =
             Nn_d.saturate ((FadFloat.make Nn_utils.min_i) ,
                            (FadFloat.make Nn_utils.max_i) , out1_384) in
         (if self.i_474 then self.nx_439 <- x_396) ;
         (if self.i_474 then self.nx_438 <- FadFloat.make Nn_utils.ts) ;
         (let (y0_376:FadFloat.t) = FadFloat.make 0. in
          (if self.i_474 then self.m_436 <- y0_376) ;
          (if self.i_474 then self.tstep'_356 <- FadFloat.make tstep_348) ;
          (if self.i_474 then self.m_430 <- self.tstep'_356) ;
          self.i_474 <- false ;
          (let (x_473:FadFloat.t) = self.m_472 in
           self.m_472 <- FadFloat.(+) x_473  self.tstep'_356 ;
           (let (alpha_415:FadFloat.t) = FadFloat.make 0.005 in
            let (beta_416:FadFloat.t) = FadFloat.make 0.03 in
            let (ref_421:FadFloat.t) = Array.get inp_347  0 in
            let (x_disc_399:FadFloat.t) = self.nx_439 in
            let (plant_approx_386:FadFloat.t) =
                FadFloat.(+) lw_1_382  (FadFloat.( * ) lw_2_383  x_disc_399) in
            let (outp_351:(FadFloat.t)Array.t) =
                Array.of_list ((::) (x_435 , ((::) (plant_approx_386 , ([]))))) in
            let (pos_422:FadFloat.t) = Array.get outp_351  0 in
            let (in_bounds_423:FadFloat.t) =
                Discrete_obs_fad.q_lt ((Discrete_obs_fad.abs (FadFloat.(-) 
                                                                pos_422 
                                                                ref_421)) ,
                                       (FadFloat.(+) alpha_415 
                                                     (FadFloat.( * ) 
                                                        beta_416 
                                                        (Discrete_obs_fad.abs 
                                                           ref_421)))) in
            (begin match self.s_428 with
                   | Nn_Init_136 ->
                       (if self.r_429 then ()) ;
                       self.result_424 <- FadFloat.make 1. ;
                       (begin match (((>=) x_473  (FadFloat.make 1.)) ,
                                     (Discrete_obs_fad.isFalse in_bounds_423)
                                     ,
                                     ((>=) x_473  (FadFloat.make 1.)) ,
                                     (Discrete_obs_fad.isTrue in_bounds_423)) with
                              | (_ , _ , true , true) ->
                                  self.r_429 <- true ;
                                  self.s_428 <- Nn_In_Bounds_137
                              | (true , true , _ , _) ->
                                  self.t0_425 <- x_473 ;
                                  self.r_429 <- true ;
                                  self.s_428 <- Nn_Out_Bounds_138
                              | _ -> self.r_429 <- false  end)
                   | Nn_In_Bounds_137 ->
                       (if self.r_429 then ()) ;
                       self.result_424 <- in_bounds_423 ;
                       (begin match Discrete_obs_fad.isFalse in_bounds_423 with
                              | true ->
                                  self.t0_425 <- x_473 ;
                                  self.r_429 <- true ;
                                  self.s_428 <- Nn_Out_Bounds_138
                              | _ -> self.r_429 <- false  end)
                   | Nn_Out_Bounds_138 ->
                       (if self.r_429 then ()) ;
                       self.result_424 <- in_bounds_423 ;
                       (begin match (((>) x_473 
                                          (FadFloat.translate self.t0_425  2.))
                                     ,
                                     (Discrete_obs_fad.isTrue in_bounds_423)) with
                              | (_ , true) ->
                                  self.t1_427 <- x_473 ;
                                  self.t0_426 <- self.t0_425 ;
                                  self.r_429 <- true ;
                                  self.s_428 <- Nn_Hold_139
                              | (true , _) ->
                                  self.r_429 <- true ;
                                  self.s_428 <- Nn_Fals_140
                              | _ -> self.r_429 <- false  end)
                   | Nn_Hold_139 ->
                       (if self.r_429 then ()) ;
                       self.result_424 <- in_bounds_423 ;
                       (begin match (((>=) x_473 
                                           (FadFloat.translate self.t1_427 
                                                               1.)) ,
                                     ((>) x_473 
                                          (FadFloat.translate self.t0_426  2.))
                                     ,
                                     ((>=) x_473 
                                           (FadFloat.translate self.t1_427 
                                                               1.)) ,
                                     ((<=) x_473 
                                           (FadFloat.translate self.t0_426 
                                                               2.)) ,
                                     (Discrete_obs_fad.isFalse in_bounds_423)
                                     ,
                                     ((<) x_473 
                                          (FadFloat.translate self.t1_427  1.))) with
                              | (_ , _ , _ , _ , true , true) ->
                                  self.t0_425 <- self.t0_426 ;
                                  self.r_429 <- true ;
                                  self.s_428 <- Nn_Out_Bounds_138
                              | (_ , _ , true , true , _ , _) ->
                                  self.r_429 <- true ;
                                  self.s_428 <- Nn_In_Bounds_137
                              | (true , true , _ , _ , _ , _) ->
                                  self.r_429 <- true ;
                                  self.s_428 <- Nn_Fals_140
                              | _ -> self.r_429 <- false  end)
                   | Nn_Fals_140 ->
                       (if self.r_429 then ()) ;
                       self.result_424 <- FadFloat.make (-1.) ;
                       self.r_429 <- false
                    end) ;
            self.m_470 <- (if Nn_utils.normalize
                           then
                             Nn_d.normalize_in (Nn_utils.minp ,
                                                Nn_utils.maxp , x_disc_399)
                           else x_disc_399) ;
            self.m_465 <- x_469 ;
            self.m_463 <- x_462 ;
            self.m_459 <- x_462 ;
            self.m_454 <- x_458 ;
            self.m_452 <- x_451 ;
            self.m_448 <- x_451 ;
            self.m_444 <- x_447 ;
            self.m_442 <- x_447 ;
            (let (dy_411:FadFloat.t) = FadFloat.make 1. in
             self.m_440 <- FadFloat.(+) (FadFloat.( * ) self.tstep'_356 
                                                        dy_411)  x_441 ;
             (let (t_398:FadFloat.t) =
                  i_604_step self.i_604
                    (self.tstep'_356 ,
                     (FadFloat.make 1.) , (FadFloat.make 0.)) in
              let (hor_397:FadFloat.t) = self.nx_438 in
              (begin match (>) t_398  hor_397 with
                     | true ->
                         self.nx_439 <- x_396 ;
                         self.nx_438 <- FadFloat.scale (FadFloat.translate 
                                                          (FadFloat.floor 
                                                             (FadFloat.scale 
                                                                t_398 
                                                                ((/.) 
                                                                   1. 
                                                                   Nn_utils.ts)))
                                                           1.)  Nn_utils.ts
                     | _ -> ()  end) ;
              (let (cur_disc_360:FadFloat.t) =
                   i_603_step self.i_603
                     (self.tstep'_356 , Nn_utils.u_ts , x_disc_399) in
               let (aux1_366:FadFloat.t) =
                   FadFloat.scale (FadFloat.(/) (FadFloat.scale (FadFloat.sqr 
                                                                   cur_disc_360)
                                                                
                                                                (Nn_d.sgn 
                                                                   cur_disc_360))
                                                 x_435) 
                                  ((/.) 15.  Nn_utils.mass) in
               let (x_437:FadFloat.t) = self.m_436 in
               let (visc_fric_369:FadFloat.t) =
                   FadFloat.scale x_437  ((/.) 12.  Nn_utils.mass) in
               let (acc_365:FadFloat.t) =
                   FadFloat.translate (FadFloat.(-) aux1_366  visc_fric_369) 
                                      ((~-.) Nn_utils.gravity) in
               self.m_436 <- FadFloat.(+) (FadFloat.( * ) self.tstep'_356 
                                                          acc_365)  x_437 ;
               self.m_434 <- FadFloat.(+) (FadFloat.( * ) self.tstep'_356 
                                                          x_437)  x_435 ;
               (let (x_431:FadFloat.t) = self.m_430 in
                self.m_430 <- FadFloat.(+) x_431  self.tstep'_356 ;
                ((FadFloat.get x_431) , outp_351 , self.result_424)))))))))))):
    float * FadFloat.t Array.t * FadFloat.t) in
  Node { alloc = nn_nn1_alloc; reset = nn_nn1_reset ; step = nn_nn1_step }
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
      'n , 'm , 'l , 'k , 'j , 'i , 'h , 'g , 'f , 'e , 'd , 'c , 'b , 'a) _nn_nn2 =
  { mutable i_606 : 'z ;
    mutable i_605 : 'y ;
    mutable i_602 : 'x ;
    mutable m_600 : 'w ;
    mutable m_598 : 'v ;
    mutable m_593 : 'u ;
    mutable m_591 : 't ;
    mutable m_587 : 's ;
    mutable m_582 : 'r ;
    mutable m_580 : 'q ;
    mutable m_576 : 'p ;
    mutable m_572 : 'o ;
    mutable m_570 : 'n ;
    mutable m_568 : 'm ;
    mutable nx_567 : 'l ;
    mutable nx_566 : 'k ;
    mutable m_564 : 'j ;
    mutable m_562 : 'i ;
    mutable m_558 : 'h ;
    mutable r_557 : 'g ;
    mutable s_556 : 'f ;
    mutable t1_555 : 'e ;
    mutable t0_554 : 'd ;
    mutable t0_553 : 'c ; mutable result_552 : 'b ; mutable tstep'_484 : 'a }

let nn_nn2 (tstep_476:float) = 
  let Node { alloc = i_606_alloc; step = i_606_step ; reset = i_606_reset } = Nn_d.integrate 
   in 
  let Node { alloc = i_605_alloc; step = i_605_step ; reset = i_605_reset } = Nn_d.zero_order_hold 
   in
  let nn_nn2_alloc _ =
    ();
    { i_602 = (false:bool) ;
      m_600 = (create ():FadFloat.t) ;
      m_598 = (create ():FadFloat.t) ;
      m_593 = (create ():FadFloat.t) ;
      m_591 = (create ():FadFloat.t) ;
      m_587 = (create ():FadFloat.t) ;
      m_582 = (create ():FadFloat.t) ;
      m_580 = (create ():FadFloat.t) ;
      m_576 = (create ():FadFloat.t) ;
      m_572 = (create ():FadFloat.t) ;
      m_570 = (create ():FadFloat.t) ;
      m_568 = (create ():FadFloat.t) ;
      nx_567 = (create ():FadFloat.t) ;
      nx_566 = (create ():FadFloat.t) ;
      m_564 = (create ():FadFloat.t) ;
      m_562 = (create ():FadFloat.t) ;
      m_558 = (create ():FadFloat.t) ;
      r_557 = (false:bool) ;
      s_556 = (Nn_Fals_226:state__2578) ;
      t1_555 = (create ():FadFloat.t) ;
      t0_554 = (create ():FadFloat.t) ;
      t0_553 = (create ():FadFloat.t) ;
      result_552 = (create ():FadFloat.t) ;
      tstep'_484 = (create ():FadFloat.t);
      i_606 = i_606_alloc () (* discrete *)  ;
      i_605 = i_605_alloc () (* discrete *)  } in
  let nn_nn2_reset self  =
    ((self.i_602 <- true ;
      self.r_557 <- false ;
      self.s_556 <- Nn_Init_222 ;
      i_606_reset self.i_606  ; i_605_reset self.i_605 ):unit) in 
  let nn_nn2_step self (inp_475:(FadFloat.t)Array.t) =
    (((if self.i_602 then self.m_600 <- FadFloat.make 0.) ;
      (if self.i_602 then self.m_598 <- FadFloat.make 0.) ;
      (let (y0_541:FadFloat.t) = FadFloat.make 0. in
       (if self.i_602 then self.m_568 <- y0_541) ;
       (let (x_569:FadFloat.t) = self.m_568 in
        let (compute_532:bool) = (>) x_569  self.m_570 in
        let (x_597:FadFloat.t) =
            if self.i_602
            then FadFloat.make 0.
            else if compute_532 then self.m_591 else self.m_593 in
        let (x_599:FadFloat.t) = self.m_598 in
        let (x_590:FadFloat.t) =
            if self.i_602
            then x_599
            else if compute_532 then x_599 else self.m_587 in
        let (x_586:FadFloat.t) =
            if self.i_602
            then FadFloat.make 0.
            else if compute_532 then self.m_580 else self.m_582 in
        let (y0_500:FadFloat.t) = FadFloat.make 0.5 in
        (if self.i_602 then self.m_562 <- y0_500) ;
        (let (x_563:FadFloat.t) = self.m_562 in
         let (sig1_516:FadFloat.t) =
             if Nn_utils.normalize
             then Nn_d.normalize_in (Nn_utils.mint , Nn_utils.maxt , x_563)
             else x_563 in
         let (x_579:FadFloat.t) =
             if self.i_602
             then sig1_516
             else if compute_532 then sig1_516 else self.m_576 in
         let (x_575:FadFloat.t) =
             if self.i_602
             then FadFloat.make Nn_utils.ts
             else
               if compute_532
               then
                 FadFloat.scale (FadFloat.translate (FadFloat.floor (
                                                                    FadFloat.scale 
                                                                    x_569 
                                                                    (
                                                                    (/.) 
                                                                    1. 
                                                                    Nn_utils.ts)))
                                                     1.)  Nn_utils.ts
               else self.m_572 in
         let (lw_2_511:FadFloat.t) =
             Nn_d.mat_op (Nn_utils.iw3_1_1 ,
                          Nn_utils.iw3_1_2 ,
                          Nn_utils.iw3_1_3 ,
                          Nn_utils.iw3_1_4 ,
                          Nn_utils.iw3_2_1 ,
                          Nn_utils.iw3_2_2 ,
                          Nn_utils.iw3_2_3 ,
                          Nn_utils.iw3_2_4 ,
                          Nn_utils.iw3_3_1 ,
                          Nn_utils.iw3_3_2 ,
                          Nn_utils.iw3_3_3 ,
                          Nn_utils.iw3_3_4 ,
                          Nn_utils.iw3_4_1 ,
                          Nn_utils.iw3_4_2 ,
                          Nn_utils.iw3_4_3 ,
                          Nn_utils.iw3_4_4 ,
                          Nn_utils.iw3_5_1 ,
                          Nn_utils.iw3_5_2 ,
                          Nn_utils.iw3_5_3 ,
                          Nn_utils.iw3_5_4 ,
                          Nn_utils.iw3_6_1 ,
                          Nn_utils.iw3_6_2 ,
                          Nn_utils.iw3_6_3 ,
                          Nn_utils.iw3_6_4 ,
                          Nn_utils.iw3_7_1 ,
                          Nn_utils.iw3_7_2 ,
                          Nn_utils.iw3_7_3 ,
                          Nn_utils.iw3_7_4 ,
                          Nn_utils.iw3_8_1 ,
                          Nn_utils.iw3_8_2 ,
                          Nn_utils.iw3_8_3 ,
                          Nn_utils.iw3_8_4 ,
                          Nn_utils.iw3_9_1 ,
                          Nn_utils.iw3_9_2 ,
                          Nn_utils.iw3_9_3 ,
                          Nn_utils.iw3_9_4 ,
                          Nn_utils.b3_1 ,
                          Nn_utils.b3_2 ,
                          Nn_utils.b3_3 ,
                          Nn_utils.b3_4 ,
                          Nn_utils.b3_5 ,
                          Nn_utils.b3_6 ,
                          Nn_utils.b3_7 ,
                          Nn_utils.b3_8 ,
                          Nn_utils.b3_9 ,
                          Nn_utils.lw4_1 ,
                          Nn_utils.lw4_2 ,
                          Nn_utils.lw4_3 ,
                          Nn_utils.lw4_4 ,
                          Nn_utils.lw4_5 ,
                          Nn_utils.lw4_6 ,
                          Nn_utils.lw4_7 ,
                          Nn_utils.lw4_8 ,
                          Nn_utils.lw4_9 ,
                          Nn_utils.b4 ,
                          (( *. ) (( *. ) Nn_utils.lw6_5  Nn_utils.lw5) 
                                  Nn_utils.iw5) ,
                          x_579 , x_586 , x_590 , x_597) in
         let (lw_1_510:FadFloat.t) =
             Nn_d.mat_op (Nn_utils.iw1_1_1 ,
                          Nn_utils.iw1_1_2 ,
                          Nn_utils.iw1_1_3 ,
                          Nn_utils.iw1_1_4 ,
                          Nn_utils.iw1_2_1 ,
                          Nn_utils.iw1_2_2 ,
                          Nn_utils.iw1_2_3 ,
                          Nn_utils.iw1_2_4 ,
                          Nn_utils.iw1_3_1 ,
                          Nn_utils.iw1_3_2 ,
                          Nn_utils.iw1_3_3 ,
                          Nn_utils.iw1_3_4 ,
                          Nn_utils.iw1_4_1 ,
                          Nn_utils.iw1_4_2 ,
                          Nn_utils.iw1_4_3 ,
                          Nn_utils.iw1_4_4 ,
                          Nn_utils.iw1_5_1 ,
                          Nn_utils.iw1_5_2 ,
                          Nn_utils.iw1_5_3 ,
                          Nn_utils.iw1_5_4 ,
                          Nn_utils.iw1_6_1 ,
                          Nn_utils.iw1_6_2 ,
                          Nn_utils.iw1_6_3 ,
                          Nn_utils.iw1_6_4 ,
                          Nn_utils.iw1_7_1 ,
                          Nn_utils.iw1_7_2 ,
                          Nn_utils.iw1_7_3 ,
                          Nn_utils.iw1_7_4 ,
                          Nn_utils.iw1_8_1 ,
                          Nn_utils.iw1_8_2 ,
                          Nn_utils.iw1_8_3 ,
                          Nn_utils.iw1_8_4 ,
                          Nn_utils.iw1_9_1 ,
                          Nn_utils.iw1_9_2 ,
                          Nn_utils.iw1_9_3 ,
                          Nn_utils.iw1_9_4 ,
                          Nn_utils.b1_1 ,
                          Nn_utils.b1_2 ,
                          Nn_utils.b1_3 ,
                          Nn_utils.b1_4 ,
                          Nn_utils.b1_5 ,
                          Nn_utils.b1_6 ,
                          Nn_utils.b1_7 ,
                          Nn_utils.b1_8 ,
                          Nn_utils.b1_9 ,
                          Nn_utils.lw2_1 ,
                          Nn_utils.lw2_2 ,
                          Nn_utils.lw2_3 ,
                          Nn_utils.lw2_4 ,
                          Nn_utils.lw2_5 ,
                          Nn_utils.lw2_6 ,
                          Nn_utils.lw2_7 ,
                          Nn_utils.lw2_8 ,
                          Nn_utils.lw2_9 ,
                          Nn_utils.b2 ,
                          Nn_utils.lw6_2 , x_579 , x_586 , x_590 , x_597) in
         let (ref_481:FadFloat.t) = Array.get inp_475  0 in
         let (ref'_515:FadFloat.t) =
             if Nn_utils.normalize
             then Nn_d.normalize_in (Nn_utils.mint , Nn_utils.maxt , ref_481)
             else ref_481 in
         let (p_513:FadFloat.t) =
             FadFloat.(/) (FadFloat.(-) ref'_515  lw_1_510)  lw_2_511 in
         let (out1_512:FadFloat.t) =
             if Nn_utils.normalize
             then Nn_d.normalize_out (Nn_utils.minp , Nn_utils.maxp , p_513)
             else p_513 in
         let (x_524:FadFloat.t) =
             Nn_d.saturate ((FadFloat.make Nn_utils.min_i) ,
                            (FadFloat.make Nn_utils.max_i) , out1_512) in
         (if self.i_602 then self.nx_567 <- x_524) ;
         (if self.i_602 then self.nx_566 <- FadFloat.make Nn_utils.ts) ;
         (let (y0_504:FadFloat.t) = FadFloat.make 0. in
          (if self.i_602 then self.m_564 <- y0_504) ;
          (if self.i_602 then self.tstep'_484 <- FadFloat.make tstep_476) ;
          (if self.i_602 then self.m_558 <- self.tstep'_484) ;
          self.i_602 <- false ;
          (let (x_601:FadFloat.t) = self.m_600 in
           self.m_600 <- FadFloat.(+) x_601  self.tstep'_484 ;
           (let (alpha_543:FadFloat.t) = FadFloat.make 0.005 in
            let (beta_544:FadFloat.t) = FadFloat.make 0.04 in
            let (ref_549:FadFloat.t) = Array.get inp_475  0 in
            let (x_disc_527:FadFloat.t) = self.nx_567 in
            let (plant_approx_514:FadFloat.t) =
                FadFloat.(+) lw_1_510  (FadFloat.( * ) lw_2_511  x_disc_527) in
            let (outp_479:(FadFloat.t)Array.t) =
                Array.of_list ((::) (x_563 , ((::) (plant_approx_514 , ([]))))) in
            let (pos_550:FadFloat.t) = Array.get outp_479  0 in
            let (in_bounds_551:FadFloat.t) =
                Discrete_obs_fad.q_lt ((Discrete_obs_fad.abs (FadFloat.(-) 
                                                                pos_550 
                                                                ref_549)) ,
                                       (FadFloat.(+) alpha_543 
                                                     (FadFloat.( * ) 
                                                        beta_544 
                                                        (Discrete_obs_fad.abs 
                                                           ref_549)))) in
            (begin match self.s_556 with
                   | Nn_Init_222 ->
                       (if self.r_557 then ()) ;
                       self.result_552 <- FadFloat.make 1. ;
                       (begin match (((>=) x_601  (FadFloat.make 1.)) ,
                                     (Discrete_obs_fad.isFalse in_bounds_551)
                                     ,
                                     ((>=) x_601  (FadFloat.make 1.)) ,
                                     (Discrete_obs_fad.isTrue in_bounds_551)) with
                              | (_ , _ , true , true) ->
                                  self.r_557 <- true ;
                                  self.s_556 <- Nn_In_Bounds_223
                              | (true , true , _ , _) ->
                                  self.t0_553 <- x_601 ;
                                  self.r_557 <- true ;
                                  self.s_556 <- Nn_Out_Bounds_224
                              | _ -> self.r_557 <- false  end)
                   | Nn_In_Bounds_223 ->
                       (if self.r_557 then ()) ;
                       self.result_552 <- in_bounds_551 ;
                       (begin match Discrete_obs_fad.isFalse in_bounds_551 with
                              | true ->
                                  self.t0_553 <- x_601 ;
                                  self.r_557 <- true ;
                                  self.s_556 <- Nn_Out_Bounds_224
                              | _ -> self.r_557 <- false  end)
                   | Nn_Out_Bounds_224 ->
                       (if self.r_557 then ()) ;
                       self.result_552 <- in_bounds_551 ;
                       (begin match (((>) x_601 
                                          (FadFloat.translate self.t0_553  2.))
                                     ,
                                     (Discrete_obs_fad.isTrue in_bounds_551)) with
                              | (_ , true) ->
                                  self.t1_555 <- x_601 ;
                                  self.t0_554 <- self.t0_553 ;
                                  self.r_557 <- true ;
                                  self.s_556 <- Nn_Hold_225
                              | (true , _) ->
                                  self.r_557 <- true ;
                                  self.s_556 <- Nn_Fals_226
                              | _ -> self.r_557 <- false  end)
                   | Nn_Hold_225 ->
                       (if self.r_557 then ()) ;
                       self.result_552 <- in_bounds_551 ;
                       (begin match (((>=) x_601 
                                           (FadFloat.translate self.t1_555 
                                                               1.)) ,
                                     ((>) x_601 
                                          (FadFloat.translate self.t0_554  2.))
                                     ,
                                     ((>=) x_601 
                                           (FadFloat.translate self.t1_555 
                                                               1.)) ,
                                     ((<=) x_601 
                                           (FadFloat.translate self.t0_554 
                                                               2.)) ,
                                     (Discrete_obs_fad.isFalse in_bounds_551)
                                     ,
                                     ((<) x_601 
                                          (FadFloat.translate self.t1_555  1.))) with
                              | (_ , _ , _ , _ , true , true) ->
                                  self.t0_553 <- self.t0_554 ;
                                  self.r_557 <- true ;
                                  self.s_556 <- Nn_Out_Bounds_224
                              | (_ , _ , true , true , _ , _) ->
                                  self.r_557 <- true ;
                                  self.s_556 <- Nn_In_Bounds_223
                              | (true , true , _ , _ , _ , _) ->
                                  self.r_557 <- true ;
                                  self.s_556 <- Nn_Fals_226
                              | _ -> self.r_557 <- false  end)
                   | Nn_Fals_226 ->
                       (if self.r_557 then ()) ;
                       self.result_552 <- FadFloat.make (-1.) ;
                       self.r_557 <- false
                    end) ;
            self.m_598 <- (if Nn_utils.normalize
                           then
                             Nn_d.normalize_in (Nn_utils.minp ,
                                                Nn_utils.maxp , x_disc_527)
                           else x_disc_527) ;
            self.m_593 <- x_597 ;
            self.m_591 <- x_590 ;
            self.m_587 <- x_590 ;
            self.m_582 <- x_586 ;
            self.m_580 <- x_579 ;
            self.m_576 <- x_579 ;
            self.m_572 <- x_575 ;
            self.m_570 <- x_575 ;
            (let (dy_539:FadFloat.t) = FadFloat.make 1. in
             self.m_568 <- FadFloat.(+) (FadFloat.( * ) self.tstep'_484 
                                                        dy_539)  x_569 ;
             (let (t_526:FadFloat.t) =
                  i_606_step self.i_606
                    (self.tstep'_484 ,
                     (FadFloat.make 1.) , (FadFloat.make 0.)) in
              let (hor_525:FadFloat.t) = self.nx_566 in
              (begin match (>) t_526  hor_525 with
                     | true ->
                         self.nx_567 <- x_524 ;
                         self.nx_566 <- FadFloat.scale (FadFloat.translate 
                                                          (FadFloat.floor 
                                                             (FadFloat.scale 
                                                                t_526 
                                                                ((/.) 
                                                                   1. 
                                                                   Nn_utils.ts)))
                                                           1.)  Nn_utils.ts
                     | _ -> ()  end) ;
              (let (cur_disc_488:FadFloat.t) =
                   i_605_step self.i_605
                     (self.tstep'_484 , Nn_utils.u_ts , x_disc_527) in
               let (aux1_494:FadFloat.t) =
                   FadFloat.scale (FadFloat.(/) (FadFloat.scale (FadFloat.sqr 
                                                                   cur_disc_488)
                                                                
                                                                (Nn_d.sgn 
                                                                   cur_disc_488))
                                                 x_563) 
                                  ((/.) 15.  Nn_utils.mass) in
               let (x_565:FadFloat.t) = self.m_564 in
               let (visc_fric_497:FadFloat.t) =
                   FadFloat.scale x_565  ((/.) 12.  Nn_utils.mass) in
               let (acc_493:FadFloat.t) =
                   FadFloat.translate (FadFloat.(-) aux1_494  visc_fric_497) 
                                      ((~-.) Nn_utils.gravity) in
               self.m_564 <- FadFloat.(+) (FadFloat.( * ) self.tstep'_484 
                                                          acc_493)  x_565 ;
               self.m_562 <- FadFloat.(+) (FadFloat.( * ) self.tstep'_484 
                                                          x_565)  x_563 ;
               (let (x_559:FadFloat.t) = self.m_558 in
                self.m_558 <- FadFloat.(+) x_559  self.tstep'_484 ;
                ((FadFloat.get x_559) , outp_479 , self.result_552)))))))))))):
    float * FadFloat.t Array.t * FadFloat.t) in
  Node { alloc = nn_nn2_alloc; reset = nn_nn2_reset ; step = nn_nn2_step }
