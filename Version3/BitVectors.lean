
namespace SMT3

-- Integer intervals [lo, hi-1]
def Range!(lo: Int) (hi: Int): Type :=
  { n : Int // lo <= n ∧ n < hi }

-- Bit values
def Bit!: Type := Range! 0 2

#check ((Subtype.mk 1 (by omega)) : Bit!)

-- Positive integers
def Pos!: Type :=  { n : Int // n > 0 }

-- plus is the addition of positive integers
def plus (m n : Pos!) : Pos! :=
  ⟨m.val + n.val,
   by have := m.property ; have := n.property ; omega⟩

-- minus is the subtraction of positive integers, defined only when m > n:
def minus (m n : Pos!) (h: m.val > n.val): Pos! :=
  ⟨m.val - n.val,
   by have := n.property ; omega⟩

-- isBV is a predicate that holds when b is a bit value that is 0 outside the range [0, m-1] and is either 0 or 1 inside the range
def isBV (i : Int) (m : Int) (b : Int) : Prop :=
  (0 > i → b = 0) ∧
  (m > i ∧ i ≥ 0 → 0 ≤ b ∧ b ≤ 1) ∧
  (i ≥ m → b = 0)


-- BitVec
-- BitVec(m) is the type of bit vectors of size m, where m is a positive integer. A value v of type BitVec(m) is a function that takes an integer i and returns a bit b such that isBV(i, m, b) holds.
def BitVec (m : Pos!) : Type :=
  (i : Int) → { b : Int // isBV i m.val b }

-- #check (BitVec 5)

--  one is the bit vector of size m that has all 1's for all
-- in-range positions
def one {m : Pos!} : BitVec m :=
  λ (i: Int) =>
    -- case 1: i is in range
    if h:(0 <= i ∧ i < m.val) then
     ⟨1, by unfold isBV; omega⟩
    else
    -- case 2: i is out of range
     ⟨0, by unfold isBV; omega⟩


---------------------
-- Sequence operators
---------------------

-- concat takes two bit vectors v1 and v2 of sizes m1 and m2, respectively, and returns a bit vector of size m1 + m2 that is the concatenation of v1 and v2. The first m1 bits of the result are the bits of v1, and the next m2 bits are the bits of v2. The bits of the result are indexed from 0 to m1 + m2 - 1, where the bit at index i is the bit of v1 at index i if i < m1, and the bit of v2 at index i - m1 if i >= m1.
def concat {m2 m1: Pos!} (v2 : BitVec m2) (v1 : BitVec m1) :
                       BitVec (plus m1 m2) :=
  λ (i: Int) =>
    -- case 1: i is in the first m1 bits
    if (m1.val > i) then
      let p := by
        unfold isBV ; unfold plus
        have h2 := m2.property
        have h3 := (v1 i).property
        unfold isBV at h3
        simp ; omega
     -- case 1 output
     ⟨(v1 i).val, p⟩
    else
    -- case 2: i is in the next m2 bits
      let p := by
        unfold isBV ; unfold plus
        have h1 := m1.property
        have hv2 := (v2 (i - m1.val)).property
        unfold isBV at hv2
        simp ; omega
     -- case 2 output
     ⟨(v2 (i - m1.val)).val, p⟩

-- extract takes a bit vector v of size m and two integers hi and lo such that 0 ≤ lo ≤ hi < m, and returns a bit vector of size hi - lo + 1 that is the subsequence of v from index lo to index hi. The bits of the result are indexed from 0 to hi - lo, where the bit at index i is the bit of v at index i + lo.
def extract {m : Pos!}
  (hi : {n : Int // m.val > n})
  (lo : {n : Int // hi.val ≥ n ∧ n ≥ 0 })
  {m' : {n : Int // n = hi.val - lo.val + 1}}
  (v : BitVec m) : BitVec ⟨m'.val, by omega⟩ :=
  λ (i: Int) =>
    -- case 1: i is in range
    if c: m'.val > i ∧ i ≥ 0 then
      let p := by
        unfold isBV
        have hm := m'.property
        have hv := (v (i + lo)).property
        unfold isBV at hv
        simp ; omega
    -- case 1 output
      ⟨(v (i + lo)).val, p⟩
    else
    -- case 2: i is out of range
      let p := by unfold isBV ; simp
    -- case 2 output
      ⟨0, p⟩

---------------------
-- Bitwise operators
---------------------

-- bvnot takes a bit vector v of size m and returns a bit vector of size m that is the bitwise negation of v.
def bvnot {m : Pos!} (v : BitVec m) : BitVec m :=
  λ (i: Int) => let b :=
    if 0 <= i ∧ i < m.val then
      if (v i).val = 0 then 1 else 0
    else 0
    ⟨b, by unfold isBV; omega⟩

-- bvand takes two bit vectors v1 and v2 of size m and returns a bit vector of size m that is the bitwise conjunction of v1 and v2.
def bvand {m : Pos!} (v1 : BitVec m) (v2 : BitVec m) : BitVec m :=
  λ (i: Int) => let b :=
    if 0 <= i ∧ i < m.val then
      if (v1 i).val = 1 ∧ (v2 i).val = 1 then 1 else 0
    else 0
    ⟨b, by unfold isBV; omega⟩

-- bvor takes two bit vectors v1 and v2 of size m and returns a bit vector of size m that is the bitwise disjunction of v1 and v2.
def bvor {m : Pos!} (v1 : BitVec m) (v2 : BitVec m) : BitVec m :=
  λ (i: Int) => let b :=
    if 0 <= i ∧ i < m.val then
      if (v1 i).val = 1 ∨ (v2 i).val = 1
      then 1 else 0
    else 0
    ⟨b, by unfold isBV; omega⟩

-- bvnand
def bvnand {m : Pos!} (v1 : BitVec m) (v2 : BitVec m) : BitVec m :=
  bvnot (bvand v1 v2)

-- bvnor
def bvnor {m : Pos!} (v1 : BitVec m) (v2 : BitVec m) : BitVec m :=
  bvnot (bvor v1 v2)

-- bvxor
def bvxor {m : Pos!} (v1 : BitVec m) (v2 : BitVec m) : BitVec m :=
  bvor (bvand v1 (bvnot v2))
       (bvand (bvnot v1) v2)

def bvxnorxnor {m : Pos!} (v1 : BitVec m) (v2 : BitVec m) : BitVec m :=
  bvor (bvand v1 v2 )
       (bvand (bvnot v1) (bvnot v2))

end SMT3
