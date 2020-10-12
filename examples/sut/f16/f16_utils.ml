(* The Zélus compiler, version 2.1
  (vendredi 25 septembre 2020, 18:02:26 (UTC+0200)) *)
open Ztypes
open Constants
open Matrix
open F16_mlutils
open FadFloat
type ('b , 'a) _integrate =
  { mutable i_367 : 'b ; mutable m_365 : 'a }

let integrate  = 
  
  let integrate_alloc _ =
    ();{ i_367 = (false:bool) ; m_365 = (Obj.magic ():FadFloat.t) } in
  let integrate_reset self  =
    (self.i_367 <- true:unit) in 
  let integrate_step self ((x0_363:FadFloat.t) ,
                           (dx_361:FadFloat.t) , (h_362:FadFloat.t)) =
    (((if self.i_367 then self.m_365 <- x0_363) ;
      self.i_367 <- false ;
      (let (x_366:FadFloat.t) = self.m_365 in
       self.m_365 <- FadFloat.(+) x_366  (FadFloat.( * ) h_362  dx_361) ;
       x_366)):FadFloat.t) in
  Node { alloc = integrate_alloc; reset = integrate_reset ;
                                  step = integrate_step }
let saturate ((x_370:FadFloat.t) ,
              (low_369:FadFloat.t) , (high_368:FadFloat.t)) =
  FadFloat.max (FadFloat.min x_370  high_368)  low_369

let round (f_371:FadFloat.t) =
  let ((frac_372:float) , (i_373:float)) = FadFloat.modf f_371 in
  if (>=) (FadFloat.make frac_372)  (FadFloat.make 0.5)
  then FadFloat.make ((+.) i_373  1.)
  else FadFloat.make i_373

type _pdot = unit

let pdot  = 
   let pdot_alloc _ = () in
  let pdot_reset self  =
    ((()):unit) in 
  let pdot_step self ((p3_375:FadFloat.t) , (p1_374:FadFloat.t)) =
    ((let ((t_377:FadFloat.t) , (p2_376:FadFloat.t)) =
          if (>=) p1_374  (FadFloat.make 50.)
          then
            if (>=) p3_375  (FadFloat.make 50.)
            then ((FadFloat.make 5.) , p1_374)
            else
              ((F16_mlutils.rtau (FadFloat.(-) (FadFloat.make 60.)  p3_375))
               , (FadFloat.make 60.))
          else
            if (>=) p3_375  (FadFloat.make 50.)
            then ((FadFloat.make 5.) , (FadFloat.make 40.))
            else ((F16_mlutils.rtau (FadFloat.(-) p1_374  p3_375)) , p1_374) in
      FadFloat.( * ) t_377  (FadFloat.(-) p2_376  p3_375)):FadFloat.t) in
  Node { alloc = pdot_alloc; reset = pdot_reset ; step = pdot_step }
