open Common_types

let _ =
  Random.self_init ();

  let models = [
    ("at", (module Defbench.Autotrans.ReplayDiscrete : RunReplay));
    ("f16", (module Defbench.F16.ReplayDiscrete : RunReplay));
    ("cc", (module Defbench.CC.ReplayDiscrete : RunReplay));
    ("wt", (module Defbench.WT.ReplayDiscrete : RunReplay));
    ("afc", (module Defbench.AFC.ReplayDiscrete : RunReplay));
    ("sc", (module Defbench.SC.ReplayDiscrete : RunReplay));
    ("nn", (module Defbench.NN.ReplayDiscrete : RunReplay));
  ] in

  let models_str = String.concat " | " (fst (List.split models)) in
  let all_models = snd (List.split models) in

  let usg_msg = Printf.sprintf "usage: ./replay_bench.opt [%s] dump_path" models_str in

  try
    let sel_model = ref None in
    let dump_path = ref "" in

    let arg_i = ref 0 in
    Arg.parse []
      (fun a ->
         begin match !arg_i with
           | 0 -> sel_model := Some (List.assoc a models)
           | 1 -> dump_path := a
           | _ -> Printf.printf "ignoring anonymous param %s\n" a
         end;
         arg_i := !arg_i + 1)
      usg_msg;

    let Some (module Bench) = !sel_model in
    let dump_path = !dump_path in
    if dump_path = "" then raise (Invalid_argument "got no dump path");

    if Sys.(not (file_exists dump_path) || is_directory dump_path) then
      raise (Invalid_argument (dump_path ^ " is not a valid file"));

    Bench.run dump_path
  with e ->
    Printf.printf "no model selected: %s\n" (Printexc.to_string e);
    print_endline usg_msg;
    raise Exit
