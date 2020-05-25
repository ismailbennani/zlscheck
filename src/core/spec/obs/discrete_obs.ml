(* The Zélus compiler, version 2.0
  (lundi 25 mai 2020, 14:33:03 (UTC+0200)) *)
open Ztypes
type state__4555 =
Discrete_obs_YFALSE_323 | Discrete_obs_YTRUE_322 | Discrete_obs_INIT_321 
type state__4554 = Discrete_obs_YTRUE_315 | Discrete_obs_INIT_314 
let q_true = infinity

let q_false = neg_infinity

type _no_signal = unit

let no_signal  = 
   let no_signal_alloc _ = () in
  let no_signal_reset self  =
    ((()):unit) in 
  let no_signal_step self () =
    ((let resultp_424 = ref (false:bool) in
      let resultv_423 = ref (():unit) in
      (begin match false with
             | true -> resultp_424 := true ; resultv_423 := () | _ -> ()  end)
      ; (!resultv_423 , !resultp_424)):unit signal) in
  Node { alloc = no_signal_alloc; reset = no_signal_reset ;
                                  step = no_signal_step }
type ('a) _now =
  { mutable m_427 : 'a }

let now  = 
   let now_alloc _ =
     ();{ m_427 = (false:bool) } in
  let now_reset self  =
    (self.m_427 <- true:unit) in 
  let now_step self () =
    ((let resultp_426 = ref (false:bool) in
      let resultv_425 = ref (():unit) in
      let (x_428:bool) = self.m_427 in
      self.m_427 <- false ;
      (begin match x_428 with
             | true -> resultp_426 := true ; resultv_425 := () | _ -> ()  end)
      ; (!resultv_425 , !resultp_426)):unit signal) in
  Node { alloc = now_alloc; reset = now_reset ; step = now_step }
let isTrue (p_429:float) =
  (>=) p_429  0.

let isFalse (p_430:float) =
  (<) p_430  0.

let q_istrue (p_431:float) =
  let resultp_433 = ref (false:bool) in
  let resultv_432 = ref (():unit) in
  (begin match isTrue p_431 with
         | true -> resultp_433 := true ; resultv_432 := () | _ -> ()  end) ;
  (!resultv_432 , !resultp_433)

let q_isfalse (p_434:float) =
  let resultp_436 = ref (false:bool) in
  let resultv_435 = ref (():unit) in
  (begin match isFalse p_434 with
         | true -> resultp_436 := true ; resultv_435 := () | _ -> ()  end) ;
  (!resultv_435 , !resultp_436)

let q_aretrue2 ((p_437:float) , (s_438:float)) =
  let resultp_440 = ref (false:bool) in
  let resultv_439 = ref (():unit) in
  (begin match ((isTrue s_438) ,
                (isTrue p_437) , (isTrue p_437) , (isTrue s_438)) with
         | (_ , _ , true , true) | (true , true , _ , _) ->
             resultp_440 := true ; resultv_439 := () | _ -> ()  end) ;
  (!resultv_439 , !resultp_440)

type ('b , 'a) _freeze =
  { mutable i_443 : 'b ; mutable res_442 : 'a }

let freeze  = 
  
  let freeze_alloc _ =
    ();{ i_443 = (false:bool) ; res_442 = (Obj.magic ():'a) } in
  let freeze_reset self  =
    (self.i_443 <- true:unit) in 
  let freeze_step self (p_441:'a4108) =
    (((if self.i_443 then self.res_442 <- p_441) ;
      self.i_443 <- false ; self.res_442):'a) in
  Node { alloc = freeze_alloc; reset = freeze_reset ; step = freeze_step }
type ('a) _q_istrue_now =
  { mutable i_564 : 'a }

let q_istrue_now  = 
  let Node { alloc = i_564_alloc; step = i_564_step ; reset = i_564_reset } = freeze 
   in
  let q_istrue_now_alloc _ =
    ();{ i_564 = i_564_alloc () (* discrete *)  } in
  let q_istrue_now_reset self  =
    (i_564_reset self.i_564 :unit) in 
  let q_istrue_now_step self (p_444:float) =
    ((let resultp_447 = ref (false:bool) in
      let resultv_446 = ref (():unit) in
      (begin match isTrue p_444 with
             | true -> resultp_447 := true ; resultv_446 := () | _ -> ()  end)
      ; i_564_step self.i_564 (!resultv_446 , !resultp_447)):unit signal) in
  Node { alloc = q_istrue_now_alloc; reset = q_istrue_now_reset ;
                                     step = q_istrue_now_step }
type ('a) _q_isfalse_now =
  { mutable i_565 : 'a }

let q_isfalse_now  = 
  let Node { alloc = i_565_alloc; step = i_565_step ; reset = i_565_reset } = freeze 
   in
  let q_isfalse_now_alloc _ =
    ();{ i_565 = i_565_alloc () (* discrete *)  } in
  let q_isfalse_now_reset self  =
    (i_565_reset self.i_565 :unit) in 
  let q_isfalse_now_step self (p_448:float) =
    ((let resultp_451 = ref (false:bool) in
      let resultv_450 = ref (():unit) in
      (begin match isFalse p_448 with
             | true -> resultp_451 := true ; resultv_450 := () | _ -> ()  end)
      ; i_565_step self.i_565 (!resultv_450 , !resultp_451)):unit signal) in
  Node { alloc = q_isfalse_now_alloc; reset = q_isfalse_now_reset ;
                                      step = q_isfalse_now_step }
let q_gt ((p1_452:float) , (p2_453:float)) =
  (-.) p1_452  p2_453

let q_ge ((p1_454:float) , (p2_455:float)) =
  (-.) p1_454  p2_455

let q_lt ((p1_456:float) , (p2_457:float)) =
  (-.) p2_457  p1_456

let q_le ((p1_458:float) , (p2_459:float)) =
  (-.) p2_459  p1_458

let q_not (p_460:float) =
  (~-.) p_460

let q_or ((p1_461:'a4185) , (p2_462:'a4185)) =
  max p1_461  p2_462

let q_and ((p1_463:'a4195) , (p2_464:'a4195)) =
  min p1_463  p2_464

let q_eqi ((i1_465:float) , (i2_466:float)) =
  (-.) 0.5  (abs_float ((-.) i1_465  i2_466))

let implies ((a_469:float) , (b_470:float)) =
  q_or ((q_not a_469) , b_470)

type ('b , 'a) _q_up =
  { mutable i_475 : 'b ; mutable m_472 : 'a }

let q_up  = 
   let q_up_alloc _ =
     ();{ i_475 = (false:bool) ; m_472 = (42.:float) } in
  let q_up_reset self  =
    (self.i_475 <- true:unit) in 
  let q_up_step self (p_471:float) =
    ((let (x_474:float) =
          if self.i_475
          then p_471
          else q_and ((q_lt (self.m_472 , 0.)) , (q_gt (p_471 , 0.))) in
      self.i_475 <- false ; self.m_472 <- p_471 ; x_474):float) in
  Node { alloc = q_up_alloc; reset = q_up_reset ; step = q_up_step }
type ('b , 'a) _b_up =
  { mutable i_480 : 'b ; mutable m_477 : 'a }

let b_up  = 
   let b_up_alloc _ =
     ();{ i_480 = (false:bool) ; m_477 = (false:bool) } in
  let b_up_reset self  =
    (self.i_480 <- true:unit) in 
  let b_up_step self (p_476:bool) =
    ((let (x_479:bool) =
          if self.i_480 then p_476 else (&&) (not self.m_477)  p_476 in
      self.i_480 <- false ; self.m_477 <- p_476 ; x_479):bool) in
  Node { alloc = b_up_alloc; reset = b_up_reset ; step = b_up_step }
let min_cpt = (-1.)

type ('b , 'a) _always =
  { mutable i_486 : 'b ; mutable m_483 : 'a }

let always  = 
  
  let always_alloc _ =
    ();{ i_486 = (false:bool) ; m_483 = (Obj.magic ():'b) } in
  let always_reset self  =
    (self.i_486 <- true:unit) in 
  let always_step self (p_481:'a4265) =
    ((let (x_485:'a4265) =
          if self.i_486 then p_481 else q_and (self.m_483 , p_481) in
      self.i_486 <- false ; self.m_483 <- x_485 ; x_485):'b) in
  Node { alloc = always_alloc; reset = always_reset ; step = always_step }
type ('a) _never =
  { mutable i_566 : 'a }

let never  = 
  let Node { alloc = i_566_alloc; step = i_566_step ; reset = i_566_reset } = always 
   in let never_alloc _ =
        ();{ i_566 = i_566_alloc () (* discrete *)  } in
  let never_reset self  =
    (i_566_reset self.i_566 :unit) in 
  let never_step self (p_487:float) =
    (i_566_step self.i_566 (q_not p_487):float) in
  Node { alloc = never_alloc; reset = never_reset ; step = never_step }
type ('b , 'a) _once =
  { mutable i_493 : 'b ; mutable m_490 : 'a }

let once  = 
  
  let once_alloc _ =
    ();{ i_493 = (false:bool) ; m_490 = (Obj.magic ():'c) } in
  let once_reset self  =
    (self.i_493 <- true:unit) in 
  let once_step self (p_488:'a4280) =
    ((let (x_492:'a4280) =
          if self.i_493 then p_488 else q_or (self.m_490 , p_488) in
      self.i_493 <- false ; self.m_490 <- x_492 ; x_492):'c) in
  Node { alloc = once_alloc; reset = once_reset ; step = once_step }
type ('f , 'e , 'd , 'c , 'b , 'a) _sincefirst =
  { mutable i_567 : 'f ;
    mutable i_569 : 'e ;
    mutable i_568 : 'd ;
    mutable r_498 : 'c ; mutable s_497 : 'b ; mutable result_496 : 'a }

let sincefirst  = 
  let Node { alloc = i_567_alloc; step = i_567_step ; reset = i_567_reset } = never 
   in 
  let Node { alloc = i_569_alloc; step = i_569_step ; reset = i_569_reset } = once 
   in 
  let Node { alloc = i_568_alloc; step = i_568_step ; reset = i_568_reset } = never 
   in
  let sincefirst_alloc _ =
    ();
    { r_498 = (false:bool) ;
      s_497 = (Discrete_obs_YTRUE_315:state__4554) ; result_496 = (42.:float);
      i_567 = i_567_alloc () (* discrete *)  ;
      i_569 = i_569_alloc () (* discrete *)  ;
      i_568 = i_568_alloc () (* discrete *)  } in
  let sincefirst_reset self  =
    ((self.r_498 <- false ;
      self.s_497 <- Discrete_obs_INIT_314 ;
      i_567_reset self.i_567  ;
      i_569_reset self.i_569  ; i_568_reset self.i_568 ):unit) in 
  let sincefirst_step self ((x_494:float) , (y_495:float)) =
    (((begin match self.s_497 with
             | Discrete_obs_INIT_314 ->
                 let resultp_501 = ref (false:bool) in
                 let resultv_500 = ref (():unit) in
                 (if self.r_498 then i_567_reset self.i_567 ) ;
                 self.result_496 <- q_or ((i_567_step self.i_567 y_495) ,
                                          x_494) ;
                 (begin match isTrue y_495 with
                        | true -> resultp_501 := true ; resultv_500 := ()
                        | _ -> ()  end) ;
                 (begin match (!resultv_500 , !resultp_501) with
                        | (() , true) ->
                            self.r_498 <- true ;
                            self.s_497 <- Discrete_obs_YTRUE_315
                        | _ -> self.r_498 <- false  end)
             | Discrete_obs_YTRUE_315 ->
                 (if self.r_498 then
                  (i_569_reset self.i_569  ; i_568_reset self.i_568 )) ;
                 self.result_496 <- q_or ((i_568_step self.i_568 y_495) ,
                                          (i_569_step self.i_569 x_494)) ;
                 self.r_498 <- false
              end) ; self.result_496):float) in
  Node { alloc = sincefirst_alloc; reset = sincefirst_reset ;
                                   step = sincefirst_step }
type ('f , 'e , 'd , 'c , 'b , 'a) _sincelast =
  { mutable i_570 : 'f ;
    mutable i_571 : 'e ;
    mutable r_507 : 'd ;
    mutable s_506 : 'c ; mutable last_res_505 : 'b ; mutable result_504 : 'a }

let sincelast  = 
  let Node { alloc = i_570_alloc; step = i_570_step ; reset = i_570_reset } = never 
   in 
  let Node { alloc = i_571_alloc; step = i_571_step ; reset = i_571_reset } = once 
   in
  let sincelast_alloc _ =
    ();
    { r_507 = (false:bool) ;
      s_506 = (Discrete_obs_YFALSE_323:state__4555) ;
      last_res_505 = (42.:float) ; result_504 = (42.:float);
      i_570 = i_570_alloc () (* discrete *)  ;
      i_571 = i_571_alloc () (* discrete *)  } in
  let sincelast_reset self  =
    ((self.r_507 <- false ;
      self.s_506 <- Discrete_obs_INIT_321 ;
      i_570_reset self.i_570  ; i_571_reset self.i_571 ):unit) in 
  let sincelast_step self ((x_502:float) , (y_503:float)) =
    (((begin match self.s_506 with
             | Discrete_obs_INIT_321 ->
                 let resultp_510 = ref (false:bool) in
                 let resultv_509 = ref (():unit) in
                 (if self.r_507 then i_570_reset self.i_570 ) ;
                 self.result_504 <- q_or ((i_570_step self.i_570 y_503) ,
                                          x_502) ;
                 (begin match isTrue y_503 with
                        | true -> resultp_510 := true ; resultv_509 := ()
                        | _ -> ()  end) ;
                 (begin match (!resultv_509 , !resultp_510) with
                        | (() , true) ->
                            self.r_507 <- true ;
                            self.s_506 <- Discrete_obs_YTRUE_322
                        | _ -> self.r_507 <- false  end)
             | Discrete_obs_YTRUE_322 ->
                 let resultp_513 = ref (false:bool) in
                 let resultv_512 = ref (():unit) in
                 (if self.r_507 then ()) ;
                 self.result_504 <- x_502 ;
                 (begin match isFalse y_503 with
                        | true -> resultp_513 := true ; resultv_512 := ()
                        | _ -> ()  end) ;
                 (begin match (!resultv_512 , !resultp_513) with
                        | (() , true) ->
                            self.last_res_505 <- x_502 ;
                            self.r_507 <- true ;
                            self.s_506 <- Discrete_obs_YFALSE_323
                        | _ -> self.r_507 <- false  end)
             | Discrete_obs_YFALSE_323 ->
                 let resultp_516 = ref (false:bool) in
                 let resultv_515 = ref (():unit) in
                 (if self.r_507 then i_571_reset self.i_571 ) ;
                 self.result_504 <- q_or (self.last_res_505 ,
                                          (i_571_step self.i_571 x_502)) ;
                 (begin match isTrue y_503 with
                        | true -> resultp_516 := true ; resultv_515 := ()
                        | _ -> ()  end) ;
                 (begin match (!resultv_515 , !resultp_516) with
                        | (() , true) ->
                            self.r_507 <- true ;
                            self.s_506 <- Discrete_obs_YTRUE_322
                        | _ -> self.r_507 <- false  end)
              end) ; self.result_504):float) in
  Node { alloc = sincelast_alloc; reset = sincelast_reset ;
                                  step = sincelast_step }
type ('a) _since =
  { mutable i_572 : 'a }

let since  = 
  let Node { alloc = i_572_alloc; step = i_572_step ; reset = i_572_reset } = sincelast 
   in let since_alloc _ =
        ();{ i_572 = i_572_alloc () (* discrete *)  } in
  let since_reset self  =
    (i_572_reset self.i_572 :unit) in 
  let since_step self ((x_517:float) , (y_518:float)) =
    (i_572_step self.i_572 (x_517 , y_518):float) in
  Node { alloc = since_alloc; reset = since_reset ; step = since_step }
type ('b , 'a) _onceBfromlastAtoC =
  { mutable i_574 : 'b ; mutable i_573 : 'a }

let onceBfromlastAtoC  = 
  let Node { alloc = i_574_alloc; step = i_574_step ; reset = i_574_reset } = sincelast 
   in 
  let Node { alloc = i_573_alloc; step = i_573_step ; reset = i_573_reset } = never 
   in
  let onceBfromlastAtoC_alloc _ =
    ();
    { i_574 = i_574_alloc () (* discrete *)  ;
      i_573 = i_573_alloc () (* discrete *)  } in
  let onceBfromlastAtoC_reset self  =
    ((i_574_reset self.i_574  ; i_573_reset self.i_573 ):unit) in 
  let onceBfromlastAtoC_step self ((a_519:float) ,
                                   (b_520:float) , (c_521:float)) =
    (implies (c_521 ,
              (q_or ((i_573_step self.i_573 a_519) ,
                     (i_574_step self.i_574 (b_520 , a_519))))):float) in
  Node { alloc = onceBfromlastAtoC_alloc; reset = onceBfromlastAtoC_reset ;
                                          step = onceBfromlastAtoC_step }
type ('b , 'a) _onceBfromfirstAtoC =
  { mutable i_576 : 'b ; mutable i_575 : 'a }

let onceBfromfirstAtoC  = 
  let Node { alloc = i_576_alloc; step = i_576_step ; reset = i_576_reset } = sincefirst 
   in 
  let Node { alloc = i_575_alloc; step = i_575_step ; reset = i_575_reset } = never 
   in
  let onceBfromfirstAtoC_alloc _ =
    ();
    { i_576 = i_576_alloc () (* discrete *)  ;
      i_575 = i_575_alloc () (* discrete *)  } in
  let onceBfromfirstAtoC_reset self  =
    ((i_576_reset self.i_576  ; i_575_reset self.i_575 ):unit) in 
  let onceBfromfirstAtoC_step self ((a_522:float) ,
                                    (b_523:float) , (c_524:float)) =
    (implies (c_524 ,
              (q_or ((i_575_step self.i_575 a_522) ,
                     (i_576_step self.i_576 (b_523 , a_522))))):float) in
  Node { alloc = onceBfromfirstAtoC_alloc; reset = onceBfromfirstAtoC_reset ;
                                           step = onceBfromfirstAtoC_step }
type ('a) _onceBfromAtoC =
  { mutable i_577 : 'a }

let onceBfromAtoC  = 
  let Node { alloc = i_577_alloc; step = i_577_step ; reset = i_577_reset } = onceBfromlastAtoC 
   in
  let onceBfromAtoC_alloc _ =
    ();{ i_577 = i_577_alloc () (* discrete *)  } in
  let onceBfromAtoC_reset self  =
    (i_577_reset self.i_577 :unit) in 
  let onceBfromAtoC_step self ((a_525:float) , (b_526:float) , (c_527:float)) =
    (i_577_step self.i_577 (a_525 , b_526 , c_527):float) in
  Node { alloc = onceBfromAtoC_alloc; reset = onceBfromAtoC_reset ;
                                      step = onceBfromAtoC_step }
type ('b , 'a) _alwaysBfromlastAtoC =
  { mutable i_579 : 'b ; mutable i_578 : 'a }

let alwaysBfromlastAtoC  = 
  let Node { alloc = i_579_alloc; step = i_579_step ; reset = i_579_reset } = sincelast 
   in 
  let Node { alloc = i_578_alloc; step = i_578_step ; reset = i_578_reset } = never 
   in
  let alwaysBfromlastAtoC_alloc _ =
    ();
    { i_579 = i_579_alloc () (* discrete *)  ;
      i_578 = i_578_alloc () (* discrete *)  } in
  let alwaysBfromlastAtoC_reset self  =
    ((i_579_reset self.i_579  ; i_578_reset self.i_578 ):unit) in 
  let alwaysBfromlastAtoC_step self ((a_528:float) ,
                                     (b_529:float) , (c_530:float)) =
    (implies (c_530 ,
              (q_or ((i_578_step self.i_578 a_528) ,
                     (q_not (i_579_step self.i_579 ((q_not b_529) , a_528)))))):
    float) in
  Node { alloc = alwaysBfromlastAtoC_alloc; reset = alwaysBfromlastAtoC_reset
                                            ; step = alwaysBfromlastAtoC_step }
type ('b , 'a) _alwaysBfromfirstAtoC =
  { mutable i_581 : 'b ; mutable i_580 : 'a }

let alwaysBfromfirstAtoC  = 
  let Node { alloc = i_581_alloc; step = i_581_step ; reset = i_581_reset } = sincefirst 
   in 
  let Node { alloc = i_580_alloc; step = i_580_step ; reset = i_580_reset } = never 
   in
  let alwaysBfromfirstAtoC_alloc _ =
    ();
    { i_581 = i_581_alloc () (* discrete *)  ;
      i_580 = i_580_alloc () (* discrete *)  } in
  let alwaysBfromfirstAtoC_reset self  =
    ((i_581_reset self.i_581  ; i_580_reset self.i_580 ):unit) in 
  let alwaysBfromfirstAtoC_step self ((a_531:float) ,
                                      (b_532:float) , (c_533:float)) =
    (implies (c_533 ,
              (q_or ((i_580_step self.i_580 a_531) ,
                     (q_not (i_581_step self.i_581 ((q_not b_532) , a_531)))))):
    float) in
  Node { alloc = alwaysBfromfirstAtoC_alloc; reset = alwaysBfromfirstAtoC_reset
                                             ;
                                             step = alwaysBfromfirstAtoC_step }
type ('a) _alwaysBfromAtoC =
  { mutable i_582 : 'a }

let alwaysBfromAtoC  = 
  let Node { alloc = i_582_alloc; step = i_582_step ; reset = i_582_reset } = alwaysBfromlastAtoC 
   in
  let alwaysBfromAtoC_alloc _ =
    ();{ i_582 = i_582_alloc () (* discrete *)  } in
  let alwaysBfromAtoC_reset self  =
    (i_582_reset self.i_582 :unit) in 
  let alwaysBfromAtoC_step self ((a_534:float) ,
                                 (b_535:float) , (c_536:float)) =
    (i_582_step self.i_582 (a_534 , b_535 , c_536):float) in
  Node { alloc = alwaysBfromAtoC_alloc; reset = alwaysBfromAtoC_reset ;
                                        step = alwaysBfromAtoC_step }
type ('a) _neverBfromlastAtoC =
  { mutable i_583 : 'a }

let neverBfromlastAtoC  = 
  let Node { alloc = i_583_alloc; step = i_583_step ; reset = i_583_reset } = alwaysBfromlastAtoC 
   in
  let neverBfromlastAtoC_alloc _ =
    ();{ i_583 = i_583_alloc () (* discrete *)  } in
  let neverBfromlastAtoC_reset self  =
    (i_583_reset self.i_583 :unit) in 
  let neverBfromlastAtoC_step self ((a_537:float) ,
                                    (b_538:float) , (c_539:float)) =
    (i_583_step self.i_583 (a_537 , (q_not b_538) , c_539):float) in
  Node { alloc = neverBfromlastAtoC_alloc; reset = neverBfromlastAtoC_reset ;
                                           step = neverBfromlastAtoC_step }
type ('a) _neverBfromfirstAtoC =
  { mutable i_584 : 'a }

let neverBfromfirstAtoC  = 
  let Node { alloc = i_584_alloc; step = i_584_step ; reset = i_584_reset } = alwaysBfromfirstAtoC 
   in
  let neverBfromfirstAtoC_alloc _ =
    ();{ i_584 = i_584_alloc () (* discrete *)  } in
  let neverBfromfirstAtoC_reset self  =
    (i_584_reset self.i_584 :unit) in 
  let neverBfromfirstAtoC_step self ((a_540:float) ,
                                     (b_541:float) , (c_542:float)) =
    (i_584_step self.i_584 (a_540 , (q_not b_541) , c_542):float) in
  Node { alloc = neverBfromfirstAtoC_alloc; reset = neverBfromfirstAtoC_reset
                                            ; step = neverBfromfirstAtoC_step }
type ('a) _neverBfromAtoC =
  { mutable i_585 : 'a }

let neverBfromAtoC  = 
  let Node { alloc = i_585_alloc; step = i_585_step ; reset = i_585_reset } = alwaysBfromAtoC 
   in
  let neverBfromAtoC_alloc _ =
    ();{ i_585 = i_585_alloc () (* discrete *)  } in
  let neverBfromAtoC_reset self  =
    (i_585_reset self.i_585 :unit) in 
  let neverBfromAtoC_step self ((a_543:float) , (b_544:float) , (c_545:float)) =
    (i_585_step self.i_585 (a_543 , (q_not b_544) , c_545):float) in
  Node { alloc = neverBfromAtoC_alloc; reset = neverBfromAtoC_reset ;
                                       step = neverBfromAtoC_step }
type ('b , 'a) _onceBfromlastA =
  { mutable i_587 : 'b ; mutable i_586 : 'a }

let onceBfromlastA  = 
  let Node { alloc = i_587_alloc; step = i_587_step ; reset = i_587_reset } = sincelast 
   in 
  let Node { alloc = i_586_alloc; step = i_586_step ; reset = i_586_reset } = never 
   in
  let onceBfromlastA_alloc _ =
    ();
    { i_587 = i_587_alloc () (* discrete *)  ;
      i_586 = i_586_alloc () (* discrete *)  } in
  let onceBfromlastA_reset self  =
    ((i_587_reset self.i_587  ; i_586_reset self.i_586 ):unit) in 
  let onceBfromlastA_step self ((a_546:float) , (b_547:float)) =
    (q_or ((i_586_step self.i_586 a_546) ,
           (i_587_step self.i_587 (b_547 , a_546))):float) in
  Node { alloc = onceBfromlastA_alloc; reset = onceBfromlastA_reset ;
                                       step = onceBfromlastA_step }
type ('b , 'a) _onceBfromfirstA =
  { mutable i_589 : 'b ; mutable i_588 : 'a }

let onceBfromfirstA  = 
  let Node { alloc = i_589_alloc; step = i_589_step ; reset = i_589_reset } = sincefirst 
   in 
  let Node { alloc = i_588_alloc; step = i_588_step ; reset = i_588_reset } = never 
   in
  let onceBfromfirstA_alloc _ =
    ();
    { i_589 = i_589_alloc () (* discrete *)  ;
      i_588 = i_588_alloc () (* discrete *)  } in
  let onceBfromfirstA_reset self  =
    ((i_589_reset self.i_589  ; i_588_reset self.i_588 ):unit) in 
  let onceBfromfirstA_step self ((a_548:float) , (b_549:float)) =
    (q_or ((i_588_step self.i_588 a_548) ,
           (i_589_step self.i_589 (b_549 , a_548))):float) in
  Node { alloc = onceBfromfirstA_alloc; reset = onceBfromfirstA_reset ;
                                        step = onceBfromfirstA_step }
type ('a) _onceBfromA =
  { mutable i_590 : 'a }

let onceBfromA  = 
  let Node { alloc = i_590_alloc; step = i_590_step ; reset = i_590_reset } = onceBfromlastA 
   in
  let onceBfromA_alloc _ =
    ();{ i_590 = i_590_alloc () (* discrete *)  } in
  let onceBfromA_reset self  =
    (i_590_reset self.i_590 :unit) in 
  let onceBfromA_step self ((a_550:float) , (b_551:float)) =
    (i_590_step self.i_590 (a_550 , b_551):float) in
  Node { alloc = onceBfromA_alloc; reset = onceBfromA_reset ;
                                   step = onceBfromA_step }
type ('b , 'a) _alwaysBfromlastA =
  { mutable i_592 : 'b ; mutable i_591 : 'a }

let alwaysBfromlastA  = 
  let Node { alloc = i_592_alloc; step = i_592_step ; reset = i_592_reset } = sincelast 
   in 
  let Node { alloc = i_591_alloc; step = i_591_step ; reset = i_591_reset } = never 
   in
  let alwaysBfromlastA_alloc _ =
    ();
    { i_592 = i_592_alloc () (* discrete *)  ;
      i_591 = i_591_alloc () (* discrete *)  } in
  let alwaysBfromlastA_reset self  =
    ((i_592_reset self.i_592  ; i_591_reset self.i_591 ):unit) in 
  let alwaysBfromlastA_step self ((a_552:float) , (b_553:float)) =
    (q_or ((i_591_step self.i_591 a_552) ,
           (q_not (i_592_step self.i_592 ((q_not b_553) , a_552)))):float) in
  Node { alloc = alwaysBfromlastA_alloc; reset = alwaysBfromlastA_reset ;
                                         step = alwaysBfromlastA_step }
type ('b , 'a) _alwaysBfromfirstA =
  { mutable i_594 : 'b ; mutable i_593 : 'a }

let alwaysBfromfirstA  = 
  let Node { alloc = i_594_alloc; step = i_594_step ; reset = i_594_reset } = sincefirst 
   in 
  let Node { alloc = i_593_alloc; step = i_593_step ; reset = i_593_reset } = never 
   in
  let alwaysBfromfirstA_alloc _ =
    ();
    { i_594 = i_594_alloc () (* discrete *)  ;
      i_593 = i_593_alloc () (* discrete *)  } in
  let alwaysBfromfirstA_reset self  =
    ((i_594_reset self.i_594  ; i_593_reset self.i_593 ):unit) in 
  let alwaysBfromfirstA_step self ((a_554:float) , (b_555:float)) =
    (q_or ((i_593_step self.i_593 a_554) ,
           (q_not (i_594_step self.i_594 ((q_not b_555) , a_554)))):float) in
  Node { alloc = alwaysBfromfirstA_alloc; reset = alwaysBfromfirstA_reset ;
                                          step = alwaysBfromfirstA_step }
type ('a) _alwaysBfromA =
  { mutable i_595 : 'a }

let alwaysBfromA  = 
  let Node { alloc = i_595_alloc; step = i_595_step ; reset = i_595_reset } = alwaysBfromlastA 
   in
  let alwaysBfromA_alloc _ =
    ();{ i_595 = i_595_alloc () (* discrete *)  } in
  let alwaysBfromA_reset self  =
    (i_595_reset self.i_595 :unit) in 
  let alwaysBfromA_step self ((a_556:float) , (b_557:float)) =
    (i_595_step self.i_595 (a_556 , b_557):float) in
  Node { alloc = alwaysBfromA_alloc; reset = alwaysBfromA_reset ;
                                     step = alwaysBfromA_step }
type ('a) _neverBfromlastA =
  { mutable i_596 : 'a }

let neverBfromlastA  = 
  let Node { alloc = i_596_alloc; step = i_596_step ; reset = i_596_reset } = alwaysBfromlastA 
   in
  let neverBfromlastA_alloc _ =
    ();{ i_596 = i_596_alloc () (* discrete *)  } in
  let neverBfromlastA_reset self  =
    (i_596_reset self.i_596 :unit) in 
  let neverBfromlastA_step self ((a_558:float) , (b_559:float)) =
    (i_596_step self.i_596 (a_558 , (q_not b_559)):float) in
  Node { alloc = neverBfromlastA_alloc; reset = neverBfromlastA_reset ;
                                        step = neverBfromlastA_step }
type ('a) _neverBfromfirstA =
  { mutable i_597 : 'a }

let neverBfromfirstA  = 
  let Node { alloc = i_597_alloc; step = i_597_step ; reset = i_597_reset } = alwaysBfromfirstA 
   in
  let neverBfromfirstA_alloc _ =
    ();{ i_597 = i_597_alloc () (* discrete *)  } in
  let neverBfromfirstA_reset self  =
    (i_597_reset self.i_597 :unit) in 
  let neverBfromfirstA_step self ((a_560:float) , (b_561:float)) =
    (i_597_step self.i_597 (a_560 , (q_not b_561)):float) in
  Node { alloc = neverBfromfirstA_alloc; reset = neverBfromfirstA_reset ;
                                         step = neverBfromfirstA_step }
type ('a) _neverBfromA =
  { mutable i_598 : 'a }

let neverBfromA  = 
  let Node { alloc = i_598_alloc; step = i_598_step ; reset = i_598_reset } = neverBfromlastA 
   in
  let neverBfromA_alloc _ =
    ();{ i_598 = i_598_alloc () (* discrete *)  } in
  let neverBfromA_reset self  =
    (i_598_reset self.i_598 :unit) in 
  let neverBfromA_step self ((a_562:float) , (b_563:float)) =
    (i_598_step self.i_598 (a_562 , b_563):float) in
  Node { alloc = neverBfromA_alloc; reset = neverBfromA_reset ;
                                    step = neverBfromA_step }
