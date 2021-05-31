(* The Zélus compiler, version 2.0
  (jeudi 4 juin 2020, 17:57:12 (UTC+0200)) *)
open Ztypes
open Constants
open Matrix
open F16_mlutils
open MyOp
type ('b , 'a) _integrate =
  { mutable i_367 : 'b ; mutable m_365 : 'a }

let integrate  = 
  
  let integrate_alloc _ =
    ();{ i_367 = (false:bool) ; m_365 = (Obj.magic ():MyOp.t) } in
  let integrate_reset self  =
    (self.i_367 <- true:unit) in 
  let integrate_step self ((x0_363:MyOp.t) , (dx_361:MyOp.t) , (h_362:MyOp.t)) =
    (((if self.i_367 then self.m_365 <- x0_363) ;
      self.i_367 <- false ;
      (let (x_366:MyOp.t) = self.m_365 in
       self.m_365 <- MyOp.(+) x_366  (MyOp.( * ) h_362  dx_361) ; x_366)):
    MyOp.t) in
  Node { alloc = integrate_alloc; reset = integrate_reset ;
                                  step = integrate_step }
let saturate ((x_370:MyOp.t) , (low_369:MyOp.t) , (high_368:MyOp.t)) =
  MyOp.max (MyOp.min x_370  high_368)  low_369

let round (f_371:MyOp.t) =
  let ((frac_372:float) , (i_373:float)) = MyOp.modf f_371 in
  if (>=) (MyOp.make frac_372)  (MyOp.make 0.5)
  then MyOp.make ((+.) i_373  1.)
  else MyOp.make i_373

type _pdot = unit

let pdot  = 
   let pdot_alloc _ = () in
  let pdot_reset self  =
    ((()):unit) in 
  let pdot_step self ((p3_375:MyOp.t) , (p1_374:MyOp.t)) =
    ((let ((t_377:MyOp.t) , (p2_376:MyOp.t)) =
          if (>=) p1_374  (MyOp.make 50.)
          then
            if (>=) p3_375  (MyOp.make 50.)
            then ((MyOp.make 5.) , p1_374)
            else
              ((F16_mlutils.rtau (MyOp.(-) (MyOp.make 60.)  p3_375)) ,
               (MyOp.make 60.))
          else
            if (>=) p3_375  (MyOp.make 50.)
            then ((MyOp.make 5.) , (MyOp.make 40.))
            else ((F16_mlutils.rtau (MyOp.(-) p1_374  p3_375)) , p1_374) in
      MyOp.( * ) t_377  (MyOp.(-) p2_376  p3_375)):MyOp.t) in
  Node { alloc = pdot_alloc; reset = pdot_reset ; step = pdot_step }
