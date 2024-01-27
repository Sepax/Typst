
#import "template.typ": *
#show: template.with(
  title: [Finite automata and formal languages #linebreak() Assignment 1],
  short_title: "DIT084",
  description: [
    DIT323 (Finite automata and formal languages)\ at Gothenburg University, Spring
    2024
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

= 

_Question:_ Prove using induction that, for every finite alphabet, $Sigma, forall n in NN. |Sigma^n| = |Sigma|^n$.

_Solution:_ Let $P(n) := |Sigma^n| = |Sigma|^n$.

#proof[
  By induction on $n$.

  _Basis:_ $P(0)$ is true since $|Sigma^0| = 1 = |Sigma|^0$.

  _Inductive step:_ Assume $P(n)$ is true for some arbitrary  $n in NN$ _(i.h.)_. We want to show that $P(n+1)$ is true.

  Let $Sigma$ be a finite alphabet. Then, $|Sigma^{n+1}| = |Sigma| |Sigma^n|$ by definition of $Sigma^{n+1}$.

  By the induction hypothesis, $|Sigma^n| = |Sigma|^n => |Sigma^{n+1}| = |Sigma| |Sigma^n| = |Sigma| |Sigma|^n = |Sigma|^{n+1}$.

  $therefore forall n in NN. P(n)$.
]

= 

Define a language $S$ containing words over the alphabet $Sigma = {a,b}$ inductively in
the following way:

- The empty word is in $S$: $epsilon in S$
- If $u, v in S$, then _auavb_ $in S$.
- If $u, v, w in S$, then _buavaw_ $in S$.

== 

_Question:_ Use recursion to define two functions $hash_a, hash_b ∈ Sigma^* -> NN$ that return the number of occurrences of $a$ and $b$, respectively, in their input.

_Solution:_

$ hash_a (u v) = cases(
  0 & quad "if" u v = epsilon, 
  1 + hash_a (v) & quad "if" u = a, 
  hash_a (v) & quad "if" u eq.not a) $

#linebreak()

$ hash_b (u v) = cases(
  0 & quad "if" u v = epsilon, 
  1 + hash_b (v) & quad "if" u = b, 
  hash_b (v) & quad "if" u eq.not b) $

#pagebreak()

==

_Question:_ Use induction to prove that $forall w in S. hash_a (w) = 2  hash_b (w)$.

_Hint:_ You might want to show that $hash_a ( italic("auavb") ) = 2 + hash_a (u) + hash_a (v)$.
How do you prove this? This property follows from a lemma that you can perhaps prove by induction:
$forall u,v in Sigma^* . hash_a (u v) = hash_a (u) + hash_a (v)$

_Solution:_

==== Proof of lemma from hint

Lemma to prove: $l_1 := forall u,v in Sigma^* . hash_a (u v) = hash_a (u) + hash_a (v)$

Let $P(u) := hash_a (u v) = hash_a (u) + hash_a (v)$.

#proof[
  By induction on $u$.

  _Basis:_ $P(epsilon)$ is true since $hash_a (epsilon) = 0 = hash_a (epsilon) + hash_a (epsilon)$.

  _Inductive step:_ Assume $P(u)$ is true for some arbitrary  $u in Sigma^*$ _(i.h.)_. We want to show that $P(a u)$ is true.

  Let $v in Sigma^*$. Then, 
  
  $ hash_a (a u v) &= 1 + hash_a (u v) & & wide ("by definition of" hash_a) \
    &= 1 + hash_a (u) + hash_a (v) & & wide ("i.h")  \
    &= hash_a (a u) + hash_a (v) & & wide ("by definition of" hash_a) $

  $therefore forall u,v in Sigma^*. P(u)$.
]

Because $hash_a$ and $hash_b$ are defined in the same way, the same proof can be applied to:
$ forall u,v in Sigma^* . hash_b (u v) = hash_b (u) + hash_b (v) $

==== Using lemma 1 to prove lemma 2 from hint 

_Lemma to prove:_ $l_2 := hash_a ( italic("auavb") ) = 2 + hash_a (u) + hash_a (v)$

#proof[
  $ hash_a (a u a v b) &= 1 + hash_a (u a v b) & & wide ("by definition of" hash_a) \ 
    &= 1 + hash_a (u) + hash_a (a v b) & & wide ("lemma" l_1) \
    &= 1 + hash_a (u) + 1 + hash_a (v b) & & wide ("by definition of" hash_a) \
    &= 2 + hash_a (u) + hash_a (v) + hash_a (b) & & wide ("lemma" l_1) \
    &= 2 + hash_a (u) + hash_a (v) + hash_a (epsilon)& & wide ("by definition of" hash_a) \
    &= 2 + hash_a (u) + hash_a (v) & & wide ("by definition of" hash_a) $
  
  $therefore hash_a ( italic("auavb") ) = 2 + hash_a (u) + hash_a (v)$
]

Because $hash_a$ and $hash_b$ are defined in the same way, the same proof can be applied to: 
$ hash_b ( italic("bubva") ) = 2 + hash_b (u) + hash_b (v) $

#pagebreak()

==== Using statement to prove original question

_Statement to prove:_ $forall w in S. hash_a (w) = 2  hash_b (w)$

Let $P(w) := hash_a (w) = 2  hash_b (w)$.

#proof[
  By induction on $w$.

  _Basis:_ $P(epsilon)$ is true since $hash_a (epsilon) = 0 = 2  hash_b (epsilon)$.

  _Inductive step:_ Assume $P(w)$ is true for some arbitrary  $w in S$ _(i.h.)_. We want to show that $P(italic("auavb")) and P(italic("buavaw"))$ is true.

  Let $u,v,w in S$. Then,

  $ hash_a ( italic("auavb") ) &= 2 + hash_a (u) + hash_a (v) & & wide ("lemma" l_2) \
    &= 2 + 2 hash_b (u) + 2 hash_b (v) & & wide ("i.h") \
    &= 2 (1 + hash_b (u) + hash_b (v)) & & wide ("arithmetic") \
    &= 2 hash_b ( italic("auavb") ) & & wide  $

  #linebreak()
  
  $ hash_a ( italic("buavaw") ) &= 2 + hash_a (u) + hash_a (v) & & wide ("by statement") \
    &= 2 + 2 hash_b (u) + 2 hash_b (v) & & wide ("i.h") \
    &= 2 (1 + hash_b (u) + hash_b (v)) & & wide ("arithmetic") \
    &= 2 hash_b ( italic("buavaw") ) & & wide ("by statement") $

  $therefore forall w in S. P(w)$.
]




= 

_Question:_ Let $Sigma = {0}$ and define $f, g, h in Sigma^* -> NN$ recursively in the following way:

- $g(epsilon) = 1$ #linebreak()
  $g(0w) = |w| + g(w) + -h(w)$
- $h(epsilon) = 0$ #linebreak()
  $h(0w) = |w| + g(w)$
- $f(epsilon) = 1$ #linebreak()
  $f(0w) = h(w) = 2g(w)$

==

_Question:_ Compute the values of $f(00), g(00), h(00), f(000), g(000), h(000), f(0000), g(0000), h(0000)$

==

_Question:_ Prove that $forall n in NN. f(0^n) = 1+n$.

_Hint:_ First prove that $forall n in NN. g(0^n) = 1 and h(0^n) = n$.



