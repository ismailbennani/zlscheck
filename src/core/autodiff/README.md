This folder defines several modules used to perform the AD in zélus models. The basic idea is to replace `Pervasives` by `Pervasives_AD` and `float` by `FadBad.OrderedFloat`.

- diff.ml:
  Define the FADLike module used in the examples to turn a model that takes an array of differentiable floats (modules of type OrderedFS) and outputs a differentiable float (robustness) into an easy to use `float array -> float * float array` method.
  `f = run_diff model` can now be used as a score function: it takes an array of floats as input and outputs a score (first element of the tuple) and the derivatives of that float wrt. the inputs (second element of the tuple) computed using the OrderedFS.t values.

- extended_FAD_float.ml:
  I needed some additional values defined by the standard library of ocaml around floats that were not defined by FADBADml over FAD types, e.g. `infinity`, `modf` or `ceil`. This modules is used by `pervasives_ad.ml` to define the `Pervasives` replacements that we use in the models. This is the model that should be extended if we need more primitives like `cosh` or `log`.

- pervasives_ad.ml:
  This module is used as a replacement for `Pervasives`. Instead of using floats, the module uses FadBad.OrderedFloat values.
