(logic AUFLIRA

:written_by {Cesare Tinelli and Clark Barrett}
:date {15/05/2006}

:theory Int_Int_Real_Array_ArraysEx

:language
 "Closed formulas built over an arbitrary expansion of the
  Int_Int_Real_Array_ArraysEx signature with free function and
  predicate symbols but containing only linear atoms, that is,
  atoms with no occurrences of the function symbol * (see, 
  however, the extensions below).

  Formulas in ite terms must satisfy the same restriction, with the
  exception that they need not be closed.
 "

:extensions
 "As in the logic QF_LIA and QF_LRA, with the difference that 
  numerals for real numbers must end with .0 (as in 5.0).
 "
)