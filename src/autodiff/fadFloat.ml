(* FAD operators *)

include (Fadbad.OrderedF(Fadbad.OrderedFloat) : module type of Fadbad.OrderedF(Fadbad.OrderedFloat) with type elt := float)

let infinity = make infinity
let neg_infinity = make neg_infinity
let nan = make nan
let max_val = make max_float
let min_val = make min_float
let epsilon = make epsilon_float

let classify v = classify_float !!v

let of_string s = make (float_of_string s)

let print v = print_string (to_string v)
let fprintf ff v = Printf.fprintf ff "%s" (to_string v)
let prerr v = prerr_string (to_string v)
let read () = make (read_float ())

let modf v = modf !!v

(* let log10 v =
  let res = make (log10 !!v) in
  if depend v then begin
    setDepend res v;
    Array.iteri (fun i _ -> res.m_diff.(i) <- ref ((log10 (Stdlib.exp 1.)) *. !(v.m_diff.(i)) /. !(v.m_val)))
      res.m_diff;
  end;
  res *)

let atan2 v = failwith "not implemented"
let cosh v = failwith "not implemented"
let sinh v = failwith "not implemented"
let tanh v = failwith "not implemented"

let ceil v = let res = make (ceil !!v) in res
let floor v = let res = make (floor !!v) in res
let truncate v = truncate !!v

let frexp v = frexp !!v
let ldexp v i = make (ldexp v i)

(* let abs v =
  let f = abs_float !!v in
  let res = make f in
  if depend v then begin
    setDepend res v;
    Array.iteri (fun i _ -> res.m_diff.(i) <- ref (if Stdlib.(f >= 0.) then 1. else -1.))
      res.m_diff;
  end;
   res *)

let copysign a b =
  if a * b >= make 0. then a
  else - a

let abs a = max a (-a)

let pow t f = t ** (make f)

let mod_t t1 t2 =
  t1 - (make (Stdlib.floor ((get t1) /. (get t2)))) * t2
