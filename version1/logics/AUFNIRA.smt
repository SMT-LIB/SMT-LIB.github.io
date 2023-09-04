(logic AUFNIRA

:written_by {Cesare Tinelli and Clark Barrett}
:date {28/06/2006}

:theory Int_Int_Real_Array_ArraysEx

:language
 "Closed formulas built over an arbitrary expansion of the
  Int_Int_Real_Array_ArraysEx signature with free function and
  predicate symbols.

  Formulas in ite terms need not be closed.
 "

 :extensions
 "The syntax (+ t_1 ... t_n) with n>2 is allowed as an abbreviation
  of the term (+ t_1 (+ t_2 (+ t_3 ... ))).  Similarly for *.
 "

 :extensions
 "In addition to 0 and 1, integer numerals n > 1 are allowed.  They abbreviate
  the term (+ 1 ... 1) with n occurrences of 1.  Similarly for real numerals
  with the difference that real numberals must end with .0 (as in 5.0).
 "
)
