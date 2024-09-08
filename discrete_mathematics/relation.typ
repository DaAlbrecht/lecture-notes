#import "../template.typ": *
#import "@preview/diagraph:0.2.5": *

= Relation

== Cartesian product

#definition[The Cartesian product of two sets $A$ and $B$ is the set of all ordered pairs $(a, b)$ where $a$ is an element of $A$ and $b$ is an element of $B$.
\
$ A * B =  {(a,b) bar.v a in A and b in B}$]

#example[The Cartesian product of the sets $A = {1, 2}$ and $B = {3, 4}$ is:\
$A * B = {(1, 3), (1, 4), (2, 3), (2, 4)}$.]

#definition[A relation $R$ from a set $A$ to a set $B$ is a subset of the Cartesian product $A * B$.
\
$R subset.eq A * B$]

#example[Let $A = {1, 2}$ and $B = {3, 4}$. The relation $R = {(1, 3), (2, 4)}$ is a relation from $A$ to $B$.]

For $(a, b) in R$, we write $a R b$, and say that $a$ is in relation $R$ to $b$.


== Inverse relation

#definition[The inverse relation $R^{-1}$ of a relation $R$ is the relation that contains the ordered pairs of $R$ in reverse order.
\
$R^{-1} = {(b, a) | (a, b) in R}$]

#example[Let $R = {(1, 3), (2, 4)}$. The inverse relation $R^{-1}$ is:\
$R^{-1} = {(3, 1), (4, 2)}$.]


== Composition of relations

#definition[
Given the relation $R subset.eq A * B$ and $S subset.eq B * C$,
the composition of $R compose S$ is the relation from $A$ to $C$ defined by:
\
\
$R compose S = {(a, c) | exists b in B, (a, b) in R and (b, c) in S}$]

#pagebreak()

== Representation of relations

Relations can be represented in different ways, one way is by using a directed graph.

#example[$R = {(a,1), (b,1), (b,3), (c,2)} subset.eq A * B$ when $A = {a, b, c}$ and $B = {1, 2, 3}$.
\
#raw-render(
  ```
  digraph {
    rankdir=LR
    a -> 1
    b -> 1
    b -> 3
    c -> 2
  }
  ```)

or $R^{-1} = {(1, a), (1, b), (3, b), (2, c)}$.
\
#raw-render(
  ```
  digraph {
    rankdir=LR
    1 -> a
    1 -> b
    3 -> b
    2 -> c
  }
  ```)
]

#pagebreak()

== Relations $R subset.eq A * A$

Relations that are subsets of the Cartesian product of a set with itself are called relations on the set.
They can have the following properties:


#definition[Reflexive: $(a, a) in R forall a in A$.]
#example[The relation $R = {(1, 1), (2, 2)} subset.eq A * A$ is reflexive.
\
#raw-render(
  ```
  digraph {
    1 -> 1
    2 -> 2
  }
  ```)
]

#definition[Transitive: $forall a, b, c in A, (a, b) in R and (b, c) in R arrow.r.double (a, c) in R$.]

#example[The relation $R = {(1, 2), (2, 3), (1, 3)} subset.eq A * A$ is transitive.
\
#raw-render(
  ```
  digraph {
    rankdir=LR
    1 -> 2
    2 -> 3
    1 -> 3
  }
  ```)
]


#definition[Symmetric: $forall a, b in A, (a, b) in R arrow.r.double (b, a) in R$.]


#example[The relation $R = {(1, 2), (2, 1)} subset.eq A * A$ is symmetric.
\
#raw-render(
  ```
  digraph {
    rankdir=LR
    1 -> 2
    2 -> 1
  }
  ```)
]

#definition[Antisymmetric: $forall a, b in A, (a, b) in R and (b, a) in R arrow.r.double a = b$.
\
or equivalently: $forall a, b in A, (a, b) in R and a != b arrow.r.double (b, a) in.not R$.]

#example[The relation $R = {(1, 2),(2, 3), (1,1)} subset.eq A * A$ is antisymmetric.

#raw-render(
  ```
  digraph {
    rankdir=LR
    1 -> 2
    2 -> 3
    1 -> 1
  }
  ```)
]

#definition[Asymmetric: $forall a, b in A, (a, b) in R arrow.r.double (b, a) in.not R$.]

#example[The relation $R = {(1, 2), (2, 3)} subset.eq A * A$ is asymmetric.
\
#raw-render(
  ```
  digraph {
    rankdir=LR
    1 -> 2
    2 -> 3
  }
  ```)
]

