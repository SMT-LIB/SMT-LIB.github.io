(theory Strings

 :smt-lib-version 2.7
 :written-by "Cesare Tinelli, Clark Barrett, and Pascal Fontaine"
 :date "2020-02-01"
 :last-updated "2024-07-21"
 :update-history
 "Note: history only accounts for content changes, not release changes.
  2024-07-21 Updated to Version 2.7.
  2024-14-07 Fixed typos and ambiguities in definitions of str.replace_re and str.replace_re_all
  2022-12-07 Fixed comment providing the description of str.replace_re.
  2020-08-06 Fixed an example in Strings constant definition.
  2020-02-09 Layout and minor fixes.
 "

 :notes
 "This is a theory of character strings and regular expressions over an alphabet 
  consisting of Unicode characters. It is not meant to be used in isolation but 
  in combination with Ints, the theory of integer numbers.
 "

 :notes 
 "The theory is based on an initial proposal by Nikolaj Bjørner, Vijay Ganesh, 
  Raphaël Michel and Margus Veanes at SMT 2012.
  The following people, in alphabetical order, have contributed further suggestions 
  that helped shape the current version of the theory (with our apologies for any, 
  unintentional, omissions):
  Kshitij Bansal, Murphy Berzish, Nikolaj Bjørner, David Cok, Levent Erkok, 
  Andrew Gacek, Vijay Ganesh, Alberto Griggio, Joxan Jaffar, Anthony Lin, Andres 
  Nötzli, Andrew Reynolds, Philipp Rümmer, Margus Veanes, and Tjark Weber.
 "

;-------
; Sorts
;-------

 :sorts ((String 0) ; string sort
         (RegLan 0) ; regular expression sort
         (Int 0)    ; integer sort
        )

 :notes
 "There was consensus in the community that having a character type is not
  really necessary and in fact complicates the theory. So the only way to
  express characters is to use strings of length 1.
 "

; In string fields below (which are double-quote-delimited) we cannot write 
; something like "abc" to denote a string constant, we must use ""abc"" instead.

 :notes
 "Because of SMT-LIB's own escaping conventions, string literals are written 
  in quadruple quotes, as in ""abc"", in textual fields here.
 " 

;-----------
; Constants
;-----------

; string constants for _singleton_ strings, 
; i.e., strings consisting of exactly one character 
 :funs-description 
 "All indexed identifiers, all of sort String, of the form 

    (_ char ⟨H⟩) 
   
  where ⟨H⟩ is an SMT-LIB hexadecimal generated by the following BNF grammar

      ⟨H⟩ ::= #x⟨F⟩ | #x⟨F⟩⟨F⟩ | #x⟨F⟩⟨F⟩⟨F⟩ | #x⟨F⟩⟨F⟩⟨F⟩⟨F⟩ | #x⟨2⟩⟨F⟩⟨F⟩⟨F⟩⟨F⟩
      ⟨2⟩ ::= 0 | 1 | 2 
      ⟨F⟩ ::= ⟨2⟩ | 3 | 4 | 5 | 6 | 7 | 8 | 9
            | a | b | b | d | e | f
            | A | B | C | D | E | F 

   Ex:  (_ char #xA)  (_ char #x4E)  (_ char #x123)  (_ char #x1BC3D)  
  
   Each identifier (_ char n) denotes a string of length 1 whose only character 
   is the Unicode character with code point n. We identify Unicode characters
   with their code point, expressed as a hexadecimal.
   For instance, 
   - (_ char #x2B) denotes the string ""+"" whose only character has code point 
     0x0002B (PLUS SIGN); 
   - (_ char #x27E8) denotes the string ""⟨"" whose only character has code point 
     0x027E8 (MATHEMATICAL LEFT ANGLE BRACKET).
 "

 :notes
 "The use of hexadecimal as indices of indexed symbols requires a (minor)
  extension of the SMT-LIB 2 standard which currently allows only numerals and
  symbols as indices.
 "

 :notes
 "Because of leading zeros, the same one-character string is denoted by more 
  than one constant. 
  Example: (_ char #x2B), (_ char #x02B), (_ char #x002B) and (_ char #x0002B).
 "

 :notes 
 "The singleton string constants represent all the Unicode code points in 
  Planes 0 to 2 of Unicode, ranging from 0x00000 to 0x2FFFF (0 to 196607).
  Planes 3-13 are currently unassigned and 14-16 are special purpose or 
  private planes.
  
  A later version may extend the constants to all 17 Unicode planes.

  References: 
  - https://www.unicode.org/main.html
  - http://www.utf8-chartable.de/
  - https://www.compart.com/en/unicode/
 "

 :notes 
 "Rationale for the chosen notation for singleton string constants:
  Because of their large range, Unicode code points are typically given in
  hexadecimal notation. Using a hexadecimal directly to denote the
  corresponding character, however, would create an overloading problem in
  logics that combine this theory with that of bitvectors since hexadecimals
  denote bitvectors there.
  Using them as indices instead avoids this problem.
 "

; String literals (string constants)
 :funs-description 
 "All double-quote-delimited string literals consisting of printable US ASCII 
  characters, i.e., those with Unicode code point from 0x00020 to 0x0007E.
  We refer to these literals as _string constants_.
 "

 :notes
 "The restriction to printable US ASCII characters in string constants is for 
  simplicity since that set is universally supported. Arbitrary Unicode characters 
  can be represented with _escape sequences_ which can have one of the following 
  forms 
      \ud₃d₂d₁d₀  
      \u{d₀} 
      \u{d₁d₀}
      \u{d₂d₁d₀}
      \u{d₃d₂d₁d₀}
      \u{d₄d₃d₂d₁d₀}
  where each dᵢ is a hexadecimal digit and d₄ is restricted to the range 0-2.
  These are the **only escape sequences** in this theory. See later.
  In a later version, the restrictions above on the digits may be extended 
  to allow characters from all 17 Unicode planes.
 
  Observe that the first form, \ud₃d₂d₁d₀, has exactly 4 hexadecimal digit, 
  following the common use of this form in some programming languages.
  Unicode characters outside the range covered by \ud₃d₂d₁d₀ can be
  represented with the long form \u{d₄d₃d₂d₁d₀}.
 
  Also observe that programming language-specific escape sequences, such as
  \n, \b, \r and so on, are _not_ escape sequences in this theory as they
  are not fully standard across languages.
 "

 :notes
 "SMT-LIB 2.6 has one escape sequence of its own for string literals. Two
  double quotes ("") are used to represent the double-quote character within 
  a string literal such as the one containing this very note. That escape 
  sequence is at the level of the SMT-LIB frontend of a solver, not at the 
  level of this theory. 
 "

 :values 
 "The set of values for String is the set of all string literals; 
  for RegLan it is the set of all ground terms of that sort.
 "

 :notes
 "The set of values for String and RegLan could be restricted further, to 
  remove some redundancies. For instance, we could disallow leading zeros 
  in escape sequences.
  For RegLan, we could insist on some level of normalization for regular
  expression values. These restrictions are left to future versions.
 "

 :notes
 "All function symbols in this theory denote *total* functions, i.e., 
  they are fully specified by the theory. This is achieved by returning 
  _error_ values for inputs where the intended functions are undefined.
  Error outputs are always outside of the range of the intended function,
  so there is no confusion with non-error outputs.
 "

;----------------
; Core functions
;----------------

 ; String functions
 :funs (
        ; String concatenation
        (str.++ String String String :left-assoc)

        ; String length
        (str.len String Int)

        ; Lexicographic ordering
        (str.< String String Bool :chainable)   
       ) 

 ; Regular expression functions
 :funs (
        ; String to RE injection
        (str.to_re String RegLan) 

        ; RE membership
        (str.in_re String RegLan Bool) 

        ; Constant denoting the empty set of strings
        (re.none RegLan)

        ; Constant denoting the set of all strings 
        (re.all RegLan)

        ; Constant denoting the set of all strings of length 1
        (re.allchar RegLan)

        ; RE concatenation
        (re.++ RegLan RegLan RegLan :left-assoc)

        ; RE union
        (re.union RegLan RegLan RegLan :left-assoc)

        ; RE intersection
        (re.inter RegLan RegLan RegLan :left-assoc)

        ; Kleene Closure
        (re.* RegLan RegLan) 
       )

 :notes 
 "Function str.to_re allows one to write _symbolic regular expressions_, 
  e.g., RegLan terms with subterms like (str.to_re x) where x is a variable. 
  Such terms have more expressive power than regular expressions. This is 
  intentional, for future developments.
  The restriction to actual regular expressions will be imposed in a logic
  where str.to_re will be applicable to string constants only.
 "

;----------------------------
; Additional functions
;----------------------------

 :fun (
       ; Reflexive closure of lexicographic ordering
       (str.<= String String Bool :chainable)   
 
       ; Singleton string containing a character at given position 
       ; or empty string when position is out of range.
       ; The leftmost position is 0.
       (str.at String Int String)

       ; Substring
       ; (str.substr s i n) evaluates to the longest (unscattered) substring
       ; of s of length at most n starting at position i.
       ; It evaluates to the empty string if n is negative or i is not in 
       ; the interval [0,l-1] where l is the length of s.
       (str.substr String Int Int String)

       ; First string is a prefix of second one.
       ; (str.prefixof s t) is true iff s is a prefix of t.
       (str.prefixof String String Bool)

       ; First string is a suffix of second one.
       ; (str.suffixof s t) is true iff s is a suffix of t.
       (str.suffixof String String Bool)

       ; First string contains second one
       ; (str.contains s t) iff s contains t.
       (str.contains String String Bool)
  
       ; Index of first occurrence of second string in first one starting at 
       ; the position specified by the third argument.
       ; (str.indexof s t i), with 0 <= i <= |s| is the position of the first
       ; occurrence of t in s at or after position i, if any. 
       ; Otherwise, it is -1. Note that the result is i whenever i is within
       ; the range [0, |s|] and t is empty.
       (str.indexof String String Int Int)
  
       ; Replace 
       ; (str.replace s t t') is the string obtained by replacing the first
       ; occurrence of t in s, if any, by t'. Note that if t is empty, the
       ; result is to prepend t' to s; also, if t does not occur in s then
       ; the result is s.
       (str.replace String String String String)

       ; (str.replace_all s t t’) is s if t is the empty string. Otherwise, it
       ; is the string obtained from s by replacing all occurrences of t in s
       ; by t’, starting with the first occurrence and proceeding in
       ; left-to-right order. 
       (str.replace_all String String String String)

       ; (str.replace_re s r t) is the string obtained by replacing the
       ; shortest leftmost match of r in s, if any, by t.
       ; Note that if the language of r contains the empty string, 
       ; the result is to prepend t to s.
       (str.replace_re String RegLan String String) 

       ; (str.replace_re_all s r t) is the string obtained by replacing,
       ; left-to right, each shortest *non-empty* match of r in s by t.
       (str.replace_re_all String RegLan String String) 

       ; RE complement
       (re.comp RegLan RegLan)

       ; RE difference
       (re.diff RegLan RegLan RegLan :left-assoc)
 
       ; RE Kleene cross
       ; (re.+ e) abbreviates (re.++ e (re.* e)).
       (re.+ RegLan RegLan)

       ; RE option
       ; (re.opt e) abbreviates (re.union e (str.to_re ""))
       (re.opt RegLan RegLan)

       ; RE range
       ; (re.range s₁ s₂) is the set of all *singleton* strings s such that
       ; (str.<= s₁ s s₂) provided s₁ and s₂ are singleton. Otherwise, it 
       ; is the empty language.
       (re.range String String RegLan)


       ; Function symbol indexed by a numeral n.
       ; ((_ re.^ n) e) is the nth power of e:
       ; - ((_ re.^ 0) e) = (str.to_re "") 
       ; - ((_ re.^ n') e) = (re.++ e ((_ re.^ n) e))  where n' = n + 1
       ((_ re.^ n) RegLan RegLan)

       ; Function symbol indexed by two numerals n₁ and n₂.
       ; - ((_ re.loop n₁ n₂) e) = re.none                   if n₁ > n₂
       ; - ((_ re.loop n₁ n₂) e) = ((_ re.^ n₁) e)           if n₁ = n₂
       ; - ((_ re.loop n₁ n₂) e) = 
       ;     (re.union ((_ re.^ n₁) e) ... ((_ re.^ n₂) e))  if n₁ < n₂
       ((_ re.loop n₁ n₂) RegLan RegLan)
      )

 :notes
 "The symbol re.^ is indexed, as opposed to having an additional Int argument.
  The latter is problematic because then n can be symbolic in a formula, 
  complicating solving or requiring a logic that restricts n to be a numeral.
  The same argument applies to re.loop and has been used for functions in other 
  theories, such as (_ extract i j) in FixedSizeBitVectors.
 "

 :notes
 "The arguments to re.range can be symbolic. This is intentional, as in the case 
  of str.to_re . 
 "

;---------------------------
; Maps to and from integers
;---------------------------

 :fun (
       ; Digit check
       ; (str.is_digit s) is true iff s consists of a single character which is 
       ; a decimal digit, that is, a code point in the range 0x0030 ... 0x0039.
       (str.is_digit String Bool)

       ; (str.to_code s) is the code point of the only character of s, 
       ; if s is a singleton string; otherwise, it is -1. 
       (str.to_code String Int) 

       ; (str.from_code n) is the singleton string whose only character is
       ; code point n if n is in the range [0, 196607]; otherwise, it is the 
       ; empty string.
       (str.from_code Int String) 

       ; Conversion to integers
       ; (str.to_int s) with s consisting of digits (in the sense of str.is_digit)
       ; evaluates to the positive integer denoted by s when seen as a number in 
       ; base 10 (possibly with leading zeros).
       ; It evaluates to -1 if s is empty or contains non-digits. 
       (str.to_int String Int)

       ; Conversion from integers.
       ; (str.from_int n) with n non-negative is the corresponding string in
       ; decimal notation, with no leading zeros. If n < 0, it is the empty string. 
       (str.from_int Int String)

  :notes
  "(str.to_int ""00123"") evaluates to 123.
   (str.from_int 123) evaluates to ""123"".
   (str.to_int ""-123"") evaluates to -1, an error value, not to -123.
   (str.from_int -123) evaluates to """", an error value, not to ""-123"".
  "
      )

 :definition
 "For every expanded signature Σ, the instance of Strings with that signature is
  the theory consisting of all Σ-models that satisfy the constraints detailed
  below.
  We use 
  - ⟦ _ ⟧ to denote the meaning of a symbol in a given Σ-model.
  - UC to denote the set of all integers from 0x00000 to 0x2FFFF, representing 
    the set of all code points for Unicode characters in Planes 0-2. 

  * String

    ⟦String⟧ is the set UC* of all words, in the sense of universal algebra, 
    over the alphabet UC of Unicode characters, with juxtaposition denoting
    the concatenation operator here. 

    Note: Character positions in a word are numbered starting at 0.

  * RegLan

    ⟦RegLan⟧ is the powerset of ⟦String⟧, the set of all subsets of ⟦String⟧. 
    Each subset can be seen as a language with alphabet UC. 
    Each variable-free term of sort RegLan denotes a regular language in ⟦RegLan⟧.

  * Int

    ⟦Int⟧ is the set of integer numbers.

  * Singleton string constants

    Each such constant is interpreted as the singleton string consisting of 
    the corresponding code point. For example, constant (_ char #x65) is
    interpreted as code point 0x00065, for the letter A, while (_ char #x3B1) is
    interpreted as code point 0x003B1, for the Greek letter α.  

  * String constants

    1. The empty string constant """" is interpreted as the empty word ε of UC*.

    2. Each string constant containing a single (printable) US ASCII character
       is interpreted as the word consisting of the corresponding Unicode
       character code point.
       
       Ex: ⟦""m""⟧ = ⟦(_ char #x6D)⟧ = 0x0006D
           ⟦"" ""⟧ = ⟦(_ char #x20)⟧ = 0x00020

    3. Each string constant of the form ""\ud₃d₂d₁d₀"" where each dᵢ is a
       hexadecimal digit is interpreted as the word consisting of just the 
       character with code point 0xd₃d₂d₁d₀

       Ex: ⟦""\u003A""⟧ = ⟦(_ char #x3A)⟧ = 0x0003A

    4. Each literal of the form ""\u{d₀}"" (resp., ""\u{d₁d₀}"", ""\u{d₂d₁d₀}"",
       ""\u{d₃d₂d₁d₀}"", or ""\u{d₄d₃d₂d₁d₀}"") where each dᵢ is a hexadecimal 
       digit and d₄ is in the set {0,1,2} is interpreted as the word consisting 
       of just the character with code point 0xd₀ (resp., 0xd₁d₀, 0xd₂d₁d₀, 
       0xd₃d₂d₁d₀, or 0xd₄d₃d₂d₁d₀).

       Ex: ⟦""\u{3A}""⟧ = ⟦(_ char #x3A)⟧ = 0x0003A

    5. ⟦l⟧ = ⟦l₁⟧⟦l₂⟧  if l does not start with an escape sequence and can be 
       obtained as the concatenation of a one-character string literal l₁ and
       a non-empty string literal l₂.

       Ex: ⟦""a\u02C1""⟧ = ⟦""a""⟧⟦""\u02C1""⟧ = 0x00061 0x002C1
           ⟦""\u2CA""⟧ = 0x0005C ⟦""u2CA""⟧            (not an escape sequence)
           ⟦""\u2CXA""⟧ = 0x0005C ⟦""u2CXA""⟧          (not an escape sequence)
           ⟦""\u{ACG}A""⟧ = 0x0005C ⟦""u{ACG}A""⟧      (not an escape sequence)

    6. ⟦l⟧ = ⟦l₁⟧⟦l₂⟧  if l can be obtained as the concatenation of string
       literals l₁ and l₂ where l₁ is an escape sequence and l₂ is non-empty.

       Ex: ⟦""\u02C1a""⟧ = ⟦""\u02C1""⟧⟦""a""⟧ = 0x002C1 ⟦""a""⟧
           ⟦""\u{2C}1a""⟧ = ⟦""\u{2C}""⟧⟦""1a""⟧ = 0x0002C ⟦""1a""⟧

    Note: Character positions in a string literal are numbered starting at 0, 
          with escape sequences treated as a single character – consistently
          with their semantics.

          Ex.: In ""a\u1234T"", character a is at position 0, the character 
               corresponding to ""\u1234"" is at position 1, and character T is
               at position 2.

  * (str.++ String String String) 

    ⟦str.++⟧ is the word concatenation function.

  * (str.len String Int)

    ⟦str.len⟧(w) is the number of characters (elements of UC) in w,
    denoted below as |w|. 

    Note: ⟦str.len⟧(w) is **not** the number of bytes used by some Unicode
          encoding, such as UTF-8 – that number can be greater than the number 
          of characters. 

    Note: ⟦str.len(""\u1234"")⟧  is 1 since every escape sequence denotes 
          a single character.

  * (str.< String String Bool)

    ⟦str.<⟧(w₁, w₂) is true iff w₁ is smaller than w₂ in the lexicographic 
    extension to UC* of the standard numerical < ordering over UC.

    Note: The order induced by str.< corresponds to alphabetical order
    for strings composed of characters from the alphabet of a western language 
    such as English:
    ⟦(str.< ""a"" ""aardvark"" ""aardwolf"" ... ""zygomorphic"" ""zygotic"")⟧ = true

  * (str.to_re String RegLan) 

    ⟦str.to_re⟧(w) = { w }

  * (str.in_re String RegLan Bool) 

    ⟦str.in_re⟧(w, L) = true iff w ∈ L

  * (re.none RegLan)

    ⟦re.none⟧  = ∅

  * (re.all RegLan)

    ⟦re.all⟧  = ⟦String⟧ = UC*

  * (re.allchar RegLan)

    ⟦re.allchar⟧  = { w ∈ UC* | |w| = 1 } .

  * (re.++ RegLan RegLan RegLan :left-assoc)

    ⟦re.++⟧(L₁, L₂) = { w₁w₂ | w₁ ∈ L₁ and w₂ ∈ L₂ }

  * (re.union RegLan RegLan RegLan :left-assoc)

    ⟦re.union⟧(L₁, L₂) = { w | w ∈ L₁ or w ∈ L₂ }

  * (re.inter RegLan RegLan RegLan :left-assoc)

    ⟦re.inter⟧(L₁, L₂) = { w | w ∈ L₁ and w ∈ L₂ }

  * (re.* RegLan RegLan) 

    ⟦re.*⟧(L) is the smallest subset K of UC* such that
    1. ε ∈ K
    2. ⟦re.++⟧(L,K) ⊆ K

  * (str.<= String String Bool)

    ⟦str.<=⟧(w₁, w₂) is true iff either ⟦str.<⟧(w₁, w₂) or w₁ = w₂.

  * (str.at String Int String)

    ⟦str.at⟧(w, n) = ⟦str.substr⟧(w, n, 1) 

  * (str.substr String Int Int String)

   - ⟦str.substr⟧(w, m, n) is the unique word w₂ such that
     for some words w₁ and w₃
      - w = w₁w₂w₃ 
      - |w₁| = m
      - |w₂| = min(n, |w| - m) 
                                    if 0 <= m < |w| and 0 < n
    - ⟦str.substr⟧(w, m, n) = ε      otherwise

    Note: The second part of the definition makes ⟦str.substr⟧ a total function.

  * (str.prefixof String String Bool)

    ⟦str.prefixof⟧(w₁, w) = true  iff  w = w₁w₂ for some word w₂

  * (str.suffixof String String Bool)

    ⟦str.suffixof⟧(w₂, w) = true  iff  w = w₁w₂ for some word w₁

  * (str.contains String String Bool)

    ⟦str.contains⟧(w, w₂) = true  iff  w = w₁w₂w₃ for some words w₁, w₃

  * (str.indexof String String Int Int)

    - ⟦str.indexof⟧(w, w₂, i) is the smallest n such that for some words w₁, w₃
        - w = w₁w₂w₃
        - i <= n = |w₁|
      if ⟦str.contains⟧(w, w₂) = true and i >= 0

    - ⟦str.indexof⟧(w,w₂,i) = -1  otherwise

  * (str.replace String String String String)

    - ⟦str.replace⟧(w, w₁, w₂) = w          if ⟦str.contains⟧(w, w₁) = false

    - ⟦str.replace⟧(w, w₁, w₂) = u₁w₂u₂
      where u₁ is the shortest word such that 
            w = u₁w₁u₂
                                            if ⟦str.contains⟧(w, w₁) = true

  * (str.replace_all String String String String)

    - ⟦str.replace_all⟧(w, w₁, w₂) = w      if ⟦str.contains⟧(w, w₁) = false 
                                              or 
                                              w₁ = ε

    - ⟦str.replace_all⟧(w, w₁, w₂) = u₁w₂⟦str.replace_all⟧(u₂, w₁, w₂)
      where u₁ is the shortest word such that 
            w = u₁w₁u₂
                                            if ⟦str.contains⟧(w, w₁) = true
                                              and 
                                              w₁ ≠ ε

  * (str.replace_re String RegLan String String)

    - ⟦str.replace_re⟧(w, L, w₂) = w        if no substring of w is in L

    - ⟦str.replace_re⟧(w, L, w₂) = u₁w₂u₂ 
      where u₁, w₁ are the shortest words such that
            - w = u₁w₁u₂
            - w₁ ∈ L
                                            if some non-empty substring of w is in L

    Note that in the second case, the priority goes to minimizing the length of u₁.
    That is, we must first choose the smallest possible u₁, and then, for that u₁,
    we must choose the smallest possible w₁.  In particular, if ε ∈ L, then both
    u₁ and w₁ must be ε, so the result is just w₂w.

  * (str.replace_re_all String RegLan String String)

    - ⟦str.replace_re_all⟧(w, L, w₂) = w    if no substring of w is in L or ε ∈ L

    - ⟦str.replace_re_all⟧(w, L, w₂) = u₁w₂⟦str.replace_re_all⟧(u₂, L, w₂)
      where u₁, w₁ are the shortest words such that 
            - w = u₁w₁u₂
            - w₁ ∈ L
            - w₁ ≠ ε
                                            if some non-empty substring of w is in L

    Note that in the second case, the priority goes to minimizing the length of u₁.
    That is, we must first choose the smallest possible u₁, and then, for that u₁,
    we must choose the smallest possible w₁.

  * (re.comp RegLan RegLan)

    ⟦str.comp⟧(L) = UC* \ L

  * (re.diff RegLan RegLan RegLan :left-assoc)

    ⟦str.diff⟧(L₁, L₂) = L₁ \ L₂

  * (re.+ RegLan RegLan)

    ⟦re.+⟧(L) = ⟦re.++⟧(L, ⟦re.*⟧(L))

  * (re.opt RegLan RegLan)

    ⟦re.opt⟧(L) = L ∪ { ε }

  * (re.range String String RegLan)

    - ⟦re.range⟧(w₁, w₂) = { w ∈ UC | w₁ <= w <= w₂ }  
      where <= is ⟦str.<=⟧                             if |w₁| = |w₂| = 1
    - ⟦re.range⟧(w₁, w₂) = ∅                           otherwise                     

    Note: ⟦re.range⟧(⟦""ab""⟧, ⟦""c""⟧) = ⟦re.range⟧(⟦""a""⟧, ⟦""bc""⟧) =
          ⟦re.range⟧(⟦""c""⟧, ⟦""a""⟧) =  ∅

  * ((_ re.^ n) RegLan RegLan)

    ⟦(_ re.^ n)⟧(L) = Lⁿ  where Lⁿ is defined inductively on n as follows:
    - L⁰ = { ε } 
    - Lⁿ⁺¹ = ⟦re.++⟧(L, Lⁿ)

  * ((_ re.loop i n) RegLan RegLan)

    ⟦(_ re.loop i n)⟧(L) = Lⁱ ∪ ... ∪ Lⁿ   if i <= n       
    ⟦(_ re.loop i n)⟧(L) = ∅               otherwise

  * (str.is_digit String Bool)

    ⟦str.is_digit⟧(w) = true  iff |w| = 1 and 0x00030 <= w <= 0x00039

  * (str.to_code String Int)

    - ⟦str.to_code⟧(w) = -1         if |w| ≠ 1
    - ⟦str.to_code⟧(w) = w          otherwise  (as w consists of a single code point)

  * (str.from_code Int String) 
                                     
    - ⟦str.from_code⟧(n) = n        if 0x00000 <= n <= 0x2FFFF 
    - ⟦str.from_code⟧(n) = ε        otherwise

  * (str.to_int String Int)

    - ⟦str.to_int⟧(w) = -1 if w = ⟦l⟧  
      where l is the empty string literal or one containing anything other than
      digits, i.e., characters with code point in the range 0x00030–0x00039

    - ⟦str.to_int⟧(w) = n if w = ⟦l⟧  
      where l is a string literal consisting of a single digit denoting number n

    - ⟦str.to_int⟧(w) = 10*⟦str.to_int⟧(w₁) + ⟦str.to_int⟧(w₂) if 
      - w = w₁w₂
      - |w₁| > 0
      - |w₂| = 1
      - ⟦str.to_int⟧(w₁) >= 0
      - ⟦str.to_int⟧(w₂) >= 0
 
    Note: This function is made total by mapping the empty word and words with
          non-digits to -1.

    Note: The function returns a non-negative number also for words that start
          with (characters corresponding to) superfluous zeros, such as 
          ⟦""0023""⟧.

  * (str.from_int Int String)

    - ⟦str.from_int⟧(n) = w  where w is the shortest word such that 
    - ⟦str.to_int⟧(w) = n      if n >= 0
    - ⟦str.from_int⟧(n) = ε    otherwise

    Note: This function is made total by mapping negative integers
          to the empty word.

    Note: ⟦str.to_int⟧(⟦str.from_int⟧(n)) = n iff n is a non-negative integer.

    Note: ⟦str.from_int⟧(⟦str.to_int⟧(w)) = w iff w consists only of digits *and*
          has no leading zeros.
 "
)
