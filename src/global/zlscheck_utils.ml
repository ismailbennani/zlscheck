let two_pi = 2.0 *. 3.14159265358979323846

let eq_float a b epsilon =
  let absA = abs_float a in
  let absB = abs_float b in
  let diff = abs_float (a -. b) in

  if a = b then
    (* shortcut, handles infinities *)
    true
  else if Float.is_nan a then Float.is_nan b
  else if Float.is_nan b then Float.is_nan a
  else if a = 0. || b = 0. || (absA +. absB < epsilon_float) then
    (* a or b is zero or both are extremely close to it
       relative error is less meaningful here *)
    diff < (epsilon *. epsilon_float)
  else
    diff /. (min (absA +. absB) max_float) < epsilon

let eq_float a b = eq_float a b 1e-10

let eq_float_array a b = Array.for_all (fun x -> x) (Array.map2 eq_float a b)

let array_map3 f a b c =
  let la = Array.length a in
  let lb = Array.length b in
  let lc = Array.length b in
  if la <> lb || lb <> lc then
    invalid_arg "map3: arrays must have the same length"
  else begin
    if la = 0 then [||] else begin
      let r = Array.make la
          (f (Array.unsafe_get a 0) (Array.unsafe_get b 0) (Array.unsafe_get c 0)) in
      for i = 1 to la - 1 do
        Array.unsafe_set r i (f (Array.unsafe_get a i) (Array.unsafe_get b i) (Array.unsafe_get c i))
      done;
      r
    end
  end

let clamp (low, high) x = max low (min x high)
let saturate = clamp

let saturate_array array_bounds array_v =
  let res = Array.copy array_v in
  for i = 0 to Array.length array_bounds - 1 do
    res.(i) <- saturate array_bounds.(i) array_v.(i);
  done;
  res

let rec uniform_float (low, high) =
  if low > high then uniform_float (high, low)
  else Random.float (high -. low) +. low

let ur_sample (input_ranges : (float * float) array) =
  Array.map uniform_float input_ranges

let rec rand_pair () =
  let u1 = Random.float 1.0 in
  let u2 = Random.float 1.0 in
  if u1 < epsilon_float then rand_pair ()
  else u1, u2

let gaussian (mu, sigma) =
  let u1, u2 = rand_pair () in
  let z = sqrt (-.2. *. log u1) *. cos (two_pi *. u2) in
  z *. sigma +. mu

let rec bounded_gaussian (b_min, b_max) (mu, sigma) =
  let lambda = gaussian(mu, sigma) in
  if lambda > b_min && lambda < b_max then lambda
  else bounded_gaussian(b_min, b_max) (mu, sigma)

let random_direction input =
  Array.map (fun _ -> gaussian(0.,1.)) input

let get_bounds center direction bounds radius =
  let min_max =
    (array_map3 (fun center_i dir_i (low_i, up_i) ->
         if dir_i = 0. then (neg_infinity, infinity) else
         let min = (low_i -. center_i) /. dir_i in
         let max = (up_i -. center_i) /. dir_i in
         if min < max then (min,max) else (max,min))
        center direction bounds)
  in
  Array.fold_left (fun (old_min,old_max) (new_min,new_max) ->
      max old_min new_min, min old_max new_max)
    (neg_infinity,infinity) min_max

let in_bounds (value : float array) (bounds : (float * float) array) =
  Array.fold_left (&&) true
    (Array.map2 (fun v (low,up) -> v >= low && v <= up) value bounds)

let mac point coef dir = Array.map2 (fun p d -> p +. coef *. d) point dir

let max_array a b = Array.map2 max a b
let min_array a b = Array.map2 min a b
let sum_array = Array.map2 ( +. )
let mul_array = Array.map2 ( *. )
let div_array = Array.map2 ( /. )
let square_array a =  mul_array a a
let sqrt_array =  Array.map sqrt

let translate point v =
  Array.map (fun p -> p +. v) point
let scale point coef =
  Array.map (fun p -> p *. coef) point

let rec int_pow f i =
  match i with
  | 0 -> 1.
  | 1 -> f
  | _ -> let i' = i/2 in (int_pow f i') *. (int_pow f (i-i'))

let inv_diag_mat m =
  Array.map
    (fun x -> if x = 0. then failwith "inv_diag_mat: division by 0" else 1./.x)
    m

let sqrt_diag_mat m =
  Array.map
    (fun x -> if x < 0. then failwith "sqrt_diag_mat: negative value" else sqrt x)
    m

let norm m =
  sqrt (Array.fold_left ( +. ) 0. (square_array m))

let float_array_dist a1 a2 =
  norm (Array.map2 (fun a b -> a -. b) a1 a2)
