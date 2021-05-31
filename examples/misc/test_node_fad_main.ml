(* simulation (discrete) function *)
let main =
  let open Ztypes in
  let Node { alloc = alloc; step = step; reset = reset } = Test_node_fad.main in
  let mem = alloc () in
  reset mem;
  (fun x -> step mem x);;
(* (discrete) simulation loop *)
while true do main () done;
exit(0);;
