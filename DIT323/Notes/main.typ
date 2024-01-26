
#import "template.typ": *
#show: template.with(
  title: [Finite automata and formal languages],
  short_title: "DIT084",
  description: [
    Notes based on lectures for DIT323 (Finite automata and formal languages)\ at
    Gothenburg University, Spring 2024
  ],
  authors: ((name: "Sebastian Pålsson"),),
  lof: false,
  lot: false,
  lol: false,
  paper_size: "a4",
  cols: 1,
  text_font: "XCharter",
  code_font: "Cascadia Mono",
  accent: "#000000", // black
)

#pagebreak()

= Introduction

A *finite automaton* is a computational model with a set of states, input
symbols, transition rules, an initial state, and accepting states. It recognizes
patterns and processes strings in a language by transitioning between states
based on input.

*Formal languages* are abstract systems defined by rules to represent and
analyze languages. They provide a precise framework for specifying syntax,
semantics, and rules for generating valid strings within a language.

== Regular Expressions

Regular expressions are concise patterns for searching and matching strings,
widely used in text processing and pattern matching.

- Used in text editors
- Used to describe the lexical syntax of programming languages.
- Can only describe a limited class of “languages”.

#example[
  - A regular expression for strings of ones of even length: *_(11)∗_*
  - A regular expression for some keywords: *_while_ ∣ _for_ ∣ _if_ ∣ _else_*
  - A regular expression for positive natural number literals (of a certain form):
    *_[1–9][0–9]∗_*
]

== Finite automata

- Used to implement regular expression matching.
- Used to specify or model systems.
  - One kind of finite automaton is used in the specification of TCP.
- Equivalent to regular expressions.

#example[
  #figure(
    image("figures/finite_automata_1.png", width: 80%),
    caption: [Model of a lock],
  ) <finite_automata_lock>
   
  - The states are a kind of memory.
  - Finite number of states ⇒ finite memory.
]

#pagebreak()

== Context-free grammars

Used to describe the syntax of programming languages.
- More general than regular expressions.
- Used by parser generators. (Often restricted.)

#sourcecode[```
Expr ::== Number
    | Expr Op Expr
    | '(' Expr ')'
