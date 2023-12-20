
#import "template.typ": *
#show: template.with(
  title: [Testing, debugging and verification],
  short_title: "DIT084",
  description: [
    Notes based on lectures for DIT084 (Testing, debugging and verification)\ at
    Gothenburg University, Autumn 2023
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

= Introduction

How do we judge failure in software development? In general, we need a measure
to judge failure. This is given by means of satisfaction of a specification. A
specification is a set of requirements that a system must satisfy. A
specification can be given in many forms, such as a formal mathematical
description, a set of examples, or a set of requirements in natural language.
The specification is the basis for testing, debugging and verification.

In simple terms:

$
"Spec" = "Require" + "Ensure"
$

where *Require* is the set of requirements the program must satisfy in order to
behave correctly, and *Ensure* is the set of guarantees that the program must
satisfy.

#example[
  Imagine a programs that sorts an array of integers. The program must satisfy the
  following specification:
  - *Require:* Accept only input as an array of integers.
  - *Ensure:* Return a sorted array of integers.
]

== The contract methaphor

Same priciple as a *legal contract*, between supplier and client.
- *Supplier:* aka implementer, here a _class or method_ in Java.
- *Client:* mostly _caller object or human user_ calling main-method.
- *Contract:* One or more _pairs of ensures-requires clauses_, defining _mutual obligations_ between
  supplier and client.

_"If the caller (the client) of the method *m* (the supplier) gives inputs which
fulfils the required *precondition*, then the method *m* ensures that the
*postcondition* holds after *m* finishes execution.”_

== Specification, failure, correctness

A failure/correctness is relative to a specification.
- A method *fails* when called in a _state fulfilling the required precondition_ of
  its contract and it _does not terminate in a state fulfulling the postcondition_
  to be ensured.
- A method is *correct* whenever it is started in a _state fulfilling the required precondition_,
  then it _terminates in a state fulfilling the postcondition to be ensured_.
- *Correctness:* Proving absence of failures.

= Testing

Some terminology regarding faults, errors & failures:
- *Fault:* a static defect in the software.
- *Error:* an incorrect internal state that is the manifestation of some fault.
- *Failure:* external, incorrect behaviour with respect to expected behaviour.

== The State of a program

A program can be seen as a function that maps a state to a state. The state of a
program is the values of all variables at a given point in time.

Inputs in the program in @program_state does not always trigger failures. This
is the case for most programs!

#figure(
  image("figures/program_state.png", width: 80%),
  caption: [A graph showing the states of a program],
) <program_state>

=== Program to graph

How does one convert a program to a state graph?

A labelled graph $G$ is of the form

$ G = (N,E,L) $

where $N$ is a set of nodes, $E$ is a set of edges and $L$ is a set of labels. $E subset.eq N times L times N$

A program $P$ is a set of statements

$ P = {s_1, s_2, ..., s_n} $

The following function is used to transform the program to a graph:

$ [dot.op]^(0,f): S -> 2^E $

The function takes an initial state $0$ and a final state $f$ and a *statement*
and *return a set of edges*. We use the special state $bot$ to mean an exit
state (for return statements).

The transformation rule are as follows:

$ [s_1; s_2]^(0,f) = [s_1]^(0,1) union [s_2]^(1,f) $

where $1$ is a fresh state.

#example[
  Some examples of transformations:
  - $[x = a;]^(0,f) = { (0,f = a,f) }$
  - $["return" a;]^(0,f) = { (0,"return" a, bot) } $
  - $["if"(b){s_1}]^(0,f) = { (0,b,1),(0,!b,f) } union {s_1}^(1,f)$
  - $["while"(b){s_2}]^(0,f) = { (0,b,1),(0,!b,f) } union {s_2}^(1,0)$
]

== Complexity of testing (and why we need models)

No other engineering field builds products as complicated as software. The term
correctness has no meaning. Like other engineers, we must use abstraction to
cope with complexity. We use *discrete mathematics* to raise our level of
abstraction.

Abstraction is the purpose of _Model-Driven Test Design_ (MDTD). The “model” is
an abstract structure.

=== Software testing foundations

Testing can only show the presence of failures, not their absence.

- *Testing:* Evaluate software by observing its execution.
- *Test Failure:* Execution of a test that results in a software failure.
- *Debugging:* The process of finding a fault given a failure.

*Not all inputs will “trigger” a fault into causing a failure*

=== RIPR model (or fault and failure model)

Four conditions necessary for a failure to be observed:
- *Reachability:* The location or locations in the program that contain the fault
  must be reached.
- *Infection:* The state of the program must be incorrect.
- *Propagation:* The infected state must cause some output/final state to be
  incorrect.
- *Reveal:* The tester must observe part of the incorrect state.

The RIPR model is a framework for understanding and categorizing software bugs.
It stands for Reach, Infection, Propagation, and Reveal. Reach refers to the
execution reaching the defect, Infection is when the defect causes an incorrect
program state, Propagation is when this incorrect state leads to incorrect
behavior or output, and Reveal is when this incorrect behavior is observed.

#figure(image("figures/ripr_model.png", width: 80%), caption: [The RIPR model]) <ripr_model>

=== The V model

The V-model emphasizes a parallel relationship between development and testing
stages. Each development stage has a corresponding testing phase, ensuring that
issues are identified and fixed early. _It's called the V-model due to its V-like structure, representing the sequence
of execution of processes._

Each testing phase uses a different type of testing level:

- *Acceptance testing:*: Assess software with respect to user requirements
- *System Testing:*: Assess software with respect to system-level specification.
- *Integration Testing:* Assess software with respect to high-level design
- *Unit Testing:* Assess software with respect to low-level unit design

#figure(image("figures/v_model.png", width: 80%), caption: [The V model]) <v_model>

