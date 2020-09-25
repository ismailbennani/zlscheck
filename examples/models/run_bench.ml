open Ztypes

let pick_random (a, b) = Random.float (b -. a) +. a

let run (Node { alloc; step; reset } as bench) input max_t =
  let q = alloc () in
  reset q;

  let rec aux t rob =
    Printf.printf "\t\t\tt: %g/%g                                   \r" t max_t;
    if t > max_t then
      MyOp.get rob
    else
      let input = Array.map MyOp.make input in
      let t, _, rob = step q input in
      aux t rob
  in aux 0. MyOp.infinity

let name = ref "AT"
let model = ref (At_bench.autotrans_at1 0.01)
let n_input = ref 2
let bounds = ref [| 0., 100.; 0., 350. |]
let max_t = ref 20.

let set_at () =
  name := "AT";
  model := At_bench.autotrans_at1 0.01;
  n_input := 2;
  bounds := [| 0., 100.; 0., 350. |];
  max_t := 20.

let set_f16 () =
  name := "F16";
  model := F16_bench.f16 0.01;
  n_input := 3;
  let pi = 3.1416 in
  bounds := [| pi /. 4. -. pi /. 20., pi /. 4. +. pi /. 20.;
               -. pi /. 2. *. 0.8, -. pi /. 2. *. 0.8 +. pi /. 20.;
               -. pi /. 4. -. pi /. 8., -. pi /. 4. +. pi /. 8. |];
  max_t := 25.

let set_model s =
  if s = "at" || s = "AT" || s = "autotrans" then
    set_at ()
  else if s = "f16" || s = "F16" then
    set_f16 ()
  else begin
    Printf.eprintf "Don't know model %s, valid models are: at, f16" s;
    exit 1
  end

let _ =

  let k = ref 1000 in
  let n = ref 1000 in
  let use_max = ref false in

  Arg.parse [
    "-model", Arg.String set_model, "model to run";
    "-n", Arg.Set_int n, "outer loop size";
    "-k", Arg.Set_int k, "inner loop size";
    "-max", Arg.Set use_max, "record max output instead of min output";
  ] (fun _ -> ()) "./run_bench [-model [at | f16]] [-n N] [-k K] [-max]";

  let n = !n in
  let k = !k in
  let use_max = !use_max in
  let name = !name in
  let model = !model in
  let n_input = !n_input in
  let bounds = !bounds in
  let max_t = !max_t in

  Printf.printf "Chosen model: %s\n" name;

  let folder_name = Printf.sprintf "dump_%s" name in
  let main_filename = Filename.concat folder_name "main_dump.csv" in

  if not (Sys.file_exists folder_name) || not (Sys.is_directory folder_name) then
    Unix.mkdir folder_name 0o777;

  let main_fd = open_out main_filename in

  Printf.fprintf main_fd "%s,rob\n" (String.concat "," (List.init n_input (fun i -> Printf.sprintf "u%d" i)));
  flush main_fd;

  for i = 0 to n - 1 do
    let filename = Filename.concat folder_name (Printf.sprintf "dump%d.csv" i) in
    let fd = open_out filename in
    Printf.fprintf fd "%s,rob\n" (String.concat "," (List.init n_input (fun i -> Printf.sprintf "u%d" i)));

    Printf.printf "Run %d/%d:\n" (i+1) n;

    let best_input = ref [||] in
    let best_rob = ref infinity in

    for j = 0 to k - 1 do
      let input = Array.map pick_random bounds in
      Printf.printf "Iteration %d/%d: " (j+1) k; flush stdout;
      let rob = run model input max_t in
      Printf.fprintf fd "%s,%g\n" (String.concat "," (Array.to_list (Array.map (Printf.sprintf "%g") input))) rob;

      if !best_input = [||] ||
         (use_max && rob > !best_rob) ||
         (not use_max && rob < !best_rob) then
        begin
          best_input := input;
          best_rob := rob;
        end;
    done;

    Printf.printf "done.%*s\nBest rob: %g\n" 30 " " !best_rob;
    close_out fd;

    Printf.fprintf main_fd "%s,%g\n" (String.concat "," (Array.to_list (Array.map (Printf.sprintf "%g") !best_input))) !best_rob;
    flush main_fd;
  done;

  close_out main_fd
