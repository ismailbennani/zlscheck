(* Based on the paper
   On the convergence of adam and beyond
   SJ Reddi, S Kale, S Kumar - arXiv preprint arXiv:1904.09237
*)

open Zlscheck_utils
open Optim_types
open Optim_utils

let ( ++ ) = sum_array
let ( *@ ) = scale
let ( +@ ) = translate

let print_result n_runs max_n_runs cur_sample cur_val cur_grad =
  Printf.printf "Run %i/%i\n" n_runs max_n_runs;
  Printf.printf "New point : %a\n" Misc_printers.print_float_array cur_sample;
  Printf.printf "New value : %.2e\n" cur_val;
  Printf.printf "New gradient : %a\n" Misc_printers.print_float_array cur_grad;
  print_newline (); flush stdout

type 'a optim_params_ = {
  do_restart: bool;
  restart_fn: unit -> unit;
  meth: 'a;
}

module type Method =
sig
  type meth_params
  val default_params : meth_params

  val name : string

  val string_of_params : meth_params -> string

  type acc
  val create_acc : unit -> acc

  (* first order moment
     [phi params t grad] *)
  val phi : meth_params optim_params_ params -> acc -> int -> float array -> float array
  (* second order moment (RESTRICTION TO DIAGONAL MATRICES)
     [psi params t grad] *)
  val psi : meth_params optim_params_ params -> acc -> int -> float array -> float array

  val alpha : meth_params optim_params_ params -> int -> float

  val proj : (float * float) array -> float array -> float array
end

module ClassicMethod =
struct
  let name = "Classic"

  type meth_params = {
    alpha: float;
  }

  let string_of_params p = Printf.sprintf "{ \"alpha\": %g }" p.alpha

  let default_params = {
    alpha = 0.5;
  }

  type acc = { mutable psi_res : float array }
  let create_acc () = { psi_res = [||]; }

  let phi _ _ _ grad = grad
  let psi _ acc _ grad =
    if Array.length acc.psi_res = 0 then
      acc.psi_res <- Array.make (Array.length grad) 1.;
    acc.psi_res

  let alpha params t =
    params.optim.meth.alpha /. (sqrt (float t))

  let proj bounds sample =
    saturate_array bounds sample
end

module ADAGRADMethod =
struct
  (* John C. Duchi, Elad Hazan, and Yoram Singer.
     Adaptive subgradient methods for online learning and stochastic
     optimization.
     Journal of Machine Learning Research, 12:2121–2159, 2011. *)
  let name = "ADAGRAD"

  type meth_params = {
    alpha: float;
  }

  let string_of_params p = Printf.sprintf "{ \"alpha\": %g }" p.alpha

  let default_params = {
    alpha = 0.5;
  }

  type acc = { mutable last_psi : float array; }
  let create_acc () = { last_psi = [||] }

  let phi _ _ _ grad = grad
  let psi _ acc t grad =
    if Array.length acc.last_psi = 0 then
      acc.last_psi <- square_array grad
    else
      acc.last_psi <- acc.last_psi ++ (square_array grad);
    acc.last_psi *@ (1./.(float t))

  let alpha params t =
    params.optim.meth.alpha /. (sqrt (float t))

  let proj bounds sample =
    saturate_array bounds sample
end

module ADAMMethod =
struct
  (* Diederik P. Kingma and Jimmy Ba.
     Adam: A method for stochastic optimization.
     In Proceedings of 3rd International Conference on Learning Representations,
     2015. *)
  let name = "ADAM"

  type meth_params = {
    alpha : float;
    beta1 : float;
    beta2 : float;
  }

  let string_of_params p =
    Printf.sprintf "{ \"alpha\": %g, \"beta1\": %g, \"beta2\": %g }"
      p.alpha p.beta1 p.beta2

  let default_params = {
    alpha = 0.5;
    beta1 = 0.9;
    beta2 = 0.999;
  }

  type acc = {
    mutable last_phi : float array;
    mutable last_psi : float array;
  }
  let create_acc () = { last_phi = [||]; last_psi = [||] }

  let phi params acc _ grad =
    if Array.length acc.last_phi = 0 then
      acc.last_phi <- grad *@ (1. -. params.optim.meth.beta1)
    else
      acc.last_phi <- (acc.last_phi *@ params.optim.meth.beta1) ++ (grad *@ (1. -. params.optim.meth.beta1));
    acc.last_phi
  let psi params acc _ grad =
    if Array.length acc.last_psi = 0 then
      acc.last_psi <- (square_array grad) *@ (1. -. params.optim.meth.beta2)
    else
      acc.last_psi <- (acc.last_psi *@ params.optim.meth.beta2) ++ ((square_array grad) *@ (1. -. params.optim.meth.beta2));
    acc.last_psi

  let alpha params t =
    params.optim.meth.alpha /. (sqrt (float t))

  let proj bounds sample =
    saturate_array bounds sample
