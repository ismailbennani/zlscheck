(* The Zélus compiler, version 2.0
  (jeudi 4 juin 2020, 17:57:12 (UTC+0200)) *)
open Ztypes
open MyOp
let pi = 3.1416

let twopi = ( *. ) 2.  pi

let pi_t = MyOp.make pi

let twopi_t = MyOp.scale pi_t  2.

type ('b , 'a) _integrate =
  { mutable i_33 : 'b ; mutable m_31 : 'a }

let integrate  = 
  
  let integrate_alloc _ =
    ();{ i_33 = (false:bool) ; m_31 = (Obj.magic ():MyOp.t) } in
  let integrate_reset self  =
    (self.i_33 <- true:unit) in 
  let integrate_step self ((tstep_27:MyOp.t) , (x_28:MyOp.t) , (y0_29:MyOp.t)) =
    (((if self.i_33 then self.m_31 <- y0_29) ;
      self.i_33 <- false ;
      (let (x_32:MyOp.t) = self.m_31 in
       self.m_31 <- MyOp.(+) (MyOp.( * ) x_28  tstep_27)  x_32 ; x_32)):
    MyOp.t) in
  Node { alloc = integrate_alloc; reset = integrate_reset ;
                                  step = integrate_step }
let radPs2rpm (u_34:MyOp.t) =
  MyOp.scale u_34  ((/.) 60.  twopi)

let rpm2radPs (u_35:MyOp.t) =
  MyOp.scale u_35  ((/.) twopi  60.)

let rad2deg (u_36:MyOp.t) =
  MyOp.scale u_36  ((/.) 180.  pi)

let deg2rad (u_37:MyOp.t) =
  MyOp.scale u_37  ((/.) pi  180.)

let interp1 ((x_arr_40:(MyOp.t)Array.t) ,
             (v_arr_38:(MyOp.t)Array.t) , (x_39:MyOp.t)) =
  Wt_interp.interp1 (x_arr_40 , v_arr_38)  x_39

