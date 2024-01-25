
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

= 

_Question:_ Define a language $S$ containing words over the alphabet $Sigma = {a,b}$ inductively in
the following way:

- The empty word is in $S$: $epsilon in S$
- If $u, v in S$, then _auavb_ $in S$.
- If $u, v, w in S$, then _buavaw_ $in S$.

== 

_Question:_ Use recursion to define two functions $hash a, hash b ∈ Sigma^* -> NN$ that return the number of occurrences of $a$ and $b$, respectively, in their input.

==

_Question:_ Use induction to prove that $forall w in S. hash a(w) = 2  hash b(w)$.

_Hint:_ You might want to show that $hash_a ( italic("auavb") ) = 2 + hash_a (u) + hash_a (v)$.
How do you prove this? This property follows from a lemma that you can perhaps prove by induction:
$forall u,v in Sigma^* . hash_a (u v) = hash_a (u) + hash_a (v)$

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



