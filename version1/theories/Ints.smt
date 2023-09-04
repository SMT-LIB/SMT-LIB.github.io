(theory Ints

 :written_by {Cesare Tinelli}
 :date {08/04/05}
 :updated {30/01/09}
 :history {
  30/01/09 removed erroneous :assoc attribute for binary minus
  28/10/09 Slight changes to the ':notes' attribute
  }

 :sorts (Int)

 :notes 
 "The (unsupported) annotations of the function/predicate symbols have
  the following meaning: 
  
  attribute | possible value | meaning 
  -------------------------------------------------------
  :assoc           //          the symbol is associative
  :comm            //          the symbol is commutative
  :unit       a constant c     c is the symbol's left and right unit
  :trans           //          the symbol is transitive
  :refl            //          the symbol is reflexive
  :irref           //          the symbol is irreflexive
  :antisym         //          the symbol is antisymmetric
 "
 :funs ((0 Int) 
        (1 Int)
        (~ Int Int)     ; unary minus
        (- Int Int Int) ; binary minus
        (+ Int Int Int :assoc :comm :unit {0}) 
        (* Int Int Int :assoc :comm :unit {1})
       )

 :preds ((<= Int Int :refl :trans :antisym)
         (< Int Int :trans :irref)
         (>= Int Int :refl :trans :antisym)
         (> Int Int :trans :irref)
        )

 :definition 
 "This is the first-order theory of the integers, that is, the set of all
  the first-order sentences over the given signature that are true in the
  structure of the integer numbers interpreting the signature's symbols
  in the obvious way (with ~ denoting the negation and - the subtraction
  functions).
 "
 :notes
 "Note that this theory is not (recursively) axiomatizable in a first-order 
  logic such as SMT-LIB's underlying logic. 
  That is why the theory is defined semantically.
 "
 )