let morellif16 ((alpha_378:FadFloat.t) ,
                (beta_380:FadFloat.t) ,
                (de_383:FadFloat.t) ,
                (da_382:FadFloat.t) ,
                (dr_384:FadFloat.t) ,
                (p_385:FadFloat.t) ,
                (q_386:FadFloat.t) ,
                (r_387:FadFloat.t) ,
                (cbar_381:FadFloat.t) ,
                (b_379:FadFloat.t) ,
                (v_388:FadFloat.t) ,
                (xcg_389:FadFloat.t) , (xcgref_390:FadFloat.t)) =
  let (qhat_492:FadFloat.t) =
      FadFloat.(/) (FadFloat.( * ) q_386  cbar_381) 
                   (FadFloat.scale v_388  2.) in
  let (a0_397:FadFloat.t) = FadFloat.make (-0.01943367) in
  let (a1_398:FadFloat.t) = FadFloat.make 0.2136104 in
  let (a2_399:FadFloat.t) = FadFloat.make (-0.2903457) in
  let (a3_400:FadFloat.t) = FadFloat.make (-0.003348641) in
  let (a4_401:FadFloat.t) = FadFloat.make (-0.2060504) in
  let (a5_402:FadFloat.t) = FadFloat.make 0.6988016 in
  let (a6_403:FadFloat.t) = FadFloat.make (-0.9035381) in
  let (cx0_516:FadFloat.t) =
      FadFloat.(+) (FadFloat.(+) (FadFloat.(+) (FadFloat.(+) (FadFloat.(+) 
                                                                (FadFloat.(+) 
                                                                   a0_397 
                                                                   (FadFloat.( * ) 
                                                                    a1_398 
                                                                    alpha_378))
                                                                
                                                                (FadFloat.( * ) 
                                                                   a2_399 
                                                                   (FadFloat.pow 
                                                                    de_383 
                                                                    2.))) 
                                                             (FadFloat.( * ) 
                                                                a3_400 
                                                                de_383)) 
                                               (FadFloat.( * ) (FadFloat.( * ) 
                                                                  a4_401 
                                                                  alpha_378) 
                                                               de_383)) 
                                 (FadFloat.( * ) a5_402 
                                                 (FadFloat.pow alpha_378  2.)))
                    (FadFloat.( * ) a6_403  (FadFloat.pow alpha_378  3.)) in
  let (b0_404:FadFloat.t) = FadFloat.make 0.4833383 in
  let (b1_405:FadFloat.t) = FadFloat.make 8.644627 in
  let (b2_406:FadFloat.t) = FadFloat.make 11.31098 in
  let (b3_407:FadFloat.t) = FadFloat.make (-74.22961) in
  let (b4_408:FadFloat.t) = FadFloat.make 60.75776 in
  let (cxq_517:FadFloat.t) =
      FadFloat.(+) (FadFloat.(+) (FadFloat.(+) (FadFloat.(+) b0_404 
                                                             (FadFloat.( * ) 
                                                                b1_405 
                                                                alpha_378)) 
                                               (FadFloat.( * ) b2_406 
                                                               (FadFloat.pow 
                                                                  alpha_378 
                                                                  2.))) 
                                 (FadFloat.( * ) b3_407 
                                                 (FadFloat.pow alpha_378  3.)))
                    (FadFloat.( * ) b4_408  (FadFloat.pow alpha_378  4.)) in
  let (cx_394:FadFloat.t) =
      FadFloat.(+) cx0_516  (FadFloat.( * ) cxq_517  qhat_492) in
  let (phat_488:FadFloat.t) =
      FadFloat.(/) (FadFloat.( * ) p_385  b_379)  (FadFloat.scale v_388  2.) in
  let (rhat_503:FadFloat.t) =
      FadFloat.(/) (FadFloat.( * ) r_387  b_379)  (FadFloat.scale v_388  2.) in
  let (h0_431:FadFloat.t) = FadFloat.make (-0.105853) in
  let (h1_432:FadFloat.t) = FadFloat.make (-0.5776677) in
  let (h2_433:FadFloat.t) = FadFloat.make (-0.01672435) in
  let (h3_434:FadFloat.t) = FadFloat.make 0.1357256 in
  let (h4_435:FadFloat.t) = FadFloat.make 0.2172952 in
  let (h5_436:FadFloat.t) = FadFloat.make 3.464156 in
  let (h6_437:FadFloat.t) = FadFloat.make (-2.835451) in
  let (h7_438:FadFloat.t) = FadFloat.make (-1.098104) in
  let (cl0_510:FadFloat.t) =
      FadFloat.(+) (FadFloat.(+) (FadFloat.(+) (FadFloat.(+) (FadFloat.(+) 
                                                                (FadFloat.(+) 
                                                                   (FadFloat.(+) 
                                                                    (
                                                                    FadFloat.( * ) 
                                                                    h0_431 
                                                                    beta_380)
                                                                    
                                                                    (
                                                                    FadFloat.( * ) 
                                                                    (
                                                                    FadFloat.( * ) 
                                                                    h1_432 
                                                                    alpha_378)
                                                                     
                                                                    beta_380))
                                                                   
                                                                   (FadFloat.( * ) 
                                                                    (
                                                                    FadFloat.( * ) 
                                                                    h2_433 
                                                                    (
                                                                    FadFloat.pow 
                                                                    alpha_378
                                                                     
                                                                    2.)) 
                                                                    beta_380))
                                                                
                                                                (FadFloat.( * ) 
                                                                   h3_434 
                                                                   (FadFloat.pow 
                                                                    beta_380 
                                                                    2.))) 
                                                             (FadFloat.( * ) 
                                                                (FadFloat.( * ) 
                                                                   h4_435 
                                                                   alpha_378)
                                                                
                                                                (FadFloat.pow 
                                                                   beta_380 
                                                                   2.))) 
                                               (FadFloat.( * ) (FadFloat.( * ) 
                                                                  h5_436 
                                                                  (FadFloat.pow 
                                                                    alpha_378
                                                                     
                                                                    3.)) 
                                                               beta_380)) 
                                 (FadFloat.( * ) (FadFloat.( * ) h6_437 
                                                                 (FadFloat.pow 
                                                                    alpha_378
                                                                     
                                                                    4.)) 
                                                 beta_380)) 
                   (FadFloat.( * ) (FadFloat.( * ) h7_438 
                                                   (FadFloat.pow alpha_378 
                                                                 2.)) 
                                   (FadFloat.pow beta_380  2.)) in
  let (i0_439:FadFloat.t) = FadFloat.make (-0.4126806) in
  let (i1_440:FadFloat.t) = FadFloat.make (-0.1189974) in
  let (i2_441:FadFloat.t) = FadFloat.make 1.247721 in
  let (i3_442:FadFloat.t) = FadFloat.make (-0.7391132) in
  let (clp_513:FadFloat.t) =
      FadFloat.(+) (FadFloat.(+) (FadFloat.(+) i0_439 
                                               (FadFloat.( * ) i1_440 
                                                               alpha_378)) 
                                 (FadFloat.( * ) i2_441 
                                                 (FadFloat.pow alpha_378  2.)))
                    (FadFloat.( * ) i3_442  (FadFloat.pow alpha_378  3.)) in
  let (j0_443:FadFloat.t) = FadFloat.make 0.06250437 in
  let (j1_444:FadFloat.t) = FadFloat.make 0.6067723 in
  let (j2_445:FadFloat.t) = FadFloat.make (-1.101964) in
  let (j3_446:FadFloat.t) = FadFloat.make 9.100087 in
  let (j4_447:FadFloat.t) = FadFloat.make (-11.92672) in
  let (clr_514:FadFloat.t) =
      FadFloat.(+) (FadFloat.(+) (FadFloat.(+) (FadFloat.(+) j0_443 
                                                             (FadFloat.( * ) 
                                                                j1_444 
                                                                alpha_378)) 
                                               (FadFloat.( * ) j2_445 
                                                               (FadFloat.pow 
                                                                  alpha_378 
                                                                  2.))) 
                                 (FadFloat.( * ) j3_446 
                                                 (FadFloat.pow alpha_378  3.)))
                    (FadFloat.( * ) j4_447  (FadFloat.pow alpha_378  4.)) in
  let (k0_448:FadFloat.t) = FadFloat.make (-0.1463144) in
  let (k1_449:FadFloat.t) = FadFloat.make (-0.0407391) in
  let (k2_450:FadFloat.t) = FadFloat.make 0.03253159 in
  let (k3_451:FadFloat.t) = FadFloat.make 0.4851209 in
  let (k4_452:FadFloat.t) = FadFloat.make 0.297885 in
  let (k5_453:FadFloat.t) = FadFloat.make (-0.3746393) in
  let (k6_454:FadFloat.t) = FadFloat.make (-0.3213068) in
  let (clda_511:FadFloat.t) =
      FadFloat.(+) (FadFloat.(+) (FadFloat.(+) (FadFloat.(+) (FadFloat.(+) 
                                                                (FadFloat.(+) 
                                                                   k0_448 
                                                                   (FadFloat.( * ) 
                                                                    k1_449 
                                                                    alpha_378))
                                                                
                                                                (FadFloat.( * ) 
                                                                   k2_450 
                                                                   beta_380))
                                                             
                                                             (FadFloat.( * ) 
                                                                k3_451 
                                                                (FadFloat.pow 
                                                                   alpha_378 
                                                                   2.))) 
                                               (FadFloat.( * ) (FadFloat.( * ) 
                                                                  k4_452 
                                                                  alpha_378) 
                                                               beta_380)) 
                                 (FadFloat.( * ) (FadFloat.( * ) k5_453 
                                                                 (FadFloat.pow 
                                                                    alpha_378
                                                                     
                                                                    2.)) 
                                                 beta_380)) 
                   (FadFloat.( * ) k6_454  (FadFloat.pow alpha_378  3.)) in
  let (l0_455:FadFloat.t) = FadFloat.make 0.02635729 in
  let (l1_456:FadFloat.t) = FadFloat.make (-0.0219291) in
  let (l2_457:FadFloat.t) = FadFloat.make (-0.003152901) in
  let (l3_458:FadFloat.t) = FadFloat.make (-0.05817803) in
  let (l4_459:FadFloat.t) = FadFloat.make 0.4516159 in
  let (l5_460:FadFloat.t) = FadFloat.make (-0.4928702) in
  let (l6_461:FadFloat.t) = FadFloat.make (-0.01579864) in
  let (cldr_512:FadFloat.t) =
      FadFloat.(+) (FadFloat.(+) (FadFloat.(+) (FadFloat.(+) (FadFloat.(+) 
                                                                (FadFloat.(+) 
                                                                   l0_455 
                                                                   (FadFloat.( * ) 
                                                                    l1_456 
                                                                    alpha_378))
                                                                
                                                                (FadFloat.( * ) 
                                                                   l2_457 
                                                                   beta_380))
                                                             
                                                             (FadFloat.( * ) 
                                                                (FadFloat.( * ) 
                                                                   l3_458 
                                                                   alpha_378)
                                                                 beta_380)) 
                                               (FadFloat.( * ) (FadFloat.( * ) 
                                                                  l4_459 
                                                                  (FadFloat.pow 
                                                                    alpha_378
                                                                     
                                                                    2.)) 
                                                               beta_380)) 
                                 (FadFloat.( * ) (FadFloat.( * ) l5_460 
                                                                 (FadFloat.pow 
                                                                    alpha_378
                                                                     
                                                                    3.)) 
                                                 beta_380)) 
                   (FadFloat.( * ) l6_461  (FadFloat.pow beta_380  2.)) in
  let (cl_391:FadFloat.t) =
      FadFloat.(+) (FadFloat.(+) (FadFloat.(+) (FadFloat.(+) cl0_510 
                                                             (FadFloat.( * ) 
                                                                clp_513 
                                                                phat_488)) 
                                               (FadFloat.( * ) clr_514 
                                                               rhat_503)) 
                                 (FadFloat.( * ) clda_511  da_382)) 
                   (FadFloat.( * ) cldr_512  dr_384) in
  let (m0_462:FadFloat.t) = FadFloat.make (-0.0202937) in
  let (m1_463:FadFloat.t) = FadFloat.make 0.04660702 in
  let (m2_464:FadFloat.t) = FadFloat.make (-0.6012308) in
  let (m3_465:FadFloat.t) = FadFloat.make (-0.08062977) in
  let (m4_466:FadFloat.t) = FadFloat.make 0.08320429 in
  let (m5_467:FadFloat.t) = FadFloat.make 0.5018538 in
  let (m6_468:FadFloat.t) = FadFloat.make 0.6378864 in
  let (m7_469:FadFloat.t) = FadFloat.make 0.4226356 in
  let (cm0_515:FadFloat.t) =
      FadFloat.(+) (FadFloat.(+) (FadFloat.(+) (FadFloat.(+) (FadFloat.(+) 
                                                                (FadFloat.(+) 
                                                                   (FadFloat.(+) 
                                                                    m0_462 
                                                                    (
                                                                    FadFloat.( * ) 
                                                                    m1_463 
                                                                    alpha_378))
                                                                   
                                                                   (FadFloat.( * ) 
                                                                    m2_464 
                                                                    de_383)) 
                                                                (FadFloat.( * ) 
                                                                   (FadFloat.( * ) 
                                                                    m3_465 
                                                                    alpha_378)
                                                                    de_383)) 
                                                             (FadFloat.( * ) 
                                                                m4_466 
                                                                (FadFloat.pow 
                                                                   de_383  2.)))
                                               
                                               (FadFloat.( * ) (FadFloat.( * ) 
                                                                  m5_467 
                                                                  (FadFloat.pow 
                                                                    alpha_378
                                                                     
                                                                    2.)) 
                                                               de_383)) 
                                 (FadFloat.( * ) m6_468 
                                                 (FadFloat.pow de_383  3.))) 
                   (FadFloat.( * ) (FadFloat.( * ) m7_469  alpha_378) 
                                   (FadFloat.pow de_383  2.)) in
  let (n0_470:FadFloat.t) = FadFloat.make (-5.19153) in
  let (n1_471:FadFloat.t) = FadFloat.make (-3.554716) in
  let (n2_472:FadFloat.t) = FadFloat.make (-35.98636) in
  let (n3_473:FadFloat.t) = FadFloat.make 224.7355 in
  let (n4_474:FadFloat.t) = FadFloat.make (-412.0991) in
  let (n5_475:FadFloat.t) = FadFloat.make 241.175 in
  let (cmq_523:FadFloat.t) =
      FadFloat.(+) (FadFloat.(+) (FadFloat.(+) (FadFloat.(+) (FadFloat.(+) 
                                                                n0_470 
                                                                (FadFloat.( * ) 
                                                                   n1_471 
                                                                   alpha_378))
                                                             
                                                             (FadFloat.( * ) 
                                                                n2_472 
                                                                (FadFloat.pow 
                                                                   alpha_378 
                                                                   2.))) 
                                               (FadFloat.( * ) n3_473 
                                                               (FadFloat.pow 
                                                                  alpha_378 
                                                                  3.))) 
                                 (FadFloat.( * ) n4_474 
                                                 (FadFloat.pow alpha_378  4.)))
                    (FadFloat.( * ) n5_475  (FadFloat.pow alpha_378  5.)) in
  let (f0_420:FadFloat.t) = FadFloat.make (-0.1378278) in
  let (f1_421:FadFloat.t) = FadFloat.make (-4.211369) in
  let (f2_422:FadFloat.t) = FadFloat.make 4.775187 in
  let (f3_423:FadFloat.t) = FadFloat.make (-10.26225) in
  let (f4_424:FadFloat.t) = FadFloat.make 8.399763 in
  let (f5_425:FadFloat.t) = FadFloat.make (-0.4354) in
  let (cz0_521:FadFloat.t) =
      FadFloat.(+) (FadFloat.( * ) (FadFloat.(+) (FadFloat.(+) (FadFloat.(+) 
                                                                  (FadFloat.(+) 
                                                                    f0_420 
                                                                    (
                                                                    FadFloat.( * ) 
                                                                    f1_421 
                                                                    alpha_378))
                                                                  
                                                                  (FadFloat.( * ) 
                                                                    f2_422 
                                                                    (
                                                                    FadFloat.pow 
                                                                    alpha_378
                                                                     
                                                                    2.))) 
                                                               (FadFloat.( * ) 
                                                                  f3_423 
                                                                  (FadFloat.pow 
                                                                    alpha_378
                                                                     
                                                                    3.))) 
                                                 (FadFloat.( * ) f4_424 
                                                                 (FadFloat.pow 
                                                                    alpha_378
                                                                     
                                                                    4.))) 
                                   (FadFloat.(-) (FadFloat.make 1.) 
                                                 (FadFloat.pow beta_380  2.)))
                    (FadFloat.( * ) f5_425  de_383) in
  let (g0_426:FadFloat.t) = FadFloat.make (-30.54956) in
  let (g1_427:FadFloat.t) = FadFloat.make (-41.32305) in
  let (g2_428:FadFloat.t) = FadFloat.make 329.2788 in
  let (g3_429:FadFloat.t) = FadFloat.make (-684.8038) in
  let (g4_430:FadFloat.t) = FadFloat.make 408.0244 in
  let (czq_522:FadFloat.t) =
      FadFloat.(+) (FadFloat.(+) (FadFloat.(+) (FadFloat.(+) g0_426 
                                                             (FadFloat.( * ) 
                                                                g1_427 
                                                                alpha_378)) 
                                               (FadFloat.( * ) g2_428 
                                                               (FadFloat.pow 
                                                                  alpha_378 
                                                                  2.))) 
                                 (FadFloat.( * ) g3_429 
                                                 (FadFloat.pow alpha_378  3.)))
                    (FadFloat.( * ) g4_430  (FadFloat.pow alpha_378  4.)) in
  let (cz_396:FadFloat.t) =
      FadFloat.(+) cz0_521  (FadFloat.( * ) czq_522  qhat_492) in
  let (cm_392:FadFloat.t) =
      FadFloat.(+) (FadFloat.(+) cm0_515  (FadFloat.( * ) cmq_523  qhat_492))
                   
                   (FadFloat.( * ) cz_396  (FadFloat.(-) xcgref_390  xcg_389)) in
  let (o0_476:FadFloat.t) = FadFloat.make 0.2993363 in
  let (o1_477:FadFloat.t) = FadFloat.make 0.06594004 in
  let (o2_478:FadFloat.t) = FadFloat.make (-0.2003125) in
  let (o3_479:FadFloat.t) = FadFloat.make (-0.06233977) in
  let (o4_480:FadFloat.t) = FadFloat.make (-2.107885) in
  let (o5_481:FadFloat.t) = FadFloat.make 2.14142 in
  let (o6_482:FadFloat.t) = FadFloat.make 0.8476901 in
  let (cn0_524:FadFloat.t) =
      FadFloat.(+) (FadFloat.(+) (FadFloat.(+) (FadFloat.(+) (FadFloat.(+) 
                                                                (FadFloat.(+) 
                                                                   (FadFloat.( * ) 
                                                                    o0_476 
                                                                    beta_380)
                                                                   
                                                                   (FadFloat.( * ) 
                                                                    (
                                                                    FadFloat.( * ) 
                                                                    o1_477 
                                                                    alpha_378)
                                                                     
                                                                    beta_380))
                                                                
                                                                (FadFloat.( * ) 
                                                                   o2_478 
                                                                   (FadFloat.pow 
                                                                    beta_380 
                                                                    2.))) 
                                                             (FadFloat.( * ) 
                                                                (FadFloat.( * ) 
                                                                   o3_479 
                                                                   alpha_378)
                                                                
                                                                (FadFloat.pow 
                                                                   beta_380 
                                                                   2.))) 
                                               (FadFloat.( * ) (FadFloat.( * ) 
                                                                  o4_480 
                                                                  (FadFloat.pow 
                                                                    alpha_378
                                                                     
                                                                    2.)) 
                                                               beta_380)) 
                                 (FadFloat.( * ) (FadFloat.( * ) o5_481 
                                                                 (FadFloat.pow 
                                                                    alpha_378
                                                                     
                                                                    2.)) 
                                                 (FadFloat.pow beta_380  2.)))
                   
                   (FadFloat.( * ) (FadFloat.( * ) o6_482 
                                                   (FadFloat.pow alpha_378 
                                                                 3.)) 
                                   beta_380) in
  let (p0_483:FadFloat.t) = FadFloat.make 0.02677652 in
  let (p1_484:FadFloat.t) = FadFloat.make (-0.3298246) in
  let (p2_485:FadFloat.t) = FadFloat.make 0.1926178 in
  let (p3_486:FadFloat.t) = FadFloat.make 4.013325 in
  let (p4_487:FadFloat.t) = FadFloat.make (-4.404302) in
  let (cnp_527:FadFloat.t) =
      FadFloat.(+) (FadFloat.(+) (FadFloat.(+) (FadFloat.(+) p0_483 
                                                             (FadFloat.( * ) 
                                                                p1_484 
                                                                alpha_378)) 
                                               (FadFloat.( * ) p2_485 
                                                               (FadFloat.pow 
                                                                  alpha_378 
                                                                  2.))) 
                                 (FadFloat.( * ) p3_486 
                                                 (FadFloat.pow alpha_378  3.)))
                    (FadFloat.( * ) p4_487  (FadFloat.pow alpha_378  4.)) in
  let (q0_489:FadFloat.t) = FadFloat.make (-0.3698756) in
  let (q1_490:FadFloat.t) = FadFloat.make (-0.1167551) in
  let (q2_491:FadFloat.t) = FadFloat.make (-0.7641297) in
  let (cnr_528:FadFloat.t) =
      FadFloat.(+) (FadFloat.(+) q0_489  (FadFloat.( * ) q1_490  alpha_378)) 
                   (FadFloat.( * ) q2_491  (FadFloat.pow alpha_378  2.)) in
  let (r0_493:FadFloat.t) = FadFloat.make (-0.03348717) in
  let (r1_494:FadFloat.t) = FadFloat.make 0.04276655 in
  let (r2_495:FadFloat.t) = FadFloat.make 0.006573646 in
  let (r3_496:FadFloat.t) = FadFloat.make 0.3535831 in
  let (r4_497:FadFloat.t) = FadFloat.make (-1.373308) in
  let (r5_498:FadFloat.t) = FadFloat.make 1.237582 in
  let (r6_499:FadFloat.t) = FadFloat.make 0.2302543 in
  let (r7_500:FadFloat.t) = FadFloat.make (-0.2512876) in
  let (r8_501:FadFloat.t) = FadFloat.make 0.1588105 in
  let (r9_502:FadFloat.t) = FadFloat.make (-0.5199526) in
  let (cnda_525:FadFloat.t) =
      FadFloat.(+) (FadFloat.(+) (FadFloat.(+) (FadFloat.(+) (FadFloat.(+) 
                                                                (FadFloat.(+) 
                                                                   (FadFloat.(+) 
                                                                    (
                                                                    FadFloat.(+) 
                                                                    (
                                                                    FadFloat.(+) 
                                                                    r0_493 
                                                                    (
                                                                    FadFloat.( * ) 
                                                                    r1_494 
                                                                    alpha_378))
                                                                    
                                                                    (
                                                                    FadFloat.( * ) 
                                                                    r2_495 
                                                                    beta_380))
                                                                    
                                                                    (
                                                                    FadFloat.( * ) 
                                                                    (
                                                                    FadFloat.( * ) 
                                                                    r3_496 
                                                                    alpha_378)
                                                                     
                                                                    beta_380))
                                                                   
                                                                   (FadFloat.( * ) 
                                                                    (
                                                                    FadFloat.( * ) 
                                                                    r4_497 
                                                                    (
                                                                    FadFloat.pow 
                                                                    alpha_378
                                                                     
                                                                    2.)) 
                                                                    beta_380))
                                                                
                                                                (FadFloat.( * ) 
                                                                   (FadFloat.( * ) 
                                                                    r5_498 
                                                                    (
                                                                    FadFloat.pow 
                                                                    alpha_378
                                                                     
                                                                    3.)) 
                                                                   beta_380))
                                                             
                                                             (FadFloat.( * ) 
                                                                r6_499 
                                                                (FadFloat.pow 
                                                                   alpha_378 
                                                                   2.))) 
                                               (FadFloat.( * ) r7_500 
                                                               (FadFloat.pow 
                                                                  alpha_378 
                                                                  3.))) 
                                 (FadFloat.( * ) r8_501 
                                                 (FadFloat.pow beta_380  3.)))
                   
                   (FadFloat.( * ) (FadFloat.( * ) r9_502  alpha_378) 
                                   (FadFloat.pow beta_380  3.)) in
  let (s0_504:FadFloat.t) = FadFloat.make (-0.08115894) in
  let (s1_505:FadFloat.t) = FadFloat.make (-0.0115658) in
  let (s2_506:FadFloat.t) = FadFloat.make 0.02514167 in
  let (s3_507:FadFloat.t) = FadFloat.make 0.2038748 in
  let (s4_508:FadFloat.t) = FadFloat.make (-0.3337476) in
  let (s5_509:FadFloat.t) = FadFloat.make 0.1004297 in
  let (cndr_526:FadFloat.t) =
      FadFloat.(+) (FadFloat.(+) (FadFloat.(+) (FadFloat.(+) (FadFloat.(+) 
                                                                s0_504 
                                                                (FadFloat.( * ) 
                                                                   s1_505 
                                                                   alpha_378))
                                                             
                                                             (FadFloat.( * ) 
                                                                s2_506 
                                                                beta_380)) 
                                               (FadFloat.( * ) (FadFloat.( * ) 
                                                                  s3_507 
                                                                  alpha_378) 
                                                               beta_380)) 
                                 (FadFloat.( * ) (FadFloat.( * ) s4_508 
                                                                 (FadFloat.pow 
                                                                    alpha_378
                                                                     
                                                                    2.)) 
                                                 beta_380)) 
                   (FadFloat.( * ) s5_509  (FadFloat.pow alpha_378  2.)) in
  let (c0_409:FadFloat.t) = FadFloat.make (-1.145916) in
  let (c1_410:FadFloat.t) = FadFloat.make 0.06016057 in
  let (c2_411:FadFloat.t) = FadFloat.make 0.1642479 in
  let (cy0_518:FadFloat.t) =
      FadFloat.(+) (FadFloat.(+) (FadFloat.( * ) c0_409  beta_380) 
                                 (FadFloat.( * ) c1_410  da_382)) 
                   (FadFloat.( * ) c2_411  dr_384) in
  let (d0_412:FadFloat.t) = FadFloat.make (-0.1006733) in
  let (d1_413:FadFloat.t) = FadFloat.make 0.8679799 in
  let (d2_414:FadFloat.t) = FadFloat.make 4.260586 in
  let (d3_415:FadFloat.t) = FadFloat.make (-6.923267) in
  let (cyp_519:FadFloat.t) =
      FadFloat.(+) (FadFloat.(+) (FadFloat.(+) d0_412 
                                               (FadFloat.( * ) d1_413 
                                                               alpha_378)) 
                                 (FadFloat.( * ) d2_414 
                                                 (FadFloat.pow alpha_378  2.)))
                    (FadFloat.( * ) d3_415  (FadFloat.pow alpha_378  3.)) in
  let (e0_416:FadFloat.t) = FadFloat.make 0.8071648 in
  let (e1_417:FadFloat.t) = FadFloat.make 0.1189633 in
  let (e2_418:FadFloat.t) = FadFloat.make 4.177702 in
  let (e3_419:FadFloat.t) = FadFloat.make (-9.162236) in
  let (cyr_520:FadFloat.t) =
      FadFloat.(+) (FadFloat.(+) (FadFloat.(+) e0_416 
                                               (FadFloat.( * ) e1_417 
                                                               alpha_378)) 
                                 (FadFloat.( * ) e2_418 
                                                 (FadFloat.pow alpha_378  2.)))
                    (FadFloat.( * ) e3_419  (FadFloat.pow alpha_378  3.)) in
  let (cy_395:FadFloat.t) =
      FadFloat.(+) (FadFloat.(+) cy0_518  (FadFloat.( * ) cyp_519  phat_488))
                    (FadFloat.( * ) cyr_520  rhat_503) in
  let (cn_393:FadFloat.t) =
      FadFloat.(-) (FadFloat.(+) (FadFloat.(+) (FadFloat.(+) (FadFloat.(+) 
                                                                cn0_524 
                                                                (FadFloat.( * ) 
                                                                   cnp_527 
                                                                   phat_488))
                                                             
                                                             (FadFloat.( * ) 
                                                                cnr_528 
                                                                rhat_503)) 
                                               (FadFloat.( * ) cnda_525 
                                                               da_382)) 
                                 (FadFloat.( * ) cndr_526  dr_384)) 
                   (FadFloat.( * ) (FadFloat.( * ) cy_395 
                                                   (FadFloat.(-) xcgref_390 
                                                                 xcg_389)) 
                                   (FadFloat.(/) cbar_381  b_379)) in
  (cx_394 , cy_395 , cz_396 , cl_391 , cm_392 , cn_393)

