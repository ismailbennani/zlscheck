(* The Zélus compiler, version 2.0
  (lundi 25 mai 2020, 14:33:03 (UTC+0200)) *)
open Ztypes
type dual = (float  * float)
let make ((re_328:'a4588) , (im_327:'a4587)) =
  (re_328 , im_327)

let re ((re_329:'a4595) , _) =
  re_329

let im (_ , (im_330:'a4601)) =
  im_330

let split ((d_331:'a4614) , (d_332:'a4613)) =
  (d_331 , d_332)

let eq (((d1_335:'a4633) , (d1_336:'a4631)) ,
        ((d2_337:'a4633) , (d2_338:'a4635))) =
  (=) d1_335  d2_337

let neq (((d1_341:'a4652) , (d1_342:'a4650)) ,
         ((d2_343:'a4652) , (d2_344:'a4654))) =
  (<>) d1_341  d2_343

let lt (((d1_347:'a4671) , (d1_348:'a4669)) ,
        ((d2_349:'a4671) , (d2_350:'a4673))) =
  (<) d1_347  d2_349

let le (((d1_353:'a4690) , (d1_354:'a4688)) ,
        ((d2_355:'a4690) , (d2_356:'a4692))) =
  (<=) d1_353  d2_355

let gt (((d1_359:'a4709) , (d1_360:'a4707)) ,
        ((d2_361:'a4709) , (d2_362:'a4711))) =
  (>) d1_359  d2_361

let ge (((d1_365:'a4728) , (d1_366:'a4726)) ,
        ((d2_367:'a4728) , (d2_368:'a4730))) =
  (>=) d1_365  d2_367

let neg ((d_371:float) , (d_372:float)) =
  (((~-.) d_371) , ((~-.) d_372))

let add (((d1_375:float) , (d1_376:float)) ,
         ((d2_377:float) , (d2_378:float))) =
  (((+.) d1_375  d2_377) , ((+.) d1_376  d2_378))

let sub (((d1_383:float) , (d1_384:float)) ,
         ((d2_385:float) , (d2_386:float))) =
  (((-.) d1_383  d2_385) , ((-.) d1_384  d2_386))

let mul (((d1_391:float) , (d1_392:float)) ,
         ((d2_393:float) , (d2_394:float))) =
  ((( *. ) d1_391  d2_393) ,
   ((+.) (( *. ) d1_391  d2_394)  (( *. ) d1_392  d2_393)))

let div (((d1_401:float) , (d1_402:float)) ,
         ((d2_403:float) , (d2_404:float))) =
  (((/.) d1_401  d2_403) ,
   ((/.) ((+.) (( *. ) d1_401  d2_404)  (( *. ) d1_402  d2_403)) 
         (( *. ) d2_403  d2_403)))

let pow (((d_413:float) , (d_414:float)) , (k_415:float)) =
  ((( ** ) d_413  k_415) ,
   (( *. ) (( *. ) k_415  d_414)  (( ** ) d_413  ((-.) k_415  1.))))

let scale (((d_419:float) , (d_420:float)) , (f_421:float)) =
  ((( *. ) f_421  d_419) , (( *. ) f_421  d_420))

let translate (((d_424:float) , (d_425:'a5027)) , (f_426:float)) =
  (((+.) d_424  f_426) , d_425)

let sqrt ((d_429:float) , (d_430:float)) =
  ((Stdlib.sqrt d_429) , ((/.) d_430  (( *. ) 2.  (Stdlib.sqrt d_429))))

let exp ((d_434:float) , (d_435:float)) =
  ((Stdlib.exp d_434) , (( *. ) d_435  (Stdlib.exp d_434)))

let log ((d_439:float) , (d_440:float)) =
  ((Stdlib.log d_439) , ((/.) d_440  d_439))

let log10 ((d_444:float) , (d_445:float)) =
  ((Stdlib.log10 d_444) , ((/.) d_445  (( *. ) (Stdlib.log 10.)  d_444)))

let cos ((d_449:float) , (d_450:float)) =
  ((Stdlib.cos d_449) , (( *. ) ((~-.) d_450)  (Stdlib.sin d_449)))

let sin ((d_454:float) , (d_455:float)) =
  ((Stdlib.sin d_454) , (( *. ) d_455  (Stdlib.cos d_454)))

let tan ((d_459:float) , (d_460:float)) =
  ((Stdlib.tan d_459) ,
   ((/.) d_460  (( *. ) (Stdlib.cos d_459)  (Stdlib.cos d_459))))

let acos ((d_465:float) , (d_466:float)) =
  ((Stdlib.acos d_465) ,
   ((/.) ((~-.) d_466)  (Stdlib.sqrt ((-.) 1.  (( *. ) d_465  d_465)))))

let asin ((d_471:float) , (d_472:float)) =
  ((Stdlib.asin d_471) ,
   ((/.) d_472  (Stdlib.sqrt ((-.) 1.  (( *. ) d_471  d_471)))))

let atan ((d_477:float) , (d_478:float)) =
  ((Stdlib.atan d_477) , ((/.) d_478  ((+.) 1.  (( *. ) d_477  d_477))))

let cosh ((d_483:float) , (d_484:float)) =
  ((Stdlib.cosh d_483) , (( *. ) d_484  (Stdlib.sinh d_483)))

let sinh ((d_488:float) , (d_489:float)) =
  ((Stdlib.sinh d_488) , (( *. ) d_489  (Stdlib.cosh d_488)))

let tanh ((d_493:float) , (d_494:float)) =
  ((Stdlib.tanh d_493) ,
   (( *. ) d_494  (( *. ) (Stdlib.cosh d_493)  (Stdlib.cosh d_493))))

let abs ((d_499:float) , (d_500:float)) =
  ((abs_float d_499) , (( *. ) ((/.) d_499  (abs_float d_499))  d_500))

let ceil ((d_505:float) , (d_506:'a5505)) =
  ((Stdlib.ceil d_505) , d_506)

let floor ((d_509:float) , (d_510:'a5520)) =
  ((Stdlib.floor d_509) , d_510)

let frexp (d_513:'a5526) =
  Assert.failwith "Dual frexp not implemented"

let ldexp (d_514:'a5532) =
  Assert.failwith "Dual ldexp not implemented"

let modf (d_515:'a5538) =
  Assert.failwith "Dual modf not implemented"

let dual_of_int (i_516:int) =
  let (re_518:float) = float i_516 in
  (re_518 , 0.)

let dual_of_float (f_519:'a5560) =
  (f_519 , 0.)

let float_of_dual ((d_522:'a5569) , (d_523:'a5571)) =
  d_522

let truncate ((d_525:float) , (d_526:'a5581)) =
  Stdlib.truncate d_525

let zero = dual_of_float 0.

let one = dual_of_float 1.

let infinity = dual_of_float Stdlib.infinity

let neg_infinity = dual_of_float Stdlib.neg_infinity

let nan = dual_of_float Stdlib.nan

let epsilon = dual_of_float epsilon_float

let max_dual = dual_of_float max_float

let min_dual = dual_of_float min_float

let dual (f_528:'a5618) =
  (f_528 , 0.)

let int_of_dual ((d_532:float) , (d_533:'a5627)) =
  truncate (d_532 , d_533)

let max (((d1_534:float) , (d1_535:float)) ,
         ((d2_536:float) , (d2_537:float))) =
  scale ((add ((add ((d1_534 , d1_535) , (d2_536 , d2_537))) ,
               (abs (sub ((d1_534 , d1_535) , (d2_536 , d2_537)))))) , 
         0.5)

let min (((d1_538:float) , (d1_539:float)) ,
         ((d2_540:float) , (d2_541:float))) =
  scale ((sub ((add ((d1_538 , d1_539) , (d2_540 , d2_541))) ,
               (abs (sub ((d1_538 , d1_539) , (d2_540 , d2_541)))))) , 
         0.5)

type ('c , 'b , 'a) _integrate =
  { mutable major_545 : 'c ; mutable i_549 : 'b ; mutable a_546 : 'a }

let integrate (cstate_561:Ztypes.cstate) = 
  
  let integrate_alloc _ =
    cstate_561.cmax <- (+) cstate_561.cmax  1;
    { major_545 = false ;
      i_549 = (false:bool) ; a_546 = { pos = 42.; der = 0. } } in
  let integrate_step self ((time_544:float) ,
                           ((y_543:float) , (x0_542:float))) =
    ((let (cindex_562:int) = cstate_561.cindex in
      let cpos_564 = ref (cindex_562:int) in
      cstate_561.cindex <- (+) cstate_561.cindex  1 ;
      self.major_545 <- cstate_561.major ;
      (if cstate_561.major then
       for i_1 = cindex_562 to 0 do Zls.set cstate_561.dvec  i_1  0. done
       else ((self.a_546.pos <- Zls.get cstate_561.cvec  !cpos_564 ;
              cpos_564 := (+) !cpos_564  1))) ;
      (let (result_566:(float  * float)) =
           (if self.i_549 then self.a_546.pos <- x0_542) ;
           self.i_549 <- false ;
           self.a_546.der <- y_543 ; (self.a_546.pos , y_543) in
       cpos_564 := cindex_562 ;
       (if cstate_561.major then
        (((Zls.set cstate_561.cvec  !cpos_564  self.a_546.pos ;
           cpos_564 := (+) !cpos_564  1)))
        else (((Zls.set cstate_561.dvec  !cpos_564  self.a_546.der ;
                cpos_564 := (+) !cpos_564  1)))) ; result_566)):float * float) in
   let integrate_reset self  =
     (self.i_549 <- true:unit) in
  Node { alloc = integrate_alloc; step = integrate_step ;
                                  reset = integrate_reset }
type ('c , 'b , 'a) _integrate_dual =
  { mutable major_554 : 'c ; mutable i_560 : 'b ; mutable new_v_557 : 'a }

let integrate_dual (cstate_567:Ztypes.cstate) = 
  
  let integrate_dual_alloc _ =
    cstate_567.cmax <- (+) cstate_567.cmax  1;
    { major_554 = false ;
      i_560 = (false:bool) ; new_v_557 = { pos = 42.; der = 0. } } in
  let integrate_dual_step self ((time_553:float) ,
                                (((d_550:float) , (d_551:'a5677)) ,
                                 (v0_552:float))) =
    ((let (cindex_568:int) = cstate_567.cindex in
      let cpos_570 = ref (cindex_568:int) in
      cstate_567.cindex <- (+) cstate_567.cindex  1 ;
      self.major_554 <- cstate_567.major ;
      (if cstate_567.major then
       for i_1 = cindex_568 to 0 do Zls.set cstate_567.dvec  i_1  0. done
       else ((self.new_v_557.pos <- Zls.get cstate_567.cvec  !cpos_570 ;
              cpos_570 := (+) !cpos_570  1))) ;
      (let (result_572:(float  * float)) =
           (if self.i_560 then self.new_v_557.pos <- v0_552) ;
           self.i_560 <- false ;
           self.new_v_557.der <- d_550 ; (self.new_v_557.pos , d_550) in
       cpos_570 := cindex_568 ;
       (if cstate_567.major then
        (((Zls.set cstate_567.cvec  !cpos_570  self.new_v_557.pos ;
           cpos_570 := (+) !cpos_570  1)))
        else (((Zls.set cstate_567.dvec  !cpos_570  self.new_v_557.der ;
                cpos_570 := (+) !cpos_570  1)))) ; result_572)):float * float) in
   let integrate_dual_reset self  =
     (self.i_560 <- true:unit) in
  Node { alloc = integrate_dual_alloc; step = integrate_dual_step ;
                                       reset = integrate_dual_reset }
