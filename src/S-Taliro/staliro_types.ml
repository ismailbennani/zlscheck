type 'a staliro_options = {
  verbose : bool;
  falsification : bool;
  false_at_zero : bool;
  (* plot : bool; *)
  optim_params : 'a
}

type ('a, 'b) run = {
  bestRob : float;
  bestSample : 'a;
  nTests : int;
  paramVal : 'b;
  falsified : bool;
  (* in seconds *)
  run_time : float;
}
type 'a history = {
  hist_rob : float list;
  hist_samples : 'a list;
}

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

let print_run print_sample ff run =
  Printf.fprintf ff "Run time : %.8f\n" run.run_time;
  Printf.fprintf ff "bestSample : %a\n" print_sample run.bestSample;
  Printf.fprintf ff "bestRob : %.8f\n" run.bestRob;
  Printf.fprintf ff "nTests : %d\n" run.nTests;
  Printf.fprintf ff "falsified : %s\n" (if run.falsified then "true" else "false");
