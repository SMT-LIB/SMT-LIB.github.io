(theory Reals_Int

 :written_by {Cesare Tinelli}
 :date {08/04/05} 
 :updated {30/01/09}
 :history {
  30/01/09 removed erroneous :assoc attribute for binary minus
  }

 :sorts (Real)

 :notes 
 "The (unsupported) annotations of the function/predicate symbols have
  the following meaning: 
  
  attribute | possible value | meaning 
  -------------------------------------------------------
  :assoc           //          the symbol is associative
  :comm            //          the symbol is commutative
  :iden       a constant c     c is the symbol left and right unit
  :trans           //          the symbol is transitive
  :refl            //          the symbol is reflexive
  :irref           //          the symbol is irreflexive
  :antisym         //          the symbol is antisymmetric
 "
 :funs ((0 Real) 
        (1 Real)
        (~ Real Real)      ; unary minus
        (- Real Real Real) ; binary minus
        (+ Real Real Real :assoc :comm :unit {0}) 
        (* Real Real Real :assoc :comm :unit {1})
       )

 :preds ((<= Real Real :refl :trans :antisym)
         (< Real Real :trans :irref)
         (IsInt Real)
        )

 :definition 
 "This theory extends the theory Reals with an IsInt predicate symbol.
  More precisely, this is the first-order theory of the real numbers structure
  that interprets the (IsInt _) predicate as the unary relation coiciding with 
  the set of all the integer numbers.
 "
 :notes
 "Note that this theory is not (recursively) axiomatizable in a first-order logic such
  as SMT-LIB's underlying logic (this is simply because the integers are not first-order
  axiomatizable).
 "
 )

