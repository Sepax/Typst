
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

Let $Sigma = {0,1}$

Let $R & = (0 + 01^*)^* (epsilon + 1) 1 (epsilon + 0 + 1)^*$

Let's construct a NFA for R:

+ Construct a NFA for $(0 + 01^*)^*$
   
  #figure(image("figures/F6.jpg", width: 50%)) 
 
+ Add $(epsilon + 1) 1$ to the NFA
   
  #figure(image("figures/F7.jpg", width: 50%)) 

+ Add $(epsilon + 0 + 1)^*$ to the NFA
   
  #figure(image("figures/F8.jpg", width: 50%)) 

The NFA for R is the thus following:

#sourcecode[```
     0       1 
→ q0 {q0,q1} {q2} 
  q1 Ø       {q0,q1}
  q2 Ø       q3
* q3 q3      q3
```
]

#pagebreak()

=

The regular expression is: $R = 1(1+01)^+$

- The "$1$" in the beginning makes it so that the string must start with a $1$.
- The "$+$" makes it so $|w| gt.eq 2$
- $(1+01)$ makes it so it always ends with a $1$ and two zeroes never appear after
  one another.

=


Let the following table represent the NFA:

#table(
  columns: (auto, auto, auto, auto),
  inset: 10pt,
  align: horizon,
  [*State*], [$epsilon$], [$a$], [$b$],
  [$-> s_0$], [$emptyset$], [$s_1$], [${s_0,s_2}$],
  [$ s_1$], [$s_2$], [$s_4$], [$s_3$],
  [$s_2$], [$emptyset$], [${s_1, s_4}$], [$s_3$],
  [$s_3$], [$s_5$], [${s_4,s_5}$], [$emptyset$],
  [$s_4$], [$s_3$], [$emptyset$], [$s_5$],
  [$"*" s_5$], [$emptyset$], [$s_5$], [$s_5$]
)

We then define the following DFA by subset construction:

#table(
  columns: (auto, auto, auto),
  inset: 10pt,
  align: horizon,
  [*State*],  [$a$], [$b$],
  [$-> s_0$], [${s_1,s_2}$], [${s_0, s_2}$],
  [${s_1,s_2}$], [${s_1,s_2,s_3,s_4,s_5}$],[${s_3,s_5}$],
  [${s_0, s_2}$], [${s_1,s_2,s_3,s_4,s_5}$], [${s_0,s_2,s_3,s_5}$],
  [$"*"{s_1,s_2,s_3,s_4,s_5}$], [${s_1,s_2,s_3,s_4,s_5}$], [${s_3,s_5}$],
  [$"*"{s_3,s_5}$],[${s_3,s_4,s_5}$], [{$s_5$}],
  [${s_0,s_2,s_3,s_5}$], [${s_0,s_1,s_2,s_3,s_4,s_5}$],[${s_0,s_2,s_3,s_5}$],
  [$"*"{s_3,s_4,s_5}$],[${s_3,s_4,s_5}$],[$s_5$],
  [$"*" s_5$], [$s_5$], [$s_5$],
  [${s_0,s_1,s_2,s_3,s_4,s_5}$],[${s_1,s_2,s_3,s_4,s_5}$],[${s_0,s_2,s_3,s_5}$]
)

#pagebreak()

=

Transition diagram for the NFA:

#figure(image("figures/F9.jpg", width: 70%))

Let's define the following equations for the NFA:

$ q_0 &= epsilon + q_0 a \ 
q_1 &= q_0 b + q_2 b \
q_2 &= q_0 c + q_1 c \
q_3 &= q_1 b + q_3 c \
q_4 &= q_3 a + q_4 b + q_2 c $

The goal is to find the regular expression for the final state, $q_4$.

For $q_0$ we have:

$ q_0 &= epsilon + q_0 a & & \
      &= epsilon a^* wide & & ("Arden's lemma") $

For $q_1$ we have:

$ q_1 &= q_0 b + q_2 b \ 
      &= q_0 b + (q_0 c + q_1 c) b wide & & ("Substitute" q_2) \
      &= q_0 b + q_0 c b + q_1 c b \ 
      &= (q_0 b + q_0 c b) (c b)^* wide & & ("Arden's lemma") $

For $q_2$ we have:

$ q_2 &= q_0 c + q_1 c \ 
      &= q_0 c + (q_0 b + q_0 c b) (c b)^* c wide & & ("Substitute" q_1) $

#pagebreak()

For $q_3$ we have:

$ q_3 &= q_1 b + q_3 c \
      &= q_1 b c^* $


Now we solve $q_4$:

$ q_4 &= q_3 a + q_4 b + q_2 c & \
    &= (q_3 a + q_2 c) b^*  & ("Arden's lemma") \
    &= ((q_1 b c^*) a + (q_0 c + (q_0 b + q_0 c b) (c b)^* c) c) b^*  & ("Substitute" q_3 "and" q_2 ) \
    &= (q_1 b c^* a + q_0 c c + q_0 b (c b)^* c c + q_0 c b (c b)^* c c ) b^*  & ("Simplify") \
    &= (((q_0 b + q_0 c b) (c b)^*) b c^* a + q_0 c c + q_0 b (c b)^* c c + q_0 c b (c b)^* c c ) b^*  & ("Substitute" q_1) \
    &= (q_0 b (c b)^* b c^* a + q_0 c b (c b)^* b c^* a + q_0 c c + q_0 b (c b)^* c c + q_0 c b (c b)^* c c ) b^*  & ("Simplify") \
    &= (epsilon a^* b (c b)^* b c^* a + epsilon a^* c b (c b)^* b c^* a + epsilon a^* c c + epsilon a^* b (c b)^* c c + epsilon a^* c b (c b)^* c c ) b^*  & ("Substitute" q_0) \
    &= (a^* b (c b)^* b c^* a + a^* c b (c b)^* b c^* a + a^* c c + a^* b (c b)^* c c + a^* c b (c b)^* c c ) b^*  & ("Remove" epsilon) \
    &= a^* (b (c b)^* b c^* a + c b (c b)^* b c^* a + c c + b (c b)^* c c + c b (c b)^* c c ) b^*  & ("Simplify") \
$



