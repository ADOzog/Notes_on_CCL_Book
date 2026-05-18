// St. Hubertus: Pray for us
// St. Carlo-Acutis: Pray for us
#show title: set align(center)
#set math.equation(numbering: "1")
#set page(numbering: " 1 of 1")
//#set page(numbering: "-1-")
//#set heading(numbering: "1.")
#show heading:underline
#set text(size: 12pt)
#set par(justify: true)


// My macros
#let P = $scr(P)$

#title[Notes and Exercises from _Computability, Complexity, and Languages_ \ by Martin D. Davis et al.]
#align(center)[Anthony Ozog]

== Chapter 2: Programs and Computable Functions
=== Section 1. A Programming Languages
#align(center)[*Notes*]
The first programming language that is defined is pretty simple. It only has the following parts
$
V arrow.l V + 1& #h(.5in)"Increment"\
V arrow.l V - 1& #h(.5in)"Decrement*"\
"IF" V eq.not 0 "GOTO" A& #h(.5in)"Conditional Branch"\
$
$"*"$ If $V = 0$ then keep $V = 0$. \
Actually there are no negative numbers, they only kind of numbers the program works for are just in $NN$. Also for convention they call the input variables $X_1, X_2, X_3, dots$ and the output variables $Y_1, Y_2, Y_3, dots$ and local variables $Z_1, Z_2, Z_3, dots$ often dropping the subscript.
$
X& #h(.5in) "Input"\
Y& #h(.5in) "Output"\
Z& #h(.5in) "Local"\
$
Also instructions are optionally "labelled" using the following notation. 
$
A_1,  B_1, C_1, D_1, E_1, A_2, B_2, C_2, D_2, E_2, A_3, dots
$
Once again often with the subscript dropped. $E$ is often the label of the "exit" instruction, meaning it has no instructions and halts the program. Also instructions must be finite. Additionally local and output variables are initialized to $0$. Finally this programming language is designated $scr(L)$.\
=== Section 2. Some Examples of Programs
#align(center)[*Notes*]
Abbreviating a "pseudo"-instruction or set of instructions is called at _Macro_ and the following is an example of a common one. 
$
"GOTO" [L]
$
Where the $"IF"$ part of the conditional branch is omitted. Another common macro that is seen a lot is
$
V arrow.l V'
$
where the $V'$ is replaced by some other variable during the _macro expansion_. Here the books works hard to show how this assignment/initialization takes place and what the expansion looks like. As a mathematician it seems pretty simple that I can initialize a variable to whatever I want it to be, including outputs of functions on variables denoted $+, -, times, dots$, but it is cool to see how these abstractions occur in the language $scr(L)$.







#align(center)[*Exercises*]
+ Write a program in $scr(L)$ that computes the function $f(x) = 3 x$.\
  *Solution*\
  #set math.cases(delim: "[", reverse: true)
  $
  &Y arrow.l X\
  &Z arrow.l 2\
  &cases("IF" Y eq.not 0 "GOTO" A , "GOTO" E) "Unnecessary"\
  [A]#h(.5in) &Y arrow.l X + Y\
  &Z arrow.l Z - 1\
  &"IF" Z eq.not 0 "GOTO" A\
  $
+ Write a program in$scr(L)$ that solves Exercise $1$ using no macros.\
  I am not gonna do this one since you can just fill in the macros.
+ Let $f(x) = 1$ if $x$ is even; $f(x) = 0$ if x is odd. Write a program in $scr(L)$ that computes $f$.
  $
  [C]#h(.5in) &"IF" X eq.not 0 "GOTO" A\
  &"GOTO" "E"\
  [A]#h(.5in) &X arrow.l X - 1\
  &Y = Y + 1\
  &"IF" X eq.not 0 "GOTO" B\
  &"GOTO" "E"\
  [B]#h(.5in) &X arrow.l X - 1\
  &Y = Y - 1\
  &"IF" X eq.not 0 "GOTO" A\
  $
+ Let $f(x) = 1$ if $x$ is even; $f(x)$ undefined if x is odd. Write a program in $scr(L)$ that computes $f$.
  $
  &Y arrow.l 1\
  [C]#h(.5in) &"IF" X eq.not 0 "GOTO" A\
  &"GOTO" "E"\
  [A]#h(.5in) &X arrow.l X - 1\
  //&Y = Y + 1\
  &"IF" X eq.not 0 "GOTO" B\
  &"GOTO" "A"\
  [B]#h(.5in) &X arrow.l X - 1\
  //&Y = Y - 1\
  &"IF" X eq.not 0 "GOTO" A\
  $

=== Section 3. Syntax
#align(center)[*Notes*]
This section is a bit of repetition as well as a very detailed account of the language $scr(L)$, so I will have brief notes.\
The following are called _statements_
$
&V arrow.l V + 1\
&V arrow.l V - 1\
&V arrow.l V\
&"IF" V eq.not 0 "GOTO" L
$
where $V$ may be any variable and $L$ may be any label. An _instruction_ is either a statement or a label-statement pair. A _program_ is a list (finite sequence) of instructions. The length of the list is the _length_ of a program. The _empty program_ is the program of length 0.\
The _state of a program_ #P is a list of equations of the form $V = m$, where $V$ is a variable and $m$ is a number, including an equation for each variable that occurs in #P and including no two equations with the same variable.\
Let $sigma$ be a state of #P and let $V$ be a variable that occurs in $sigma$. The _value of_ $V$ _at_ $sigma$ is then the number $q$ such that the equation $V=q$ is one of the equations making up $sigma$.
The _snapshot_ or _instantaneous description_ of a program #P of length $n$ is the pair $(i, sigma)$ where $i$ is the instruction about to be executed and $1 lt.eq i lt.eq n + 1$ and $sigma$ is a state of #P. $i = n + 1$ is the "stop" instruction.\
Page 27 defines all the cases of a _successor_ of a snapshot.\
A _computation_ of a program #P is a list
$
s_1, s_2, s_3, dots, s_k
$
$s_i$ snapshots of #P, such that $s_(i + 1)$ is the successor of $s_i$ for $i  = 1,2,3,dots,k-1$ and $s_k$ is _terminal_, meaning $i = n + 1$.
#align(center)[*Exercises*]
+ Give a program #P that such that for every computation $s_1, s_2, dots, s_k$ of #P, $k=5$.\
  *Solution*
  $
  &Z arrow.l 0\
  &Z arrow.l Z + 1\
  &Z arrow.l Z + 1\
  &Z arrow.l Z + 1\
  $
=== Section 4. Computable Functions

