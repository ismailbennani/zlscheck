open Common_types

let make_dump_folder path name =
  let split = StringLabels.split_on_char ' ' name in
  let filter = List.fold_right (fun s acc -> if s = "" || s = "-" then acc else s :: acc) split [] in
  let name = String.concat "_" filter in
  let foldername = Printf.sprintf "dump_%s" name in
  Filename.concat path foldername

let make_tmp_dump () = Filename.open_temp_file "dump" ".csv"
let close_tmp_dump (path, fd) = close_out fd

let print_result print_sample { optim; n_runs; best_sample; best_rob;
                                falsified; elapsed_time } =
  Printf.printf "Result %s (%d runs): %sFALSIFIED after %g seconds\n"
    optim n_runs (if falsified then "" else "NOT ") elapsed_time;
  Printf.printf "\tbest_sample: %a with rob %g\n"
    print_sample best_sample best_rob

let print_matlab_validate fd bench_name matlab_path model_name prop_name_in_matlab model_folder =
  Printf.fprintf fd
    "warning('off','all');\n\
     addpath(genpath(\"/home/lahkim/Documents/MATLAB/toolbox/S-TALIRO\"));\n\
     addpath(genpath(\"/home/lahkim/Documents/MATLAB/toolbox/matlab_bgl\"));\n\
     addpath(\"%s\");\n\
     addpath(genpath(\"%s\"));\n\
     run(\"spec_%s.m\");\n\
     [ok, notok] = validate_zlscheck_%s(%s, preds, \".\");\n\
     validation_results.('%s').('%s').ok = ok;\n\
     validation_results.('%s').('%s').notok = notok;\n\
     clear ok notok preds u T;"
    matlab_path
    (Filename.concat (Filename.dirname matlab_path)
       ("shared/benchmarks/" ^ model_folder))
    model_name model_name prop_name_in_matlab
    model_name bench_name model_name bench_name

let print_result print_optim_params ff
    { bench; desc; n_repet; n_runs; mean_n_runs; median_n_runs;
      n_falsif; total_time } =
  Printf.fprintf ff "Result %s: %s\n" bench desc;
  Printf.fprintf ff "\t%d/%d successfully falsified\n" n_falsif n_repet;
  Printf.fprintf ff "\tmax runs per falsif: %d\n" n_runs;
  Printf.fprintf ff "\tmean num runs: %g\n" mean_n_runs;
  Printf.fprintf ff "\tmedian num runs: %g\n" median_n_runs;
  Printf.fprintf ff "\ttotal time: %g seconds\n" total_time;
  Printf.fprintf ff "\n";
  Printf.fprintf ff "%a" print_optim_params ()

let print_validate_all fd matlab_path =
  Printf.fprintf fd
    "addpath(\"%s\")\n\
     cur_fd = pwd;\n\
     validation_scripts = find_rec(\".\", \"validate.m\");\n\
     for i = 1:length(validation_scripts)\n\
     \tvalidation_script = validation_scripts(i);\n\
     \t[folder, ~] = fileparts(validation_script);\n\
     \tfprintf(\"Entering  %%s...\", folder);\n\
     \tcd(folder);\n\
     \trun(\"validate.m\");\n\
     end\n\
     cd(cur_fd);\n\
     clear cur_fd validation_scripts validation_script folder i;"
    matlab_path

let mk_bench_list_str benches macro_benches =
  Format.fprintf Format.str_formatter
    "@[<h>@ @ @ @ @ @[<v>@[<h>@[<v>MACRO:@]@;@[<v>%a@]@]@;@[<h>@[<v>INDIVIDUAL BENCHES:@]@;@[<hov>%a@]@]@]@]"
    (fun ff l -> List.iter (fun b -> Format.fprintf ff "@[%s@]@," b) l) macro_benches
    (fun ff l -> List.iter (fun b -> Format.fprintf ff "@[%s,@ @]@," b) l) benches;
  (* (String.concat ", " benches); *)
  Format.flush_str_formatter ()

let string_of_op_t_arr arr =
  (String.concat ","
     (Array.to_list
        (Array.map
           (fun fad_f -> Printf.sprintf "%g" (MyOp.get fad_f))
           arr)))

let print_grads ff x =
  Printf.fprintf ff "[%s]" (String.concat "; "
                              (List.init (MyOp.dim x)
                                 (fun i -> Printf.sprintf "%g" (MyOp.d x i))))

let compute_mean a =
  let n = Array.length a in
  if n = 0 then -1.
  else
    let sum = Array.fold_left ( + ) 0 a in
    (float sum) /. (float n)

let compute_median a =
  let n = Array.length a in
  if n = 0 then -1.
  else
    let a' = Array.copy a in
    Array.fast_sort compare a';
    ((float a.((n-1)/2)) +. (float a.(n/2))) /. 2.0;;
