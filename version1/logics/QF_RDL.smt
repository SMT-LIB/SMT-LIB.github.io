(logic QF_RDL

 :written_by {Cesare Tinelli}
 :date {08/04/05}
 :last_modified {30/05/05}

 :theory Reals

 :language 
 "Closed quantifier-free formulas with atoms of the form:
  - <fvar>   (see SMT-LIB concrete syntax)
  - (op (- x y) c),
  - (op (- x y) (~ c)),
  - (op x y),
  - (op (- (+ x ... x) (+ y ... y)) c) with n>0 occurrences of x and y,
  - (op (- (+ x ... x) (+ y ... y)) (~ c)) with n>0 occurrences of x and y
  where
    - op is <, <=, >, >=, =, or distinct
    - x, y are free constant symbols, 
    - c is 0, 1, or a term of the form (+ 1 ... (+ 1 1)) with n>1 ones. 
  "
 :extensions
 "Sums (+ 1 ... (+ 1 1)) of n ones can be abbreviated by the numeral n. 
  For instance, (+ 1 (+ 1 1)) can be abbreviated by 3.
 "
 :extensions
 "The expression (op (- x y) (/ c n)) where n is a numeral other than 0 and
  c is either a numeral or an expression of the form (~ m) for some numeral m, 
  abbreviates the expression
  (op (- (+ x ... x) (+ y ... y)) m) with n occurrences of x and y.
 "
)


