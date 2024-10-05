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

==== Multigraphs

In the adjacency matrix of a multigraph, the value of $A_(i j)$ is the number of edges between vertices $v_i$ and $v_j$.

#example[
  The adjacency matrix of the multigraph $G = (V, E)$ with $V = brace.l a, b, c brace.r$ and $E = brace.l a a, a b, b a, b c, c a, a c brace.r$ is:
  $
  #raw-render(
    ```
    graph {
      rankdir=LR
      a -- a
      a -- b [label=" "]
      b -- a [label=" "]
      b -- c
      c -- a
      a -- c
    }
    ```
  )
  mat(
    2 , 2 , 2;
    2 , 0 , 1;
    2 , 1 , 0;
  )
  $
]



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


#pagebreak()

= Cycles and Paths

Given the following graph $G = (V, E)$
\
$V = brace.l a, b, c, d, e brace.r , E = brace.l a b, a d, a c, b d, b c, d c, d e, c e brace.r$:

#raw-render(
  ```
  graph {
    rankdir=LR
    a -- b
    a -- d
    a -- c
    b -- d
    b -- c
    d -- c
    d -- e
    c -- e
  }
  ```
)

In this graph, there are multiple paths from the vertex $a$ to the vertex $e$. One such path could be $a d, d c, c b, b d, d e$.
This path is called a *walk*.

#definition[
  a walk is a sequence of incident edges in a graph.

  Properties of a walk:
   - A walk is called *closed* if the start and end vertices are the same.
   - The number of edges in a walk is called the *length* of the walk.
]

#example[
  $a, d, c, b, d, e$ is a walk of length $5$ in the graph $G$.
]

#definition[
  A *trail* is a walk where no edge is repeated.
]

#example[
  $a, d, c, b, d, e$ is a trail in the graph $G$.
]


#definition[
  A *path* is a trail where no vertex is repeated.
]

#example[
  $a, d, c, e$ is a path in the graph $G$.
]

#definition[
  A *cycle* is a non-empty trail where the start and end vertices are the same.
]

#example[
  $a, d, c, b, a$ is a cycle in the graph $G$.
]

== Calculating the Number of Paths

The number of paths of length $k$ between two vertices $a$ and $b$ can be calculated using the adjacency matrix $A$ of the graph.

#statement[
  The number of paths of length $k$ between vertices $a$ and $b$ is the value of $A^k_(a b)$.
]

#example[
  Given is the following adjacency matrix $A$ that does not contain weights:
  $
  A = mat(
    0 , 1 , 0 , 0;
    1 , 0 , 1 , 0;
    0 , 0 , 0 , 1;
    0 , 0 , 1 , 0;
  )
  $
  We are looking for the number of paths of length $3$ between vertices $2$ and $3$.
  For this, we calculate $A^3$:
  $
  A^2 = mat(
    1 , 0 , 1 , 0;
    0 , 1 , 0 , 1;
    0 , 0 , 1 , 0;
    0 , 0 , 0 , 1;
  )
  $
  $
  A^3 = mat(
    0 , 1 , 0 , 1;
    1 , 0 , 2 , 0;
    0 , 0 , 0 , 1;
    0 , 0 , 1 , 0;
  )
  $

  The value of $A^3_(2 3)$ is $2$, which means that there are $2$ paths of length $3$ between vertices $2$ and $3$.
]

#pagebreak()

#definition[
  In an undirected graph $G = (V, E)$, two vertices $a$ and $b$ are called *connected* if $G$ contains a path from $a$ to $b$.
  If a graph contains a path between every pair of vertices, it is called *connected*.
]

#example[
  The graph $G = (V, E)$ with $V = brace.l a, b, c, d brace.r$ and $E = brace.l a b, a d, a c, b d, b c, d c brace.r$ is connected.
#raw-render(
  ```
  graph {
    rankdir=LR
    a -- b
    a -- d
    a -- c
    b -- d
    b -- c
    d -- c
  }
  ```
)
]

#definition[
  A maximal connected subgraph of a graph $G$ is called a *connected component*.
]

#example[
  The graph $G = (V, E)$ with $V = brace.l a, b, c, d, e brace.r$ and $E = brace.l a b, a d brace.r$ has three connected components.
#raw-render(
  ```
  graph {
    rankdir=LR
    a -- b
    a -- d
    c
    e
  }
  ```
)
The connected components are $brace.l a, b, d brace.r$, $brace.l c brace.r$, and $brace.l e brace.r$.
]

