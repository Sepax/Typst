
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

== The contract methaphor <contract_methafor>

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

== Test automation

The use of software to control _the execution_ of tests, the _comparison_ of
actual outcomes to predicted outcomes, the
_setting up_ of test preconditions, and other test _control_ and test reporting
functions.

- Reduces cost
- Reduces human error
- Reduces variance in test quality from different individuals
- Reduces cost of *regression testing*

== Regression testing

Regression testing is a type of software testing that seeks to uncover new
software bugs, or regressions, in existing functional and non-functional areas
of a system after changes such as enhancements, patches or configuration
changes, have been made to them.

- Orthogonal to other mentioned tests
- Testing that is done *after changes* in the software (updates)
- Standard part of maintenance phase of software development

_The purpose of regression testing is to gain confidence that changes did not
cause new failures._

== Software testability

The degree to which a system or component facilitates the establishment of test
criteria and the performance of tests to determine whether those criteria have
been met. _In simple terms: how hard is it to finds faults?_

Testability is a condition of two factors:
- How to provide the test values to the software?
- How to observe the results of test execution?

== Observability

How easy it is to observe the behaviour of a program in terms of its outputs,
effects on the environment and other hardware and software components.

_Software that affects hardware devices, databases, or remote files have low
observability!_

== Controllability

How easy it is to provide a program with the needed inputs, in terms of values,
operations, and behaviours.

- Easy to control software with inputs from keyboards
- Inputs from hardware sensors or distributed software is harder

== Test suit construction

A test suite is a collection of test cases that are intended to be used to test
a software program to show that it has some specified set of behaviours.

- Most central actitivy of testing
- Determines if we have enough test cases (stopping criteria)
- Determines if we have the right test cases (represenative test cases)

The quality of test suites defines the quality of the overall testing effort.
When presenting test suites, we show only relevant parts of test cases.

=== Black box testing

Deriving test suites from external descriptions of the software, e.g.
- Specifications
- Requirements / Design
- Input space knowledge

=== White box testing

Deriving test suites from the source code, e.g.

- Conditions
- Branches in execution
- Statements

_Modern techniques are a hybrid of both black- and white box_

== Coverage criteria

Most metrics used as quality criteria for test suites, describe the degree of
some kind of coverage. These metric are called coverage criteria.

These are crucial for testing _saftey critical software_.

There are certain categories of coverage criteria:
- Control flow graph coverage (white box)
- Logic coverage (white box)
- Input space partitioning (black box)

== Control flow graph

Represent a method to test as a graph, where:
- Statements are nodes
- Edges describe control flow between statements
- Edges are labelled with conditions

#important[*Rules of transformation* can be read in Section 7.3.1 "Structural Graph
  coverage for source code" from the book: Introduction to software testing. *This
  is required*]

=== Control flow graph notions

- *Execution path:* a path through the control flow graph that starts at the entry
  point and is either
infinite or ends at one of the exit points.
- *Path condition:* a condition causing execution to take some path $p$
- *Feasible execution path:* an execution path for which a satisfiable path
  condition exists.

#note[A branch or statement is feasible if it is contained in at least one feasible
  execution path.]

== Types of coverage criteria

=== Statement coverage (SC)

Satisfied by a test suite _TS_, _iff_ for every node $n$ in the control flow
graph there is at least one test in _TS_ causing an execution path via $n$.

=== Branch coverage (BC)

Satisfied by a test suite _TS_, _iff_ for every edge $e$ in the control flow
graph there is at least one test in _TS_ causing an execution path via $e$. _Note that this is a stronger criterion than statement coverage._

=== Path coverage (PC)

Satisfied by a test suite _TS_, _iff_ for every feasible execution path $p$ in
the control flow graph there is at least one test in _TS_ causing an execution
path via $p$. _Note that this is a stronger criterion than branch coverage._

=== Logic coverage (LC)

Satisfied by a test suite _TS_, _iff_ for every predicate $p$ in the control
flow graph there is at least one test in _TS_ causing an execution path via $p$.

Logical (boolean) expressions can come from many sources. We focus on decisions
in the source code _(if, while, for, etc.)_.

=== Decision coverage (DC)

Let the decisions of a program $p$, $D(p)$, be the set of all logical
expressions which $p$
branches on.

For a given decision $d$, _DC_ is satisfied by a test suite _TS_ if it:
- Contains at least two tests,
- one where $d$ evaluates to true,
- one where $d$ evaluates to false

