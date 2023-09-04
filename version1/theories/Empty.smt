(theory Empty

 :written_by {Cesare Tinelli}
 :date {08/04/05}
 
 :sorts (U)

 :definition
 "This theory has no axioms and a signature consisting of the sort U."

 :notes
 "Since SMT-LIB's underlying logic is a logic with equality, this theory
  in effect corresponds to the so called theory of equality over uninterpreted
  symbols. That is, a formula over arbitrary sort, function and predicate symbols
  is satisfiable in Empty iff it is consistent with the properties of equality
  (reflexivity, symmetry, transitivity, and substitutivity).
 "
)


