type t = int

let cnt = ref 0
let get_fresh () = cnt := !cnt + 1; !cnt

let zc_names : (int, string) Hashtbl.t = Hashtbl.create 10
let zc_table : (int, MyOp.t) Hashtbl.t = Hashtbl.create 10

let name uid = Printf.sprintf "%s_%d" (Hashtbl.find zc_names uid) uid
let value uid = Hashtbl.find zc_table uid

let print uid = print_string (name uid)

let ids () =
  (Hashtbl.fold (fun k _ res -> k :: res) zc_table [])
let keys () =
  (Hashtbl.fold (fun k _ res -> (name k) :: res) zc_table [])

let print_names () = print_string (String.concat ", " (keys ()))

let make name =
  let uid = get_fresh () in
  Hashtbl.add zc_names uid name;
  uid

let has_switched = ref false
let last_switch : t option ref = ref None
let switched zc =
  has_switched := true;
  last_switch := Some zc

let did_switch () = !has_switched
let get_last_switch () = !last_switch

let rst () =
  Hashtbl.reset zc_table;
  has_switched := false

let register_zc uid e =
  Hashtbl.replace zc_table uid e
let active uid =
  Hashtbl.mem zc_table uid

let _ = Random.self_init ()
let pick_random () =
  let ids = ids () in
  if ids = [] then None
  else
    let random_i = Random.int (List.length ids) in
    Some (List.nth ids random_i)
