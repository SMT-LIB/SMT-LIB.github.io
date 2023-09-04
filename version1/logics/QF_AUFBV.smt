(logic QF_AUFBV

 :written_by {Clark Barrett}
 :date {07/05/07}
 :updated {14/08/09}
 :history {
  Changed incorrect theory name "BV_ArraysEx". 
 }

 :theory BitVector_ArraysEx

 :language 
 "Closed quantifier-free formulas built over an arbitrary expansion of the
  BitVector_ArraysEx signature with free function and predicate symbols over
  the sorts of BitVector_ArraysEx. Formulas in ite terms must satisfy the same
  restriction as well, with the exception that they need not be closed (because
  they may be in the scope of a let expression).
 "
 :extensions
 "As in the logic QF_BV."
)


