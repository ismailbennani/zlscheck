open Matrix
open FadFloat

let get = Matrix.get

let ro = make 2.377e-3

let thrust_a = {
  dim = (6,6);
  content = Array.map (Array.map make)
    [|[|  1060.;  635.;   60.; -1020.; -2700.; -3600. |];
      [|   670.;  425.;   25.;  -170.; -1900.; -1400. |];
      [|   880.;  690.;  345.;  -300.; -1300.;  -595. |];
      [|  1140.; 1010.;  755.;   350.;  -247.;  -342. |];
      [|  1500.; 1330.; 1130.;   910.;   600.;  -200. |];
      [|  1860.; 1700.; 1525.;  1360.;  1100.;   700. |]|]
}

let thrust_b = {
  dim = (6,6);
  content = Array.map (Array.map make)
    [|[| 12680.; 12680.; 12610.; 12640.; 12390.; 11680. |];
      [|  9150.;  9150.;  9312.;  9839.; 10176.;  9848. |];
      [|  6200.;  6313.;  6610.;  7090.;  7750.;  8050. |];
      [|  3950.;  4040.;  4290.;  4660.;  5320.;  6100. |];
      [|  2450.;  2470.;  2600.;  2840.;  3250.;  3800. |];
      [|  1400.;  1400.;  1560.;  1660.;  1930.;  2310. |]|]
}

let thrust_c = {
  dim = (6,6);
  content = Array.map (Array.map make)
    [|[| 20000.; 21420.; 22700.; 24240.; 26070.; 28886. |];
      [| 15000.; 15700.; 16860.; 18910.; 21075.; 23319. |];
      [| 10800.; 11225.; 12250.; 13760.; 15975.; 18300. |];
      [|  7000.;  7323.;  8154.;  9285.; 11115.; 13484. |];
      [|  4000.;  4435.;  5000.;  5700.;  6860.;  8642. |];
      [|  2500.;  2600.;  2835.;  3215.;  3950.;  5057. |]|]
}

let dampp_a = {
  dim = (12,9);
  content = Array.map (Array.map make)
    [|[| -0.267;  0.882; -0.108; -8.80; -0.126; -0.360;  -7.21; -0.380;  0.061 |];
      [| -0.110;  0.852; -0.108; -25.8; -0.026; -0.359; -0.540; -0.363;  0.052 |];
      [|  0.308;  0.876; -0.188; -28.9;  0.063; -0.443;  -5.23; -0.378;  0.052 |];
      [|   1.34;  0.958;  0.110; -31.4;  0.113; -0.420;  -5.26; -0.386; -0.012 |];
      [|   2.08;  0.962;  0.258; -31.2;  0.208; -0.383;  -6.11; -0.370; -0.013 |];
      [|   2.91;  0.974;  0.226; -30.7;  0.230; -0.375;  -6.64; -0.453; -0.024 |];
      [|   2.76;  0.819;  0.344; -27.7;  0.319; -0.329;  -5.69; -0.550;  0.050 |];
      [|   2.05;  0.483;  0.362; -28.2;  0.437; -0.294;  -6.00; -0.582;  0.150 |];
      [|   1.50;  0.590;  0.611; -29.0;  0.680; -0.230;  -6.20; -0.595;  0.130 |];
      [|   1.49;   1.21;  0.529; -29.8;  0.100; -0.210;  -6.40; -0.637;  0.158 |];
      [|   1.83; -0.493;  0.298; -38.3;  0.447; -0.120;  -6.60;  -1.02;  0.240 |];
      [|   1.21;  -1.04;  -2.27; -35.3; -0.330; -0.100;  -6.00; -0.840;  0.150 |]|]
}

