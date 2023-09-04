(logic QF_NIA

 :written_by {Cesare Tinelli}
 :date {26/06/09}
 
 :theory Ints

 :language 
 "Closed quantifier-free formulas built over an arbitrary expansion of 
  the Ints signature with free constant symbols, containing one or more
  non-linear atoms, that is, atoms with terms of the form (* x y) where
  neither x nor y is a numeral.

  Formulas in ite terms must satisfy the same restriction as well,
  with the exception that they need not be closed.
 "
 :extensions
 "In addition to 0 and 1, numerals n > 1 are allowed also as arguments of
  predicate or function symbols. In that case, they abbreviate the term
  (+ 1 ... 1) with n occurrences of 1.
 "
)


