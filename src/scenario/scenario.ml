type 'a desc =
  (* immediate value *)
  | Cste
  | PcwseCste of float
  | Custom of ('a array -> float -> 'a array) * int
  (* combinator *)
  | Cross of 'a t * 'a t
and 'a t = {
  dim: int;
  max_t: float;
  desc: 'a desc;
}

let dim t = t.dim
let max_t t = t.max_t
let desc t = t.desc

let rec fprintf ff s =
  match desc s with
  | Cste -> Printf.fprintf ff "Cste"
  | PcwseCste h -> Printf.fprintf ff "PcwseCste(%g)" h
  | Custom (f, n) -> Printf.fprintf ff "Custom(<fun>, %d)" n
  | Cross (t1, t2) -> Printf.fprintf ff "<%a, %a>" fprintf_inner t1 fprintf_inner t2
and fprintf_inner ff s =
  match desc s with
  | Cross (t1, t2) -> Printf.fprintf ff "%a, %a" fprintf_inner t1 fprintf_inner t2
  | _ -> fprintf ff s

let constant dim max_t = { dim; max_t; desc = Cste }
let piecewise_constant dim h max_t  = { dim; max_t; desc = PcwseCste h }
let custom f n dim max_t = { dim; max_t; desc = Custom (f, n) }
let cross t1 t2 = {
  dim = (dim t1) + (dim t2);
  max_t = max (max_t t1) (max_t t2);
  desc = Cross (t1, t2)
}

let rec n_ctrl_points scenario =
  match desc scenario with
  | Cste -> dim scenario
  | PcwseCste h ->
    let n_pieces = ceil ((max_t scenario) /. h) in
    (truncate n_pieces) * (dim scenario)
  | Custom (f, n) -> n
  | Cross (t1, t2) -> (n_ctrl_points t1) + (n_ctrl_points t2)

let rec get_interp scenario ctrl_points =
  match desc scenario with
  | Cste -> let x = Array.sub ctrl_points 0 (dim scenario) in (fun t -> x)
  | PcwseCste h ->
    let dim = dim scenario in
    fun t ->
      let index = truncate (t /. h) in
      let cp_n = Array.length ctrl_points in
      if index >= cp_n / dim then
        Array.sub ctrl_points (cp_n - dim - 1) dim
      else Array.sub ctrl_points (dim * index) dim
  | Custom (f, _) -> fun t -> f ctrl_points t
  | Cross (t1, t2) ->
    let n1 = n_ctrl_points t1 in
    let n2 = n_ctrl_points t2 in
    let interp1 = get_interp t1 (Array.sub ctrl_points 0 n1) in
    let interp2 = get_interp t2 (Array.sub ctrl_points n1 n2) in
    fun t -> Array.append (interp1 t) (interp2 t)
