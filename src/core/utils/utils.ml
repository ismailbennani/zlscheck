open Misc_printers

let two_pi = 2.0 *. 3.14159265358979323846

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

let saturate (low, high) v =
  if v < low then low else if v > high then high else v

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
         let min = (low_i -. center_i) /. dir_i in
         let max = (up_i -. center_i) /. dir_i in
         if min < max then (min,max) else (max,min))
        center direction bounds)
  in
  (* print_string "bounds : [";
     Array.iter (fun (min,max) ->
      print_string "(";
      print_float min; print_string ", "; print_float max;
      print_string ")") min_max;
     print_string "]"; print_newline (); *)

  Array.fold_left (fun (old_min,old_max) (new_min,new_max) ->
      max old_min new_min, min old_max new_max)
    (neg_infinity,infinity) min_max

let in_bounds (value : float array) (bounds : (float * float) array) =
  Array.fold_left (&&) true (Array.map2 (fun v (low,up) -> v >= low && v <= up) value bounds)

let translate point coef dir =
  Array.map2 (fun p d -> p +. coef *. d) point dir

let neighbour (radius : float) (center : float array) (bounds : (float * float) array) =
  assert (in_bounds center bounds);

  let direction = Array.map (fun _ -> gaussian(0.,1.)) center in
  let lambda_min, lambda_max = get_bounds center direction bounds radius in

  (* Printf.printf "bounds: %a\n" print_floatfloat_array bounds;
  Printf.printf "center: %a\n" print_float_array center;
  Printf.printf "direction: %a\n" print_float_array direction;
  Printf.printf "lambda in [%.2f, %.2f]\n" lambda_min lambda_max;
  Printf.printf "center + lambda * direction between %a and %a\n"
    print_float_array (translate center lambda_min direction)
    print_float_array (translate center lambda_max direction); *)

  let lambda = bounded_gaussian (lambda_min, lambda_max)
      (0., min radius (max lambda_min lambda_max)) in

  (* Printf.printf "lambda: %.2f\n" lambda; *)

  let new_input = Array.map2 (fun f1 f2 -> f1 +. lambda *. f2) center direction in

  (* Printf.printf "new point: %a\n\n" print_float_array new_input; *)

  assert (in_bounds new_input bounds);
  new_input
