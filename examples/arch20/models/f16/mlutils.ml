open Matrix

let ro = 2.377e-3

let thrust_a = {
  dim = (6,6);
  content =
  [|[|  1060.;  635.;   60.; -1020.; -2700.; -3600. |];
    [|   670.;  425.;   25.;  -170.; -1900.; -1400. |];
    [|   880.;  690.;  345.;  -300.; -1300.;  -595. |];
    [|  1140.; 1010.;  755.;   350.;  -247.;  -342. |];
    [|  1500.; 1330.; 1130.;   910.;   600.;  -200. |];
    [|  1860.; 1700.; 1525.;  1360.;  1100.;   700. |]|]
  }

let thrust_b = {
  dim = (6,6);
  content =
  [|[| 12680.; 12680.; 12610.; 12640.; 12390.; 11680. |];
    [|  9150.;  9150.;  9312.;  9839.; 10176.;  9848. |];
    [|  6200.;  6313.;  6610.;  7090.;  7750.;  8050. |];
    [|  3950.;  4040.;  4290.;  4660.;  5320.;  6100. |];
    [|  2450.;  2470.;  2600.;  2840.;  3250.;  3800. |];
    [|  1400.;  1400.;  1560.;  1660.;  1930.;  2310. |]|]
  }

let thrust_c = {
  dim = (6,6);
  content =
  [|[| 20000.; 21420.; 22700.; 24240.; 26070.; 28886. |];
    [| 15000.; 15700.; 16860.; 18910.; 21075.; 23319. |];
    [| 10800.; 11225.; 12250.; 13760.; 15975.; 18300. |];
    [|  7000.;  7323.;  8154.;  9285.; 11115.; 13484. |];
    [|  4000.;  4435.;  5000.;  5700.;  6860.;  8642. |];
    [|  2500.;  2600.;  2835.;  3215.;  3950.;  5057. |]|]
  }

let dampp_a = {
  dim = (12,9);
  content =
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

let round f =
  let frac, i = modf f in if frac >= 0.5 then i +. 1. else i

let adc(vt, alt) =
    (* converts velocity (vt) and altitude (alt) to mach number (amach)
       and dynamic pressure (qbar)
       See pages 63-65 of Stevens & Lewis, "Aircraft Control and Simulation",
       2nd edition *)

    (* vt = freestream air speed *)

    let tfac = 1. -. 0.703e-5 *. alt in
    let t =
        if alt >= 35000. then 390. (* in stratosphere *)
        else 519. *. tfac (* 3 rankine per atmosphere (3 rankine per 1000 ft) *)
    in

    (* rho = freestream mass density *)
    let rho = ro *. (tfac ** 4.14) in

    (* a = speed of sound at the ambient conditions *)
    (* speed of sound in a fluid is the sqrt of the quotient of the modulus
       of elasticity over the mass density *)
    let a = sqrt (1.4 *. 1716.3 *. t) in

    (* amach = mach number *)
    vt /. a,
    (* qbar = dynamic pressure *)
    0.5 *. rho *. vt *. vt

let tgear(thtl) =
  if thtl <= 0.77 then 64.94 *. thtl else 217.38 *. thtl -. 117.38

let thrust(power, alt, rmach) =
  let rmach = max rmach 0. in

  (* thrust lookup-table *)
  let alt = max 0.01 alt in (* uh, why not 0? *)
  let h = 0.0001 *. alt in
  let rm = 5. *. rmach in
  let tmil = Matrix.lut2d thrust_b h rm in

  if power < 50. then
      let tidl = Matrix.lut2d thrust_a h rm in
      tidl +. (tmil -. tidl) *. power *. 0.02
  else
      let tmax = Matrix.lut2d thrust_c h rm in
      tmil +. (tmax -. tmil) *. (power -. 50.) *. 0.02

let dampp_aux (da, k, l, i) =
  (get dampp_a (k-1) i) +.
  (abs_float da) *. ((get dampp_a (l-1) i) -. (get dampp_a (k-1) i))

let dampp(alpha) =
  (* alpha in degrees *)
  let s = 0.2 *. alpha +. 2. in
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

let rtau(dp) =
    if dp <= 25. then 1.
    else if dp >= 50. then 0.1
    else 1.9 -. 0.036 *. dp

let exit = exit
