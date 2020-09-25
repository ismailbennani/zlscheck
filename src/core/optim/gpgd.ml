(* Greedy Piecewise Gradient Descent *)

open Ztypes
open Optim_types
open Optim_utils
open Zlscheck_utils

let print_float_arr ff a =
  Printf.fprintf ff "[%s]"
    (String.concat "; " (Array.to_list (Array.map (fun f -> Printf.sprintf "%g" f) a)))

let is_vverbose () = Optim_globals.params.vverbose
let is_verbose () = Optim_globals.params.verbose || is_vverbose ()

module Make(MyOp : Diff.OrderedFS with type elt = float) (GDMethod : AdaptativeGradient.Method)=
struct
  let name = "gpo"

  let string_of_params p =
    Printf.sprintf "{ \"alpha\": %g, \"beta\": %g, \"eps\": %g }"
      p.gpo.alpha p.gpo.beta p.gpo.eps

  type 's optim_step_params = {
    state : 's;      (* current state of sim *)
    mutable n : int; (* current number of steps since beginning of sim *)
    max_n : int;     (* sim horizon *)
    max_piece_size : int;
    mutable gd_acc : GDMethod.acc;
    mutable chunk_n : int;
    mutable cur_prefix : (float array * int) list;
    mutable cur_rob : float;
    mutable n_sim_steps : int;

    (* store last input that have been computed, as opposed to input
       that has been selected at last step *)
    mutable last_input : float array;
    mutable last_rob : float;
  }

  type gpo_res = {
    hist : (float array * int) list list;
    rob : float;
    n_chunks : int;
    n_sim_steps : int;
    max_n : int;
  }

  let sqrdist u1 u2 =
    let min_length = min (Array.length u1) (Array.length u2) in
    let sum = ref 0. in
    for i = 0 to min_length - 1 do
      sum := !sum +. (u1.(i) -. u2.(i)) *. (u1.(i) -. u2.(i))
    done;
    !sum

  let rec append_chunk prefix (input, n) =
    match prefix with
    | [] -> [input, n]
    | [input', n'] ->
      if sqrdist input input' = 0.
      then [input, n+n']
      else [(input', n'); (input, n)]
    | x :: q -> x :: (append_chunk q (input, n))

  let gd acc input grad bounds k =
    let alpha = GDMethod.alpha k in
    let mt = GDMethod.phi acc k grad in
    let vt = GDMethod.psi acc k grad in
    let dir = mul_array mt (translate (sqrt_diag_mat vt) epsilon_float) in
    let next_sample = mac input (-. alpha) dir in
    (* Printf.printf "%a - %g . %a = %a\n"
       print_float_arr input alpha print_float_arr dir
       print_float_arr next_sample; *)
    GDMethod.proj next_sample

  (* let gd alpha input grad bounds k =
     let next_sample = mac input (-. alpha /. (sqrt (float k))) grad in
     saturate_array bounds next_sample *)

  (* acceptance criterion:
     - eq: chunks have same size, prob of accepting one depends on rob
     - gt: old chunk is bigger,
     - lt: old chunk is smaller,
  *)

  let accept_eq r r' =
    let beta = Optim_globals.params.meth.gpo.beta in
    Random.float 1. <= (exp (beta *. (r -. r')))
  let accept_gt n n' r r' =
    let a = Optim_globals.params.meth.gpo.a in
    let b = Optim_globals.params.meth.gpo.b in
    let alpha = Optim_globals.params.meth.gpo.alpha in
    let beta = Optim_globals.params.meth.gpo.beta in
    let n = float n in
    let n' = float n' in
    Random.float 1. <=
    (a *. (1. -. exp (alpha *. (n' -. n))) +. b *. (exp (beta *. (r -. r'))))
    /. (a +. b)
  let accept_lt n n' r r' =
    let a = Optim_globals.params.meth.gpo.a in
    let b = Optim_globals.params.meth.gpo.b in
    let alpha = Optim_globals.params.meth.gpo.alpha in
    let beta = Optim_globals.params.meth.gpo.beta in
    let n = float n in
    let n' = float n' in
    Random.float 1. <=
    (a *. (exp (alpha *. (n' -. n))) +. b *. (1. -. exp (beta *. (r' -. r))))
    /. (a +. b)

  let converged u u' r r' =
    sqrdist u u' <=
    Optim_globals.params.meth.gpo.eps *. Optim_globals.params.meth.gpo.eps
  (* (r -. r') *. (r -. r') <=
     Optim_globals.params.meth.gpo.eps *. Optim_globals.params.meth.gpo.eps *)

  (* simulate until transition or horizon *)
  let sim step h state input =
    assert (h > 0);
    let rec aux n =
      let rob, t = step state input in
      if t then
        n+1, rob
      else if n < h - 1 then
        aux (n+1)
      else
        n+1, rob
    in aux 0

  let sim_fad step h state input =
    let input_fad = Array.map MyOp.make input in
    Array.iteri (fun i x -> MyOp.diff x i (Array.length input)) input_fad;
    let n, rob_fad = sim step h state input_fad in
    let rob = MyOp.get rob_fad in
    let grad = Array.init (Array.length input) (fun i -> MyOp.d rob_fad i) in
    n, rob, grad

  (*
    node has type float array -D-> float * float array * float option

    rob, grad, trans = step q u where
      - rob is the robustness
      - grad the gradient of rob w.r.t. u
      - trans a boolean true if a transition has been taken
  *)
  let run (Cnode { alloc; step; reset; copy }) max_n max_piece_size =
    let bounds = Optim_globals.params.bounds in

    (* this function needs to be here so that type 's of Cnode does not escape its scope *)
    let optim_step step_params hist =
      let rec step_aux input n rob grad state k hist =
        let state' = alloc () in
        copy step_params.state state';

        let new_input = gd step_params.gd_acc input grad bounds k in

        if is_vverbose () then
          Printf.printf "[Chunk %2d, iteration %6d] \027[2mNew candidate:\027[0m \027[1m%a\027[0m\n"
            step_params.chunk_n k print_float_arr new_input;

        if sqrdist input new_input = 0. then begin
          if is_vverbose () then
            Printf.printf "                             \027[1m\027[31mFound same input twice, moving on.\027[0m\n";
          n, input, state, rob, hist, k
        end else

          let n', rob', grad' =
            sim_fad step
              (min max_piece_size (min (step_params.max_n - step_params.n) n))
              state' new_input
          in

          let new_full_input = append_chunk step_params.cur_prefix (new_input, n') in
          let new_hist = new_full_input :: hist in

          step_params.n_sim_steps <- step_params.n_sim_steps + n';

          if is_vverbose () then begin
            Printf.printf "                             \027[2m%d steps before transition\027[0m\n"
              n';
            Printf.printf "                             \027[33mrob = %g\027[0m \027[2m|\027[0m alpha = %g \027[2m|\027[0m grad = %a\n"
              rob' (GDMethod.alpha 1) print_float_arr grad';
          end;

          let keep_new =
            if n = n'  then
              (* gradient descent algorithm *)
              true
            else if n > n' && rob > rob' then
              (* new chunk is smaller and rob is smaller, we keep new input *)
              true
            else if n > n' && rob <= rob' then
              (* new chunk is smaller but rob is bigger, we may keep new input *)
              accept_gt n n' rob rob'
            else assert false
          in

          if is_vverbose () then
            Printf.printf "                             ==> %s new candidate\027[0m\n"
              (if keep_new then "\027[92mKeeping" else "\027[91mDiscarding");

          (* return
             - n : size of chunk
             - input : selected input
             - state : new state after n steps with input input
             - rob : new rob after n steps with input input
          *)

          if step_params.last_input <> [||] &&
             k >= Optim_globals.params.meth.gpo.gd_miniter &&
             converged
               step_params.last_input new_input
               step_params.last_rob rob' ||
             k >= Optim_globals.params.meth.gpo.gd_maxiter
          then
            begin
              if is_verbose () then
                if k >= Optim_globals.params.meth.gpo.gd_maxiter then
                  Printf.printf "                             \027[1m\027[32mReached %d iterations, moving on.\027[0m\n"
                    k
                else
                  Printf.printf "                             \027[1m\027[32mInputs have converged, moving on.\027[0m\n";
              if keep_new then
                n', new_input, state', rob', new_hist, k
              else
                n, input, state, rob, new_hist, k
            end
          else begin
            step_params.last_input <- new_input;
            step_params.last_rob <- rob';
            if keep_new then begin
              step_aux new_input n' rob' grad' state' (k+1) new_hist
            end else begin
              Optim_globals.params.meth.gd.alpha <- Optim_globals.params.meth.gd.alpha /. 2.;
              step_aux input n rob grad state (k+1) new_hist
            end
          end
      in

      (* tries N random inputs and keeps best candidate *)
      let rec pick_initial_input acc k =
        if k >= Optim_globals.params.meth.gpo.nb_init_samples then
          begin match acc with
          | None -> assert false
          | Some (inp, n, rob, grad, state) -> inp, n, rob, grad, state
          end
        else
          let state = alloc () in
          copy step_params.state state;
          let input = ur_sample bounds in

          let n, rob, grad = sim_fad step (min max_piece_size (step_params.max_n - step_params.n)) state input in
          step_params.n_sim_steps <- step_params.n_sim_steps + n;

          if is_vverbose () then
            Printf.printf "                             (%0.*d/%d) Got rob %g with input %a after %d steps\n"
              (truncate (ceil (log10 (float Optim_globals.params.meth.gpo.nb_init_samples))))
              (k+1) Optim_globals.params.meth.gpo.nb_init_samples
              rob print_float_arr input n;

          let new_acc =
            match acc with
            | Some (inp', n', rob', grad', state) when rob' <= rob ->
              Some (inp', n', rob', grad', state)
            | _ -> Some (input, n, rob, grad, state)
          in
          pick_initial_input new_acc (k+1)
      in

      assert(Optim_globals.params.meth.gpo.nb_init_samples >= 1);

      if is_verbose () then
        Printf.printf "[Chunk %2d, iteration %6d] Looking for initial input\n"
          step_params.chunk_n 0;

      (* run chunk once with random input *)
      let input, n, rob, grad, state = pick_initial_input None 0 in

      if is_verbose () then begin
        Printf.printf "[Chunk %2d, iteration %6d] Chose input: %a\n"
          step_params.chunk_n 0 print_float_arr input;
        Printf.printf "                             %d steps before transition with rob %g and grad %a\n"
          n rob print_float_arr grad;
      end;

      let new_full_input = append_chunk step_params.cur_prefix (input, n) in
      let new_hist = new_full_input :: hist in

      (* optimize chunk *)
      step_aux input n rob grad state 1 new_hist
    in

    let initial_alpha = Optim_globals.params.meth.gd.alpha in
    let rec run_aux step_params hist =
      if step_params.n >= step_params.max_n then
        {
          hist;
          rob = step_params.cur_rob;
          n_chunks = step_params.chunk_n + 1;
          n_sim_steps = step_params.n_sim_steps;
          max_n = step_params.max_n;
        }
      else begin
        if is_verbose () then
          Printf.printf "[Chunk %2d] Starting...\n" step_params.chunk_n;
        let n, input, state, rob, hist, k = optim_step step_params hist in
        if is_verbose () then begin
          Printf.printf "[Chunk %2d] Done after %d optim. steps: input %a for %d sim. steps.\n"
            step_params.chunk_n k print_float_arr input n;
        end;

        (* update inputs for next optim. step *)
        copy state step_params.state;
        step_params.n <- step_params.n + n;
        step_params.chunk_n <- step_params.chunk_n + 1;
        step_params.cur_prefix <- List.hd hist;
        step_params.cur_rob <- rob;
        step_params.last_input <- [||];
        step_params.gd_acc <- GDMethod.create_acc ();
        Optim_globals.params.meth.gd.alpha <- initial_alpha;

        (* optimize next chunk *)
        run_aux step_params hist
      end
    in

    let state = alloc () in reset state;
    run_aux {
      state;
      n = 0;
      max_n;
      max_piece_size;
      gd_acc = GDMethod.create_acc ();
      chunk_n = 0;
      cur_prefix = [];
      cur_rob = infinity;
      n_sim_steps = 0;
      last_input = [||];
      last_rob = infinity;
    } []


  let falsify = run
  let minimize node = assert false

  let get_rob_from_output o = MyOp.get o
end
