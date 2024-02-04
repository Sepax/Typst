
#import "template.typ": *
#show: template.with(
  title: [Finite automata and formal languages #linebreak() Assignment 2],
  short_title: "DIT084",
  description: [
    DIT323 (Finite automata and formal languages)\ at Gothenburg University
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

_Answer:_ The language comprises of words formed by the letters a, b, and c, and
it is mandatory for the words to have at least one c or two a's.

_Motivation:_


#automaton((S0: (S1: "a", S2: "c"), S1: (S1: "b,c", S2: "a"), S2: (S2: "a,b,c")))

_Looking at the automaton, we can see that any word must contain atlease one c or two a's._


=

==

_Answer:_ See text file `2-1.txt` 

_Motivation:_ 

- *s0* is the start state and also the state when no 'b' has been encountered yet. On seeing an 'a', it remains in s0 because the string "bba" cannot start with 'a'. On seeing a 'b', it moves to *s1*.

- *s1* is the state after seeing a 'b'. On seeing another 'b', it moves to *s2* (as we now have "bb"). On seeing an 'a', it goes back to s0 because the string "bba" cannot start with "ba".

- *s2* is the state after seeing "bb". On seeing an 'a', it moves to *s3* (as we now have "bba"). On seeing a 'b', it stays in *s2* because we're still in the middle of seeing a sequence of 'b's.

- *s3* is the trap state. Once the DFA sees the string "bba", it moves to *s3* and stays there on any input. This is because the string already contains "bba", so any further input cannot change this.

_The DFA accepts a string if and only if it is not in *s3* at the end of the
string. This is because being in *s3* means that the string contains "bba", and
we want to accept exactly those strings that do not contain "bba"._

#pagebreak()

==

_Answer:_ See text file `2-2.txt`

_Motivation:_

- *s0* is the start state and also the state for an even number of 'a's. If it
  sees an 'a', it moves to *s1* (indicating that it has now seen an odd number of 'a's).
  If it sees a 'b', it stays in *s0* because 'b' does not affect the count of 'a's.

- *s1* is the state for an odd number of 'a's. If it sees an 'a', it moves back to
  *s0* (indicating that it has now seen an even number of 'a's). If it sees a 'b',
  it stays in *s1* because 'b' does not affect the count of 'a's.

_The DFA accepts a string if and only if it is in s0 at the end of the string.
This is because being in *s0* means that the string contains an even number of 'a's,
and we want to accept exactly those strings._

==

_Answer:_ See text file `2.3.txt`

_Motivation:_ Given two DFAs $A_1 = (Q_1,Sigma, delta_1,q_01,F_1)$ and $A_2 = (Q_2,Sigma, delta_2,q_02,F_2)$ with
the same alphabet, we can construct a DFA $A_1 times.circle A_2$ that satisfies
the following property:

$ L(A_1 times.circle A_2) = L(A_1) sect L(A_2) $

Construction:

$ A_1 times.circle A_2 = (Q_1 times Q_2,Sigma, delta,(q_01,q_02),F_1 times F_2) $

where

$ delta((s_1,s_2), a) = (delta_1(s_1,a),delta_2(s_2,a)) $

=

== 

_Answer:_ See text file `3-1.txt`

_Motivation:_

Given two DFAs $A_1 = (Q_1,Sigma, delta_1,q_01,F_1)$ and $A_2 = (Q_2,Sigma, delta_2,q_02,F_2)$ with
the same alphabet, we can construct a DFA $A_1 plus.circle A_2$ that satisfies
the following property:

$ L(A_1 plus.circle A_2) = L(A_1) union L(A_2) $

Construction:

$ A_1 plus.circle A_2 = (Q_1 times Q_2,Sigma, delta,(q_01,q_02),F_1 union F_2) $

where

$ delta((s_1,s_2), a) = (delta_1(s_1,a),delta_2(s_2,a)) $

*Important:* this also applies for NFAs.

==

_Answer:_ See text file `3-2.txt`

_Motivation:_ 

First we omitted the inaccessable states in the NFA, and then we construced the
DFA with subset construction. The DFA is constructed by creating a state for
each subset of the states of the NFA.

