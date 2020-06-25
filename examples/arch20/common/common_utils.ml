open Common_types

let make_dump_folder path name =
  let split = StringLabels.split_on_char ' ' name in
  let filter = List.fold_right (fun s acc -> if s = "" || s = "-" then acc else s :: acc) split [] in
  let name = String.concat "_" filter in
  let foldername = Printf.sprintf "dump_%s" name in
  Filename.concat path foldername

let make_tmp_dump i = Filename.open_temp_file ("dump_" ^ (string_of_int i) ^ "_") ".csv"
let close_tmp_dump (path, fd) = close_out fd

let print_result print_sample { optim; n_runs; best_sample; best_rob;
                                falsified; elapsed_time } =
  Printf.printf "Result %s (%d runs): %sFALSIFIED after %g seconds\n"
    optim n_runs (if falsified then "" else "NOT ") elapsed_time;
  Printf.printf "\tbest_sample: %a with rob %g\n"
    print_sample best_sample best_rob

let print_matlab_validate fd bench_name shared_path model_name prop_name_in_matlab model_folder =
  Printf.fprintf fd
    "warning('off','all');\n\
     addpath(\"%s\");\n\
     addpath(genpath(\"%s\"));\n\
     run(\"spec_%s.m\");\n\
     [ok, notok] = validate_zlscheck_%s(%s, preds, \".\");\n\
     validation_results.('%s').('%s').ok = ok;\n\
     validation_results.('%s').('%s').notok = notok;\n\
     clear ok notok preds u T;"
    (Filename.concat (Filename.dirname shared_path) "matlab")
    (Filename.concat shared_path ("benchmarks/" ^ model_folder))
    model_name model_name prop_name_in_matlab
    model_name bench_name model_name bench_name

let print_result print_optim_params ff
    { bench; desc; prop; n_repet; n_runs; mean_n_runs; median_n_runs;
      n_falsif; total_time } =
  Printf.fprintf ff "name:%s\n" bench;
  Printf.fprintf ff "desc:%s\n" desc;
  Printf.fprintf ff "prop:%s\n" prop;
  Printf.fprintf ff "n_repet:%d\n" n_repet;
  Printf.fprintf ff "n_runs:%d\n" n_runs;
  Printf.fprintf ff "n_falsif:%d\n" n_falsif;
  Printf.fprintf ff "mean:%g\n" mean_n_runs;
  Printf.fprintf ff "median:%g\n" median_n_runs;
  Printf.fprintf ff "time:%g\n" total_time;
  Printf.fprintf ff "\nparams:\n%a" print_optim_params ()

let print_validate_all fd shared_path =
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
    (Filename.concat (Filename.dirname shared_path) "matlab")

let mk_bench_list_str benches macro_benches =
  let max_macro_length =
    List.fold_left max 0 (List.map (fun (m,_) -> String.length m) macro_benches)
  in
  let new_macro_benches =
    List.map (fun (m,l) ->
        let new_m = Bytes.make (max_macro_length+2) ' ' in
        String.blit m 0 new_m 0 (String.length m);
        new_m.[String.length m] <- ':';
        (Bytes.unsafe_to_string new_m, l)) macro_benches
  in

  Format.fprintf Format.str_formatter
    "@[<h>@ @ @ @ @ @[<v>MACROs:@;@[<h>@;@[<v>%a@]@]@;@[<h>@[<v>INDIVIDUAL BENCHES:@]@;@[<hov>%a@]@]@]@]"
    (fun ff l -> List.iter (fun (m,b) ->
         Format.fprintf ff "@[@[<h>%s@ [@[<hov>%a@]],@]@ @]@," m
           (fun ff l -> List.iter (fun b -> Format.fprintf ff "@[%s@],@;" b) l) b) l)
    new_macro_benches
    (fun ff l -> List.iter (fun b -> Format.fprintf ff "@[%s@],@;" b) l) benches;
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
