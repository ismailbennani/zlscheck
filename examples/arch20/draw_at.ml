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
        Scanf.bscanf dump_ib "%g,%g,%g,%g,%g,%g,%g\n"
          (fun t th br rpm gear speed rob ->
             time.(!i) <- t;
             inps.(!i) <- [|th;br;rpm;gear;speed;rob|]);
        i := !i + 1
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

let anim = true
let width = 1600.
let height = 800.
let offsety = 100.
let padx = 100.
let pady = 50.
let sepy = 20.
let t_min = 0.
let t_max = 30.
let th_min = 0.
let th_max = 100.
let br_min = 0.
let br_max = 360.
let rpm_min = 0.
let rpm_max = 5000.
let gear_min = 1.
let gear_max = 4.
let speed_min = 0.
let speed_max = 120.

let n_scope = 4
let scope_w = truncate (width -. 2. *. padx)
let scope_h = truncate ((height -. (float (n_scope - 1)) *. sepy -. 2. *. pady -. offsety) /. (float n_scope))
let scope_x = truncate padx
let speed_y = truncate pady
let gear_y = truncate (pady +. (float scope_h) +. sepy)
let rpm_y = truncate (pady +. 2. *. ((float scope_h) +. sepy))
let inp_y = truncate (pady +. 3. *. ((float scope_h) +. sepy))

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

let h_lines = [|[||]; [||]; [||]; [||]; [||]|]
let v_lines = [|[||]; [||]; [||]; [||]; [||]|]

let draw_h_lines scope_y (v_min, v_max) column times =
Array.iter (fun c ->
    draw_scope scope_y (v_min, v_max) 0 green
      [|times.(0); times.(Array.length times - 1)|] [|[|c|]; [|c|]|])
  h_lines.(column)

let draw_v_lines scope_y (v_min, v_max) column =
  Array.iter (fun c ->
      let x = get_coord_x c in
      moveto (scope_x + x) scope_y;
      lineto (scope_x + x) (scope_y + scope_h))
    v_lines.(column)

let draw_th times values =
  draw_scope inp_y (th_min, th_max) 0 blue times values;
  draw_h_lines inp_y (th_min, th_max) 0 times;
  draw_v_lines inp_y (th_min, th_max) 0
let draw_br times values =
  draw_scope inp_y (br_min, br_max) 1 red times values;
  draw_h_lines inp_y (br_min, br_max) 0 times;
  draw_v_lines inp_y (br_min, br_max) 0
let draw_rpm times values =
  draw_scope rpm_y (rpm_min, rpm_max) 2 blue times values;
  draw_h_lines rpm_y (rpm_min, rpm_max) 1 times;
  draw_v_lines rpm_y (rpm_min, rpm_max) 1
let draw_gear times values =
  draw_scope gear_y (gear_min, gear_max) 3 blue times values;
  draw_h_lines gear_y (gear_min, gear_max) 2 times;
  draw_v_lines gear_y (gear_min, gear_max) 2
let draw_speed times values =
  draw_scope speed_y (speed_min, speed_max) 4 blue times values;
  draw_h_lines speed_y (speed_min, speed_max) 3 times;
  draw_v_lines speed_y (speed_min, speed_max) 3

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

let draw_th_axis () =
  draw_scope_axis_x (scope_x, inp_y) (th_min, th_max) blue "t";
  draw_scope_axis_y (scope_x, inp_y) (th_min, th_max) blue "throttle" true
let draw_br_axis () =
  draw_scope_axis_y (scope_x + scope_w, inp_y) (br_min, br_max) red "brake" false
let draw_rpm_axis () =
  draw_scope_axis_x (scope_x, rpm_y) (rpm_min, rpm_max) blue "t";
  draw_scope_axis_y (scope_x, rpm_y) (rpm_min, rpm_max) blue "rpm" true
let draw_gear_axis () =
  draw_scope_axis_x (scope_x, gear_y) (gear_min, gear_max) blue "t";
  draw_scope_axis_y (scope_x, gear_y) (gear_min, gear_max) blue "gear" true
let draw_speed_axis () =
  draw_scope_axis_x (scope_x, speed_y) (speed_min, speed_max) blue "t";
  draw_scope_axis_y (scope_x, speed_y) (speed_min, speed_max) blue "speed" true

let draw_scopes i =
  let dump_file = get_path i in
  let times, inps = read_dump dump_file in
  clear_graph ();
  draw_th times inps; draw_th_axis ();
  draw_br times inps; draw_br_axis ();
  draw_rpm times inps; draw_rpm_axis ();
  draw_gear times inps; draw_gear_axis ();
  draw_speed times inps; draw_speed_axis ();
  inps.(Array.length inps - 1).(5)


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

  h_lines.(1) <- [|3000.|];
  h_lines.(3) <- [|35.|];
  v_lines.(3) <- [|4.|];

  dump_path := "at1/hist/dump_autotrans_AT6a_offline_GD_Classic/1";

  open_graph (":0 " ^ (string_of_int (truncate width)) ^ "x" ^ (string_of_int (truncate height)) ^ "+0-1000");
  auto_synchronize false;

  main "AT6a - offline GD" 1;

  h_lines.(1) <- [||];
  h_lines.(3) <- [|120.|];
  v_lines.(3) <- [||];

  dump_path := "at1/hist/dump_autotrans_AT1_offline_GD_Classic/1";

  open_graph (":0 " ^ (string_of_int (truncate width)) ^ "x" ^ (string_of_int (truncate height)) ^ "+0-1000");
  auto_synchronize false;

  main "AT1 - offline - GD" 1;

  dump_path := "at1/hist/dump_autotrans_AT1_online_UR_GD_Classic/1";

  open_graph (":0 " ^ (string_of_int (truncate width)) ^ "x" ^ (string_of_int (truncate height)) ^ "+0-1000");
  auto_synchronize false;

  main "AT1 - online - UR - GD" 1;

  h_lines.(3) <- [|50.|];
  v_lines.(3) <- [|8.|];

  dump_path := "at1/hist/dump_autotrans_AT6b_offline_GD_Classic/1";

  open_graph (":0 " ^ (string_of_int (truncate width)) ^ "x" ^ (string_of_int (truncate height)) ^ "+0-1000");
  auto_synchronize false;

  main "AT6b - offline GD" 1;

  Printf.printf "done\n"