For a given program $p$, _DC_ is satisfied by _TS_ if it satisfies _DC_ *for all* decisions $d in D(p)$.

#example[
  #figure(
    image("figures/decision_coverage.png", width: 80%),
    caption: [Decision coverage example],
  ) <decision_coverage>
]

=== Condition Coverage (CC)

#figure(
  image("figures/condition_coverage.png", width: 80%),
  caption: [Condition coverage],
) <condition_coverage>
#figure(
  image("figures/condition_coverage_example.png", width: 80%),
  caption: [Condition coverage example],
) <condition_coverage_example>

=== Modified Condition Decision Coverage (MCDC)

#figure(
  image("figures/mcdc.png", width: 80%),
  caption: [Modified Condition Decision Coverage],
) <mcdc>
#figure(
  image("figures/mcdc_example.png", width: 80%),
  caption: [Modified Condition Decision Coverage example],
) <mcdc_example>

== Input domain modeling

- The input domain $D$: the possible values that input parameters can have.
- A partition $q$ defines a set of equvilence classes (or simply blocks $B_q$)
  over $D$

A partition $q$ satisfies: (completeness)

$ union.big_(b in B_q) b = D $

Blocks are pairwise disjoint:

$ b_i union b_j = emptyset, wide i eq.not j, wide b_i, b_j in B_q $

- Test values in the same block are assumed to contain _equally useful values_.
- Test cases contain values from each block.

#example[
  #figure(
    image("figures/partitioning.png", width: 80%),
    caption: [Partitioning example],
  ) <partitioning>
]

=== Strategies for generating blocks

- Valid vs. invalid values: all valid and all invalid (completeness)
- Sub-partition: valid values serving different functionality.
- Boundaries: values at or close boundaries often cause problems (stress testing).
- Normal use (happy path): the desired outcome.
- Missing blocks vs overlapping blocks (complete vs disjoint)
- Special values Pointers: (null and not null), collection: (empty and non empty),
  integer (zero a special value).

#example[
  #figure(
    image("figures/example_triang.png", width: 80%),
    caption: [Example: triang(0)],
  ) <example_triang>
  #figure(
    image("figures/example_triang_2.png", width: 80%),
    caption: [Example: triang(0) - Solution],
  ) <example_triang_2>
]

All combinations of blocks from all characteristics must be used. The number of
tests is the product of the number of blocks for each partition. _All Combinations Coverage *ACoC*_

For _triang()_, we have three characteristics, each with 4 blocks. Thus, we need $4 dot 4 dot 4 = 64$ test
cases.

Recall: _different choices of values from the same block are equivalent from testing
perspective_.

= Debugging
- How to systematicly find source of failer
- Test-case to reproduce errors
- Finidng a small failing input (if possible)
- Observing exceution: Debbuggers and Logging
- Program dependencies: data- and control

== Motivation
- Debuging needs to be systematic
- Debuging may involve large inputs
- Programs may have have thousands of memory locations
- Program may pass through milions of states before failure occurs

== The Steps Of Debugging
+ Reproduce the error and try to understand the cause.
+ Isolate and minimise the diffrent factors. (*Simplification*)
+ Eyeball the code, where could it be? (*Reason backwards*)
+ Devise experiments to test your hypothesis. (*Test hypothesis*)
+ Repeat step 3 and 4 until the cause of the bug is determined
+ Fix the bug and verify the fix
+ Create a regression test (See below)

_ Regression testing is a type of software testing that checks if recent code
changes have negatively impacted existing features. It involves re-running
previously created test cases after code modifications to catch any unintended
side effects and ensure the ongoing stability of the software._

== Problem Simplification

As described in the diffrent steps of debugging, simplification is a way to
determine the bug. The idea behing simplification is to minimize the failing
input, so that it will be easier to understand what inputs causes the bug.

*Simplification* can be reached by *Divide-and-Conquer*, where you *->*
+ Cut away one half of the test input
+ Check if any of the halves still exhibit failure.
+ Repeat, until minimal input has been found.

Although this works in some scenarios, this method has the following problems
*->*
- Tedious to re-run test manually
- Boring, cut and paste, re-run ...
- What, if none of the halves exhibits a failure?

Because of the problems with *Divide-and-Conquer*, in most cases automation of
input simplificartion is more favourable.

=== AUTOMATION OF INPUT SIMPLIFICATION

Automation of input simplification in debugging involves using tools or
algorithm to automatically reduce the complexity of input data. This helps
identify and isolate bugs more efficiently, especially in large or complex
software systems.