#definition[
  A graph is called *disconnected* if it contains more than one connected component.
]

#pagebreak()

== Breadth-First Search (BFS)

Breadth-First Search (BFS) is an algorithm used to traverse graphs. It starts at a given vertex and explores all of its neighbors at the present depth before moving on to the vertices at the next depth level.

*Algorithm:*

1. Determine the starting vertex $s$, mark it as visited, and add it to the queue.
2. Take the first vertex $v$ from the queue:
  - If $v$ is the target vertex, the search is complete.
  - Otherwise, add all unvisited neighbors of $v$ to the queue and mark them as visited.
3. Repeat step 2 until the queue is empty.
4. If the queue is empty and the target vertex has not been found, the target vertex is not reachable from the starting vertex.


To check if a graph is connected, we can start a BFS from any vertex and check if all vertices are visited at the end.

#statement[
  A connected graph with $n$ vertices has at least $n-1$ edges.

  A graph with more than $((n-1)(n-2))/2$ edges is connected.
]

Another way to check if a graph is connected is by checking the adjacency matrix. If the matrix $A^k$ contains only non-zero values, the graph is connected.

#pagebreak()

=== Eulerian Paths and Cycle

#definition[
  An *Eulerian path* is a path that visits every edge exactly once.
]

#example[
  The graph $G = (V, E)$ with $V = brace.l a, b, c, d brace.r$ and $E = brace.l a b, a d, a c, b d, b c, d c brace.r$ has an Eulerian path $a, b, d, c, a, d, b, c$.
#raw-render(
  ```
  graph {
    rankdir=LR
    a -- b
    a -- d
    a -- c
    b -- d
    b -- c
    d -- c
  }
  ```
)
]

#statement[
  A connected (Multi)graph has an Eulerian cycle if and only if all vertices have an even degree.
]

=== Fleury’s Algorithm

Fleury's algorithm is an algorithm used to find an Eulerian cycle in a graph.

*Algorithm:*

1. Start at any vertex $v$.
2. While there are unvisited edges in the graph:
  - If $v$ has no neighbors, add $v$ to the cycle and remove it from the graph.
  - If $v$ has neighbors, choose the neighbor $u$ that is not a bridge (an edge whose removal would disconnect the graph) if possible.
  - Add the edge $v-u$ to the cycle and remove it from the graph.
  - Set $v = u$.
3. The cycle is complete when all edges have been visited.


=== Hamiltonian Cycle

#definition[
  A *Hamiltonian cycle* is a cycle that visits every vertex exactly once.
]

#statement[
  In a graph with $n$ vertices, a Hamiltonian cycle must exists if a minimum of $1/2(n-1)(n-2)+2$ edges are present.
]

#pagebreak()

= Trees

#definition[
  A *tree* is a connected graph with no cycles.
]

#example[
  The graph $G = (V, E)$ with $V = brace.l a, b, c, d brace.r$ and $E = brace.l a b, a d, a c brace.r$ is a tree.
  #raw-render(
  ```
  graph {
    rankdir=LR
    a -- b
    a -- d
    a -- c
  }
  ```
  )

  The graph $H = (V, E)$ with $V = brace.l a, b, c, d brace.r$ and $E = brace.l a b, a d, a c, b d brace.r$ is not a tree because it contains a cycle.

  #raw-render(
  ```
  graph {
    rankdir=LR
    a -- b [color=red]
    a -- d [color=red]
    a -- c
    b -- d [color=red]
  }
  ```
)
]

#definition[
  If all connected components of a graph are trees, the graph is called a *forest*.
]

#statement[
  A connected graph $G$ with $n$ vertices is a tree if and only if:
  - $G$ has $n-1$ edges.
  - If one edge is removed from $G$, it becomes disconnected.
  - Between any two vertices in $G$, there is exactly one path.
]

#pagebreak()

#definition[
  A *spanning tree* of a graph $G$ is a subgraph that is a tree and contains all vertices of $G$.
]

#example[
  The graph $G = (V, E)$ with $V = brace.l a, b, c, d, e, f brace.r$ and $E = brace.l a b, a d, a c, b d, f a, f b brace.r$
  has a spanning tree $T = (V, E')$ with $V = brace.l a, b, c, d, e, f brace.r$ and $E' = brace.l  a d, a c, f a, f b brace.r$.

  $G$:
  #raw-render(
  ```
  graph {
    rankdir=LR
    a -- b
    a -- d
    a -- c
    b -- d
    f -- a
    f -- b
  }
  ```
)

  $T$:
  #raw-render(
  ```
  graph {
    rankdir=LR
    a -- d
    a -- c
    f -- a
    f -- b
  }
  ```
)
]

