(theory Arrays

 :written_by {Silvio Ranise and Cesare Tinelli}
 :date {08/04/05}
 
 :sorts (Index Element Array)

 :funs ((select Array Index Element) (store Array Index Element Array))

 :definition 
 "This is a theory of functional arrays without extensionality.
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
 )

 :notes 
 "It is not difficult to prove that the two axioms above are logically 
  equivalent to the following \"McCarthy axiom\":

          (forall (?a Array) (?i Index) (?j Index) (?e Element) 
           (= (select (store ?a ?i ?e) ?j)
              (ite (= ?i ?j) ?e (select ?a ?j))))

  Such an axiom appeared in the following paper:
  Correctness of a Compiler for Arithmetic Expressions,
  by John McCarthy and James Painter,
  available at http://www-formal.stanford.edu/jmc/mcpain.html.
 "    
)


