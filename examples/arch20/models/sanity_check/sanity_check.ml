(* The Zélus compiler, version 2.0
  (lundi 25 mai 2020, 14:33:03 (UTC+0200)) *)
open Ztypes
type _model = unit

let model  = 
   let model_alloc _ = () in
  let model_reset self  =
    ((()):unit) in 
  let model_step self (inp_5:('a37)Array.t) =
    (Array.get inp_5  0:'a) in
  Node { alloc = model_alloc; reset = model_reset ; step = model_step }