One exampel of such a algorrithm is *Delta Debugging*. Delta debugging is a
software debugging technique that aims to isolate and identify the cause of a
failure in a program by systematically narrowing down the input that triggers
the failure. The term "delta" refers to the minimal change needed to reproduce
the failure.

The algorithm *Delta debugging* or *DD-Min* as it is also called, works as seen
in figure 4 below.
#figure(
  image("figures/deltaDebugging.png", width: 80%),
  caption: [Delta Debugging],
) <ripr_model>

=== Short Quiz On Delta debugging

*Question :*

Suppose test(c) returns FAIL whenever ccontains two or more occurrences of the
letter X. Apply the ddMin algorithm to minimise the failing input array [X, Z,
Z, X] . Write down each step of the algorithm, and the values of n (number of
chunks). Initially, n is 2.

*Solution :*
#figure(
  image("figures/solution-ddmin.png", width: 80%),
  caption: [Delta Debugging Quiz Answer],
) <ripr_model>

== Observing outcome, State Inspection

Mainly there are three diffrent ways to perform state inspections of a program
*->*
- *Simple logging :* print statements
- *Advanced loggin :* configureable what is printed based on level (e.g. OFF <
  FINE < INFO < WARNING < SEVERE), using e.g. Java’s logging package.
- *Debugging tools :* e.g. Eclipse debugger or the Java debugger jbd (hand-in
  assignment 2)

=== The Quick-And-Dirty Approach : Print Logging

- *Manually add prit statements at code locations to be observed*
- System.out.println(“size = "+ size);

*Pros ->*
- Simple and easy.
- No tools or infrastructure needed, works on any platform.

*Cons ->*
- Code cluttering.
- Output cluttering.
- Performance penalty, possibly changed behaviour (real time apps).
- Buffered output lost on crash
- Source code access required, recompilation necessary.

=== BASIC LOGGING IN JAVA
- Each class can have its own logger-object.
- Each logger has level:
- OFF < FINE... < INFO < WARNING < SEVERE
- Setting the level controls which messages gets written to log.
- Quick Demo: Dubbel.java

*Pros ->*
- Output cluttering can be mastered
- Small performance overhead
- Exceptions are loggable
- Log complete up to crash
- Etc.

*Cons ->*
- Code cluttering - don’t try to log everything

=== Using Debuggers
Assume we have found a small failing test case and identified the faulty
component.

* Basic Functionality of a Debugger*
- Execution Control: Stop execution at specific locations, breakpoints
- Interpretation: Step-wise execution of code
- State Inspection: Observe values of variables and stack
- State Change: Change state of stopped program
- Debugging tools: Eclipse GUI debugger or the Java debugger jbd

= Formal Specification

Describing contracts of units (methods) in a mathematically precise (formal)
language.

Motivation:
- Higher degree of precision
- Automation of program analysis
  - program verification
  - static checking
  - test case generation

== Unit specification

Methods can be specified by referring to:
- result value
- initial values of formal parameters
- pre-state and post-state

== Writing formal Specifications

When writing a formal specification one should list the required pre and
post-conditions. How to find these and formalize them can be tricky.

#example[
Consider the very informal specification of `enterPIN (pin:int)`:

_"Enter the PIN that belongs to the currently inserted bank card into the ATM,
when not yet authenticated. If a wrong PIN is entered three times in a row, the
card is invalidated and confiscated. After having entered the correct PIN, the
customer is regarded as authenticated."_

Contract states _what is guaranteed_ (postcondition), _under which conditions_ (precondition).

Preconditions:
- Card is inserted, user not yet authenticated.

Postconditions:
- If PIN is correct, then the user is authenticated.
- If PIN is incorrect and `wrongPINCounter` was $<2$ when entering the method,
  then `wrongPINCounter` is increased by $1$ and user is not authenticated.
- If PIN is incorrect and `wrongPINCounter` was $>=2$ when entering the method,
  then card is conficaded and user is not authenticated.

There are also some implicit ones:

Implicit preconditions:
- ATM card slot is free
- Card is valid
- Card is not null

Implicit postconditons:
- ATM card slot is occupied
- User is not authenticated
- `wrongPINCounter` is $0$
]<formal_spec_ex>

#important[Implicit pre/postconditions should also be formalised, for example that the
  arguments of a method should not be null, as shown in the above example]

== Validity

In context of formal specification, we want to know if some *formula hold true
in a particular program state.*

- A formula is *valid* if it is true in *all possible states*
- Valid formulas are *useful to simplify other formulas*
- *A formula is satisfiable if it is true at least once*

