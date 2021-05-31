This folder defines modules that are used to run the simulation. It provides methods to sample any hybrid model and get a trace out of it.

- execPeriodic.ml:
  It defines a `sample` method that takes a model as input (as a Ztypes.Hsim value) and simulates it using `SSolver`.
  It defines an `offset`, a `period` and a `max_time` values that are used to determine the minimal set of times at which we want to read the values output by the model.
  The module `Fun : PeriodicFun` defines a method that constructs the final output returned by sample using the values returned by the solver during the simulation.
  This module is used in `horizon.ml` and in `sample.ml`

- horizon.ml:
  This module defines simulation methods that only retrieve the last value of the simulation. It is useful in offline falsification methods where we only care about the last robustness computed by the model. It has a `Hybrid` and a `Discrete` modules that perform the simulation either on hybrid (Ztypes.Hsim, using ExecPeriodic) or on discrete (Ztypes.Node) models.

- sample.ml:
  This module defines simulation methods that create an array of all the values returned by the solver during the simulation.

- myZls.ml:
  This module re-defines the Zls module found in Zélus, with any arithmetic type (not necessarily float).
