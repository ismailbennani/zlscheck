open Optim_types

let string_of_mode = function
  | Falsify -> "Falsify"
  | Minimize -> "Minimize"

let string_of_params string_of_optim string_of_init p =
  Printf.sprintf "{ \"max_n_runs\": %d \"bounds\": [%s],\
                  \"init_sample\": %s, \"verbose\": %s, \"meth\": %s }"
    p.max_n_runs
    (String.concat "; "
       (Array.to_list
          (Array.map
             (fun (f1, f2) -> Printf.sprintf "%g,%g" f1 f2)
             p.bounds)))
    (match p.init_sample with None -> "None" | Some i -> string_of_init i)
    (if p.verbose then "true" else "false") (string_of_optim p.optim)
