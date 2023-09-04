(logic QF_UFBV

:written_by {Clark Barrett}
:date {May 7, 2007}

:theory Fixed_Size_BitVectors

:language
 "Closed quantifier-free formulas built over an arbitrary expansion of the
  Fixed_Size_BitVectors signature with free function and predicate symbols over
  the sorts BitVec[m] for 0 < m.  Formulas in ite terms must satisfy the same
  restriction as well, with the exception that they need not be closed (because
  they may be in the scope of a let expression).
 "

:extensions
 "As in the logic QF_BV."
)

