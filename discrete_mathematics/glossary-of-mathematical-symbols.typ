= Glossary of Mathematical Symbols

This is a glossary of the mathematical symbols used in this document.

== Set Theory

#table(
  columns: (auto,auto,2fr),
  align: (center,center,left),
  table.header(
    [Symbol], [Usage], [Interpretation]
  ),
  $emptyset$,${ }$,"The empty set",
  ${ }$,${a,b,c...}$,[A set containing elements $a$, $b$, and $c$ (and so on)],
  $bar.v$, ${a bar.v T(a)}$,[The set of all $a$ such that $T(a)$ is true],
  $:$,${a:T(a)}$,[The set of all $a$ such that $T(a)$ is true],
)

== Set Operations

#table(
  columns: (auto,auto,2fr),
  align: (center,center,left),
  table.header(
    [Symbol], [Usage], [Interpretation]
  ),
  $union$,${A union B}$,[The union of sets $A$ and $B$],
  $sect$,${A sect B}$,[The intersection of sets $A$ and $B$],
  $union.dot$,${A union.dot B}$,[Union of disjoint sets A and B],
)

== Set Relations

#table(
  columns: (auto,auto,2fr),
  align: (center,center,left),
  table.header(
    [Symbol], [Usage], [Interpretation]
  ),
  $in$,${a in A}$,[The element $a$ is in the set $A$],
  $in.not$,${a in.not A}$,[The element $a$ is not in the set $A$],
  $subset$,${A subset B}$,[The set $A$ is a subset of the set $B$],
  $subset.eq$,${A subset.eq B}$,[The set $A$ is a subset of or equal to the set $B$],
  $eq.not$,${A eq.not B}$,[The set $A$ is not equal to the set $B$],
)

== Blackboard bold

#table(
  columns: (auto,1fr),
  align: (center,left),
  table.header(
    [Symbol],  [Interpretation]
  ),
  $NN$,"The set of natural numbers",
  $ZZ$,"The set of integers",
  $ZZ p $,[The set of integers where $p$ is a prime number],
)

== Equality, equivalence and similarity

#table(
  columns: (auto,auto,2fr),
  align: (center,center,left),
  table.header(
    [Symbol], [Usage], [Interpretation]
  ),
  $eq$,$a eq b$,[The elements $a$ and $b$ are equal],
  $eq.not$,$a eq.not b$,[The elements $a$ and $b$ are not equal],
  $equiv$,$a equiv b$,[The elements $a$ and $b$ are equivalent],
  $equiv.not$,$a equiv.not b$,[The elements $a$ and $b$ are not equivalent],
)

#pagebreak()

== Comparison

#table(
  columns: (auto,auto,2fr),
  align: (center,center,left),
  table.header(
    [Symbol], [Usage], [Interpretation]
  ),
  $lt$,$a lt b$,[The element $a$ is less than $b$],
  $gt$,$a gt b$,[The element $a$ is greater than $b$],
  $lt.eq$,$a lt.eq b$,[The element $a$ is less than or equal to $b$],
  $gt.eq$,$a gt.eq b$,[The element $a$ is greater than or equal to $b$],
)

== Divisibility

#table(
  columns: (auto,auto,2fr),
  align: (center,center,left),
  table.header(
    [Symbol], [Usage], [Interpretation]
  ),
  $divides$,$a divides b$,[The element $a$ divides $b$],
  $divides.not$,$a divides.not b$,[The element $a$ does not divide $b$],
)

== Relations

#table(
  columns: (auto,auto,2fr),
  align: (center,center,left),
  table.header(
    [Symbol], [Usage], [Interpretation]
  ),
  $compose$,$R compose S$,[The composition of relations $R$ and $S$],
  $lt.eq$,$a lt.eq b$,[Order relation between elements $a$ and $b$],
  $tilde.basic$,$a tilde.basic b$,[Equivalence relation between elements $a$ and $b$],
  $bracket.l thin bracket.r$,$bracket.l a bracket.r$,[The equivalence class of element $a$],
  $space^(-1)$,$R^(-1)$,[The inverse of relation $R$],
  $space^+ $,$R^+ $,[The transitive closure of relation $R$],
  $space^*$,$R^*$,[The reflexive-transitive closure of relation $R$],
)

== Logical Operators

#table(
  columns: (auto,auto,2fr,1fr),
  align: (center,center,left,left),
  table.header(
    [Symbol], [Usage], [Interpretation], [Colloquially]
  ),
  $and$,$a and b$,[The logical conjunction of $a$ and $b$],[Both $a$ and $b$],
  $or$,$a or b$,[The logical disjunction of $a$ and $b$],[Either $a$ or $b$ or both],
  $not$,$not a$,[The logical negation of $a$],[Not $a$],
  $arrow.r.l.double$,$a arrow.r.l.double b$,[The logical implication from $a$ to $b$ and $b$ to $a$], [If $a$ then $b$ and if $b$ then $a$],
  $arrow.r.double$,$a arrow.r.double b$,[The logical implication from $a$ to $b$],[If $a$ then $b$],
)

== Quantifiers

#table(
  columns: (auto,auto,2fr),
  align: (center,center,left),
  table.header(
    [Symbol], [Usage], [Interpretation]
  ),
  $forall$,$forall a$,[For all elements $a$],
  $exists$,$exists a$,[There exists an element $a$],
  $exists !$,$exists ! a$,[There exists exactly one element $a$],
  $exists.not$,$exists.not a$,[There does not exist an element $a$],
)
