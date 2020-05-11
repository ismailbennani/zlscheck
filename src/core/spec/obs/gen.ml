(* The Zélus compiler, version 2.1
  (mer. 06 mai 2020 13:31:20 CEST) *)
open Ztypes
let pick_float ((i1_76:float) , (i2_77:float)) =
  (+.) (Random.float ((-.) i2_77  i1_76))  i1_76

type ('b , 'a) _flat =
  { mutable i_80 : 'b ; mutable res_79 : 'a }

let flat  = 
  
  let flat_alloc _ =
    ();{ i_80 = (false:bool) ; res_79 = (Obj.magic ():'a) } in
  let flat_reset self  =
    (self.i_80 <- true:unit) in 
  let flat_step self (_ , (prev_78:'a1376)) =
    (((if self.i_80 then self.res_79 <- prev_78) ;
      self.i_80 <- false ; self.res_79):'a) in
  Node { alloc = flat_alloc; reset = flat_reset ; step = flat_step }
