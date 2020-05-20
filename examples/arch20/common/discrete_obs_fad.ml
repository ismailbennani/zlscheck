(* The Zélus compiler, version 2.1
  (mer. 06 mai 2020 13:31:20 CEST) *)
open Ztypes
type state__5018 =
Discrete_obs_fad_YFALSE_233
| Discrete_obs_fad_YTRUE_232 | Discrete_obs_fad_INIT_231 
type state__5017 = Discrete_obs_fad_YTRUE_225 | Discrete_obs_fad_INIT_224 
type state__5016 = Discrete_obs_fad_Count_215 | Discrete_obs_fad_Stop_214 
open MyOp
let q_true = MyOp.make infinity

let q_false = MyOp.make neg_infinity

type _no_signal = unit

let no_signal  = 
   let no_signal_alloc _ = () in
  let no_signal_reset self  =
    ((()):unit) in 
  let no_signal_step self () =
    ((let resultp_466 = ref (false:bool) in
      let resultv_465 = ref (():unit) in
      (begin match false with
             | true -> resultp_466 := true ; resultv_465 := () | _ -> ()  end)
      ; (!resultv_465 , !resultp_466)):unit signal) in
  Node { alloc = no_signal_alloc; reset = no_signal_reset ;
                                  step = no_signal_step }
