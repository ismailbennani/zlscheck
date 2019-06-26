let global : (string, float) Hashtbl.t = Hashtbl.create 16

let set_global s v = Hashtbl.add global s v
let get_global s = Hashtbl.find global s
