#import "@preview/diagraph:0.3.0": *
#import "../template.typ": *
#set table(
  fill: (x, y) =>
    if y == 0 {
      gray.lighten(40%)
    },
  align: right,
)


= Graph Theory

== Basic Definitions

#definition[
  A Graph $G$ is a pair $G = (V, E)$ where $V$ is a set of vertices and $E$ is a set of edges $brace.l a, b brace.r$ where $a, b in V, a eq.not b$.
]

An edge $e = brace.l a, b brace.r$ always connects two vertices $a$ and $b$. The vertices $a$ and $b$ are called the *endpoints* of the edge $e$.

#example[
  A graph $G = (V, E)$ with $V = brace.l a, b, c, d brace.r$ and $E = brace.l brace.l a, b brace.r, brace.l b, c brace.r, brace.l a, d brace.r brace.r, brace.l d, b brace.r brace.r$.
#raw-render(
  ```
  graph {
    rankdir=LR
    a -- b
    b -- c
    a -- d
    d -- b
  }
  ```)
]

#definition[
  A graph $H = (V, E)$ is a *subgraph* of a graph $G = (V', E')$ if $V subset V'$ and $E subset E'$.
]

#example[
  A graph $G = (V, E)$ with $V = brace.l a, b, c, d brace.r$ and $E = brace.l brace.l a, b brace.r, brace.l b, c brace.r, brace.l a, d brace.r brace.r,
  brace.l d, b brace.r brace.r$ 
  \
  has a subgraph $H = (V', E')$ with $V' = brace.l a, b, c brace.r$ and $E' = brace.l brace.l a, b brace.r, brace.l b, c brace.r brace.r, brace.l a, c brace.r$.
#raw-render(
  ```
  graph {
    rankdir=LR
    a -- b
    b -- c
    a -- c
  }
  ```)
]

To reduce confusion, graphs are often drawn so that the edges do not cross each other. For all graphs that this is possible, the graph is called a *planar graph*.

#pagebreak()

According to our previous definition, a graph can not have an edge that connects a vertex to itself. However, in some cases, it is useful to allow such edges. A graph that allows edges to connect a vertex to itself or
multiple edges between the same vertices is called a *multigraph*.

#example[
  A graph $G = (V, E)$ with $V = brace.l a, b, c brace.r$ and $E = brace.l brace.l a, c brace.r, brace.l a, b brace.r, brace.l c, c brace.r brace.r$.
#raw-render(
  ```
  graph {
    rankdir=LR
    a -- c
    a -- b
    c -- c
  }
  ```)
]

#pagebreak()

#table(
  columns: (auto,2fr,1.5fr),
  align: (center,left,left),
  table.header(
    [Term], [Definition], [Example]
  ),
  [Vertex], [A point in a graph], $a$,
  [Edge], [A connection between two vertices], $brace.l a, b brace.r$,
  [Subgraph], [A graph that is a subset of another graph], $H = (V', E')$,
  [Planar Graph], [A graph that can be drawn without edges crossing], render("graph { a -- b }"),
  [Multigraph], [A graph that allows edges to connect a vertex to itself or multiple edges between the same vertices],[#render("graph { a--a a--b  b--a }") 
    $E = brace.l brace.l a, a brace.r, brace.l a, b brace.r, brace.l b, a brace.r brace.r$],
  [Loop], [An edge that connects a vertex to itself], render("graph { a -- a }"),
  [Adjacent], [Two vertices are adjacent if they are connected by an edge], [#render("graph { a -- b }") $a$ and $b$ are adjacent],
  [Incident (edges)], [Two edges are incident if they share a vertex], [#render("graph { a -- b a -- c }") $brace.l a, b brace.r$ and $brace.l a, c brace.r$ are incident],
  [Incident (vertex)], [An edge is incident to a vertex if the vertex is an endpoint of the edge], [#render("graph { a -- b a -- c }") $a$ is incident to $brace.l a, b brace.r$],
  [Degree], [The number of edges incident to a vertex], [#render("graph { a -- b a -- c }") The degree of $a$ is $2$],
  [Isolated Vertex], [A vertex with degree $0$], [#render("graph { a }") $a$ is an isolated vertex],
)

#statement[
  Given a graph $G = (V, E)$, the sum of the degrees of all vertices is equal to twice the number of edges.
  $ sum_(v in V) deg(v) = 2 |E| $
]

It is important to note that in a multigraph with loops, each loop contributes $+2$ to the degree of the vertex it is incident to.

#pagebreak()

#statement[
  In each graph, the number of vertices with odd degree is even.
]

This must be the case because the sum of the degrees of all vertices is equal to twice the number of edges. Since the sum of the degrees is even (due to the factor of $2$), the number of vertices with odd degree must be even (odd + odd = even).

#example[
  In the graph $G = (V, E)$ with $V = brace.l a, b, c, d brace.r$ and $E = brace.l brace.l a, b brace.r, brace.l b, c brace.r, brace.l a, d brace.r brace.r, brace.l d, b brace.r brace.r$,

  #raw-render(
    ```
    graph {
      rankdir=LR
      a -- b
      b -- c
      a -- d
      d -- b
    }
    ```
  )
  the vertices $a$ and $d$ have an even degree, while $b$ and $c$ have an odd degree.
]

