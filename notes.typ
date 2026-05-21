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
#let L = $scr(L)$

#let ifs(L: none,V,gt) = if L == none [
  $&"IF" #V eq.not  0 "GOTO" #gt\ $
] else [
  $[#L] #h(.5in)&"IF" #V eq.not 0 "GOTO" #gt\ $
]
#let inc(L: none,V,m : none) = if L == none [
  #if m == none [
  $&#V arrow.l #V + 1\ $
  ] else [
  $&#V arrow.l #V + #m\ $
  ]
] else [
  #if m == none [
  $[#L] #h(.5in)&#V arrow.l V + 1\ $
  ] else [
  $[#L] #h(.5in)&#V arrow.l V + #m\ $
  ]
]
#let dec(L: none,V,m : none) = if L == none [
  #if m == none [
  $&#V arrow.l #V - 1\ $
  ] else [
  $&#V arrow.l #V - #m\ $
  ]
] else [
  #if m == none [
  $[#L] #h(.5in)&#V arrow.l #V - 1\ $
  ] else [
  $[#L] #h(.5in)&#V arrow.l #V - #m\ $
  ]
]
#let init(L: none,V,m : none) = if L == none [
  #if m == none [
  $&#V arrow.l 0\ $
  ] else [
  $&#V arrow.l #m\ $
  ]
] else [
  #if m == none [
  $[#L] #h(.5in)&#V arrow.l 0\ $
  ] else [
  $[#L] #h(.5in)&#V arrow.l #m\ $
  ]
]
#let GT(gt) = [
  $&"GOTO" #gt \ $
]


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
#pagebreak()
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

#pagebreak()
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
#pagebreak()
=== Section 4. Computable Functions
The _Initial State_ of a program #P in the language #L for $r_1, r_2, dots, r_m$ given numbers is the state $sigma$ of #P where 
$
X_1 = r_1, X_2 = r_2, dots, X_m = r_m, Y = 0
$
and $V = 0$ for all other variables in #P. The _Initial Snapshot_ is denoted $(1,sigma)$.\
_Case 1._ There exists a computation $s_1, s_2, dots, s_k$ of #P beginning with the initial snapshot. Then $psi_#P^((m))(r_1, r_2, dots, r_m)$ is the value of $Y$ at the terminal snapshot $s_k$.\
_Case 2._ There does not exists a computation. This means there is an infinite sequence $s_1, s_2, dots$ beginning with the initial snapshot. Also, $psi_#P^((m))(r_1, r_2, dots, r_m)$ is undefined here.\
A function $g$ is _partially computable_ if for some $r_1, r_2, dots, r_m$,
$
g(r_1, r_2, dots, r_m) = psi_#P^((m))(r_1, r_2, dots, r_m).
$
Also when $g(r_1, r_2, dots, r_m)$ is undefined so is $psi_#P^((m))(r_1, r_2, dots, r_m)$, and when $g$ is defined they are equal.
A function $g$ is total if it is defined for all input $r_1, r_2, dots, r_m$. 
#align(center)[#box(stroke: 1pt, inset: 4pt)[*A function is _computable_ if it is both partially computable and total*]]
#align(center)[*Exercises*]
+ Let #P be a program
  $
  &"IF" X eq.not 0 "GOTO" A\
  [A]#h(.5in) & X arrow.l X + 1\
  #ifs("X","A", )
  [A]#h(.5in) & Y arrow.l Y + 1\
  $
  What is $psi^((1))_#P$?\
  *Solution*\
  It is the nowhere defined function.
+ The same as Exercise $1$ for the program
  $
  #ifs(L:$B$, $X$, $A$)
  #inc($Z$)
  #ifs($Z$, $B$)
  #init(L:$A$, $X$,m:$X$)
  $
  *Solution*\
  #set math.cases(reverse: false, delim: "{")
  $
  psi^((1))_#P = cases(
    0 #h(.5in) "undefined",
    x eq.not 0 #h(.5in) 0
  )
  $
+ The same as Exercise $1$ for the empty program\
  *Solution*\
  $
  psi^((1))_#P = 0
  $
+ Let #P be the program
  $
  #init($Y$, m: $X_1$)
  #ifs(L:$A$,$X_2$, $E$)
  #inc($Y$)
  #inc($Y$)
  #dec($X_2$)
  #GT($A$)
  $
  What is $psi^((1))_#P (r_1)$? #h(4pt) $psi^((2))_#P (r_1,r_2)$? #h(4pt) $psi^((3))_#P (r_1,r_2,r_3)$?\
  *Solution*\
  $
  psi^((1))_#P (r_1)  &= "undefined"\
  psi^((2))_#P (r_1,r_2) &= cases(
    (r_1,0) #h(.5in) "undefined",
    (r_1,r_2 eq.not 0) #h(.5in) r_1
  )\
  psi^((3))_#P (r_1,r_2,r_3) &= cases(
    (r_1,0,r_3) #h(.5in) "undefined",
    (r_1,r_2 eq.not 0, r_3) #h(.5in) r_1
  )\
  $
