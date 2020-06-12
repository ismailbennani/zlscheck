include Extended_FAD_float

let copysign a b =
  if a * b >= make 0. then a
  else - a

let abs a = max a (-a)

let pow t f = t ** (make f)
