
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





=

We will solve this problem by removing each node one by one and construct the
regular expression in steps by writing subexpressions for each edge in the NFA.

We start by adding node $I$ and $F$ that stands for the initial and final state
of the NFA.

#figure(image("figures/F1.jpg", width: 50%)) 

Then we remove node $q_0$ and add the subexpressions to the new edges in the
NFA.

#figure(image("figures/F2.jpg", width: 50%)) 

Then we remove node $q_1$ and do the same thing.

#figure(image("figures/F3.jpg", width: 50%)) 

Then we remove node $q_3$ and do the same thing.

#figure(image("figures/F4.jpg", width: 50%)) 

Finally we remove node $q_2$ and $q_4$ and do the same thing.

#figure(image("figures/F5.jpg", width: 50%)) 

We get the following regular expression:

$ (a^* b c c + a^* b (c b)^* c c + a^* b b c c + a^* c c c + a^* b b a c + a^* c a c) b^*$

We can remove the first term $a^* b c c $ because this is a subset of the second
term $a^* b (c b)^* c c$. Thus we get the final regular expression:

$(a^* b (c b)^* c c + a^* b b c c + a^* c c c + a^* b b a c + a^* c a c) b^*$