+ Show that for every partially computable function $f(x_1, dots, x_n)$ there is a number $m gt.eq 0$ such that $f$ is computed by infinitely many programs of length $m$.\
  *Proof*\
  Let $f(x_1, dots, x_n)$ be some partially computable function such that
  $
  f(x_1, dots, x_n) = psi^((n))_#P^* (x_1, dots, x_n)
  $
  where $#P^*$ is a program of length $l$ that computes $f$. Now take $m = l + 1$ and look at the set of all programs $S$ of length $m$ that begin with $#P^*$ and whose final instruction does not change the value of $Y$ (the output) and does not contain a GOTO. It is easy to see that all programs in $S$ compute $f$ since the final instruction does not change $Y$ and $#P^*$ would be terminal at that point. It is also easy to see that $S$ is infinite since the final instruction could be any of the following
  $
  #init($Z_1$)
  #init($Z_2$)
  #init($Z_3$)
  &dots.v\
  #init($Z_1$, m:1)
  #init($Z_2$, m:1)
  #init($Z_3$, m:1)
  &dots.v\
  #init($Z_1$, m:2)
  &dots.v\
  $
  #align(right)[#box(stroke: 1pt, inset: 4pt, fill: black)[]]
+ (a) For every number $k gt.eq 0$, let $f_k$ be the constant function $f_k (x) = k$. Show that for every $k$, $f_k$ is computable.\
  *Proof*\
  Let $k gt.eq 0$ and consider the function $f_k (x) = k$. It is easy to see that $f_k$ it total since it is equal to $k$ for all $x$. Now all that is left to show is that $f_k$ is partially computable. Considered the following program #P
  $
  #init($Y$, m: $k$)
  $
  where $psi^((1))_#P (x) = k$ thus $psi^((1))_#P (x) = f_k$. This means $f_k$ is partially computable and since it is total $f_k$ is computable for any $k$.
  #align(right)[#box(stroke: 1pt, inset: 4pt, fill: black)[]]

#pagebreak()
=== Section 5. More about Macros

Observe the following macro.
$
#init($W$, m: $f(V_1,dots, V_n)$)
$
where $f$ is a partially computable function. This macro is the abbreviation of the following expansion.
$
#init($Z_m$)
#init($Z_(m+1)$, m: $V_1$)
#init($Z_(m+2)$, m: $V_2$)
dots.v\
#init($Z_(m+n)$, m: $V_n$)
#init($Z_(m+n+1)$)
#init($Z_(m+n+2)$)
dots.v\
#init($Z_(m+n+k)$)
&scr(Q)_m\
#init($W$, m: $Z_n$, L:$E_m$)
$
where $m$ is large enough that these variables are never used in the main program.\
This next macro makes IF statement look more familiar.
$
&"IF" P(V_1,dots, V_n) "GOTO" L
$<new_if>
where $P(V_1,dots, V_n)$ is a computable predicate that evaluates to either 
$
"TRUE" = 1, #h(.2in) "FALSE" = 0
$
which means @new_if is the expansion of 
$
#init($Z$,m:$P(V_1,dots, V_n)$)
#ifs($Z$,$L$)
$
Note how all of these _macros_ are just abbreviations of the original language #L which means if anything is computable with these macros, or any new ones we define using #L, then it is computable in #L.

#align(center)[*Exercises*]
+ Let $f(x)$, $g(x)$ be computable functions and let $h(x) = f(g(x))$. Show that $h$ is computable.\
  *Proof*
  Since $f$ and $g$ are computable there exists
  $
  f(x) &= psi_(#P _f)^((1))(x)\
  &"and"\
  g(x) &= psi_(#P _g)^((1))(x)\
  $
  for programs $#P _f$ and $#P _g$ respectively. Then $h$ can be computed using the following program
  $
  #init($X$,m:$x$)
  #init($Z$,m:$psi_(#P _g)^((1))(X)$)
  #init($Y$,m:$psi_(#P _f)^((1))(Z)$)
  $
  which is easily see to compute $h$.
+ Show by constructing a program that the predicate $x_1 lt.eq x_2$ is computable.\
  Consider the following program
  $
  #init($Z_1$,m:$x_1$)
  #init($Z_2$,m:$x_2$)
  #ifs($Z_2$, $P$)
  #ifs(L:$P$,$Z_1$, $S$)
  #init(L:$T$,$Y$,m:$1$)
  #GT($E$)
  #init(L:$F$,$Y$,m:$0$)
  #GT($E$)
  #dec($Z_1$, L:$S$ )
  #dec($Z_2$)
  #ifs($Z_1$, $C$)
  #GT($T$)
  #ifs(L:$C$,$Z_2$, $S$)
  #GT($F$)
  $


#pagebreak()
== Chapter 3: Primitive Recursive Functions
=== Section 1. Composition

