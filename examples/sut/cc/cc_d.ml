(* The Zélus compiler, version 2.1
  (vendredi 25 septembre 2020, 18:02:26 (UTC+0200)) *)
open Ztypes
type state__3069 = Cc_d_Braking_217 | Cc_d_Keeping_216 | Cc_d_Chasing_215 
type state__3068 = Cc_d_Braking_194 | Cc_d_Keeping_193 | Cc_d_Chasing_192 
type state__3067 = Cc_d_Braking_171 | Cc_d_Keeping_170 | Cc_d_Chasing_169 
type state__3066 = Cc_d_Braking_148 | Cc_d_Keeping_147 | Cc_d_Chasing_146 
type state__3065 = Cc_d_Braking_90 | Cc_d_Keeping_89 | Cc_d_Chasing_88 
open FadFloat
let d0 = FadFloat.make 20.

let d1 = FadFloat.make 15.

let d2 = FadFloat.make 10.

let d3 = FadFloat.make 5.

type ('b , 'a) _integrate =
  { mutable i_314 : 'b ; mutable m_312 : 'a }

let integrate  = 
  
  let integrate_alloc _ =
    ();{ i_314 = (false:bool) ; m_312 = (Obj.magic ():FadFloat.t) } in
  let integrate_reset self  =
    (self.i_314 <- true:unit) in 
  let integrate_step self ((tstep_308:FadFloat.t) ,
                           (x_309:FadFloat.t) , (y0_310:FadFloat.t)) =
    (((if self.i_314 then self.m_312 <- y0_310) ;
      self.i_314 <- false ;
      (let (x_313:FadFloat.t) = self.m_312 in
       self.m_312 <- FadFloat.(+) x_313  (FadFloat.( * ) tstep_308  x_309) ;
       x_313)):FadFloat.t) in
  Node { alloc = integrate_alloc; reset = integrate_reset ;
                                  step = integrate_step }
