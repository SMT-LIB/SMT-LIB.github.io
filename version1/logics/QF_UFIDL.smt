(logic QF_UFIDL

 :written_by {Cesare Tinelli}
 :date {07/04/05}
 
 :theory Ints

 :language
 "Closed quantifier-free formulas built over an arbitrary expansion with 
  free function and predicate symbols of the following subsignature of Ints:

  :sorts (Int)
  :funs ((1 Int)
         (- Int Int Int)
         (+ Int Int Int) 
        )
  :preds ((<= Int Int)
         (< Int Int)
         (>= Int Int)
         (> Int Int)
        )

  and such that every term headed by + or - is, modulo commutativity, 
  a term of the form (op t 1) where op is + or -, and t is an SMT-LIB term. 
 "
 
 :extensions
 "Modulo commutativity of +, nested increments of the form (+ 1 ... (+ 1 t)) 
  with n occurrences of 1 can be abbreviated as (+ n t).
  Similarly for -.
 "
)


