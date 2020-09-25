(* module Optim = Gpgd.Make(MyOp)(AdaptativeGradient.ClassicMethod) *)

module Make(Bench : Bench_type.Bench) =
struct
  module Optim = Gpgd.Make(MyOp)(Bench.GDMethod)
  let name = Bench.name

  let run max_piece_size =
    let open Optim in

    Bench.set_optim_params ();

    let init_sample = Zlscheck_utils.ur_sample Optim_globals.params.bounds in
    Optim_globals.params.init_sample <- Some init_sample;

    let ({ hist; rob; n_chunks; n_sim_steps; max_n } as res) =
      run Bench.node Bench.max_n max_piece_size  in

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
      (List.hd hist);
    init_sample, res
end

module Bench = Defbench.WT.Phi4
module RunBench = Make(Bench)

let _ =
  let open Optim in

  Random.self_init ();
  Optim_globals.params.vverbose <- true;

  Optim_globals.params.meth.gpo.nb_init_samples <- 10;
  Optim_globals.params.meth.gpo.gd_miniter <- 50;
  Optim_globals.params.meth.gpo.gd_maxiter <- 1000;

  RunBench.run 100
