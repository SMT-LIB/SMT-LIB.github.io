(logic QF_UFNRA

 :written_by {Cesare Tinelli}
 :date {26/06/09}
] 
 :theory Reals

 :language
 "Closed quantifier-free formulas built over an arbitrary expansion of 
  the Reals signature with free sort, function, and/or predicate symbols 
  containing one or more non-linear atoms, that is, atoms with terms of
  the form (* x y) where neither x nor y is a numeral.

  Formulas in ite terms must satisfy the same restriction, with the 
  exception that they need not be closed.
 "
 :extensions
 "In addition to 0 and 1, numerals n > 1 are allowed also as arguments of
  predicate or function symbols. In that case, they abbreviate the term
  (+ 1 ... 1) with n occurrences of 1.
 "
 :extensions
 "Also allowed are rational coefficients: expressions of the form:
  (/ m n) where n is a numeral other than 0 and m is either a numeral
  or an expression of the form (~ i) for some numeral i, 

  An atom with rational coefficients is syntactic sugar for any equivalent
  atom with integer coefficients obtained by applying standard arithmetic
  transformations.
 ")


