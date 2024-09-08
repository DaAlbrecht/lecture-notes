#import "../template.typ": *

= Greatest Common Divisor

#definition[
Each number has at least two divisors: 1 and itself.
]

#statement[
  #align(center)[
  $d bar.v a arrow.r.double a = d * k$ for some integer $k$.]
  This means the divisors $d$ can not be larger than $a$ itself.
]

#example[
The divisors of $12$ are $1, 2, 3, 4, 6, 12$.

$1 * 12 = 12$, $2 * 6 = 12$, $3 * 4 = 12$, $4 * 3 = 12$, $6 * 2 = 12$, $12 * 1 = 12$.
]

#definition[
A common divisor of two numbers is a number that divides both numbers.
This means a common divisor of $a$ and $b$ is a number $d$ that divides both $a$ and $b$.
]

#example[
The common divisors of $12$ and $18$ are $1, 2, 3, 6$.

$1 * 12 = 12$, $2 * 6 = 12$, $3 * 4 = 12$, $6 * 2 = 12$.

$1 * 18 = 18$, $2 * 9 = 18$, $3 * 6 = 18$, $6 * 3 = 18$.
]

#definition[
The greatest common divisor of two numbers is the largest number that divides both numbers denoted as $gcd(a, b)$.
]

In order to find the greatest common divisor of two numbers, the Euclidean Algorithm can be used.

#pagebreak()
== Euclidean Algorithm

The Euclidean Algorithm is an efficient method to find the greatest common divisor of two numbers.
It is based on the fact that a common divisor of two numbers is also a divisor of their sum and difference.

#example[
    $a = 42$, $b = 66$.

    A common divisor of $42$ and $66$ is for example $#text(fill: blue,"3")$. $#text(fill: blue,"3") * 14 = 42$ and $#text(fill: blue,"3") * 22 = 66$.

    For sum and difference the following holds:

    $108 = 42 + 66 = #text(fill: blue,"3") * 14 + #text(fill: blue,"3") * 22 = #text(fill: blue,"3") * (14 + 22) = #text(fill: blue,"3") * 36$.

    $24 = 66 - 42 = #text(fill: blue,"3") * 22 - #text(fill: blue,"3") * 14 = #text(fill: blue,"3") * (22 - 14) = #text(fill: blue,"3") * 8$.
]


=== Algorithm

The Euclidean algorithm works as follows:

#example[
  $gcd(400,225)$ 

  #table(
    columns: (1fr, 2fr),
    align: (left, right),
    [$400 - 225$],[$400 - 225 = 175$],
    [#h(3em) $225 - 175$],[$225 - 175 = 50$],
    [#h(5.8em) $175 - 50$],[$175 - 50 = 125$],
    [#h(5.8em) $125 - 50$],[$125 - 50 = 75$],
    [#h(5.8em) $75 - 50$],[$75 - 50 = 25$],
    [#h(8.2em) $50 - 25$],[$50 - 25 = 25$],
    [#h(8.2em) $25 - 25$],[$25 - 25 = 0$]
  )

  $gcd(400,225) = 25$.
]

#statement[
  #align(center)[
    $d bar.v (alpha * a +  beta * b) quad  forall alpha, beta  in ZZ$.
  ]
  Every term of the form $alpha *a + beta * b$ is a multiple of $d$ if both $a$ and $b$ are multiples of $d$.
  Such terms are called *linear combinations* of $a$ and $b$.
]

#pagebreak()
== Extended Euclidean Algorithm

#definition[
The Extended Euclidean Algorithm calculates in addition to the greatest common divisor (gcd) of integers $a$ and $b$, also the coefficients of Bézout's identity, which are integers $x$ and $y$ such that
#align(center)[
    $a * x + b * y = gcd(a, b)$.
  ]
]

#example[
  Given the same example as before: $a = 400$, $b = 225$.

  The Extended Euclidean Algorithm calculates the coefficients $x$ and $y$ such that $a * x + b * y = gcd(a, b)$.
]

#example[
  #table(
    columns: (1fr),
    align: (left),
    stroke: none,
    [$400 - 225$],
    [#h(3em) $225 - #text(fill: red, "175")$],
    [#h(5.8em) $175 - #text(fill: red,"50")$],
    [#h(5.8em) $#text(fill: red, "125") - 50$],
    [#h(5.8em) $#text(fill: red,"75") - 50$],
    [#h(8.2em) $50 - #text(fill: red,"25")$],
    [#h(8.2em) $25 - #text(fill: red,"25")$],
  )

  $gcd(400,225) = 25$.

  Now the coefficients $x$ and $y$ can be calculated by working backwards:

  $25 = 50 - #text(fill: red,"25")\
      = 50 - (75 - 50) = 2 * 50 - #text(fill: red,"75")\
      = 2 * 50 - (125 - 50) = 3 * 50 - #text(fill: red,"125")\
      = 3 * 50 - (175 - 50) = 4 * #text(fill: red,"50") - 175\
      = 4 * (225 - 175) - 175 = 4 * 225 - 5 * #text(fill: red,"175")\
      = 4 * 225 - 5 * (400 - 225)\
      = 9 * 225 - 5 * 400
  $
]
