(* The Zélus compiler, version 2.1
  (mer. 06 mai 2020 13:31:20 CEST) *)
open Ztypes
type state__4678 =
Hybrid_obs_YFALSE_343 | Hybrid_obs_YTRUE_342 | Hybrid_obs_INIT_341 
type state__4677 = Hybrid_obs_YTRUE_334 | Hybrid_obs_INIT_333 
let q_true = infinity

let q_false = neg_infinity

type ('b , 'a) _no_signal =
  { mutable major_582 : 'b ; mutable x_585 : 'a }

let no_signal (cstate_903:Ztypes.cstate) = 
  
  let no_signal_alloc _ =
    cstate_903.zmax <- (+) cstate_903.zmax  1;
    { major_582 = false ; x_585 = { zin = false; zout = 1. } } in
  let no_signal_step self ((time_581:float) , ()) =
    ((let (zindex_905:int) = cstate_903.zindex in
      let zpos_907 = ref (zindex_905:int) in
      cstate_903.zindex <- (+) cstate_903.zindex  1 ;
      self.major_582 <- cstate_903.major ;
      (let (result_908:(unit)signal) =
           let resultp_584 = ref (false:bool) in
           let resultv_583 = ref (():unit) in
           self.x_585.zout <- (-1.) ;
           (begin match self.x_585.zin with
                  | true -> resultp_584 := true ; resultv_583 := ()
                  | _ -> ()  end) ; (!resultv_583 , !resultp_584) in
       (if cstate_903.major then (((self.x_585.zin <- false)))
        else (((self.x_585.zin <- Zls.get_zin cstate_903.zinvec  !zpos_907 ;
                zpos_907 := (+) !zpos_907  1)) ;
              zpos_907 := zindex_905 ;
              ((Zls.set cstate_903.zoutvec  !zpos_907  self.x_585.zout ;
                zpos_907 := (+) !zpos_907  1)))) ; result_908)):unit signal) in
   let no_signal_reset self  =
     ((()):unit) in
  Node { alloc = no_signal_alloc; step = no_signal_step ;
                                  reset = no_signal_reset }
type ('b , 'a) _now =
  { mutable major_587 : 'b ; mutable i_591 : 'a }

let now (cstate_909:Ztypes.cstate) = 
   let now_alloc _ =
     ();{ major_587 = false ; i_591 = (false:bool) } in
  let now_step self ((time_586:float) , ()) =
    ((self.major_587 <- cstate_909.major ;
      (let resultp_589 = ref (false:bool) in
       let resultv_588 = ref (():unit) in
       let (x_590:zero) = self.i_591 in
       self.i_591 <- false ;
       (begin match x_590 with
              | true -> resultp_589 := true ; resultv_588 := () | _ -> ()  end)
       ; (!resultv_588 , !resultp_589))):unit signal) in 
  let now_reset self  =
    (self.i_591 <- true:unit) in
  Node { alloc = now_alloc; step = now_step ; reset = now_reset }
let isTrue (p_592:float) =
  (>=) p_592  0.

let isFalse (p_593:float) =
  (<) p_593  0.

