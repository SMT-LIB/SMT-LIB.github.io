(logic QF_LIA

 :written_by {Cesare Tinelli}
 :date {08/04/05}
 
 :theory Ints

 :language 
 "Closed quantifier-free formulas built over an arbitrary expansion of 
  the Ints signature with free constant symbols, but containing only
  linear atoms, that is, atoms with no occurrences of the function
  symbol * (but see the notational conventions below).

  Formulas in ite terms must satisfy the same restriction as well,
  with the exception that they need not be closed.
 "
 :extensions
 "The syntax (+ t_1 ... t_n) with n>2 is allowed as an abbreviation
  of the term (+ t_1 (+ t_2 (+ t_3 ... ))). 
 "
 :extensions
 "Terms with positive integer coefficients are allowed, that is,
  expressions of the form (* n t) or (* t n) for some numeral n, both of
  which abbreviate the term (+ t ... t) having n occurrences of t.
 "
 :extensions
 "Terms with negative integer coefficients are also allowed, that is,
  expressions of the form (* (~ n) t) or (* t (~ n)) for some numeral n,
  both of which abbreviate the term (~ (* n t)).
 "
 :extensions
 "In addition to 0 and 1, numerals n > 1 are allowed also as arguments of
  atoms or of +. In that case, they abbreviate the term (+ 1 ... 1) with
  n occurrences of 1.
 "
)


