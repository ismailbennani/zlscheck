open Ztypes

module type OptimS = Optim.S with type input = float array
                              and type output = float * float array

module type RunBench =
sig
  include Deftypes.SUT
  module Optim : OptimS
  module Logger : Logger.S
  val optim_params_of_array : float array -> Optim.optim_params
  val string_of_params : Optim.optim_params Optim_types.params -> string
  val print_optim_params : out_channel -> Optim.optim_params Optim_types.params -> unit
  val run : Logger.params -> Optim.optim_params Optim_types.params -> float array Deftypes.one_repet_result
end