#example[
  The following *useful* formulas are valid, i.e. you can replace the formula on
  the left side by the one on the right.

  1. $not(exists x: t. med P) <-> forall x: t. med not P$
  2. $not(forall x: t. med P) <-> exists x: t. med not P$
  3. $(forall x: t. med P and Q) <-> (forall x: t. med P) and (forall x: t. med Q)$
  4. $(exists x: t. med P or Q) <-> (exists x: t. med P) or (exists x: t. med Q)$

  #figure(
    image("figures/useful_formulas.png", width: 90%),
    caption: [Some other useful valid formulas],
  )<useful_formulas>

]

= Dafny

Object oriented language desinged to make it easy to write *correct* code.

- Allow annotations specifying program behaviour, as part of the language.
- Automatically proves that the code adheres to specications.
- Absence of run-time errors, e.g. null-pointers, index-out-of-bounds etc.
- Termination checking of loops.

== Fields

Declaring fields.
- Variables declared with keyword `var`
- Type annotations given by `:`
- Assignment written `:=`
- Several variables can be declared at once.
- Parallel assignments possible.

#sourcecode[```js
  var insertedCard : BankCard?;
  var wrongPINCounter : int;
  var customerAuthenticated : bool;
```]

#sourcecode[```js
  var x : int;
  x := 34;
  var y, z := true, false //parallel assignment
```]

#note[The prefix `?` clarifies that the field is allowed to be `null`. ]

== Constructor

Example of a constructor.

#sourcecode[```js
    constructor (n: int)
      modifies this
    {
      ...
    }
    ```]

== Methods

Example of some methods

#sourcecode[```js
    method insertCard (card : BankCard){ ... }
    method enterPIN (pin : int) { ... }
    method add (num1 : int, num2 : int) returns (result : int) { ... }
    ```]

== Propositional logic

All variables $P, Q, R$ (aka propositions) are booleans, i.e. take values True
or False.

#table(
  columns: (auto, auto, auto),
  inset: 10pt,
  align: horizon,
  [*Connectiv*],
  [*Meaning*],
  [*Dafny*],
  [$not P$],
  [not $P$],
  [`!P`],
  [$P and Q$],
  [$P$ and $Q$],
  [`P && Q`],
  [$P or Q$],
  [$P$ or $Q$],
  [`P || Q`],
  [$P -> Q$],
  [$P$ implies $Q$],
  [`P ==> Q`],
  [$P <-> Q$],
  [$P$ is equivalent to $Q$],
  [`P <==> Q`],
)

== First order logic: Quantifiers

Writing quantifiers in Dafny.

#table(
  columns: (auto, auto, auto),
  inset: 10pt,
  align: horizon,
  [*Connectiv*],
  [*Meaning*],
  [*Dafny*],
  [$forall x: t. med P$],
  [For all $x$ of type $t$, $P$ holds],
  [`forall x : t :: P`],
  [$exists x: t. med P$],
  [There exists an $x$ of type $t$, such that $P$ holds],
  [`exists x : t :: P`],
)

#example[
The array `a` only holds values less than or equal to $2$

#sourcecode[```java
    forall i : int :: 0 <= i < a.Length ==> arr[i] <= 2;
  ```]

At least one entry holds the value $1$

#sourcecode[```java
    exists i : int :: 0 <= i < a.Length && a[i] == 1
  ```]
]

== Requires & Ensures

The `requires` and `ensures` prefixes represents pre/postconditions which can
consist of:
- quantifiers, logic connectives
- functions ( `function fibonacci`, etc. )
- predicates

They have no impact on runtime and are just for checking the validity of the
program.

#sourcecode[```java
method example(x : int, y : int) returns (m : int)
  requires x >= 0 && y < = // precondition
  ensures m <= 0 // postcondition
{ return y*x }
```]

== Classes

- Keyword `class`
- No access modifiers like public, private, etc.
- Fields declared by `var` keyword (local variables)
- Objects declared with `new` keyword + `constructor` methods
  - Can have one anonymous (unamed constructor) + several named ones.

#sourcecode[```java
class MyClass {
  var field : int;

  constructor() {
    field := 0;
  }

  constructor Init(x : int) {
    field := x;
  }

