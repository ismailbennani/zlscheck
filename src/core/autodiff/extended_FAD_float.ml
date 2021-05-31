module Float = 
struct
  type t = float ref

  type elt = float
  type scalar = float

  let create () = ref 7895.

  let make x = ref x
  let get f = !f
  let ( !! ) = get

  let integer i = ref (float i)

  let to_string x = string_of_float !x
  let string_of_scalar = string_of_float
  let string_of_elt = string_of_float

  let copy x = ref !x
  let deepcopy x = copy x

  let zero () = ref 0.
  let one () = ref 1.
  let two () = ref 2.

  let scale x a = ref (a *. !x)
  let translate x a = ref (!x +. a)

  let ( ~+ ) = copy
  let ( ~- ) x = Stdlib.(ref (~-. !x))

  let ( + ) x y = Stdlib.(ref (!x +. !y))
  let ( += ) x y = Stdlib.(x := (!x +. !y)); x

  let ( - ) x y = Stdlib.(ref (!x -. !y))
  let ( -= ) x y = Stdlib.(x := (!x -. !y)); x

  let ( * ) x y = Stdlib.(ref (!x *. !y))
  let ( *= ) x y = Stdlib.(x := (!x *. !y)); x

  let ( / ) x y = Stdlib.(ref (!x /. !y))
  let ( /= ) x y = Stdlib.(x := (!x /. !y)); x

  let ( ** ) x y = Stdlib.(ref (!x ** !y))

  let inv x = Stdlib.(ref (1. /. !x))
  let sqr x = Stdlib.(ref (!x *. !x))

  let sqrt x = Stdlib.(ref (sqrt !x))
  let log x = Stdlib.(ref (log !x))
  let exp x = Stdlib.(ref (exp !x))
  let sin x = Stdlib.(ref (sin !x))
  let cos x = Stdlib.(ref (cos !x))
  let tan x = Stdlib.(ref (tan !x))
  let asin x = Stdlib.(ref (asin !x))
  let acos x = Stdlib.(ref (acos !x))
  let atan x = Stdlib.(ref (atan !x))

  let ( = ) x y = Stdlib.(!x = !y)
  let ( <> ) x y = Stdlib.(!x <> !y)

  let ( < ) x y = Stdlib.(get x < get y)
  let ( <= ) x y = Stdlib.(get x <= get y)
  let ( > ) x y = Stdlib.(get x > get y)
  let ( >= ) x y = Stdlib.(get x >= get y)

  let max f1 f2 = make (max (get f1) (get f2))
  let min f1 f2 = make (min (get f1) (get f2))
end

include Fadbad.OrderedF(Float)

  let infinity = make infinity
  let neg_infinity = make neg_infinity
  let nan = make nan
  let max_val = make max_float
  let min_val = make min_float
  let epsilon = make epsilon_float

  let classify v = classify_float !!v

  let of_string s = make (float_of_string s)

  let print v = print_string (to_string v)
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