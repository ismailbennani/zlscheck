let print_latex print_infos ff info =
  Printf.fprintf ff
    "\\documentclass[landscape]{report}\n\
     \\usepackage[landscape]{geometry}\n\
     \\begin{document}\n\
      %a\n\
    \\end{document}"
    print_infos info

let load_file f =
  let ic = open_in f in
  let n = in_channel_length ic in
  let s = Bytes.create n in
  really_input ic s 0 n;
  close_in ic;
  s

type info = {
  mutable name : string;
  mutable desc : string;
  mutable prop_name : string;
  mutable n_repet : int;
  mutable n_runs : int;
  mutable n_falsif : int;
  mutable mean : float;
  mutable median : float;
  mutable cumulative_time : float;
  mutable actual_time : float;
  mutable best_rob : float;
}

let empty_info () = {
  name = "";
  desc = "";
  prop_name = "";
  n_repet = 0;
  n_runs = 0;
  n_falsif = 0;
  mean = 0.;
  median = 0.;
  best_rob = 0.;
  cumulative_time = 0.;
  actual_time = 0.;
}

let rec find_info path =
  if Sys.is_directory path then
    Array.fold_left (fun acc p -> (find_info (Filename.concat path p)) @ acc)
      [] (Sys.readdir path)
  else
  if Filename.basename path = "info" then [path] else []

let read_info path =
  let res = empty_info () in
  let fd = open_in path in
  try
    let cont = ref true in
    while !cont do
      let line = input_line fd in
      if String.trim line = "" then cont := false
      else try
        let parse_line = String.split_on_char ':' line in
        let field = List.hd parse_line in
        let value = List.hd (List.tl parse_line) in
        if field = "name" then
          res.name <- String.concat "\\_" (String.split_on_char '_' value)
        else if field = "desc" then
          res.desc <- String.concat "\\_" (String.split_on_char '_' value)
        else if field = "prop" then
          res.prop_name <- String.concat "\\_" (String.split_on_char '_' value)
        else if field = "n_repet" then res.n_repet <- int_of_string value
        else if field = "n_runs" then res.n_runs <- int_of_string value
        else if field = "n_falsif" then res.n_falsif <- int_of_string value
        else if field = "mean" then res.mean <- float_of_string value
        else if field = "median" then res.median <- float_of_string value
        else if field = "best_rob" then res.best_rob <- float_of_string value
        else if field = "cumulative_time" then res.cumulative_time <- float_of_string value
        else if field = "actual_time" then res.actual_time <- float_of_string value
        else Printf.eprintf "Unknown field %s, ignored.\n" field
      with e -> cont := false
    done;
    close_in fd;
    res
    with e -> begin
      Printf.eprintf "File %s is not a valid info file.\n" path;
      close_in fd;
      raise e;
  end

let print_full_infos ff info_l =
  let print_time ff t =
    let secs_i = truncate (mod_float t 60.) in
    let rest = floor (t /. 60.) in
    let mins_i = truncate (mod_float rest 60.) in
    let rest = floor (rest /. 60.) in
    let hours_i = truncate (mod_float rest 24.) in
    let rest = floor (rest /. 24.) in
    let days_i = truncate rest in
    let days = if days_i = 0 then ""
      else (string_of_int days_i) ^ " days " in
    let hours = if days_i = 0 && hours_i = 0 then ""
      else (string_of_int hours_i) ^ " hours " in
    let mins = if days_i = 0 && hours_i = 0 && mins_i = 0 then ""
      else (string_of_int mins_i) ^ " mins " in
    let secs = (string_of_int secs_i) ^ " secs " in
    Printf.fprintf ff "%s%s%s%s" days hours mins secs
  in
  let print_full_info { name; desc; prop_name; n_repet; n_runs; n_falsif;
                        mean; median; best_rob; cumulative_time; actual_time } =
    Printf.fprintf ff "%s & %d & %d & %d & %g & %g & %g & %a & %a\n\\\\\\hline\n"
      prop_name n_repet n_runs n_falsif mean median best_rob
      print_time cumulative_time print_time actual_time
  in
  Printf.fprintf ff "\\begin{tabular}{|r|c|c|c|c|c|c|c|c|}\n\\hline\n";
  Printf.fprintf ff "prop & repet & runs & falsif & mean & median & best\_rob & \
                 cumulative\\_time & actual\\_time\n\\\\\\hline\n";
  List.iter print_full_info info_l;
  Printf.fprintf ff "\\end{tabular}"

let print_short_infos ff info_l =
  let print_short_info { prop_name; n_repet; n_falsif; mean; median; best_rob } =
    Printf.fprintf ff "%s & %d/%d & %g & %g & %g\n\\\\\\hline\n"
      prop_name n_falsif n_repet mean median best_rob
  in
  Printf.fprintf ff "\\begin{tabular}{|r|c|c|c|c|}\n\\hline\n";
  Printf.fprintf ff "prop & falsif/repet & mean & median & best\_rob\n\\\\\\hline\n";
  List.iter print_short_info info_l;
  Printf.fprintf ff "\\end{tabular}"

let _ =
  let short = ref false in
  let pdf = ref false in
  let paths = ref [] in

  let usg = "usage: ./read_results.opt [ args ] PATH( PATH)*\n\n\
             finds all files names 'info' in subtree of input paths and merge \
             their content, outputs in stdout"
  in

  Arg.parse [
    "--short", Arg.Set short, "output less fields";
    "--pdf", Arg.Set pdf, "output pdf instead of tex (requires pdflatex)";
  ] (fun p -> paths := p :: !paths) usg;

  let info = List.concat (List.map find_info !paths) in
  let info = List.map read_info info in

  (* let instance1 = List.fold_left (fun acc info ->
      if Filename.check_suffix info.prop_name "_inst2" then acc
      else if Filename.check_suffix info.prop_name "_inst1" then
        { info with prop_name = String.sub info.prop_name 0 (String.length info.prop_name - 6) } :: acc
      else info :: acc) [] info
  in
  let instance2 = List.fold_left (fun acc info ->
      if Filename.check_suffix info.prop_name "_inst1" then acc
      else if Filename.check_suffix info.prop_name "_inst2" then
        { info with prop_name = String.sub info.prop_name 0 (String.length info.prop_name - 6) } :: acc
      else info :: acc) [] info
  in *)

  let print_infos = if !short then print_short_infos else print_full_infos in

  if !pdf then begin
    let tmp_name, tmp_fd = Filename.open_temp_file "bench_res_" ".tex" in
    Printf.fprintf tmp_fd "%a" (print_latex print_infos) info;
    close_out tmp_fd;
    Sys.command (Printf.sprintf "pdflatex -output-directory=/tmp -interaction=nonstopmode %s > /dev/null" tmp_name);
    let pdf_name = (Filename.chop_suffix tmp_name ".tex") ^ ".pdf" in
    ignore (Sys.command ("cat " ^ pdf_name));
  end else begin
    Printf.printf "%a" (print_latex print_infos) info;
    print_newline ();
  end