let cx_a = {
  dim = (12, 5);
  content = Array.map (Array.map make)
    [|[| -0.0990; -0.0480; -0.0220; -0.0400; -0.0830 |];
      [| -0.0810; -0.0380; -0.0200; -0.0380; -0.0730 |];
      [| -0.0810; -0.0400; -0.0210; -0.0390; -0.0760 |];
      [| -0.0630; -0.0210; -0.0040; -0.0250; -0.0720 |];
      [| -0.0250;  0.0160;  0.0320;  0.0060; -0.0460 |];
      [|  0.0440;  0.0830;  0.0940;  0.0620;  0.0120 |];
      [|  0.0970;  0.1270;  0.1280;  0.0870;  0.0240 |];
      [|  0.1130;  0.1370;  0.1300;  0.0850;  0.0250 |];
      [|  0.1450;  0.1620;  0.1540;  0.1000;  0.0430 |];
      [|  0.1670;  0.1770;  0.1610;  0.1100;  0.0530 |];
      [|  0.1740;  0.1790;  0.1550;  0.1040;  0.0470 |];
      [|  0.1660;  0.1670;  0.1380;  0.0910;  0.0400 |]|]
}

let cz_a = Array.map make
  [| 0.770;  0.241; -0.100; -0.415; -0.731; -1.053;
     -1.355; -1.646; -1.917; -2.120; -2.248; -2.229|]

let cl_a = {
  dim = (12,7);
  content = Array.map (Array.map make)
    [|[| 0.; -0.0010; -0.0030; -0.0010;      0.;  0.0070;  0.0090 |];
      [| 0.; -0.0040; -0.0090; -0.0100; -0.0100; -0.0100; -0.0110 |];
      [| 0.; -0.0080; -0.0170; -0.0200; -0.0220; -0.0230; -0.0230 |];
      [| 0.; -0.0120; -0.0240; -0.0300; -0.0340; -0.0340; -0.0370 |];
      [| 0.; -0.0160; -0.0300; -0.0390; -0.0470; -0.0490; -0.0500 |];
      [| 0.; -0.0220; -0.0410; -0.0540; -0.0600; -0.0630; -0.0680 |];
      [| 0.; -0.0220; -0.0450; -0.0570; -0.0690; -0.0810; -0.0890 |];
      [| 0.; -0.0210; -0.0400; -0.0540; -0.0670; -0.0790; -0.0880 |];
      [| 0.; -0.0150; -0.0160; -0.0230; -0.0330; -0.0600; -0.0910 |];
      [| 0.; -0.0080; -0.0020; -0.0060; -0.0360; -0.0580; -0.0760 |];
      [| 0.; -0.0130; -0.0100; -0.0140; -0.0350; -0.0620; -0.0770 |];
      [| 0.; -0.0150; -0.0190; -0.0270; -0.0350; -0.0590; -0.0760 |]|]
}

let cm_a = {
  dim = (12,7);
  content = Array.map (Array.map make)
    [|[| 0.2050; 0.0810; -0.0460; -0.1740; -0.2590 |];
      [| 0.1680; 0.0770; -0.0200; -0.1450; -0.2020 |];
      [| 0.1860; 0.1070; -0.0090; -0.1210; -0.1840 |];
      [| 0.1960; 0.1100; -0.0050; -0.1270; -0.1930 |];
      [| 0.2130; 0.1100; -0.0060; -0.1290; -0.1990 |];
      [| 0.2510; 0.1410;  0.0100; -0.1020; -0.1500 |];
      [| 0.2450; 0.1270;  0.0060; -0.0970; -0.1600 |];
      [| 0.2380; 0.1190; -0.0010; -0.1130; -0.1670 |];
      [| 0.2520; 0.1330;  0.0140; -0.0870; -0.1040 |];
      [| 0.2310; 0.1080;      0.; -0.0840; -0.0760 |];
      [| 0.1980; 0.0810; -0.0130; -0.0690; -0.0410 |];
      [| 0.1920; 0.0930;  0.0320; -0.0060; -0.0050 |]|]
}