type ('d , 'c , 'b , 'a) _q_istrue =
  { mutable major_596 : 'd ;
    mutable i_603 : 'c ; mutable x_601 : 'b ; mutable m_599 : 'a }

let q_istrue (cstate_915:Ztypes.cstate) = 
  
  let q_istrue_alloc _ =
    cstate_915.zmax <- (+) cstate_915.zmax  1;
    { major_596 = false ;
      i_603 = (false:bool) ;
      x_601 = { zin = false; zout = 1. } ; m_599 = (42.:float) } in
  let q_istrue_step self ((time_595:float) , (p_594:float)) =
    ((let (zindex_917:int) = cstate_915.zindex in
      let zpos_919 = ref (zindex_917:int) in
      cstate_915.zindex <- (+) cstate_915.zindex  1 ;
      self.major_596 <- cstate_915.major ;
      (let (result_920:(unit)signal) =
           let resultp_598 = ref (false:bool) in
           let resultv_597 = ref (():unit) in
           let (x_602:zero) = self.i_603 in
           (if self.i_603 then self.m_599 <- p_594) ;
           self.i_603 <- false ;
           self.x_601.zout <- p_594 ;
           (let (x_600:float) = self.m_599 in
            self.m_599 <- p_594 ;
            (begin match (((&&) self.major_596  ((<>) p_594  x_600)) ,
                          (isTrue p_594) ,
                          self.x_601.zin , x_602 , (isTrue p_594)) with
                   | (_ , _ , _ , true , true) | (_ , _ , true , _ , _) | 
                                                 (true , true , _ , _ , _) ->
                       resultp_598 := true ; resultv_597 := () | _ -> ()  end)
            ; (!resultv_597 , !resultp_598)) in
       (if cstate_915.major then (((self.x_601.zin <- false)))
        else (((self.x_601.zin <- Zls.get_zin cstate_915.zinvec  !zpos_919 ;
                zpos_919 := (+) !zpos_919  1)) ;
              zpos_919 := zindex_917 ;
              ((Zls.set cstate_915.zoutvec  !zpos_919  self.x_601.zout ;
                zpos_919 := (+) !zpos_919  1)))) ; result_920)):unit signal) in
   let q_istrue_reset self  =
     (self.i_603 <- true:unit) in
  Node { alloc = q_istrue_alloc; step = q_istrue_step ;
                                 reset = q_istrue_reset }
type ('d , 'c , 'b , 'a) _q_isfalse =
  { mutable major_606 : 'd ;
    mutable i_613 : 'c ; mutable x_611 : 'b ; mutable m_609 : 'a }

let q_isfalse (cstate_921:Ztypes.cstate) = 
  
  let q_isfalse_alloc _ =
    cstate_921.zmax <- (+) cstate_921.zmax  1;
    { major_606 = false ;
      i_613 = (false:bool) ;
      x_611 = { zin = false; zout = 1. } ; m_609 = (42.:float) } in
  let q_isfalse_step self ((time_605:float) , (p_604:float)) =
    ((let (zindex_923:int) = cstate_921.zindex in
      let zpos_925 = ref (zindex_923:int) in
      cstate_921.zindex <- (+) cstate_921.zindex  1 ;
      self.major_606 <- cstate_921.major ;
      (let (result_926:(unit)signal) =
           let resultp_608 = ref (false:bool) in
           let resultv_607 = ref (():unit) in
           let (x_612:zero) = self.i_613 in
           (if self.i_613 then self.m_609 <- p_604) ;
           self.i_613 <- false ;
           self.x_611.zout <- (~-.) p_604 ;
           (let (x_610:float) = self.m_609 in
            self.m_609 <- p_604 ;
            (begin match (((&&) self.major_606  ((<>) p_604  x_610)) ,
                          (isFalse p_604) ,
                          self.x_611.zin , x_612 , (isFalse p_604)) with
                   | (_ , _ , _ , true , true) | (_ , _ , true , _ , _) | 
                                                 (true , true , _ , _ , _) ->
                       resultp_608 := true ; resultv_607 := () | _ -> ()  end)
            ; (!resultv_607 , !resultp_608)) in
       (if cstate_921.major then (((self.x_611.zin <- false)))
        else (((self.x_611.zin <- Zls.get_zin cstate_921.zinvec  !zpos_925 ;
                zpos_925 := (+) !zpos_925  1)) ;
              zpos_925 := zindex_923 ;
              ((Zls.set cstate_921.zoutvec  !zpos_925  self.x_611.zout ;
                zpos_925 := (+) !zpos_925  1)))) ; result_926)):unit signal) in
   let q_isfalse_reset self  =
     (self.i_613 <- true:unit) in
  Node { alloc = q_isfalse_alloc; step = q_isfalse_step ;
                                  reset = q_isfalse_reset }
type ('c , 'b , 'a) _ignore_first_instant =
  { mutable major_617 : 'c ; mutable i_623 : 'b ; mutable result_619 : 'a }

let ignore_first_instant (cstate_927:Ztypes.cstate) = 
  
  let ignore_first_instant_alloc _ =
    ();
    { major_617 = false ; i_623 = (false:bool) ; result_619 = (false:bool) } in
  let ignore_first_instant_step self ((time_616:float) ,
                                      ((sv_614:'a4165) , (sp_615:bool))) =
    ((self.major_617 <- cstate_927.major ;
      (let resultp_621 = ref (false:bool) in
       let resultv_620 = ref (Obj.magic ():'a) in
       let (x_622:zero) = self.i_623 in
       self.i_623 <- false ;
       (begin match x_622 with
              | true -> self.result_619 <- true
              | _ -> self.result_619 <- false  end) ;
       (begin match ((sv_614 , sp_615) , (not self.result_619)) with
              | (((x_624:'a4165) , true) , true) ->
                  resultp_621 := true ; resultv_620 := x_624 | _ -> ()  end)
       ; (!resultv_620 , !resultp_621))):'a signal) in 
  let ignore_first_instant_reset self  =
    (self.i_623 <- true:unit) in
  Node { alloc = ignore_first_instant_alloc; step = ignore_first_instant_step
                                             ;
                                             reset = ignore_first_instant_reset }
type ('c , 'b , 'a) _freeze =
  { mutable major_627 : 'c ; mutable i_629 : 'b ; mutable res_628 : 'a }

let freeze (cstate_933:Ztypes.cstate) = 
  
  let freeze_alloc _ =
    ();
    { major_627 = false ; i_629 = (false:bool) ; res_628 = (Obj.magic ():'b) } in
  let freeze_step self ((time_626:float) , (p_625:'a4167)) =
    ((self.major_627 <- cstate_933.major ;
      ((if self.i_629 then self.res_628 <- p_625) ;
       self.i_629 <- false ; self.res_628)):'b) in 
  let freeze_reset self  =
    (self.i_629 <- true:unit) in
  Node { alloc = freeze_alloc; step = freeze_step ; reset = freeze_reset }
type ('e , 'd , 'c , 'b , 'a) _q_istrue_now =
  { mutable i_869 : 'e ;
    mutable major_632 : 'd ;
    mutable i_640 : 'c ; mutable x_638 : 'b ; mutable m_636 : 'a }

let q_istrue_now (cstate_939:Ztypes.cstate) = 
  let Node { alloc = i_869_alloc; step = i_869_step ; reset = i_869_reset } = freeze 
  cstate_939 in
  let q_istrue_now_alloc _ =
    cstate_939.zmax <- (+) cstate_939.zmax  1;
    { major_632 = false ;
      i_640 = (false:bool) ;
      x_638 = { zin = false; zout = 1. } ; m_636 = (42.:float);
      i_869 = i_869_alloc () (* continuous *)  } in
  let q_istrue_now_step self ((time_631:float) , (p_630:float)) =
    ((let (zindex_941:int) = cstate_939.zindex in
      let zpos_943 = ref (zindex_941:int) in
      cstate_939.zindex <- (+) cstate_939.zindex  1 ;
      self.major_632 <- cstate_939.major ;
      (let (result_944:(unit)signal) =
           let resultp_635 = ref (false:bool) in
           let resultv_634 = ref (():unit) in
           let (x_639:zero) = self.i_640 in
           (if self.i_640 then self.m_636 <- p_630) ;
           self.i_640 <- false ;
           self.x_638.zout <- p_630 ;
           (let (x_637:float) = self.m_636 in
            self.m_636 <- p_630 ;
            (begin match (((&&) self.major_632  ((<>) p_630  x_637)) ,
                          (isTrue p_630) ,
                          self.x_638.zin , x_639 , (isTrue p_630)) with
                   | (_ , _ , _ , true , true) | (_ , _ , true , _ , _) | 
                                                 (true , true , _ , _ , _) ->
                       resultp_635 := true ; resultv_634 := () | _ -> ()  end)
            ;
            i_869_step self.i_869 (time_631 , (!resultv_634 , !resultp_635))) in
       (if cstate_939.major then (((self.x_638.zin <- false)))
        else (((self.x_638.zin <- Zls.get_zin cstate_939.zinvec  !zpos_943 ;
                zpos_943 := (+) !zpos_943  1)) ;
              zpos_943 := zindex_941 ;
              ((Zls.set cstate_939.zoutvec  !zpos_943  self.x_638.zout ;
                zpos_943 := (+) !zpos_943  1)))) ; result_944)):unit signal) in
  
  let q_istrue_now_reset self  =
    ((self.i_640 <- true ; i_869_reset self.i_869 ):unit) in
  Node { alloc = q_istrue_now_alloc; step = q_istrue_now_step ;
                                     reset = q_istrue_now_reset }
type ('e , 'd , 'c , 'b , 'a) _q_isfalse_now =
  { mutable i_870 : 'e ;
    mutable major_643 : 'd ;
    mutable i_651 : 'c ; mutable x_649 : 'b ; mutable m_647 : 'a }

let q_isfalse_now (cstate_945:Ztypes.cstate) = 
  let Node { alloc = i_870_alloc; step = i_870_step ; reset = i_870_reset } = freeze 
  cstate_945 in
  let q_isfalse_now_alloc _ =
    cstate_945.zmax <- (+) cstate_945.zmax  1;
    { major_643 = false ;
      i_651 = (false:bool) ;
      x_649 = { zin = false; zout = 1. } ; m_647 = (42.:float);
      i_870 = i_870_alloc () (* continuous *)  } in
  let q_isfalse_now_step self ((time_642:float) , (p_641:float)) =
    ((let (zindex_947:int) = cstate_945.zindex in
      let zpos_949 = ref (zindex_947:int) in
      cstate_945.zindex <- (+) cstate_945.zindex  1 ;
      self.major_643 <- cstate_945.major ;
      (let (result_950:(unit)signal) =
           let resultp_646 = ref (false:bool) in
           let resultv_645 = ref (():unit) in
           let (x_650:zero) = self.i_651 in
           (if self.i_651 then self.m_647 <- p_641) ;
           self.i_651 <- false ;
           self.x_649.zout <- (~-.) p_641 ;
           (let (x_648:float) = self.m_647 in
            self.m_647 <- p_641 ;
            (begin match (((&&) self.major_643  ((<>) p_641  x_648)) ,
                          (isFalse p_641) ,
                          self.x_649.zin , x_650 , (isFalse p_641)) with
                   | (_ , _ , _ , true , true) | (_ , _ , true , _ , _) | 
                                                 (true , true , _ , _ , _) ->
                       resultp_646 := true ; resultv_645 := () | _ -> ()  end)
            ;
            i_870_step self.i_870 (time_642 , (!resultv_645 , !resultp_646))) in
       (if cstate_945.major then (((self.x_649.zin <- false)))
        else (((self.x_649.zin <- Zls.get_zin cstate_945.zinvec  !zpos_949 ;
                zpos_949 := (+) !zpos_949  1)) ;
              zpos_949 := zindex_947 ;
              ((Zls.set cstate_945.zoutvec  !zpos_949  self.x_649.zout ;
                zpos_949 := (+) !zpos_949  1)))) ; result_950)):unit signal) in
  
  let q_isfalse_now_reset self  =
    ((self.i_651 <- true ; i_870_reset self.i_870 ):unit) in
  Node { alloc = q_isfalse_now_alloc; step = q_isfalse_now_step ;
                                      reset = q_isfalse_now_reset }
let q_gt ((p1_652:float) , (p2_653:float)) =
  (-.) p1_652  p2_653

let q_ge ((p1_654:float) , (p2_655:float)) =
  (-.) p1_654  p2_655

let q_lt ((p1_656:float) , (p2_657:float)) =
  (-.) p2_657  p1_656

let q_le ((p1_658:float) , (p2_659:float)) =
  (-.) p2_659  p1_658

let q_not (p_660:float) =
  (~-.) p_660

let q_or ((p1_661:'a4249) , (p2_662:'a4249)) =
  max p1_661  p2_662

let q_and ((p1_663:'a4259) , (p2_664:'a4259)) =
  min p1_663  p2_664

let q_eqi ((i1_665:float) , (i2_666:float)) =
  (-.) 0.5  (abs_float ((-.) i1_665  i2_666))

let implies ((a_669:float) , (b_670:float)) =
  q_or ((q_not a_669) , b_670)

type ('e , 'd , 'c , 'b , 'a) _q_up =
  { mutable major_673 : 'e ;
    mutable i_682 : 'd ;
    mutable x_680 : 'c ; mutable m_678 : 'b ; mutable result_674 : 'a }

let q_up (cstate_951:Ztypes.cstate) = 
  
  let q_up_alloc _ =
    cstate_951.zmax <- (+) cstate_951.zmax  1;
    { major_673 = false ;
      i_682 = (false:bool) ;
      x_680 = { zin = false; zout = 1. } ;
      m_678 = (42.:float) ; result_674 = (42.:float) } in
  let q_up_step self ((time_672:float) , (p_671:float)) =
    ((let (zindex_953:int) = cstate_951.zindex in
      let zpos_955 = ref (zindex_953:int) in
      cstate_951.zindex <- (+) cstate_951.zindex  1 ;
      self.major_673 <- cstate_951.major ;
      (let (result_956:float) =
           let resultp_677 = ref (false:bool) in
           let resultv_676 = ref (():unit) in
           let (x_681:zero) = self.i_682 in
           (if self.i_682 then self.m_678 <- p_671) ;
           self.i_682 <- false ;
           self.x_680.zout <- p_671 ;
           (let (x_679:float) = self.m_678 in
            self.m_678 <- p_671 ;
            (begin match (((&&) self.major_673  ((<>) p_671  x_679)) ,
                          (isTrue p_671) ,
                          self.x_680.zin , x_681 , (isTrue p_671)) with
                   | (_ , _ , _ , true , true) | (_ , _ , true , _ , _) | 
                                                 (true , true , _ , _ , _) ->
                       resultp_677 := true ; resultv_676 := () | _ -> ()  end)
            ;
            (begin match (!resultv_676 , !resultp_677) with
                   | (() , true) -> self.result_674 <- p_671
                   | _ ->
                       self.result_674 <- min (-1e-10) 
                                              ((~-.) (abs_float p_671))
                    end) ; self.result_674) in
       (if cstate_951.major then (((self.x_680.zin <- false)))
        else (((self.x_680.zin <- Zls.get_zin cstate_951.zinvec  !zpos_955 ;
                zpos_955 := (+) !zpos_955  1)) ;
              zpos_955 := zindex_953 ;
              ((Zls.set cstate_951.zoutvec  !zpos_955  self.x_680.zout ;
                zpos_955 := (+) !zpos_955  1)))) ; result_956)):float) in 
  let q_up_reset self  =
    (self.i_682 <- true:unit) in
  Node { alloc = q_up_alloc; step = q_up_step ; reset = q_up_reset }
type ('b , 'a) _b_up =
  { mutable i_687 : 'b ; mutable m_684 : 'a }

let b_up  = 
   let b_up_alloc _ =
     ();{ i_687 = (false:bool) ; m_684 = (false:bool) } in
  let b_up_reset self  =
    (self.i_687 <- true:unit) in 
  let b_up_step self (p_683:bool) =
    ((let (x_686:bool) =
          if self.i_687 then p_683 else (&&) (not self.m_684)  p_683 in
      self.i_687 <- false ; self.m_684 <- p_683 ; x_686):bool) in
  Node { alloc = b_up_alloc; reset = b_up_reset ; step = b_up_step }
let min_cpt = (-1.)

let eps = 0.1

type ('j , 'i , 'h , 'g , 'f , 'e , 'd , 'c , 'b , 'a) _always =
  { mutable major_690 : 'j ;
    mutable h_705 : 'i ;
    mutable h_703 : 'h ;
    mutable i_701 : 'g ;
    mutable x_700 : 'f ;
    mutable x_699 : 'e ;
    mutable m_697 : 'd ;
    mutable x_696 : 'c ; mutable x_695 : 'b ; mutable cur_f_692 : 'a }

let always (cstate_957:Ztypes.cstate) = 
  
  let always_alloc _ =
    cstate_957.zmax <- (+) cstate_957.zmax  4;
    { major_690 = false ;
      h_705 = 42. ;
      h_703 = (42.:float) ;
      i_701 = (false:bool) ;
      x_700 = { zin = false; zout = 1. } ;
      x_699 = { zin = false; zout = 1. } ;
      m_697 = (42.:float) ;
      x_696 = { zin = false; zout = 1. } ;
      x_695 = { zin = false; zout = 1. } ; cur_f_692 = (42.:float) } in
  let always_step self ((time_689:float) , (p_688:float)) =
    ((let (zindex_959:int) = cstate_957.zindex in
      let zpos_961 = ref (zindex_959:int) in
      cstate_957.zindex <- (+) cstate_957.zindex  4 ;
      self.major_690 <- cstate_957.major ;
      (let (result_962:float) =
           let h_704 = ref (infinity:float) in
           let encore_702 = ref (false:bool) in
           (if self.i_701 then self.m_697 <- p_688) ;
           (let (x_698:float) = self.m_697 in
            (if self.i_701 then self.cur_f_692 <- p_688) ;
            (let (l_694:float) = self.cur_f_692 in
             (begin match (self.x_695.zin ,
                           self.x_696.zin ,
                           ((&&) self.major_690  ((<>) p_688  x_698)) ,
                           self.x_699.zin , self.x_700.zin) with
                    | (_ , _ , _ , _ , true) | (_ , _ , _ , true , _) | 
                                               (_ , _ , true , _ , _) | 
                                               (_ , true , _ , _ , _) | 
                                               (true , _ , _ , _ , _) ->
                        encore_702 := true ;
                        self.cur_f_692 <- q_and (l_694 , p_688) | _ -> ()  end)
             ;
             self.h_703 <- (if !encore_702 then 0. else infinity) ;
             h_704 := min !h_704  self.h_703 ;
             self.h_705 <- !h_704 ;
             self.i_701 <- false ;
             self.x_700.zout <- (-.) ((-.) self.cur_f_692  0.1)  p_688 ;
             self.x_699.zout <- (-.) p_688  ((+.) self.cur_f_692  0.1) ;
             self.m_697 <- p_688 ;
             self.x_696.zout <- p_688 ;
             self.x_695.zout <- (~-.) p_688 ; self.cur_f_692)) in
       cstate_957.horizon <- min cstate_957.horizon  self.h_705 ;
       (if cstate_957.major then
        (((self.x_700.zin <- false) ;
          (self.x_699.zin <- false) ;
          (self.x_696.zin <- false) ; (self.x_695.zin <- false)))
        else (((self.x_700.zin <- Zls.get_zin cstate_957.zinvec  !zpos_961 ;
                zpos_961 := (+) !zpos_961  1) ;
               (self.x_699.zin <- Zls.get_zin cstate_957.zinvec  !zpos_961 ;
                zpos_961 := (+) !zpos_961  1) ;
               (self.x_696.zin <- Zls.get_zin cstate_957.zinvec  !zpos_961 ;
                zpos_961 := (+) !zpos_961  1) ;
               (self.x_695.zin <- Zls.get_zin cstate_957.zinvec  !zpos_961 ;
                zpos_961 := (+) !zpos_961  1)) ;
              zpos_961 := zindex_959 ;
              ((Zls.set cstate_957.zoutvec  !zpos_961  self.x_700.zout ;
                zpos_961 := (+) !zpos_961  1) ;
               (Zls.set cstate_957.zoutvec  !zpos_961  self.x_699.zout ;
                zpos_961 := (+) !zpos_961  1) ;
               (Zls.set cstate_957.zoutvec  !zpos_961  self.x_696.zout ;
                zpos_961 := (+) !zpos_961  1) ;
               (Zls.set cstate_957.zoutvec  !zpos_961  self.x_695.zout ;
                zpos_961 := (+) !zpos_961  1)))) ; result_962)):float) in 
  let always_reset self  =
    (self.i_701 <- true:unit) in
  Node { alloc = always_alloc; step = always_step ; reset = always_reset }
type ('b , 'a) _never =
  { mutable i_871 : 'b ; mutable major_708 : 'a }

let never (cstate_963:Ztypes.cstate) = 
  let Node { alloc = i_871_alloc; step = i_871_step ; reset = i_871_reset } = always 
  cstate_963 in
  let never_alloc _ =
    ();{ major_708 = false;i_871 = i_871_alloc () (* continuous *)  } in
  let never_step self ((time_707:float) , (p_706:float)) =
    ((self.major_708 <- cstate_963.major ;
      i_871_step self.i_871 (time_707 , (q_not p_706))):float) in 
  let never_reset self  =
    (i_871_reset self.i_871 :unit) in
  Node { alloc = never_alloc; step = never_step ; reset = never_reset }
type ('j , 'i , 'h , 'g , 'f , 'e , 'd , 'c , 'b , 'a) _once =
  { mutable major_711 : 'j ;
    mutable h_726 : 'i ;
    mutable h_724 : 'h ;
    mutable i_722 : 'g ;
    mutable x_721 : 'f ;
    mutable x_720 : 'e ;
    mutable m_718 : 'd ;
    mutable x_717 : 'c ; mutable x_716 : 'b ; mutable cur_f_713 : 'a }

let once (cstate_969:Ztypes.cstate) = 
  
  let once_alloc _ =
    cstate_969.zmax <- (+) cstate_969.zmax  4;
    { major_711 = false ;
      h_726 = 42. ;
      h_724 = (42.:float) ;
      i_722 = (false:bool) ;
      x_721 = { zin = false; zout = 1. } ;
      x_720 = { zin = false; zout = 1. } ;
      m_718 = (42.:float) ;
      x_717 = { zin = false; zout = 1. } ;
      x_716 = { zin = false; zout = 1. } ; cur_f_713 = (42.:float) } in
  let once_step self ((time_710:float) , (p_709:float)) =
    ((let (zindex_971:int) = cstate_969.zindex in
      let zpos_973 = ref (zindex_971:int) in
      cstate_969.zindex <- (+) cstate_969.zindex  4 ;
      self.major_711 <- cstate_969.major ;
      (let (result_974:float) =
           let h_725 = ref (infinity:float) in
           let encore_723 = ref (false:bool) in
           (if self.i_722 then self.m_718 <- p_709) ;
           (let (x_719:float) = self.m_718 in
            (if self.i_722 then self.cur_f_713 <- p_709) ;
            (let (l_715:float) = self.cur_f_713 in
             (begin match (self.x_716.zin ,
                           self.x_717.zin ,
                           ((&&) self.major_711  ((<>) p_709  x_719)) ,
                           self.x_720.zin , self.x_721.zin) with
                    | (_ , _ , _ , _ , true) | (_ , _ , _ , true , _) | 
                                               (_ , _ , true , _ , _) | 
                                               (_ , true , _ , _ , _) | 
                                               (true , _ , _ , _ , _) ->
                        encore_723 := true ;
                        self.cur_f_713 <- q_or (l_715 , p_709) | _ -> ()  end)
             ;
             self.h_724 <- (if !encore_723 then 0. else infinity) ;
             h_725 := min !h_725  self.h_724 ;
             self.h_726 <- !h_725 ;
             self.i_722 <- false ;
             self.x_721.zout <- (-.) ((-.) self.cur_f_713  0.1)  p_709 ;
             self.x_720.zout <- (-.) p_709  ((+.) self.cur_f_713  0.1) ;
             self.m_718 <- p_709 ;
             self.x_717.zout <- p_709 ;
             self.x_716.zout <- (~-.) p_709 ; self.cur_f_713)) in
       cstate_969.horizon <- min cstate_969.horizon  self.h_726 ;
       (if cstate_969.major then
        (((self.x_721.zin <- false) ;
          (self.x_720.zin <- false) ;
          (self.x_717.zin <- false) ; (self.x_716.zin <- false)))
        else (((self.x_721.zin <- Zls.get_zin cstate_969.zinvec  !zpos_973 ;
                zpos_973 := (+) !zpos_973  1) ;
               (self.x_720.zin <- Zls.get_zin cstate_969.zinvec  !zpos_973 ;
                zpos_973 := (+) !zpos_973  1) ;
               (self.x_717.zin <- Zls.get_zin cstate_969.zinvec  !zpos_973 ;
                zpos_973 := (+) !zpos_973  1) ;
               (self.x_716.zin <- Zls.get_zin cstate_969.zinvec  !zpos_973 ;
                zpos_973 := (+) !zpos_973  1)) ;
              zpos_973 := zindex_971 ;
              ((Zls.set cstate_969.zoutvec  !zpos_973  self.x_721.zout ;
                zpos_973 := (+) !zpos_973  1) ;
               (Zls.set cstate_969.zoutvec  !zpos_973  self.x_720.zout ;
                zpos_973 := (+) !zpos_973  1) ;
               (Zls.set cstate_969.zoutvec  !zpos_973  self.x_717.zout ;
                zpos_973 := (+) !zpos_973  1) ;
               (Zls.set cstate_969.zoutvec  !zpos_973  self.x_716.zout ;
                zpos_973 := (+) !zpos_973  1)))) ; result_974)):float) in 
  let once_reset self  =
    (self.i_722 <- true:unit) in
  Node { alloc = once_alloc; step = once_step ; reset = once_reset }
type ('k , 'j , 'i , 'h , 'g , 'f , 'e , 'd , 'c , 'b , 'a) _sincefirst =
  { mutable i_873 : 'k ;
    mutable i_872 : 'j ;
    mutable major_730 : 'i ;
    mutable x_744 : 'h ;
    mutable h_738 : 'g ;
    mutable h_736 : 'f ;
    mutable r_734 : 'e ;
    mutable s_733 : 'd ;
    mutable result_732 : 'c ; mutable i_746 : 'b ; mutable m_742 : 'a }

let sincefirst (cstate_975:Ztypes.cstate) = 
  let Node { alloc = i_873_alloc; step = i_873_step ; reset = i_873_reset } = never 
  cstate_975 in 
  let Node { alloc = i_872_alloc; step = i_872_step ; reset = i_872_reset } = once 
  cstate_975 in
  let sincefirst_alloc _ =
    cstate_975.zmax <- (+) cstate_975.zmax  1;
    { major_730 = false ;
      x_744 = { zin = false; zout = 1. } ;
      h_738 = 42. ;
      h_736 = (42.:float) ;
      r_734 = (false:bool) ;
      s_733 = (Hybrid_obs_YTRUE_334:state__4677) ;
      result_732 = (42.:float) ; i_746 = (false:bool) ; m_742 = (42.:float);
      i_873 = i_873_alloc () (* continuous *)  ;
      i_872 = i_872_alloc () (* continuous *)  } in
  let sincefirst_step self ((time_729:float) ,
                            ((x_727:float) , (y_728:float))) =
    ((let (zindex_977:int) = cstate_975.zindex in
      let zpos_979 = ref (zindex_977:int) in
      cstate_975.zindex <- (+) cstate_975.zindex  1 ;
      self.major_730 <- cstate_975.major ;
      (let (result_980:float) =
           let h_737 = ref (infinity:float) in
           let encore_735 = ref (false:bool) in
           let (nevery_731:float) = i_873_step self.i_873 (time_729 , y_728) in
           (begin match self.s_733 with
                  | Hybrid_obs_INIT_333 ->
                      let resultp_741 = ref (false:bool) in
                      let resultv_740 = ref (():unit) in
                      (if self.r_734 then self.i_746 <- true) ;
                      (let (x_745:zero) = self.i_746 in
                       (if self.i_746 then self.m_742 <- y_728) ;
                       self.i_746 <- false ;
                       self.result_732 <- q_or (nevery_731 , x_727) ;
                       self.x_744.zout <- y_728 ;
                       (let (x_743:float) = self.m_742 in
                        self.m_742 <- y_728 ;
                        (begin match (((&&) self.major_730 
                                            ((<>) y_728  x_743)) ,
                                      (isTrue y_728) ,
                                      self.x_744.zin , x_745 , (isTrue y_728)) with
                               | (_ , _ , _ , true , true) | (_ ,
                                                              _ ,
                                                              true , _ , _) | 
                                                             (true ,
                                                              true ,
                                                              _ , _ , _) ->
                                   resultp_741 := true ; resultv_740 := ()
                               | _ -> ()  end) ;
                        (begin match (!resultv_740 , !resultp_741) with
                               | (() , true) ->
                                   encore_735 := true ;
                                   self.r_734 <- true ;
                                   self.s_733 <- Hybrid_obs_YTRUE_334
                               | _ -> self.r_734 <- false  end)))
                  | Hybrid_obs_YTRUE_334 ->
                      (if self.r_734 then i_872_reset self.i_872 ) ;
                      self.result_732 <- q_or (nevery_731 ,
                                               (i_872_step self.i_872
                                                  (time_729 , x_727))) ;
                      self.r_734 <- false
                   end) ;
           self.h_736 <- (if !encore_735 then 0. else infinity) ;
           h_737 := min !h_737  self.h_736 ;
           self.h_738 <- !h_737 ; self.result_732 in
       cstate_975.horizon <- min cstate_975.horizon  self.h_738 ;
       (if cstate_975.major then (((self.x_744.zin <- false)))
        else (((self.x_744.zin <- Zls.get_zin cstate_975.zinvec  !zpos_979 ;
                zpos_979 := (+) !zpos_979  1)) ;
              zpos_979 := zindex_977 ;
              ((Zls.set cstate_975.zoutvec  !zpos_979  self.x_744.zout ;
                zpos_979 := (+) !zpos_979  1)))) ; result_980)):float) in 
  let sincefirst_reset self  =
    ((i_873_reset self.i_873  ;
      self.r_734 <- false ;
      self.s_733 <- Hybrid_obs_INIT_333 ;
      self.i_746 <- true ; i_872_reset self.i_872 ):unit) in
  Node { alloc = sincefirst_alloc; step = sincefirst_step ;
                                   reset = sincefirst_reset }
type ('p ,
      'o ,
      'n , 'm , 'l , 'k , 'j , 'i , 'h , 'g , 'f , 'e , 'd , 'c , 'b , 'a) _sincelast =
  { mutable i_875 : 'p ;
    mutable i_874 : 'o ;
    mutable major_750 : 'n ;
    mutable x_765 : 'm ;
    mutable h_759 : 'l ;
    mutable h_757 : 'k ;
    mutable r_755 : 'j ;
    mutable s_754 : 'i ;
    mutable last_res_753 : 'h ;
    mutable result_752 : 'g ;
    mutable i_767 : 'f ;
    mutable m_763 : 'e ;
    mutable i_775 : 'd ;
    mutable m_771 : 'c ; mutable i_783 : 'b ; mutable m_779 : 'a }

let sincelast (cstate_981:Ztypes.cstate) = 
  let Node { alloc = i_875_alloc; step = i_875_step ; reset = i_875_reset } = never 
  cstate_981 in 
  let Node { alloc = i_874_alloc; step = i_874_step ; reset = i_874_reset } = once 
  cstate_981 in
  let sincelast_alloc _ =
    cstate_981.zmax <- (+) cstate_981.zmax  1;
    { major_750 = false ;
      x_765 = { zin = false; zout = 1. } ;
      h_759 = 42. ;
      h_757 = (42.:float) ;
      r_755 = (false:bool) ;
      s_754 = (Hybrid_obs_YFALSE_343:state__4678) ;
      last_res_753 = (42.:float) ;
      result_752 = (42.:float) ;
      i_767 = (false:bool) ;
      m_763 = (42.:float) ;
      i_775 = (false:bool) ;
      m_771 = (42.:float) ; i_783 = (false:bool) ; m_779 = (42.:float);
      i_875 = i_875_alloc () (* continuous *)  ;
      i_874 = i_874_alloc () (* continuous *)  } in
  let sincelast_step self ((time_749:float) , ((x_747:float) , (y_748:float))) =
    ((let (zindex_983:int) = cstate_981.zindex in
      let zpos_985 = ref (zindex_983:int) in
      cstate_981.zindex <- (+) cstate_981.zindex  1 ;
      self.major_750 <- cstate_981.major ;
      (let (result_986:float) =
           let h_758 = ref (infinity:float) in
           let encore_756 = ref (false:bool) in
           let (nevery_751:float) = i_875_step self.i_875 (time_749 , y_748) in
           (begin match self.s_754 with
                  | Hybrid_obs_INIT_341 ->
                      let resultp_762 = ref (false:bool) in
                      let resultv_761 = ref (():unit) in
                      (if self.r_755 then self.i_767 <- true) ;
                      (let (x_766:zero) = self.i_767 in
                       (if self.i_767 then self.m_763 <- y_748) ;
                       self.i_767 <- false ;
                       self.result_752 <- q_or (nevery_751 , x_747) ;
                       self.x_765.zout <- y_748 ;
                       (let (x_764:float) = self.m_763 in
                        self.m_763 <- y_748 ;
                        (begin match (((&&) self.major_750 
                                            ((<>) y_748  x_764)) ,
                                      (isTrue y_748) ,
                                      self.x_765.zin , x_766 , (isTrue y_748)) with
                               | (_ , _ , _ , true , true) | (_ ,
                                                              _ ,
                                                              true , _ , _) | 
                                                             (true ,
                                                              true ,
                                                              _ , _ , _) ->
                                   resultp_762 := true ; resultv_761 := ()
                               | _ -> ()  end) ;
                        (begin match (!resultv_761 , !resultp_762) with
                               | (() , true) ->
                                   encore_756 := true ;
                                   self.r_755 <- true ;
                                   self.s_754 <- Hybrid_obs_YTRUE_342
                               | _ -> self.r_755 <- false  end)))
                  | Hybrid_obs_YTRUE_342 ->
                      let resultp_770 = ref (false:bool) in
                      let resultv_769 = ref (():unit) in
                      (if self.r_755 then self.i_775 <- true) ;
                      (let (x_774:zero) = self.i_775 in
                       (if self.i_775 then self.m_771 <- y_748) ;
                       self.i_775 <- false ;
                       self.result_752 <- x_747 ;
                       self.x_765.zout <- (~-.) y_748 ;
                       (let (x_772:float) = self.m_771 in
                        self.m_771 <- y_748 ;
                        (begin match (((&&) self.major_750 
                                            ((<>) y_748  x_772)) ,
                                      (isFalse y_748) ,
                                      self.x_765.zin ,
                                      x_774 , (isFalse y_748)) with
                               | (_ , _ , _ , true , true) | (_ ,
                                                              _ ,
                                                              true , _ , _) | 
                                                             (true ,
                                                              true ,
                                                              _ , _ , _) ->
                                   resultp_770 := true ; resultv_769 := ()
                               | _ -> ()  end) ;
                        (begin match (!resultv_769 , !resultp_770) with
                               | (() , true) ->
                                   encore_756 := true ;
                                   self.last_res_753 <- x_747 ;
                                   self.r_755 <- true ;
                                   self.s_754 <- Hybrid_obs_YFALSE_343
                               | _ -> self.r_755 <- false  end)))
                  | Hybrid_obs_YFALSE_343 ->
                      let resultp_778 = ref (false:bool) in
                      let resultv_777 = ref (():unit) in
                      (if self.r_755 then
                       (self.i_783 <- true ; i_874_reset self.i_874 )) ;
                      (let (x_782:zero) = self.i_783 in
                       (if self.i_783 then self.m_779 <- y_748) ;
                       self.i_783 <- false ;
                       self.result_752 <- q_or (self.last_res_753 ,
                                                (i_874_step self.i_874
                                                   (time_749 , x_747))) ;
                       self.x_765.zout <- y_748 ;
                       (let (x_780:float) = self.m_779 in
                        self.m_779 <- y_748 ;
                        (begin match (((&&) self.major_750 
                                            ((<>) y_748  x_780)) ,
                                      (isTrue y_748) ,
                                      self.x_765.zin , x_782 , (isTrue y_748)) with
                               | (_ , _ , _ , true , true) | (_ ,
                                                              _ ,
                                                              true , _ , _) | 
                                                             (true ,
                                                              true ,
                                                              _ , _ , _) ->
                                   resultp_778 := true ; resultv_777 := ()
                               | _ -> ()  end) ;
                        (begin match (!resultv_777 , !resultp_778) with
                               | (() , true) ->
                                   encore_756 := true ;
                                   self.r_755 <- true ;
                                   self.s_754 <- Hybrid_obs_YTRUE_342
                               | _ -> self.r_755 <- false  end)))
                   end) ;
           self.h_757 <- (if !encore_756 then 0. else infinity) ;
           h_758 := min !h_758  self.h_757 ;
           self.h_759 <- !h_758 ; self.result_752 in
       cstate_981.horizon <- min cstate_981.horizon  self.h_759 ;
       (if cstate_981.major then (((self.x_765.zin <- false)))
        else (((self.x_765.zin <- Zls.get_zin cstate_981.zinvec  !zpos_985 ;
                zpos_985 := (+) !zpos_985  1)) ;
              zpos_985 := zindex_983 ;
              ((Zls.set cstate_981.zoutvec  !zpos_985  self.x_765.zout ;
                zpos_985 := (+) !zpos_985  1)))) ; result_986)):float) in 
  let sincelast_reset self  =
    ((i_875_reset self.i_875  ;
      self.r_755 <- false ;
      self.s_754 <- Hybrid_obs_INIT_341 ;
      self.i_767 <- true ;
      self.i_775 <- true ; self.i_783 <- true ; i_874_reset self.i_874 ):
    unit) in
  Node { alloc = sincelast_alloc; step = sincelast_step ;
                                  reset = sincelast_reset }
type ('b , 'a) _since =
  { mutable i_876 : 'b ; mutable major_787 : 'a }

let since (cstate_987:Ztypes.cstate) = 
  let Node { alloc = i_876_alloc; step = i_876_step ; reset = i_876_reset } = sincelast 
  cstate_987 in
  let since_alloc _ =
    ();{ major_787 = false;i_876 = i_876_alloc () (* continuous *)  } in
  let since_step self ((time_786:float) , ((x_784:float) , (y_785:float))) =
    ((self.major_787 <- cstate_987.major ;
      i_876_step self.i_876 (time_786 , (x_784 , y_785))):float) in 
  let since_reset self  =
    (i_876_reset self.i_876 :unit) in
  Node { alloc = since_alloc; step = since_step ; reset = since_reset }
type ('c , 'b , 'a) _onceBfromlastAtoC =
  { mutable i_878 : 'c ; mutable i_877 : 'b ; mutable major_792 : 'a }

let onceBfromlastAtoC (cstate_993:Ztypes.cstate) = 
  let Node { alloc = i_878_alloc; step = i_878_step ; reset = i_878_reset } = sincelast 
  cstate_993 in 
  let Node { alloc = i_877_alloc; step = i_877_step ; reset = i_877_reset } = never 
  cstate_993 in
  let onceBfromlastAtoC_alloc _ =
    ();
    { major_792 = false;
      i_878 = i_878_alloc () (* continuous *)  ;
      i_877 = i_877_alloc () (* continuous *)  } in
  let onceBfromlastAtoC_step self ((time_791:float) ,
                                   ((a_788:float) ,
                                    (b_789:float) , (c_790:float))) =
    ((self.major_792 <- cstate_993.major ;
      implies (c_790 ,
               (q_or ((i_877_step self.i_877 (time_791 , a_788)) ,
                      (i_878_step self.i_878 (time_791 , (b_789 , a_788))))))):
    float) in 
  let onceBfromlastAtoC_reset self  =
    ((i_878_reset self.i_878  ; i_877_reset self.i_877 ):unit) in
  Node { alloc = onceBfromlastAtoC_alloc; step = onceBfromlastAtoC_step ;
                                          reset = onceBfromlastAtoC_reset }
type ('c , 'b , 'a) _onceBfromfirstAtoC =
  { mutable i_880 : 'c ; mutable i_879 : 'b ; mutable major_797 : 'a }

let onceBfromfirstAtoC (cstate_999:Ztypes.cstate) = 
  let Node { alloc = i_880_alloc; step = i_880_step ; reset = i_880_reset } = sincefirst 
  cstate_999 in 
  let Node { alloc = i_879_alloc; step = i_879_step ; reset = i_879_reset } = never 
  cstate_999 in
  let onceBfromfirstAtoC_alloc _ =
    ();
    { major_797 = false;
      i_880 = i_880_alloc () (* continuous *)  ;
      i_879 = i_879_alloc () (* continuous *)  } in
  let onceBfromfirstAtoC_step self ((time_796:float) ,
                                    ((a_793:float) ,
                                     (b_794:float) , (c_795:float))) =
    ((self.major_797 <- cstate_999.major ;
      implies (c_795 ,
               (q_or ((i_879_step self.i_879 (time_796 , a_793)) ,
                      (i_880_step self.i_880 (time_796 , (b_794 , a_793))))))):
    float) in 
  let onceBfromfirstAtoC_reset self  =
    ((i_880_reset self.i_880  ; i_879_reset self.i_879 ):unit) in
  Node { alloc = onceBfromfirstAtoC_alloc; step = onceBfromfirstAtoC_step ;
                                           reset = onceBfromfirstAtoC_reset }
type ('b , 'a) _onceBfromAtoC =
  { mutable i_881 : 'b ; mutable major_802 : 'a }

let onceBfromAtoC (cstate_1005:Ztypes.cstate) = 
  let Node { alloc = i_881_alloc; step = i_881_step ; reset = i_881_reset } = onceBfromlastAtoC 
  cstate_1005 in
  let onceBfromAtoC_alloc _ =
    ();{ major_802 = false;i_881 = i_881_alloc () (* continuous *)  } in
  let onceBfromAtoC_step self ((time_801:float) ,
                               ((a_798:float) , (b_799:float) , (c_800:float))) =
    ((self.major_802 <- cstate_1005.major ;
      i_881_step self.i_881 (time_801 , (a_798 , b_799 , c_800))):float) in 
  let onceBfromAtoC_reset self  =
    (i_881_reset self.i_881 :unit) in
  Node { alloc = onceBfromAtoC_alloc; step = onceBfromAtoC_step ;
                                      reset = onceBfromAtoC_reset }
type ('c , 'b , 'a) _alwaysBfromlastAtoC =
  { mutable i_883 : 'c ; mutable i_882 : 'b ; mutable major_807 : 'a }

let alwaysBfromlastAtoC (cstate_1011:Ztypes.cstate) = 
  let Node { alloc = i_883_alloc; step = i_883_step ; reset = i_883_reset } = sincelast 
  cstate_1011 in 
  let Node { alloc = i_882_alloc; step = i_882_step ; reset = i_882_reset } = never 
  cstate_1011 in
  let alwaysBfromlastAtoC_alloc _ =
    ();
    { major_807 = false;
      i_883 = i_883_alloc () (* continuous *)  ;
      i_882 = i_882_alloc () (* continuous *)  } in
  let alwaysBfromlastAtoC_step self ((time_806:float) ,
                                     ((a_803:float) ,
                                      (b_804:float) , (c_805:float))) =
    ((self.major_807 <- cstate_1011.major ;
      implies (c_805 ,
               (q_or ((i_882_step self.i_882 (time_806 , a_803)) ,
                      (q_not (i_883_step self.i_883
                                (time_806 , ((q_not b_804) , a_803)))))))):
    float) in 
  let alwaysBfromlastAtoC_reset self  =
    ((i_883_reset self.i_883  ; i_882_reset self.i_882 ):unit) in
  Node { alloc = alwaysBfromlastAtoC_alloc; step = alwaysBfromlastAtoC_step ;
                                            reset = alwaysBfromlastAtoC_reset }
type ('c , 'b , 'a) _alwaysBfromfirstAtoC =
  { mutable i_885 : 'c ; mutable i_884 : 'b ; mutable major_812 : 'a }

let alwaysBfromfirstAtoC (cstate_1017:Ztypes.cstate) = 
  let Node { alloc = i_885_alloc; step = i_885_step ; reset = i_885_reset } = sincefirst 
  cstate_1017 in 
  let Node { alloc = i_884_alloc; step = i_884_step ; reset = i_884_reset } = never 
  cstate_1017 in
  let alwaysBfromfirstAtoC_alloc _ =
    ();
    { major_812 = false;
      i_885 = i_885_alloc () (* continuous *)  ;
      i_884 = i_884_alloc () (* continuous *)  } in
  let alwaysBfromfirstAtoC_step self ((time_811:float) ,
                                      ((a_808:float) ,
                                       (b_809:float) , (c_810:float))) =
    ((self.major_812 <- cstate_1017.major ;
      implies (c_810 ,
               (q_or ((i_884_step self.i_884 (time_811 , a_808)) ,
                      (q_not (i_885_step self.i_885
                                (time_811 , ((q_not b_809) , a_808)))))))):
    float) in 
  let alwaysBfromfirstAtoC_reset self  =
    ((i_885_reset self.i_885  ; i_884_reset self.i_884 ):unit) in
  Node { alloc = alwaysBfromfirstAtoC_alloc; step = alwaysBfromfirstAtoC_step
                                             ;
                                             reset = alwaysBfromfirstAtoC_reset }
type ('b , 'a) _alwaysBfromAtoC =
  { mutable i_886 : 'b ; mutable major_817 : 'a }

let alwaysBfromAtoC (cstate_1023:Ztypes.cstate) = 
  let Node { alloc = i_886_alloc; step = i_886_step ; reset = i_886_reset } = alwaysBfromlastAtoC 
  cstate_1023 in
  let alwaysBfromAtoC_alloc _ =
    ();{ major_817 = false;i_886 = i_886_alloc () (* continuous *)  } in
  let alwaysBfromAtoC_step self ((time_816:float) ,
                                 ((a_813:float) ,
                                  (b_814:float) , (c_815:float))) =
    ((self.major_817 <- cstate_1023.major ;
      i_886_step self.i_886 (time_816 , (a_813 , b_814 , c_815))):float) in 
  let alwaysBfromAtoC_reset self  =
    (i_886_reset self.i_886 :unit) in
  Node { alloc = alwaysBfromAtoC_alloc; step = alwaysBfromAtoC_step ;
                                        reset = alwaysBfromAtoC_reset }
type ('b , 'a) _neverBfromlastAtoC =
  { mutable i_887 : 'b ; mutable major_822 : 'a }

let neverBfromlastAtoC (cstate_1029:Ztypes.cstate) = 
  let Node { alloc = i_887_alloc; step = i_887_step ; reset = i_887_reset } = alwaysBfromlastAtoC 
  cstate_1029 in
  let neverBfromlastAtoC_alloc _ =
    ();{ major_822 = false;i_887 = i_887_alloc () (* continuous *)  } in
  let neverBfromlastAtoC_step self ((time_821:float) ,
                                    ((a_818:float) ,
                                     (b_819:float) , (c_820:float))) =
    ((self.major_822 <- cstate_1029.major ;
      i_887_step self.i_887 (time_821 , (a_818 , (q_not b_819) , c_820))):
    float) in 
  let neverBfromlastAtoC_reset self  =
    (i_887_reset self.i_887 :unit) in
  Node { alloc = neverBfromlastAtoC_alloc; step = neverBfromlastAtoC_step ;
                                           reset = neverBfromlastAtoC_reset }
type ('b , 'a) _neverBfromfirstAtoC =
  { mutable i_888 : 'b ; mutable major_827 : 'a }

let neverBfromfirstAtoC (cstate_1035:Ztypes.cstate) = 
  let Node { alloc = i_888_alloc; step = i_888_step ; reset = i_888_reset } = alwaysBfromfirstAtoC 
  cstate_1035 in
  let neverBfromfirstAtoC_alloc _ =
    ();{ major_827 = false;i_888 = i_888_alloc () (* continuous *)  } in
  let neverBfromfirstAtoC_step self ((time_826:float) ,
                                     ((a_823:float) ,
                                      (b_824:float) , (c_825:float))) =
    ((self.major_827 <- cstate_1035.major ;
      i_888_step self.i_888 (time_826 , (a_823 , (q_not b_824) , c_825))):
    float) in 
  let neverBfromfirstAtoC_reset self  =
    (i_888_reset self.i_888 :unit) in
  Node { alloc = neverBfromfirstAtoC_alloc; step = neverBfromfirstAtoC_step ;
                                            reset = neverBfromfirstAtoC_reset }
type ('b , 'a) _neverBfromAtoC =
  { mutable i_889 : 'b ; mutable major_832 : 'a }

let neverBfromAtoC (cstate_1041:Ztypes.cstate) = 
  let Node { alloc = i_889_alloc; step = i_889_step ; reset = i_889_reset } = alwaysBfromAtoC 
  cstate_1041 in
  let neverBfromAtoC_alloc _ =
    ();{ major_832 = false;i_889 = i_889_alloc () (* continuous *)  } in
  let neverBfromAtoC_step self ((time_831:float) ,
                                ((a_828:float) ,
                                 (b_829:float) , (c_830:float))) =
    ((self.major_832 <- cstate_1041.major ;
      i_889_step self.i_889 (time_831 , (a_828 , (q_not b_829) , c_830))):
    float) in 
  let neverBfromAtoC_reset self  =
    (i_889_reset self.i_889 :unit) in
  Node { alloc = neverBfromAtoC_alloc; step = neverBfromAtoC_step ;
                                       reset = neverBfromAtoC_reset }
type ('c , 'b , 'a) _onceBfromlastA =
  { mutable i_891 : 'c ; mutable i_890 : 'b ; mutable major_836 : 'a }

let onceBfromlastA (cstate_1047:Ztypes.cstate) = 
  let Node { alloc = i_891_alloc; step = i_891_step ; reset = i_891_reset } = sincelast 
  cstate_1047 in 
  let Node { alloc = i_890_alloc; step = i_890_step ; reset = i_890_reset } = never 
  cstate_1047 in
  let onceBfromlastA_alloc _ =
    ();
    { major_836 = false;
      i_891 = i_891_alloc () (* continuous *)  ;
      i_890 = i_890_alloc () (* continuous *)  } in
  let onceBfromlastA_step self ((time_835:float) ,
                                ((a_833:float) , (b_834:float))) =
    ((self.major_836 <- cstate_1047.major ;
      q_or ((i_890_step self.i_890 (time_835 , a_833)) ,
            (i_891_step self.i_891 (time_835 , (b_834 , a_833))))):float) in 
  let onceBfromlastA_reset self  =
    ((i_891_reset self.i_891  ; i_890_reset self.i_890 ):unit) in
  Node { alloc = onceBfromlastA_alloc; step = onceBfromlastA_step ;
                                       reset = onceBfromlastA_reset }
type ('c , 'b , 'a) _onceBfromfirstA =
  { mutable i_893 : 'c ; mutable i_892 : 'b ; mutable major_840 : 'a }

let onceBfromfirstA (cstate_1053:Ztypes.cstate) = 
  let Node { alloc = i_893_alloc; step = i_893_step ; reset = i_893_reset } = sincefirst 
  cstate_1053 in 
  let Node { alloc = i_892_alloc; step = i_892_step ; reset = i_892_reset } = never 
  cstate_1053 in
  let onceBfromfirstA_alloc _ =
    ();
    { major_840 = false;
      i_893 = i_893_alloc () (* continuous *)  ;
      i_892 = i_892_alloc () (* continuous *)  } in
  let onceBfromfirstA_step self ((time_839:float) ,
                                 ((a_837:float) , (b_838:float))) =
    ((self.major_840 <- cstate_1053.major ;
      q_or ((i_892_step self.i_892 (time_839 , a_837)) ,
            (i_893_step self.i_893 (time_839 , (b_838 , a_837))))):float) in 
  let onceBfromfirstA_reset self  =
    ((i_893_reset self.i_893  ; i_892_reset self.i_892 ):unit) in
  Node { alloc = onceBfromfirstA_alloc; step = onceBfromfirstA_step ;
                                        reset = onceBfromfirstA_reset }
type ('b , 'a) _onceBfromA =
  { mutable i_894 : 'b ; mutable major_844 : 'a }

let onceBfromA (cstate_1059:Ztypes.cstate) = 
  let Node { alloc = i_894_alloc; step = i_894_step ; reset = i_894_reset } = onceBfromlastA 
  cstate_1059 in
  let onceBfromA_alloc _ =
    ();{ major_844 = false;i_894 = i_894_alloc () (* continuous *)  } in
  let onceBfromA_step self ((time_843:float) ,
                            ((a_841:float) , (b_842:float))) =
    ((self.major_844 <- cstate_1059.major ;
      i_894_step self.i_894 (time_843 , (a_841 , b_842))):float) in 
  let onceBfromA_reset self  =
    (i_894_reset self.i_894 :unit) in
  Node { alloc = onceBfromA_alloc; step = onceBfromA_step ;
                                   reset = onceBfromA_reset }
type ('c , 'b , 'a) _alwaysBfromlastA =
  { mutable i_896 : 'c ; mutable i_895 : 'b ; mutable major_848 : 'a }

let alwaysBfromlastA (cstate_1065:Ztypes.cstate) = 
  let Node { alloc = i_896_alloc; step = i_896_step ; reset = i_896_reset } = sincelast 
  cstate_1065 in 
  let Node { alloc = i_895_alloc; step = i_895_step ; reset = i_895_reset } = never 
  cstate_1065 in
  let alwaysBfromlastA_alloc _ =
    ();
    { major_848 = false;
      i_896 = i_896_alloc () (* continuous *)  ;
      i_895 = i_895_alloc () (* continuous *)  } in
  let alwaysBfromlastA_step self ((time_847:float) ,
                                  ((a_845:float) , (b_846:float))) =
    ((self.major_848 <- cstate_1065.major ;
      q_or ((i_895_step self.i_895 (time_847 , a_845)) ,
            (q_not (i_896_step self.i_896
                      (time_847 , ((q_not b_846) , a_845)))))):float) in 
  let alwaysBfromlastA_reset self  =
    ((i_896_reset self.i_896  ; i_895_reset self.i_895 ):unit) in
  Node { alloc = alwaysBfromlastA_alloc; step = alwaysBfromlastA_step ;
                                         reset = alwaysBfromlastA_reset }
type ('c , 'b , 'a) _alwaysBfromfirstA =
  { mutable i_898 : 'c ; mutable i_897 : 'b ; mutable major_852 : 'a }

let alwaysBfromfirstA (cstate_1071:Ztypes.cstate) = 
  let Node { alloc = i_898_alloc; step = i_898_step ; reset = i_898_reset } = sincefirst 
  cstate_1071 in 
  let Node { alloc = i_897_alloc; step = i_897_step ; reset = i_897_reset } = never 
  cstate_1071 in
  let alwaysBfromfirstA_alloc _ =
    ();
    { major_852 = false;
      i_898 = i_898_alloc () (* continuous *)  ;
      i_897 = i_897_alloc () (* continuous *)  } in
  let alwaysBfromfirstA_step self ((time_851:float) ,
                                   ((a_849:float) , (b_850:float))) =
    ((self.major_852 <- cstate_1071.major ;
      q_or ((i_897_step self.i_897 (time_851 , a_849)) ,
            (q_not (i_898_step self.i_898
                      (time_851 , ((q_not b_850) , a_849)))))):float) in 
  let alwaysBfromfirstA_reset self  =
    ((i_898_reset self.i_898  ; i_897_reset self.i_897 ):unit) in
  Node { alloc = alwaysBfromfirstA_alloc; step = alwaysBfromfirstA_step ;
                                          reset = alwaysBfromfirstA_reset }
type ('b , 'a) _alwaysBfromA =
  { mutable i_899 : 'b ; mutable major_856 : 'a }

let alwaysBfromA (cstate_1077:Ztypes.cstate) = 
  let Node { alloc = i_899_alloc; step = i_899_step ; reset = i_899_reset } = alwaysBfromlastA 
  cstate_1077 in
  let alwaysBfromA_alloc _ =
    ();{ major_856 = false;i_899 = i_899_alloc () (* continuous *)  } in
  let alwaysBfromA_step self ((time_855:float) ,
                              ((a_853:float) , (b_854:float))) =
    ((self.major_856 <- cstate_1077.major ;
      i_899_step self.i_899 (time_855 , (a_853 , b_854))):float) in 
  let alwaysBfromA_reset self  =
    (i_899_reset self.i_899 :unit) in
  Node { alloc = alwaysBfromA_alloc; step = alwaysBfromA_step ;
                                     reset = alwaysBfromA_reset }
type ('b , 'a) _neverBfromlastA =
  { mutable i_900 : 'b ; mutable major_860 : 'a }

let neverBfromlastA (cstate_1083:Ztypes.cstate) = 
  let Node { alloc = i_900_alloc; step = i_900_step ; reset = i_900_reset } = alwaysBfromlastA 
  cstate_1083 in
  let neverBfromlastA_alloc _ =
    ();{ major_860 = false;i_900 = i_900_alloc () (* continuous *)  } in
  let neverBfromlastA_step self ((time_859:float) ,
                                 ((a_857:float) , (b_858:float))) =
    ((self.major_860 <- cstate_1083.major ;
      i_900_step self.i_900 (time_859 , (a_857 , (q_not b_858)))):float) in 
  let neverBfromlastA_reset self  =
    (i_900_reset self.i_900 :unit) in
  Node { alloc = neverBfromlastA_alloc; step = neverBfromlastA_step ;
                                        reset = neverBfromlastA_reset }
type ('b , 'a) _neverBfromfirstA =
  { mutable i_901 : 'b ; mutable major_864 : 'a }

let neverBfromfirstA (cstate_1089:Ztypes.cstate) = 
  let Node { alloc = i_901_alloc; step = i_901_step ; reset = i_901_reset } = alwaysBfromfirstA 
  cstate_1089 in
  let neverBfromfirstA_alloc _ =
    ();{ major_864 = false;i_901 = i_901_alloc () (* continuous *)  } in
  let neverBfromfirstA_step self ((time_863:float) ,
                                  ((a_861:float) , (b_862:float))) =
    ((self.major_864 <- cstate_1089.major ;
      i_901_step self.i_901 (time_863 , (a_861 , (q_not b_862)))):float) in 
  let neverBfromfirstA_reset self  =
    (i_901_reset self.i_901 :unit) in
  Node { alloc = neverBfromfirstA_alloc; step = neverBfromfirstA_step ;
                                         reset = neverBfromfirstA_reset }
type ('b , 'a) _neverBfromA =
  { mutable i_902 : 'b ; mutable major_868 : 'a }

let neverBfromA (cstate_1095:Ztypes.cstate) = 
  let Node { alloc = i_902_alloc; step = i_902_step ; reset = i_902_reset } = neverBfromlastA 
  cstate_1095 in
  let neverBfromA_alloc _ =
    ();{ major_868 = false;i_902 = i_902_alloc () (* continuous *)  } in
  let neverBfromA_step self ((time_867:float) ,
                             ((a_865:float) , (b_866:float))) =
    ((self.major_868 <- cstate_1095.major ;
      i_902_step self.i_902 (time_867 , (a_865 , b_866))):float) in 
  let neverBfromA_reset self  =
    (i_902_reset self.i_902 :unit) in
  Node { alloc = neverBfromA_alloc; step = neverBfromA_step ;
                                    reset = neverBfromA_reset }