type ('a) _now =
  { mutable m_469 : 'a }

let now  = 
   let now_alloc _ =
     ();{ m_469 = (false:bool) } in
  let now_reset self  =
    (self.m_469 <- true:unit) in 
  let now_step self () =
    ((let resultp_468 = ref (false:bool) in
      let resultv_467 = ref (():unit) in
      let (x_470:bool) = self.m_469 in
      self.m_469 <- false ;
      (begin match x_470 with
             | true -> resultp_468 := true ; resultv_467 := () | _ -> ()  end)
      ; (!resultv_467 , !resultp_468)):unit signal) in
  Node { alloc = now_alloc; reset = now_reset ; step = now_step }
let isTrue (p_471:MyOp.t) =
  (>=) p_471  (MyOp.make 0.)

let isFalse (p_472:MyOp.t) =
  (<) p_472  (MyOp.make 0.)

let q_istrue (p_473:MyOp.t) =
  let resultp_475 = ref (false:bool) in
  let resultv_474 = ref (():unit) in
  (begin match isTrue p_473 with
         | true -> resultp_475 := true ; resultv_474 := () | _ -> ()  end) ;
  (!resultv_474 , !resultp_475)

let q_isfalse (p_476:MyOp.t) =
  let resultp_478 = ref (false:bool) in
  let resultv_477 = ref (():unit) in
  (begin match isFalse p_476 with
         | true -> resultp_478 := true ; resultv_477 := () | _ -> ()  end) ;
  (!resultv_477 , !resultp_478)

let q_aretrue2 ((p_479:MyOp.t) , (s_480:MyOp.t)) =
  let resultp_482 = ref (false:bool) in
  let resultv_481 = ref (():unit) in
  (begin match ((isTrue s_480) ,
                (isTrue p_479) , (isTrue p_479) , (isTrue s_480)) with
         | (_ , _ , true , true) | (true , true , _ , _) ->
             resultp_482 := true ; resultv_481 := () | _ -> ()  end) ;
  (!resultv_481 , !resultp_482)

type ('b , 'a) _freeze =
  { mutable i_485 : 'b ; mutable res_484 : 'a }

let freeze  = 
  
  let freeze_alloc _ =
    ();{ i_485 = (false:bool) ; res_484 = (Obj.magic ():'a) } in
  let freeze_reset self  =
    (self.i_485 <- true:unit) in 
  let freeze_step self (p_483:'a4294) =
    (((if self.i_485 then self.res_484 <- p_483) ;
      self.i_485 <- false ; self.res_484):'a) in
  Node { alloc = freeze_alloc; reset = freeze_reset ; step = freeze_step }
type ('a) _q_istrue_now =
  { mutable i_729 : 'a }

let q_istrue_now  = 
  let Node { alloc = i_729_alloc; step = i_729_step ; reset = i_729_reset } = freeze 
   in
  let q_istrue_now_alloc _ =
    ();{ i_729 = i_729_alloc () (* discrete *)  } in
  let q_istrue_now_reset self  =
    (i_729_reset self.i_729 :unit) in 
  let q_istrue_now_step self (p_486:MyOp.t) =
    ((let resultp_489 = ref (false:bool) in
      let resultv_488 = ref (():unit) in
      (begin match isTrue p_486 with
             | true -> resultp_489 := true ; resultv_488 := () | _ -> ()  end)
      ; i_729_step self.i_729 (!resultv_488 , !resultp_489)):unit signal) in
  Node { alloc = q_istrue_now_alloc; reset = q_istrue_now_reset ;
                                     step = q_istrue_now_step }
type ('a) _q_isfalse_now =
  { mutable i_730 : 'a }

let q_isfalse_now  = 
  let Node { alloc = i_730_alloc; step = i_730_step ; reset = i_730_reset } = freeze 
   in
  let q_isfalse_now_alloc _ =
    ();{ i_730 = i_730_alloc () (* discrete *)  } in
  let q_isfalse_now_reset self  =
    (i_730_reset self.i_730 :unit) in 
  let q_isfalse_now_step self (p_490:MyOp.t) =
    ((let resultp_493 = ref (false:bool) in
      let resultv_492 = ref (():unit) in
      (begin match isFalse p_490 with
             | true -> resultp_493 := true ; resultv_492 := () | _ -> ()  end)
      ; i_730_step self.i_730 (!resultv_492 , !resultp_493)):unit signal) in
  Node { alloc = q_isfalse_now_alloc; reset = q_isfalse_now_reset ;
                                      step = q_isfalse_now_step }
let q_gt ((p1_494:MyOp.t) , (p2_495:MyOp.t)) =
  MyOp.(-) p1_494  p2_495

let q_ge ((p1_496:MyOp.t) , (p2_497:MyOp.t)) =
  MyOp.(-) p1_496  p2_497

let q_lt ((p1_498:MyOp.t) , (p2_499:MyOp.t)) =
  MyOp.(-) p2_499  p1_498

let q_le ((p1_500:MyOp.t) , (p2_501:MyOp.t)) =
  MyOp.(-) p2_501  p1_500

let q_not (p_502:MyOp.t) =
  MyOp.(~-) p_502

let q_or ((p1_503:MyOp.t) , (p2_504:MyOp.t)) =
  MyOp.max p1_503  p2_504

let q_and ((p1_505:MyOp.t) , (p2_506:MyOp.t)) =
  MyOp.min p1_505  p2_506

let abs (x1_507:MyOp.t) =
  MyOp.max x1_507  (MyOp.(~-) x1_507)

let q_eq (precision_508:MyOp.t)  ((x1_509:MyOp.t) , (x2_510:MyOp.t)) =
  MyOp.(-) precision_508  (abs (MyOp.(-) x1_509  x2_510))

let q_eqi ((i1_511:MyOp.t) , (i2_512:MyOp.t)) =
  MyOp.(-) (MyOp.make 0.5)  (abs (MyOp.(-) i1_511  i2_512))

let implies ((a_513:MyOp.t) , (b_514:MyOp.t)) =
  q_or ((q_not a_513) , b_514)

type ('b , 'a) _q_up =
  { mutable i_519 : 'b ; mutable m_516 : 'a }

let q_up  = 
  
  let q_up_alloc _ =
    ();{ i_519 = (false:bool) ; m_516 = (create ():MyOp.t) } in
  let q_up_reset self  =
    (self.i_519 <- true:unit) in 
  let q_up_step self (p_515:MyOp.t) =
    ((let (x_518:MyOp.t) =
          if self.i_519
          then p_515
          else
            q_and ((q_lt (self.m_516 , (MyOp.zero ()))) ,
                   (q_gt (p_515 , (MyOp.zero ())))) in
      self.i_519 <- false ; self.m_516 <- p_515 ; x_518):MyOp.t) in
  Node { alloc = q_up_alloc; reset = q_up_reset ; step = q_up_step }
type ('b , 'a) _b_up =
  { mutable i_524 : 'b ; mutable m_521 : 'a }

let b_up  = 
   let b_up_alloc _ =
     ();{ i_524 = (false:bool) ; m_521 = (false:bool) } in
  let b_up_reset self  =
    (self.i_524 <- true:unit) in 
  let b_up_step self (p_520:bool) =
    ((let (x_523:bool) =
          if self.i_524 then p_520 else (&&) (not self.m_521)  p_520 in
      self.i_524 <- false ; self.m_521 <- p_520 ; x_523):bool) in
  Node { alloc = b_up_alloc; reset = b_up_reset ; step = b_up_step }
let min_cpt = (-1.)

type ('e , 'd , 'c , 'b , 'a) _counter =
  { mutable r_533 : 'e ;
    mutable s_532 : 'd ;
    mutable cpt_531 : 'c ; mutable i_537 : 'b ; mutable m_534 : 'a }

let counter (delay_525:float) = 
  
  let counter_alloc _ =
    ();
    { r_533 = (false:bool) ;
      s_532 = (Discrete_obs_fad_Count_215:state__5016) ;
      cpt_531 = (create ():MyOp.t) ;
      i_537 = (false:bool) ; m_534 = (create ():MyOp.t) } in
  let counter_reset self  =
    ((self.r_533 <- false ;
      self.s_532 <- Discrete_obs_fad_Stop_214 ; self.i_537 <- true):unit) in 
  let counter_step self ((tstep_526:MyOp.t) ,
                         ((strtv_529:unit) , (strtp_530:bool)) ,
                         ((rstv_527:unit) , (rstp_528:bool))) =
    (((begin match self.s_532 with
             | Discrete_obs_fad_Stop_214 ->
                 (if self.r_533 then ()) ;
                 self.cpt_531 <- MyOp.make delay_525 ;
                 (begin match (strtv_529 , strtp_530) with
                        | (() , true) ->
                            self.r_533 <- true ;
                            self.s_532 <- Discrete_obs_fad_Count_215
                        | _ -> self.r_533 <- false  end)
             | Discrete_obs_fad_Count_215 ->
                 (if self.r_533 then self.i_537 <- true) ;
                 (let (x_536:MyOp.t) =
                      if self.i_537
                      then MyOp.make delay_525
                      else MyOp.(-) self.m_534  tstep_526 in
                  self.i_537 <- false ;
                  self.cpt_531 <- x_536 ;
                  self.m_534 <- x_536 ;
                  (begin match (rstv_527 , rstp_528) with
                         | (() , true) ->
                             self.r_533 <- true ;
                             self.s_532 <- Discrete_obs_fad_Stop_214
                         | _ -> self.r_533 <- false  end))
              end) ; self.cpt_531):MyOp.t) in
  Node { alloc = counter_alloc; reset = counter_reset ; step = counter_step }
type ('b , 'a) _always =
  { mutable i_543 : 'b ; mutable m_540 : 'a }

let always  = 
  
  let always_alloc _ =
    ();{ i_543 = (false:bool) ; m_540 = (create ():MyOp.t) } in
  let always_reset self  =
    (self.i_543 <- true:unit) in 
  let always_step self (p_538:MyOp.t) =
    ((let (x_542:MyOp.t) =
          if self.i_543 then p_538 else q_and (self.m_540 , p_538) in
      self.i_543 <- false ; self.m_540 <- x_542 ; x_542):MyOp.t) in
  Node { alloc = always_alloc; reset = always_reset ; step = always_step }
type ('a) _never =
  { mutable i_731 : 'a }

let never  = 
  let Node { alloc = i_731_alloc; step = i_731_step ; reset = i_731_reset } = always 
   in let never_alloc _ =
        ();{ i_731 = i_731_alloc () (* discrete *)  } in
  let never_reset self  =
    (i_731_reset self.i_731 :unit) in 
  let never_step self (p_544:MyOp.t) =
    (i_731_step self.i_731 (q_not p_544):MyOp.t) in
  Node { alloc = never_alloc; reset = never_reset ; step = never_step }
type ('b , 'a) _once =
  { mutable i_550 : 'b ; mutable m_547 : 'a }

let once  = 
  
  let once_alloc _ =
    ();{ i_550 = (false:bool) ; m_547 = (create ():MyOp.t) } in
  let once_reset self  =
    (self.i_550 <- true:unit) in 
  let once_step self (p_545:MyOp.t) =
    ((let (x_549:MyOp.t) =
          if self.i_550 then p_545 else q_or (self.m_547 , p_545) in
      self.i_550 <- false ; self.m_547 <- x_549 ; x_549):MyOp.t) in
  Node { alloc = once_alloc; reset = once_reset ; step = once_step }
type ('f , 'e , 'd , 'c , 'b , 'a) _sincefirst =
  { mutable i_732 : 'f ;
    mutable i_734 : 'e ;
    mutable i_733 : 'd ;
    mutable r_555 : 'c ; mutable s_554 : 'b ; mutable result_553 : 'a }

let sincefirst  = 
  let Node { alloc = i_732_alloc; step = i_732_step ; reset = i_732_reset } = never 
   in 
  let Node { alloc = i_734_alloc; step = i_734_step ; reset = i_734_reset } = once 
   in 
  let Node { alloc = i_733_alloc; step = i_733_step ; reset = i_733_reset } = never 
   in
  let sincefirst_alloc _ =
    ();
    { r_555 = (false:bool) ;
      s_554 = (Discrete_obs_fad_YTRUE_225:state__5017) ;
      result_553 = (create ():MyOp.t);
      i_732 = i_732_alloc () (* discrete *)  ;
      i_734 = i_734_alloc () (* discrete *)  ;
      i_733 = i_733_alloc () (* discrete *)  } in
  let sincefirst_reset self  =
    ((self.r_555 <- false ;
      self.s_554 <- Discrete_obs_fad_INIT_224 ;
      i_732_reset self.i_732  ;
      i_734_reset self.i_734  ; i_733_reset self.i_733 ):unit) in 
  let sincefirst_step self ((x_551:MyOp.t) , (y_552:MyOp.t)) =
    (((begin match self.s_554 with
             | Discrete_obs_fad_INIT_224 ->
                 let resultp_558 = ref (false:bool) in
                 let resultv_557 = ref (():unit) in
                 (if self.r_555 then i_732_reset self.i_732 ) ;
                 self.result_553 <- q_or ((i_732_step self.i_732 y_552) ,
                                          x_551) ;
                 (begin match isTrue y_552 with
                        | true -> resultp_558 := true ; resultv_557 := ()
                        | _ -> ()  end) ;
                 (begin match (!resultv_557 , !resultp_558) with
                        | (() , true) ->
                            self.r_555 <- true ;
                            self.s_554 <- Discrete_obs_fad_YTRUE_225
                        | _ -> self.r_555 <- false  end)
             | Discrete_obs_fad_YTRUE_225 ->
                 (if self.r_555 then
                  (i_734_reset self.i_734  ; i_733_reset self.i_733 )) ;
                 self.result_553 <- q_or ((i_733_step self.i_733 y_552) ,
                                          (i_734_step self.i_734 x_551)) ;
                 self.r_555 <- false
              end) ; self.result_553):MyOp.t) in
  Node { alloc = sincefirst_alloc; reset = sincefirst_reset ;
                                   step = sincefirst_step }
type ('f , 'e , 'd , 'c , 'b , 'a) _sincelast =
  { mutable i_735 : 'f ;
    mutable i_736 : 'e ;
    mutable r_564 : 'd ;
    mutable s_563 : 'c ; mutable last_res_562 : 'b ; mutable result_561 : 'a }

let sincelast  = 
  let Node { alloc = i_735_alloc; step = i_735_step ; reset = i_735_reset } = never 
   in 
  let Node { alloc = i_736_alloc; step = i_736_step ; reset = i_736_reset } = once 
   in
  let sincelast_alloc _ =
    ();
    { r_564 = (false:bool) ;
      s_563 = (Discrete_obs_fad_YFALSE_233:state__5018) ;
      last_res_562 = (create ():MyOp.t) ;
      result_561 = (create ():MyOp.t);
      i_735 = i_735_alloc () (* discrete *)  ;
      i_736 = i_736_alloc () (* discrete *)  } in
  let sincelast_reset self  =
    ((self.r_564 <- false ;
      self.s_563 <- Discrete_obs_fad_INIT_231 ;
      i_735_reset self.i_735  ; i_736_reset self.i_736 ):unit) in 
  let sincelast_step self ((x_559:MyOp.t) , (y_560:MyOp.t)) =
    (((begin match self.s_563 with
             | Discrete_obs_fad_INIT_231 ->
                 let resultp_567 = ref (false:bool) in
                 let resultv_566 = ref (():unit) in
                 (if self.r_564 then i_735_reset self.i_735 ) ;
                 self.result_561 <- q_or ((i_735_step self.i_735 y_560) ,
                                          x_559) ;
                 (begin match isTrue y_560 with
                        | true -> resultp_567 := true ; resultv_566 := ()
                        | _ -> ()  end) ;
                 (begin match (!resultv_566 , !resultp_567) with
                        | (() , true) ->
                            self.r_564 <- true ;
                            self.s_563 <- Discrete_obs_fad_YTRUE_232
                        | _ -> self.r_564 <- false  end)
             | Discrete_obs_fad_YTRUE_232 ->
                 let resultp_570 = ref (false:bool) in
                 let resultv_569 = ref (():unit) in
                 (if self.r_564 then ()) ;
                 self.result_561 <- x_559 ;
                 (begin match isFalse y_560 with
                        | true -> resultp_570 := true ; resultv_569 := ()
                        | _ -> ()  end) ;
                 (begin match (!resultv_569 , !resultp_570) with
                        | (() , true) ->
                            self.last_res_562 <- x_559 ;
                            self.r_564 <- true ;
                            self.s_563 <- Discrete_obs_fad_YFALSE_233
                        | _ -> self.r_564 <- false  end)
             | Discrete_obs_fad_YFALSE_233 ->
                 let resultp_573 = ref (false:bool) in
                 let resultv_572 = ref (():unit) in
                 (if self.r_564 then i_736_reset self.i_736 ) ;
                 self.result_561 <- q_or (self.last_res_562 ,
                                          (i_736_step self.i_736 x_559)) ;
                 (begin match isTrue y_560 with
                        | true -> resultp_573 := true ; resultv_572 := ()
                        | _ -> ()  end) ;
                 (begin match (!resultv_572 , !resultp_573) with
                        | (() , true) ->
                            self.r_564 <- true ;
                            self.s_563 <- Discrete_obs_fad_YTRUE_232
                        | _ -> self.r_564 <- false  end)
              end) ; self.result_561):MyOp.t) in
  Node { alloc = sincelast_alloc; reset = sincelast_reset ;
                                  step = sincelast_step }
type ('a) _since =
  { mutable i_737 : 'a }

let since  = 
  let Node { alloc = i_737_alloc; step = i_737_step ; reset = i_737_reset } = sincelast 
   in let since_alloc _ =
        ();{ i_737 = i_737_alloc () (* discrete *)  } in
  let since_reset self  =
    (i_737_reset self.i_737 :unit) in 
  let since_step self ((x_574:MyOp.t) , (y_575:MyOp.t)) =
    (i_737_step self.i_737 (x_574 , y_575):MyOp.t) in
  Node { alloc = since_alloc; reset = since_reset ; step = since_step }
type ('b , 'a) _onceBfromlastAtoC =
  { mutable i_739 : 'b ; mutable i_738 : 'a }

let onceBfromlastAtoC  = 
  let Node { alloc = i_739_alloc; step = i_739_step ; reset = i_739_reset } = sincelast 
   in 
  let Node { alloc = i_738_alloc; step = i_738_step ; reset = i_738_reset } = never 
   in
  let onceBfromlastAtoC_alloc _ =
    ();
    { i_739 = i_739_alloc () (* discrete *)  ;
      i_738 = i_738_alloc () (* discrete *)  } in
  let onceBfromlastAtoC_reset self  =
    ((i_739_reset self.i_739  ; i_738_reset self.i_738 ):unit) in 
  let onceBfromlastAtoC_step self ((a_576:MyOp.t) ,
                                   (b_577:MyOp.t) , (c_578:MyOp.t)) =
    (implies (c_578 ,
              (q_or ((i_738_step self.i_738 a_576) ,
                     (i_739_step self.i_739 (b_577 , a_576))))):MyOp.t) in
  Node { alloc = onceBfromlastAtoC_alloc; reset = onceBfromlastAtoC_reset ;
                                          step = onceBfromlastAtoC_step }
type ('b , 'a) _onceBfromfirstAtoC =
  { mutable i_741 : 'b ; mutable i_740 : 'a }

let onceBfromfirstAtoC  = 
  let Node { alloc = i_741_alloc; step = i_741_step ; reset = i_741_reset } = sincefirst 
   in 
  let Node { alloc = i_740_alloc; step = i_740_step ; reset = i_740_reset } = never 
   in
  let onceBfromfirstAtoC_alloc _ =
    ();
    { i_741 = i_741_alloc () (* discrete *)  ;
      i_740 = i_740_alloc () (* discrete *)  } in
  let onceBfromfirstAtoC_reset self  =
    ((i_741_reset self.i_741  ; i_740_reset self.i_740 ):unit) in 
  let onceBfromfirstAtoC_step self ((a_579:MyOp.t) ,
                                    (b_580:MyOp.t) , (c_581:MyOp.t)) =
    (implies (c_581 ,
              (q_or ((i_740_step self.i_740 a_579) ,
                     (i_741_step self.i_741 (b_580 , a_579))))):MyOp.t) in
  Node { alloc = onceBfromfirstAtoC_alloc; reset = onceBfromfirstAtoC_reset ;
                                           step = onceBfromfirstAtoC_step }
type ('a) _onceBfromAtoC =
  { mutable i_742 : 'a }

let onceBfromAtoC  = 
  let Node { alloc = i_742_alloc; step = i_742_step ; reset = i_742_reset } = onceBfromlastAtoC 
   in
  let onceBfromAtoC_alloc _ =
    ();{ i_742 = i_742_alloc () (* discrete *)  } in
  let onceBfromAtoC_reset self  =
    (i_742_reset self.i_742 :unit) in 
  let onceBfromAtoC_step self ((a_582:MyOp.t) ,
                               (b_583:MyOp.t) , (c_584:MyOp.t)) =
    (i_742_step self.i_742 (a_582 , b_583 , c_584):MyOp.t) in
  Node { alloc = onceBfromAtoC_alloc; reset = onceBfromAtoC_reset ;
                                      step = onceBfromAtoC_step }
type ('b , 'a) _alwaysBfromlastAtoC =
  { mutable i_744 : 'b ; mutable i_743 : 'a }

let alwaysBfromlastAtoC  = 
  let Node { alloc = i_744_alloc; step = i_744_step ; reset = i_744_reset } = sincelast 
   in 
  let Node { alloc = i_743_alloc; step = i_743_step ; reset = i_743_reset } = never 
   in
  let alwaysBfromlastAtoC_alloc _ =
    ();
    { i_744 = i_744_alloc () (* discrete *)  ;
      i_743 = i_743_alloc () (* discrete *)  } in
  let alwaysBfromlastAtoC_reset self  =
    ((i_744_reset self.i_744  ; i_743_reset self.i_743 ):unit) in 
  let alwaysBfromlastAtoC_step self ((a_585:MyOp.t) ,
                                     (b_586:MyOp.t) , (c_587:MyOp.t)) =
    (implies (c_587 ,
              (q_or ((i_743_step self.i_743 a_585) ,
                     (q_not (i_744_step self.i_744 ((q_not b_586) , a_585)))))):
    MyOp.t) in
  Node { alloc = alwaysBfromlastAtoC_alloc; reset = alwaysBfromlastAtoC_reset
                                            ; step = alwaysBfromlastAtoC_step }
type ('b , 'a) _alwaysBfromfirstAtoC =
  { mutable i_746 : 'b ; mutable i_745 : 'a }

let alwaysBfromfirstAtoC  = 
  let Node { alloc = i_746_alloc; step = i_746_step ; reset = i_746_reset } = sincefirst 
   in 
  let Node { alloc = i_745_alloc; step = i_745_step ; reset = i_745_reset } = never 
   in
  let alwaysBfromfirstAtoC_alloc _ =
    ();
    { i_746 = i_746_alloc () (* discrete *)  ;
      i_745 = i_745_alloc () (* discrete *)  } in
  let alwaysBfromfirstAtoC_reset self  =
    ((i_746_reset self.i_746  ; i_745_reset self.i_745 ):unit) in 
  let alwaysBfromfirstAtoC_step self ((a_588:MyOp.t) ,
                                      (b_589:MyOp.t) , (c_590:MyOp.t)) =
    (implies (c_590 ,
              (q_or ((i_745_step self.i_745 a_588) ,
                     (q_not (i_746_step self.i_746 ((q_not b_589) , a_588)))))):
    MyOp.t) in
  Node { alloc = alwaysBfromfirstAtoC_alloc; reset = alwaysBfromfirstAtoC_reset
                                             ;
                                             step = alwaysBfromfirstAtoC_step }
type ('a) _alwaysBfromAtoC =
  { mutable i_747 : 'a }

let alwaysBfromAtoC  = 
  let Node { alloc = i_747_alloc; step = i_747_step ; reset = i_747_reset } = alwaysBfromlastAtoC 
   in
  let alwaysBfromAtoC_alloc _ =
    ();{ i_747 = i_747_alloc () (* discrete *)  } in
  let alwaysBfromAtoC_reset self  =
    (i_747_reset self.i_747 :unit) in 
  let alwaysBfromAtoC_step self ((a_591:MyOp.t) ,
                                 (b_592:MyOp.t) , (c_593:MyOp.t)) =
    (i_747_step self.i_747 (a_591 , b_592 , c_593):MyOp.t) in
  Node { alloc = alwaysBfromAtoC_alloc; reset = alwaysBfromAtoC_reset ;
                                        step = alwaysBfromAtoC_step }
type ('a) _neverBfromlastAtoC =
  { mutable i_748 : 'a }

let neverBfromlastAtoC  = 
  let Node { alloc = i_748_alloc; step = i_748_step ; reset = i_748_reset } = alwaysBfromlastAtoC 
   in
  let neverBfromlastAtoC_alloc _ =
    ();{ i_748 = i_748_alloc () (* discrete *)  } in
  let neverBfromlastAtoC_reset self  =
    (i_748_reset self.i_748 :unit) in 
  let neverBfromlastAtoC_step self ((a_594:MyOp.t) ,
                                    (b_595:MyOp.t) , (c_596:MyOp.t)) =
    (i_748_step self.i_748 (a_594 , (q_not b_595) , c_596):MyOp.t) in
  Node { alloc = neverBfromlastAtoC_alloc; reset = neverBfromlastAtoC_reset ;
                                           step = neverBfromlastAtoC_step }
type ('a) _neverBfromfirstAtoC =
  { mutable i_749 : 'a }

let neverBfromfirstAtoC  = 
  let Node { alloc = i_749_alloc; step = i_749_step ; reset = i_749_reset } = alwaysBfromfirstAtoC 
   in
  let neverBfromfirstAtoC_alloc _ =
    ();{ i_749 = i_749_alloc () (* discrete *)  } in
  let neverBfromfirstAtoC_reset self  =
    (i_749_reset self.i_749 :unit) in 
  let neverBfromfirstAtoC_step self ((a_597:MyOp.t) ,
                                     (b_598:MyOp.t) , (c_599:MyOp.t)) =
    (i_749_step self.i_749 (a_597 , (q_not b_598) , c_599):MyOp.t) in
  Node { alloc = neverBfromfirstAtoC_alloc; reset = neverBfromfirstAtoC_reset
                                            ; step = neverBfromfirstAtoC_step }
type ('a) _neverBfromAtoC =
  { mutable i_750 : 'a }

let neverBfromAtoC  = 
  let Node { alloc = i_750_alloc; step = i_750_step ; reset = i_750_reset } = alwaysBfromAtoC 
   in
  let neverBfromAtoC_alloc _ =
    ();{ i_750 = i_750_alloc () (* discrete *)  } in
  let neverBfromAtoC_reset self  =
    (i_750_reset self.i_750 :unit) in 
  let neverBfromAtoC_step self ((a_600:MyOp.t) ,
                                (b_601:MyOp.t) , (c_602:MyOp.t)) =
    (i_750_step self.i_750 (a_600 , (q_not b_601) , c_602):MyOp.t) in
  Node { alloc = neverBfromAtoC_alloc; reset = neverBfromAtoC_reset ;
                                       step = neverBfromAtoC_step }
type ('b , 'a) _horizon =
  { mutable i_751 : 'b ; mutable m_610 : 'a }

let horizon (delay_603:float) = 
  let Node { alloc = i_751_alloc; step = i_751_step ; reset = i_751_reset } = 
  counter delay_603  in
  let horizon_alloc _ =
    ();{ m_610 = (false:bool);i_751 = i_751_alloc () (* discrete *)  } in
  let horizon_reset self  =
    ((self.m_610 <- true ; i_751_reset self.i_751 ):unit) in 
  let horizon_step self (tstep_604:MyOp.t) =
    ((let resultp_609 = ref (false:bool) in
      let resultv_608 = ref (():unit) in
      let resultp_607 = ref (false:bool) in
      let resultv_606 = ref (():unit) in
      let (x_611:bool) = self.m_610 in
      self.m_610 <- false ;
      (begin match false with
             | true -> resultp_609 := true ; resultv_608 := () | _ -> ()  end)
      ;
      (begin match x_611 with
             | true -> resultp_607 := true ; resultv_606 := () | _ -> ()  end)
      ;
      (let (cpt_605:MyOp.t) =
           i_751_step self.i_751
             (tstep_604 ,
              (!resultv_606 , !resultp_607) , (!resultv_608 , !resultp_609)) in
       q_lt (cpt_605 , (MyOp.zero ())))):MyOp.t) in
  Node { alloc = horizon_alloc; reset = horizon_reset ; step = horizon_step }
type ('e , 'd , 'c , 'b , 'a) _once_timed =
  { mutable i_753 : 'e ;
    mutable i_752 : 'd ;
    mutable i_628 : 'c ; mutable m_623 : 'b ; mutable m_621 : 'a }

let once_timed (delay_612:float) = 
  let Node { alloc = i_753_alloc; step = i_753_step ; reset = i_753_reset } = 
  counter delay_612  in 
  let Node { alloc = i_752_alloc; step = i_752_step ; reset = i_752_reset } = once 
   in
  let once_timed_alloc _ =
    ();
    { i_628 = (false:bool) ;
      m_623 = (create ():MyOp.t) ; m_621 = (false:bool);
      i_753 = i_753_alloc () (* discrete *)  ;
      i_752 = i_752_alloc () (* discrete *)  } in
  let once_timed_reset self  =
    ((self.i_628 <- true ;
      self.m_621 <- true ; i_753_reset self.i_753  ; i_752_reset self.i_752 ):
    unit) in 
  let once_timed_step self ((tstep_614:MyOp.t) , (p_613:MyOp.t)) =
    ((let resultp_620 = ref (false:bool) in
      let resultv_619 = ref (():unit) in
      let resultp_618 = ref (false:bool) in
      let resultv_617 = ref (():unit) in
      (begin match false with
             | true -> resultp_620 := true ; resultv_619 := () | _ -> ()  end)
      ;
      (let (x_622:bool) = self.m_621 in
       (begin match x_622 with
              | true -> resultp_618 := true ; resultv_617 := () | _ -> ()  end)
       ;
       (let (cpt_615:MyOp.t) =
            i_753_step self.i_753
              (tstep_614 ,
               (!resultv_617 , !resultp_618) , (!resultv_619 , !resultp_620)) in
        let (x_625:MyOp.t) = i_752_step self.i_752 p_613 in
        let (x_627:MyOp.t) =
            if self.i_628
            then p_613
            else if (<) cpt_615  (MyOp.make 0.) then self.m_623 else x_625 in
        self.i_628 <- false ;
        self.m_621 <- false ; self.m_623 <- x_627 ; x_627))):MyOp.t) in
  Node { alloc = once_timed_alloc; reset = once_timed_reset ;
                                   step = once_timed_step }
type ('e , 'd , 'c , 'b , 'a) _always_timed =
  { mutable i_755 : 'e ;
    mutable i_754 : 'd ;
    mutable i_645 : 'c ; mutable m_640 : 'b ; mutable m_638 : 'a }

let always_timed (delay_629:float) = 
  let Node { alloc = i_755_alloc; step = i_755_step ; reset = i_755_reset } = 
  counter delay_629  in 
  let Node { alloc = i_754_alloc; step = i_754_step ; reset = i_754_reset } = always 
   in
  let always_timed_alloc _ =
    ();
    { i_645 = (false:bool) ;
      m_640 = (create ():MyOp.t) ; m_638 = (false:bool);
      i_755 = i_755_alloc () (* discrete *)  ;
      i_754 = i_754_alloc () (* discrete *)  } in
  let always_timed_reset self  =
    ((self.i_645 <- true ;
      self.m_638 <- true ; i_755_reset self.i_755  ; i_754_reset self.i_754 ):
    unit) in 
  let always_timed_step self ((tstep_631:MyOp.t) , (p_630:MyOp.t)) =
    ((let resultp_637 = ref (false:bool) in
      let resultv_636 = ref (():unit) in
      let resultp_635 = ref (false:bool) in
      let resultv_634 = ref (():unit) in
      (begin match false with
             | true -> resultp_637 := true ; resultv_636 := () | _ -> ()  end)
      ;
      (let (x_639:bool) = self.m_638 in
       (begin match x_639 with
              | true -> resultp_635 := true ; resultv_634 := () | _ -> ()  end)
       ;
       (let (cpt_632:MyOp.t) =
            i_755_step self.i_755
              (tstep_631 ,
               (!resultv_634 , !resultp_635) , (!resultv_636 , !resultp_637)) in
        let (x_642:MyOp.t) = i_754_step self.i_754 p_630 in
        let (x_644:MyOp.t) =
            if self.i_645
            then p_630
            else if (<) cpt_632  (MyOp.make 0.) then self.m_640 else x_642 in
        self.i_645 <- false ;
        self.m_638 <- false ; self.m_640 <- x_644 ; x_644))):MyOp.t) in
  Node { alloc = always_timed_alloc; reset = always_timed_reset ;
                                     step = always_timed_step }
type ('a) _never_timed =
  { mutable i_756 : 'a }

let never_timed (delay_646:float) = 
  let Node { alloc = i_756_alloc; step = i_756_step ; reset = i_756_reset } = 
  always_timed delay_646  in
  let never_timed_alloc _ =
    ();{ i_756 = i_756_alloc () (* discrete *)  } in
  let never_timed_reset self  =
    (i_756_reset self.i_756 :unit) in 
  let never_timed_step self ((tstep_648:MyOp.t) , (p_647:MyOp.t)) =
    (i_756_step self.i_756 (tstep_648 , (q_not p_647)):MyOp.t) in
  Node { alloc = never_timed_alloc; reset = never_timed_reset ;
                                    step = never_timed_step }
type ('b , 'a) _onceBfromlastA =
  { mutable i_758 : 'b ; mutable i_757 : 'a }

let onceBfromlastA  = 
  let Node { alloc = i_758_alloc; step = i_758_step ; reset = i_758_reset } = sincelast 
   in 
  let Node { alloc = i_757_alloc; step = i_757_step ; reset = i_757_reset } = never 
   in
  let onceBfromlastA_alloc _ =
    ();
    { i_758 = i_758_alloc () (* discrete *)  ;
      i_757 = i_757_alloc () (* discrete *)  } in
  let onceBfromlastA_reset self  =
    ((i_758_reset self.i_758  ; i_757_reset self.i_757 ):unit) in 
  let onceBfromlastA_step self ((a_649:MyOp.t) , (b_650:MyOp.t)) =
    (q_or ((i_757_step self.i_757 a_649) ,
           (i_758_step self.i_758 (b_650 , a_649))):MyOp.t) in
  Node { alloc = onceBfromlastA_alloc; reset = onceBfromlastA_reset ;
                                       step = onceBfromlastA_step }
type ('b , 'a) _onceBfromfirstA =
  { mutable i_760 : 'b ; mutable i_759 : 'a }

let onceBfromfirstA  = 
  let Node { alloc = i_760_alloc; step = i_760_step ; reset = i_760_reset } = sincefirst 
   in 
  let Node { alloc = i_759_alloc; step = i_759_step ; reset = i_759_reset } = never 
   in
  let onceBfromfirstA_alloc _ =
    ();
    { i_760 = i_760_alloc () (* discrete *)  ;
      i_759 = i_759_alloc () (* discrete *)  } in
  let onceBfromfirstA_reset self  =
    ((i_760_reset self.i_760  ; i_759_reset self.i_759 ):unit) in 
  let onceBfromfirstA_step self ((a_651:MyOp.t) , (b_652:MyOp.t)) =
    (q_or ((i_759_step self.i_759 a_651) ,
           (i_760_step self.i_760 (b_652 , a_651))):MyOp.t) in
  Node { alloc = onceBfromfirstA_alloc; reset = onceBfromfirstA_reset ;
                                        step = onceBfromfirstA_step }
type ('a) _onceBfromA =
  { mutable i_761 : 'a }

let onceBfromA  = 
  let Node { alloc = i_761_alloc; step = i_761_step ; reset = i_761_reset } = onceBfromlastA 
   in
  let onceBfromA_alloc _ =
    ();{ i_761 = i_761_alloc () (* discrete *)  } in
  let onceBfromA_reset self  =
    (i_761_reset self.i_761 :unit) in 
  let onceBfromA_step self ((a_653:MyOp.t) , (b_654:MyOp.t)) =
    (i_761_step self.i_761 (a_653 , b_654):MyOp.t) in
  Node { alloc = onceBfromA_alloc; reset = onceBfromA_reset ;
                                   step = onceBfromA_step }
type ('b , 'a) _alwaysBfromlastA =
  { mutable i_763 : 'b ; mutable i_762 : 'a }

let alwaysBfromlastA  = 
  let Node { alloc = i_763_alloc; step = i_763_step ; reset = i_763_reset } = sincelast 
   in 
  let Node { alloc = i_762_alloc; step = i_762_step ; reset = i_762_reset } = never 
   in
  let alwaysBfromlastA_alloc _ =
    ();
    { i_763 = i_763_alloc () (* discrete *)  ;
      i_762 = i_762_alloc () (* discrete *)  } in
  let alwaysBfromlastA_reset self  =
    ((i_763_reset self.i_763  ; i_762_reset self.i_762 ):unit) in 
  let alwaysBfromlastA_step self ((a_655:MyOp.t) , (b_656:MyOp.t)) =
    (q_or ((i_762_step self.i_762 a_655) ,
           (q_not (i_763_step self.i_763 ((q_not b_656) , a_655)))):MyOp.t) in
  Node { alloc = alwaysBfromlastA_alloc; reset = alwaysBfromlastA_reset ;
                                         step = alwaysBfromlastA_step }
type ('b , 'a) _alwaysBfromfirstA =
  { mutable i_765 : 'b ; mutable i_764 : 'a }

let alwaysBfromfirstA  = 
  let Node { alloc = i_765_alloc; step = i_765_step ; reset = i_765_reset } = sincefirst 
   in 
  let Node { alloc = i_764_alloc; step = i_764_step ; reset = i_764_reset } = never 
   in
  let alwaysBfromfirstA_alloc _ =
    ();
    { i_765 = i_765_alloc () (* discrete *)  ;
      i_764 = i_764_alloc () (* discrete *)  } in
  let alwaysBfromfirstA_reset self  =
    ((i_765_reset self.i_765  ; i_764_reset self.i_764 ):unit) in 
  let alwaysBfromfirstA_step self ((a_657:MyOp.t) , (b_658:MyOp.t)) =
    (q_or ((i_764_step self.i_764 a_657) ,
           (q_not (i_765_step self.i_765 ((q_not b_658) , a_657)))):MyOp.t) in
  Node { alloc = alwaysBfromfirstA_alloc; reset = alwaysBfromfirstA_reset ;
                                          step = alwaysBfromfirstA_step }
type ('a) _alwaysBfromA =
  { mutable i_766 : 'a }

let alwaysBfromA  = 
  let Node { alloc = i_766_alloc; step = i_766_step ; reset = i_766_reset } = alwaysBfromlastA 
   in
  let alwaysBfromA_alloc _ =
    ();{ i_766 = i_766_alloc () (* discrete *)  } in
  let alwaysBfromA_reset self  =
    (i_766_reset self.i_766 :unit) in 
  let alwaysBfromA_step self ((a_659:MyOp.t) , (b_660:MyOp.t)) =
    (i_766_step self.i_766 (a_659 , b_660):MyOp.t) in
  Node { alloc = alwaysBfromA_alloc; reset = alwaysBfromA_reset ;
                                     step = alwaysBfromA_step }
type ('a) _neverBfromlastA =
  { mutable i_767 : 'a }

let neverBfromlastA  = 
  let Node { alloc = i_767_alloc; step = i_767_step ; reset = i_767_reset } = alwaysBfromlastA 
   in
  let neverBfromlastA_alloc _ =
    ();{ i_767 = i_767_alloc () (* discrete *)  } in
  let neverBfromlastA_reset self  =
    (i_767_reset self.i_767 :unit) in 
  let neverBfromlastA_step self ((a_661:MyOp.t) , (b_662:MyOp.t)) =
    (i_767_step self.i_767 (a_661 , (q_not b_662)):MyOp.t) in
  Node { alloc = neverBfromlastA_alloc; reset = neverBfromlastA_reset ;
                                        step = neverBfromlastA_step }
type ('a) _neverBfromfirstA =
  { mutable i_768 : 'a }

let neverBfromfirstA  = 
  let Node { alloc = i_768_alloc; step = i_768_step ; reset = i_768_reset } = alwaysBfromfirstA 
   in
  let neverBfromfirstA_alloc _ =
    ();{ i_768 = i_768_alloc () (* discrete *)  } in
  let neverBfromfirstA_reset self  =
    (i_768_reset self.i_768 :unit) in 
  let neverBfromfirstA_step self ((a_663:MyOp.t) , (b_664:MyOp.t)) =
    (i_768_step self.i_768 (a_663 , (q_not b_664)):MyOp.t) in
  Node { alloc = neverBfromfirstA_alloc; reset = neverBfromfirstA_reset ;
                                         step = neverBfromfirstA_step }
type ('a) _neverBfromA =
  { mutable i_769 : 'a }

let neverBfromA  = 
  let Node { alloc = i_769_alloc; step = i_769_step ; reset = i_769_reset } = neverBfromlastA 
   in
  let neverBfromA_alloc _ =
    ();{ i_769 = i_769_alloc () (* discrete *)  } in
  let neverBfromA_reset self  =
    (i_769_reset self.i_769 :unit) in 
  let neverBfromA_step self ((a_665:MyOp.t) , (b_666:MyOp.t)) =
    (i_769_step self.i_769 (a_665 , b_666):MyOp.t) in
  Node { alloc = neverBfromA_alloc; reset = neverBfromA_reset ;
                                    step = neverBfromA_step }
type ('c , 'b , 'a) _onceBfromlastA_timed =
  { mutable i_772 : 'c ; mutable i_771 : 'b ; mutable i_770 : 'a }

let onceBfromlastA_timed (delay_669:float) = 
  let Node { alloc = i_772_alloc; step = i_772_step ; reset = i_772_reset } = 
  counter delay_669  in 
  let Node { alloc = i_771_alloc; step = i_771_step ; reset = i_771_reset } = onceBfromlastAtoC 
   in 
  let Node { alloc = i_770_alloc; step = i_770_step ; reset = i_770_reset } = never 
   in
  let onceBfromlastA_timed_alloc _ =
    ();
    { i_772 = i_772_alloc () (* discrete *)  ;
      i_771 = i_771_alloc () (* discrete *)  ;
      i_770 = i_770_alloc () (* discrete *)  } in
  let onceBfromlastA_timed_reset self  =
    ((i_772_reset self.i_772  ;
      i_771_reset self.i_771  ; i_770_reset self.i_770 ):unit) in 
  let onceBfromlastA_timed_step self ((tstep_670:MyOp.t) ,
                                      (a_667:MyOp.t) , (b_668:MyOp.t)) =
    ((let resultp_677 = ref (false:bool) in
      let resultv_676 = ref (():unit) in
      let resultp_675 = ref (false:bool) in
      let resultv_674 = ref (():unit) in
      (begin match isTrue a_667 with
             | true -> resultp_677 := true ; resultv_676 := () | _ -> ()  end)
      ;
      (begin match isFalse a_667 with
             | true -> resultp_675 := true ; resultv_674 := () | _ -> ()  end)
      ;
      (let (cpt_671:MyOp.t) =
           i_772_step self.i_772
             (tstep_670 ,
              (!resultv_674 , !resultp_675) , (!resultv_676 , !resultp_677)) in
       q_or ((i_770_step self.i_770 a_667) ,
             (i_771_step self.i_771
                (a_667 , b_668 , (q_lt (cpt_671 , (MyOp.zero ())))))))):
    MyOp.t) in
  Node { alloc = onceBfromlastA_timed_alloc; reset = onceBfromlastA_timed_reset
                                             ;
                                             step = onceBfromlastA_timed_step }
type ('d , 'c , 'b , 'a) _onceBfromfirstA_timed =
  { mutable i_776 : 'd ;
    mutable i_775 : 'c ; mutable i_774 : 'b ; mutable i_773 : 'a }

let onceBfromfirstA_timed (delay_680:float) = 
  let Node { alloc = i_776_alloc; step = i_776_step ; reset = i_776_reset } = once 
   in 
  let Node { alloc = i_775_alloc; step = i_775_step ; reset = i_775_reset } = 
  counter delay_680  in 
  let Node { alloc = i_774_alloc; step = i_774_step ; reset = i_774_reset } = onceBfromfirstAtoC 
   in 
  let Node { alloc = i_773_alloc; step = i_773_step ; reset = i_773_reset } = never 
   in
  let onceBfromfirstA_timed_alloc _ =
    ();
    { i_776 = i_776_alloc () (* discrete *)  ;
      i_775 = i_775_alloc () (* discrete *)  ;
      i_774 = i_774_alloc () (* discrete *)  ;
      i_773 = i_773_alloc () (* discrete *)  } in
  let onceBfromfirstA_timed_reset self  =
    ((i_776_reset self.i_776  ;
      i_775_reset self.i_775  ;
      i_774_reset self.i_774  ; i_773_reset self.i_773 ):unit) in 
  let onceBfromfirstA_timed_step self ((tstep_681:MyOp.t) ,
                                       (a_678:MyOp.t) , (b_679:MyOp.t)) =
    ((let resultp_687 = ref (false:bool) in
      let resultv_686 = ref (():unit) in
      let resultp_685 = ref (false:bool) in
      let resultv_684 = ref (():unit) in
      (begin match false with
             | true -> resultp_687 := true ; resultv_686 := () | _ -> ()  end)
      ;
      (let (p_683:MyOp.t) = i_776_step self.i_776 a_678 in
       (begin match isTrue p_683 with
              | true -> resultp_685 := true ; resultv_684 := () | _ -> ()  end)
       ;
       (let (cpt_682:MyOp.t) =
            i_775_step self.i_775
              (tstep_681 ,
               (!resultv_684 , !resultp_685) , (!resultv_686 , !resultp_687)) in
        q_or ((i_773_step self.i_773 a_678) ,
              (i_774_step self.i_774
                 (a_678 , b_679 , (q_lt (cpt_682 , (MyOp.zero ()))))))))):
    MyOp.t) in
  Node { alloc = onceBfromfirstA_timed_alloc; reset = onceBfromfirstA_timed_reset
                                              ;
                                              step = onceBfromfirstA_timed_step }
type ('a) _onceBfromA_timed =
  { mutable i_777 : 'a }

let onceBfromA_timed (delay_690:float) = 
  let Node { alloc = i_777_alloc; step = i_777_step ; reset = i_777_reset } = 
  onceBfromlastA_timed delay_690  in
  let onceBfromA_timed_alloc _ =
    ();{ i_777 = i_777_alloc () (* discrete *)  } in
  let onceBfromA_timed_reset self  =
    (i_777_reset self.i_777 :unit) in 
  let onceBfromA_timed_step self ((tstep_691:MyOp.t) ,
                                  (a_688:MyOp.t) , (b_689:MyOp.t)) =
    (i_777_step self.i_777 (tstep_691 , a_688 , b_689):MyOp.t) in
  Node { alloc = onceBfromA_timed_alloc; reset = onceBfromA_timed_reset ;
                                         step = onceBfromA_timed_step }
type ('c , 'b , 'a) _alwaysBfromlastA_timed =
  { mutable i_780 : 'c ; mutable i_779 : 'b ; mutable i_778 : 'a }

let alwaysBfromlastA_timed (delay_694:float) = 
  let Node { alloc = i_780_alloc; step = i_780_step ; reset = i_780_reset } = 
  counter delay_694  in 
  let Node { alloc = i_779_alloc; step = i_779_step ; reset = i_779_reset } = sincelast 
   in 
  let Node { alloc = i_778_alloc; step = i_778_step ; reset = i_778_reset } = never 
   in
  let alwaysBfromlastA_timed_alloc _ =
    ();
    { i_780 = i_780_alloc () (* discrete *)  ;
      i_779 = i_779_alloc () (* discrete *)  ;
      i_778 = i_778_alloc () (* discrete *)  } in
  let alwaysBfromlastA_timed_reset self  =
    ((i_780_reset self.i_780  ;
      i_779_reset self.i_779  ; i_778_reset self.i_778 ):unit) in 
  let alwaysBfromlastA_timed_step self ((tstep_695:MyOp.t) ,
                                        (a_692:MyOp.t) , (b_693:MyOp.t)) =
    ((let resultp_702 = ref (false:bool) in
      let resultv_701 = ref (():unit) in
      let resultp_700 = ref (false:bool) in
      let resultv_699 = ref (():unit) in
      (begin match isTrue a_692 with
             | true -> resultp_702 := true ; resultv_701 := () | _ -> ()  end)
      ;
      (begin match isFalse a_692 with
             | true -> resultp_700 := true ; resultv_699 := () | _ -> ()  end)
      ;
      (let (cpt_696:MyOp.t) =
           i_780_step self.i_780
             (tstep_695 ,
              (!resultv_699 , !resultp_700) , (!resultv_701 , !resultp_702)) in
       q_or ((i_778_step self.i_778 a_692) ,
             (implies ((q_gt (cpt_696 , (MyOp.zero ()))) ,
                       (q_not (i_779_step self.i_779 ((q_not b_693) , a_692)))))))):
    MyOp.t) in
  Node { alloc = alwaysBfromlastA_timed_alloc; reset = alwaysBfromlastA_timed_reset
                                               ;
                                               step = alwaysBfromlastA_timed_step }
type ('d , 'c , 'b , 'a) _alwaysBfromfirstA_timed =
  { mutable i_784 : 'd ;
    mutable i_783 : 'c ; mutable i_782 : 'b ; mutable i_781 : 'a }

let alwaysBfromfirstA_timed (delay_705:float) = 
  let Node { alloc = i_784_alloc; step = i_784_step ; reset = i_784_reset } = once 
   in 
  let Node { alloc = i_783_alloc; step = i_783_step ; reset = i_783_reset } = 
  counter delay_705  in 
  let Node { alloc = i_782_alloc; step = i_782_step ; reset = i_782_reset } = sincefirst 
   in 
  let Node { alloc = i_781_alloc; step = i_781_step ; reset = i_781_reset } = never 
   in
  let alwaysBfromfirstA_timed_alloc _ =
    ();
    { i_784 = i_784_alloc () (* discrete *)  ;
      i_783 = i_783_alloc () (* discrete *)  ;
      i_782 = i_782_alloc () (* discrete *)  ;
      i_781 = i_781_alloc () (* discrete *)  } in
  let alwaysBfromfirstA_timed_reset self  =
    ((i_784_reset self.i_784  ;
      i_783_reset self.i_783  ;
      i_782_reset self.i_782  ; i_781_reset self.i_781 ):unit) in 
  let alwaysBfromfirstA_timed_step self ((tstep_706:MyOp.t) ,
                                         (a_703:MyOp.t) , (b_704:MyOp.t)) =
    ((let resultp_712 = ref (false:bool) in
      let resultv_711 = ref (():unit) in
      let resultp_710 = ref (false:bool) in
      let resultv_709 = ref (():unit) in
      (begin match false with
             | true -> resultp_712 := true ; resultv_711 := () | _ -> ()  end)
      ;
      (let (p_708:MyOp.t) = i_784_step self.i_784 a_703 in
       (begin match isTrue p_708 with
              | true -> resultp_710 := true ; resultv_709 := () | _ -> ()  end)
       ;
       (let (cpt_707:MyOp.t) =
            i_783_step self.i_783
              (tstep_706 ,
               (!resultv_709 , !resultp_710) , (!resultv_711 , !resultp_712)) in
        q_or ((i_781_step self.i_781 a_703) ,
              (implies ((q_gt (cpt_707 , (MyOp.zero ()))) ,
                        (q_not (i_782_step self.i_782 ((q_not b_704) , a_703))))))))):
    MyOp.t) in
  Node { alloc = alwaysBfromfirstA_timed_alloc; reset = alwaysBfromfirstA_timed_reset
                                                ;
                                                step = alwaysBfromfirstA_timed_step }
type ('a) _alwaysBfromA_timed =
  { mutable i_785 : 'a }

let alwaysBfromA_timed (delay_715:float) = 
  let Node { alloc = i_785_alloc; step = i_785_step ; reset = i_785_reset } = 
  alwaysBfromlastA_timed delay_715  in
  let alwaysBfromA_timed_alloc _ =
    ();{ i_785 = i_785_alloc () (* discrete *)  } in
  let alwaysBfromA_timed_reset self  =
    (i_785_reset self.i_785 :unit) in 
  let alwaysBfromA_timed_step self ((tstep_716:MyOp.t) ,
                                    (a_713:MyOp.t) , (b_714:MyOp.t)) =
    (i_785_step self.i_785 (tstep_716 , a_713 , b_714):MyOp.t) in
  Node { alloc = alwaysBfromA_timed_alloc; reset = alwaysBfromA_timed_reset ;
                                           step = alwaysBfromA_timed_step }
type ('a) _neverBfromlastA_timed =
  { mutable i_786 : 'a }

let neverBfromlastA_timed (delay_719:float) = 
  let Node { alloc = i_786_alloc; step = i_786_step ; reset = i_786_reset } = 
  alwaysBfromlastA_timed delay_719  in
  let neverBfromlastA_timed_alloc _ =
    ();{ i_786 = i_786_alloc () (* discrete *)  } in
  let neverBfromlastA_timed_reset self  =
    (i_786_reset self.i_786 :unit) in 
  let neverBfromlastA_timed_step self ((tstep_720:MyOp.t) ,
                                       (a_717:MyOp.t) , (b_718:MyOp.t)) =
    (i_786_step self.i_786 (tstep_720 , a_717 , (q_not b_718)):MyOp.t) in
  Node { alloc = neverBfromlastA_timed_alloc; reset = neverBfromlastA_timed_reset
                                              ;
                                              step = neverBfromlastA_timed_step }
type ('a) _neverBfromfirstA_timed =
  { mutable i_787 : 'a }

let neverBfromfirstA_timed (delay_723:float) = 
  let Node { alloc = i_787_alloc; step = i_787_step ; reset = i_787_reset } = 
  alwaysBfromfirstA_timed delay_723  in
  let neverBfromfirstA_timed_alloc _ =
    ();{ i_787 = i_787_alloc () (* discrete *)  } in
  let neverBfromfirstA_timed_reset self  =
    (i_787_reset self.i_787 :unit) in 
  let neverBfromfirstA_timed_step self ((tstep_724:MyOp.t) ,
                                        (a_721:MyOp.t) , (b_722:MyOp.t)) =
    (i_787_step self.i_787 (tstep_724 , a_721 , (q_not b_722)):MyOp.t) in
  Node { alloc = neverBfromfirstA_timed_alloc; reset = neverBfromfirstA_timed_reset
                                               ;
                                               step = neverBfromfirstA_timed_step }
type ('a) _neverBfromA_timed =
  { mutable i_788 : 'a }

let neverBfromA_timed (delay_727:float) = 
  let Node { alloc = i_788_alloc; step = i_788_step ; reset = i_788_reset } = 
  neverBfromlastA_timed delay_727  in
  let neverBfromA_timed_alloc _ =
    ();{ i_788 = i_788_alloc () (* discrete *)  } in
  let neverBfromA_timed_reset self  =
    (i_788_reset self.i_788 :unit) in 
  let neverBfromA_timed_step self ((tstep_728:MyOp.t) ,
                                   (a_725:MyOp.t) , (b_726:MyOp.t)) =
    (i_788_step self.i_788 (tstep_728 , a_725 , b_726):MyOp.t) in
  Node { alloc = neverBfromA_timed_alloc; reset = neverBfromA_timed_reset ;
                                          step = neverBfromA_timed_step }
