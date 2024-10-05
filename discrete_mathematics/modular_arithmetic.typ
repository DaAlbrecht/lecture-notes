#import "../template.typ": *

= Modular arithmetic

#definition[
Modular arithmetic is a system of arithmetic for integers, where numbers "wrap around" upon reaching a certain value called the modulus.
]


#example[
  A common example of modular arithmetic is the 12-hour clock, where the hours are represented by numbers from 1 to 12. When the clock reaches 12, it wraps around to 1.
  If the time now is 10 o'clock and we add 5 hours, the result is 10 + 5 = 3, because 10 + 5 = 15, and 15 modulo 12 is 3.
]

#statement[
  Two integers $a$ and $b$ are said to be congruent modulo $m$ if $m$ divides their difference.
  This is denoted as $a equiv b mod(m)$.

  In other words, $a$ and $b$ leave the same remainder when divided by $m$.
]

#example[
  $7 equiv 19 mod(6)$ because $6$ divides $19 - 7 = 12$.
  \
  or equivalently, $7 mod(6) = 1$ and $19 mod(6) = 1$. So, $7 equiv 19 mod(6)$.
]

== Ring of integers modulo m

#definition[
  The ring of integers modulo $m$, denoted as $ZZ slash  m ZZ$, is the set of integers from $0$ to $m-1$.
]

#example[
  The ring of integers modulo $3$, denoted as $ZZ slash 3 ZZ$, is the set ${0, 1, 2}$.
  \
  Since the possible numbers are limited to $0,1,2$ its easy to create a table of addition and multiplication for all possible combinations.

  #stack(
    dir: ltr,
    spacing: 1.5fr,
    figure(
      caption: [Addition table],
      text(1.5em,
    table(
      columns: (auto,auto,auto,auto),
      [+],[0],[1],[2],
      [0],[0],[1],[2],
      [1],[1],[2],[0],
      [2],[2],[0],[1]
    ))),
    figure(
      caption: [Multiplication table],
    text(1.5em,table(
      columns: (auto,auto,auto,auto),
      [\*],[0],[1],[2],
      [0],[0],[0],[0],
      [1],[0],[1],[2],
      [2],[0],[2],[1]
    )))
  )
]

#pagebreak()

== Digit sum

#definition[
  The digit sum of a number is the sum of its digits.
]

#example[
  The digit sum of $123$ is $1 + 2 + 3 = 6$.
]

We can use the digit sum to determine if a number is divisible by $3 or 9$.

=== Digital root

#definition[
  The digital root of a number is the single-digit number obtained by repeatedly summing the digits of the number until a single-digit number is obtained.
]

#example[
  The digital root of $123$ is $1 + 2 + 3 = 6$.
  \
  The digital root of $12345$ is $1 + 2 + 3 + 4 + 5 = 15$, and $1 + 5 = 6$.
]

== Neutral element

#definition[
  The neutral element is an element, that when combined with another element using a binary operation, leaves the other element unchanged.
]

#statement[
  The neutral element for addition is $0$, because $a + 0 = a forall a in ZZ$.
  \
  The neutral element for multiplication is $1$, because $a * 1 = a forall a in ZZ$.
]

=== Inverse element

#definition[
  The inverse element is an element, that when combined with another element using a binary operation, results in the neutral element.
]

#statement[
  The inverse element for addition is the negative of the element, because $a + (-a) = 0 forall a in ZZ$.
  \
  \
  The inverse element for multiplication is the reciprocal of the element, because $a * (1/a) = 1 forall a in ZZ$.
]

#pagebreak()

== Neutral and inverse elements in modular arithmetic

Neutral and inverse elements can also be defined in modular arithmetic.

=== Subtraction

#statement[
  In order to subtract $b$ from $a$ in the ring of integers modulo $m$, find the inverse of $b$ and add it to $a$.
  \
  \
  The inverse of $b$ is the element $x$ such that $b + x = 0 mod(m)$.
  \
  \
  *Every* element in the ring of integers modulo $m$ has an inverse element therefore *subtraction is always possible*.
]

