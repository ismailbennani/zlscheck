open Ztypes
open Common_types

module Runtime = Zlsrungtk.MakeDiscrete ()

let rec find_index_in_sorted_array times t hint =
  if (times.(hint) <= t && hint < Array.length times - 1 && times.(hint+ 1) > t) ||
     (times.(hint) <= t && hint = Array.length times - 1) ||
     (hint = 0 && times.(hint) > t) then hint
  else if times.(hint) > t then find_index_in_sorted_array times t (hint - 1)
  else if times.(hint) < t then find_index_in_sorted_array times t (hint + 1)
  else begin
    (* should not happen *)
    Printf.printf "t = %g\n" t;
    Printf.printf "hint = %d\n" hint;
    Printf.printf "times[hint-1] = %g\n" (if hint > 0 then times.(hint-1) else -1.);
    Printf.printf "times[hint] = %g\n" times.(hint);
    Printf.printf "times[hint+1] = %g\n" (if hint < Array.length times - 1 then times.(hint+1) else -1.);
    flush stdout;
    assert false
  end

let interp_i = ref 0
let interp times cp =
  fun t ->
    interp_i := find_index_in_sorted_array times t !interp_i;
    cp.(!interp_i)

module Make (Replay : Replay) =
struct

  let name = "replay " ^ Replay.name

  let read_dump dump_file =
    let dump_fd = open_in dump_file in

    let n_lines = ref 0 in
    begin try
        while true do
          n_lines := !n_lines + 1;
          ignore(input_line dump_fd);
        done
      with End_of_file -> ()
    end;

    seek_in dump_fd 0;

    let dump_ib = Scanf.Scanning.from_channel dump_fd in
    let time = Array.make !n_lines 42. in
    let inps = Array.make !n_lines [||] in

    let i = ref 0 in
    begin try
        while true do
          Scanf.bscanf dump_ib "%g,%r\n"
            Replay.scan_dump_inp
            (fun t (inp : MyOp.t array) ->
               time.(!i) <- t; inps.(!i) <- inp);
          i := !i + 1
        done
      with
      | End_of_file ->
        Printf.printf "Trace size: %d\n" !i; flush stdout;
        close_in dump_fd
      | e ->
        Printf.printf "Cannot open file %s: %s\n" dump_file (Printexc.to_string e);
        close_in_noerr dump_fd
    end;

    time, inps

  let wrap (Node { alloc; step; reset }) inp_cp =
    let step mem () = step mem inp_cp
    in Node { alloc; step; reset }

  let run dump_file =
    Printf.printf "Reading %s..\n" dump_file;

    let inp_cp = read_dump dump_file in

    Printf.printf "Running simulation\n";

    (* simulation (discrete) function *)
    let main =
      let Node { alloc = alloc; step = step; reset = reset } =
        wrap Replay.replay_node inp_cp in
      let mem = alloc () in reset mem; fun _ -> step mem ()
    in Runtime.go 1.000000 main

end
