This folder defines optimization algorithms used to find counter examples during the falsification.

- optim\*.ml
  These modules define generic methods that perform optimization on a score function `fn : input -> output` using an optimization algorithm defined in `OptimAlg` that performs an optimization step. All the logic is implemented in OptimAlg.
  The code in these optim\* modules are all the common parts of the optimization process, such as computing a history of all the input/outputs computed by the
  optimization algorithm, or computing the best candidate so far, etc..

- uniformRandom.ml uniformRandom_gdaware.ml:
  The simplest optimization algorithm: pick each input at random. Start by reading this to understand how the optimization is done.
  Each optimization module defines:

  - `type input`: type of inputs of the score function
  - `type output`: type of outputs of the score function
  - `type optim_step_params`: type of parameters used by the optimization algorithms.
  - `get_rob_from_output`: a method that extracts the robustness value as a float from the output of the algorithm. This is useful because the output of the score function can carry more information than the robustness itself (such as its gradients).
  - `step` function that takes as inputs:
    - `step_params: ('a, 'b) Optim_types.step_params`: a bunch of generic parameters from the optimization itself + specific params of type `optim_step_params`. In the case of uniform random, `type optim_step_params = unit` because we don't need any parameter.
    - `incr_runs`: a callback used to increment the number of simulations counter defined by Optim. This is a bit dirty but I didn't want to force the optimization algorithms to only perform one simulation per step, so I had to provide them a way to count the number of simulations that they performed. This can probably be done in a better way.
    - `fn`: the score function. This takes an `input` and outputs an `output`.
      The difference between `UniformRandom` and `UniformRandom_gdaware` is that the score function outputs a `float` in the former, and a `float * float array` in the latter (robustness + gradient). This optimization algorithm doesn't use the gradients anyway but I needed this version to use UR optimization on models that do return their gradients.

- simulatedAnnealing.ml simulatedAnnealing_gdaware.ml:
  There are two versions of this for the same reason than UniformRandom. This optimization algorithm is one of the first that was implemented in S-Taliro, I implemented it to check that my results made sense by comparing them to those of S-Taliro.

- adaptativeGradient.ml:
  There is only one version of this optimization algorithm because it needs the gradients to work. These algorithms are based on the paper
  On the convergence of adam and beyond
  SJ Reddi, S Kale, S Kumar - arXiv preprint arXiv:1904.09237
  This module defines a generic gradient-based optimization functor. The various methods are then defined in their own modules (ClassicMethod, ADAGRADMethod, ...).

- distribution.ml particles.ml: wip, never finalized
