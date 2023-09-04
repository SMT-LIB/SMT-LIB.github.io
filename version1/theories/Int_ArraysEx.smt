(theory Int_ArraysEx

 :written_by {Cesare Tinelli}
 :date {12/04/05}
 :updated {30/01/09}
 :history {
  30/01/09 removed erroneous :assoc attribute for binary minus
  }

 :sorts (Int Array)
 
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
        (select Array Int Int)
        (store Array Int Int Array)
       )
 :preds ((<= Int Int :refl :trans :antisym)
         (< Int Int :trans :irref)
         (>= Int Int :refl :trans :antisym)
         (> Int Int :trans :irref)
        )

 :definition 
 "This is a theory of functional arrays with extensionality with integer
  indeces and elements.
  It can be formally defined as the union of the SMT-LIB theory Int and
  the variant of the SMT-LIB theory ArraysEx under the signature morphism
  that maps both the sorts Index and Element of ArraysEx to the sort Int,
  and leaves every other symbol unchanged.
 "
 :notes
 "If for i=1,2, T_i is an SMT-LIB theory with sorts S_i, function symbols F_i,
  predicate symbols P_i, and axioms A_i, by \"union\" of T_1 and T_2 
  we mean the theory T with sorts S_1 U S_2, function symbols F_1 U F_2,
  predicate symbols P_1 U P_2, and axioms A_1 U A_2 (where U stands for set
  theoretic union).
  The theory T is a well-defined SMT-LIB theory whenever S_1, S_2, F_1, F_2, 
  P_1, P_2 are all pairwise disjoin, as is the case for the component theories
  considered here. 
"
)


