type _ t =
  | UniformFloat : (float * float) -> float t
  | Array : 'a t array -> 'a array t
  | Support : ('a * float) list -> 'a t

let rec draw : type a. a t -> a = function
  | UniformFloat (low, up) -> Random.float (up -. low) +. low
  | Array a -> Array.map draw a
  | Support l ->
    let sample = Random.float 1.0 in
    let rec draw sum r =
      begin match r with
        | [] -> assert false
        | (v, p) :: r ->
          let sum = sum +. p in
          if sample <= sum then v else draw sum r
      end
    in
    draw 0. l

let uniform_sample bounds = Array (Array.map (fun b -> UniformFloat b) bounds)