  constructor Init2(x : int, y :int) {
    field := x + y;
  }
}
```]

#sourcecode[```java
var myObject  := new MyClass();
var myObject2 := new MyClass.Init(5);
var myObject3 := new MyClass.Init2(5, 6)
```]

#pagebreak()

== Assertions

- Keyword `assert`
- Placed in method body
- Written in specification language
- Evaluated at compile-time

Dafny tries to prove *assertion hold for all executions of code*.

#sourcecode[```java
method Abs(x : int) returns (r : int)
  ensures 0 <= r {
  if (x < 0) {r := -x;}
  else {r := x;}
}

method Test() {
  var v := Abs(-3)
  assert 0 <= v;
}
```]

#note[Assertions can only be proved based on the annotions (`requires`, `ensures`) of
other methods. The previous method `test` works because the assertion is based
on the `ensures` of the method `Abs`.

The following test case would not work:

#sourcecode[```java
method Test() {
  var v := Abs(-3)
  assert v == 3;
}
```]

This is because Dafny only knows that `Abs` returns a value greater than or
equal to 0. It does not know that it returns 3.

However, if we edit the postcondition to the following:

#sourcecode[```java
ensures 0 <= x ==> r == x; // result same as x for positive input x
ensures x < 0 ==> r == -x; // result positive x for negative input x
```]

Then the test case would work. Dafny now knows that if $x$ is negative, the
result will be $-x$ (positive $x$).]

== (Ghost) Functions

Part of the specification language, thus functions cannot modify objects and
write to memory (unlike methods). _so it is SAFE to use in spec_.
- Can only be used in spec (annotations)
- Single unnamed return value
- body is a single statement (no semicolon)

#sourcecode[```java
ghost function abs (x : int) : int {
  if x < 0 then -x else x
}
```]

Now we can use `abs` in our specification.

#sourcecode[```java
method Abs(x : int) returns (r : int)
  ensures r == abs(x) {
  if (x < 0) {r := -x;}
  else {r := x;}
}
```]

== Function methods

A function method can be used in both spec and execution. If we consider the
previus method `Abs`, it might not even be necessary.

#sourcecode[```java
function abs (x : int) : int {
  if x < 0 then -x else x
}

method Test() {
  var v := abs(-3)
  assert v == 3;
}
```]

#note[Dafny remembers function method bodies, unlike methods.]

== Predicates

Recall, a predicate in first-order logic is a function returning a boolean
value. In Dafny, predicates are used similarly to functions. They can be used
both in spec and execution.

#sourcecode[```java
ghost predicate isEven (x : int) { x % 2 == 0}
```]

is equivalent to

#sourcecode[```java
ghost function isEven (x : int) : bool { x % 2 == 0 }
```]

and

#sourcecode[```java
predicate isEven (x : int) { x % 2 == 0}
```]

is equivalent to

#sourcecode[```java
function isEven (x : int) : bool { x % 2 == 0 }
```]

#pagebreak()

== Modifies & Reads clauses

Automated proofs are hard and can be slow. In Dafny, this means that we need to
add certain annotations to help.
- Dafny methods manipulating objects must declare what fields they might modify.
- Dafny functions/predicates must declare what memory locations (objects) they
  might read.

#sourcecode[```java
class BankCard {
  var pin : int;
  var accNo : int;
  var valid : bool;

  ...

  predicate isValid()
    reads this`valid; // read clause
    { this.valid }

  method invalidateCard()
    modifies this`valid; // modifies clause
    ensures !isValid();
    { valid := false;}

  ...
}
```]

#note[back-tick character is used to refer to fields of the object (class) such as
  int, bool, etc. In the case of objects inside the class this is not needed.]

== Old keyword

old-keyword in specification refers to the *value of a field before the method
was called*.

#example[`old(wrongPINCounter)` refers to its value before `insertPIN` method was called.]

== Arrays

Declaring and initialising an array

#sourcecode[```java
var a : array<int>;
a := new int[3];
assert a.Length == 3;
a[0], a[1], a[2] := 0, 0, 0;
```]

Declaring a matrix

#sourcecode[```java
var matrix : array2<int>;
matrix := new int[3, 4];
assert matrix.Length0 == 3 && matrix.Length1 == 4;
```]

#pagebreak()

Parallel assignment: set all entries to $0$

#sourcecode[```java
forall(i | 0 <= i < a.Length)
{a[i] := 0;}
forall (i,j | 0 <= i < m.Length0 && 0 <= j < m.Length1)
{m[i,j] := 0; }
```]

Parallel assignment: increment all entries by $1$. Note that all right-hand side
expressions is evaluated before assignments.

#sourcecode[```java
forall(i | 0 <= i < a.Length)
{a[i] := a[i] + 1;}
```]