let cn_a = {
  dim = (12, 7);
  content = Array.map (Array.map make)
    [|[| 0.;  0.0180;  0.0380;  0.0560;  0.0640;  0.0740;  0.0790 |];
      [| 0.;  0.0190;  0.0420;  0.0570;  0.0770;  0.0860;  0.0900 |];
      [| 0.;  0.0180;  0.0420;  0.0590;  0.0760;  0.0930;  0.1060 |];
      [| 0.;  0.0190;  0.0420;  0.0580;  0.0740;  0.0890;  0.1060 |];
      [| 0.;  0.0190;  0.0430;  0.0580;  0.0730;  0.0800;  0.0960 |];
      [| 0.;  0.0180;  0.0390;  0.0530;  0.0570;  0.0620;  0.0800 |];
      [| 0.;  0.0130;  0.0300;  0.0320;  0.0290;  0.0490;  0.0680 |];
      [| 0.;  0.0070;  0.0170;  0.0120;  0.0070;  0.0220;  0.0300 |];
      [| 0.;  0.0040;  0.0040;  0.0020;  0.0120;  0.0280;  0.0640 |];
      [| 0.; -0.0140; -0.0350; -0.0460; -0.0340; -0.0120;  0.0150 |];
      [| 0.; -0.0170; -0.0470; -0.0710; -0.0650; -0.0020;  0.0110 |];
      [| 0.; -0.0330; -0.0570; -0.0730; -0.0410; -0.0130; -0.0010 |]|]
}

let dlda_a = {
  dim = (12, 7);
  content = Array.map (Array.map make)
    [|[| -0.0410; -0.0410; -0.0420; -0.0400; -0.0430; -0.0440; -0.0430 |];
      [| -0.0520; -0.0530; -0.0530; -0.0520; -0.0490; -0.0480; -0.0490 |];
      [| -0.0530; -0.0530; -0.0520; -0.0510; -0.0480; -0.0480; -0.0470 |];
      [| -0.0560; -0.0530; -0.0510; -0.0520; -0.0490; -0.0470; -0.0450 |];
      [| -0.0500; -0.0500; -0.0490; -0.0480; -0.0430; -0.0420; -0.0420 |];
      [| -0.0560; -0.0510; -0.0490; -0.0480; -0.0420; -0.0410; -0.0370 |];
      [| -0.0820; -0.0660; -0.0430; -0.0420; -0.0420; -0.0200; -0.0030 |];
      [| -0.0590; -0.0430; -0.0350; -0.0370; -0.0360; -0.0280; -0.0130 |];
      [| -0.0420; -0.0380; -0.0260; -0.0310; -0.0250; -0.0130; -0.0100 |];
      [| -0.0380; -0.0270; -0.0160; -0.0260; -0.0210; -0.0140; -0.0030 |];
      [| -0.0270; -0.0230; -0.0180; -0.0170; -0.0160; -0.0110; -0.0070 |];
      [| -0.0170; -0.0160; -0.0140; -0.0120; -0.0110; -0.0100; -0.0080 |]|]
}

let dldr_a = {
  dim = (12, 7);
  content = Array.map (Array.map make)
    [|[|  0.0050;  0.0070;  0.0130;  0.0180;  0.0150;  0.0210;  0.0230 |];
      [|  0.0170;  0.0160;  0.0130;  0.0150;  0.0140;  0.0110;  0.0100 |];
      [|  0.0140;  0.0140;  0.0110;  0.0150;  0.0130;  0.0100;  0.0110 |];
      [|  0.0100;  0.0140;  0.0120;  0.0140;  0.0130;  0.0110;  0.0110 |];
      [| -0.0050;  0.0130;  0.0110;  0.0140;  0.0120;  0.0100;  0.0110 |];
      [|  0.0090;  0.0090;  0.0090;  0.0140;  0.0110;  0.0090;  0.0100 |];
      [|  0.0190;  0.0120;  0.0080;  0.0140;  0.0110;  0.0080;  0.0080 |];
      [|  0.0050;  0.0050;  0.0050;  0.0150;  0.0100;  0.0100;  0.0100 |];
      [|      0.;      0.; -0.0020;  0.0130;  0.0080;  0.0060;  0.0060 |];
      [| -0.0050;  0.0040;  0.0050;  0.0110;  0.0080;  0.0050;  0.0140 |];
      [| -0.0110;  0.0090;  0.0030;  0.0060;  0.0070;      0.;  0.0200 |];
      [|  0.0080;  0.0070;  0.0050;  0.0010;  0.0030;  0.0010;      0. |]|]
}

