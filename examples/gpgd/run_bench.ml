module Optim = Gpgd.Make(MyOp)(AdaptativeGradient.AMSGRADMethod)

module Make(Bench : Bench_type.Bench) =
struct
  let name = Bench.name
  let run () =
    Bench.set_optim_params ();
    Optim.run Bench.node Bench.max_n
end

module Bench = Make(Defbench.Autotrans.Phi6a)

let _ =
  let open Optim in

  Random.self_init ();

  Optim_globals.params.vverbose <- true;

  let { hist; rob; n_chunks; n_sim_steps; max_n } = Bench.run () in

  Printf.printf "\n";
  Printf.printf "Sim. horizon : %d steps\n" max_n;
  Printf.printf "Final number of chunks: %d\n" n_chunks;
  Printf.printf "Total number of sim. steps computed : %d\n" n_sim_steps;
  Printf.printf "\n";
  Printf.printf "Final rob: %g\n" rob;
  Printf.printf "Final input:\n";
  List.iter
    (fun (input, n) -> Printf.printf "\t[%s] for %d steps\n"
        (String.concat "; " (Array.to_list (Array.map (Printf.sprintf "%g") input)))
        n)
    (List.hd hist)
