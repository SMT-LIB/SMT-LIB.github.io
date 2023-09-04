(logic UFNIA

 :written_by {Cesare Tinelli}
 :date {26/06/09}
 
 :theory Ints

 :language 
 "Closed formulas built over an arbitrary expansion of the Ints signature
  with free sort, function, and/or predicate symbol, containing one or 
  more non-linear atoms, that is, atoms with terms of the form
  (* x y) where neither x nor y is a numeral.
 "
 :extensions
 "In addition to 0 and 1, numerals n > 1 are allowed also as arguments of
  predicate or function symbols. In that case, they abbreviate the term
  (+ 1 ... 1) with n occurrences of 1.
 "
)


