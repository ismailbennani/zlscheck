open Ztypes

type 'a result = {
  optim: string;
  n_runs: int;
  samples: 'a array;
  robs: float array;
  best_sample: 'a;
  best_rob: float;
  falsified: bool;
  elapsed_time: float (* seconds *)
}

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

let print_matlab_test fd matlab_path model_name prop_name_in_matlab dump_folder =
  Printf.fprintf fd
    "warning('off','all');\n\
     addpath(genpath(\"/home/lahkim/Documents/MATLAB/toolbox/S-TALIRO\"));\n\
     addpath(genpath(\"/home/lahkim/Documents/MATLAB/toolbox/matlab_bgl\"));\n\
     addpath(\"%s\");\n\
     addpath(genpath(\"%s\"));\n\
     run(\"spec_%s.m\");\n\
     [ok, notok] = validate_zlscheck_%s(%s, preds, \".\");"
    matlab_path
    (Filename.concat (Filename.dirname matlab_path)
       ("shared/benchmarks/" ^ model_name))
    model_name model_name prop_name_in_matlab

let string_of_op_t_arr arr =
  (String.concat ","
     (Array.to_list
        (Array.map
           (fun fad_f -> Printf.sprintf "%g" (MyOp.get fad_f))
           arr)))

module type Replay =
sig
  val name : string
  val max_t : float
  val replay_node : (float array * MyOp.t array array, unit) node
  val scan_dump_inp : Scanf.Scanning.in_channel -> MyOp.t array
  (* val print_dump_inp : out_channel -> MyOp.t array -> unit *)
end

module type RunReplay =
sig
  val name : string
  val run : string -> unit
end

module type Bench =
sig
  module Optim : Optim.S with type input := float array and type output := float * float array

  val name : string
  val max_t : float
  val sample_every : int (* used by online optim *)

  val prop_name_in_matlab : string
  val model_name_in_matlab : string

  val dump_path : string
  val matlab_path : string

  val node : (MyOp.t array, float * MyOp.t array * MyOp.t) node

  val set_optim_params: unit -> unit
  (* take k parameters and output a function from time to num_signals values *)
  val interp_fn : MyOp.t array -> float -> MyOp.t array
end

module type RunBench =
sig
  module Optim : Optim.S with type input := float array and type output := float * float array
  val name : string
  val bench_name : string
  val prop_name_in_matlab : string
  val model_name_in_matlab : string
  val dump_path : string option ref
  val dump_folder : string option ref
  val matlab_path : string ref
  val save_path : string ref
  val print_optim_params : out_channel -> unit -> unit
  val run : unit -> float array result
end

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
