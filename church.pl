nat(0).
s(0) :- nat(0).
s(X + 1) :- nat(X).
nat(s(X)) :- nat(X).

plus(0, X, X).
plus(s(X), Y, s(Z)) :- plus(X, Y, Z).

times(0, X, 0).
times(s(X), Y, Z) :- times(X, Y, Z1), plus(Z1, Y, Z). 
