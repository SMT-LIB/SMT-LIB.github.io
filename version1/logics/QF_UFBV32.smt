(logic QF_UFBV[32]

:written_by {Silvio Ranise, Cesare Tinelli, and Clark Barrett}
:date {10/07/2006}

:theory Fixed_Size_BitVectors[32]

:language
 "Closed quantifier-free formulas built over an arbitrary expansion
  of the Fixed_Size_BitVectors[32] signature with free function and
  predicate symbols over the sorts BitVec[m] for 0 < m <= 32.
  Formulas in ite terms must satisfy the same restriction as well,
  with the exception that they need not be closed (because they may
  be in the scope of a let expression).
 "

:extensions
 "Below, let |exp| denote the integer resulting from the evaluation
  of the arithmetic expression exp.

  - bit0 abbreviates (extract[0:0] bv0)
  - bit1 abbreviates (extract[0:0] bv1)

  - the string bv followed by the numeral n (as in bv13) abbreviates
    any term t of sort BitVec[32] built out only of the symbols in
    {concat, bit0, bit1} such that

    [[t]] = nat2bv[32](n) for n=0, ..., 2^32 - 1.

    See the specification of the theory's semantics for a definition
    of the functions [[_]] and nat2bv.
    Note that this convention implicitly considers the numeral n as a
    number written in base 10.

  - (bvnand s t) abbreviates (bvnot (bvand s t))
  - (bvnor s t) abbreviates (bvnot (bvor s t))

  For all terms s,t of sort BitVec[m], where 1 <= m <= 32
  - (bvslt s t) abbreviates:
      (or (and (= (extract[|m-1|:|m-1|] s) bit1)
               (= (extract[|m-1|:|m-1|] t) bit0))
          (and (= (extract[|m-1|:|m-1|] s) (extract[|m-1|:|m-1|] t))
               (bvlt s t)))
  - (bvsleq s t) abbreviates:
      (or (and (= (extract[|m-1|:|m-1|] s) bit1)
               (= (extract[|m-1|:|m-1|] t) bit0))
          (and (= (extract[|m-1|:|m-1|] s) (extract[|m-1|:|m-1|] t))
               (bvleq s t)))
  - (bvsgt s t) abbreviates (bvslt t s)
  - (bvsgeq s t) abbreviates (bvsleq t s)

  For all numerals j > 1 and 1 <= m <= 32, and all terms of s and t of
  sort BitVec[m],

  - (shift_left0 t 0) stands for t
  - (shift_left0 t j) abbreviates
    bit0 if m = 1, and
    (shift_left0 (concat (extract[|m-2|:0] t) bit0) |j-1|) otherwise

  - (shift_left1 t 0) stands for t
  - (shift_left1 t j) abbreviates
    bit1 if m = 1, and
    (shift_left1 (concat (extract[|m-2|:0] t) bit1) |j-1|) otherwise

  - (shift_right0 t 0) stands for t
  - (shift_right0 t j) abbreviates bit0 if m = 1 and
    (shift_right0 (concat bit0 (extract[|m-1|:1] t)) |j-1|) otherwise

  - (shift_right1 t 0) stands for t
  - (shift_right1 t j) abbreviates bit1 if m = 1 and
    (shift_right1 (concat bit1 (extract[|m-1|:1] t)) |j-1|) otherwise

  - (repeat t 1) abbreviates t
  - (repeat t j) abbreviates (concat t (repeat t |j-1|))
    provided that j*m <= 32

  - (sign_extend t 0) stands for t
  - (sign_extend t j) abbreviates
    (concat (repeat (extract[|m-1|:|m-1|] t) j) t)

  - (rotate_left t 0) stands for t
  - (rotate_left t j) abbreviates t if m = 1, and
    (rotate_left
     (concat (extract[|m-2|:0] t) (extract[|m-1|:|m-1|] t)
     |j-1|) otherwise

  - (rotate_right t 0) stands for t
  - (rotate_right t j) abbreviates t if m = 1, and
    (rotate_right
     (concat (extract[0:0] t) (extract[|m-1|:1] t))
     |j-1|) otherwise

  For all numerals j with 0 < j <= 32,
  - (fill[j] bit0) abbreviates (extract[|j-1|:0] bv0)
  - (fill[j] bit1) abbreviates (repeat j bit1)

 "
)