== Naming

#table(
  columns: (auto,1.5fr,1.5fr),
  align: (center,left,left),
  table.header(
    [Term], [Definition], [Example]
  ),
  [root], [A vertex with no incoming edges], [#render("graph { a -- b a -- c }") $a$ is the root],
  [leaf], [A vertex with no outgoing edges], [#render("graph { a -- b b -- c }") $c$ is a leaf],
  [level], [The distance from the root], [#render("graph { a -- b a -- c b -- d }") $a$ is level $0$, $b$ is level $1$, $c$ is level $1$, $d$ is level $2$],
  [parent], [A vertex $v$ is the parent of vertex $u$ if there is an edge $v-u$], [#render("graph { a -- b a -- c b -- d }") $a$ is the parent of $b$],
  [child], [A vertex $u$ is a child of vertex $v$ if there is an edge $v-u$], [#render("graph { a -- b a -- c b -- d }") $b$ is a child of $a$],
  [sibling], [Two vertices that share the same parent], [#render("graph { a -- b a -- c b -- d c -- d }") $b$ and $c$ are siblings],
  [ancestor], [A vertex $v$ is an ancestor of vertex $u$ if there is a path from $v$ to $u$], [#render("graph { a -- b a -- c b -- d }") $a$ is an ancestor of $d$],
  [descendant], [A vertex $u$ is a descendant of vertex $v$ if there is a path from $v$ to $u$], [#render("graph { a -- b a -- c b -- d }") $d$ is a descendant of $a$],
  [binary tree], [A tree where each vertex has at most two children], [#render("graph { a -- b a -- c b -- d }")],
)
#pagebreak()

== Binary Search Trees

#definition[
  A *binary search tree* (BST) is a binary tree where each vertex has at most two children, and the left child of a vertex contains a value less than the vertex, while the right child contains a value greater than the vertex.
]


#example[
  The following binary tree is a binary search tree:
  #raw-render(
  ```
  graph {
      8 -- 3
      8 -- 10
      3 -- 1
      3 -- 6
      6 -- 4
      6 -- 7
      10 -- 14
      14 -- 13
  }
  ```
)
]

=== Operations

#definition[
  *Search*: To find a value in a binary search tree, start at the root and compare the value with the current vertex. If the value is less than the current vertex, move to the left child. If it is greater, move to the right child. Repeat this process until the value is found or corresponding subtree is empty, then the value is not in the tree.

  *Insert*: To insert a value into a binary search tree, search for the value. If the value is not found, insert it as a leaf at the position where the search ended.

  *Delete*: To delete a value from a binary search tree, search for the value. If the value is found:
    - If the vertex has no children, remove the vertex.
    - If the vertex has one child, replace the vertex with its child.
    - If the vertex has two children, replace the vertex with the smallest value in the right subtree.
]

#statement[
  The maximum amount of comparisons needed to search for a value in a binary search tree with length $n$ is $n + 1$.
]

The time complexity of searching, inserting, and deleting in a binary search tree is $O(h)$, where $h$ is the height of the tree.
This makes it crucial to ensure the height is minimized. The height of a tree is highly dependent on the order of insertion and deletion operations.

#example[
  A Binary Search Tree with the values $brace.l 4, 8, 9, 14, 16, 20, 25, 31 brace.r$:

  worst case height: 7
  #raw-render(
  ```
  graph {
    rankdir=LR
    4 -- 8
    8 -- 9
    9 -- 14
    14 -- 16
    16 -- 20
    20 -- 25
    25 -- 31
  }
  ```,
  width: 100%
)

compact height: 3
  #raw-render(
  ```
  graph {
    rankdir=TD
    14 -- 8
    8 -- 4
    8 -- 9
    14 -- 20
    20 -- 16
    20 -- 25
    25 -- 31
  }
  ```,
)
]

One method to try to minimize the height of a binary search tree is a *devided and conquer* approach. This approach involves inserting the median value of the list as the root, then recursively inserting the median value of the left and right sublists as the left and right children of the root.

#pagebreak()

#statement[
  In a binary search tree with length $l$, is the maximum data that can be stored:
  $
  n = sum_(k=0)^(l) 2^k = 2^(l+1) - 1
  $
  Resulting in a search time of $O(log_2(n))$.
]


