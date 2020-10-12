(* The Zélus compiler, version 2.1
  (vendredi 25 septembre 2020, 18:02:26 (UTC+0200)) *)
open Ztypes
type state__5532 = Discrete_obs_fad_Count_240 | Discrete_obs_fad_Stop_239 
open FadFloat
let q_true = FadFloat.infinity

let q_false = FadFloat.neg_infinity

type _no_signal = unit

let no_signal  = 
   let no_signal_alloc _ = () in
  let no_signal_reset self  =
    ((()):unit) in 
  let no_signal_step self () =
    ((let resultp_540 = ref (false:bool) in
      let resultv_539 = ref (():unit) in
      (begin match false with
             | true -> resultp_540 := true ; resultv_539 := () | _ -> ()  end)
      ; (!resultv_539 , !resultp_540)):unit signal) in
  Node { alloc = no_signal_alloc; reset = no_signal_reset ;
                                  step = no_signal_step }
type ('a) _now =
  { mutable m_543 : 'a }

let now  = 
   let now_alloc _ =
     ();{ m_543 = (false:bool) } in
  let now_reset self  =
    (self.m_543 <- true:unit) in 
  let now_step self () =
    ((let resultp_542 = ref (false:bool) in
      let resultv_541 = ref (():unit) in
      let (x_544:bool) = self.m_543 in
      self.m_543 <- false ;
      (begin match x_544 with
             | true -> resultp_542 := true ; resultv_541 := () | _ -> ()  end)
      ; (!resultv_541 , !resultp_542)):unit signal) in
  Node { alloc = now_alloc; reset = now_reset ; step = now_step }
let isTrue (p_545:FadFloat.t) =
  (>=) p_545  (FadFloat.make 0.)

let isFalse (p_546:FadFloat.t) =
  (<) p_546  (FadFloat.make 0.)

let q_istrue (p_547:FadFloat.t) =
  let resultp_549 = ref (false:bool) in
  let resultv_548 = ref (():unit) in
  (begin match isTrue p_547 with
         | true -> resultp_549 := true ; resultv_548 := () | _ -> ()  end) ;
  (!resultv_548 , !resultp_549)

let q_isfalse (p_550:FadFloat.t) =
  let resultp_552 = ref (false:bool) in
  let resultv_551 = ref (():unit) in
  (begin match isFalse p_550 with
         | true -> resultp_552 := true ; resultv_551 := () | _ -> ()  end) ;
  (!resultv_551 , !resultp_552)

let q_aretrue2 ((p_553:FadFloat.t) , (s_554:FadFloat.t)) =
  let resultp_556 = ref (false:bool) in
  let resultv_555 = ref (():unit) in
  (begin match ((isTrue s_554) ,
                (isTrue p_553) , (isTrue p_553) , (isTrue s_554)) with
         | (_ , _ , true , true) | (true , true , _ , _) ->
             resultp_556 := true ; resultv_555 := () | _ -> ()  end) ;
  (!resultv_555 , !resultp_556)

type ('b , 'a) _freeze =
  { mutable i_559 : 'b ; mutable res_558 : 'a }

let freeze  = 
  
  let freeze_alloc _ =
    ();{ i_559 = (false:bool) ; res_558 = (Obj.magic ():'a) } in
  let freeze_reset self  =
    (self.i_559 <- true:unit) in 
  let freeze_step self (p_557:'a4696) =
    (((if self.i_559 then self.res_558 <- p_557) ;
      self.i_559 <- false ; self.res_558):'a) in
  Node { alloc = freeze_alloc; reset = freeze_reset ; step = freeze_step }
type ('a) _q_istrue_now =
  { mutable i_852 : 'a }

let q_istrue_now  = 
  let Node { alloc = i_852_alloc; step = i_852_step ; reset = i_852_reset } = freeze 
   in
  let q_istrue_now_alloc _ =
    ();{ i_852 = i_852_alloc () (* discrete *)  } in
  let q_istrue_now_reset self  =
    (i_852_reset self.i_852 :unit) in 
  let q_istrue_now_step self (p_560:FadFloat.t) =
    ((let resultp_563 = ref (false:bool) in
      let resultv_562 = ref (():unit) in
      (begin match isTrue p_560 with
             | true -> resultp_563 := true ; resultv_562 := () | _ -> ()  end)
      ; i_852_step self.i_852 (!resultv_562 , !resultp_563)):unit signal) in
  Node { alloc = q_istrue_now_alloc; reset = q_istrue_now_reset ;
                                     step = q_istrue_now_step }
type ('a) _q_isfalse_now =
  { mutable i_853 : 'a }

let q_isfalse_now  = 
  let Node { alloc = i_853_alloc; step = i_853_step ; reset = i_853_reset } = freeze 
   in
  let q_isfalse_now_alloc _ =
    ();{ i_853 = i_853_alloc () (* discrete *)  } in
  let q_isfalse_now_reset self  =
    (i_853_reset self.i_853 :unit) in 
  let q_isfalse_now_step self (p_564:FadFloat.t) =
    ((let resultp_567 = ref (false:bool) in
      let resultv_566 = ref (():unit) in
      (begin match isFalse p_564 with
             | true -> resultp_567 := true ; resultv_566 := () | _ -> ()  end)
      ; i_853_step self.i_853 (!resultv_566 , !resultp_567)):unit signal) in
  Node { alloc = q_isfalse_now_alloc; reset = q_isfalse_now_reset ;
                                      step = q_isfalse_now_step }
let q_gt ((p1_568:FadFloat.t) , (p2_569:FadFloat.t)) =
  FadFloat.(-) p1_568  p2_569

let q_ge ((p1_570:FadFloat.t) , (p2_571:FadFloat.t)) =
  FadFloat.(-) p1_570  p2_571

let q_lt ((p1_572:FadFloat.t) , (p2_573:FadFloat.t)) =
  FadFloat.(-) p2_573  p1_572

let q_le ((p1_574:FadFloat.t) , (p2_575:FadFloat.t)) =
  FadFloat.(-) p2_575  p1_574

let q_not (p_576:FadFloat.t) =
  FadFloat.(~-) p_576

let q_or ((p1_577:FadFloat.t) , (p2_578:FadFloat.t)) =
  FadFloat.max p1_577  p2_578

let q_and ((p1_579:FadFloat.t) , (p2_580:FadFloat.t)) =
  FadFloat.min p1_579  p2_580

let abs (x1_581:FadFloat.t) =
  FadFloat.max x1_581  (FadFloat.(~-) x1_581)

let q_eq (precision_582:FadFloat.t) 
         ((x1_583:FadFloat.t) , (x2_584:FadFloat.t)) =
  FadFloat.(-) precision_582  (abs (FadFloat.(-) x1_583  x2_584))

let q_eqi ((i1_585:FadFloat.t) , (i2_586:FadFloat.t)) =
  FadFloat.(-) (FadFloat.make 0.5)  (abs (FadFloat.(-) i1_585  i2_586))

let implies ((a_587:FadFloat.t) , (b_588:FadFloat.t)) =
  q_or ((q_not a_587) , b_588)

type ('b , 'a) _q_up =
  { mutable i_593 : 'b ; mutable m_590 : 'a }

let q_up  = 
  
  let q_up_alloc _ =
    ();{ i_593 = (false:bool) ; m_590 = (create ():FadFloat.t) } in
  let q_up_reset self  =
    (self.i_593 <- true:unit) in 
  let q_up_step self (p_589:FadFloat.t) =
    ((let (x_592:FadFloat.t) =
          if self.i_593
          then p_589
          else
            q_and ((q_lt (self.m_590 , (FadFloat.zero ()))) ,
                   (q_gt (p_589 , (FadFloat.zero ())))) in
      self.i_593 <- false ; self.m_590 <- p_589 ; x_592):FadFloat.t) in
  Node { alloc = q_up_alloc; reset = q_up_reset ; step = q_up_step }
type ('b , 'a) _b_up =
  { mutable i_598 : 'b ; mutable m_595 : 'a }

let b_up  = 
   let b_up_alloc _ =
     ();{ i_598 = (false:bool) ; m_595 = (false:bool) } in
  let b_up_reset self  =
    (self.i_598 <- true:unit) in 
  let b_up_step self (p_594:bool) =
    ((let (x_597:bool) =
          if self.i_598 then p_594 else (&&) (not self.m_595)  p_594 in
      self.i_598 <- false ; self.m_595 <- p_594 ; x_597):bool) in
  Node { alloc = b_up_alloc; reset = b_up_reset ; step = b_up_step }
let min_cpt = (-1.)

type ('e , 'd , 'c , 'b , 'a) _counter =
  { mutable r_607 : 'e ;
    mutable s_606 : 'd ;
    mutable cpt_605 : 'c ; mutable i_611 : 'b ; mutable m_608 : 'a }

let counter (delay_599:float) = 
  
  let counter_alloc _ =
    ();
    { r_607 = (false:bool) ;
      s_606 = (Discrete_obs_fad_Count_240:state__5532) ;
      cpt_605 = (create ():FadFloat.t) ;
      i_611 = (false:bool) ; m_608 = (create ():FadFloat.t) } in
  let counter_reset self  =
    ((self.r_607 <- false ;
      self.s_606 <- Discrete_obs_fad_Stop_239 ; self.i_611 <- true):unit) in 
  let counter_step self ((tstep_600:FadFloat.t) ,
                         ((strtv_603:unit) , (strtp_604:bool)) ,
                         ((rstv_601:unit) , (rstp_602:bool))) =
    (((begin match self.s_606 with
             | Discrete_obs_fad_Stop_239 ->
                 (if self.r_607 then ()) ;
                 self.cpt_605 <- FadFloat.make delay_599 ;
                 (begin match (strtv_603 , strtp_604) with
                        | (() , true) ->
                            self.r_607 <- true ;
                            self.s_606 <- Discrete_obs_fad_Count_240
                        | _ -> self.r_607 <- false  end)
             | Discrete_obs_fad_Count_240 ->
                 (if self.r_607 then self.i_611 <- true) ;
                 (let (x_610:FadFloat.t) =
                      if self.i_611
                      then FadFloat.make delay_599
                      else FadFloat.(-) self.m_608  tstep_600 in
                  self.i_611 <- false ;
                  self.cpt_605 <- x_610 ;
                  self.m_608 <- x_610 ;
                  (begin match (rstv_601 , rstp_602) with
                         | (() , true) ->
                             self.r_607 <- true ;
                             self.s_606 <- Discrete_obs_fad_Stop_239
                         | _ -> self.r_607 <- false  end))
              end) ; self.cpt_605):FadFloat.t) in
  Node { alloc = counter_alloc; reset = counter_reset ; step = counter_step }
type ('b , 'a) _always =
  { mutable i_617 : 'b ; mutable m_614 : 'a }

let always  = 
  
  let always_alloc _ =
    ();{ i_617 = (false:bool) ; m_614 = (create ():FadFloat.t) } in
  let always_reset self  =
    (self.i_617 <- true:unit) in 
  let always_step self (p_612:FadFloat.t) =
    ((let (x_616:FadFloat.t) =
          if self.i_617 then p_612 else q_and (self.m_614 , p_612) in
      self.i_617 <- false ; self.m_614 <- x_616 ; x_616):FadFloat.t) in
  Node { alloc = always_alloc; reset = always_reset ; step = always_step }
type ('a) _never =
  { mutable i_854 : 'a }

let never  = 
  let Node { alloc = i_854_alloc; step = i_854_step ; reset = i_854_reset } = always 
   in let never_alloc _ =
        ();{ i_854 = i_854_alloc () (* discrete *)  } in
  let never_reset self  =
    (i_854_reset self.i_854 :unit) in 
  let never_step self (p_618:FadFloat.t) =
    (i_854_step self.i_854 (q_not p_618):FadFloat.t) in
  Node { alloc = never_alloc; reset = never_reset ; step = never_step }
type ('b , 'a) _once =
  { mutable i_624 : 'b ; mutable m_621 : 'a }

let once  = 
  
  let once_alloc _ =
    ();{ i_624 = (false:bool) ; m_621 = (create ():FadFloat.t) } in
  let once_reset self  =
    (self.i_624 <- true:unit) in 
  let once_step self (p_619:FadFloat.t) =
    ((let (x_623:FadFloat.t) =
          if self.i_624 then p_619 else q_or (self.m_621 , p_619) in
      self.i_624 <- false ; self.m_621 <- x_623 ; x_623):FadFloat.t) in
  Node { alloc = once_alloc; reset = once_reset ; step = once_step }
type ('d , 'c , 'b , 'a) _sincefirst =
  { mutable i_855 : 'd ;
    mutable i_636 : 'c ; mutable m_632 : 'b ; mutable m_629 : 'a }

let sincefirst  = 
  let Node { alloc = i_855_alloc; step = i_855_step ; reset = i_855_reset } = never 
   in
  let sincefirst_alloc _ =
    ();
    { i_636 = (false:bool) ;
      m_632 = (create ():FadFloat.t) ; m_629 = (create ():FadFloat.t);
      i_855 = i_855_alloc () (* discrete *)  } in
  let sincefirst_reset self  =
    ((self.i_636 <- true ; i_855_reset self.i_855 ):unit) in 
  let sincefirst_step self ((x_625:FadFloat.t) , (y_626:FadFloat.t)) =
    ((let (x_634:FadFloat.t) = q_or (self.m_632 , x_625) in
      let (x_631:FadFloat.t) =
          if self.i_636 then y_626 else q_and (self.m_629 , y_626) in
      let (x_635:FadFloat.t) =
          if self.i_636
          then q_true
          else if isTrue x_631 then x_625 else x_634 in
      self.i_636 <- false ;
      self.m_632 <- x_635 ; self.m_629 <- i_855_step self.i_855 y_626 ; x_635):
    FadFloat.t) in
  Node { alloc = sincefirst_alloc; reset = sincefirst_reset ;
                                   step = sincefirst_step }
type ('b , 'a) _sincelast =
  { mutable i_644 : 'b ; mutable m_640 : 'a }

let sincelast  = 
  
  let sincelast_alloc _ =
    ();{ i_644 = (false:bool) ; m_640 = (create ():FadFloat.t) } in
  let sincelast_reset self  =
    (self.i_644 <- true:unit) in 
  let sincelast_step self ((x_637:FadFloat.t) , (y_638:FadFloat.t)) =
    ((let (x_642:FadFloat.t) = q_or (self.m_640 , x_637) in
      let (x_643:FadFloat.t) =
          if self.i_644
          then q_true
          else if isTrue y_638 then x_637 else x_642 in
      self.i_644 <- false ; self.m_640 <- x_643 ; x_643):FadFloat.t) in
  Node { alloc = sincelast_alloc; reset = sincelast_reset ;
                                  step = sincelast_step }
type ('a) _since =
  { mutable i_856 : 'a }

let since  = 
  let Node { alloc = i_856_alloc; step = i_856_step ; reset = i_856_reset } = sincelast 
   in let since_alloc _ =
        ();{ i_856 = i_856_alloc () (* discrete *)  } in
  let since_reset self  =
    (i_856_reset self.i_856 :unit) in 
  let since_step self ((x_645:FadFloat.t) , (y_646:FadFloat.t)) =
    (i_856_step self.i_856 (x_645 , y_646):FadFloat.t) in
  Node { alloc = since_alloc; reset = since_reset ; step = since_step }
type ('b , 'a) _onceBfromlastAtoC =
  { mutable i_858 : 'b ; mutable i_857 : 'a }

let onceBfromlastAtoC  = 
  let Node { alloc = i_858_alloc; step = i_858_step ; reset = i_858_reset } = sincelast 
   in 
  let Node { alloc = i_857_alloc; step = i_857_step ; reset = i_857_reset } = never 
   in
  let onceBfromlastAtoC_alloc _ =
    ();
    { i_858 = i_858_alloc () (* discrete *)  ;
      i_857 = i_857_alloc () (* discrete *)  } in
  let onceBfromlastAtoC_reset self  =
    ((i_858_reset self.i_858  ; i_857_reset self.i_857 ):unit) in 
  let onceBfromlastAtoC_step self ((a_647:FadFloat.t) ,
                                   (b_648:FadFloat.t) , (c_649:FadFloat.t)) =
    (implies (c_649 ,
              (q_or ((i_857_step self.i_857 a_647) ,
                     (i_858_step self.i_858 (b_648 , a_647))))):FadFloat.t) in
  Node { alloc = onceBfromlastAtoC_alloc; reset = onceBfromlastAtoC_reset ;
                                          step = onceBfromlastAtoC_step }
type ('b , 'a) _onceBfromfirstAtoC =
  { mutable i_860 : 'b ; mutable i_859 : 'a }

let onceBfromfirstAtoC  = 
  let Node { alloc = i_860_alloc; step = i_860_step ; reset = i_860_reset } = sincefirst 
   in 
  let Node { alloc = i_859_alloc; step = i_859_step ; reset = i_859_reset } = never 
   in
  let onceBfromfirstAtoC_alloc _ =
    ();
    { i_860 = i_860_alloc () (* discrete *)  ;
      i_859 = i_859_alloc () (* discrete *)  } in
  let onceBfromfirstAtoC_reset self  =
    ((i_860_reset self.i_860  ; i_859_reset self.i_859 ):unit) in 
  let onceBfromfirstAtoC_step self ((a_650:FadFloat.t) ,
                                    (b_651:FadFloat.t) , (c_652:FadFloat.t)) =
    (implies (c_652 ,
              (q_or ((i_859_step self.i_859 a_650) ,
                     (i_860_step self.i_860 (b_651 , a_650))))):FadFloat.t) in
  Node { alloc = onceBfromfirstAtoC_alloc; reset = onceBfromfirstAtoC_reset ;
                                           step = onceBfromfirstAtoC_step }
type ('a) _onceBfromAtoC =
  { mutable i_861 : 'a }

let onceBfromAtoC  = 
  let Node { alloc = i_861_alloc; step = i_861_step ; reset = i_861_reset } = onceBfromlastAtoC 
   in
  let onceBfromAtoC_alloc _ =
    ();{ i_861 = i_861_alloc () (* discrete *)  } in
  let onceBfromAtoC_reset self  =
    (i_861_reset self.i_861 :unit) in 
  let onceBfromAtoC_step self ((a_653:FadFloat.t) ,
                               (b_654:FadFloat.t) , (c_655:FadFloat.t)) =
    (i_861_step self.i_861 (a_653 , b_654 , c_655):FadFloat.t) in
  Node { alloc = onceBfromAtoC_alloc; reset = onceBfromAtoC_reset ;
                                      step = onceBfromAtoC_step }
type ('b , 'a) _alwaysBfromlastAtoC =
  { mutable i_863 : 'b ; mutable i_862 : 'a }

let alwaysBfromlastAtoC  = 
  let Node { alloc = i_863_alloc; step = i_863_step ; reset = i_863_reset } = sincelast 
   in 
  let Node { alloc = i_862_alloc; step = i_862_step ; reset = i_862_reset } = never 
   in
  let alwaysBfromlastAtoC_alloc _ =
    ();
    { i_863 = i_863_alloc () (* discrete *)  ;
      i_862 = i_862_alloc () (* discrete *)  } in
  let alwaysBfromlastAtoC_reset self  =
    ((i_863_reset self.i_863  ; i_862_reset self.i_862 ):unit) in 
  let alwaysBfromlastAtoC_step self ((a_656:FadFloat.t) ,
                                     (b_657:FadFloat.t) , (c_658:FadFloat.t)) =
    (implies (c_658 ,
              (q_or ((i_862_step self.i_862 a_656) ,
                     (q_not (i_863_step self.i_863 ((q_not b_657) , a_656)))))):
    FadFloat.t) in
  Node { alloc = alwaysBfromlastAtoC_alloc; reset = alwaysBfromlastAtoC_reset
                                            ; step = alwaysBfromlastAtoC_step }
type ('b , 'a) _alwaysBfromfirstAtoC =
  { mutable i_865 : 'b ; mutable i_864 : 'a }

let alwaysBfromfirstAtoC  = 
  let Node { alloc = i_865_alloc; step = i_865_step ; reset = i_865_reset } = sincefirst 
   in 
  let Node { alloc = i_864_alloc; step = i_864_step ; reset = i_864_reset } = never 
   in
  let alwaysBfromfirstAtoC_alloc _ =
    ();
    { i_865 = i_865_alloc () (* discrete *)  ;
      i_864 = i_864_alloc () (* discrete *)  } in
  let alwaysBfromfirstAtoC_reset self  =
    ((i_865_reset self.i_865  ; i_864_reset self.i_864 ):unit) in 
  let alwaysBfromfirstAtoC_step self ((a_659:FadFloat.t) ,
                                      (b_660:FadFloat.t) , (c_661:FadFloat.t)) =
    (implies (c_661 ,
              (q_or ((i_864_step self.i_864 a_659) ,
                     (q_not (i_865_step self.i_865 ((q_not b_660) , a_659)))))):
    FadFloat.t) in
  Node { alloc = alwaysBfromfirstAtoC_alloc; reset = alwaysBfromfirstAtoC_reset
                                             ;
                                             step = alwaysBfromfirstAtoC_step }
type ('a) _alwaysBfromAtoC =
  { mutable i_866 : 'a }

let alwaysBfromAtoC  = 
  let Node { alloc = i_866_alloc; step = i_866_step ; reset = i_866_reset } = alwaysBfromlastAtoC 
   in
  let alwaysBfromAtoC_alloc _ =
    ();{ i_866 = i_866_alloc () (* discrete *)  } in
  let alwaysBfromAtoC_reset self  =
    (i_866_reset self.i_866 :unit) in 
  let alwaysBfromAtoC_step self ((a_662:FadFloat.t) ,
                                 (b_663:FadFloat.t) , (c_664:FadFloat.t)) =
    (i_866_step self.i_866 (a_662 , b_663 , c_664):FadFloat.t) in
  Node { alloc = alwaysBfromAtoC_alloc; reset = alwaysBfromAtoC_reset ;
                                        step = alwaysBfromAtoC_step }
type ('a) _neverBfromlastAtoC =
  { mutable i_867 : 'a }

let neverBfromlastAtoC  = 
  let Node { alloc = i_867_alloc; step = i_867_step ; reset = i_867_reset } = alwaysBfromlastAtoC 
   in
  let neverBfromlastAtoC_alloc _ =
    ();{ i_867 = i_867_alloc () (* discrete *)  } in
  let neverBfromlastAtoC_reset self  =
    (i_867_reset self.i_867 :unit) in 
  let neverBfromlastAtoC_step self ((a_665:FadFloat.t) ,
                                    (b_666:FadFloat.t) , (c_667:FadFloat.t)) =
    (i_867_step self.i_867 (a_665 , (q_not b_666) , c_667):FadFloat.t) in
  Node { alloc = neverBfromlastAtoC_alloc; reset = neverBfromlastAtoC_reset ;
                                           step = neverBfromlastAtoC_step }
type ('a) _neverBfromfirstAtoC =
  { mutable i_868 : 'a }

let neverBfromfirstAtoC  = 
  let Node { alloc = i_868_alloc; step = i_868_step ; reset = i_868_reset } = alwaysBfromfirstAtoC 
   in
  let neverBfromfirstAtoC_alloc _ =
    ();{ i_868 = i_868_alloc () (* discrete *)  } in
  let neverBfromfirstAtoC_reset self  =
    (i_868_reset self.i_868 :unit) in 
  let neverBfromfirstAtoC_step self ((a_668:FadFloat.t) ,
                                     (b_669:FadFloat.t) , (c_670:FadFloat.t)) =
    (i_868_step self.i_868 (a_668 , (q_not b_669) , c_670):FadFloat.t) in
  Node { alloc = neverBfromfirstAtoC_alloc; reset = neverBfromfirstAtoC_reset
                                            ; step = neverBfromfirstAtoC_step }
type ('a) _neverBfromAtoC =
  { mutable i_869 : 'a }

let neverBfromAtoC  = 
  let Node { alloc = i_869_alloc; step = i_869_step ; reset = i_869_reset } = alwaysBfromAtoC 
   in
  let neverBfromAtoC_alloc _ =
    ();{ i_869 = i_869_alloc () (* discrete *)  } in
  let neverBfromAtoC_reset self  =
    (i_869_reset self.i_869 :unit) in 
  let neverBfromAtoC_step self ((a_671:FadFloat.t) ,
                                (b_672:FadFloat.t) , (c_673:FadFloat.t)) =
    (i_869_step self.i_869 (a_671 , (q_not b_672) , c_673):FadFloat.t) in
  Node { alloc = neverBfromAtoC_alloc; reset = neverBfromAtoC_reset ;
                                       step = neverBfromAtoC_step }
type ('b , 'a) _horizon =
  { mutable i_870 : 'b ; mutable m_681 : 'a }

let horizon (delay_674:float) = 
  let Node { alloc = i_870_alloc; step = i_870_step ; reset = i_870_reset } = 
  counter delay_674  in
  let horizon_alloc _ =
    ();{ m_681 = (false:bool);i_870 = i_870_alloc () (* discrete *)  } in
  let horizon_reset self  =
    ((self.m_681 <- true ; i_870_reset self.i_870 ):unit) in 
  let horizon_step self (tstep_675:FadFloat.t) =
    ((let resultp_680 = ref (false:bool) in
      let resultv_679 = ref (():unit) in
      let resultp_678 = ref (false:bool) in
      let resultv_677 = ref (():unit) in
      let (x_682:bool) = self.m_681 in
      self.m_681 <- false ;
      (begin match false with
             | true -> resultp_680 := true ; resultv_679 := () | _ -> ()  end)
      ;
      (begin match x_682 with
             | true -> resultp_678 := true ; resultv_677 := () | _ -> ()  end)
      ;
      (let (cpt_676:FadFloat.t) =
           i_870_step self.i_870
             (tstep_675 ,
              (!resultv_677 , !resultp_678) , (!resultv_679 , !resultp_680)) in
       q_lt (cpt_676 , (FadFloat.zero ())))):FadFloat.t) in
  Node { alloc = horizon_alloc; reset = horizon_reset ; step = horizon_step }
type ('e , 'd , 'c , 'b , 'a) _once_timed =
  { mutable i_872 : 'e ;
    mutable i_871 : 'd ;
    mutable i_699 : 'c ; mutable m_694 : 'b ; mutable m_692 : 'a }

let once_timed (delay_683:float) = 
  let Node { alloc = i_872_alloc; step = i_872_step ; reset = i_872_reset } = 
  counter delay_683  in 
  let Node { alloc = i_871_alloc; step = i_871_step ; reset = i_871_reset } = once 
   in
  let once_timed_alloc _ =
    ();
    { i_699 = (false:bool) ;
      m_694 = (create ():FadFloat.t) ; m_692 = (false:bool);
      i_872 = i_872_alloc () (* discrete *)  ;
      i_871 = i_871_alloc () (* discrete *)  } in
  let once_timed_reset self  =
    ((self.i_699 <- true ;
      self.m_692 <- true ; i_872_reset self.i_872  ; i_871_reset self.i_871 ):
    unit) in 
  let once_timed_step self ((tstep_685:FadFloat.t) , (p_684:FadFloat.t)) =
    ((let resultp_691 = ref (false:bool) in
      let resultv_690 = ref (():unit) in
      let resultp_689 = ref (false:bool) in
      let resultv_688 = ref (():unit) in
      (begin match false with
             | true -> resultp_691 := true ; resultv_690 := () | _ -> ()  end)
      ;
      (let (x_693:bool) = self.m_692 in
       (begin match x_693 with
              | true -> resultp_689 := true ; resultv_688 := () | _ -> ()  end)
       ;
       (let (cpt_686:FadFloat.t) =
            i_872_step self.i_872
              (tstep_685 ,
               (!resultv_688 , !resultp_689) , (!resultv_690 , !resultp_691)) in
        let (x_696:FadFloat.t) = i_871_step self.i_871 p_684 in
        let (x_698:FadFloat.t) =
            if self.i_699
            then p_684
            else
              if (<) cpt_686  (FadFloat.make 0.) then self.m_694 else x_696 in
        self.i_699 <- false ;
        self.m_692 <- false ; self.m_694 <- x_698 ; x_698))):FadFloat.t) in
  Node { alloc = once_timed_alloc; reset = once_timed_reset ;
                                   step = once_timed_step }
type ('e , 'd , 'c , 'b , 'a) _always_timed =
  { mutable i_874 : 'e ;
    mutable i_873 : 'd ;
    mutable i_716 : 'c ; mutable m_711 : 'b ; mutable m_709 : 'a }

let always_timed (delay_700:float) = 
  let Node { alloc = i_874_alloc; step = i_874_step ; reset = i_874_reset } = 
  counter delay_700  in 
  let Node { alloc = i_873_alloc; step = i_873_step ; reset = i_873_reset } = always 
   in
  let always_timed_alloc _ =
    ();
    { i_716 = (false:bool) ;
      m_711 = (create ():FadFloat.t) ; m_709 = (false:bool);
      i_874 = i_874_alloc () (* discrete *)  ;
      i_873 = i_873_alloc () (* discrete *)  } in
  let always_timed_reset self  =
    ((self.i_716 <- true ;
      self.m_709 <- true ; i_874_reset self.i_874  ; i_873_reset self.i_873 ):
    unit) in 
  let always_timed_step self ((tstep_702:FadFloat.t) , (p_701:FadFloat.t)) =
    ((let resultp_708 = ref (false:bool) in
      let resultv_707 = ref (():unit) in
      let resultp_706 = ref (false:bool) in
      let resultv_705 = ref (():unit) in
      (begin match false with
             | true -> resultp_708 := true ; resultv_707 := () | _ -> ()  end)
      ;
      (let (x_710:bool) = self.m_709 in
       (begin match x_710 with
              | true -> resultp_706 := true ; resultv_705 := () | _ -> ()  end)
       ;
       (let (cpt_703:FadFloat.t) =
            i_874_step self.i_874
              (tstep_702 ,
               (!resultv_705 , !resultp_706) , (!resultv_707 , !resultp_708)) in
        let (x_713:FadFloat.t) = i_873_step self.i_873 p_701 in
        let (x_715:FadFloat.t) =
            if self.i_716
            then p_701
            else
              if (<) cpt_703  (FadFloat.make 0.) then self.m_711 else x_713 in
        self.i_716 <- false ;
        self.m_709 <- false ; self.m_711 <- x_715 ; x_715))):FadFloat.t) in
  Node { alloc = always_timed_alloc; reset = always_timed_reset ;
                                     step = always_timed_step }
type ('a) _never_timed =
  { mutable i_875 : 'a }

let never_timed (delay_717:float) = 
  let Node { alloc = i_875_alloc; step = i_875_step ; reset = i_875_reset } = 
  always_timed delay_717  in
  let never_timed_alloc _ =
    ();{ i_875 = i_875_alloc () (* discrete *)  } in
  let never_timed_reset self  =
    (i_875_reset self.i_875 :unit) in 
  let never_timed_step self ((tstep_719:FadFloat.t) , (p_718:FadFloat.t)) =
    (i_875_step self.i_875 (tstep_719 , (q_not p_718)):FadFloat.t) in
  Node { alloc = never_timed_alloc; reset = never_timed_reset ;
                                    step = never_timed_step }
type ('b , 'a) _onceBfromlastA =
  { mutable i_877 : 'b ; mutable i_876 : 'a }

let onceBfromlastA  = 
  let Node { alloc = i_877_alloc; step = i_877_step ; reset = i_877_reset } = sincelast 
   in 
  let Node { alloc = i_876_alloc; step = i_876_step ; reset = i_876_reset } = never 
   in
  let onceBfromlastA_alloc _ =
    ();
    { i_877 = i_877_alloc () (* discrete *)  ;
      i_876 = i_876_alloc () (* discrete *)  } in
  let onceBfromlastA_reset self  =
    ((i_877_reset self.i_877  ; i_876_reset self.i_876 ):unit) in 
  let onceBfromlastA_step self ((a_720:FadFloat.t) , (b_721:FadFloat.t)) =
    (q_or ((i_876_step self.i_876 a_720) ,
           (i_877_step self.i_877 (b_721 , a_720))):FadFloat.t) in
  Node { alloc = onceBfromlastA_alloc; reset = onceBfromlastA_reset ;
                                       step = onceBfromlastA_step }
type ('b , 'a) _onceBfromfirstA =
  { mutable i_879 : 'b ; mutable i_878 : 'a }

let onceBfromfirstA  = 
  let Node { alloc = i_879_alloc; step = i_879_step ; reset = i_879_reset } = sincefirst 
   in 
  let Node { alloc = i_878_alloc; step = i_878_step ; reset = i_878_reset } = never 
   in
  let onceBfromfirstA_alloc _ =
    ();
    { i_879 = i_879_alloc () (* discrete *)  ;
      i_878 = i_878_alloc () (* discrete *)  } in
  let onceBfromfirstA_reset self  =
    ((i_879_reset self.i_879  ; i_878_reset self.i_878 ):unit) in 
  let onceBfromfirstA_step self ((a_722:FadFloat.t) , (b_723:FadFloat.t)) =
    (q_or ((i_878_step self.i_878 a_722) ,
           (i_879_step self.i_879 (b_723 , a_722))):FadFloat.t) in
  Node { alloc = onceBfromfirstA_alloc; reset = onceBfromfirstA_reset ;
                                        step = onceBfromfirstA_step }
type ('a) _onceBfromA =
  { mutable i_880 : 'a }

let onceBfromA  = 
  let Node { alloc = i_880_alloc; step = i_880_step ; reset = i_880_reset } = onceBfromlastA 
   in
  let onceBfromA_alloc _ =
    ();{ i_880 = i_880_alloc () (* discrete *)  } in
  let onceBfromA_reset self  =
    (i_880_reset self.i_880 :unit) in 
  let onceBfromA_step self ((a_724:FadFloat.t) , (b_725:FadFloat.t)) =
    (i_880_step self.i_880 (a_724 , b_725):FadFloat.t) in
  Node { alloc = onceBfromA_alloc; reset = onceBfromA_reset ;
                                   step = onceBfromA_step }
type ('b , 'a) _alwaysBfromlastA =
  { mutable i_882 : 'b ; mutable i_881 : 'a }

let alwaysBfromlastA  = 
  let Node { alloc = i_882_alloc; step = i_882_step ; reset = i_882_reset } = sincelast 
   in 
  let Node { alloc = i_881_alloc; step = i_881_step ; reset = i_881_reset } = never 
   in
  let alwaysBfromlastA_alloc _ =
    ();
    { i_882 = i_882_alloc () (* discrete *)  ;
      i_881 = i_881_alloc () (* discrete *)  } in
  let alwaysBfromlastA_reset self  =
    ((i_882_reset self.i_882  ; i_881_reset self.i_881 ):unit) in 
  let alwaysBfromlastA_step self ((a_726:FadFloat.t) , (b_727:FadFloat.t)) =
    (q_or ((i_881_step self.i_881 a_726) ,
           (q_not (i_882_step self.i_882 ((q_not b_727) , a_726)))):FadFloat.t) in
  Node { alloc = alwaysBfromlastA_alloc; reset = alwaysBfromlastA_reset ;
                                         step = alwaysBfromlastA_step }
type ('b , 'a) _alwaysBfromfirstA =
  { mutable i_884 : 'b ; mutable i_883 : 'a }

let alwaysBfromfirstA  = 
  let Node { alloc = i_884_alloc; step = i_884_step ; reset = i_884_reset } = sincefirst 
   in 
  let Node { alloc = i_883_alloc; step = i_883_step ; reset = i_883_reset } = never 
   in
  let alwaysBfromfirstA_alloc _ =
    ();
    { i_884 = i_884_alloc () (* discrete *)  ;
      i_883 = i_883_alloc () (* discrete *)  } in
  let alwaysBfromfirstA_reset self  =
    ((i_884_reset self.i_884  ; i_883_reset self.i_883 ):unit) in 
  let alwaysBfromfirstA_step self ((a_728:FadFloat.t) , (b_729:FadFloat.t)) =
    (q_or ((i_883_step self.i_883 a_728) ,
           (q_not (i_884_step self.i_884 ((q_not b_729) , a_728)))):FadFloat.t) in
  Node { alloc = alwaysBfromfirstA_alloc; reset = alwaysBfromfirstA_reset ;
                                          step = alwaysBfromfirstA_step }
type ('a) _alwaysBfromA =
  { mutable i_885 : 'a }

let alwaysBfromA  = 
  let Node { alloc = i_885_alloc; step = i_885_step ; reset = i_885_reset } = alwaysBfromlastA 
   in
  let alwaysBfromA_alloc _ =
    ();{ i_885 = i_885_alloc () (* discrete *)  } in
  let alwaysBfromA_reset self  =
    (i_885_reset self.i_885 :unit) in 
  let alwaysBfromA_step self ((a_730:FadFloat.t) , (b_731:FadFloat.t)) =
    (i_885_step self.i_885 (a_730 , b_731):FadFloat.t) in
  Node { alloc = alwaysBfromA_alloc; reset = alwaysBfromA_reset ;
                                     step = alwaysBfromA_step }
type ('a) _neverBfromlastA =
  { mutable i_886 : 'a }

let neverBfromlastA  = 
  let Node { alloc = i_886_alloc; step = i_886_step ; reset = i_886_reset } = alwaysBfromlastA 
   in
  let neverBfromlastA_alloc _ =
    ();{ i_886 = i_886_alloc () (* discrete *)  } in
  let neverBfromlastA_reset self  =
    (i_886_reset self.i_886 :unit) in 
  let neverBfromlastA_step self ((a_732:FadFloat.t) , (b_733:FadFloat.t)) =
    (i_886_step self.i_886 (a_732 , (q_not b_733)):FadFloat.t) in
  Node { alloc = neverBfromlastA_alloc; reset = neverBfromlastA_reset ;
                                        step = neverBfromlastA_step }
type ('a) _neverBfromfirstA =
  { mutable i_887 : 'a }

let neverBfromfirstA  = 
  let Node { alloc = i_887_alloc; step = i_887_step ; reset = i_887_reset } = alwaysBfromfirstA 
   in
  let neverBfromfirstA_alloc _ =
    ();{ i_887 = i_887_alloc () (* discrete *)  } in
  let neverBfromfirstA_reset self  =
    (i_887_reset self.i_887 :unit) in 
  let neverBfromfirstA_step self ((a_734:FadFloat.t) , (b_735:FadFloat.t)) =
    (i_887_step self.i_887 (a_734 , (q_not b_735)):FadFloat.t) in
  Node { alloc = neverBfromfirstA_alloc; reset = neverBfromfirstA_reset ;
                                         step = neverBfromfirstA_step }
type ('a) _neverBfromA =
  { mutable i_888 : 'a }

let neverBfromA  = 
  let Node { alloc = i_888_alloc; step = i_888_step ; reset = i_888_reset } = neverBfromlastA 
   in
  let neverBfromA_alloc _ =
    ();{ i_888 = i_888_alloc () (* discrete *)  } in
  let neverBfromA_reset self  =
    (i_888_reset self.i_888 :unit) in 
  let neverBfromA_step self ((a_736:FadFloat.t) , (b_737:FadFloat.t)) =
    (i_888_step self.i_888 (a_736 , b_737):FadFloat.t) in
  Node { alloc = neverBfromA_alloc; reset = neverBfromA_reset ;
                                    step = neverBfromA_step }
type ('c , 'b , 'a) _onceBfromlastA_timed =
  { mutable i_891 : 'c ; mutable i_890 : 'b ; mutable i_889 : 'a }

let onceBfromlastA_timed (delay_740:float) = 
  let Node { alloc = i_891_alloc; step = i_891_step ; reset = i_891_reset } = 
  counter delay_740  in 
  let Node { alloc = i_890_alloc; step = i_890_step ; reset = i_890_reset } = onceBfromlastAtoC 
   in 
  let Node { alloc = i_889_alloc; step = i_889_step ; reset = i_889_reset } = never 
   in
  let onceBfromlastA_timed_alloc _ =
    ();
    { i_891 = i_891_alloc () (* discrete *)  ;
      i_890 = i_890_alloc () (* discrete *)  ;
      i_889 = i_889_alloc () (* discrete *)  } in
  let onceBfromlastA_timed_reset self  =
    ((i_891_reset self.i_891  ;
      i_890_reset self.i_890  ; i_889_reset self.i_889 ):unit) in 
  let onceBfromlastA_timed_step self ((tstep_741:FadFloat.t) ,
                                      (a_738:FadFloat.t) , (b_739:FadFloat.t)) =
    ((let resultp_748 = ref (false:bool) in
      let resultv_747 = ref (():unit) in
      let resultp_746 = ref (false:bool) in
      let resultv_745 = ref (():unit) in
      (begin match isTrue a_738 with
             | true -> resultp_748 := true ; resultv_747 := () | _ -> ()  end)
      ;
      (begin match isFalse a_738 with
             | true -> resultp_746 := true ; resultv_745 := () | _ -> ()  end)
      ;
      (let (cpt_742:FadFloat.t) =
           i_891_step self.i_891
             (tstep_741 ,
              (!resultv_745 , !resultp_746) , (!resultv_747 , !resultp_748)) in
       q_or ((i_889_step self.i_889 a_738) ,
             (i_890_step self.i_890
                (a_738 , b_739 , (q_lt (cpt_742 , (FadFloat.zero ())))))))):
    FadFloat.t) in
  Node { alloc = onceBfromlastA_timed_alloc; reset = onceBfromlastA_timed_reset
                                             ;
                                             step = onceBfromlastA_timed_step }
type ('d , 'c , 'b , 'a) _onceBfromfirstA_timed =
  { mutable i_895 : 'd ;
    mutable i_894 : 'c ; mutable i_893 : 'b ; mutable i_892 : 'a }

let onceBfromfirstA_timed (delay_751:float) = 
  let Node { alloc = i_895_alloc; step = i_895_step ; reset = i_895_reset } = once 
   in 
  let Node { alloc = i_894_alloc; step = i_894_step ; reset = i_894_reset } = 
  counter delay_751  in 
  let Node { alloc = i_893_alloc; step = i_893_step ; reset = i_893_reset } = onceBfromfirstAtoC 
   in 
  let Node { alloc = i_892_alloc; step = i_892_step ; reset = i_892_reset } = never 
   in
  let onceBfromfirstA_timed_alloc _ =
    ();
    { i_895 = i_895_alloc () (* discrete *)  ;
      i_894 = i_894_alloc () (* discrete *)  ;
      i_893 = i_893_alloc () (* discrete *)  ;
      i_892 = i_892_alloc () (* discrete *)  } in
  let onceBfromfirstA_timed_reset self  =
    ((i_895_reset self.i_895  ;
      i_894_reset self.i_894  ;
      i_893_reset self.i_893  ; i_892_reset self.i_892 ):unit) in 
  let onceBfromfirstA_timed_step self ((tstep_752:FadFloat.t) ,
                                       (a_749:FadFloat.t) ,
                                       (b_750:FadFloat.t)) =
    ((let resultp_758 = ref (false:bool) in
      let resultv_757 = ref (():unit) in
      let resultp_756 = ref (false:bool) in
      let resultv_755 = ref (():unit) in
      (begin match false with
             | true -> resultp_758 := true ; resultv_757 := () | _ -> ()  end)
      ;
      (let (p_754:FadFloat.t) = i_895_step self.i_895 a_749 in
       (begin match isTrue p_754 with
              | true -> resultp_756 := true ; resultv_755 := () | _ -> ()  end)
       ;
       (let (cpt_753:FadFloat.t) =
            i_894_step self.i_894
              (tstep_752 ,
               (!resultv_755 , !resultp_756) , (!resultv_757 , !resultp_758)) in
        q_or ((i_892_step self.i_892 a_749) ,
              (i_893_step self.i_893
                 (a_749 , b_750 , (q_lt (cpt_753 , (FadFloat.zero ()))))))))):
    FadFloat.t) in
  Node { alloc = onceBfromfirstA_timed_alloc; reset = onceBfromfirstA_timed_reset
                                              ;
                                              step = onceBfromfirstA_timed_step }
type ('a) _onceBfromA_timed =
  { mutable i_896 : 'a }

let onceBfromA_timed (delay_761:float) = 
  let Node { alloc = i_896_alloc; step = i_896_step ; reset = i_896_reset } = 
  onceBfromlastA_timed delay_761  in
  let onceBfromA_timed_alloc _ =
    ();{ i_896 = i_896_alloc () (* discrete *)  } in
  let onceBfromA_timed_reset self  =
    (i_896_reset self.i_896 :unit) in 
  let onceBfromA_timed_step self ((tstep_762:FadFloat.t) ,
                                  (a_759:FadFloat.t) , (b_760:FadFloat.t)) =
    (i_896_step self.i_896 (tstep_762 , a_759 , b_760):FadFloat.t) in
  Node { alloc = onceBfromA_timed_alloc; reset = onceBfromA_timed_reset ;
                                         step = onceBfromA_timed_step }
type ('c , 'b , 'a) _alwaysBfromlastA_timed =
  { mutable i_899 : 'c ; mutable i_898 : 'b ; mutable i_897 : 'a }

let alwaysBfromlastA_timed (delay_765:float) = 
  let Node { alloc = i_899_alloc; step = i_899_step ; reset = i_899_reset } = 
  counter delay_765  in 
  let Node { alloc = i_898_alloc; step = i_898_step ; reset = i_898_reset } = sincelast 
   in 
  let Node { alloc = i_897_alloc; step = i_897_step ; reset = i_897_reset } = never 
   in
  let alwaysBfromlastA_timed_alloc _ =
    ();
    { i_899 = i_899_alloc () (* discrete *)  ;
      i_898 = i_898_alloc () (* discrete *)  ;
      i_897 = i_897_alloc () (* discrete *)  } in
  let alwaysBfromlastA_timed_reset self  =
    ((i_899_reset self.i_899  ;
      i_898_reset self.i_898  ; i_897_reset self.i_897 ):unit) in 
  let alwaysBfromlastA_timed_step self ((tstep_766:FadFloat.t) ,
                                        (a_763:FadFloat.t) ,
                                        (b_764:FadFloat.t)) =
    ((let resultp_773 = ref (false:bool) in
      let resultv_772 = ref (():unit) in
      let resultp_771 = ref (false:bool) in
      let resultv_770 = ref (():unit) in
      (begin match isTrue a_763 with
             | true -> resultp_773 := true ; resultv_772 := () | _ -> ()  end)
      ;
      (begin match isFalse a_763 with
             | true -> resultp_771 := true ; resultv_770 := () | _ -> ()  end)
      ;
      (let (cpt_767:FadFloat.t) =
           i_899_step self.i_899
             (tstep_766 ,
              (!resultv_770 , !resultp_771) , (!resultv_772 , !resultp_773)) in
       q_or ((i_897_step self.i_897 a_763) ,
             (implies ((q_gt (cpt_767 , (FadFloat.zero ()))) ,
                       (q_not (i_898_step self.i_898 ((q_not b_764) , a_763)))))))):
    FadFloat.t) in
  Node { alloc = alwaysBfromlastA_timed_alloc; reset = alwaysBfromlastA_timed_reset
                                               ;
                                               step = alwaysBfromlastA_timed_step }
type ('d , 'c , 'b , 'a) _alwaysBfromfirstA_timed =
  { mutable i_903 : 'd ;
    mutable i_902 : 'c ; mutable i_901 : 'b ; mutable i_900 : 'a }

let alwaysBfromfirstA_timed (delay_776:float) = 
  let Node { alloc = i_903_alloc; step = i_903_step ; reset = i_903_reset } = once 
   in 
  let Node { alloc = i_902_alloc; step = i_902_step ; reset = i_902_reset } = 
  counter delay_776  in 
  let Node { alloc = i_901_alloc; step = i_901_step ; reset = i_901_reset } = sincefirst 
   in 
  let Node { alloc = i_900_alloc; step = i_900_step ; reset = i_900_reset } = never 
   in
  let alwaysBfromfirstA_timed_alloc _ =
    ();
    { i_903 = i_903_alloc () (* discrete *)  ;
      i_902 = i_902_alloc () (* discrete *)  ;
      i_901 = i_901_alloc () (* discrete *)  ;
      i_900 = i_900_alloc () (* discrete *)  } in
  let alwaysBfromfirstA_timed_reset self  =
    ((i_903_reset self.i_903  ;
      i_902_reset self.i_902  ;
      i_901_reset self.i_901  ; i_900_reset self.i_900 ):unit) in 
  let alwaysBfromfirstA_timed_step self ((tstep_777:FadFloat.t) ,
                                         (a_774:FadFloat.t) ,
                                         (b_775:FadFloat.t)) =
    ((let resultp_783 = ref (false:bool) in
      let resultv_782 = ref (():unit) in
      let resultp_781 = ref (false:bool) in
      let resultv_780 = ref (():unit) in
      (begin match false with
             | true -> resultp_783 := true ; resultv_782 := () | _ -> ()  end)
      ;
      (let (p_779:FadFloat.t) = i_903_step self.i_903 a_774 in
       (begin match isTrue p_779 with
              | true -> resultp_781 := true ; resultv_780 := () | _ -> ()  end)
       ;
       (let (cpt_778:FadFloat.t) =
            i_902_step self.i_902
              (tstep_777 ,
               (!resultv_780 , !resultp_781) , (!resultv_782 , !resultp_783)) in
        q_or ((i_900_step self.i_900 a_774) ,
              (implies ((q_gt (cpt_778 , (FadFloat.zero ()))) ,
                        (q_not (i_901_step self.i_901 ((q_not b_775) , a_774))))))))):
    FadFloat.t) in
  Node { alloc = alwaysBfromfirstA_timed_alloc; reset = alwaysBfromfirstA_timed_reset
                                                ;
                                                step = alwaysBfromfirstA_timed_step }
type ('a) _alwaysBfromA_timed =
  { mutable i_904 : 'a }

let alwaysBfromA_timed (delay_786:float) = 
  let Node { alloc = i_904_alloc; step = i_904_step ; reset = i_904_reset } = 
  alwaysBfromlastA_timed delay_786  in
  let alwaysBfromA_timed_alloc _ =
    ();{ i_904 = i_904_alloc () (* discrete *)  } in
  let alwaysBfromA_timed_reset self  =
    (i_904_reset self.i_904 :unit) in 
  let alwaysBfromA_timed_step self ((tstep_787:FadFloat.t) ,
                                    (a_784:FadFloat.t) , (b_785:FadFloat.t)) =
    (i_904_step self.i_904 (tstep_787 , a_784 , b_785):FadFloat.t) in
  Node { alloc = alwaysBfromA_timed_alloc; reset = alwaysBfromA_timed_reset ;
                                           step = alwaysBfromA_timed_step }
type ('a) _neverBfromlastA_timed =
  { mutable i_905 : 'a }

let neverBfromlastA_timed (delay_790:float) = 
  let Node { alloc = i_905_alloc; step = i_905_step ; reset = i_905_reset } = 
  alwaysBfromlastA_timed delay_790  in
  let neverBfromlastA_timed_alloc _ =
    ();{ i_905 = i_905_alloc () (* discrete *)  } in
  let neverBfromlastA_timed_reset self  =
    (i_905_reset self.i_905 :unit) in 
  let neverBfromlastA_timed_step self ((tstep_791:FadFloat.t) ,
                                       (a_788:FadFloat.t) ,
                                       (b_789:FadFloat.t)) =
    (i_905_step self.i_905 (tstep_791 , a_788 , (q_not b_789)):FadFloat.t) in
  Node { alloc = neverBfromlastA_timed_alloc; reset = neverBfromlastA_timed_reset
                                              ;
                                              step = neverBfromlastA_timed_step }
type ('a) _neverBfromfirstA_timed =
  { mutable i_906 : 'a }

let neverBfromfirstA_timed (delay_794:float) = 
  let Node { alloc = i_906_alloc; step = i_906_step ; reset = i_906_reset } = 
  alwaysBfromfirstA_timed delay_794  in
  let neverBfromfirstA_timed_alloc _ =
    ();{ i_906 = i_906_alloc () (* discrete *)  } in
  let neverBfromfirstA_timed_reset self  =
    (i_906_reset self.i_906 :unit) in 
  let neverBfromfirstA_timed_step self ((tstep_795:FadFloat.t) ,
                                        (a_792:FadFloat.t) ,
                                        (b_793:FadFloat.t)) =
    (i_906_step self.i_906 (tstep_795 , a_792 , (q_not b_793)):FadFloat.t) in
  Node { alloc = neverBfromfirstA_timed_alloc; reset = neverBfromfirstA_timed_reset
                                               ;
                                               step = neverBfromfirstA_timed_step }
type ('a) _neverBfromA_timed =
  { mutable i_907 : 'a }

let neverBfromA_timed (delay_798:float) = 
  let Node { alloc = i_907_alloc; step = i_907_step ; reset = i_907_reset } = 
  neverBfromlastA_timed delay_798  in
  let neverBfromA_timed_alloc _ =
    ();{ i_907 = i_907_alloc () (* discrete *)  } in
  let neverBfromA_timed_reset self  =
    (i_907_reset self.i_907 :unit) in 
  let neverBfromA_timed_step self ((tstep_799:FadFloat.t) ,
                                   (a_796:FadFloat.t) , (b_797:FadFloat.t)) =
    (i_907_step self.i_907 (tstep_799 , a_796 , b_797):FadFloat.t) in
  Node { alloc = neverBfromA_timed_alloc; reset = neverBfromA_timed_reset ;
                                          step = neverBfromA_timed_step }
type ('a) _absence =
  { mutable i_908 : 'a }

let absence  = 
  let Node { alloc = i_908_alloc; step = i_908_step ; reset = i_908_reset } = never 
   in let absence_alloc _ =
        ();{ i_908 = i_908_alloc () (* discrete *)  } in
  let absence_reset self  =
    (i_908_reset self.i_908 :unit) in 
  let absence_step self (p_800:FadFloat.t) =
    (i_908_step self.i_908 p_800:FadFloat.t) in
  Node { alloc = absence_alloc; reset = absence_reset ; step = absence_step }
type ('b , 'a) _absence_timed =
  { mutable i_910 : 'b ; mutable i_909 : 'a }

let absence_timed (t_802:float) = 
  let Node { alloc = i_910_alloc; step = i_910_step ; reset = i_910_reset } = neverBfromA 
   in 
  let Node { alloc = i_909_alloc; step = i_909_step ; reset = i_909_reset } = 
  horizon t_802  in
  let absence_timed_alloc _ =
    ();
    { i_910 = i_910_alloc () (* discrete *)  ;
      i_909 = i_909_alloc () (* discrete *)  } in
  let absence_timed_reset self  =
    ((i_910_reset self.i_910  ; i_909_reset self.i_909 ):unit) in 
  let absence_timed_step self ((tstep_803:FadFloat.t) , (p_801:FadFloat.t)) =
    (i_910_step self.i_910 ((i_909_step self.i_909 tstep_803) , p_801):
    FadFloat.t) in
  Node { alloc = absence_timed_alloc; reset = absence_timed_reset ;
                                      step = absence_timed_step }
type ('a) _minimum_duration =
  { mutable i_911 : 'a }

let minimum_duration (t_805:float) = 
  let Node { alloc = i_911_alloc; step = i_911_step ; reset = i_911_reset } = 
  counter t_805  in
  let minimum_duration_alloc _ =
    ();{ i_911 = i_911_alloc () (* discrete *)  } in
  let minimum_duration_reset self  =
    (i_911_reset self.i_911 :unit) in 
  let minimum_duration_step self ((tstep_806:FadFloat.t) , (p_804:FadFloat.t)) =
    ((let resultp_812 = ref (false:bool) in
      let resultv_811 = ref (():unit) in
      (begin match isTrue p_804 with
             | true -> resultp_812 := true ; resultv_811 := () | _ -> ()  end)
      ;
      (let (cpt_808:FadFloat.t) =
           i_911_step self.i_911
             (tstep_806 ,
              (!resultv_811 , !resultp_812) , (!resultv_811 , !resultp_812)) in
       implies ((q_not p_804) , (q_lt (cpt_808 , (FadFloat.make 0.)))))):
    FadFloat.t) in
  Node { alloc = minimum_duration_alloc; reset = minimum_duration_reset ;
                                         step = minimum_duration_step }
type ('a) _maximum_duration =
  { mutable i_912 : 'a }

let maximum_duration (t_814:float) = 
  let Node { alloc = i_912_alloc; step = i_912_step ; reset = i_912_reset } = 
  counter t_814  in
  let maximum_duration_alloc _ =
    ();{ i_912 = i_912_alloc () (* discrete *)  } in
  let maximum_duration_reset self  =
    (i_912_reset self.i_912 :unit) in 
  let maximum_duration_step self ((tstep_815:FadFloat.t) , (p_813:FadFloat.t)) =
    ((let resultp_821 = ref (false:bool) in
      let resultv_820 = ref (():unit) in
      (begin match isTrue p_813 with
             | true -> resultp_821 := true ; resultv_820 := () | _ -> ()  end)
      ;
      (let (cpt_817:FadFloat.t) =
           i_912_step self.i_912
             (tstep_815 ,
              (!resultv_820 , !resultp_821) , (!resultv_820 , !resultp_821)) in
       implies (p_813 , (q_ge (cpt_817 , (FadFloat.make 0.)))))):FadFloat.t) in
  Node { alloc = maximum_duration_alloc; reset = maximum_duration_reset ;
                                         step = maximum_duration_step }
type ('b , 'a) _bounded_recurrence =
  { mutable i_913 : 'b ; mutable i_835 : 'a }

let bounded_recurrence (t_823:float) = 
  let Node { alloc = i_913_alloc; step = i_913_step ; reset = i_913_reset } = 
  counter t_823  in
  let bounded_recurrence_alloc _ =
    ();{ i_835 = (false:bool);i_913 = i_913_alloc () (* discrete *)  } in
  let bounded_recurrence_reset self  =
    ((self.i_835 <- true ; i_913_reset self.i_913 ):unit) in 
  let bounded_recurrence_step self ((tstep_824:FadFloat.t) ,
                                    (p_822:FadFloat.t)) =
    ((let resultp_833 = ref (false:bool) in
      let resultv_832 = ref (():unit) in
      let resultp_831 = ref (false:bool) in
      let resultv_830 = ref (():unit) in
      (begin match isTrue p_822 with
             | true -> resultp_831 := true ; resultv_830 := () | _ -> ()  end)
      ;
      (begin match isTrue q_true with
             | true -> resultp_833 := true ; resultv_832 := () | _ -> ()  end)
      ;
      (let (x_834:(unit)signal) =
           if self.i_835
           then (!resultv_832 , !resultp_833)
           else (!resultv_830 , !resultp_831) in
       self.i_835 <- false ;
       (let (cpt_826:FadFloat.t) =
            i_913_step self.i_913
              (tstep_824 , x_834 , (!resultv_830 , !resultp_831)) in
        q_ge (cpt_826 , (FadFloat.make 0.))))):FadFloat.t) in
  Node { alloc = bounded_recurrence_alloc; reset = bounded_recurrence_reset ;
                                           step = bounded_recurrence_step }
type ('c , 'b , 'a) _bounded_response =
  { mutable i_915 : 'c ; mutable i_914 : 'b ; mutable result_840 : 'a }

let bounded_response (t_838:float) = 
  let Node { alloc = i_915_alloc; step = i_915_step ; reset = i_915_reset } = 
  onceBfromfirstA_timed t_838  in 
  let Node { alloc = i_914_alloc; step = i_914_step ; reset = i_914_reset } = never 
   in
  let bounded_response_alloc _ =
    ();
    { result_840 = (create ():FadFloat.t);
      i_915 = i_915_alloc () (* discrete *)  ;
      i_914 = i_914_alloc () (* discrete *)  } in
  let bounded_response_reset self  =
    ((i_915_reset self.i_915  ; i_914_reset self.i_914 ):unit) in 
  let bounded_response_step self ((tstep_839:FadFloat.t) ,
                                  (p_836:FadFloat.t) , (s_837:FadFloat.t)) =
    (((if isTrue s_837 then
       (i_915_reset self.i_915  ; i_914_reset self.i_914 )) ;
      self.result_840 <- q_or ((i_914_step self.i_914 p_836) ,
                               (i_915_step self.i_915
                                  (tstep_839 , p_836 , s_837))) ;
      self.result_840):FadFloat.t) in
  Node { alloc = bounded_response_alloc; reset = bounded_response_reset ;
                                         step = bounded_response_step }
type ('a) _bounded_invariance =
  { mutable i_916 : 'a }

let bounded_invariance (t_843:float) = 
  let Node { alloc = i_916_alloc; step = i_916_step ; reset = i_916_reset } = 
  counter t_843  in
  let bounded_invariance_alloc _ =
    ();{ i_916 = i_916_alloc () (* discrete *)  } in
  let bounded_invariance_reset self  =
    (i_916_reset self.i_916 :unit) in 
  let bounded_invariance_step self ((tstep_844:FadFloat.t) ,
                                    (p_841:FadFloat.t) , (s_842:FadFloat.t)) =
    ((let resultp_851 = ref (false:bool) in
      let resultv_850 = ref (():unit) in
      (begin match ((isTrue s_842) ,
                    (isTrue p_841) , (isTrue p_841) , (isTrue s_842)) with
             | (_ , _ , true , true) | (true , true , _ , _) ->
                 resultp_851 := true ; resultv_850 := () | _ -> ()  end) ;
      (let (cpt_847:FadFloat.t) =
           i_916_step self.i_916
             (tstep_844 ,
              (!resultv_850 , !resultp_851) , (!resultv_850 , !resultp_851)) in
       q_or (s_842 , (q_le (cpt_847 , (FadFloat.make 0.)))))):FadFloat.t) in
  Node { alloc = bounded_invariance_alloc; reset = bounded_invariance_reset ;
                                           step = bounded_invariance_step }