let stevensf16 ((alpha_530:FadFloat.t) ,
                (beta_531:FadFloat.t) ,
                (el_532:FadFloat.t) ,
                (ail_529:FadFloat.t) , (rdr_533:FadFloat.t)) =
  let (cxt_537:FadFloat.t) = F16_mlutils.cx (alpha_530 , el_532) in
  let (cyt_538:FadFloat.t) = F16_mlutils.cy (beta_531 , ail_529 , rdr_533) in
  let (czt_539:FadFloat.t) = F16_mlutils.cz (alpha_530 , beta_531 , el_532) in
  let (dail_540:FadFloat.t) = FadFloat.scale ail_529  ((/.) 1.  20.) in
  let (drdr_541:FadFloat.t) = FadFloat.scale rdr_533  ((/.) 1.  30.) in
  let (clt_534:FadFloat.t) =
      FadFloat.(+) (FadFloat.(+) (F16_mlutils.cl (alpha_530 , beta_531)) 
                                 (FadFloat.( * ) (F16_mlutils.dlda (alpha_530
                                                                    ,
                                                                    beta_531))
                                                  dail_540)) 
                   (FadFloat.( * ) (F16_mlutils.dldr (alpha_530 , beta_531)) 
                                   drdr_541) in
  let (cmt_535:FadFloat.t) = F16_mlutils.cm (alpha_530 , el_532) in
  let (cnt_536:FadFloat.t) =
      FadFloat.(+) (FadFloat.(+) (F16_mlutils.cn (alpha_530 , beta_531)) 
                                 (FadFloat.( * ) (F16_mlutils.dnda (alpha_530
                                                                    ,
                                                                    beta_531))
                                                  dail_540)) 
                   (FadFloat.( * ) (F16_mlutils.dndr (alpha_530 , beta_531)) 
                                   drdr_541) in
  (cxt_537 , cyt_538 , czt_539 , clt_534 , cmt_535 , cnt_536)

