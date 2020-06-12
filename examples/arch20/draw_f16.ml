open Graphics

(* READ STUFF *)

let dump_path = ref ""

let get_path n = Filename.concat !dump_path ((string_of_int n) ^ ".csv")

let read_dump dump_file =
  Printf.printf "Reading: %s\n" dump_file;

  let dump_fd = open_in dump_file in

  let n_lines = ref (-1) in
  begin try
      while true do
        n_lines := !n_lines + 1;
        ignore(input_line dump_fd);
      done
    with End_of_file -> ()
  end;

  seek_in dump_fd 0;

  let dump_ib = Scanf.Scanning.from_channel dump_fd in
  let time = Array.make !n_lines 42. in
  let inps = Array.make !n_lines [||] in

  let i = ref 0 in
  begin try
      while true do
        Scanf.bscanf dump_ib "%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g\n"
          (fun t phi0 theta0 psi0 alt alpha beta vt phi theta psi p q r rob ->
            time.(!i) <- t;
            inps.(!i) <- [|alt;alpha;beta;vt;phi;theta;psi;p;q;r;rob;phi0;theta0;psi0|];
            i := !i + 1)
      done
    with
    | End_of_file ->
      Printf.printf "Trace size: %d\n\n" !i; flush stdout;
      close_in dump_fd
    | e ->
      Printf.printf "Cannot open file %s: %s\n\n" dump_file (Printexc.to_string e);
      close_in_noerr dump_fd
  end;

  time, inps

(* DRAW STUFF *)

let pi = 3.1416
let dtor = 0.0174533

let anim = true
let width = 1000.
let height = 800.
let offsety = 100.
let padx = 100.
let pady = 50.
let sepy = 20.
let t_min = 0.
let t_max = 15.
let alt_min = 0.
let alt_max = 4050.
let angle_min = -.pi
let angle_max = pi
let a_b_min = -30. *. dtor
let a_b_max = 50. *. dtor
let v_min = 0.
let v_max = 1000.
let speed_min = 0.
let speed_max = 120.

let n_range = 3
let range_w = 100.
let range_h = 10.
let range_offsetx = 70.
let range_sepy = 25.
let phi_min = pi /. 4. -. pi /. 20.
let phi_max = pi /. 4. +. pi /. 20.
let theta_min = -. pi /. 2. *. 0.8
let theta_max = -. pi /. 2. *. 0.8 +. pi /. 20.
let psi_min = -. pi /. 4. -. pi /. 8.
let psi_max = -. pi /. 4. +. pi /. 8.

let range_full_h = (float n_range) *. range_h +. (float (n_range - 1)) *. range_sepy
let phi_range_y = truncate (height -. (offsety -. range_full_h) /. 2. -. range_sepy /. 2.)
let theta_range_y = truncate (height -. (offsety -. range_full_h) /. 2. -. 3. *. range_sepy /. 2.)
let psi_range_y = truncate (height -. (offsety -. range_full_h) /. 2. -. 5. *. range_sepy /. 2.)

let n_scope = 4
let scope_w = truncate (width -. 2. *. padx)
let scope_h = truncate ((height -. (float (n_scope - 1)) *. sepy -. 2. *. pady -. offsety) /. (float n_scope))
let scope_x = truncate padx
let v_y = truncate pady
let a_b_y = truncate (pady +. (float scope_h) +. sepy)
let angle_y = truncate (pady +. 2. *. ((float scope_h) +. sepy))
let alt_y = truncate (pady +. 3. *. ((float scope_h) +. sepy))

let get_coord_x t =
  truncate (((t -. t_min) /. (t_max -. t_min)) *. (float scope_w))
let get_coord_y (v_min, v_max) v =
  truncate (((v -. v_min) /. (v_max -. v_min)) *. (float scope_h))

let draw_scope scope_y (v_min, v_max) column color times values =
  set_color color;
  let draw_point (t, v) =
    if t >= t_min && t <= t_max then
      let x = get_coord_x t in
      let y = get_coord_y (v_min, v_max) v in
      lineto (scope_x + x) (scope_y + y);
  in
  if Array.length times <> 0 then begin
    let first_t = times.(0) in
    let first_v = values.(0).(column) in
    let first_x = get_coord_x first_t in
    let first_y = get_coord_y (v_min, v_max) first_v in
    moveto (scope_x + first_x) (scope_y + first_y);
    Array.iteri (fun i t -> draw_point (t, values.(i).(column))) times;
  end

