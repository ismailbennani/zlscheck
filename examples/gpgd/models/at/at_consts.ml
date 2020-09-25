open MyOp

(* lookup tables *)

let col_engine = (* RPM *)
  Array.map make
  [| 800.; 1200.; 1600.; 2000.; 2400.; 2800.; 3200.; 3600.; 4000.; 4400.; 4800. |]
let line_engine = (* Throttle *)
  Array.map make [| 0.; 20.; 30.; 40.; 50.; 60.; 70.; 80.; 90.; 100. |]
let vals_engine = (* 2D Lookup table *)
  Array.map (Array.map make)
  [| [| -40.; -44.; -49.; -53.; -57.; -61.; -65.; -70.; -74.; -78.; -82. |];
     [| 215.; 117.;  85.;  66.;  44.;  29.;  10.;  -2.; -13.; -22.; -32. |];
     [| 245.; 208.; 178.; 148.; 122.; 104.;  85.;  66.;  48.;  33.;  18. |];
     [| 264.; 260.; 241.; 219.; 193.; 167.; 152.; 133.; 119.;  96.;  85. |];
     [| 264.; 279.; 282.; 275.; 260.; 238.; 223.; 208.; 189.; 171.; 152. |];
     [| 267.; 290.; 293.; 297.; 290.; 275.; 260.; 256.; 234.; 212.; 193. |];
     [| 267.; 297.; 305.; 305.; 305.; 301.; 293.; 282.; 267.; 249.; 226. |];
     [| 267.; 301.; 308.; 312.; 319.; 323.; 319.; 316.; 297.; 279.; 253. |];
     [| 267.; 301.; 312.; 319.; 327.; 327.; 327.; 327.; 312.; 293.; 267. |];
     [| 267.; 301.; 312.; 319.; 327.; 334.; 334.; 334.; 319.; 305.; 275. |] |]

let col_interpup = (* gear *)
  Array.map make [| 1.; 2.; 3.; 4.|]
let line_interpup = (* throttle *)
  Array.map make [| 0.; 25.; 35.; 50.; 90.; 100. |]
let vals_interpup = (* 2D Lookup table *)
  Array.map (Array.map make)
  [| [| 10.; 30.;  50.; 1000000. |];
     [| 10.; 30.;  50.; 1000000. |];
     [| 15.; 30.;  50.; 1000000. |];
     [| 23.; 41.;  60.; 1000000. |];
     [| 40.; 70.; 100.; 1000000. |];
     [| 40.; 70.; 100.; 1000000. |] |]

let col_interpdn = (* gear *)
  Array.map make [| 1.; 2.; 3.; 4.|]
let line_interpdn = (* throttle *)
  Array.map make [| 0.; 5.; 40.; 50.; 90.; 100. |]
let vals_interpdn = (* 2D Lookup table *)
  Array.map (Array.map make)
  [| [| 0.;  5.; 20.; 35. |];
     [| 0.;  5.; 20.; 35. |];
     [| 0.;  5.; 25.; 40. |];
     [| 0.;  5.; 30.; 50. |];
     [| 0.; 30.; 50.; 80. |];
     [| 0.; 30.; 50.; 80. |] |]

let line_factork = (* speed ratio *)
  Array.map make
  [| 0.; 0.1 ; 0.2 ; 0.3 ; 0.4 ; 0.5 ; 0.6 ; 0.7 ; 0.8; 0.81; 0.82;
         0.83; 0.84; 0.85; 0.86; 0.87; 0.88; 0.89; 0.9; 0.92; 0.94 |]
let vals_factork = (* 1D Lookup table *)
  Array.map make
  [| 137.4652089938063; 137.06501915685197; 135.86444964598905;
     135.6643547275119; 137.56525645304487; 140.3665853117251;
     145.2689108144154; 152.87251771654735; 162.97731109964374;
     164.2779280697452; 166.17882979527823; 167.97968406157264;
     170.08068070558275; 172.78196210502438; 175.3831960452274;
     179.58518933324765; 183.58708770279083; 189.8900776348212;
     197.69377945543027; 215.90241703685155; 244.51599037908485; |]

let line_torkratio = (* speed ratio *)
  Array.map make
  [| 0.; 0.1 ; 0.2 ; 0.3 ; 0.4 ; 0.5 ; 0.6 ; 0.7 ; 0.8; 0.81; 0.82;
         0.83; 0.84; 0.85; 0.86; 0.87; 0.88; 0.89; 0.9; 0.92; 0.94 |]
let vals_torkratio = (* 1D Lookup table *)
  Array.map make
  [| 2.2319999999999998; 2.075; 1.975; 1.8459999999999999; 1.72; 1.564; 1.409;
     1.254; 1.0959999999999999; 1.08; 1.061; 1.043; 1.028; 1.012; 1.002; 1.002;
     1.001; 0.998; 0.9990000000000001; 1.001; 1.002 |]

let line_gear = Array.map make [| 1.; 2.; 3.; 4. |] (* gear *)
let vals_gear = Array.map make [| 2.393; 1.450; 1.000; 0.677 |] (* 1D Lookup table *)