(* cf. zlscheck/src/core/autodiff/extended_FAD_float.ml *)
include Extended_FAD_float

let copysign a b =
  if a * b >= make 0. then a
  else - a

let abs a = max a (-a)

let pow t f = t ** (make f)

let mod_t t1 t2 =
  t1 - (make (Stdlib.floor ((get t1) /. (get t2)))) * t2

(* to match diff.orderedfs signature *)
let length t = 0
