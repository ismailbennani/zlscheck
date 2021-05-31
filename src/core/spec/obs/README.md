This folder defines the observers used to compute the robustness. The important modules are:

- discrete_obs.zls:
  This is the discrete version of the observers, these are the synchronous observers defined by Nicolas Halbwachs in his paper and in his book, plus some util methods. But instead of outputing a boolean, they output a robustness (float).
  These are the base blocks used in the examples to write the nodes that compute the robustness.
  The blocks themselves are inspired by the operators of the MITL logic, I implemented the common sub-formulas found in the properties of the models in ARCH. I did not figure out any systematic way to build this basic block, they are the result of a huge amount of trial and error, and small tweaks.
  The main idea is that at each instant, the output of an observer should be computed from the inputs that currently have an impact on its value, in such a way that the gradients of that result are somewhat consistent with the behavior of the property.
  Another important point for me was to write these discrete blocks as closely as possible to their hybrid version, to minimize the differences between these two. That's mainly why I use a lot of automata and the least amount of `pre` possible.
- hybrid_obs.zls:
  This is the hybrid version of the previous module.
  The main problem is that it becomes a lot harder to compute expressions of the form: max for t' in [0, t] of f(t') where t is the current time of the simulation. Its discrete form would look like: let v = 0 -> max (pre max) f.
  The simplest solution I found was to approximate the value of the max by sampling the signals in space (not in time!) and updating the value of the max each time the signal crosses the grid. It is implemented in `acc`:
  - `f` is the function used to compute the new result (`max` or `min` here)
  - `eps` the size of the grid
  - `s` the input signal
    The initial value of `s` is recorded in `cur_f`, each time the distance between `s` and `cur_f` is bigger than `eps`, `cur_f` is updated using `f`. With `min` and `max` this means that the approximation is wrong by at most `eps`.
