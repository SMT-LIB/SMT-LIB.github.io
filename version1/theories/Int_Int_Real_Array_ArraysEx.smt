(theory Int_Int_Real_Array_ArraysEx

ArrayIntArrayIntReal

 :written_by {Cesare Tinelli and Clark Barrett}
 :date {15/05/06}

 :sorts (Int Real Array1 Array2)

 :funs ((0 Int)
        (1 Int)
        (- Int Int)     ; unary minus
        (- Int Int Int) ; binary minus
        (+ Int Int Int)
        (* Int Int Int)
       )

 :preds ((<= Int Int)
         (< Int Int)
         (>= Int Int)
         (> Int Int)
        )

 :funs ((0.0 Real)   ; requires extending SMT-LIB grammar
        (1.0 Real)   ; requires extending SMT-LIB grammar
        (- Real Real)      ; unary minus
        (- Real Real Real) ; binary minus
        (+ Real Real Real)
        (* Real Real Real)
       )

 :preds ((<= Real Real)
         (< Real Real)
         (>= Real Real)
         (> Real Real)
        )

 :funs ((select Array1 Int Real)
        (store Array1 Int Real Array1)

        (select Array2 Int Array1)
        (store Array2 Int Array1 Array2)
       )


 :definition
 "This is a theory of functional arrays (with extensionality) with sort
  name Array1, integer indices and real elements, plus arrays with sort
  name Array2, integer indices and Array1 elements.
  It can be formally defined as the union of the following variants of
  the SMT-LIB theories Int and ArraysEx produced by these signature
  morphisms:

  - the trivial variant of Int produced by the identity morphism;

  - the variant of Real produced by the morphism mapping
    0 to 0.0 and 1 to 1.0, and every other symbol to itself;

  - the variant of ArraysEx produced by the morphism mapping
    Index to Int, Element to Real, and every other symbol to itself;

  - the variant of ArraysEx under the morphism mapping
    Index to Int, Element to Array, and every other symbol to itself;
"
)
