module Syntax = Stl_syntax
module Semantic = Stl_semantic

module Type = struct
  type t = Syntax.f
  type trace = (float * float Semantic.EnvMap.t) array
  type result = float

  let eval = Semantic.eval

  let print_t = Syntax.print
  let print_trace ff t =

    let print_envmap ff envmap =
      Format.fprintf ff "{@,@[<hov 2>%a@]@,}"
        (fun ff map ->
           Semantic.EnvMap.iter
             (fun key value -> Format.fprintf ff "%s: %.2e;@ " key value)
             map)
        envmap
    in

    Format.fprintf ff "[|%a|]"
      (fun ff a ->
         Array.iter
           (fun (t, map) ->
              Format.fprintf ff "At t=%.2e:@.@[<hov 2>%a@]@."
                t print_envmap map)
         a)
      t
  let print_result ff r = Format.fprintf ff "%.2f" r
end