=== Equivalency of Graphs

Two graphs are considered equivalent if they have the same number of vertices and edges, and the edges are connected in the same way.

#definition[
  Two graphs $G = (V, E)$ and $H = (V', E')$ are *isomorphic* if there is a bijection $f: V -> V'$ such that $brace.l a, b brace.r in E$ if and only if $brace.l f(a), f(b) brace.r in E'$.
]

#example[
  The graphs $G = (V, E)$ and $H = (V', E')$ with $V = brace.l a, b, c brace.r$, $V' = brace.l x, y, z brace.r$, $E = brace.l brace.l a, b brace.r, brace.l b, c brace.r brace.r$, and $E' = brace.l brace.l x, y brace.r, brace.l y, z brace.r brace.r$ are isomorphic.
#raw-render(
  ```
  graph {
    rankdir=LR
    a -- b
    b -- c
  }
  ```
)
#raw-render(
  ```
  graph {
    rankdir=LR
    x -- y
    y -- z
  }
  ```
)

The bijection $f$ is defined as $f(a) = x$, $f(b) = y$, and $f(c) = z$.
]

#pagebreak()

=== Directed Graphs

In a directed graph, the edges have a direction. An edge $e = brace.l a, b brace.r$ is directed from $a$ to $b$. The vertex $a$ is called the *tail* of the edge, and the vertex $b$ is called the *head* of the edge.

#example[
  A directed graph $G = (V, E)$ with $V = brace.l a, b, c brace.r$ and $E = brace.l brace.l a, b brace.r, brace.l b, c brace.r, brace.l c, a brace.r brace.r$.

#raw-render(
  ```
  digraph {
    rankdir=LR
    a -> b
    b -> c
    c -> a
  }
  ```
)
]

== Representation of Graphs in Computers

=== Matrix Representation

Graphs can be represented in computers in different ways. One common representation is the *adjacency matrix*.

#definition[
  The *adjacency matrix* of a graph $G = (V, E)$ is a matrix $A$ of size $|V| times |V|$ 
  where $ A_(i j) = 1$ if there is an edge between vertices $v_i$ and $v_j$, and $0$ otherwise.
]

#example[
  The adjacency matrix of the graph $G = (V, E)$ with $V = brace.l a, b, c brace.r$ and $E = brace.l brace.l a, b brace.r, brace.l b, c brace.r, brace.l c, a brace.r brace.r$ is:
  $
  #raw-render(
    ```
    graph {
      rankdir=LR
      a -- b
      b -- c
      c -- a
    }
    ```
  )
  mat(
    0 , 1 , 1;
    1 , 0 , 1;
    1 , 1 , 0;
  )
  $
]

#definition[
  The *Incidence Matrix* of a graph $G = (V, E)$ is a matrix $A$ of size $|V| times |E|$ 
  where $ A_(i j) = 1$ if vertex $v_i$ is incident to edge $e_j$, and $0$ otherwise.
]

#example[
  The incidence matrix of the graph $G = (V, E)$ with $V = brace.l a, b, c brace.r$ and $E = brace.l brace.l a, b brace.r, brace.l b, c brace.r, brace.l c, a brace.r brace.r$ is:
  $
  #raw-render(
    ```
    graph {
      rankdir=LR
      a -- b
      b -- c
      c -- a
    }
    ```
  )
  mat(
    1 , 0 , 1;
    1 , 1 , 0;
    0 , 1 , 1;
  )
  $
]

#pagebreak()

=== List Representation

Another common representation is the *adjacency list*.

#definition[
  The *adjacency list* of a graph $G = (V, E)$ is a list of size $|V|$ where each element $A[i]$ is a list of vertices adjacent to vertex $v_i$.
]

#example[
  The adjacency list of the graph $G = (V, E)$ with $V = brace.l a, b, c brace.r$ and $E = brace.l brace.l a, b brace.r, brace.l b, c brace.r, brace.l c, a brace.r brace.r$ is:
  #raw-render(
    ```
    graph {
      rankdir=LR
      a -- b
      b -- c
      c -- a
    }
    ```
  )

  #table(
    columns: 2,
    align: (center,left),
    stroke: none,
    table.header(
      [Vertex], [Adjacent Vertices]
    ),
    table.hline(start: 0),
    table.vline(x: 1),
    [a], [b, c],
    [b], [a, c],
    [c], [a, b],
  )
]

The adjacency list representation is more space-efficient than the adjacency matrix representation for sparse graphs,
because the number of elements in an adjacency list is twice the number of edges, while the number of elements in an adjacency matrix is $|V|^2$.
