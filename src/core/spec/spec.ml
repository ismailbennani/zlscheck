(* Aliases for the code in this folder *)

module Stl = Stl

module Check(FormulaType : Check.OfflineFormulaType) =
  Check.Check(FormulaType)
module Monitor(FormulaType : Monitor.OnlineFormulaType) =
  Monitor.Monitor(FormulaType)

(* Common monitors and checkers *)

module CheckStl = Check(Stl)