Op ::== '+' | '-' | '*' | '/'
```]

== Turing machines

A Turing machine is an abstract model of computation with a tape, read/write
head, and rules. It serves as a foundational concept in the study of algorithms
and computability.

- Unbounded memory: an infinite tape of cells.
- A read/write head that can move along the tape.
- A kind of finite state machine with rules for what the head should do.

It is equivalent to a number of other models of computation.

== Repetition of some classical logic

=== Propositions

A *proposition* is a statement that is either true or false.

#example[
  - The sky is blue.
  - The sky is green.
  - 1 + 1 = 2.
  - 1 + 1 = 3.
]

It may not always be known what the truth value (⊤ or ⊥) of a proposition is.

=== Connectives

*Logical connectives* are operators that combine propositions to form new
propositions.

#table(
  columns: (20em, auto),
  inset: 10pt,
  align: center,
  [*p* ∧ *q*],
  [conjuction],
  [*p* ∨ *q*],
  [disjunction],
  [¬*p*],
  [negation],
  [*p* ⇒ *q*],
  [implication],
  [*p* ⇔ *q*],
  [equivalence],
)

#pagebreak()

Truth tables for these connectives:

#table(
  columns: (auto, auto, auto, auto, auto, auto, auto),
  inset: 10pt,
  align: center,
  [*p*],
  [*q*],
  [*p* ∧ *q*],
  [*p* ∨ *q*],
  [¬*p*],
  [*p* ⇒ *q*],
  [*p* ⇔ *q*],
  [⊤],
  [⊤],
  [⊤],
  [⊤],
  [⊥],
  [⊤],
  [⊤],
  [⊤],
  [⊥],
  [⊥],
  [⊤],
  [⊥],
  [⊥],
  [⊥],
  [⊥],
  [⊤],
  [⊥],
  [⊤],
  [⊤],
  [⊤],
  [⊥],
  [⊥],
  [⊥],
  [⊥],
  [⊥],
  [⊤],
  [⊤],
  [⊤],
)

Note that *$p => q$* is true if *$p$* is false.

=== Validity

A proposition is _valid_, or a _tautology_, if it is satisfied for all
assignments of truth values to its variables.

#example[
  - *$p => p$* is valid.
  - *$p or not p$* is valid
]

=== Equivalence

Two propositions are _equivalent_ if they have the same truth value for all
assignments of truth values to their variables. (they have the same truth table)

#example[
  - *$p => q$* and *$not p or q$* are equivalent.
  - *$p and q$* and *$q and p$* are equivalent.
]

=== Predicates

A predicate is, roughly speaking, a function to propositions.

#example[
  - $P(n) = $ "$n$ is a prime number"
  - $Q(a,b) = $ "$(a+b)^2 = a^2 + 2a b + b^2$"
]

=== Quantifiers

*Universal quantification* and *existential quantification* are used to express
statements about all or some elements in a set.

#example[
  - *$forall n in N: P(n)$* means that $P(n)$ is true for all natural numbers $n$.
  - *$exists n in N: P(n)$* means that $P(n)$ is true for some natural number $n$.
]

#pagebreak()

== Repetition of some set theory

A set is roughly speaking a collection of elements.

=== Defining sets

- *$A = {1, 2, 3}$* means that $A$ is the set containing the elements $1$, $2$,
  and $3$.
- *$B = {x in N | x > 0}$* means that $B$ is the set of all natural numbers
  $x$ such that $x > 0$.
- *$C = {x in N | exists y in N: x = 2y}$* means that $C$ is the set of all
  natural numbers $x$ such that there exists a natural number $y$ such that
  $x = 2y$. (the set of all even natural numbers)

=== Members, subsets, and equality

- *$x in A$* means that $x$ is an element of $A$.
- *$A subset.eq B$* means that $A$ is a subset of $B$.
- *$A = B$* means that $A$ and $B$ are equal.

=== The empty set

- *$emptyset$* is the empty set.
- *$forall x: not x in emptyset$*.

=== Set operations

==== Union, intersection and set difference

- *$A union B$* is the union of $A$ and $B$. (the set of all elements that are in $A$ or $B$)
- *$A sect B$* is the intersection of $A$ and $B$. (the set of all elements that
  are in $A$ and $B$)
- *$A backslash B = A - B$* is the set difference of $A$ and $B$. (the set of all
  elements that are in $A$ but not in $B$)

==== Complement

- *$overline(A)$* is the complement of $A$. (the set of all elements that are not
  in $A$)

==== _Cartesian product_

- *$A times B$* is the Cartesian product of $A$ and $B$. (the set of all pairs
  $(a, b)$ where $a in A$ and $b in B$)

#example[
  - *$N times N$* is the set of all pairs of natural numbers.
  - *$N times N times N$* is the set of all triples of natural numbers.
]

==== Power set

- *$℘(A) = { A | A subset.eq S}$* is the power set of $A$. (the set of all subsets
  of $A$)

#example[
  - *$℘({1, 2}) = {emptyset, {1}, {2}, {1, 2}}$*
]

==== Set of all finite subsets

- *$"Fin"(A) = { A | A subset.eq S, A "is finite" }$* is the set of all finite
  subsets of $A$.

#example[
  - *$"Fin"({1, 2}) = {emptyset, {1}, {2}, {1, 2}}$*
  - *$"Fin"(N) = ℘(N)$*
]

=== Relations

Relations define connections between elements of sets. A binary relation is a
subset of the Cartesian product of two sets, often denoted as $R subset.eq A times B$.
Common types include reflexive, symmetric, and transitive relations, capturing
different aspects of element connections.

- A binary relation $R$ on $A$ is a subset of $A^2 = A times A: R subset.eq A^2$
- Notation: $x R y$ same as $(x, y) in R$
- Can be generalised from $A times A$ to $A times B times C times dots.h.c $

==== Some binary relational properties

For $R subset.eq A times B$:

- Total (left-total): $forall x in A: exists y in B: x R y$
- Functional/deterministic: $forall x in A: forall y, z in B: x R y and x R z => y = z$

For $R subset.eq A^2$:

- Reflexive: $forall x in A: x R x$
- Symmetric: $forall x, y in A: x R y => y R x$
- Transitive: $forall x, y, z in A: x R y and y R z => x R z$
- Antisymmetric: $forall x, y in A: x R y and y R x => x = y$

===== Partial orders

A _partial order_ is a relation that is reflexive, antisymmetric, and
transitive.

==== Equivalence relations

An _equivalence relation_ is a relation that is reflexive, symmetric, and
transitive.

=== Functions

Relation between two sets, denoted as $f: A → B$, where $A$ is the _domain_ (set
of inputs) and $B$ is the _codomain_ (set of possible outputs). Every element in
the _domain_ is associated with a unique element in the _codomain_. If $(x, y)$ is
in the function, it means that the input $x$ is associated with the output $y$.

- Sometimes defined as the set of total and functional relations $f subset.eq A
  times B$
- Notation $f(x) = y$ same as $(x, y) in f$
- If the requirement of totality is dropped, we get the set of partial functions, $A harpoon.rt B$
- The _image_ is the set of all outputs of the function, ${y in B | x in A, f(x) = y}$

==== Identity, composition

- The _identity function_ $id_A: A → A$ is defined as $id_A(x) = x$
- For functions $f in B -> C$ and $g in A -> B$ the _composition_ of $f compose g in A -> C$ is
  defined by $(f compose g)(x) = f(g(x))$

#pagebreak()

==== Injectivity

An _injection_ is a function $f: A → B$ such that $forall x, y in A: f(x) = f(y) => x = y$

- Every input is mapped to an unique output.
- A is at most as large as B.
- Holds if $f$ has a left inverse $g in B -> A: g compose f = $ _id_

#figure(
  image("figures/injective.png", width: 40%),
  caption: [Injective function],
)

==== Surjectivity

A _surjection_ is a function $f: A → B$ such that $forall y in B: exists x in A: f(x) = y$

- The function "targets" every element in the _codomain_
- A is at least as large as B.
- Holds if $f$ has a right inverse $g in B -> A: f compose g = $ _id_

#figure(
  image("figures/surjective.png", width: 40%),
  caption: [Surjective function],
)

==== Bijectivity

A _bijection_ is a function $f: A → B$ such that $forall y in B: exists! x in A: f(x) = y$. _In simple terms, it is both injective and surjective._

- $A$ and $B$ are of the same size.
- Holds _iff_ $f$ has left and right inverse $g in B -> A$

#figure(
  image("figures/bijective.png", width: 40%),
  caption: [Bijective function],
)

=== Partitions

A _partition_ $P subset.eq ℘(A)$ of a set $A$ is a set of non-empty subsets of $A$ such
that every element in $A$ is in exactly one of the subsets.
- Every element is non-empty: $forall X in P: X eq.not emptyset$
- The elements cover $A: union.big_(B in P) B = A$
- The elements are mutually disjoint: $forall B, C in P: B eq.not C => B sect C = emptyset$

#example[
  - $P = {{1, 2}, {3, 4}}$ is a partition of $A = {1, 2, 3, 4}$
  - $P = {{1, 2}, {3, 4}, {5}}$ is not a partition of $A = {1, 2, 3, 4}$
]

=== Equivalence classes

Given a set $A$ and an equivalence relation $R subset.eq A times A$, the
_equivalence class_ of an element $a in A$ is the set of all elements in $A$ that
are equivalent to $a$.

#definition[
  The equivalence classes of an equivalence relation $R$ on $A$:
   
  $ [x]_R = {y in A | x R y} $
]

=== Quotients

Given a set $A$ and an equivalence relation $R subset.eq A times A$, the
quotient of $A$ by $R$ is the set of all equivalence classes of $R$.

#definition[
  The quotient of $A$ by $R$ is the set of all equivalence classes of $R$:
   
  $ A / R = {[x]_R | x in A} $
]

#example[
  Can one define $ZZ = NN^2$ with the intention that $(m,n)$ stands for $m-n$?
   
  No, $(0,1)$ and (1,2) would both represent $-1$.
   
  _Instead we can use the quotient set:_
   
  $ ZZ = NN^2 backslash tilde.op_ZZ $
   
  where 
   
  $ (m_1,n_2) tilde.op_ZZ (m_2,n_2) <=> m_1+n_1 = m_2+n_2 $
]

#pagebreak()

= Proofs, induction & recursive functions

== Basic proof methods

#table(
  columns: (auto, auto),
  inset: 10pt,
  align: center,
  [*To prove*],
  [*Method*],
  [$p => q$],
  [Assume $p$ and prove $q$],
  [$p => q$],
  [Assume $not$ q and prove $not p$],
  [$forall x in A. P(x)$],
  [Assume that we have an $x in A$ and prove $P(x)$],
  [$p <=> q$],
  [Prove both $p => q$ and $q = p$],
  [$not p$],
  [Assume $p$ and derive a contradiction],
  [$p$],
  [Prove $not not p$],
)

== Induction

For a natural number predicate $P$ we can prove $forall n in NN: P(n)$ in the
following way:

- Prove $P(0)$
- Prove $forall n in NN: P(n) => P(n+1)$

with the formula:

$ P(0) and (forall n in NN : P(n) => P(n+1)) => forall n in NN : P(n) $

#pagebreak()

== Complete/Strong induction

We can also prove $forall n in NN: P(n)$ in the following way:

- Prove $P(0)$
- For every $n, i in NN$, prove that if $P(i)$ holds for all $i lt.eq n$, $P(n+1)$ holds.

with the formula:

$ P(0) and (forall n in NN: (forall i in NN: i lt.eq n => P(i)) => P(n+1)) => forall n in NN: P(n) $

#example[
  #lemma[
    Every natural number $n gt.eq 8$ can be written as a sum of multiples of $3$ and $5$.
  ]
   
  #proof[
    _(by complete induction)_
     
    Let $P(n) := n gt.eq 8 => exists a, b in NN: n = 3a + 5b$
     
    We prove that $P(n)$ holds for all $n in NN$ by complete induction on $n$:
     
    _Basis:_ $(n = 8,9,10)$
    - $P(8)$ holds since $8 = 3*1 + 5*1$.
    - $P(9)$ holds since $9 = 3*3 + 5*0$.
    - $P(10)$ holds since $9 = 3*0 + 5*2$.
     
    _Inductive step:_ $P(8) and P(9) and P(10) and dots.h.c and P(k) => P(k + 1) "where" k gt.eq i$
     
    _Induction hypothesis:_ Assume $P(i)$ is true for all $i in NN$ where 
    $10 lt.eq i lt.eq k$
     
    _To prove:_ $P(k + 1) := k + 1 gt.eq 8 => exists a, b in NN: k + 1 = 3a + 5b$
     
    $ k + 1 = 3a + 5b & <=> k - 2 = 3a + 5b - 3 \
                    & <=> k - 2 = 3(a-1) + 5b \ 
                    & <=> k - 2 = 3a' + 5b $
     
    $k - 2 gt.eq 8$ and $k - 2 lt.eq k$, so by the _induction hypothesis_, $P(k - 2)$ holds,
    thus $P(k+1)$ holds.
     
     
  ]
   
]
 
#pagebreak()
 
== Proof by counterexample
 
To prove that a statement is false, we can find a counterexample. 
 
_In general, to prove:_ $   & not(forall "natural number predicates" P: P(0) and \
  & (forall n in NN : n gt.eq 1 and P(n) => P(n + 1)) => \
  & forall n in NN : n gt.eq 1 => P(n)) $
 
_we assume:_ $   & forall "natural number predicates" P: P(0) and \
  & (forall n in NN : n gt.eq 1 and P(n) => P(n + 1)) => \
  & forall n in NN : n gt.eq 1 => P(n) $
 
_and derive a contradiction._
 
#example[
  The following statement does not hold for $P(n) := n eq.not 1$ and $n = 1$
   
  $ P(0) and (forall n in NN : n gt.eq 1 and P(n) => P(n+1)) => forall n in NN : n gt.eq 1 => P(n) $
   
  _The hypotheses hold, but not the conclusion._
   
  #proof[
     
    Let $P(n) := n eq.not 1$
     
    Base case: $P(0) := 0 eq.not 1$
     
    To disproof: 
     
    $   & forall n in NN : n gt.eq 1 and P(n) => P(n + 1) \
      & forall n in NN : n gt.eq 1 and n eq.not 1 => n + 1 eq.not 1 $
     
    _Let $n = 1$_
     
    $   & n gt.eq 1 and P(n) => P(n+1) \
      & n gt.eq 1 and P(1) => P(2) \
      & 1 gt.eq 1 and 1 eq.not 1 => 1 + 1 eq.not 1 $
     
    $P(1) := 1 eq.not 1$ is a contradiction, so we are done.
     
  ]
]

#pagebreak()

== Inductively defined sets

An inductively defined set is a set that is defined in such a way that its
elements are generated by applying a set of rules or operations starting from
some initial elements. The process of generating elements continues
indefinitely, and it relies on a principle of induction.

- *Base Elements:* Specify a set of initial elements that belong to the set. These
  are the starting points for the construction of the set.
- *Inductive Rules:* Define rules or operations that allow you to generate new
  elements of the set based on the existing elements.
- *Closure under Induction:* if an element belongs to the set, all the elements
  generated from it using the inductive rules also belong to the set.

#example[
  An example of an inductively defined set is the set of natural numbers:
   
  $ "" / ("zero" in NN) wide (n in NN) / ("suc"(n) in NN) $
]

#example[
  Another example, booleans:
   
  $ "" / ("true" in italic("Bool")) wide "" / ("false" in italic("Bool")) $
]

#example[
  Another example, finite lists:
   
  $ "" / ("nil" in italic("List")(A)) wide (x in italic("A") wide x s in italic("List")(A)) / ("cons"(x, x s) in italic("List")(A)) $
]

_Note that "nil" stands for the empty list and "cons" stands for the construction
of a list by adding an element to the front of an existing list (in haskell)._

_Some alternative notations for lists:_
- $[ med ] <=> $ nil
- $x : x s <=> "cons"(x, x s)$
- $[1,2,3] <=> "cons"(1, "cons"(2, "cons"(3, "nil")))$

== Recursive functions

A recursive function is a function that is defined in terms of itself. It is
defined by a base case and a recursive case.

#example[
  $   &italic("length") in italic("List")(A) &->& NN \
    &italic("length")("nil")               &= & "zero" \
    &italic("length")("cons"(x,x s))       &= & "suc"(italic("length")(x s)) $
]

#example[
  $   & f in italic("List")(A) times italic("List")(A) &->& italic("List")(A) \
    & f("nil", y s)                                  &= & y s \
    & f("cons"(x, x s), y s)                         &= & "cons"(x, f(x s, y s)) $
]

== Mutual induction

In general, a proof by mutual induction of a statement A consists in proving a
stronger statement than $A$, usually a statement of the form $A and B$, where $B$ can
be seen as an _"auxiliary statement"_. The advantage is that now one can use a
*stronger induction hypothesis* than in a proof of the mere statement $A$ by
simple induction.



#example[
  _The following is a nice example of a property about natural numbers that cannot
  be proved by simple induction (at least, not in a natural way), but the proof by
  mutual induction is very easy, because it gives a stronger induction hypothesis._
   
  Let $f,g,h in NN -> {0,1}$ be functions defined as follows:
   
   
  $   & f(n) = cases(
    #align(right)[#box[$0 quad$]]&\, "if" n=0,
    #align(right)[#box[$g(n-1) quad$]]&\, "otherwise",

  ) wide
   
  g(n) = cases(
    #align(right)[#box[$1 quad$]]&\, "if" n=0,
    #align(right)[#box[$f(n-1) quad$]]&\, "otherwise",

  ) \
   
    & h(n) = cases(
    #align(right)[#box[$0 quad$]]&\, "if" n=0,
    #align(right)[#box[$1 - h(n-1) quad$]]&\, "otherwise",

  ) $
   
  Let $P(n) := forall n in NN: h(n) = f(n)$.
   
  _It does not seem possible to prove the proposition by simple induction, the
  induction hypothesis in this case is too weak. But the proof is quite easy if
  you prove the following stronger statement, by (mutual) induction on $n in NN$:_
   
  Let $P'(n) := forall n in NN: h(n) = f(n) and h(n) = 1 - g(n)$.
   
  #proof[ 
    By induction on $n in NN$.
     
    _Basis:_ $f(0) = 0 = h(0)$ and $h(0) = 0 = 1-1 = 1 - g(0)$
     
    _Inductive step:_ By induction hypothesis (i.h), $h(n) = f(n)$ and $h(n) = 1 - g(n)$.
    Hence,
     
    $ f(n+1) &= g(n) = 1 - h(n) = 1 - f(n) = h(n+1) \
    h(n+1) &= 1 - h(n) = 1 - f(n) = 1 - g(n+1) $
  ]
   
  _Note that in the inductive step, to prove that $f(n+1)=h(n+1)$ we use the
  inductive hypothesis about the second statement, i.e. $h(n)=1−g(n)$. Conversely,
  to prove that $h(n+1)=1−g(n+1)$ we use the inductive hypothesis about the first
  statement, i.e. $f(n)=h(n)$. This is the essence of mutual induction._
]
 
#pagebreak()

= Structural induction & automata theory

== Structural induction

Structural induction is a proof technique that can be used to prove properties
of recursively defined objects, such as inductively defined sets and recursive
functions.

#example[
  For a given inductivley defined set we have a corresponding induction
  prionciple.
   
  Consider the following inductively defined set of natural numbers:
   
  $ "" / ("zero" in NN) wide (n in NN) / ("suc"(n) in NN) $
   
  In order to prove $forall n in NN: P(n)$:
   
  - Prove $P("zero")$
  - Prove $forall n in NN: P(n) => P("suc"(n))$
]

#example[
  Another example, booleans:
   
  $ "" / ("true" in italic("Bool")) wide "" / ("false" in italic("Bool")) $
   
  In order to prove $forall b in italic("Bool"): P(b)$:
  - Prove $P("true")$
  - Prove $P("false")$
]

#example[
  Another example, finite lists:
   
  $ "" / ("nil" in italic("List")(A)) wide (x in italic("A") wide x s in italic("List")(A)) / ("cons"(x, x s) in italic("List")(A)) $
   
  In order to prove $forall x s in italic("List")(A): P(x s)$:
  - Prove $P("nil")$
  - Prove $forall x in A: forall x s in italic("List")(A): P(x s) => P("cons"(x, x s))$
]

The pattern of proving a proposition with structural induction.

Consider an inductivley defined set:

$ dots.h.c quad (x in italic("A") wide d in D(A)) 
/ (c(x,dots,d) in D(A)) quad dots.h.c $

In order to prove $forall d in D(a):P(d)$:
- $dots.v$
- $forall x in A, dots, d in D(A)$, prove that $dots$ and $P(d) => P(c(x, dots, d))$.
- $dots.v$

_One inductive hypothesis for each recutsive argument._

#pagebreak()

== Notes on induction/recursion

- _Inductively defined sets:_ interference rules with constructors.
- _Recursion (primitive recursion):_ recursive calls only for recursive arguments
  $f(c(x,d)) = dots.h.c f(d) dots.h.c$.
- _Structural induction:_ inductive hypotheses for recursive arguments $P(d) => P(c(x,d))$.

== Concepts from automata theory

=== Alphabets and strings

An alphabet is a finite, nonempty set of symbols.
- ${a,b,c,dots.h.c,z}$
- ${0,1,dots.h.c,9}$

A string (or word) over the alphabet is $Sigma$ is a member of _List_($Sigma$).


=== Some conventions

Following the course text book:
- $Sigma:$ An alphabet
- $a,b,c:$ Elements of $Sigma$
- $u,v,w:$ Words (strings) over $Sigma$

=== Simple notation

#table(
  columns: (auto, auto),
  inset: 10pt,
  align: center,
  [$Sigma^*$],
  [_List_$(Sigma)$],
  [$epsilon$],
  [nil or $[med]$],
  [a w],
  [cons(a, w)],
  [$a$],
  [cons$(a,"nil")$ or $[a]$],
  [$a,b,c$],
  [$[a,b,c]$],
  [$u v$],
  [append(u, v)],
  [|w|],
  [length(w)],
  [$sigma^+$],
  [nonempty strings, ${w in Sigma^* | w eq.not epsilon}$],
)

=== Exponentiation

$Sigma^n:$ Strings of length $n$, ${w in Sigma^* | |w| = n}$

#example[
  ${a,b}^2 = {a a, a b, b a, b b}$
]

==== Alternative definition of $Sigma^n subset.eq Sigma^*$
- $Sigma^0 = {epsilon}$
- $Sigma^{n+1} = {a w | a in Sigma, w in Sigma^n}$

#pagebreak()

==== Repeated strings

$w^n$: $w$ repeated $n$ times

#example[
  $a b^2 = 𝑎 𝑏 𝑎 𝑏 𝑎 𝑏$
]

==== Recursive definitions of functions on strings

- $w^0 = epsilon$
- $w^{n+1} = w w^n$

=== Languages

A language over an alphabet $Sigma$ is a subset $L subset.eq Sigma^*$. Examples
of such languages are typical programming languages such as C, Java, and Python
and regular written languages. Another example is the odd natural numbers
expressed in binary notation (without leading zeroes), which is a language over
the alphabet ${0,1}$.

Following the course text book: $L,M,N:$ Languages over $Sigma$.

=== Operations on languages

Some of these are mentioned earlier.

#table(
  columns: (auto, auto, auto),
  inset: 10pt,
  align: center,
  [*Operation*],
  [*Rule*],
  [*Example*],
  [Concatenation],
  [$L M = {u v | u in L, v in M}$],
  [${a, b c}{d e , f} = {a d e, a f, b c d e, b c f}$],
  [Exponentiation],
  [$L^0 = {epsilon}$, $L^{n+1} = L L^n$],
  [${a, b c}^2 &= {a, b c}({a, b c}^1) \ &= {a, b c}({a, b c}{epsilon}) \ &= {a, b c}{a, b c} \ &= {a a, a b c, b c a, b c b c}$],
  [The _Kleene star_],
  [$L^* = union.big_(n in NN) L^n$],
  [${a, b c}^* &= {a, b c}^0 union {a,b c}^1 union {a, b c}^2 union dots.h.c \ &= {epsilon, a, b c, a a, a b c, b c a, b c b c, dots.h.c}$],
)

#pagebreak()

== Inductivley defined subsets

One can define subsets of (say) $Sigma^*$ inductively. For instance, for $L subset.eq Sigma^*$ we
can define $L^* subset.eq Sigma^*$ inductively as follows:

$ "" / (epsilon in L^*) wide (u in L quad v in L^*) / (u v in L^*) $

_Note that there are no constructors (but in some cases it might make sense to
name the rules)_.

#example[
  $a b a in {a, a b}^*$
   
  #proof[
    $ (overline(a b in {a, a b}) wide (overline(a in {a, a b}) wide overline(epsilon in {a, a b})) / (a in {a, a b}^*)) / (a b a in {a, a b}^*) $
  ]
]

_some more shit on recursion with subsets is to be added here!_

#pagebreak()

= Deterministic finite automata

A _DFA_ specifies a language. In @even_diagram, the language is : ${11}^* = {epsilon, 11, 1111, dots.h.c}$.
One of many use cases of _DFAs_ is the implementation of regular expression
matching. 

#figure(image("figures/DFA.png", width: 60%), caption: [Transition diagram]) <even_diagram>

A _DFA_ is given by a 5-tuple $(Q,Sigma, delta, q_0, F)$ where 

- $Q:$ The finite set of states.
- $Sigma:$ The alphabet.
- $delta in Q times Sigma -> Q:$ The transition function.
- $q_0 in Q:$ The starting state.
- $F subset.eq Q:$ The set of accepting states

The diagram in @even_diagram corresponds to the 5-tuple

$ italic("Even") = ({s_0,s_1},{1}, delta, s_0, {s_0}) $

where $delta$ is defined in the following way:

$   & delta in {s_0,s_1} times {1} -> {s_0,s_1} \
  & delta(s_0, 1) = s_1 \
  & delta(s_1, 1) = s_0 $

== Semantics

#definition[
  The language $L(A)$ of a DFA $A = (Q, Sigma, delta, q_0, F)$ is defined in the
  following way: 
   
  A transition function for strings which is defined by recursion: 
   
  $   &hat(delta) in Q times Sigma^* &->& Q \
    &hat(delta)(q,epsilon)         &= & q \
    &hat(delta)(q, a w)            &= & hat(delta)(delta(q, a),w) $ 
   
  The language of $A$ is defined as the set of all strings $w in Sigma^*$ such
  that $hat(delta)(q_0, w) in F$:
   
  $ L(A) = {w in Sigma^* | hat(delta)(q_0, w) in F} $
]

#example[
  The language of the DFA in @even_diagram is specified as follows:
   
  $ hat(delta)(s_0,11) &= hat(delta)(delta(s_0, 1),1) \
                     &= hat(delta)(s_1,1) \
                     &= hat(delta)(delta(s_1, 1),epsilon) \
                     &= hat(delta)(s_0, epsilon) \
                     &= s_0 $
]

== Transition diagrams

A transition diagram is a graphical representation of a DFA. The states are
represented by circles, the transitions by arrows, and the accepting states by
double circles.

- One node per state.
- An arrow "from nowhere" to the starting state.
- Double circles for accepting states.
- For every transition $delta(s_1, a) = s_2$, an arrow marked with $a$ from $s_1$ to $s_2$.
  (multiple arrows can be combined)

#figure(
  image("figures/td_missing_trans.png", width: 50%),
  caption: [TD with missing transitions],
) <missing_trans>

#figure(
  image("figures/td_missing_trans_2.png", width: 50%),
  caption: [Every missing tranisition goes to a new state (that is not accepting)],
) <missing_trans_2>

_Note that diagrams with missing tranisitions do not define the alphabet
unambiguousely. Consider the diagram in @missing_trans, the alphabet must be a
(finite) superset of ${"'"0"'","'"1"'",dots.h.c, "'"9"'"}$, but which one?_

#pagebreak()

== Transition tables

A transition table is a tabular representation of a DFA. The states are
represented by rows, the transitions by columns, and the accepting states by
double entries.

#figure(
  image("figures/trans_table.png", width: 20%),
  caption: [Transition table],
) <trans_table>

- _States:_ left column.
- _Alphabet:_ top row.
- _Starting state:_ marked with $->$.
- _Accepting states:_ marked with $*$
- _Transition function:_ table.

#pagebreak()

== Constructions

Given a DFA $A = (Q,Sigma, delta,q_0,F)$ we can construct a DFA $overline(A)$ that
satisfies the following property:

$ L(overline(A)) = overline(L(A)) := Sigma^* backslash L(A) $

Construction:

$ overline(A) = (Q,Sigma, delta,q_0,Q backslash F) $

_We accept if the original automaton doesn't. (what???)_

#example[
  Let $A$ be
   
  #figure(image("figures/DFA_1.png", width: 40%))
   
  Then $overline(A)$ is
   
  #figure(image("figures/DFA_2.png", width: 40%))
]

== Product construction

Given two DFAs $A_1 = (Q_1,Sigma, delta_1,q_01,F_1)$ and $A_2 = (Q_2,Sigma, delta_2,q_02,F_2)$ with
the same alphabet, we can construct a DFA $A_1 times.circle A_2$ that satisfies
the following property:

$ L(A_1 times.circle A_2) = L(A_1) sect L(A_2) $

Construction:

$ A_1 times.circle A_2 = (Q_1 times Q_2,Sigma, delta,(q_01,q_02),F_1 times F_2) $

where

$ delta((s_1,s_2), a) = (delta_1(s_1,a),delta_2(s_2,a)) $

_We basically run the two automatons in parallel and accept if both accept._

#pagebreak()

== Sum Construction

Given two DFAs $A_1 = (Q_1,Sigma, delta_1,q_01,F_1)$ and $A_2 = (Q_2,Sigma, delta_2,q_02,F_2)$ with
the same alphabet, we can construct a DFA $A_1 plus.circle A_2$ that satisfies
the following property:

$ L(A_1 plus.circle A_2) = L(A_1) union L(A_2) $

Construction:

$ A_1 plus.circle A_2 = (Q_1 union Q_2,Sigma, delta,(q_01,q_02),F_1 union F_2) $

where

$   & delta((s_1,s_2), a) = cases(
  #align(right)[#box[$(delta_1(s_1, a),s_2 ) quad$]]&\, "if" q in Q_1,
  #align(right)[#box[$(s_1, delta_2(s_2, a)) quad$]]&\, "if" q in Q_2,

) $

== Accessible states

Let $A = (Q, Sigma, delta, q_0, F)$ be a DFA. The set _Acc_$(q) subset.eq Q$ of
states that are accessible from $q in Q$ can be defined in the following way:

$ italic("Acc")(q) = {hat(delta)(q,w) | w in Sigma^*} $

To construct a possible smaller DFA, which satisfies $L(A) = L(A'):$

$  & A' & = & (italic("Acc")(q_0), Sigma, delta', q_0, F sect italic("Acc")(q_0)) \
   & delta'(q,a) & = & delta(q, a) $

#example[
  The following two DFAs define the same language:

  #figure(image("figures/acc_states_1.png", width: 40%), caption: [$A$])

  #figure(image("figures/acc_states_2.png", width: 40%), caption: [$A'$])

  _Notice that $A$ has unreachable states from the starting state $q_0$. We can ignore these states and construct $A'$._ 
]

== Regular languages

A language $M subset.eq Sigma^*$ is _regular_ if there exists a DFA $A$ with alphabet $Sigma$ such that $L(A) = M$.

- Note that if $M$ and $N$ are regular, then so are $M sect N$, $M union N$, and $overline(M)$.
- We will see later that if $M$ and $N$ are regular, then so are $M N$.

= Non-deterministic finite automata & the subset construction















 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
