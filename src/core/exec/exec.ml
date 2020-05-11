open Ztypes

module Run =
struct
  module type Discrete =
  sig
    val run : (unit, 'a) node -> 'a
  end
  module type Hybrid =
  sig
    val run : (cstate -> ((time * unit), 'a) node) -> 'a
  end
end
