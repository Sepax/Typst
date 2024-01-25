
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

==== _Union, intersection and set difference_

- *$A union B$* is the union of $A$ and $B$. (the set of all elements that are in $A$ or $B$)
- *$A sect B$* is the intersection of $A$ and $B$. (the set of all elements that
  are in $A$ and $B$)
- *$A backslash B = A - B$* is the set difference of $A$ and $B$. (the set of all
  elements that are in $A$ but not in $B$)

==== _Complement_

- *$overline(A)$* is the complement of $A$. (the set of all elements that are not
  in $A$)

==== _Cartesian product_

- *$A times B$* is the Cartesian product of $A$ and $B$. (the set of all pairs
  $(a, b)$ where $a in A$ and $b in B$)

#example[
  - *$N times N$* is the set of all pairs of natural numbers.
  - *$N times N times N$* is the set of all triples of natural numbers.
]

==== _Power set_

- *$℘(A) = { A | A subset.eq S}$* is the power set of $A$. (the set of all subsets
  of $A$)

#example[
  - *$℘({1, 2}) = {emptyset, {1}, {2}, {1, 2}}$*
]

==== _Set of all finite subsets_

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

==== _Some binary relational properties_

For $R subset.eq A times B$:

- Total (left-total): $forall x in A: exists y in B: x R y$
- Functional/deterministic: $forall x in A: forall y, z in B: x R y and x R z => y = z$

For $R subset.eq A^2$:

- Reflexive: $forall x in A: x R x$
- Symmetric: $forall x, y in A: x R y => y R x$
- Transitive: $forall x, y, z in A: x R y and y R z => x R z$
- Antisymmetric: $forall x, y in A: x R y and y R x => x = y$

===== _Partial orders_

A _partial order_ is a relation that is reflexive, antisymmetric, and
transitive.

==== _Equivalence relations_

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

==== _Identity, composition_

- The _identity function_ $id_A: A → A$ is defined as $id_A(x) = x$
- For functions $f in B -> C$ and $g in A -> B$ the _composition_ of $f compose g in A -> C$ is
  defined by $(f compose g)(x) = f(g(x))$

#pagebreak()

==== _Injectivity_

An _injection_ is a function $f: A → B$ such that $forall x, y in A: f(x) = f(y) => x = y$

- Every input is mapped to an unique output.
- A is at most as large as B.
- Holds if $f$ has a left inverse $g in B -> A: g compose f = $ _id_

#figure(
  image("figures/injective.png", width: 40%),
  caption: [Injective function],
)

==== _Surjectivity_

A _surjection_ is a function $f: A → B$ such that $forall y in B: exists x in A: f(x) = y$

- The function "targets" every element in the _codomain_
- A is at least as large as B.
- Holds if $f$ has a right inverse $g in B -> A: f compose g = $ _id_

#figure(
  image("figures/surjective.png", width: 40%),
  caption: [Surjective function],
)

==== _Bijectivity_

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

= Proofs, induction & rectursive functions





 
 
 
 
 
 
 
 
 
 
 
 
 