let morellif16 ((alpha_378:MyOp.t) ,
                (beta_380:MyOp.t) ,
                (de_383:MyOp.t) ,
                (da_382:MyOp.t) ,
                (dr_384:MyOp.t) ,
                (p_385:MyOp.t) ,
                (q_386:MyOp.t) ,
                (r_387:MyOp.t) ,
                (cbar_381:MyOp.t) ,
                (b_379:MyOp.t) ,
                (v_388:MyOp.t) , (xcg_389:MyOp.t) , (xcgref_390:MyOp.t)) =
  let (qhat_492:MyOp.t) =
      MyOp.(/) (MyOp.( * ) q_386  cbar_381)  (MyOp.scale v_388  2.) in
  let (a0_397:MyOp.t) = MyOp.make (-0.01943367) in
  let (a1_398:MyOp.t) = MyOp.make 0.2136104 in
  let (a2_399:MyOp.t) = MyOp.make (-0.2903457) in
  let (a3_400:MyOp.t) = MyOp.make (-0.003348641) in
  let (a4_401:MyOp.t) = MyOp.make (-0.2060504) in
  let (a5_402:MyOp.t) = MyOp.make 0.6988016 in
  let (a6_403:MyOp.t) = MyOp.make (-0.9035381) in
  let (cx0_516:MyOp.t) =
      MyOp.(+) (MyOp.(+) (MyOp.(+) (MyOp.(+) (MyOp.(+) (MyOp.(+) a0_397 
                                                                 (MyOp.( * ) 
                                                                    a1_398 
                                                                    alpha_378))
                                                       
                                                       (MyOp.( * ) a2_399 
                                                                   (MyOp.pow 
                                                                    de_383 
                                                                    2.))) 
                                             (MyOp.( * ) a3_400  de_383)) 
                                   (MyOp.( * ) (MyOp.( * ) a4_401  alpha_378)
                                                de_383)) 
                         (MyOp.( * ) a5_402  (MyOp.pow alpha_378  2.))) 
               (MyOp.( * ) a6_403  (MyOp.pow alpha_378  3.)) in
  let (b0_404:MyOp.t) = MyOp.make 0.4833383 in
  let (b1_405:MyOp.t) = MyOp.make 8.644627 in
  let (b2_406:MyOp.t) = MyOp.make 11.31098 in
  let (b3_407:MyOp.t) = MyOp.make (-74.22961) in
  let (b4_408:MyOp.t) = MyOp.make 60.75776 in
  let (cxq_517:MyOp.t) =
      MyOp.(+) (MyOp.(+) (MyOp.(+) (MyOp.(+) b0_404 
                                             (MyOp.( * ) b1_405  alpha_378)) 
                                   (MyOp.( * ) b2_406 
                                               (MyOp.pow alpha_378  2.))) 
                         (MyOp.( * ) b3_407  (MyOp.pow alpha_378  3.))) 
               (MyOp.( * ) b4_408  (MyOp.pow alpha_378  4.)) in
  let (cx_394:MyOp.t) = MyOp.(+) cx0_516  (MyOp.( * ) cxq_517  qhat_492) in
  let (phat_488:MyOp.t) =
      MyOp.(/) (MyOp.( * ) p_385  b_379)  (MyOp.scale v_388  2.) in
  let (rhat_503:MyOp.t) =
      MyOp.(/) (MyOp.( * ) r_387  b_379)  (MyOp.scale v_388  2.) in
  let (h0_431:MyOp.t) = MyOp.make (-0.105853) in
  let (h1_432:MyOp.t) = MyOp.make (-0.5776677) in
  let (h2_433:MyOp.t) = MyOp.make (-0.01672435) in
  let (h3_434:MyOp.t) = MyOp.make 0.1357256 in
  let (h4_435:MyOp.t) = MyOp.make 0.2172952 in
  let (h5_436:MyOp.t) = MyOp.make 3.464156 in
  let (h6_437:MyOp.t) = MyOp.make (-2.835451) in
  let (h7_438:MyOp.t) = MyOp.make (-1.098104) in
  let (cl0_510:MyOp.t) =
      MyOp.(+) (MyOp.(+) (MyOp.(+) (MyOp.(+) (MyOp.(+) (MyOp.(+) (MyOp.(+) 
                                                                    (
                                                                    MyOp.( * ) 
                                                                    h0_431 
                                                                    beta_380)
                                                                    
                                                                    (
                                                                    MyOp.( * ) 
                                                                    (
                                                                    MyOp.( * ) 
                                                                    h1_432 
                                                                    alpha_378)
                                                                     
                                                                    beta_380))
                                                                 
                                                                 (MyOp.( * ) 
                                                                    (
                                                                    MyOp.( * ) 
                                                                    h2_433 
                                                                    (
                                                                    MyOp.pow 
                                                                    alpha_378
                                                                     
                                                                    2.)) 
                                                                    beta_380))
                                                       
                                                       (MyOp.( * ) h3_434 
                                                                   (MyOp.pow 
                                                                    beta_380 
                                                                    2.))) 
                                             (MyOp.( * ) (MyOp.( * ) 
                                                            h4_435  alpha_378)
                                                         
                                                         (MyOp.pow beta_380 
                                                                   2.))) 
                                   (MyOp.( * ) (MyOp.( * ) h5_436 
                                                           (MyOp.pow 
                                                              alpha_378  3.))
                                                beta_380)) 
                         (MyOp.( * ) (MyOp.( * ) h6_437 
                                                 (MyOp.pow alpha_378  4.)) 
                                     beta_380)) 
               (MyOp.( * ) (MyOp.( * ) h7_438  (MyOp.pow alpha_378  2.)) 
                           (MyOp.pow beta_380  2.)) in
  let (i0_439:MyOp.t) = MyOp.make (-0.4126806) in
  let (i1_440:MyOp.t) = MyOp.make (-0.1189974) in
  let (i2_441:MyOp.t) = MyOp.make 1.247721 in
  let (i3_442:MyOp.t) = MyOp.make (-0.7391132) in
  let (clp_513:MyOp.t) =
      MyOp.(+) (MyOp.(+) (MyOp.(+) i0_439  (MyOp.( * ) i1_440  alpha_378)) 
                         (MyOp.( * ) i2_441  (MyOp.pow alpha_378  2.))) 
               (MyOp.( * ) i3_442  (MyOp.pow alpha_378  3.)) in
  let (j0_443:MyOp.t) = MyOp.make 0.06250437 in
  let (j1_444:MyOp.t) = MyOp.make 0.6067723 in
  let (j2_445:MyOp.t) = MyOp.make (-1.101964) in
  let (j3_446:MyOp.t) = MyOp.make 9.100087 in
  let (j4_447:MyOp.t) = MyOp.make (-11.92672) in
  let (clr_514:MyOp.t) =
      MyOp.(+) (MyOp.(+) (MyOp.(+) (MyOp.(+) j0_443 
                                             (MyOp.( * ) j1_444  alpha_378)) 
                                   (MyOp.( * ) j2_445 
                                               (MyOp.pow alpha_378  2.))) 
                         (MyOp.( * ) j3_446  (MyOp.pow alpha_378  3.))) 
               (MyOp.( * ) j4_447  (MyOp.pow alpha_378  4.)) in
  let (k0_448:MyOp.t) = MyOp.make (-0.1463144) in
  let (k1_449:MyOp.t) = MyOp.make (-0.0407391) in
  let (k2_450:MyOp.t) = MyOp.make 0.03253159 in
  let (k3_451:MyOp.t) = MyOp.make 0.4851209 in
  let (k4_452:MyOp.t) = MyOp.make 0.297885 in
  let (k5_453:MyOp.t) = MyOp.make (-0.3746393) in
  let (k6_454:MyOp.t) = MyOp.make (-0.3213068) in
  let (clda_511:MyOp.t) =
      MyOp.(+) (MyOp.(+) (MyOp.(+) (MyOp.(+) (MyOp.(+) (MyOp.(+) k0_448 
                                                                 (MyOp.( * ) 
                                                                    k1_449 
                                                                    alpha_378))
                                                       
                                                       (MyOp.( * ) k2_450 
                                                                   beta_380))
                                             
                                             (MyOp.( * ) k3_451 
                                                         (MyOp.pow alpha_378 
                                                                   2.))) 
                                   (MyOp.( * ) (MyOp.( * ) k4_452  alpha_378)
                                                beta_380)) 
                         (MyOp.( * ) (MyOp.( * ) k5_453 
                                                 (MyOp.pow alpha_378  2.)) 
                                     beta_380)) 
               (MyOp.( * ) k6_454  (MyOp.pow alpha_378  3.)) in
  let (l0_455:MyOp.t) = MyOp.make 0.02635729 in
  let (l1_456:MyOp.t) = MyOp.make (-0.0219291) in
  let (l2_457:MyOp.t) = MyOp.make (-0.003152901) in
  let (l3_458:MyOp.t) = MyOp.make (-0.05817803) in
  let (l4_459:MyOp.t) = MyOp.make 0.4516159 in
  let (l5_460:MyOp.t) = MyOp.make (-0.4928702) in
  let (l6_461:MyOp.t) = MyOp.make (-0.01579864) in
  let (cldr_512:MyOp.t) =
      MyOp.(+) (MyOp.(+) (MyOp.(+) (MyOp.(+) (MyOp.(+) (MyOp.(+) l0_455 
                                                                 (MyOp.( * ) 
                                                                    l1_456 
                                                                    alpha_378))
                                                       
                                                       (MyOp.( * ) l2_457 
                                                                   beta_380))
                                             
                                             (MyOp.( * ) (MyOp.( * ) 
                                                            l3_458  alpha_378)
                                                          beta_380)) 
                                   (MyOp.( * ) (MyOp.( * ) l4_459 
                                                           (MyOp.pow 
                                                              alpha_378  2.))
                                                beta_380)) 
                         (MyOp.( * ) (MyOp.( * ) l5_460 
                                                 (MyOp.pow alpha_378  3.)) 
                                     beta_380)) 
               (MyOp.( * ) l6_461  (MyOp.pow beta_380  2.)) in
  let (cl_391:MyOp.t) =
      MyOp.(+) (MyOp.(+) (MyOp.(+) (MyOp.(+) cl0_510 
                                             (MyOp.( * ) clp_513  phat_488)) 
                                   (MyOp.( * ) clr_514  rhat_503)) 
                         (MyOp.( * ) clda_511  da_382)) 
               (MyOp.( * ) cldr_512  dr_384) in
  let (m0_462:MyOp.t) = MyOp.make (-0.0202937) in
  let (m1_463:MyOp.t) = MyOp.make 0.04660702 in
  let (m2_464:MyOp.t) = MyOp.make (-0.6012308) in
  let (m3_465:MyOp.t) = MyOp.make (-0.08062977) in
  let (m4_466:MyOp.t) = MyOp.make 0.08320429 in
  let (m5_467:MyOp.t) = MyOp.make 0.5018538 in
  let (m6_468:MyOp.t) = MyOp.make 0.6378864 in
  let (m7_469:MyOp.t) = MyOp.make 0.4226356 in
  let (cm0_515:MyOp.t) =
      MyOp.(+) (MyOp.(+) (MyOp.(+) (MyOp.(+) (MyOp.(+) (MyOp.(+) (MyOp.(+) 
                                                                    m0_462 
                                                                    (
                                                                    MyOp.( * ) 
                                                                    m1_463 
                                                                    alpha_378))
                                                                 
                                                                 (MyOp.( * ) 
                                                                    m2_464 
                                                                    de_383)) 
                                                       (MyOp.( * ) (MyOp.( * ) 
                                                                    m3_465 
                                                                    alpha_378)
                                                                    de_383)) 
                                             (MyOp.( * ) m4_466 
                                                         (MyOp.pow de_383  2.)))
                                   
                                   (MyOp.( * ) (MyOp.( * ) m5_467 
                                                           (MyOp.pow 
                                                              alpha_378  2.))
                                                de_383)) 
                         (MyOp.( * ) m6_468  (MyOp.pow de_383  3.))) 
               (MyOp.( * ) (MyOp.( * ) m7_469  alpha_378) 
                           (MyOp.pow de_383  2.)) in
  let (n0_470:MyOp.t) = MyOp.make (-5.19153) in
  let (n1_471:MyOp.t) = MyOp.make (-3.554716) in
  let (n2_472:MyOp.t) = MyOp.make (-35.98636) in
  let (n3_473:MyOp.t) = MyOp.make 224.7355 in
  let (n4_474:MyOp.t) = MyOp.make (-412.0991) in
  let (n5_475:MyOp.t) = MyOp.make 241.175 in
  let (cmq_523:MyOp.t) =
      MyOp.(+) (MyOp.(+) (MyOp.(+) (MyOp.(+) (MyOp.(+) n0_470 
                                                       (MyOp.( * ) n1_471 
                                                                   alpha_378))
                                             
                                             (MyOp.( * ) n2_472 
                                                         (MyOp.pow alpha_378 
                                                                   2.))) 
                                   (MyOp.( * ) n3_473 
                                               (MyOp.pow alpha_378  3.))) 
                         (MyOp.( * ) n4_474  (MyOp.pow alpha_378  4.))) 
               (MyOp.( * ) n5_475  (MyOp.pow alpha_378  5.)) in
  let (f0_420:MyOp.t) = MyOp.make (-0.1378278) in
  let (f1_421:MyOp.t) = MyOp.make (-4.211369) in
  let (f2_422:MyOp.t) = MyOp.make 4.775187 in
  let (f3_423:MyOp.t) = MyOp.make (-10.26225) in
  let (f4_424:MyOp.t) = MyOp.make 8.399763 in
  let (f5_425:MyOp.t) = MyOp.make (-0.4354) in
  let (cz0_521:MyOp.t) =
      MyOp.(+) (MyOp.( * ) (MyOp.(+) (MyOp.(+) (MyOp.(+) (MyOp.(+) f0_420 
                                                                   (MyOp.( * ) 
                                                                    f1_421 
                                                                    alpha_378))
                                                         
                                                         (MyOp.( * ) 
                                                            f2_422 
                                                            (MyOp.pow 
                                                               alpha_378  2.)))
                                               
                                               (MyOp.( * ) f3_423 
                                                           (MyOp.pow 
                                                              alpha_378  3.)))
                                     
                                     (MyOp.( * ) f4_424 
                                                 (MyOp.pow alpha_378  4.))) 
                           (MyOp.(-) (MyOp.make 1.)  (MyOp.pow beta_380  2.)))
                (MyOp.( * ) f5_425  de_383) in
  let (g0_426:MyOp.t) = MyOp.make (-30.54956) in
  let (g1_427:MyOp.t) = MyOp.make (-41.32305) in
  let (g2_428:MyOp.t) = MyOp.make 329.2788 in
  let (g3_429:MyOp.t) = MyOp.make (-684.8038) in
  let (g4_430:MyOp.t) = MyOp.make 408.0244 in
  let (czq_522:MyOp.t) =
      MyOp.(+) (MyOp.(+) (MyOp.(+) (MyOp.(+) g0_426 
                                             (MyOp.( * ) g1_427  alpha_378)) 
                                   (MyOp.( * ) g2_428 
                                               (MyOp.pow alpha_378  2.))) 
                         (MyOp.( * ) g3_429  (MyOp.pow alpha_378  3.))) 
               (MyOp.( * ) g4_430  (MyOp.pow alpha_378  4.)) in
  let (cz_396:MyOp.t) = MyOp.(+) cz0_521  (MyOp.( * ) czq_522  qhat_492) in
  let (cm_392:MyOp.t) =
      MyOp.(+) (MyOp.(+) cm0_515  (MyOp.( * ) cmq_523  qhat_492)) 
               (MyOp.( * ) cz_396  (MyOp.(-) xcgref_390  xcg_389)) in
  let (o0_476:MyOp.t) = MyOp.make 0.2993363 in
  let (o1_477:MyOp.t) = MyOp.make 0.06594004 in
  let (o2_478:MyOp.t) = MyOp.make (-0.2003125) in
  let (o3_479:MyOp.t) = MyOp.make (-0.06233977) in
  let (o4_480:MyOp.t) = MyOp.make (-2.107885) in
  let (o5_481:MyOp.t) = MyOp.make 2.14142 in
  let (o6_482:MyOp.t) = MyOp.make 0.8476901 in
  let (cn0_524:MyOp.t) =
      MyOp.(+) (MyOp.(+) (MyOp.(+) (MyOp.(+) (MyOp.(+) (MyOp.(+) (MyOp.( * ) 
                                                                    o0_476 
                                                                    beta_380)
                                                                 
                                                                 (MyOp.( * ) 
                                                                    (
                                                                    MyOp.( * ) 
                                                                    o1_477 
                                                                    alpha_378)
                                                                     
                                                                    beta_380))
                                                       
                                                       (MyOp.( * ) o2_478 
                                                                   (MyOp.pow 
                                                                    beta_380 
                                                                    2.))) 
                                             (MyOp.( * ) (MyOp.( * ) 
                                                            o3_479  alpha_378)
                                                         
                                                         (MyOp.pow beta_380 
                                                                   2.))) 
                                   (MyOp.( * ) (MyOp.( * ) o4_480 
                                                           (MyOp.pow 
                                                              alpha_378  2.))
                                                beta_380)) 
                         (MyOp.( * ) (MyOp.( * ) o5_481 
                                                 (MyOp.pow alpha_378  2.)) 
                                     (MyOp.pow beta_380  2.))) 
               (MyOp.( * ) (MyOp.( * ) o6_482  (MyOp.pow alpha_378  3.)) 
                           beta_380) in
  let (p0_483:MyOp.t) = MyOp.make 0.02677652 in
  let (p1_484:MyOp.t) = MyOp.make (-0.3298246) in
  let (p2_485:MyOp.t) = MyOp.make 0.1926178 in
  let (p3_486:MyOp.t) = MyOp.make 4.013325 in
  let (p4_487:MyOp.t) = MyOp.make (-4.404302) in
  let (cnp_527:MyOp.t) =
      MyOp.(+) (MyOp.(+) (MyOp.(+) (MyOp.(+) p0_483 
                                             (MyOp.( * ) p1_484  alpha_378)) 
                                   (MyOp.( * ) p2_485 
                                               (MyOp.pow alpha_378  2.))) 
                         (MyOp.( * ) p3_486  (MyOp.pow alpha_378  3.))) 
               (MyOp.( * ) p4_487  (MyOp.pow alpha_378  4.)) in
  let (q0_489:MyOp.t) = MyOp.make (-0.3698756) in
  let (q1_490:MyOp.t) = MyOp.make (-0.1167551) in
  let (q2_491:MyOp.t) = MyOp.make (-0.7641297) in
  let (cnr_528:MyOp.t) =
      MyOp.(+) (MyOp.(+) q0_489  (MyOp.( * ) q1_490  alpha_378)) 
               (MyOp.( * ) q2_491  (MyOp.pow alpha_378  2.)) in
  let (r0_493:MyOp.t) = MyOp.make (-0.03348717) in
  let (r1_494:MyOp.t) = MyOp.make 0.04276655 in
  let (r2_495:MyOp.t) = MyOp.make 0.006573646 in
  let (r3_496:MyOp.t) = MyOp.make 0.3535831 in
  let (r4_497:MyOp.t) = MyOp.make (-1.373308) in
  let (r5_498:MyOp.t) = MyOp.make 1.237582 in
  let (r6_499:MyOp.t) = MyOp.make 0.2302543 in
  let (r7_500:MyOp.t) = MyOp.make (-0.2512876) in
  let (r8_501:MyOp.t) = MyOp.make 0.1588105 in
  let (r9_502:MyOp.t) = MyOp.make (-0.5199526) in
  let (cnda_525:MyOp.t) =
      MyOp.(+) (MyOp.(+) (MyOp.(+) (MyOp.(+) (MyOp.(+) (MyOp.(+) (MyOp.(+) 
                                                                    (
                                                                    MyOp.(+) 
                                                                    (
                                                                    MyOp.(+) 
                                                                    r0_493 
                                                                    (
                                                                    MyOp.( * ) 
                                                                    r1_494 
                                                                    alpha_378))
                                                                    
                                                                    (
                                                                    MyOp.( * ) 
                                                                    r2_495 
                                                                    beta_380))
                                                                    
                                                                    (
                                                                    MyOp.( * ) 
                                                                    (
                                                                    MyOp.( * ) 
                                                                    r3_496 
                                                                    alpha_378)
                                                                     
                                                                    beta_380))
                                                                 
                                                                 (MyOp.( * ) 
                                                                    (
                                                                    MyOp.( * ) 
                                                                    r4_497 
                                                                    (
                                                                    MyOp.pow 
                                                                    alpha_378
                                                                     
                                                                    2.)) 
                                                                    beta_380))
                                                       
                                                       (MyOp.( * ) (MyOp.( * ) 
                                                                    r5_498 
                                                                    (
                                                                    MyOp.pow 
                                                                    alpha_378
                                                                     
                                                                    3.)) 
                                                                   beta_380))
                                             
                                             (MyOp.( * ) r6_499 
                                                         (MyOp.pow alpha_378 
                                                                   2.))) 
                                   (MyOp.( * ) r7_500 
                                               (MyOp.pow alpha_378  3.))) 
                         (MyOp.( * ) r8_501  (MyOp.pow beta_380  3.))) 
               (MyOp.( * ) (MyOp.( * ) r9_502  alpha_378) 
                           (MyOp.pow beta_380  3.)) in
  let (s0_504:MyOp.t) = MyOp.make (-0.08115894) in
  let (s1_505:MyOp.t) = MyOp.make (-0.0115658) in
  let (s2_506:MyOp.t) = MyOp.make 0.02514167 in
  let (s3_507:MyOp.t) = MyOp.make 0.2038748 in
  let (s4_508:MyOp.t) = MyOp.make (-0.3337476) in
  let (s5_509:MyOp.t) = MyOp.make 0.1004297 in
  let (cndr_526:MyOp.t) =
      MyOp.(+) (MyOp.(+) (MyOp.(+) (MyOp.(+) (MyOp.(+) s0_504 
                                                       (MyOp.( * ) s1_505 
                                                                   alpha_378))
                                              (MyOp.( * ) s2_506  beta_380)) 
                                   (MyOp.( * ) (MyOp.( * ) s3_507  alpha_378)
                                                beta_380)) 
                         (MyOp.( * ) (MyOp.( * ) s4_508 
                                                 (MyOp.pow alpha_378  2.)) 
                                     beta_380)) 
               (MyOp.( * ) s5_509  (MyOp.pow alpha_378  2.)) in
  let (c0_409:MyOp.t) = MyOp.make (-1.145916) in
  let (c1_410:MyOp.t) = MyOp.make 0.06016057 in
  let (c2_411:MyOp.t) = MyOp.make 0.1642479 in
  let (cy0_518:MyOp.t) =
      MyOp.(+) (MyOp.(+) (MyOp.( * ) c0_409  beta_380) 
                         (MyOp.( * ) c1_410  da_382)) 
               (MyOp.( * ) c2_411  dr_384) in
  let (d0_412:MyOp.t) = MyOp.make (-0.1006733) in
  let (d1_413:MyOp.t) = MyOp.make 0.8679799 in
  let (d2_414:MyOp.t) = MyOp.make 4.260586 in
  let (d3_415:MyOp.t) = MyOp.make (-6.923267) in
  let (cyp_519:MyOp.t) =
      MyOp.(+) (MyOp.(+) (MyOp.(+) d0_412  (MyOp.( * ) d1_413  alpha_378)) 
                         (MyOp.( * ) d2_414  (MyOp.pow alpha_378  2.))) 
               (MyOp.( * ) d3_415  (MyOp.pow alpha_378  3.)) in
  let (e0_416:MyOp.t) = MyOp.make 0.8071648 in
  let (e1_417:MyOp.t) = MyOp.make 0.1189633 in
  let (e2_418:MyOp.t) = MyOp.make 4.177702 in
  let (e3_419:MyOp.t) = MyOp.make (-9.162236) in
  let (cyr_520:MyOp.t) =
      MyOp.(+) (MyOp.(+) (MyOp.(+) e0_416  (MyOp.( * ) e1_417  alpha_378)) 
                         (MyOp.( * ) e2_418  (MyOp.pow alpha_378  2.))) 
               (MyOp.( * ) e3_419  (MyOp.pow alpha_378  3.)) in
  let (cy_395:MyOp.t) =
      MyOp.(+) (MyOp.(+) cy0_518  (MyOp.( * ) cyp_519  phat_488)) 
               (MyOp.( * ) cyr_520  rhat_503) in
  let (cn_393:MyOp.t) =
      MyOp.(-) (MyOp.(+) (MyOp.(+) (MyOp.(+) (MyOp.(+) cn0_524 
                                                       (MyOp.( * ) cnp_527 
                                                                   phat_488))
                                              (MyOp.( * ) cnr_528  rhat_503))
                                    (MyOp.( * ) cnda_525  da_382)) 
                         (MyOp.( * ) cndr_526  dr_384)) 
               (MyOp.( * ) (MyOp.( * ) cy_395  (MyOp.(-) xcgref_390  xcg_389))
                            (MyOp.(/) cbar_381  b_379)) in
  (cx_394 , cy_395 , cz_396 , cl_391 , cm_392 , cn_393)

