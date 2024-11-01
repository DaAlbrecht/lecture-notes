#import "../template.typ": *

= Computability Theory


== Computability

The field of computability theory is concerned with the study of what can be computed and how efficiently it can be computed.
It is a branch of mathematical logic and theoretical computer science that focuses on the limits of computability.
Computability theory examines the existence and nature of algorithms and the extent to which problems can be solved algorithmically.

=== Partial Function

A partial function is a function that is not defined for all possible inputs.

Partial functions can be denoted as:
- $f: X harpoon.rt Y$
- $f: X arrow.r.not Y$
- $f: X arrow.r.hook Y$

#definition[
  For a partial function $f: X harpoon.rt Y$, and any $x in X$, one has either:
  - $f(x) = y in Y$ (its a single element in Y)
  - $f(x)$ is undefined (it is not defined for this input)
]

#example[
  The partial function $f: RR harpoon.rt RR, x arrow.r.bar 1/x$ is not defined for $x = 0$.
]

=== Register Machine

A register machine is a theoretical model of computation that consists of a set of registers and a set of instructions that operate on these registers.

A register machine over an alphabet $Gamma = {a_1, dots, a_L}$ is a computational model consisting of $R$ registers $R_0, dots, R_(R-1)$, each of which contains a word from $Gamma^*$.

The following operations are possible on the registers:

- Check if a register is empty.
- Read the top character of a register.
- Delete the top character of a register.
- Add a character to the top of a register.

A program for a register machine consists of a sequence of instructions that specify the operations to be performed on the registers.

#table(
  columns: 2,
    [*Command*], [*Description*],
    [*STOP*], [The program halts execution.],
    [*GOTO m*], [The program jumps to the command with label m.],
    [*SWITCH r m0 m1 … mL*], [
      If register r is empty, the program jumps to the command with label m0.
      If the top character of Rr is equal to ai, the program jumps to mi.
    ],
    [*POP r m0 m1 … mL*], [
      Same as the SWITCH command, but additionally removes the last character 
      from register Rr, if present.
    ],
    [*PUSH r c*], [Appends the character c ∈ Γ to register Rr.]
)

=== Turing Machine

A Turing machine is a theoretical model of computation that consists of an infinite tape divided into cells, a read/write head that moves along the tape, and a finite set of states.

A formal definition of a Turing machine consists of a 7-tuple $M = (Q, Gamma, b, Sigma, delta, q_0, F)$, where:
- $Q$ is a finite set of states.
- $Gamma$ is a finite set of tape symbols.
- $b in Gamma$ is the blank symbol.
- $Sigma subset.eq Gamma$ is the set of input symbols.
- $delta: Q times Gamma arrow.r.hook Q times Gamma times {L, R}$ is the transition function.
- $q_0 in Q$ is the initial state.
- $F subset.eq Q$ is the set of final states.


== P and NP

The classes P and NP are fundamental complexity classes in computational complexity theory.

=== P

The class P consists of decision problems that can be solved in polynomial time by a deterministic Turing machine.

A decision problem is in P if there exists an algorithm that solves it in polynomial time, where the running time of the algorithm is bounded by a polynomial in the size of the input.

#definition[
  A decision problem is in P if there exists a deterministic Turing machine that solves it in polynomial time.
]

#example[
  A P problem could be:
  "Given $n$ Keys and $n$ Locks, find out which key fits which lock."

  This problem can be solved in $O(n^2)$ time by trying all possible combinations.
]

=== NP

The class NP consists of decision problems for which a proposed solution can be verified in polynomial time by a deterministic Turing machine,
even if the solution itself cannot be found in polynomial time.

#example[
  An NP problem could be:
  "Given a graph $G$ and an integer $k$, is there a clique of size $k$ in $G$?"

  While finding the clique itself may be difficult, verifying that a given set of vertices forms a clique can be done in polynomial time.
]

=== NP-Complete

In computational complexity theory, a problem is NP-complete when:

1. It is a decision problem, meaning that for any input to the problem, the output is either "yes" or "no".
2. When the answer is "yes", this can be demonstrated through the existence of a short (polynomial length) solution.
3. The correctness of each solution can be verified quickly (namely, in polynomial time) and a brute-force search algorithm can find a solution by trying all possible solutions.
4. The problem can be used to simulate every other problem for which we can verify quickly that a solution is correct. In this sense, NP-complete problems are the hardest of the problems to which solutions can be verified quickly. If we could find solutions of some NP-complete problem quickly, we could quickly find the solutions of every other problem to which a given solution can be easily verified.