let draw_inp_range range_y (v_min, v_max) name v =
  set_color black;
  let x_start = truncate (width -. range_offsetx -. range_w) in
  let x_end = truncate (width -. range_offsetx) in
  moveto x_start range_y;
  lineto x_end range_y;
  let s_min = Printf.sprintf "%s: %g" name v_min in
  let s_min_w, s_min_h = text_size s_min in
  moveto (x_start - s_min_w - 2) (range_y - s_min_h / 2);
  draw_string s_min;
  let s_max = Printf.sprintf "%g" v_max in
  let s_max_w, s_max_h = text_size s_max in
  moveto (x_end + 2) (range_y - s_max_h / 2);
  draw_string s_max;
  let v_x = truncate (((v -. v_min) /. (v_max -. v_min)) *. range_w) in
  set_color red;
  moveto (x_start + v_x) (range_y - truncate (range_h /. 2.));
  lineto (x_start + v_x) (range_y + truncate (range_h /. 2.))

let h_lines = [|[||]; [||]; [||]; [||]|]
let v_lines = [|[||]; [||]; [||]; [||]|]

let draw_h_lines scope_y (v_min, v_max) column times =
  Array.iter (fun c ->
    draw_scope scope_y (v_min, v_max) 0 green [|t_min; t_max|] [|[|c|]; [|c|]|])
  h_lines.(column)

let draw_v_lines scope_y (v_min, v_max) column =
  Array.iter (fun c ->
      let x = get_coord_x c in
      moveto (scope_x + x) scope_y;
      lineto (scope_x + x) (scope_y + scope_h))
    v_lines.(column)

let draw_alt times values =
  draw_scope alt_y (alt_min, alt_max) 0 red times values;
  draw_h_lines alt_y (alt_min, alt_max) 0 times;
  draw_v_lines alt_y (alt_min, alt_max) 0
let draw_phi times values =
  draw_scope angle_y (angle_min, angle_max) 4 red times values;
  draw_h_lines angle_y (angle_min, angle_max) 1 times;
  draw_v_lines angle_y (angle_min, angle_max) 1
let draw_theta times values =
  draw_scope angle_y (angle_min, angle_max) 5 blue times values;
  draw_h_lines angle_y (angle_min, angle_max) 1 times;
  draw_v_lines angle_y (angle_min, angle_max) 1
let draw_psi times values =
  draw_scope angle_y (angle_min, angle_max) 6 green times values;
  draw_h_lines angle_y (angle_min, angle_max) 1 times;
  draw_v_lines angle_y (angle_min, angle_max) 1
let draw_p times values =
  draw_scope angle_y (angle_min, angle_max) 7 yellow times values;
  draw_h_lines angle_y (angle_min, angle_max) 1 times;
  draw_v_lines angle_y (angle_min, angle_max) 1
let draw_q times values =
  draw_scope angle_y (angle_min, angle_max) 8 cyan times values;
  draw_h_lines angle_y (angle_min, angle_max) 1 times;
  draw_v_lines angle_y (angle_min, angle_max) 1
let draw_r times values =
  draw_scope angle_y (angle_min, angle_max) 9 magenta times values;
  draw_h_lines angle_y (angle_min, angle_max) 1 times;
  draw_v_lines angle_y (angle_min, angle_max) 1
let draw_alpha times values =
  draw_scope a_b_y (a_b_min, a_b_max) 1 red times values;
  draw_h_lines a_b_y (a_b_min, a_b_max) 2 times;
  draw_v_lines a_b_y (a_b_min, a_b_max) 2
let draw_beta times values =
  draw_scope a_b_y (a_b_min, a_b_max) 2 blue times values;
  draw_h_lines a_b_y (a_b_min, a_b_max) 2 times;
  draw_v_lines a_b_y (a_b_min, a_b_max) 2
let draw_v times values =
  draw_scope v_y (v_min, v_max) 3 red times values;
  draw_h_lines v_y (v_min, v_max) 3 times;
  draw_v_lines v_y (v_min, v_max) 3

