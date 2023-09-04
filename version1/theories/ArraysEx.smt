(theory ArraysEx

 :written_by {Silvio Ranise and Cesare Tinelli}
 :date {08/04/05}
 :updated {28/10/05}
 :history {
  Bug fix in the third axiom, pointed out by Robert Nieuwenhuis:
  The scope of 'forall (?i Index)' was the whole implication
  instead of just the premise of the implication.
  }

 :sorts (Index Element Array)

 :funs ((select Array Index Element) (store Array Index Element Array))

 :definition 
 "This is a theory of functional arrays with extensionality.
  It is formally and completely defined by the axioms below.
 "

 :axioms 
 (
  (forall (?a Array) (?i Index) (?e Element)
     (= (select (store ?a ?i ?e) ?i) ?e))
  (forall (?a Array) (?i Index) (?j Index) (?e Element) 
     (or (= ?i ?j) 
         (= (select (store ?a ?i ?e) ?j)
            (select ?a ?j))))
  (forall (?a Array) (?b Array)
     (implies (forall (?i Index) (= (select ?a ?i) (select ?b ?i)))
              (= ?a ?b)))
 )

 :notes 
 "This theory extends the theory Arrays with an axiom stating that
  any two arrays with the same elements are in fact the same array.
 "    
)


