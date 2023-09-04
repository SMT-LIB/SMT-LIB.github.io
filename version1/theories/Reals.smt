(theory Reals

 :aliases {Real Closed Fields}

 :written_by {Cesare Tinelli}
 :date {08/04/05}
 :updated {30/01/09}
 :history {
  30/01/09 removed erroneous :assoc attribute for binary minus
  }

 :references {
  1) W. Hodges. Model theory. Cambridge University Press, 1993.
  2) PlanetMath, http://planetmath.org/encyclopedia/RealClosedFields.html
 }
 
 :sorts (Real)

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
 :funs ((0 Real) 
        (1 Real)
        (~ Real Real)      ; unary minus
        (- Real Real Real) ; binary minus
        (+ Real Real Real :assoc :comm :unit {0}) 
        (* Real Real Real :assoc :comm :unit {1})
       )

 :preds ((<= Real Real :refl :trans :antisym)
         (< Real Real :trans :irref)
         (>= Real Real :refl :trans :antisym)
         (> Real Real :trans :irref)
        )

 :definition 
 "The standard first-order theory of real numbers, but with no overloading
  of the minus symbols.
  This is the set of all the first-order sentences over the given signature
  that are true in the structure of the real numbers that interprets the 
  signature's symbols in the obvious way.

  This theory coincides with the theory of real closed fields, axiomatized
  by the sentences in the :axioms field, plus the two axioms schemas also
  listed, but in comments, in the same field.
  "
 :axioms (
          ; associativity of +
          (forall (?x Real) (?y Real) (?z Real)
           (= (+ (+ ?x ?y) ?z) (+ ?x (+ ?y ?z))))

          ; commutativity of +
          (forall (?x Real) (?y Real)
           (= (* ?x ?y) (* ?y ?x)))

          ; 0 is the right (and by commutativity, left) unit of +
          (forall (?x Real) (= (+ ?x 0) ?x))

          ; right (and left) inverse wrt +
          (forall (?x Real) (= (+ ?x (~ ?x)) 0))

          ; associativity of *
          (forall (?x Real) (?y Real) (?z Real)
           (= (* (* ?x ?y) ?z) (* ?x (* ?y ?z))))

          ; commutativity of *
          (forall (?x Real) (?y Real) (= (* ?x ?y) (* ?y ?x)))

          ; 1 is the right (and by commutativity, left) unit of *
          (forall (?x Real) (= (* ?x 1) ?x))

          ; existence of right (and left) inverse wrt *
          (forall (?x Real)
           (or (= ?x 0) (exists (?y Real) (= (* ?x ?y) 1))))

          ; left distributivity of * over +
          (forall (?x Real) (?y Real) (?z Real)
           (= (* ?x (+ ?y ?z)) (+ (* ?x ?y) (* ?x ?z))))

          ; right distributivity of * over +
          (forall (?x Real) (?y Real) (?z Real)
           (= (* (+ ?x ?y) ?z) (+ (* ?x ?z) (* ?y ?z))))

         ; non-triviality
          (distinct 0 1)

         ; all positive elements have a square root
          (forall (?x Real)
           (exists (?y Real) (or (= ?x (* ?y ?y)) (= (~ ?x) (* ?y ?y)))))

         ; axiom schemas for all n > 0
         ; (forall (?x_1 Real) ... (?x_n Real)
         ;   (distinct (+ (* ?x_1 ?x_1) (+ ... (* ?x_n ?x_n)))
         ;             (~ 1))) 

         ; axiom schemas for all odd n > 0 where
         ; (^ y n) abbreviates the n-fold product of y with itself
         ;  (forall (?x_1 Real) ... (?x_n Real)
         ;   (exists (?y Real)
         ;   (= 0
         ;      (+ (^ ?y n) (+ (* ?x_1 (^ ?y n-1)) (+  ... (+ (* ?x_{n-1} ?y) ?x_n)))))))

         ; reflexivity of <=
         (forall (?x Real) (<= ?x ?x))

         ; antisymmetry of <=
         (forall (?x Real) (?y Real)
          (implies (and (<= ?x ?y) (<= ?y ?x))
                   (= ?x ?y)))

         ; transitivity of <=
         (forall (?x Real) (?y Real) (?z Real)
          (implies (and (<= ?x ?y) (<= ?y ?z))
                   (<= ?x ?z)))

         ; totality of <=
         (forall (?x Real) (?y Real)
          (or (<= ?x ?y) (<= ?y ?x)))
    
         ; monotonicity of <= wrt +
         (forall (?x Real) (?y Real) (?z Real)
          (implies (<= ?x ?y) (<= (+ ?x ?z) (+ ?y ?z))))

         ; monotonicity of <= wrt *
         (forall (?x Real) (?y Real) (?z Real)
          (implies (and (<= ?x ?y) (<= 0 ?z))
                   (<= (* ?z ?x) (* ?z ?y))))

         ; definition of binary minus
         (forall (?x Real) (?y Real) (= (- ?x ?y) (+ ?x (~ ?y))))

         ; definition of <
         (forall (?x Real) (?y Real) 
          (iff (< ?x ?y)
               (and (<= ?x ?y) (distinct ?x ?y)))
         )

         ; definition of >=
         (forall (?x Real) (?y Real) 
          (iff (>= ?x ?y)
               (<= ?y ?x))
         )

         ; definition of >
         (forall (?x Real) (?y Real) 
          (iff (> ?x ?y)
               (< ?y ?x))
         )
 ) 
)