let dnda_a = {
  dim = (12, 7);
  content = Array.map (Array.map make)
    [|[| 0.0010;   0.0020; -0.0060; -0.0110; -0.0150; -0.0240; -0.0220; |];
      [| -0.0270; -0.0140; -0.0080; -0.0110; -0.0150; -0.0100;  0.0020; |];
      [| -0.0170; -0.0160; -0.0060; -0.0100; -0.0140; -0.0040; -0.0030; |];
      [| -0.0130; -0.0160; -0.0060; -0.0090; -0.0120; -0.0020; -0.0050; |];
      [| -0.0120; -0.0140; -0.0050; -0.0080; -0.0110; -0.0010; -0.0030; |];
      [| -0.0160; -0.0190; -0.0080; -0.0060; -0.0080;  0.0030; -0.0010; |];
      [|  0.0010; -0.0210; -0.0050;      0.; -0.0020;  0.0140; -0.0090; |];
      [|  0.0170;  0.0020;  0.0070;  0.0040;  0.0020;  0.0060; -0.0090; |];
      [|  0.0110;  0.0120;  0.0040;  0.0070;  0.0060; -0.0010; -0.0010; |];
      [|  0.0170;  0.0160;  0.0070;  0.0100;  0.0120;  0.0040;  0.0030; |];
      [|  0.0080;  0.0150;  0.0060;  0.0040;  0.0110;  0.0040; -0.0020; |];
      [|  0.0160;  0.0110;  0.0060;  0.0100;  0.0110;  0.0060;  0.0010; |]|]
}

let dndr_a = {
  dim = (12, 7);
  content = Array.map (Array.map make)
    [|[| -0.0180; -0.0280; -0.0370; -0.0480; -0.0430; -0.0520; -0.0620 |];
      [| -0.0520; -0.0510; -0.0410; -0.0450; -0.0440; -0.0340; -0.0340 |];
      [| -0.0520; -0.0430; -0.0380; -0.0450; -0.0410; -0.0360; -0.0270 |];
      [| -0.0520; -0.0460; -0.0400; -0.0450; -0.0410; -0.0360; -0.0280 |];
      [| -0.0540; -0.0450; -0.0400; -0.0440; -0.0400; -0.0350; -0.0270 |];
      [| -0.0490; -0.0490; -0.0380; -0.0450; -0.0380; -0.0280; -0.0270 |];
      [| -0.0590; -0.0570; -0.0370; -0.0470; -0.0340; -0.0240; -0.0230 |];
      [| -0.0510; -0.0520; -0.0300; -0.0480; -0.0350; -0.0230; -0.0230 |];
      [| -0.0300; -0.0300; -0.0270; -0.0490; -0.0350; -0.0200; -0.0190 |];
      [| -0.0370; -0.0330; -0.0240; -0.0450; -0.0290; -0.0160; -0.0090 |];
      [| -0.0260; -0.0300; -0.0190; -0.0330; -0.0220; -0.0100; -0.0250 |];
      [| -0.0130; -0.0080; -0.0130; -0.0160; -0.0090; -0.0140; -0.0100 |]|]
}

let round f =
  let frac, i = modf f in
  if Stdlib.(frac >= 0.5) then make (i +. 1.)
  else make i

let adc(vt, alt) =
  (* converts velocity (vt) and altitude (alt) to mach number (amach)
     and dynamic pressure (qbar)
     See pages 63-65 of Stevens & Lewis, "Aircraft Control and Simulation",
     2nd edition *)

  (* vt = freestream air speed *)

  let tfac = translate (-(scale alt 0.703e-5)) 1. in
  let t =
    if alt >= make 35000. then make 390. (* in stratosphere *)
    else scale tfac 519. (* 3 rankine per atmosphere (3 rankine per 1000 ft) *)
  in

  (* rho = freestream mass density *)
  let rho = ro * (pow tfac 4.14) in

  (* a = speed of sound at the ambient conditions *)
  (* speed of sound in a fluid is the sqrt of the quotient of the modulus
     of elasticity over the mass density *)
  let a = sqrt (scale t (1.4 *. 1716.3)) in

  (* amach = mach number *)
  vt / a,
  (* qbar = dynamic pressure *)
  scale (rho * vt * vt) 0.5

