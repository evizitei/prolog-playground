plus(0, A, A).
plus(A, B, C) :- C is A + B.

sum([], 0).
sum([X|Xs], S) :- sum(Xs, S0), S is S0 + X.