type ('d , 'c , 'b , 'a) _leader_car =
  { mutable i_338 : 'd ;
    mutable m_336 : 'c ; mutable m_334 : 'b ; mutable m_331 : 'a }

let leader_car  = 
  
  let leader_car_alloc _ =
    ();
    { i_338 = (false:bool) ;
      m_336 = (Obj.magic ():FadFloat.t) ;
      m_334 = (Obj.magic ():FadFloat.t) ; m_331 = (Obj.magic ():FadFloat.t) } in
  let leader_car_reset self  =
    (self.i_338 <- true:unit) in 
  let leader_car_step self ((y0_319:FadFloat.t) ,
                            (v0_318:FadFloat.t) ,
                            (t_316:FadFloat.t) ,
                            (throttle_317:FadFloat.t) ,
                            (brake_315:FadFloat.t)) =
    (((if self.i_338 then self.m_336 <- v0_318) ;
      (if self.i_338 then self.m_334 <- y0_319) ;
      (let (x_333:FadFloat.t) =
           if self.i_338 then t_316 else FadFloat.(-) t_316  self.m_331 in
       self.i_338 <- false ;
       (let (x_337:FadFloat.t) = self.m_336 in
        let (x_328:FadFloat.t) =
            FadFloat.(-) (FadFloat.(~-) throttle_317) 
                         (FadFloat.( * ) brake_315  x_337) in
        self.m_336 <- FadFloat.(+) x_337  (FadFloat.( * ) x_333  x_328) ;
        (let (x_335:FadFloat.t) = self.m_334 in
         self.m_334 <- FadFloat.(+) x_335  (FadFloat.( * ) x_333  x_337) ;
         self.m_331 <- t_316 ; x_335)))):FadFloat.t) in
  Node { alloc = leader_car_alloc; reset = leader_car_reset ;
                                   step = leader_car_step }
type ('j , 'i , 'h , 'g , 'f , 'e , 'd , 'c , 'b , 'a) _follower_car =
  { mutable i_368 : 'j ;
    mutable m_366 : 'i ;
    mutable m_364 : 'h ;
    mutable m_361 : 'g ;
    mutable r_358 : 'f ;
    mutable s_357 : 'e ;
    mutable rob_345 : 'd ;
    mutable dy_344 : 'c ; mutable dv_343 : 'b ; mutable chase_369 : 'a }

let follower_car  = 
  
  let follower_car_alloc _ =
    ();
    { i_368 = (false:bool) ;
      m_366 = (Obj.magic ():FadFloat.t) ;
      m_364 = (Obj.magic ():FadFloat.t) ;
      m_361 = (Obj.magic ():FadFloat.t) ;
      r_358 = (false:bool) ;
      s_357 = (Cc_d_Braking_90:state__3065) ;
      rob_345 = (Obj.magic ():FadFloat.t) ;
      dy_344 = (Obj.magic ():FadFloat.t) ;
      dv_343 = (Obj.magic ():FadFloat.t) ; chase_369 = (false:bool) } in
  let follower_car_reset self  =
    ((self.i_368 <- true ;
      self.r_358 <- false ; self.s_357 <- Cc_d_Chasing_88):unit) in 
  let follower_car_step self ((y0_342:FadFloat.t) ,
                              (v0_341:FadFloat.t) ,
                              (t_340:FadFloat.t) , (leader_y_339:FadFloat.t)) =
    ((let switchp_360 = ref (false:bool) in
      let switchv_359 = ref (():unit) in
      (if self.i_368 then self.m_366 <- y0_342) ;
      (if self.i_368 then self.m_364 <- v0_341) ;
      (let (x_363:FadFloat.t) =
           if self.i_368 then t_340 else FadFloat.(-) t_340  self.m_361 in
       self.i_368 <- false ;
       (let (x_367:FadFloat.t) = self.m_366 in
        let (x_365:FadFloat.t) = self.m_364 in
        (begin match self.s_357 with
               | Cc_d_Chasing_88 ->
                   (if self.r_358 then ()) ;
                   self.rob_345 <- FadFloat.(-) (FadFloat.(-) x_367 
                                                              leader_y_339) 
                                                d2 ;
                   self.dy_344 <- FadFloat.(~-) x_365 ;
                   self.dv_343 <- FadFloat.make 1. ;
                   (begin match (<=) (FadFloat.(-) x_367  leader_y_339)  d2 with
                          | true ->
                              switchp_360 := true ;
                              switchv_359 := () ;
                              self.r_358 <- true ;
                              self.s_357 <- Cc_d_Keeping_89
                          | _ -> self.r_358 <- false  end)
               | Cc_d_Keeping_89 ->
                   (if self.r_358 then ()) ;
                   self.chase_369 <- (>) (FadFloat.make (Random.float 1.)) 
                                         (FadFloat.make 0.5) ;
                   self.rob_345 <- (if self.chase_369
                                    then
                                      FadFloat.(-) d1 
                                                   (FadFloat.(-) x_367 
                                                                 leader_y_339)
                                    else
                                      FadFloat.(-) (FadFloat.(-) x_367 
                                                                 leader_y_339)
                                                    d3) ;
                   self.dy_344 <- x_365 ;
                   self.dv_343 <- FadFloat.make 0. ;
                   (begin match (((<=) (FadFloat.(-) x_367  leader_y_339)  d3)
                                 ,
                                 ((>=) (FadFloat.(-) x_367  leader_y_339)  d1)) with
                          | (_ , true) ->
                              switchp_360 := true ;
                              switchv_359 := () ;
                              self.r_358 <- true ;
                              self.s_357 <- Cc_d_Chasing_88
                          | (true , _) ->
                              switchp_360 := true ;
                              switchv_359 := () ;
                              self.r_358 <- true ;
                              self.s_357 <- Cc_d_Braking_90
                          | _ -> self.r_358 <- false  end)
               | Cc_d_Braking_90 ->
                   (if self.r_358 then ()) ;
                   self.rob_345 <- FadFloat.(-) d0 
                                                (FadFloat.(-) x_367 
                                                              leader_y_339) ;
                   self.dy_344 <- FadFloat.(~-) x_365 ;
                   self.dv_343 <- FadFloat.(~-) x_365 ;
                   (begin match (>=) (FadFloat.(-) x_367  leader_y_339)  d0 with
                          | true ->
                              switchp_360 := true ;
                              switchv_359 := () ;
                              self.r_358 <- true ;
                              self.s_357 <- Cc_d_Chasing_88
                          | _ -> self.r_358 <- false  end)
                end) ;
        self.m_366 <- FadFloat.(+) x_367  (FadFloat.( * ) x_363  self.dy_344)
        ;
        self.m_364 <- FadFloat.(+) x_365  (FadFloat.( * ) x_363  self.dv_343)
        ;
        self.m_361 <- t_340 ;
        (x_367 , self.rob_345 , (!switchv_359 , !switchp_360))))):FadFloat.t *
                                                                  FadFloat.t *
                                                                  unit signal) in
  Node { alloc = follower_car_alloc; reset = follower_car_reset ;
                                     step = follower_car_step }
type ('p1 ,
      'o1 ,
      'n1 ,
      'm1 ,
      'l1 ,
      'k1 ,
      'j1 ,
      'i1 ,
      'h1 ,
      'g1 ,
      'f1 ,
      'e1 ,
      'd1 ,
      'c1 ,
      'b1 ,
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
      'n , 'm , 'l , 'k , 'j , 'i , 'h , 'g , 'f , 'e , 'd , 'c , 'b , 'a) _chasing_cars =
  { mutable i_537 : 'p1 ;
    mutable m_535 : 'o1 ;
    mutable m_533 : 'n1 ;
    mutable m_531 : 'm1 ;
    mutable m_528 : 'l1 ;
    mutable m_526 : 'k1 ;
    mutable m_524 : 'j1 ;
    mutable m_521 : 'i1 ;
    mutable m_519 : 'h1 ;
    mutable m_517 : 'g1 ;
    mutable m_514 : 'f1 ;
    mutable m_512 : 'e1 ;
    mutable m_510 : 'd1 ;
    mutable m_507 : 'c1 ;
    mutable m_505 : 'b1 ;
    mutable m_503 : 'a1 ;
    mutable m_500 : 'z ;
    mutable r_481 : 'y ;
    mutable s_480 : 'x ;
    mutable r_479 : 'w ;
    mutable s_478 : 'v ;
    mutable r_477 : 'u ;
    mutable s_476 : 't ;
    mutable r_475 : 's ;
    mutable s_474 : 'r ;
    mutable result_472 : 'q ;
    mutable rob_460 : 'p ;
    mutable dy_459 : 'o ;
    mutable dv_458 : 'n ;
    mutable rob_442 : 'm ;
    mutable dy_441 : 'l ;
    mutable dv_440 : 'k ;
    mutable rob_424 : 'j ;
    mutable dy_423 : 'i ;
    mutable dv_422 : 'h ;
    mutable rob_406 : 'g ;
    mutable dy_405 : 'f ;
    mutable dv_404 : 'e ;
    mutable chase_538 : 'd ;
    mutable chase_539 : 'c ; mutable chase_540 : 'b ; mutable chase_541 : 'a }

let chasing_cars  = 
  
  let chasing_cars_alloc _ =
    ();
    { i_537 = (false:bool) ;
      m_535 = (42:int) ;
      m_533 = (Obj.magic ():FadFloat.t) ;
      m_531 = (Obj.magic ():FadFloat.t) ;
      m_528 = (Obj.magic ():FadFloat.t) ;
      m_526 = (Obj.magic ():FadFloat.t) ;
      m_524 = (Obj.magic ():FadFloat.t) ;
      m_521 = (Obj.magic ():FadFloat.t) ;
      m_519 = (Obj.magic ():FadFloat.t) ;
      m_517 = (Obj.magic ():FadFloat.t) ;
      m_514 = (Obj.magic ():FadFloat.t) ;
      m_512 = (Obj.magic ():FadFloat.t) ;
      m_510 = (Obj.magic ():FadFloat.t) ;
      m_507 = (Obj.magic ():FadFloat.t) ;
      m_505 = (Obj.magic ():FadFloat.t) ;
      m_503 = (Obj.magic ():FadFloat.t) ;
      m_500 = (Obj.magic ():FadFloat.t) ;
      r_481 = (false:bool) ;
      s_480 = (Cc_d_Braking_217:state__3069) ;
      r_479 = (false:bool) ;
      s_478 = (Cc_d_Braking_194:state__3068) ;
      r_477 = (false:bool) ;
      s_476 = (Cc_d_Braking_171:state__3067) ;
      r_475 = (false:bool) ;
      s_474 = (Cc_d_Braking_148:state__3066) ;
      result_472 = (42:int) ;
      rob_460 = (Obj.magic ():FadFloat.t) ;
      dy_459 = (Obj.magic ():FadFloat.t) ;
      dv_458 = (Obj.magic ():FadFloat.t) ;
      rob_442 = (Obj.magic ():FadFloat.t) ;
      dy_441 = (Obj.magic ():FadFloat.t) ;
      dv_440 = (Obj.magic ():FadFloat.t) ;
      rob_424 = (Obj.magic ():FadFloat.t) ;
      dy_423 = (Obj.magic ():FadFloat.t) ;
      dv_422 = (Obj.magic ():FadFloat.t) ;
      rob_406 = (Obj.magic ():FadFloat.t) ;
      dy_405 = (Obj.magic ():FadFloat.t) ;
      dv_404 = (Obj.magic ():FadFloat.t) ;
      chase_538 = (false:bool) ;
      chase_539 = (false:bool) ;
      chase_540 = (false:bool) ; chase_541 = (false:bool) } in
  let chasing_cars_reset self  =
    ((self.i_537 <- true ;
      self.r_481 <- false ;
      self.s_480 <- Cc_d_Chasing_215 ;
      self.r_479 <- false ;
      self.s_478 <- Cc_d_Chasing_192 ;
      self.r_477 <- false ;
      self.s_476 <- Cc_d_Chasing_169 ;
      self.r_475 <- false ; self.s_474 <- Cc_d_Chasing_146):unit) in 
  let chasing_cars_step self ((t_371:FadFloat.t) ,
                              (throttle_372:FadFloat.t) ,
                              (brake_370:FadFloat.t)) =
    ((let switchp_499 = ref (false:bool) in
      let switchv_498 = ref (():unit) in
      let switchp_497 = ref (false:bool) in
      let switchv_496 = ref (():unit) in
      let switchp_495 = ref (false:bool) in
      let switchv_494 = ref (():unit) in
      let switchp_493 = ref (false:bool) in
      let switchv_492 = ref (():unit) in
      (if self.i_537 then self.m_535 <- Stdlib.(+) (Random.int 4)  2) ;
      (let (x_536:int) = self.m_535 in
       (if self.i_537 then self.result_472 <- x_536) ;
       (let (y0_457:FadFloat.t) = FadFloat.make 40. in
        (if self.i_537 then self.m_533 <- y0_457) ;
        (let (v0_456:FadFloat.t) = FadFloat.make 0. in
         (if self.i_537 then self.m_531 <- v0_456) ;
         (let (x_530:FadFloat.t) =
              if self.i_537 then t_371 else FadFloat.(-) t_371  self.m_528 in
          let (y0_439:FadFloat.t) = FadFloat.make 30. in
          (if self.i_537 then self.m_526 <- y0_439) ;
          (let (v0_438:FadFloat.t) = FadFloat.make 0. in
           (if self.i_537 then self.m_524 <- v0_438) ;
           (let (x_523:FadFloat.t) =
                if self.i_537 then t_371 else FadFloat.(-) t_371  self.m_521 in
            let (y0_421:FadFloat.t) = FadFloat.make 20. in
            (if self.i_537 then self.m_519 <- y0_421) ;
            (let (v0_420:FadFloat.t) = FadFloat.make 0. in
             (if self.i_537 then self.m_517 <- v0_420) ;
             (let (x_516:FadFloat.t) =
                  if self.i_537
                  then t_371
                  else FadFloat.(-) t_371  self.m_514 in
              let (y0_403:FadFloat.t) = FadFloat.make 10. in
              (if self.i_537 then self.m_512 <- y0_403) ;
              (let (v0_402:FadFloat.t) = FadFloat.make 0. in
               (if self.i_537 then self.m_510 <- v0_402) ;
               (let (x_509:FadFloat.t) =
                    if self.i_537
                    then t_371
                    else FadFloat.(-) t_371  self.m_507 in
                let (v0_387:FadFloat.t) = FadFloat.make 0. in
                (if self.i_537 then self.m_505 <- v0_387) ;
                (let (y0_388:FadFloat.t) = FadFloat.make 0. in
                 (if self.i_537 then self.m_503 <- y0_388) ;
                 (let (x_502:FadFloat.t) =
                      if self.i_537
                      then t_371
                      else FadFloat.(-) t_371  self.m_500 in
                  self.i_537 <- false ;
                  (let (x_527:FadFloat.t) = self.m_526 in
                   let (x_534:FadFloat.t) = self.m_533 in
                   let (x_532:FadFloat.t) = self.m_531 in
                   (begin match self.s_480 with
                          | Cc_d_Chasing_215 ->
                              (if self.r_481 then ()) ;
                              self.rob_460 <- FadFloat.(-) (FadFloat.(-) 
                                                              x_534  x_527) 
                                                           d2 ;
                              self.dy_459 <- FadFloat.(~-) x_532 ;
                              self.dv_458 <- FadFloat.make 1. ;
                              (begin match (<=) (FadFloat.(-) x_534  x_527) 
                                                d2 with
                                     | true ->
                                         switchp_493 := true ;
                                         switchv_492 := () ;
                                         self.r_481 <- true ;
                                         self.s_480 <- Cc_d_Keeping_216
                                     | _ -> self.r_481 <- false  end)
                          | Cc_d_Keeping_216 ->
                              (if self.r_481 then ()) ;
                              self.chase_538 <- (>) (FadFloat.make (Random.float 
                                                                    1.)) 
                                                    (FadFloat.make 0.5) ;
                              self.rob_460 <- (if self.chase_538
                                               then
                                                 FadFloat.(-) d1 
                                                              (FadFloat.(-) 
                                                                 x_534  x_527)
                                               else
                                                 FadFloat.(-) (FadFloat.(-) 
                                                                 x_534  x_527)
                                                               d3) ;
                              self.dy_459 <- x_532 ;
                              self.dv_458 <- FadFloat.make 0. ;
                              (begin match (((<=) (FadFloat.(-) x_534  x_527)
                                                   d3) ,
                                            ((>=) (FadFloat.(-) x_534  x_527)
                                                   d1)) with
                                     | (_ , true) ->
                                         switchp_493 := true ;
                                         switchv_492 := () ;
                                         self.r_481 <- true ;
                                         self.s_480 <- Cc_d_Chasing_215
                                     | (true , _) ->
                                         switchp_493 := true ;
                                         switchv_492 := () ;
                                         self.r_481 <- true ;
                                         self.s_480 <- Cc_d_Braking_217
                                     | _ -> self.r_481 <- false  end)
                          | Cc_d_Braking_217 ->
                              (if self.r_481 then ()) ;
                              self.rob_460 <- FadFloat.(-) d0 
                                                           (FadFloat.(-) 
                                                              x_534  x_527) ;
                              self.dy_459 <- FadFloat.(~-) x_532 ;
                              self.dv_458 <- FadFloat.(~-) x_532 ;
                              (begin match (>=) (FadFloat.(-) x_534  x_527) 
                                                d0 with
                                     | true ->
                                         switchp_493 := true ;
                                         switchv_492 := () ;
                                         self.r_481 <- true ;
                                         self.s_480 <- Cc_d_Chasing_215
                                     | _ -> self.r_481 <- false  end)
                           end) ;
                   (let (x_520:FadFloat.t) = self.m_519 in
                    let (x_525:FadFloat.t) = self.m_524 in
                    (begin match self.s_478 with
                           | Cc_d_Chasing_192 ->
                               (if self.r_479 then ()) ;
                               self.rob_442 <- FadFloat.(-) (FadFloat.(-) 
                                                               x_527  x_520) 
                                                            d2 ;
                               self.dy_441 <- FadFloat.(~-) x_525 ;
                               self.dv_440 <- FadFloat.make 1. ;
                               (begin match (<=) (FadFloat.(-) x_527  x_520) 
                                                 d2 with
                                      | true ->
                                          switchp_495 := true ;
                                          switchv_494 := () ;
                                          self.r_479 <- true ;
                                          self.s_478 <- Cc_d_Keeping_193
                                      | _ -> self.r_479 <- false  end)
                           | Cc_d_Keeping_193 ->
                               (if self.r_479 then ()) ;
                               self.chase_539 <- (>) (FadFloat.make (
                                                                    Random.float 
                                                                    1.)) 
                                                     (FadFloat.make 0.5) ;
                               self.rob_442 <- (if self.chase_539
                                                then
                                                  FadFloat.(-) d1 
                                                               (FadFloat.(-) 
                                                                  x_527 
                                                                  x_520)
                                                else
                                                  FadFloat.(-) (FadFloat.(-) 
                                                                  x_527 
                                                                  x_520)  
                                                               d3) ;
                               self.dy_441 <- x_525 ;
                               self.dv_440 <- FadFloat.make 0. ;
                               (begin match (((<=) (FadFloat.(-) x_527  x_520)
                                                    d3) ,
                                             ((>=) (FadFloat.(-) x_527  x_520)
                                                    d1)) with
                                      | (_ , true) ->
                                          switchp_495 := true ;
                                          switchv_494 := () ;
                                          self.r_479 <- true ;
                                          self.s_478 <- Cc_d_Chasing_192
                                      | (true , _) ->
                                          switchp_495 := true ;
                                          switchv_494 := () ;
                                          self.r_479 <- true ;
                                          self.s_478 <- Cc_d_Braking_194
                                      | _ -> self.r_479 <- false  end)
                           | Cc_d_Braking_194 ->
                               (if self.r_479 then ()) ;
                               self.rob_442 <- FadFloat.(-) d0 
                                                            (FadFloat.(-) 
                                                               x_527  x_520)
                               ;
                               self.dy_441 <- FadFloat.(~-) x_525 ;
                               self.dv_440 <- FadFloat.(~-) x_525 ;
                               (begin match (>=) (FadFloat.(-) x_527  x_520) 
                                                 d0 with
                                      | true ->
                                          switchp_495 := true ;
                                          switchv_494 := () ;
                                          self.r_479 <- true ;
                                          self.s_478 <- Cc_d_Chasing_192
                                      | _ -> self.r_479 <- false  end)
                            end) ;
                    (let (x_513:FadFloat.t) = self.m_512 in
                     let (x_518:FadFloat.t) = self.m_517 in
                     (begin match self.s_476 with
                            | Cc_d_Chasing_169 ->
                                (if self.r_477 then ()) ;
                                self.rob_424 <- FadFloat.(-) (FadFloat.(-) 
                                                                x_520  x_513)
                                                              d2 ;
                                self.dy_423 <- FadFloat.(~-) x_518 ;
                                self.dv_422 <- FadFloat.make 1. ;
                                (begin match (<=) (FadFloat.(-) x_520  x_513)
                                                   d2 with
                                       | true ->
                                           switchp_497 := true ;
                                           switchv_496 := () ;
                                           self.r_477 <- true ;
                                           self.s_476 <- Cc_d_Keeping_170
                                       | _ -> self.r_477 <- false  end)
                            | Cc_d_Keeping_170 ->
                                (if self.r_477 then ()) ;
                                self.chase_540 <- (>) (FadFloat.make 
                                                         (Random.float 1.)) 
                                                      (FadFloat.make 0.5) ;
                                self.rob_424 <- (if self.chase_540
                                                 then
                                                   FadFloat.(-) d1 
                                                                (FadFloat.(-) 
                                                                   x_520 
                                                                   x_513)
                                                 else
                                                   FadFloat.(-) (FadFloat.(-) 
                                                                   x_520 
                                                                   x_513)  
                                                                d3) ;
                                self.dy_423 <- x_518 ;
                                self.dv_422 <- FadFloat.make 0. ;
                                (begin match (((<=) (FadFloat.(-) x_520 
                                                                  x_513)  
                                                    d3) ,
                                              ((>=) (FadFloat.(-) x_520 
                                                                  x_513)  
                                                    d1)) with
                                       | (_ , true) ->
                                           switchp_497 := true ;
                                           switchv_496 := () ;
                                           self.r_477 <- true ;
                                           self.s_476 <- Cc_d_Chasing_169
                                       | (true , _) ->
                                           switchp_497 := true ;
                                           switchv_496 := () ;
                                           self.r_477 <- true ;
                                           self.s_476 <- Cc_d_Braking_171
                                       | _ -> self.r_477 <- false  end)
                            | Cc_d_Braking_171 ->
                                (if self.r_477 then ()) ;
                                self.rob_424 <- FadFloat.(-) d0 
                                                             (FadFloat.(-) 
                                                                x_520  x_513)
                                ;
                                self.dy_423 <- FadFloat.(~-) x_518 ;
                                self.dv_422 <- FadFloat.(~-) x_518 ;
                                (begin match (>=) (FadFloat.(-) x_520  x_513)
                                                   d0 with
                                       | true ->
                                           switchp_497 := true ;
                                           switchv_496 := () ;
                                           self.r_477 <- true ;
                                           self.s_476 <- Cc_d_Chasing_169
                                       | _ -> self.r_477 <- false  end)
                             end) ;
                     (let (x_504:FadFloat.t) = self.m_503 in
                      let (x_511:FadFloat.t) = self.m_510 in
                      (begin match self.s_474 with
                             | Cc_d_Chasing_146 ->
                                 (if self.r_475 then ()) ;
                                 self.rob_406 <- FadFloat.(-) (FadFloat.(-) 
                                                                 x_513  x_504)
                                                               d2 ;
                                 self.dy_405 <- FadFloat.(~-) x_511 ;
                                 self.dv_404 <- FadFloat.make 1. ;
                                 (begin match (<=) (FadFloat.(-) x_513  x_504)
                                                    d2 with
                                        | true ->
                                            switchp_499 := true ;
                                            switchv_498 := () ;
                                            self.r_475 <- true ;
                                            self.s_474 <- Cc_d_Keeping_147
                                        | _ -> self.r_475 <- false  end)
                             | Cc_d_Keeping_147 ->
                                 (if self.r_475 then ()) ;
                                 self.chase_541 <- (>) (FadFloat.make 
                                                          (Random.float 1.)) 
                                                       (FadFloat.make 0.5) ;
                                 self.rob_406 <- (if self.chase_541
                                                  then
                                                    FadFloat.(-) d1 
                                                                 (FadFloat.(-) 
                                                                    x_513 
                                                                    x_504)
                                                  else
                                                    FadFloat.(-) (FadFloat.(-) 
                                                                    x_513 
                                                                    x_504) 
                                                                 d3) ;
                                 self.dy_405 <- x_511 ;
                                 self.dv_404 <- FadFloat.make 0. ;
                                 (begin match (((<=) (FadFloat.(-) x_513 
                                                                   x_504)  
                                                     d3) ,
                                               ((>=) (FadFloat.(-) x_513 
                                                                   x_504)  
                                                     d1)) with
                                        | (_ , true) ->
                                            switchp_499 := true ;
                                            switchv_498 := () ;
                                            self.r_475 <- true ;
                                            self.s_474 <- Cc_d_Chasing_146
                                        | (true , _) ->
                                            switchp_499 := true ;
                                            switchv_498 := () ;
                                            self.r_475 <- true ;
                                            self.s_474 <- Cc_d_Braking_148
                                        | _ -> self.r_475 <- false  end)
                             | Cc_d_Braking_148 ->
                                 (if self.r_475 then ()) ;
                                 self.rob_406 <- FadFloat.(-) d0 
                                                              (FadFloat.(-) 
                                                                 x_513  x_504)
                                 ;
                                 self.dy_405 <- FadFloat.(~-) x_511 ;
                                 self.dv_404 <- FadFloat.(~-) x_511 ;
                                 (begin match (>=) (FadFloat.(-) x_513  x_504)
                                                    d0 with
                                        | true ->
                                            switchp_499 := true ;
                                            switchv_498 := () ;
                                            self.r_475 <- true ;
                                            self.s_474 <- Cc_d_Chasing_146
                                        | _ -> self.r_475 <- false  end)
                              end) ;
                      (let ((rob_trans_383:FadFloat.t) ,
                            ((switch_transv_490:unit) , (copy_542:bool))) =
                           if (=) (FadFloat.integer x_536) 
                                  (FadFloat.integer 2)
                           then
                             (self.rob_406 , (!switchv_498 , !switchp_499))
                           else
                             if (=) (FadFloat.integer x_536) 
                                    (FadFloat.integer 3)
                             then
                               (self.rob_424 , (!switchv_496 , !switchp_497))
                             else
                               if (=) (FadFloat.integer x_536) 
                                      (FadFloat.integer 4)
                               then
                                 (self.rob_442 ,
                                  (!switchv_494 , !switchp_495))
                               else
                                 (self.rob_460 ,
                                  (!switchv_492 , !switchp_493)) in
                       (begin match (switch_transv_490 , copy_542) with
                              | (() , true) ->
                                  self.result_472 <- Stdlib.(+) (Random.int 4)
                                                                 2 | _ -> ()  end)
                       ;
                       self.m_535 <- self.result_472 ;
                       self.m_533 <- FadFloat.(+) x_534 
                                                  (FadFloat.( * ) x_530 
                                                                  self.dy_459)
                       ;
                       self.m_531 <- FadFloat.(+) x_532 
                                                  (FadFloat.( * ) x_530 
                                                                  self.dv_458)
                       ;
                       self.m_528 <- t_371 ;
                       self.m_526 <- FadFloat.(+) x_527 
                                                  (FadFloat.( * ) x_523 
                                                                  self.dy_441)
                       ;
                       self.m_524 <- FadFloat.(+) x_525 
                                                  (FadFloat.( * ) x_523 
                                                                  self.dv_440)
                       ;
                       self.m_521 <- t_371 ;
                       self.m_519 <- FadFloat.(+) x_520 
                                                  (FadFloat.( * ) x_516 
                                                                  self.dy_423)
                       ;
                       self.m_517 <- FadFloat.(+) x_518 
                                                  (FadFloat.( * ) x_516 
                                                                  self.dv_422)
                       ;
                       self.m_514 <- t_371 ;
                       self.m_512 <- FadFloat.(+) x_513 
                                                  (FadFloat.( * ) x_509 
                                                                  self.dy_405)
                       ;
                       self.m_510 <- FadFloat.(+) x_511 
                                                  (FadFloat.( * ) x_509 
                                                                  self.dv_404)
                       ;
                       self.m_507 <- t_371 ;
                       (let (x_506:FadFloat.t) = self.m_505 in
                        let (x_397:FadFloat.t) =
                            FadFloat.(-) (FadFloat.(~-) throttle_372) 
                                         (FadFloat.( * ) brake_370  x_506) in
                        self.m_505 <- FadFloat.(+) x_506 
                                                   (FadFloat.( * ) x_502 
                                                                   x_397) ;
                        self.m_503 <- FadFloat.(+) x_504 
                                                   (FadFloat.( * ) x_502 
                                                                   x_506) ;
                        self.m_500 <- t_371 ;
                        ((x_504 , x_513 , x_520 , x_527 , x_534) ,
                         rob_trans_383)))))))))))))))))))):(FadFloat.t *
                                                            FadFloat.t *
                                                            FadFloat.t *
                                                            FadFloat.t *
                                                            FadFloat.t) *
                                                           FadFloat.t) in
  Node { alloc = chasing_cars_alloc; reset = chasing_cars_reset ;
                                     step = chasing_cars_step }
