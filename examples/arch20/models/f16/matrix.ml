open MyOp

type 'a t =
  {
    dim: int * int;
    content: 'a array array;
  }

let dim1 m = fst m.dim
let dim2 m = snd m.dim

let create i j el =
  { dim = i,j; content = Array.make_matrix i j el }
let get m i j =
  if Stdlib.(i >= 0) && Stdlib.(i < dim1 m) then
    if Stdlib.(j >= 0) && Stdlib.(j < dim2 m) then
      m.content.(i).(j)
    else assert false
  else assert false
let set m i j v =
  if Stdlib.(i >= 0) && Stdlib.(i < dim1 m) then
    if Stdlib.(j >= 0) && Stdlib.(j < dim2 m) then
      m.content.(i).(j) <- v
    else assert false
  else assert false

let get_row m i =
  if Stdlib.(i >= 0) && Stdlib.(i < dim1 m) then m.content.(i)
  else assert false
let set_row_from_list m i l =
  if Stdlib.(i >= 0) && Stdlib.(i < dim1 m) then
    let row = Array.of_list l in
    if Stdlib.(Array.length row = dim2 m) then
      m.content.(i) <- row
    else assert false
  else assert false

let lut1d_col table i j_f =
  let saturate low high i =
    if i > high then high else if i < low then low else i in
  let j = saturate (make 0.) (integer Stdlib.(dim2 table - 2)) (floor j_f) in
  let dj = j_f - j in let cdj = (make 1.) - dj in

  let j = truncate j in
  (get table i j) * cdj + (get table i Stdlib.(j+1)) * dj

let lut1d_row table i_f j alpha =
  let saturate low high i =
    if i > high then high else if i < low then low else i in
  let i = saturate (make 0.) (integer Stdlib.(dim1 table - 2)) (floor i_f) in
  let di = i_f - i in let cdi = (make 1.) - di in

  let i = truncate i in
  (get table i j) * cdi + (get table Stdlib.(i+1) j) * di

let lut2d table i_f j_f =
  let saturate low high i =
    if i > high then high else if i < low then low else i in

  let i = saturate (make 0.) (integer Stdlib.(dim1 table - 2)) (floor i_f) in
  let di = i_f - i in let cdi = (make 1.) - di in
  let j = saturate (make 0.) (integer Stdlib.(dim2 table - 2)) (floor j_f) in
  let dj = j_f - j in

  let i = truncate i and j = truncate j in
  let s = (get table i j) * cdi + (get table Stdlib.(i+1) j) * di in
  let t = (get table i Stdlib.(j+1)) * cdi + (get table Stdlib.(i+1) Stdlib.(j+1)) * di in
  s + (t - s) * dj
