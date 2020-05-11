let stop () = print_endline "Assertion failed."; exit 1

let assert_bool b = if not b then stop ()
let assert_int i = assert_bool (i >= 0)
let assert_float f = assert_bool (f >= 0.)

let assert_prop = assert_float
let assert_props l = List.iter assert_prop l

let failwith = failwith