let stevensf16 ((alpha_530:MyOp.t) ,
                (beta_531:MyOp.t) ,
                (el_532:MyOp.t) , (ail_529:MyOp.t) , (rdr_533:MyOp.t)) =
  let (cxt_537:MyOp.t) = F16_mlutils.cx (alpha_530 , el_532) in
  let (cyt_538:MyOp.t) = F16_mlutils.cy (beta_531 , ail_529 , rdr_533) in
  let (czt_539:MyOp.t) = F16_mlutils.cz (alpha_530 , beta_531 , el_532) in
  let (dail_540:MyOp.t) = MyOp.scale ail_529  ((/.) 1.  20.) in
  let (drdr_541:MyOp.t) = MyOp.scale rdr_533  ((/.) 1.  30.) in
  let (clt_534:MyOp.t) =
      MyOp.(+) (MyOp.(+) (F16_mlutils.cl (alpha_530 , beta_531)) 
                         (MyOp.( * ) (F16_mlutils.dlda (alpha_530 , beta_531))
                                      dail_540)) 
               (MyOp.( * ) (F16_mlutils.dldr (alpha_530 , beta_531)) 
                           drdr_541) in
  let (cmt_535:MyOp.t) = F16_mlutils.cm (alpha_530 , el_532) in
  let (cnt_536:MyOp.t) =
      MyOp.(+) (MyOp.(+) (F16_mlutils.cn (alpha_530 , beta_531)) 
                         (MyOp.( * ) (F16_mlutils.dnda (alpha_530 , beta_531))
                                      dail_540)) 
               (MyOp.( * ) (F16_mlutils.dndr (alpha_530 , beta_531)) 
                           drdr_541) in
  (cxt_537 , cyt_538 , czt_539 , clt_534 , cmt_535 , cnt_536)