let tgear(thtl) =
  if thtl <= make 0.77 then scale thtl 64.94 else translate (scale thtl 217.38) (-117.38)

let thrust(power, alt, rmach) =
  let rmach = max rmach (make 0.) in

  (* thrust lookup-table *)
  let alt = max (make 0.01) alt in (* uh, why not 0? *)
  let h = scale alt 0.0001 in
  let rm = scale rmach 5. in
  let tmil = Matrix.lut2d thrust_b h rm in

  if power < make 50. then
    let tidl = Matrix.lut2d thrust_a h rm in
    tidl + (tmil - tidl) * (scale power 0.02)
  else
    let tmax = Matrix.lut2d thrust_c h rm in
    tmil + (tmax - tmil) * (scale (translate power (-50.)) 0.02)

let dampp_aux (da, k, l, i) =
  (get dampp_a Stdlib.(k-1) i) +
  (abs da) * ((get dampp_a Stdlib.(l-1) i) - (get dampp_a Stdlib.(k-1) i))

let dampp(alpha) =
  (* alpha in degrees *)
  let s = translate (scale alpha 0.2) 2. in
  let d0 = Matrix.lut1d_row dampp_a s 0 alpha
  and d1 = Matrix.lut1d_row dampp_a s 1 alpha
  and d2 = Matrix.lut1d_row dampp_a s 2 alpha
  and d3 = Matrix.lut1d_row dampp_a s 3 alpha
  and d4 = Matrix.lut1d_row dampp_a s 4 alpha
  and d5 = Matrix.lut1d_row dampp_a s 5 alpha
  and d6 = Matrix.lut1d_row dampp_a s 6 alpha
  and d7 = Matrix.lut1d_row dampp_a s 7 alpha
  and d8 = Matrix.lut1d_row dampp_a s 8 alpha in
  d0, d1, d2, d3, d4, d5, d6, d7, d8

let c c_a (a, b) (min_k, max_k) (min_m, max_m) add_m force_sgn =
  let s = a in
  let k = truncate s in
  let k = Stdlib.max min_k k in
  let k = Stdlib.min max_k k in
  let da = s - (FadFloat.integer k) in
  let l = Stdlib.(k + (truncate (copysign 1.1 (FadFloat.get da)))) in
  let s = b in
  let m = truncate s in
  let m = Stdlib.max min_m m in
  let m = Stdlib.min max_m m in
  let db = s - (FadFloat.integer m) in
  let n = Stdlib.(m + (truncate (copysign 1.1 (FadFloat.get db)))) in
  let l = Stdlib.(l + 3) in
  let k = Stdlib.(k + 3) in
  let m = Stdlib.(m + add_m) in
  let n = Stdlib.(n + add_m) in
  let t = get c_a Stdlib.(k-1) Stdlib.(m-1) in
  let u = get c_a Stdlib.(k-1) Stdlib.(n-1) in
  let v = t + (abs da) * (get c_a Stdlib.(l-1) Stdlib.(m-1) - t) in
  let w = u + (abs da) * (get c_a Stdlib.(l-1) Stdlib.(n-1) - u) in
  let dum = v + (w - v) * (abs db) in
  let sgn = if Stdlib.(force_sgn <> 0.) then Stdlib.copysign 1. force_sgn else 1. in
  scale dum sgn

let cx (alpha, el) =
  c cx_a (scale alpha 0.2, scale el (1. /. 12.)) (-1, 8) (-1, 1) 3 0.

let cy (beta, ail, rdr) =
  (scale beta (-0.02)) + (scale ail (0.021 /. 20.)) + (scale rdr (0.086 /. 30.))

