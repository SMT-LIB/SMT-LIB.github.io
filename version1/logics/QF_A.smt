(logic QF_A

 :written_by {Silvio Ranise and Cesare Tinelli}
 :date {08/04/05}
 :updated {01/05/07}

 :history {
   Bug fix in the :notes field below, pointed out by Albert Oliveras.
 }

 :theory Arrays

 :language 
 "Closed quantifier-free formulas built over an arbitrary expansion of
  the Arrays signature with free constant symbols.

  Note that the formulas can contain term (resp., formula) variables 
  as long as they are bound by a let (resp., flet) construct.
  Also, formulas in ite terms must be themselves quantifier-free.
 "
 :notes
 "If F is a formula in the language it is possible to pre-process F
  so that F is satisfiable in the theory Arrays iff the resulting
  formula F' is satisfiable in the theory Empty.
  The pre-processing step goes as follows: conjoin to the formula F,
  all formulas of the form

    (= (select (store t_a t_i t_e) t_j)
       (ite (= t_i t_j) t_e (read t_a t_j)))

  for all terms t_a of sort Array, all terms t_e of sort Element, and
  pairs of terms t_i, t_j of sort Index occurring in F.
  This is far from being efficient since it may generate a lot of
  possibly useless instances. But it suggests the key intuition
  underlying the theory of arrays, i.e., the semantics of select and
  store encapsulate case-splitting.
 "
)


