(* The Zélus compiler, version 2.1
  (jeudi 27 août 2020, 15:59:00 (UTC+0200)) *)
open Ztypes
type state__5532 = Discrete_obs_fad_Count_240 | Discrete_obs_fad_Stop_239 
open MyOp
let q_true = MyOp.infinity

let q_false = MyOp.neg_infinity

type _no_signal = unit

let no_signal  = 
   let no_signal_alloc _ = () in let no_signal_copy source dest = () in
  let no_signal_reset self  =
    ((()):unit) in 
  let no_signal_step self () =
    ((let resultp_540 = ref (false:bool) in
      let resultv_539 = ref (():unit) in
      (begin match false with
             | true -> resultp_540 := true ; resultv_539 := () | _ -> ()  end)
      ; (!resultv_539 , !resultp_540)):unit signal) in
  Cnode { alloc = no_signal_alloc; copy = no_signal_copy ;
                                   reset = no_signal_reset ;
                                   step = no_signal_step }
type ('a) _now =
  { mutable m_543 : 'a }

let now  = 
   let now_alloc _ =
     ();{ m_543 = (false:bool) } in
  let now_copy source dest =
    dest.m_543 <- source.m_543 in
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
  Cnode { alloc = now_alloc; copy = now_copy ;
                             reset = now_reset ; step = now_step }
let isTrue (p_545:MyOp.t) =
  (>=) p_545  (MyOp.make 0.)

let isFalse (p_546:MyOp.t) =
  (<) p_546  (MyOp.make 0.)

let q_istrue (p_547:MyOp.t) =
  let resultp_549 = ref (false:bool) in
  let resultv_548 = ref (():unit) in
  (begin match isTrue p_547 with
         | true -> resultp_549 := true ; resultv_548 := () | _ -> ()  end) ;
  (!resultv_548 , !resultp_549)

let q_isfalse (p_550:MyOp.t) =
  let resultp_552 = ref (false:bool) in
  let resultv_551 = ref (():unit) in
  (begin match isFalse p_550 with
         | true -> resultp_552 := true ; resultv_551 := () | _ -> ()  end) ;
  (!resultv_551 , !resultp_552)

let q_aretrue2 ((p_553:MyOp.t) , (s_554:MyOp.t)) =
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
  let freeze_copy source dest =
    dest.i_559 <- source.i_559 ; dest.res_558 <- source.res_558 in
  let freeze_reset self  =
    (self.i_559 <- true:unit) in 
  let freeze_step self (p_557:'a4696) =
    (((if self.i_559 then self.res_558 <- p_557) ;
      self.i_559 <- false ; self.res_558):'a) in
  Cnode { alloc = freeze_alloc; copy = freeze_copy ;
                                reset = freeze_reset ; step = freeze_step }
type ('a) _q_istrue_now =
  { mutable i_852 : 'a }

let q_istrue_now  = 
  let Cnode { alloc = i_852_alloc; copy = i_852_copy ;
                                   step = i_852_step ; reset = i_852_reset } = freeze 
   in
  let q_istrue_now_alloc _ =
    ();{ i_852 = i_852_alloc () (* discrete *)  } in
  let q_istrue_now_copy source dest =
    i_852_copy source.i_852 dest.i_852 (* discrete *) in
  let q_istrue_now_reset self  =
    (i_852_reset self.i_852 :unit) in 
  let q_istrue_now_step self (p_560:MyOp.t) =
    ((let resultp_563 = ref (false:bool) in
      let resultv_562 = ref (():unit) in
      (begin match isTrue p_560 with
             | true -> resultp_563 := true ; resultv_562 := () | _ -> ()  end)
      ; i_852_step self.i_852 (!resultv_562 , !resultp_563)):unit signal) in
  Cnode { alloc = q_istrue_now_alloc; copy = q_istrue_now_copy ;
                                      reset = q_istrue_now_reset ;
                                      step = q_istrue_now_step }
type ('a) _q_isfalse_now =
  { mutable i_853 : 'a }

let q_isfalse_now  = 
  let Cnode { alloc = i_853_alloc; copy = i_853_copy ;
                                   step = i_853_step ; reset = i_853_reset } = freeze 
   in
  let q_isfalse_now_alloc _ =
    ();{ i_853 = i_853_alloc () (* discrete *)  } in
  let q_isfalse_now_copy source dest =
    i_853_copy source.i_853 dest.i_853 (* discrete *) in
  let q_isfalse_now_reset self  =
    (i_853_reset self.i_853 :unit) in 
  let q_isfalse_now_step self (p_564:MyOp.t) =
    ((let resultp_567 = ref (false:bool) in
      let resultv_566 = ref (():unit) in
      (begin match isFalse p_564 with
             | true -> resultp_567 := true ; resultv_566 := () | _ -> ()  end)
      ; i_853_step self.i_853 (!resultv_566 , !resultp_567)):unit signal) in
  Cnode { alloc = q_isfalse_now_alloc; copy = q_isfalse_now_copy ;
                                       reset = q_isfalse_now_reset ;
                                       step = q_isfalse_now_step }
let q_gt ((p1_568:MyOp.t) , (p2_569:MyOp.t)) =
  MyOp.(-) p1_568  p2_569

let q_ge ((p1_570:MyOp.t) , (p2_571:MyOp.t)) =
  MyOp.(-) p1_570  p2_571

let q_lt ((p1_572:MyOp.t) , (p2_573:MyOp.t)) =
  MyOp.(-) p2_573  p1_572

let q_le ((p1_574:MyOp.t) , (p2_575:MyOp.t)) =
  MyOp.(-) p2_575  p1_574

let q_not (p_576:MyOp.t) =
  MyOp.(~-) p_576

let q_or ((p1_577:MyOp.t) , (p2_578:MyOp.t)) =
  MyOp.max p1_577  p2_578

let q_and ((p1_579:MyOp.t) , (p2_580:MyOp.t)) =
  MyOp.min p1_579  p2_580

let abs (x1_581:MyOp.t) =
  MyOp.max x1_581  (MyOp.(~-) x1_581)

let q_eq (precision_582:MyOp.t)  ((x1_583:MyOp.t) , (x2_584:MyOp.t)) =
  MyOp.(-) precision_582  (abs (MyOp.(-) x1_583  x2_584))

let q_eqi ((i1_585:MyOp.t) , (i2_586:MyOp.t)) =
  MyOp.(-) (MyOp.make 0.5)  (abs (MyOp.(-) i1_585  i2_586))

let implies ((a_587:MyOp.t) , (b_588:MyOp.t)) =
  q_or ((q_not a_587) , b_588)

type ('b , 'a) _q_up =
  { mutable i_593 : 'b ; mutable m_590 : 'a }

let q_up  = 
  
  let q_up_alloc _ =
    ();{ i_593 = (false:bool) ; m_590 = (create ():MyOp.t) } in
  let q_up_copy source dest =
    dest.i_593 <- source.i_593 ; dest.m_590 <- source.m_590 in
  let q_up_reset self  =
    (self.i_593 <- true:unit) in 
  let q_up_step self (p_589:MyOp.t) =
    ((let (x_592:MyOp.t) =
          if self.i_593
          then p_589
          else
            q_and ((q_lt (self.m_590 , (MyOp.zero ()))) ,
                   (q_gt (p_589 , (MyOp.zero ())))) in
      self.i_593 <- false ; self.m_590 <- p_589 ; x_592):MyOp.t) in
  Cnode { alloc = q_up_alloc; copy = q_up_copy ;
                              reset = q_up_reset ; step = q_up_step }
type ('b , 'a) _b_up =
  { mutable i_598 : 'b ; mutable m_595 : 'a }

let b_up  = 
   let b_up_alloc _ =
     ();{ i_598 = (false:bool) ; m_595 = (false:bool) } in
  let b_up_copy source dest =
    dest.i_598 <- source.i_598 ; dest.m_595 <- source.m_595 in
  let b_up_reset self  =
    (self.i_598 <- true:unit) in 
  let b_up_step self (p_594:bool) =
    ((let (x_597:bool) =
          if self.i_598 then p_594 else (&&) (not self.m_595)  p_594 in
      self.i_598 <- false ; self.m_595 <- p_594 ; x_597):bool) in
  Cnode { alloc = b_up_alloc; copy = b_up_copy ;
                              reset = b_up_reset ; step = b_up_step }
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
      cpt_605 = (create ():MyOp.t) ;
      i_611 = (false:bool) ; m_608 = (create ():MyOp.t) } in
  let counter_copy source dest =
    dest.r_607 <- source.r_607 ;
    dest.s_606 <- source.s_606 ;
    dest.cpt_605 <- source.cpt_605 ;
    dest.i_611 <- source.i_611 ; dest.m_608 <- source.m_608 in
  let counter_reset self  =
    ((self.r_607 <- false ;
      self.s_606 <- Discrete_obs_fad_Stop_239 ; self.i_611 <- true):unit) in 
  let counter_step self ((tstep_600:MyOp.t) ,
                         ((strtv_603:unit) , (strtp_604:bool)) ,
                         ((rstv_601:unit) , (rstp_602:bool))) =
    (((begin match self.s_606 with
             | Discrete_obs_fad_Stop_239 ->
                 (if self.r_607 then ()) ;
                 self.cpt_605 <- MyOp.make delay_599 ;
                 (begin match (strtv_603 , strtp_604) with
                        | (() , true) ->
                            self.r_607 <- true ;
                            self.s_606 <- Discrete_obs_fad_Count_240
                        | _ -> self.r_607 <- false  end)
             | Discrete_obs_fad_Count_240 ->
                 (if self.r_607 then self.i_611 <- true) ;
                 (let (x_610:MyOp.t) =
                      if self.i_611
                      then MyOp.make delay_599
                      else MyOp.(-) self.m_608  tstep_600 in
                  self.i_611 <- false ;
                  self.cpt_605 <- x_610 ;
                  self.m_608 <- x_610 ;
                  (begin match (rstv_601 , rstp_602) with
                         | (() , true) ->
                             self.r_607 <- true ;
                             self.s_606 <- Discrete_obs_fad_Stop_239
                         | _ -> self.r_607 <- false  end))
              end) ; self.cpt_605):MyOp.t) in
  Cnode { alloc = counter_alloc; copy = counter_copy ;
                                 reset = counter_reset ; step = counter_step }
type ('b , 'a) _always =
  { mutable i_617 : 'b ; mutable m_614 : 'a }

let always  = 
  
  let always_alloc _ =
    ();{ i_617 = (false:bool) ; m_614 = (create ():MyOp.t) } in
  let always_copy source dest =
    dest.i_617 <- source.i_617 ; dest.m_614 <- source.m_614 in
  let always_reset self  =
    (self.i_617 <- true:unit) in 
  let always_step self (p_612:MyOp.t) =
    ((let (x_616:MyOp.t) =
          if self.i_617 then p_612 else q_and (self.m_614 , p_612) in
      self.i_617 <- false ; self.m_614 <- x_616 ; x_616):MyOp.t) in
  Cnode { alloc = always_alloc; copy = always_copy ;
                                reset = always_reset ; step = always_step }
type ('a) _never =
  { mutable i_854 : 'a }

let never  = 
  let Cnode { alloc = i_854_alloc; copy = i_854_copy ;
                                   step = i_854_step ; reset = i_854_reset } = always 
   in let never_alloc _ =
        ();{ i_854 = i_854_alloc () (* discrete *)  } in
  let never_copy source dest =
    i_854_copy source.i_854 dest.i_854 (* discrete *) in
  let never_reset self  =
    (i_854_reset self.i_854 :unit) in 
  let never_step self (p_618:MyOp.t) =
    (i_854_step self.i_854 (q_not p_618):MyOp.t) in
  Cnode { alloc = never_alloc; copy = never_copy ;
                               reset = never_reset ; step = never_step }
type ('b , 'a) _once =
  { mutable i_624 : 'b ; mutable m_621 : 'a }

let once  = 
  
  let once_alloc _ =
    ();{ i_624 = (false:bool) ; m_621 = (create ():MyOp.t) } in
  let once_copy source dest =
    dest.i_624 <- source.i_624 ; dest.m_621 <- source.m_621 in
  let once_reset self  =
    (self.i_624 <- true:unit) in 
  let once_step self (p_619:MyOp.t) =
    ((let (x_623:MyOp.t) =
          if self.i_624 then p_619 else q_or (self.m_621 , p_619) in
      self.i_624 <- false ; self.m_621 <- x_623 ; x_623):MyOp.t) in
  Cnode { alloc = once_alloc; copy = once_copy ;
                              reset = once_reset ; step = once_step }
type ('d , 'c , 'b , 'a) _sincefirst =
  { mutable i_855 : 'd ;
    mutable i_636 : 'c ; mutable m_632 : 'b ; mutable m_629 : 'a }

let sincefirst  = 
  let Cnode { alloc = i_855_alloc; copy = i_855_copy ;
                                   step = i_855_step ; reset = i_855_reset } = never 
   in
  let sincefirst_alloc _ =
    ();
    { i_636 = (false:bool) ;
      m_632 = (create ():MyOp.t) ; m_629 = (create ():MyOp.t);
      i_855 = i_855_alloc () (* discrete *)  } in
  let sincefirst_copy source dest =
    dest.i_636 <- source.i_636 ;
    dest.m_632 <- source.m_632 ; dest.m_629 <- source.m_629;
    i_855_copy source.i_855 dest.i_855 (* discrete *) in
  let sincefirst_reset self  =
    ((self.i_636 <- true ; i_855_reset self.i_855 ):unit) in 
  let sincefirst_step self ((x_625:MyOp.t) , (y_626:MyOp.t)) =
    ((let (x_634:MyOp.t) = q_or (self.m_632 , x_625) in
      let (x_631:MyOp.t) =
          if self.i_636 then y_626 else q_and (self.m_629 , y_626) in
      let (x_635:MyOp.t) =
          if self.i_636
          then q_true
          else if isTrue x_631 then x_625 else x_634 in
      self.i_636 <- false ;
      self.m_632 <- x_635 ; self.m_629 <- i_855_step self.i_855 y_626 ; x_635):
    MyOp.t) in
  Cnode { alloc = sincefirst_alloc; copy = sincefirst_copy ;
                                    reset = sincefirst_reset ;
                                    step = sincefirst_step }
type ('b , 'a) _sincelast =
  { mutable i_644 : 'b ; mutable m_640 : 'a }

let sincelast  = 
  
  let sincelast_alloc _ =
    ();{ i_644 = (false:bool) ; m_640 = (create ():MyOp.t) } in
  let sincelast_copy source dest =
    dest.i_644 <- source.i_644 ; dest.m_640 <- source.m_640 in
  let sincelast_reset self  =
    (self.i_644 <- true:unit) in 
  let sincelast_step self ((x_637:MyOp.t) , (y_638:MyOp.t)) =
    ((let (x_642:MyOp.t) = q_or (self.m_640 , x_637) in
      let (x_643:MyOp.t) =
          if self.i_644
          then q_true
          else if isTrue y_638 then x_637 else x_642 in
      self.i_644 <- false ; self.m_640 <- x_643 ; x_643):MyOp.t) in
  Cnode { alloc = sincelast_alloc; copy = sincelast_copy ;
                                   reset = sincelast_reset ;
                                   step = sincelast_step }
type ('a) _since =
  { mutable i_856 : 'a }

let since  = 
  let Cnode { alloc = i_856_alloc; copy = i_856_copy ;
                                   step = i_856_step ; reset = i_856_reset } = sincelast 
   in let since_alloc _ =
        ();{ i_856 = i_856_alloc () (* discrete *)  } in
  let since_copy source dest =
    i_856_copy source.i_856 dest.i_856 (* discrete *) in
  let since_reset self  =
    (i_856_reset self.i_856 :unit) in 
  let since_step self ((x_645:MyOp.t) , (y_646:MyOp.t)) =
    (i_856_step self.i_856 (x_645 , y_646):MyOp.t) in
  Cnode { alloc = since_alloc; copy = since_copy ;
                               reset = since_reset ; step = since_step }
type ('b , 'a) _onceBfromlastAtoC =
  { mutable i_858 : 'b ; mutable i_857 : 'a }

let onceBfromlastAtoC  = 
  let Cnode { alloc = i_858_alloc; copy = i_858_copy ;
                                   step = i_858_step ; reset = i_858_reset } = sincelast 
   in 
  let Cnode { alloc = i_857_alloc; copy = i_857_copy ;
                                   step = i_857_step ; reset = i_857_reset } = never 
   in
  let onceBfromlastAtoC_alloc _ =
    ();
    { i_858 = i_858_alloc () (* discrete *)  ;
      i_857 = i_857_alloc () (* discrete *)  } in
  let onceBfromlastAtoC_copy source dest =
    i_858_copy source.i_858 dest.i_858 (* discrete *) ;
    i_857_copy source.i_857 dest.i_857 (* discrete *) in
  let onceBfromlastAtoC_reset self  =
    ((i_858_reset self.i_858  ; i_857_reset self.i_857 ):unit) in 
  let onceBfromlastAtoC_step self ((a_647:MyOp.t) ,
                                   (b_648:MyOp.t) , (c_649:MyOp.t)) =
    (implies (c_649 ,
              (q_or ((i_857_step self.i_857 a_647) ,
                     (i_858_step self.i_858 (b_648 , a_647))))):MyOp.t) in
  Cnode { alloc = onceBfromlastAtoC_alloc; copy = onceBfromlastAtoC_copy ;
                                           reset = onceBfromlastAtoC_reset ;
                                           step = onceBfromlastAtoC_step }
type ('b , 'a) _onceBfromfirstAtoC =
  { mutable i_860 : 'b ; mutable i_859 : 'a }

let onceBfromfirstAtoC  = 
  let Cnode { alloc = i_860_alloc; copy = i_860_copy ;
                                   step = i_860_step ; reset = i_860_reset } = sincefirst 
   in 
  let Cnode { alloc = i_859_alloc; copy = i_859_copy ;
                                   step = i_859_step ; reset = i_859_reset } = never 
   in
  let onceBfromfirstAtoC_alloc _ =
    ();
    { i_860 = i_860_alloc () (* discrete *)  ;
      i_859 = i_859_alloc () (* discrete *)  } in
  let onceBfromfirstAtoC_copy source dest =
    i_860_copy source.i_860 dest.i_860 (* discrete *) ;
    i_859_copy source.i_859 dest.i_859 (* discrete *) in
  let onceBfromfirstAtoC_reset self  =
    ((i_860_reset self.i_860  ; i_859_reset self.i_859 ):unit) in 
  let onceBfromfirstAtoC_step self ((a_650:MyOp.t) ,
                                    (b_651:MyOp.t) , (c_652:MyOp.t)) =
    (implies (c_652 ,
              (q_or ((i_859_step self.i_859 a_650) ,
                     (i_860_step self.i_860 (b_651 , a_650))))):MyOp.t) in
  Cnode { alloc = onceBfromfirstAtoC_alloc; copy = onceBfromfirstAtoC_copy ;
                                            reset = onceBfromfirstAtoC_reset
                                            ; step = onceBfromfirstAtoC_step }
type ('a) _onceBfromAtoC =
  { mutable i_861 : 'a }

let onceBfromAtoC  = 
  let Cnode { alloc = i_861_alloc; copy = i_861_copy ;
                                   step = i_861_step ; reset = i_861_reset } = onceBfromlastAtoC 
   in
  let onceBfromAtoC_alloc _ =
    ();{ i_861 = i_861_alloc () (* discrete *)  } in
  let onceBfromAtoC_copy source dest =
    i_861_copy source.i_861 dest.i_861 (* discrete *) in
  let onceBfromAtoC_reset self  =
    (i_861_reset self.i_861 :unit) in 
  let onceBfromAtoC_step self ((a_653:MyOp.t) ,
                               (b_654:MyOp.t) , (c_655:MyOp.t)) =
    (i_861_step self.i_861 (a_653 , b_654 , c_655):MyOp.t) in
  Cnode { alloc = onceBfromAtoC_alloc; copy = onceBfromAtoC_copy ;
                                       reset = onceBfromAtoC_reset ;
                                       step = onceBfromAtoC_step }
type ('b , 'a) _alwaysBfromlastAtoC =
  { mutable i_863 : 'b ; mutable i_862 : 'a }

let alwaysBfromlastAtoC  = 
  let Cnode { alloc = i_863_alloc; copy = i_863_copy ;
                                   step = i_863_step ; reset = i_863_reset } = sincelast 
   in 
  let Cnode { alloc = i_862_alloc; copy = i_862_copy ;
                                   step = i_862_step ; reset = i_862_reset } = never 
   in
  let alwaysBfromlastAtoC_alloc _ =
    ();
    { i_863 = i_863_alloc () (* discrete *)  ;
      i_862 = i_862_alloc () (* discrete *)  } in
  let alwaysBfromlastAtoC_copy source dest =
    i_863_copy source.i_863 dest.i_863 (* discrete *) ;
    i_862_copy source.i_862 dest.i_862 (* discrete *) in
  let alwaysBfromlastAtoC_reset self  =
    ((i_863_reset self.i_863  ; i_862_reset self.i_862 ):unit) in 
  let alwaysBfromlastAtoC_step self ((a_656:MyOp.t) ,
                                     (b_657:MyOp.t) , (c_658:MyOp.t)) =
    (implies (c_658 ,
              (q_or ((i_862_step self.i_862 a_656) ,
                     (q_not (i_863_step self.i_863 ((q_not b_657) , a_656)))))):
    MyOp.t) in
  Cnode { alloc = alwaysBfromlastAtoC_alloc; copy = alwaysBfromlastAtoC_copy
                                             ;
                                             reset = alwaysBfromlastAtoC_reset
                                             ;
                                             step = alwaysBfromlastAtoC_step }
type ('b , 'a) _alwaysBfromfirstAtoC =
  { mutable i_865 : 'b ; mutable i_864 : 'a }

let alwaysBfromfirstAtoC  = 
  let Cnode { alloc = i_865_alloc; copy = i_865_copy ;
                                   step = i_865_step ; reset = i_865_reset } = sincefirst 
   in 
  let Cnode { alloc = i_864_alloc; copy = i_864_copy ;
                                   step = i_864_step ; reset = i_864_reset } = never 
   in
  let alwaysBfromfirstAtoC_alloc _ =
    ();
    { i_865 = i_865_alloc () (* discrete *)  ;
      i_864 = i_864_alloc () (* discrete *)  } in
  let alwaysBfromfirstAtoC_copy source dest =
    i_865_copy source.i_865 dest.i_865 (* discrete *) ;
    i_864_copy source.i_864 dest.i_864 (* discrete *) in
  let alwaysBfromfirstAtoC_reset self  =
    ((i_865_reset self.i_865  ; i_864_reset self.i_864 ):unit) in 
  let alwaysBfromfirstAtoC_step self ((a_659:MyOp.t) ,
                                      (b_660:MyOp.t) , (c_661:MyOp.t)) =
    (implies (c_661 ,
              (q_or ((i_864_step self.i_864 a_659) ,
                     (q_not (i_865_step self.i_865 ((q_not b_660) , a_659)))))):
    MyOp.t) in
  Cnode { alloc = alwaysBfromfirstAtoC_alloc; copy = alwaysBfromfirstAtoC_copy
                                              ;
                                              reset = alwaysBfromfirstAtoC_reset
                                              ;
                                              step = alwaysBfromfirstAtoC_step }
type ('a) _alwaysBfromAtoC =
  { mutable i_866 : 'a }

let alwaysBfromAtoC  = 
  let Cnode { alloc = i_866_alloc; copy = i_866_copy ;
                                   step = i_866_step ; reset = i_866_reset } = alwaysBfromlastAtoC 
   in
  let alwaysBfromAtoC_alloc _ =
    ();{ i_866 = i_866_alloc () (* discrete *)  } in
  let alwaysBfromAtoC_copy source dest =
    i_866_copy source.i_866 dest.i_866 (* discrete *) in
  let alwaysBfromAtoC_reset self  =
    (i_866_reset self.i_866 :unit) in 
  let alwaysBfromAtoC_step self ((a_662:MyOp.t) ,
                                 (b_663:MyOp.t) , (c_664:MyOp.t)) =
    (i_866_step self.i_866 (a_662 , b_663 , c_664):MyOp.t) in
  Cnode { alloc = alwaysBfromAtoC_alloc; copy = alwaysBfromAtoC_copy ;
                                         reset = alwaysBfromAtoC_reset ;
                                         step = alwaysBfromAtoC_step }
type ('a) _neverBfromlastAtoC =
  { mutable i_867 : 'a }

let neverBfromlastAtoC  = 
  let Cnode { alloc = i_867_alloc; copy = i_867_copy ;
                                   step = i_867_step ; reset = i_867_reset } = alwaysBfromlastAtoC 
   in
  let neverBfromlastAtoC_alloc _ =
    ();{ i_867 = i_867_alloc () (* discrete *)  } in
  let neverBfromlastAtoC_copy source dest =
    i_867_copy source.i_867 dest.i_867 (* discrete *) in
  let neverBfromlastAtoC_reset self  =
    (i_867_reset self.i_867 :unit) in 
  let neverBfromlastAtoC_step self ((a_665:MyOp.t) ,
                                    (b_666:MyOp.t) , (c_667:MyOp.t)) =
    (i_867_step self.i_867 (a_665 , (q_not b_666) , c_667):MyOp.t) in
  Cnode { alloc = neverBfromlastAtoC_alloc; copy = neverBfromlastAtoC_copy ;
                                            reset = neverBfromlastAtoC_reset
                                            ; step = neverBfromlastAtoC_step }
type ('a) _neverBfromfirstAtoC =
  { mutable i_868 : 'a }

let neverBfromfirstAtoC  = 
  let Cnode { alloc = i_868_alloc; copy = i_868_copy ;
                                   step = i_868_step ; reset = i_868_reset } = alwaysBfromfirstAtoC 
   in
  let neverBfromfirstAtoC_alloc _ =
    ();{ i_868 = i_868_alloc () (* discrete *)  } in
  let neverBfromfirstAtoC_copy source dest =
    i_868_copy source.i_868 dest.i_868 (* discrete *) in
  let neverBfromfirstAtoC_reset self  =
    (i_868_reset self.i_868 :unit) in 
  let neverBfromfirstAtoC_step self ((a_668:MyOp.t) ,
                                     (b_669:MyOp.t) , (c_670:MyOp.t)) =
    (i_868_step self.i_868 (a_668 , (q_not b_669) , c_670):MyOp.t) in
  Cnode { alloc = neverBfromfirstAtoC_alloc; copy = neverBfromfirstAtoC_copy
                                             ;
                                             reset = neverBfromfirstAtoC_reset
                                             ;
                                             step = neverBfromfirstAtoC_step }
type ('a) _neverBfromAtoC =
  { mutable i_869 : 'a }

let neverBfromAtoC  = 
  let Cnode { alloc = i_869_alloc; copy = i_869_copy ;
                                   step = i_869_step ; reset = i_869_reset } = alwaysBfromAtoC 
   in
  let neverBfromAtoC_alloc _ =
    ();{ i_869 = i_869_alloc () (* discrete *)  } in
  let neverBfromAtoC_copy source dest =
    i_869_copy source.i_869 dest.i_869 (* discrete *) in
  let neverBfromAtoC_reset self  =
    (i_869_reset self.i_869 :unit) in 
  let neverBfromAtoC_step self ((a_671:MyOp.t) ,
                                (b_672:MyOp.t) , (c_673:MyOp.t)) =
    (i_869_step self.i_869 (a_671 , (q_not b_672) , c_673):MyOp.t) in
  Cnode { alloc = neverBfromAtoC_alloc; copy = neverBfromAtoC_copy ;
                                        reset = neverBfromAtoC_reset ;
                                        step = neverBfromAtoC_step }
type ('b , 'a) _horizon =
  { mutable i_870 : 'b ; mutable m_681 : 'a }

let horizon (delay_674:float) = 
  let Cnode { alloc = i_870_alloc; copy = i_870_copy ;
                                   step = i_870_step ; reset = i_870_reset } = 
  counter delay_674  in
  let horizon_alloc _ =
    ();{ m_681 = (false:bool);i_870 = i_870_alloc () (* discrete *)  } in
  let horizon_copy source dest =
    dest.m_681 <- source.m_681;
    i_870_copy source.i_870 dest.i_870 (* discrete *) in
  let horizon_reset self  =
    ((self.m_681 <- true ; i_870_reset self.i_870 ):unit) in 
  let horizon_step self (tstep_675:MyOp.t) =
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
      (let (cpt_676:MyOp.t) =
           i_870_step self.i_870
             (tstep_675 ,
              (!resultv_677 , !resultp_678) , (!resultv_679 , !resultp_680)) in
       q_lt (cpt_676 , (MyOp.zero ())))):MyOp.t) in
  Cnode { alloc = horizon_alloc; copy = horizon_copy ;
                                 reset = horizon_reset ; step = horizon_step }
type ('e , 'd , 'c , 'b , 'a) _once_timed =
  { mutable i_872 : 'e ;
    mutable i_871 : 'd ;
    mutable i_699 : 'c ; mutable m_694 : 'b ; mutable m_692 : 'a }

let once_timed (delay_683:float) = 
  let Cnode { alloc = i_872_alloc; copy = i_872_copy ;
                                   step = i_872_step ; reset = i_872_reset } = 
  counter delay_683  in 
  let Cnode { alloc = i_871_alloc; copy = i_871_copy ;
                                   step = i_871_step ; reset = i_871_reset } = once 
   in
  let once_timed_alloc _ =
    ();
    { i_699 = (false:bool) ;
      m_694 = (create ():MyOp.t) ; m_692 = (false:bool);
      i_872 = i_872_alloc () (* discrete *)  ;
      i_871 = i_871_alloc () (* discrete *)  } in
  let once_timed_copy source dest =
    dest.i_699 <- source.i_699 ;
    dest.m_694 <- source.m_694 ; dest.m_692 <- source.m_692;
    i_872_copy source.i_872 dest.i_872 (* discrete *) ;
    i_871_copy source.i_871 dest.i_871 (* discrete *) in
  let once_timed_reset self  =
    ((self.i_699 <- true ;
      self.m_692 <- true ; i_872_reset self.i_872  ; i_871_reset self.i_871 ):
    unit) in 
  let once_timed_step self ((tstep_685:MyOp.t) , (p_684:MyOp.t)) =
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
       (let (cpt_686:MyOp.t) =
            i_872_step self.i_872
              (tstep_685 ,
               (!resultv_688 , !resultp_689) , (!resultv_690 , !resultp_691)) in
        let (x_696:MyOp.t) = i_871_step self.i_871 p_684 in
        let (x_698:MyOp.t) =
            if self.i_699
            then p_684
            else if (<) cpt_686  (MyOp.make 0.) then self.m_694 else x_696 in
        self.i_699 <- false ;
        self.m_692 <- false ; self.m_694 <- x_698 ; x_698))):MyOp.t) in
  Cnode { alloc = once_timed_alloc; copy = once_timed_copy ;
                                    reset = once_timed_reset ;
                                    step = once_timed_step }
type ('e , 'd , 'c , 'b , 'a) _always_timed =
  { mutable i_874 : 'e ;
    mutable i_873 : 'd ;
    mutable i_716 : 'c ; mutable m_711 : 'b ; mutable m_709 : 'a }

let always_timed (delay_700:float) = 
  let Cnode { alloc = i_874_alloc; copy = i_874_copy ;
                                   step = i_874_step ; reset = i_874_reset } = 
  counter delay_700  in 
  let Cnode { alloc = i_873_alloc; copy = i_873_copy ;
                                   step = i_873_step ; reset = i_873_reset } = always 
   in
  let always_timed_alloc _ =
    ();
    { i_716 = (false:bool) ;
      m_711 = (create ():MyOp.t) ; m_709 = (false:bool);
      i_874 = i_874_alloc () (* discrete *)  ;
      i_873 = i_873_alloc () (* discrete *)  } in
  let always_timed_copy source dest =
    dest.i_716 <- source.i_716 ;
    dest.m_711 <- source.m_711 ; dest.m_709 <- source.m_709;
    i_874_copy source.i_874 dest.i_874 (* discrete *) ;
    i_873_copy source.i_873 dest.i_873 (* discrete *) in
  let always_timed_reset self  =
    ((self.i_716 <- true ;
      self.m_709 <- true ; i_874_reset self.i_874  ; i_873_reset self.i_873 ):
    unit) in 
  let always_timed_step self ((tstep_702:MyOp.t) , (p_701:MyOp.t)) =
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
       (let (cpt_703:MyOp.t) =
            i_874_step self.i_874
              (tstep_702 ,
               (!resultv_705 , !resultp_706) , (!resultv_707 , !resultp_708)) in
        let (x_713:MyOp.t) = i_873_step self.i_873 p_701 in
        let (x_715:MyOp.t) =
            if self.i_716
            then p_701
            else if (<) cpt_703  (MyOp.make 0.) then self.m_711 else x_713 in
        self.i_716 <- false ;
        self.m_709 <- false ; self.m_711 <- x_715 ; x_715))):MyOp.t) in
  Cnode { alloc = always_timed_alloc; copy = always_timed_copy ;
                                      reset = always_timed_reset ;
                                      step = always_timed_step }
type ('a) _never_timed =
  { mutable i_875 : 'a }

let never_timed (delay_717:float) = 
  let Cnode { alloc = i_875_alloc; copy = i_875_copy ;
                                   step = i_875_step ; reset = i_875_reset } = 
  always_timed delay_717  in
  let never_timed_alloc _ =
    ();{ i_875 = i_875_alloc () (* discrete *)  } in
  let never_timed_copy source dest =
    i_875_copy source.i_875 dest.i_875 (* discrete *) in
  let never_timed_reset self  =
    (i_875_reset self.i_875 :unit) in 
  let never_timed_step self ((tstep_719:MyOp.t) , (p_718:MyOp.t)) =
    (i_875_step self.i_875 (tstep_719 , (q_not p_718)):MyOp.t) in
  Cnode { alloc = never_timed_alloc; copy = never_timed_copy ;
                                     reset = never_timed_reset ;
                                     step = never_timed_step }
type ('b , 'a) _onceBfromlastA =
  { mutable i_877 : 'b ; mutable i_876 : 'a }

let onceBfromlastA  = 
  let Cnode { alloc = i_877_alloc; copy = i_877_copy ;
                                   step = i_877_step ; reset = i_877_reset } = sincelast 
   in 
  let Cnode { alloc = i_876_alloc; copy = i_876_copy ;
                                   step = i_876_step ; reset = i_876_reset } = never 
   in
  let onceBfromlastA_alloc _ =
    ();
    { i_877 = i_877_alloc () (* discrete *)  ;
      i_876 = i_876_alloc () (* discrete *)  } in
  let onceBfromlastA_copy source dest =
    i_877_copy source.i_877 dest.i_877 (* discrete *) ;
    i_876_copy source.i_876 dest.i_876 (* discrete *) in
  let onceBfromlastA_reset self  =
    ((i_877_reset self.i_877  ; i_876_reset self.i_876 ):unit) in 
  let onceBfromlastA_step self ((a_720:MyOp.t) , (b_721:MyOp.t)) =
    (q_or ((i_876_step self.i_876 a_720) ,
           (i_877_step self.i_877 (b_721 , a_720))):MyOp.t) in
  Cnode { alloc = onceBfromlastA_alloc; copy = onceBfromlastA_copy ;
                                        reset = onceBfromlastA_reset ;
                                        step = onceBfromlastA_step }
type ('b , 'a) _onceBfromfirstA =
  { mutable i_879 : 'b ; mutable i_878 : 'a }

let onceBfromfirstA  = 
  let Cnode { alloc = i_879_alloc; copy = i_879_copy ;
                                   step = i_879_step ; reset = i_879_reset } = sincefirst 
   in 
  let Cnode { alloc = i_878_alloc; copy = i_878_copy ;
                                   step = i_878_step ; reset = i_878_reset } = never 
   in
  let onceBfromfirstA_alloc _ =
    ();
    { i_879 = i_879_alloc () (* discrete *)  ;
      i_878 = i_878_alloc () (* discrete *)  } in
  let onceBfromfirstA_copy source dest =
    i_879_copy source.i_879 dest.i_879 (* discrete *) ;
    i_878_copy source.i_878 dest.i_878 (* discrete *) in
  let onceBfromfirstA_reset self  =
    ((i_879_reset self.i_879  ; i_878_reset self.i_878 ):unit) in 
  let onceBfromfirstA_step self ((a_722:MyOp.t) , (b_723:MyOp.t)) =
    (q_or ((i_878_step self.i_878 a_722) ,
           (i_879_step self.i_879 (b_723 , a_722))):MyOp.t) in
  Cnode { alloc = onceBfromfirstA_alloc; copy = onceBfromfirstA_copy ;
                                         reset = onceBfromfirstA_reset ;
                                         step = onceBfromfirstA_step }
type ('a) _onceBfromA =
  { mutable i_880 : 'a }

let onceBfromA  = 
  let Cnode { alloc = i_880_alloc; copy = i_880_copy ;
                                   step = i_880_step ; reset = i_880_reset } = onceBfromlastA 
   in
  let onceBfromA_alloc _ =
    ();{ i_880 = i_880_alloc () (* discrete *)  } in
  let onceBfromA_copy source dest =
    i_880_copy source.i_880 dest.i_880 (* discrete *) in
  let onceBfromA_reset self  =
    (i_880_reset self.i_880 :unit) in 
  let onceBfromA_step self ((a_724:MyOp.t) , (b_725:MyOp.t)) =
    (i_880_step self.i_880 (a_724 , b_725):MyOp.t) in
  Cnode { alloc = onceBfromA_alloc; copy = onceBfromA_copy ;
                                    reset = onceBfromA_reset ;
                                    step = onceBfromA_step }
type ('b , 'a) _alwaysBfromlastA =
  { mutable i_882 : 'b ; mutable i_881 : 'a }

let alwaysBfromlastA  = 
  let Cnode { alloc = i_882_alloc; copy = i_882_copy ;
                                   step = i_882_step ; reset = i_882_reset } = sincelast 
   in 
  let Cnode { alloc = i_881_alloc; copy = i_881_copy ;
                                   step = i_881_step ; reset = i_881_reset } = never 
   in
  let alwaysBfromlastA_alloc _ =
    ();
    { i_882 = i_882_alloc () (* discrete *)  ;
      i_881 = i_881_alloc () (* discrete *)  } in
  let alwaysBfromlastA_copy source dest =
    i_882_copy source.i_882 dest.i_882 (* discrete *) ;
    i_881_copy source.i_881 dest.i_881 (* discrete *) in
  let alwaysBfromlastA_reset self  =
    ((i_882_reset self.i_882  ; i_881_reset self.i_881 ):unit) in 
  let alwaysBfromlastA_step self ((a_726:MyOp.t) , (b_727:MyOp.t)) =
    (q_or ((i_881_step self.i_881 a_726) ,
           (q_not (i_882_step self.i_882 ((q_not b_727) , a_726)))):MyOp.t) in
  Cnode { alloc = alwaysBfromlastA_alloc; copy = alwaysBfromlastA_copy ;
                                          reset = alwaysBfromlastA_reset ;
                                          step = alwaysBfromlastA_step }
type ('b , 'a) _alwaysBfromfirstA =
  { mutable i_884 : 'b ; mutable i_883 : 'a }

let alwaysBfromfirstA  = 
  let Cnode { alloc = i_884_alloc; copy = i_884_copy ;
                                   step = i_884_step ; reset = i_884_reset } = sincefirst 
   in 
  let Cnode { alloc = i_883_alloc; copy = i_883_copy ;
                                   step = i_883_step ; reset = i_883_reset } = never 
   in
  let alwaysBfromfirstA_alloc _ =
    ();
    { i_884 = i_884_alloc () (* discrete *)  ;
      i_883 = i_883_alloc () (* discrete *)  } in
  let alwaysBfromfirstA_copy source dest =
    i_884_copy source.i_884 dest.i_884 (* discrete *) ;
    i_883_copy source.i_883 dest.i_883 (* discrete *) in
  let alwaysBfromfirstA_reset self  =
    ((i_884_reset self.i_884  ; i_883_reset self.i_883 ):unit) in 
  let alwaysBfromfirstA_step self ((a_728:MyOp.t) , (b_729:MyOp.t)) =
    (q_or ((i_883_step self.i_883 a_728) ,
           (q_not (i_884_step self.i_884 ((q_not b_729) , a_728)))):MyOp.t) in
  Cnode { alloc = alwaysBfromfirstA_alloc; copy = alwaysBfromfirstA_copy ;
                                           reset = alwaysBfromfirstA_reset ;
                                           step = alwaysBfromfirstA_step }
type ('a) _alwaysBfromA =
  { mutable i_885 : 'a }

let alwaysBfromA  = 
  let Cnode { alloc = i_885_alloc; copy = i_885_copy ;
                                   step = i_885_step ; reset = i_885_reset } = alwaysBfromlastA 
   in
  let alwaysBfromA_alloc _ =
    ();{ i_885 = i_885_alloc () (* discrete *)  } in
  let alwaysBfromA_copy source dest =
    i_885_copy source.i_885 dest.i_885 (* discrete *) in
  let alwaysBfromA_reset self  =
    (i_885_reset self.i_885 :unit) in 
  let alwaysBfromA_step self ((a_730:MyOp.t) , (b_731:MyOp.t)) =
    (i_885_step self.i_885 (a_730 , b_731):MyOp.t) in
  Cnode { alloc = alwaysBfromA_alloc; copy = alwaysBfromA_copy ;
                                      reset = alwaysBfromA_reset ;
                                      step = alwaysBfromA_step }
type ('a) _neverBfromlastA =
  { mutable i_886 : 'a }

let neverBfromlastA  = 
  let Cnode { alloc = i_886_alloc; copy = i_886_copy ;
                                   step = i_886_step ; reset = i_886_reset } = alwaysBfromlastA 
   in
  let neverBfromlastA_alloc _ =
    ();{ i_886 = i_886_alloc () (* discrete *)  } in
  let neverBfromlastA_copy source dest =
    i_886_copy source.i_886 dest.i_886 (* discrete *) in
  let neverBfromlastA_reset self  =
    (i_886_reset self.i_886 :unit) in 
  let neverBfromlastA_step self ((a_732:MyOp.t) , (b_733:MyOp.t)) =
    (i_886_step self.i_886 (a_732 , (q_not b_733)):MyOp.t) in
  Cnode { alloc = neverBfromlastA_alloc; copy = neverBfromlastA_copy ;
                                         reset = neverBfromlastA_reset ;
                                         step = neverBfromlastA_step }
type ('a) _neverBfromfirstA =
  { mutable i_887 : 'a }

let neverBfromfirstA  = 
  let Cnode { alloc = i_887_alloc; copy = i_887_copy ;
                                   step = i_887_step ; reset = i_887_reset } = alwaysBfromfirstA 
   in
  let neverBfromfirstA_alloc _ =
    ();{ i_887 = i_887_alloc () (* discrete *)  } in
  let neverBfromfirstA_copy source dest =
    i_887_copy source.i_887 dest.i_887 (* discrete *) in
  let neverBfromfirstA_reset self  =
    (i_887_reset self.i_887 :unit) in 
  let neverBfromfirstA_step self ((a_734:MyOp.t) , (b_735:MyOp.t)) =
    (i_887_step self.i_887 (a_734 , (q_not b_735)):MyOp.t) in
  Cnode { alloc = neverBfromfirstA_alloc; copy = neverBfromfirstA_copy ;
                                          reset = neverBfromfirstA_reset ;
                                          step = neverBfromfirstA_step }
type ('a) _neverBfromA =
  { mutable i_888 : 'a }

let neverBfromA  = 
  let Cnode { alloc = i_888_alloc; copy = i_888_copy ;
                                   step = i_888_step ; reset = i_888_reset } = neverBfromlastA 
   in
  let neverBfromA_alloc _ =
    ();{ i_888 = i_888_alloc () (* discrete *)  } in
  let neverBfromA_copy source dest =
    i_888_copy source.i_888 dest.i_888 (* discrete *) in
  let neverBfromA_reset self  =
    (i_888_reset self.i_888 :unit) in 
  let neverBfromA_step self ((a_736:MyOp.t) , (b_737:MyOp.t)) =
    (i_888_step self.i_888 (a_736 , b_737):MyOp.t) in
  Cnode { alloc = neverBfromA_alloc; copy = neverBfromA_copy ;
                                     reset = neverBfromA_reset ;
                                     step = neverBfromA_step }
type ('c , 'b , 'a) _onceBfromlastA_timed =
  { mutable i_891 : 'c ; mutable i_890 : 'b ; mutable i_889 : 'a }

let onceBfromlastA_timed (delay_740:float) = 
  let Cnode { alloc = i_891_alloc; copy = i_891_copy ;
                                   step = i_891_step ; reset = i_891_reset } = 
  counter delay_740  in 
  let Cnode { alloc = i_890_alloc; copy = i_890_copy ;
                                   step = i_890_step ; reset = i_890_reset } = onceBfromlastAtoC 
   in 
  let Cnode { alloc = i_889_alloc; copy = i_889_copy ;
                                   step = i_889_step ; reset = i_889_reset } = never 
   in
  let onceBfromlastA_timed_alloc _ =
    ();
    { i_891 = i_891_alloc () (* discrete *)  ;
      i_890 = i_890_alloc () (* discrete *)  ;
      i_889 = i_889_alloc () (* discrete *)  } in
  let onceBfromlastA_timed_copy source dest =
    i_891_copy source.i_891 dest.i_891 (* discrete *) ;
    i_890_copy source.i_890 dest.i_890 (* discrete *) ;
    i_889_copy source.i_889 dest.i_889 (* discrete *) in
  let onceBfromlastA_timed_reset self  =
    ((i_891_reset self.i_891  ;
      i_890_reset self.i_890  ; i_889_reset self.i_889 ):unit) in 
  let onceBfromlastA_timed_step self ((tstep_741:MyOp.t) ,
                                      (a_738:MyOp.t) , (b_739:MyOp.t)) =
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
      (let (cpt_742:MyOp.t) =
           i_891_step self.i_891
             (tstep_741 ,
              (!resultv_745 , !resultp_746) , (!resultv_747 , !resultp_748)) in
       q_or ((i_889_step self.i_889 a_738) ,
             (i_890_step self.i_890
                (a_738 , b_739 , (q_lt (cpt_742 , (MyOp.zero ())))))))):
    MyOp.t) in
  Cnode { alloc = onceBfromlastA_timed_alloc; copy = onceBfromlastA_timed_copy
                                              ;
                                              reset = onceBfromlastA_timed_reset
                                              ;
                                              step = onceBfromlastA_timed_step }
type ('d , 'c , 'b , 'a) _onceBfromfirstA_timed =
  { mutable i_895 : 'd ;
    mutable i_894 : 'c ; mutable i_893 : 'b ; mutable i_892 : 'a }

let onceBfromfirstA_timed (delay_751:float) = 
  let Cnode { alloc = i_895_alloc; copy = i_895_copy ;
                                   step = i_895_step ; reset = i_895_reset } = once 
   in 
  let Cnode { alloc = i_894_alloc; copy = i_894_copy ;
                                   step = i_894_step ; reset = i_894_reset } = 
  counter delay_751  in 
  let Cnode { alloc = i_893_alloc; copy = i_893_copy ;
                                   step = i_893_step ; reset = i_893_reset } = onceBfromfirstAtoC 
   in 
  let Cnode { alloc = i_892_alloc; copy = i_892_copy ;
                                   step = i_892_step ; reset = i_892_reset } = never 
   in
  let onceBfromfirstA_timed_alloc _ =
    ();
    { i_895 = i_895_alloc () (* discrete *)  ;
      i_894 = i_894_alloc () (* discrete *)  ;
      i_893 = i_893_alloc () (* discrete *)  ;
      i_892 = i_892_alloc () (* discrete *)  } in
  let onceBfromfirstA_timed_copy source dest =
    i_895_copy source.i_895 dest.i_895 (* discrete *) ;
    i_894_copy source.i_894 dest.i_894 (* discrete *) ;
    i_893_copy source.i_893 dest.i_893 (* discrete *) ;
    i_892_copy source.i_892 dest.i_892 (* discrete *) in
  let onceBfromfirstA_timed_reset self  =
    ((i_895_reset self.i_895  ;
      i_894_reset self.i_894  ;
      i_893_reset self.i_893  ; i_892_reset self.i_892 ):unit) in 
  let onceBfromfirstA_timed_step self ((tstep_752:MyOp.t) ,
                                       (a_749:MyOp.t) , (b_750:MyOp.t)) =
    ((let resultp_758 = ref (false:bool) in
      let resultv_757 = ref (():unit) in
      let resultp_756 = ref (false:bool) in
      let resultv_755 = ref (():unit) in
      (begin match false with
             | true -> resultp_758 := true ; resultv_757 := () | _ -> ()  end)
      ;
      (let (p_754:MyOp.t) = i_895_step self.i_895 a_749 in
       (begin match isTrue p_754 with
              | true -> resultp_756 := true ; resultv_755 := () | _ -> ()  end)
       ;
       (let (cpt_753:MyOp.t) =
            i_894_step self.i_894
              (tstep_752 ,
               (!resultv_755 , !resultp_756) , (!resultv_757 , !resultp_758)) in
        q_or ((i_892_step self.i_892 a_749) ,
              (i_893_step self.i_893
                 (a_749 , b_750 , (q_lt (cpt_753 , (MyOp.zero ()))))))))):
    MyOp.t) in
  Cnode { alloc = onceBfromfirstA_timed_alloc; copy = onceBfromfirstA_timed_copy
                                               ;
                                               reset = onceBfromfirstA_timed_reset
                                               ;
                                               step = onceBfromfirstA_timed_step }
type ('a) _onceBfromA_timed =
  { mutable i_896 : 'a }

let onceBfromA_timed (delay_761:float) = 
  let Cnode { alloc = i_896_alloc; copy = i_896_copy ;
                                   step = i_896_step ; reset = i_896_reset } = 
  onceBfromlastA_timed delay_761  in
  let onceBfromA_timed_alloc _ =
    ();{ i_896 = i_896_alloc () (* discrete *)  } in
  let onceBfromA_timed_copy source dest =
    i_896_copy source.i_896 dest.i_896 (* discrete *) in
  let onceBfromA_timed_reset self  =
    (i_896_reset self.i_896 :unit) in 
  let onceBfromA_timed_step self ((tstep_762:MyOp.t) ,
                                  (a_759:MyOp.t) , (b_760:MyOp.t)) =
    (i_896_step self.i_896 (tstep_762 , a_759 , b_760):MyOp.t) in
  Cnode { alloc = onceBfromA_timed_alloc; copy = onceBfromA_timed_copy ;
                                          reset = onceBfromA_timed_reset ;
                                          step = onceBfromA_timed_step }
type ('c , 'b , 'a) _alwaysBfromlastA_timed =
  { mutable i_899 : 'c ; mutable i_898 : 'b ; mutable i_897 : 'a }

let alwaysBfromlastA_timed (delay_765:float) = 
  let Cnode { alloc = i_899_alloc; copy = i_899_copy ;
                                   step = i_899_step ; reset = i_899_reset } = 
  counter delay_765  in 
  let Cnode { alloc = i_898_alloc; copy = i_898_copy ;
                                   step = i_898_step ; reset = i_898_reset } = sincelast 
   in 
  let Cnode { alloc = i_897_alloc; copy = i_897_copy ;
                                   step = i_897_step ; reset = i_897_reset } = never 
   in
  let alwaysBfromlastA_timed_alloc _ =
    ();
    { i_899 = i_899_alloc () (* discrete *)  ;
      i_898 = i_898_alloc () (* discrete *)  ;
      i_897 = i_897_alloc () (* discrete *)  } in
  let alwaysBfromlastA_timed_copy source dest =
    i_899_copy source.i_899 dest.i_899 (* discrete *) ;
    i_898_copy source.i_898 dest.i_898 (* discrete *) ;
    i_897_copy source.i_897 dest.i_897 (* discrete *) in
  let alwaysBfromlastA_timed_reset self  =
    ((i_899_reset self.i_899  ;
      i_898_reset self.i_898  ; i_897_reset self.i_897 ):unit) in 
  let alwaysBfromlastA_timed_step self ((tstep_766:MyOp.t) ,
                                        (a_763:MyOp.t) , (b_764:MyOp.t)) =
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
      (let (cpt_767:MyOp.t) =
           i_899_step self.i_899
             (tstep_766 ,
              (!resultv_770 , !resultp_771) , (!resultv_772 , !resultp_773)) in
       q_or ((i_897_step self.i_897 a_763) ,
             (implies ((q_gt (cpt_767 , (MyOp.zero ()))) ,
                       (q_not (i_898_step self.i_898 ((q_not b_764) , a_763)))))))):
    MyOp.t) in
  Cnode { alloc = alwaysBfromlastA_timed_alloc; copy = alwaysBfromlastA_timed_copy
                                                ;
                                                reset = alwaysBfromlastA_timed_reset
                                                ;
                                                step = alwaysBfromlastA_timed_step }
type ('d , 'c , 'b , 'a) _alwaysBfromfirstA_timed =
  { mutable i_903 : 'd ;
    mutable i_902 : 'c ; mutable i_901 : 'b ; mutable i_900 : 'a }

let alwaysBfromfirstA_timed (delay_776:float) = 
  let Cnode { alloc = i_903_alloc; copy = i_903_copy ;
                                   step = i_903_step ; reset = i_903_reset } = once 
   in 
  let Cnode { alloc = i_902_alloc; copy = i_902_copy ;
                                   step = i_902_step ; reset = i_902_reset } = 
  counter delay_776  in 
  let Cnode { alloc = i_901_alloc; copy = i_901_copy ;
                                   step = i_901_step ; reset = i_901_reset } = sincefirst 
   in 
  let Cnode { alloc = i_900_alloc; copy = i_900_copy ;
                                   step = i_900_step ; reset = i_900_reset } = never 
   in
  let alwaysBfromfirstA_timed_alloc _ =
    ();
    { i_903 = i_903_alloc () (* discrete *)  ;
      i_902 = i_902_alloc () (* discrete *)  ;
      i_901 = i_901_alloc () (* discrete *)  ;
      i_900 = i_900_alloc () (* discrete *)  } in
  let alwaysBfromfirstA_timed_copy source dest =
    i_903_copy source.i_903 dest.i_903 (* discrete *) ;
    i_902_copy source.i_902 dest.i_902 (* discrete *) ;
    i_901_copy source.i_901 dest.i_901 (* discrete *) ;
    i_900_copy source.i_900 dest.i_900 (* discrete *) in
  let alwaysBfromfirstA_timed_reset self  =
    ((i_903_reset self.i_903  ;
      i_902_reset self.i_902  ;
      i_901_reset self.i_901  ; i_900_reset self.i_900 ):unit) in 
  let alwaysBfromfirstA_timed_step self ((tstep_777:MyOp.t) ,
                                         (a_774:MyOp.t) , (b_775:MyOp.t)) =
    ((let resultp_783 = ref (false:bool) in
      let resultv_782 = ref (():unit) in
      let resultp_781 = ref (false:bool) in
      let resultv_780 = ref (():unit) in
      (begin match false with
             | true -> resultp_783 := true ; resultv_782 := () | _ -> ()  end)
      ;
      (let (p_779:MyOp.t) = i_903_step self.i_903 a_774 in
       (begin match isTrue p_779 with
              | true -> resultp_781 := true ; resultv_780 := () | _ -> ()  end)
       ;
       (let (cpt_778:MyOp.t) =
            i_902_step self.i_902
              (tstep_777 ,
               (!resultv_780 , !resultp_781) , (!resultv_782 , !resultp_783)) in
        q_or ((i_900_step self.i_900 a_774) ,
              (implies ((q_gt (cpt_778 , (MyOp.zero ()))) ,
                        (q_not (i_901_step self.i_901 ((q_not b_775) , a_774))))))))):
    MyOp.t) in
  Cnode { alloc = alwaysBfromfirstA_timed_alloc; copy = alwaysBfromfirstA_timed_copy
                                                 ;
                                                 reset = alwaysBfromfirstA_timed_reset
                                                 ;
                                                 step = alwaysBfromfirstA_timed_step }
type ('a) _alwaysBfromA_timed =
  { mutable i_904 : 'a }

let alwaysBfromA_timed (delay_786:float) = 
  let Cnode { alloc = i_904_alloc; copy = i_904_copy ;
                                   step = i_904_step ; reset = i_904_reset } = 
  alwaysBfromlastA_timed delay_786  in
  let alwaysBfromA_timed_alloc _ =
    ();{ i_904 = i_904_alloc () (* discrete *)  } in
  let alwaysBfromA_timed_copy source dest =
    i_904_copy source.i_904 dest.i_904 (* discrete *) in
  let alwaysBfromA_timed_reset self  =
    (i_904_reset self.i_904 :unit) in 
  let alwaysBfromA_timed_step self ((tstep_787:MyOp.t) ,
                                    (a_784:MyOp.t) , (b_785:MyOp.t)) =
    (i_904_step self.i_904 (tstep_787 , a_784 , b_785):MyOp.t) in
  Cnode { alloc = alwaysBfromA_timed_alloc; copy = alwaysBfromA_timed_copy ;
                                            reset = alwaysBfromA_timed_reset
                                            ; step = alwaysBfromA_timed_step }
type ('a) _neverBfromlastA_timed =
  { mutable i_905 : 'a }

let neverBfromlastA_timed (delay_790:float) = 
  let Cnode { alloc = i_905_alloc; copy = i_905_copy ;
                                   step = i_905_step ; reset = i_905_reset } = 
  alwaysBfromlastA_timed delay_790  in
  let neverBfromlastA_timed_alloc _ =
    ();{ i_905 = i_905_alloc () (* discrete *)  } in
  let neverBfromlastA_timed_copy source dest =
    i_905_copy source.i_905 dest.i_905 (* discrete *) in
  let neverBfromlastA_timed_reset self  =
    (i_905_reset self.i_905 :unit) in 
  let neverBfromlastA_timed_step self ((tstep_791:MyOp.t) ,
                                       (a_788:MyOp.t) , (b_789:MyOp.t)) =
    (i_905_step self.i_905 (tstep_791 , a_788 , (q_not b_789)):MyOp.t) in
  Cnode { alloc = neverBfromlastA_timed_alloc; copy = neverBfromlastA_timed_copy
                                               ;
                                               reset = neverBfromlastA_timed_reset
                                               ;
                                               step = neverBfromlastA_timed_step }
type ('a) _neverBfromfirstA_timed =
  { mutable i_906 : 'a }

let neverBfromfirstA_timed (delay_794:float) = 
  let Cnode { alloc = i_906_alloc; copy = i_906_copy ;
                                   step = i_906_step ; reset = i_906_reset } = 
  alwaysBfromfirstA_timed delay_794  in
  let neverBfromfirstA_timed_alloc _ =
    ();{ i_906 = i_906_alloc () (* discrete *)  } in
  let neverBfromfirstA_timed_copy source dest =
    i_906_copy source.i_906 dest.i_906 (* discrete *) in
  let neverBfromfirstA_timed_reset self  =
    (i_906_reset self.i_906 :unit) in 
  let neverBfromfirstA_timed_step self ((tstep_795:MyOp.t) ,
                                        (a_792:MyOp.t) , (b_793:MyOp.t)) =
    (i_906_step self.i_906 (tstep_795 , a_792 , (q_not b_793)):MyOp.t) in
  Cnode { alloc = neverBfromfirstA_timed_alloc; copy = neverBfromfirstA_timed_copy
                                                ;
                                                reset = neverBfromfirstA_timed_reset
                                                ;
                                                step = neverBfromfirstA_timed_step }
type ('a) _neverBfromA_timed =
  { mutable i_907 : 'a }

let neverBfromA_timed (delay_798:float) = 
  let Cnode { alloc = i_907_alloc; copy = i_907_copy ;
                                   step = i_907_step ; reset = i_907_reset } = 
  neverBfromlastA_timed delay_798  in
  let neverBfromA_timed_alloc _ =
    ();{ i_907 = i_907_alloc () (* discrete *)  } in
  let neverBfromA_timed_copy source dest =
    i_907_copy source.i_907 dest.i_907 (* discrete *) in
  let neverBfromA_timed_reset self  =
    (i_907_reset self.i_907 :unit) in 
  let neverBfromA_timed_step self ((tstep_799:MyOp.t) ,
                                   (a_796:MyOp.t) , (b_797:MyOp.t)) =
    (i_907_step self.i_907 (tstep_799 , a_796 , b_797):MyOp.t) in
  Cnode { alloc = neverBfromA_timed_alloc; copy = neverBfromA_timed_copy ;
                                           reset = neverBfromA_timed_reset ;
                                           step = neverBfromA_timed_step }
type ('a) _absence =
  { mutable i_908 : 'a }

let absence  = 
  let Cnode { alloc = i_908_alloc; copy = i_908_copy ;
                                   step = i_908_step ; reset = i_908_reset } = never 
   in let absence_alloc _ =
        ();{ i_908 = i_908_alloc () (* discrete *)  } in
  let absence_copy source dest =
    i_908_copy source.i_908 dest.i_908 (* discrete *) in
  let absence_reset self  =
    (i_908_reset self.i_908 :unit) in 
  let absence_step self (p_800:MyOp.t) =
    (i_908_step self.i_908 p_800:MyOp.t) in
  Cnode { alloc = absence_alloc; copy = absence_copy ;
                                 reset = absence_reset ; step = absence_step }
type ('b , 'a) _absence_timed =
  { mutable i_910 : 'b ; mutable i_909 : 'a }

let absence_timed (t_802:float) = 
  let Cnode { alloc = i_910_alloc; copy = i_910_copy ;
                                   step = i_910_step ; reset = i_910_reset } = neverBfromA 
   in 
  let Cnode { alloc = i_909_alloc; copy = i_909_copy ;
                                   step = i_909_step ; reset = i_909_reset } = 
  horizon t_802  in
  let absence_timed_alloc _ =
    ();
    { i_910 = i_910_alloc () (* discrete *)  ;
      i_909 = i_909_alloc () (* discrete *)  } in
  let absence_timed_copy source dest =
    i_910_copy source.i_910 dest.i_910 (* discrete *) ;
    i_909_copy source.i_909 dest.i_909 (* discrete *) in
  let absence_timed_reset self  =
    ((i_910_reset self.i_910  ; i_909_reset self.i_909 ):unit) in 
  let absence_timed_step self ((tstep_803:MyOp.t) , (p_801:MyOp.t)) =
    (i_910_step self.i_910 ((i_909_step self.i_909 tstep_803) , p_801):
    MyOp.t) in
  Cnode { alloc = absence_timed_alloc; copy = absence_timed_copy ;
                                       reset = absence_timed_reset ;
                                       step = absence_timed_step }
type ('a) _minimum_duration =
  { mutable i_911 : 'a }

let minimum_duration (t_805:float) = 
  let Cnode { alloc = i_911_alloc; copy = i_911_copy ;
                                   step = i_911_step ; reset = i_911_reset } = 
  counter t_805  in
  let minimum_duration_alloc _ =
    ();{ i_911 = i_911_alloc () (* discrete *)  } in
  let minimum_duration_copy source dest =
    i_911_copy source.i_911 dest.i_911 (* discrete *) in
  let minimum_duration_reset self  =
    (i_911_reset self.i_911 :unit) in 
  let minimum_duration_step self ((tstep_806:MyOp.t) , (p_804:MyOp.t)) =
    ((let resultp_812 = ref (false:bool) in
      let resultv_811 = ref (():unit) in
      (begin match isTrue p_804 with
             | true -> resultp_812 := true ; resultv_811 := () | _ -> ()  end)
      ;
      (let (cpt_808:MyOp.t) =
           i_911_step self.i_911
             (tstep_806 ,
              (!resultv_811 , !resultp_812) , (!resultv_811 , !resultp_812)) in
       implies ((q_not p_804) , (q_lt (cpt_808 , (MyOp.make 0.)))))):
    MyOp.t) in
  Cnode { alloc = minimum_duration_alloc; copy = minimum_duration_copy ;
                                          reset = minimum_duration_reset ;
                                          step = minimum_duration_step }
type ('a) _maximum_duration =
  { mutable i_912 : 'a }

let maximum_duration (t_814:float) = 
  let Cnode { alloc = i_912_alloc; copy = i_912_copy ;
                                   step = i_912_step ; reset = i_912_reset } = 
  counter t_814  in
  let maximum_duration_alloc _ =
    ();{ i_912 = i_912_alloc () (* discrete *)  } in
  let maximum_duration_copy source dest =
    i_912_copy source.i_912 dest.i_912 (* discrete *) in
  let maximum_duration_reset self  =
    (i_912_reset self.i_912 :unit) in 
  let maximum_duration_step self ((tstep_815:MyOp.t) , (p_813:MyOp.t)) =
    ((let resultp_821 = ref (false:bool) in
      let resultv_820 = ref (():unit) in
      (begin match isTrue p_813 with
             | true -> resultp_821 := true ; resultv_820 := () | _ -> ()  end)
      ;
      (let (cpt_817:MyOp.t) =
           i_912_step self.i_912
             (tstep_815 ,
              (!resultv_820 , !resultp_821) , (!resultv_820 , !resultp_821)) in
       implies (p_813 , (q_ge (cpt_817 , (MyOp.make 0.)))))):MyOp.t) in
  Cnode { alloc = maximum_duration_alloc; copy = maximum_duration_copy ;
                                          reset = maximum_duration_reset ;
                                          step = maximum_duration_step }
type ('b , 'a) _bounded_recurrence =
  { mutable i_913 : 'b ; mutable i_835 : 'a }

let bounded_recurrence (t_823:float) = 
  let Cnode { alloc = i_913_alloc; copy = i_913_copy ;
                                   step = i_913_step ; reset = i_913_reset } = 
  counter t_823  in
  let bounded_recurrence_alloc _ =
    ();{ i_835 = (false:bool);i_913 = i_913_alloc () (* discrete *)  } in
  let bounded_recurrence_copy source dest =
    dest.i_835 <- source.i_835;
    i_913_copy source.i_913 dest.i_913 (* discrete *) in
  let bounded_recurrence_reset self  =
    ((self.i_835 <- true ; i_913_reset self.i_913 ):unit) in 
  let bounded_recurrence_step self ((tstep_824:MyOp.t) , (p_822:MyOp.t)) =
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
       (let (cpt_826:MyOp.t) =
            i_913_step self.i_913
              (tstep_824 , x_834 , (!resultv_830 , !resultp_831)) in
        q_ge (cpt_826 , (MyOp.make 0.))))):MyOp.t) in
  Cnode { alloc = bounded_recurrence_alloc; copy = bounded_recurrence_copy ;
                                            reset = bounded_recurrence_reset
                                            ; step = bounded_recurrence_step }
type ('c , 'b , 'a) _bounded_response =
  { mutable i_915 : 'c ; mutable i_914 : 'b ; mutable result_840 : 'a }

let bounded_response (t_838:float) = 
  let Cnode { alloc = i_915_alloc; copy = i_915_copy ;
                                   step = i_915_step ; reset = i_915_reset } = 
  onceBfromfirstA_timed t_838  in 
  let Cnode { alloc = i_914_alloc; copy = i_914_copy ;
                                   step = i_914_step ; reset = i_914_reset } = never 
   in
  let bounded_response_alloc _ =
    ();
    { result_840 = (create ():MyOp.t);
      i_915 = i_915_alloc () (* discrete *)  ;
      i_914 = i_914_alloc () (* discrete *)  } in
  let bounded_response_copy source dest =
    dest.result_840 <- source.result_840;
    i_915_copy source.i_915 dest.i_915 (* discrete *) ;
    i_914_copy source.i_914 dest.i_914 (* discrete *) in
  let bounded_response_reset self  =
    ((i_915_reset self.i_915  ; i_914_reset self.i_914 ):unit) in 
  let bounded_response_step self ((tstep_839:MyOp.t) ,
                                  (p_836:MyOp.t) , (s_837:MyOp.t)) =
    (((if isTrue s_837 then
       (i_915_reset self.i_915  ; i_914_reset self.i_914 )) ;
      self.result_840 <- q_or ((i_914_step self.i_914 p_836) ,
                               (i_915_step self.i_915
                                  (tstep_839 , p_836 , s_837))) ;
      self.result_840):MyOp.t) in
  Cnode { alloc = bounded_response_alloc; copy = bounded_response_copy ;
                                          reset = bounded_response_reset ;
                                          step = bounded_response_step }
type ('a) _bounded_invariance =
  { mutable i_916 : 'a }

let bounded_invariance (t_843:float) = 
  let Cnode { alloc = i_916_alloc; copy = i_916_copy ;
                                   step = i_916_step ; reset = i_916_reset } = 
  counter t_843  in
  let bounded_invariance_alloc _ =
    ();{ i_916 = i_916_alloc () (* discrete *)  } in
  let bounded_invariance_copy source dest =
    i_916_copy source.i_916 dest.i_916 (* discrete *) in
  let bounded_invariance_reset self  =
    (i_916_reset self.i_916 :unit) in 
  let bounded_invariance_step self ((tstep_844:MyOp.t) ,
                                    (p_841:MyOp.t) , (s_842:MyOp.t)) =
    ((let resultp_851 = ref (false:bool) in
      let resultv_850 = ref (():unit) in
      (begin match ((isTrue s_842) ,
                    (isTrue p_841) , (isTrue p_841) , (isTrue s_842)) with
             | (_ , _ , true , true) | (true , true , _ , _) ->
                 resultp_851 := true ; resultv_850 := () | _ -> ()  end) ;
      (let (cpt_847:MyOp.t) =
           i_916_step self.i_916
             (tstep_844 ,
              (!resultv_850 , !resultp_851) , (!resultv_850 , !resultp_851)) in
       q_or (s_842 , (q_le (cpt_847 , (MyOp.make 0.)))))):MyOp.t) in
  Cnode { alloc = bounded_invariance_alloc; copy = bounded_invariance_copy ;
                                            reset = bounded_invariance_reset
                                            ; step = bounded_invariance_step }