let cz (alpha, beta, el) =
  let s = scale alpha 0.2 in
  let k = truncate s in
  let k = Stdlib.max (-1) k in
  let k = Stdlib.min 8 k in
  let da = s - (integer k) in
  let l = Stdlib.(k + (truncate (copysign 1.1 (FadFloat.get da)))) in
  let l = Stdlib.(l + 3) in
  let k = Stdlib.(k + 3) in
  let s = cz_a.(Stdlib.(k-1)) + (abs da) * (cz_a.(Stdlib.(l-1)) - cz_a.(Stdlib.(k-1))) in
  s * ((make 1.) - (pow (scale beta (1. /. 57.3))) 2.) - (scale el (0.19 /. 25.))

let cl (alpha, beta) =
  c cl_a (scale alpha 0.2, scale (abs beta) 0.2) (-1, 8) (1, 5) 1 (FadFloat.get beta)

let cm (alpha, el) =
  c cm_a (scale alpha 0.2, scale el (1. /. 12.)) (-1, 8) (-1, 1) 3 0.

let cn (alpha, beta) =
  c cn_a (scale alpha 0.2, scale (abs beta) 0.2) (-1, 8) (1, 5) 1 (FadFloat.get beta)

let dlda (alpha, beta) =
  c dlda_a (scale alpha 0.2, scale beta 0.1) (-1, 8) (-2, 2) 4 0.

let dldr (alpha, beta) =
  c dldr_a (scale alpha 0.2, scale beta 0.1) (-1, 8) (-2, 2) 4 0.

let dnda (alpha, beta) =
  c dnda_a (scale alpha 0.2, scale beta 0.1) (-1, 8) (-2, 2) 4 0.

let dndr (alpha, beta) =
  c dndr_a (scale alpha 0.2, scale beta 0.1) (-1, 8) (-2, 2) 4 0.

let rtau(dp) =
  if dp <= make 25. then make 1.
  else if dp >= make 50. then make 0.1
  else translate  (- (scale dp 0.036)) 1.9

let exit = exit

(* let test_fn name fn range_a range_b =
  let pick_float (low, high) =
    Random.float (high - low) + low
  in
  let n = 10 in
  let inp = List.init n (fun _ -> (pick_float range_a, pick_float range_b)) in
  let fn_ = List.map fn inp in
  Printf.printf "[%s]\n[%s]\n"
    (String.concat " "
       (List.map (fun (a, b) -> Printf.sprintf "%s(%f,%f)" name a b) inp))
    (String.concat " " (List.map string_of_float fn_))

let test_fn_ name fn range_a range_b range_c =
  let pick_float (low, high) =
    Random.float (high - low) + low
  in
  let n = 10 in
  let inp = List.init n (fun _ -> (pick_float range_a, pick_float range_b, pick_float range_c)) in
  let fn_ = List.map fn inp in
  Printf.printf "[%s]\n[%s]\n"
    (String.concat " "
       (List.map (fun (a, b, c) -> Printf.sprintf "%s(%f,%f,%f)" name a b c) inp))
    (String.concat " " (List.map string_of_float fn_))

let _ =
  Random.self_init ();
  test_fn "cx" cx (0.,100.) (-25.,25.);
  print_newline ();
  test_fn_ "cy" cy (0.,100.) (-10.,10.) (-10., 10.);
  print_newline ();
  test_fn_ "cz" cz (0.,100.) (-10.,10.) (-10., 10.);
  print_newline ();
  test_fn "cl" cl (0.,100.) (-10.,10.);
  print_newline ();
  test_fn "cn" cn (0.,100.) (-10.,10.);
  print_newline ();
  test_fn "cm" cm (0.,100.) (-10.,10.);
  print_newline ();
  test_fn "dlda" dlda (0.,100.) (-10.,10.);
  print_newline ();
  test_fn "dnda" dnda (0.,100.) (-10.,10.);
  print_newline ();
  test_fn "dldr" dldr (0.,100.) (-10.,10.);
  print_newline ();
  test_fn "dndr" dndr (0.,100.) (-10.,10.);
  print_newline (); *)
