(logic QF_IDL

 :written_by {Cesare Tinelli}
 :date {07/04/05}
 :last_modified {30/05/05}

 :theory Ints

 :language
 "Closed quantifier-free formulas with atoms of the form:
  - <fvar>   (see SMT-LIB concrete syntax)
  - (op (- x y) c),
  - (op (- x y) (~ c)),
  - (op x y), or
  where
    - op is <, <=, >, >=, =, or distinct
    - x, y are free constant symbols, 
    - c is 0, 1, or a term of the form (+ 1 ... (+ 1 1)) with n>1 ones. 
 "
 :extensions
 "Sums (+ 1 ... (+ 1 1)) of n ones can be abbreviated by the numeral n. 
  For instance, (+ 1 (+ 1 1)) can be abbreviated by 3.
 "
)


