#import "../template.typ": *
#import "@preview/diagraph:0.2.5": *

#show: project.with(title: "Relation")

= Cartesian product

#definition[The Cartesian product of two sets $A$ and $B$ is the set of all ordered pairs $(a, b)$ where $a$ is an element of $A$ and $b$ is an element of $B$.
\
$ A * B =  {(a,b) bar.v a in A and b in B}$]

#example[The Cartesian product of the sets $A = {1, 2}$ and $B = {3, 4}$ is:\
$A * B = {(1, 3), (1, 4), (2, 3), (2, 4)}$.]


= Relation

#definition[A relation $R$ from a set $A$ to a set $B$ is a subset of the Cartesian product $A * B$.
\
$R subset.eq A * B$]

#example[Let $A = {1, 2}$ and $B = {3, 4}$. The relation $R = {(1, 3), (2, 4)}$ is a relation from $A$ to $B$.]

For $(a, b) in R$, we write $a R b$, and say that $a$ is in relation $R$ to $b$.


= Inverse relation

#definition[The inverse relation $R^{-1}$ of a relation $R$ is the relation that contains the ordered pairs of $R$ in reverse order.
\
$R^{-1} = {(b, a) | (a, b) in R}$]

#example[Let $R = {(1, 3), (2, 4)}$. The inverse relation $R^{-1}$ is:\
$R^{-1} = {(3, 1), (4, 2)}$.]


= Composition of relations

#definition[
Given the relation $R subset.eq A * B$ and $S subset.eq B * C$,
the composition of $R compose S$ is the relation from $A$ to $C$ defined by:
\
\
$R compose S = {(a, c) | exists b in B, (a, b) in R and (b, c) in S}$]

#pagebreak()
= Representation of relations

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

= Relations $R subset.eq A * A$




= Glossary of mathematical symbols

#table(
  columns: (auto, auto, auto),
  inset: 10pt,
  align: horizon,
  table.header(
    [*Symbol*],
    [*Usage*],
    [*Description*],
  ),
)