end

module AMSGRADMethod =
struct
  let name = "AMSGRAD"

  type meth_params = {
    alpha : float;
    beta1 : float;
    beta2 : float
  }

  let string_of_params p =
    Printf.sprintf "{ \"alpha\": %g, \"beta1\": %g, \"beta2\": %g }"
      p.alpha p.beta1 p.beta2

  let default_params = {
    alpha = 0.5;
    beta1 = 0.9;
    beta2 = 0.999;
  }

  type acc = {
    mutable last_phi : float array;
    mutable last_psi : float array;
    mutable last_max_psi : float array;
  }
  let create_acc () = {
    last_phi = [||];
    last_psi = [||];
    last_max_psi = [||];
  }

  let alpha params t =
    params.optim.meth.alpha /. (sqrt (float t))
  let beta1 params t =
    params.optim.meth.beta1 /. (float t)

  let phi params acc t grad =
    let beta1 = beta1 params t in
    if Array.length acc.last_phi = 0 then
      acc.last_phi <- grad *@ (1. -. beta1)
    else
      acc.last_phi <- (acc.last_phi *@ beta1) ++ (grad *@ (1. -. beta1));
    acc.last_phi
  let psi params acc t grad =
    if Array.length acc.last_psi = 0 then begin
      acc.last_psi <- square_array grad;
      acc.last_max_psi <- acc.last_psi
    end else begin
      let new_psi = (acc.last_psi *@ params.optim.meth.beta2) ++
                    ((square_array grad) *@ (1. -. params.optim.meth.beta2)) in
      acc.last_psi <- new_psi;
      acc.last_max_psi <- max_array acc.last_max_psi new_psi
    end;
    acc.last_max_psi

  let proj bounds sample =
    saturate_array bounds sample
end

module Generic(Method : Method) =
struct

  type input = float array
  type output = float * float array
  type optim_params = Method.meth_params optim_params_
  type optim_step_params = { mutable t : int; method_acc : Method.acc }

  let string_of_params params =
    Printf.sprintf "{ \"do_restart\": %b, \"meth\": %s }"
      params.do_restart (Method.string_of_params params.meth)
  let default_params = {
    do_restart = false;
    restart_fn = (fun () -> ());
    meth = Method.default_params;
  }
  let mk_step_params _ = { t = 1; method_acc = Method.create_acc () }

  let name = "GD_" ^ Method.name

  let gd_next_sample params step_params =
    let cur_sample, (cur_val, cur_grad) = step_params.last_result in
    let alpha = Method.alpha params step_params.optim_step.t in
    let mt =
      Method.phi
        params
        step_params.optim_step.method_acc
        step_params.optim_step.t
        cur_grad
    in
    let vt =
      Method.psi
        params
        step_params.optim_step.method_acc
        step_params.optim_step.t
        cur_grad
    in
    let dir = mul_array mt (translate (sqrt_diag_mat vt) epsilon_float) in
    let next_sample = mac cur_sample (-. alpha) dir in
    Method.proj params.bounds next_sample


  let step params step_params incr_runs fn =
    let cur_sample, (cur_val, cur_grad) = step_params.last_result in
    let next_sample = gd_next_sample params step_params in

    let next_val, next_grad = fn next_sample in
    incr_runs ();


    if (params.verbose &&
        step_params.n_runs mod 100 = 1) ||
       params.vverbose then
      begin
        print_result step_params.n_runs params.max_n_runs
          cur_sample cur_val cur_grad;
      end;

    step_params.optim_step.t <- step_params.optim_step.t + 1;

    let next_res = (next_sample, (next_val, next_grad)) in
    let new_history = next_res :: step_params.history in

    let next_res, next_history =
      if params.optim.do_restart && not step_params.online then begin
        if eq_float_array next_sample cur_sample then begin
          params.optim.restart_fn ();
          let new_sample = ur_sample params.bounds in
          let new_val, new_grad = fn next_sample in
          incr_runs ();
          step_params.optim_step.t <- 1;
          Printf.printf "RESTART at %a\n" Misc_printers.print_float_array new_sample;
          (new_sample, (new_val, new_grad)),
          (new_sample, (new_val, new_grad)) :: new_history
        end else next_res, new_history
      end else next_res, new_history
    in

    (* history and inputs for the next step *)
    step_params.history <- next_history;
    step_params.last_result <- next_res

  let get_rob_from_output (rob, _) = rob
end

module Classic = Generic(ClassicMethod)
module ADAGRAD = Generic(ADAGRADMethod)
module ADAM = Generic(ADAMMethod)
module AMSGRAD = Generic(AMSGRADMethod)
