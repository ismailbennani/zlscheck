open Deftypes
open Method_types

let mk_bench_list_str benches macro_benches =
  let max_macro_length =
    List.fold_left max 0 (List.map (fun (m,_) -> String.length m) macro_benches)
  in
  let new_macro_benches =
    List.map (fun (m,l) ->
        let new_m = Bytes.make (max_macro_length+2) ' ' in
        String.blit m 0 new_m 0 (String.length m);
        Bytes.set new_m (String.length m) ':';
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
           (fun fad_f -> Printf.sprintf "%g" (FadFloat.get fad_f))
           arr)))

let print_grads ff x =
  Printf.fprintf ff "[%s]" (String.concat "; "
                              (List.init (FadFloat.dim x)
                                 (fun i -> Printf.sprintf "%g" (FadFloat.d x i))))

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
