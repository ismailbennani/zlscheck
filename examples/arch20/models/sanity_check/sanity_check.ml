(* The Zélus compiler, version 2.1
  (mer. 06 mai 2020 13:31:20 CEST) *)
open Ztypes
type _model = unit

let model  = 
   let model_alloc _ = () in
  let model_reset self  =
    ((()):unit) in 
  let model_step self (inp_5:('a37)Array.t) =
    (Array.get inp_5  0:'a) in
  Node { alloc = model_alloc; reset = model_reset ; step = model_step }