#statement[
A relation $R$ on a set $A$ is called an equivalence relation if it is *reflexive*,
*symmetric*, and *transitive*.
\
For $(a, b) in R$, we say that $a$ is *equivalent* to $b$ and write $a equiv b$.
]

== Equivalence classes

#definition[
Given an equivalence relation $R$ on a set $A$, the equivalence class of an element $a in A$ is the set of all elements in $A$ that are equivalent to $a$.
\
$[a]_R = {b in A | a equiv b}$
]
Given the relation $R$ is an equivalence relation on the set $A$ then the following properties hold:

#statement[
1. The equivalence classes of $R$ form a partition of $A$.
\
2. A partition of a set $A$ is a collection of nonempty, mutually disjoint subsets of $A$ whose union is $A$.
]


== Order Relations

#definition[
A relation $R$ on a set $A$ is called a order(relation) if it is *reflexive*, *antisymmetric* 
and *transitive*.
\
Often denoted by $a lt.eq b$.
]

For each order there also exists a strict order. A strict order is the result of removing the reflexive property from the order relation.

=== Strict order

#definition[
A relation $R$ on a set $A$ is called a strict order if it is *antisymmetric* and *transitive* and *not reflexive*.
]

#statement[
From each order relation $R$ there exists a strict order relation $S$ such that $a R b arrow.l.r.double.long a S b and a != b$.
From each strict order a order relation can be derived by adding the reflexive property.
]

#example[
  $A lt.eq B$ is a order relation on the set $A$.
  \
  $A lt B$ is a strict order relation on the set $A$.
]

== Comparability

Two elements $a$ and $b$ in a set $A$ are said to be comparable with respect to a relation $R$ if either $a R b$ or $b R a$.

=== Total order

#definition[
A relation $R$ on a set $A$ is called a total order if it is a order relation and for all $a, b in A$ either $a R b$ or $b R a$.
]

#statement[
  Total means that for any elements $a$ and $b$ in $A$, they are always related (they can always be compared) with respect to $R$
  $arrow.l.r.double.long a R b or b R a$.
]

=== Partial order

#definition[
A relation $R$ on a set $A$ is called a partial order if it is a order relation and for all $a, b in A$ if $a R b$ then $b R a$.
]

== closures

Closure of a relation $R$ is the smallest relation that contains $R$ and has a certain property.

=== Reflexive closure

#definition[
  The reflexive closure of a relation $R$ on a set $A$ is the smallest relation that contains $R$ and is reflexive.
  \
  A relation $R$ is reflexive if for all $a in A$, $(a, a) in R$.
]

#statement[
  The reflexive closure of a relation $R$ is $R union {(a, a) | a in A}$.
  \
  Often denoted by $[R]^"refl"$.
]

#example[
  Let $R = {(1, 2), (2, 3)} subset.eq A * A$.
  \
  The reflexive closure of $R$ is $R union {(1, 1), (2, 2), (3, 3)}$.
]

=== Transitive closure

#definition[
  The transitive closure of a relation $R$ on a set $A$ is the smallest relation that contains $R$ and is transitive.
  \
  A relation $R$ is transitive if for all $a, b, c in A$, $(a, b) in R and (b, c) in R arrow.r.double (a, c) in R$.
]

#statement[
  The transitive closure of a relation $R$ is the intersection of all transitive relations that contain $R$.
  \
  Often denoted by $[R]^"trans"$.
  \
  $[R]^"trans" = R union {(a, c) | exists b in A, (a, b) in R and (b, c) in R}$.
]

#example[
  Let $R = {(1, 2), (2, 3)} subset.eq A * A$.
  \
  The transitive closure of $R$ is $R union {(1, 3)}$.
]

=== Symmetric closure

#definition[
  The symmetric closure of a relation $R$ on a set $A$ is the smallest relation that contains $R$ and is symmetric.
  \
  A relation $R$ is symmetric if for all $a, b in A$, $(a, b) in R arrow.r.double (b, a) in R$.
]

#statement[
  The symmetric closure of a relation $R$ is $R union {(b, a) | (a, b) in R}$.
  \
  Often denoted by $[R]^"sym"$.
]

#example[
  Let $R = {(1, 2), (2, 3)} subset.eq A * A$.
  \
  The symmetric closure of $R$ is $R union {(2, 1), (3, 2)}$.
]