#example[
  If we take the ring of integers modulo $6$ ($ZZ slash 6 ZZ$), we get the following addition table:
  #text(1.5em,
  align(center)[
    #table(
    columns: (auto,auto,auto,auto,auto,auto,auto),
    [+],[0],[1],[2],[3],[4],[5],
    [0],[0],[1],[2],[3],[4],[5],
    [1],[1],[2],[3],[4],[5],[0],
    [2],[2],[3],[4],[5],[0],[1],
    [3],[3],[4],[5],[0],[1],[2],
    [4],[4],[5],[0],[1],[2],[3],
    [5],[5],[0],[1],[2],[3],[4]
  )]
  )
  In this table, each row and column contains all the elements of the ring of integers modulo $6$.
  Figures like this are called Latin squares.
  \
  \
  Since subtraction can be defined as addition of the inverse element $a + (-b)$, its possible to subtract by finding the inverse element.
  \
  \
  For example: $5 - 4 in ZZ slash 6 ZZ$
  1. Find the inverse of $4$: $ 4 + x = 0 mod(6)$. The inverse of $4$ is $2$.
  2. Add the inverse to $5$: $5 + 2 = 1 mod(6)$.
]

#pagebreak()

=== Division 

#statement[
  In order to divide $a$ by $b$ in the ring of integers modulo $m$, find the inverse of $b$ and multiply it by $a$.
  \
  \
  The inverse of $b$ is the element $x$ such that $b * x = 1 mod(m)$.
  \
  \
  *Not every* element in the ring of integers modulo $m$ has an inverse element therefore *division is not always possible*.
]

#example[
  If we take the ring of integers modulo $6$ ($ZZ slash 6 ZZ$), we get the following multiplication table:
  #text(1.5em,
  align(center)[
    #table(
    columns: (auto,auto,auto,auto,auto,auto,auto),
    [\*],[0],[1],[2],[3],[4],[5],
    [0],[0],[0],[0],[0],[0],[0],
    [1],[0],[1],[2],[3],[4],[5],
    [2],[0],[2],[4],[0],[2],[4],
    [3],[0],[3],[0],[3],[0],[3],
    [4],[0],[4],[2],[0],[4],[2],
    [5],[0],[5],[4],[3],[2],[1]
  )]
  )
  In this table, not every element has a reciprocal element. For example, $2$ does not have a reciprocal element.
  \
  \
  therefore, division is only possible for the elements $1, 5$ in the ring of integers modulo $6$.
]

#pagebreak()

In order to find a ring of integers modulo $m$ where division is possible for all elements, $m$ must be a prime number.

#example[
   $7$ ($ZZ slash 7 ZZ$), we get the following multiplication table, that shows that every element has a reciprocal element.
  #text(1.5em,
  align(center)[
    #table(
    columns: (auto,auto,auto,auto,auto,auto,auto),
    [\*],[1],[2],[3],[4],[5],[6],
    [1],[1],[2],[3],[4],[5],[6],
    [2],[2],[4],[6],[1],[3],[5],
    [3],[3],[6],[2],[5],[1],[4],
    [4],[4],[1],[5],[2],[6],[3],
    [5],[5],[3],[1],[6],[4],[2],
    [6],[6],[5],[4],[3],[2],[1]
  )]
  )
]

For smaller numbers, its easy to find the inverse element by trial and error or by writing out the multiplication table.
For larger numbers, the Extended Euclidean Algorithm can be used to find the inverse element.

#definition[
  In order for $a$ to have an inverse element $x$ in the ring of integers modulo $m$, $a$ and $m$ must be coprime.
  This means that the greatest common divisor of $a$ and $m$ must be $1$ ($gcd(a, m) = 1$).
]

#statement[
  Since $a$ and $m$ are coprime, there exists integers $x$ and $y$ such that $a x + m y = 1$.
  \
  \
  To find the inverse element $x$, we can use the Extended Euclidean Algorithm.
]
