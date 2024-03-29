(logic QF_UF

 :written_by {Cesare Tinelli}
 :date {08/04/05}
 
 :theory Empty

 :language 
 "Closed quantifier-free formulas built over an arbitrary expansion of
  the empty signature with free sort, function and predicate symbols.

  Note that the formulas can contain term (resp., formula) variables 
  as long as they are bound by a let (resp., flet) construct.
  Also, formulas in ite terms must be themselves quantifier-free.

  More formally, the language consists of the well-sorted closed formulas
  generated by the grammar obtained by replacing the rule for <an_formula>
  in the SMT-LIB concrete grammar with the rule:

  <an_formula> ::= <an_atom>
                |  ( <connective <an_formula>+ <annotation>* )
                |  ( let ( <var> <an_term> ) <an_formula>+ <annotation>* )
                |  ( flet ( <fvar> <an_formula> ) <an_formula>+ <annotation>* )

 "
 :notes
 "Since the theory Empty has just one symbol, the sort symbol U, all additional
  sort, function and predicate symbols used in benchmarks for this logic must
  be declared in the benchmarks themselves.
 "
)