let draw_scope_axis_y (scope_x, scope_y) (v_min, v_max) color label left =
  set_color color;
  moveto scope_x scope_y;
  lineto scope_x (scope_h + scope_y);
  let l_w, l_h = text_size label in
  let x = if left then (scope_x - l_w - 10) else (scope_x + 10) in
  moveto x (scope_y + scope_h - l_h);
  draw_string label

let draw_scope_axis_x (scope_x, scope_y) (v_min, v_max) color label =
  set_color black;
  moveto scope_x scope_y;
  lineto (scope_x + scope_w) scope_y;
  let l_w, l_h = text_size label in
  moveto (scope_x + scope_w - l_w) (scope_y - l_h);
  draw_string label

let draw_alt_axis () =
  draw_scope_axis_x (scope_x, alt_y) (alt_min, alt_max) blue "t";
  draw_scope_axis_y (scope_x, alt_y) (alt_min, alt_max) blue "alt" true
let draw_angle_axis () =
  draw_scope_axis_x (scope_x, angle_y) (angle_min, angle_max) blue "t";
  draw_scope_axis_y (scope_x, angle_y) (angle_min, angle_max) blue "angles" true
let draw_a_b_axis () =
  draw_scope_axis_x (scope_x, a_b_y) (a_b_min, a_b_max) blue "t";
  draw_scope_axis_y (scope_x, a_b_y) (a_b_min, a_b_max) blue "a,b" true
let draw_v_axis () =
  draw_scope_axis_x (scope_x, v_y) (v_min, v_max) blue "t";
  draw_scope_axis_y (scope_x, v_y) (v_min, v_max) blue "v" true

let draw_phi_range values =
  draw_inp_range phi_range_y (phi_min, phi_max) "phi0" values.(0).(11)
let draw_theta_range values =
  draw_inp_range theta_range_y (theta_min, theta_max) "theta0" values.(0).(12)
let draw_psi_range values =
  draw_inp_range psi_range_y (psi_min, psi_max) "psi0" values.(0).(13)

let draw_scopes i =
  let dump_file = get_path i in
  let times, inps = read_dump dump_file in
  clear_graph ();

  draw_phi_range inps;
  draw_theta_range inps;
  draw_psi_range inps;

  draw_alt times inps;
  draw_phi times inps;
  draw_theta times inps;
  draw_psi times inps;
  draw_p times inps;
  draw_q times inps;
  draw_r times inps;
  draw_alpha times inps;
  draw_beta times inps;
  draw_v times inps;

  draw_alt_axis ();
  draw_angle_axis ();
  draw_a_b_axis ();
  draw_v_axis ();

  inps.(Array.length inps - 1).(10)


let rec main title i =
  begin try
      let rob = draw_scopes i in
      set_color black;
      moveto 0 (truncate (height -. offsety));
      lineto (truncate width) (truncate (height -. offsety));
      let title_w,title_h = text_size title in
      let step_txt = "Step: " ^ (string_of_int i) in
      let tw,th = text_size step_txt in
      let rob_txt = "Rob: " ^ (string_of_float rob) in
      let tw',th' = text_size rob_txt in
      moveto (truncate ((width-.(float title_w))/.2.)) (truncate (height -. sepy -. (float title_h)));
      draw_string title;
      moveto (truncate ((width-.(float tw))/.2.)) (truncate (height -. offsety +. (float (th+th')) +. 5.));
      draw_string step_txt;
      moveto (truncate ((width-.(float tw'))/.2.)) (truncate (height -. offsety +. (float th')));
      draw_string rob_txt;
      let fals = rob < 0. in
      set_color (if fals then red else green);
      moveto (truncate ((width+.(float tw'))/.2. +. 5.)) (truncate (height -. offsety +. (float th')));
      draw_string (if fals then "KO" else "OK");
      synchronize ();

      let e = wait_next_event [Key_pressed] in
      begin match e.key with
      | 'd' -> main title (i+1)
      | 'q' -> main title (max 1 (i-1))
      | 'x' -> ()
      | _ -> main title i
      end
    with e ->
      Printf.printf "Warning: %s\n" (Printexc.to_string e);
      main title (max 1 (i-1))
  end

let _ =
  dump_path := "f16_results/hist/dump_f16_offline_GD_Classic/1";

  open_graph (":0 " ^ (string_of_int (truncate width)) ^ "x" ^ (string_of_int (truncate height)) ^ "+0-1000");
  auto_synchronize false;

  main "F16 - offline GD" 1;
