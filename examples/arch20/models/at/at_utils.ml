type op_t = MyOp.t

let exit = exit

(* GENERAL FUNCTIONS *)

(* vec is an ordered float array
 * returns i such that vec.(i) < v < vec.(i+1) (or i = 0 or i = length vec) *)
let ifind v vec =
  let rec aux start_i end_i =
    if start_i = end_i then start_i
    else
      let i = (start_i + end_i) / 2 in
      let v_i = vec.(i) in
      let v_ip1 = vec.(i+1) in
      if MyOp.(v_i < v && v <= v_ip1) then i
      else if MyOp.(v_i >= v) then aux start_i (max 0 (i-1))
      else if MyOp.(v > v_ip1) then
        aux (min (Array.length vec - 1) (i+1)) end_i
      else assert false
  in if v < vec.(0) then 0
  else if v > vec.(Array.length vec - 1) then Array.length vec
  else (aux 0 (Array.length vec - 1)) + 1

(* linear interpolatiion, x1 < xi <= x2 *)
let interp x1 x2 val1 val2 xi =
  let open MyOp in
  if val1 = val2 then val1
  else
    (x2 - xi) / (x2 - x1) * val1 +
    (xi - x1) / (x2 - x1) * val2

(* linear extrapolation, x1 < x2 <= xi OR xi <= x1 <= x2 *)
let extrap x1 x2 val1 val2 xi =
  let open MyOp in
  let slope = (val2 - val1) / (x2 - x1) in
  let dif = slope * (xi - x1) in
  dif + val1

(* LOOKUP FUNCTIONS:
 * These functions implement lookup tables that performs linear interpolation
 * and extrapolation. *)

let lookup1D (line, vals) =
  fun l ->
  try
    let li = ifind l line in
    if (li = 0) then
      extrap line.(0) line.(1) vals.(0) vals.(1) l
    else if (li = (Array.length line)) then
      extrap line.(li - 2) line.(li - 1) vals.(li - 2) vals.(li - 1) l
    else
      interp line.(li - 1) line.(li) vals.(li - 1) vals.(li) l
  with Invalid_argument s ->
    let li = ifind l line in
    print_string "Invalid argument (Lookup1D): "; print_string s;
    print_newline ();
    print_int li; print_string " / "; print_int (Array.length line);
    print_string ", "; print_float (MyOp.get l); print_newline ();
    exit 1

let lookup2D (line, col, vals) =
  fun (l, c) ->
  try
    let li = ifind l line in
    let ci = ifind c col in
    if (li = 0) && (ci = 0) then
      let l0_extrap = extrap (line.(0))
                             (line.(1))
                             (vals.(0).(0))
                             (vals.(1).(0)) l in
      let l1_extrap = extrap (line.(0))
                             (line.(1))
                             (vals.(0).(1))
                             (vals.(1).(1)) l in
      extrap col.(0) col.(1) l0_extrap l1_extrap c
    else if (li = 0) && (ci = Array.length col) then
      let l0_extrap = extrap (line.(0))
                             (line.(1))
                             (vals.(0).((ci - 2)))
                             (vals.(1).((ci - 2))) l in
      let l1_extrap = extrap (line.(0))
                             (line.(1))
                             (vals.(0).((ci - 1)))
                             (vals.(1).((ci - 1))) l in
      extrap col.(ci - 2) col.(ci - 1) l0_extrap l1_extrap c
    else if (li = Array.length line) && (ci = 0) then
      let l0_extrap = extrap (line.(li - 2))
                             (line.(li - 1))
                             (vals.(li - 2).(0))
                             (vals.(li - 1).(0)) l in
      let l1_extrap = extrap (line.(li - 2))
                             (line.(li - 1))
                             (vals.(li - 2).(1))
                             (vals.(li - 1).(1)) l in
      extrap col.(0) col.(1) l0_extrap l1_extrap c
    else if (li = Array.length line) && (ci = Array.length col) then
      let l0_extrap = extrap (line.(li - 2))
                             (line.(li - 1))
                             (vals.(li - 2).((ci - 2)))
                             (vals.(li - 1).((ci - 2))) l in
      let l1_extrap = extrap (line.(li - 2))
                             (line.(li - 1))
                             (vals.(li - 2).((ci - 1)))
                             (vals.(li - 1).((ci - 1))) l in
      extrap col.(ci - 2) col.(ci - 1) l0_extrap l1_extrap c
    else if (li = 0) then
      let l0_extrap = extrap (line.(0))
                             (line.(1))
                             (vals.(0).((ci - 1)))
                             (vals.(1).((ci - 1))) l in
      let l1_extrap = extrap (line.(0))
                             (line.(1))
                             (vals.(0).(ci))
                             (vals.(1).(ci)) l in
      interp col.(ci - 1) col.(ci) l0_extrap l1_extrap c
    else if (ci = 0) then
      let l0_extrap = interp (line.(li - 1))
                             (line.(li))
                             (vals.(li - 1).(0))
                             (vals.(li).(0)) l in
      let l1_extrap = interp (line.(li - 1))
                             (line.(li))
                             (vals.(li - 1).(1))
                             (vals.(li).(1)) l in
      extrap col.(0) col.(1) l0_extrap l1_extrap c
    else if (li = Array.length line) then
      let l0_extrap = extrap (line.(li - 2))
                             (line.(li - 1))
                             (vals.(li - 2).(0))
                             (vals.(li - 1).(0)) l in
      let l1_extrap = extrap (line.(li - 2))
                             (line.(li - 1))
                             (vals.(li - 2).(1))
                             (vals.(li - 1).(1)) l in
      interp col.(0) col.(1) l0_extrap l1_extrap c
    else if (ci = Array.length col) then
      let l0_extrap = interp (line.(li))
                             (line.(li - 1))
                             (vals.(li).((ci - 2)))
                             (vals.(li - 1).((ci - 2))) l in
      let l1_extrap = interp (line.(li))
                             (line.(li - 1))
                             (vals.(li).((ci - 1)))
                             (vals.(li - 1).((ci - 1))) l in
      extrap col.(0) col.(1) l0_extrap l1_extrap c
    else
      let l0_interp = interp (line.(li - 1))
                             (line.(li))
                             (vals.(li - 1).((ci - 1)))
                             (vals.(li).((ci - 1))) l in
      let l1_interp = interp (line.(li - 1))
                             (line.(li))
                             (vals.(li - 1).(ci))
                             (vals.(li).(ci)) l in
      interp col.(ci - 1) col.(ci) l0_interp l1_interp c
  with Invalid_argument s ->
    let li = ifind l line in
    let ci = ifind c col in
    print_string "Invalid argument (Lookup2D): "; print_string s;
    print_newline ();
    print_float (MyOp.get l); print_string ", "; print_float (MyOp.get c); print_newline ();
    print_int li; print_string ", "; print_int ci; print_newline ();
    exit 1

let write ff s = Printf.fprintf ff "%s" s
