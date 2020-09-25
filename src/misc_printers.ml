let print_float ff f =
  Printf.fprintf ff "%.8f" f

let print_floatfloat ff (f1, f2) =
  Printf.fprintf ff "(%.8f, %.8f)" f1 f2

let print_array print_content ff a =
  Printf.fprintf ff "[| %a |]"
    (fun ff a ->
       Array.iteri (fun i el ->
           if i = 0 then
             Printf.fprintf ff "%a" print_content el
           else
             Printf.fprintf ff "; %a" print_content el) a)
    a

let print_float_array ff a =
  Printf.fprintf ff "%a" (print_array print_float) a

let print_floatfloat_array ff a =
  Printf.fprintf ff "%a" (print_array print_floatfloat) a

let string_of_float_array sep a =
  Printf.sprintf "%s"
    (String.concat sep (Array.to_list (Array.map (fun f -> Printf.sprintf "%g" f) a)))
