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
          (fun t fs temp fcw q p rob ->
            time.(!i) <- t;
            inps.(!i) <- [|fs;temp;fcw;q;p;rob|];
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
let t_max = 40.
let fs_min = 3.99
let fs_max = 4.01
let p_min = 86.
let p_max = 90.

let n_scope = 2
let scope_w = truncate (width -. 2. *. padx)
let scope_h = truncate ((height -. (float (n_scope - 1)) *. sepy -. 2. *. pady -. offsety) /. (float n_scope))
let scope_x = truncate padx
let fs_y = truncate pady
let p_y = truncate (pady +. (float scope_h) +. sepy)

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

let h_lines = [|[||]; [|87.; 87.5|]|]
let v_lines = [|[||]; [|30.; 35.|]|]

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

let draw_fs times values =
  draw_scope fs_y (fs_min, fs_max) 0 red times values;
  draw_h_lines fs_y (fs_min, fs_max) 0 times;
  draw_v_lines fs_y (fs_min, fs_max) 0
let draw_p times values =
  draw_scope p_y (p_min, p_max) 4 red times values;
  draw_h_lines p_y (p_min, p_max) 1 times;
  draw_v_lines p_y (p_min, p_max) 1

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

let draw_fs_axis () =
  draw_scope_axis_x (scope_x, fs_y) (fs_min, fs_max) blue "t";
  draw_scope_axis_y (scope_x, fs_y) (fs_min, fs_max) blue "Fs" true
let draw_p_axis () =
  draw_scope_axis_x (scope_x, p_y) (p_min, p_max) blue "t";
  draw_scope_axis_y (scope_x, p_y) (p_min, p_max) blue "P" true

let draw_scopes i =
  let dump_file = get_path i in
  let times, inps = read_dump dump_file in
  clear_graph ();

  draw_fs times inps;
  draw_p times inps;

  draw_fs_axis ();
  draw_p_axis ();

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
  dump_path := "test_sc/hist/dump_sc_offline_SA/1";

  open_graph (":0 " ^ (string_of_int (truncate width)) ^ "x" ^ (string_of_int (truncate height)) ^ "+0-1000");
  auto_synchronize false;

  main "SC - offline GD" 1;
