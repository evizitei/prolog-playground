sample(0).
sample(1).
sample(2).
sample(3). 

pls(X, Y, Z) :- nonvar(X), nonvar(Y), Z is X + Y.
pls(X, Y, Z) :- nonvar(X), nonvar(Z), Y is Z - X.
pls(X, Y, Z) :- nonvar(Y), nonvar(Z), X is Z - Y.

plus(X, Y, Z) :- pls(X, Y, Z).
plus(X, Y, Z) :- nonvar(Z), sample(X), pls(X, Y, Z).
plus(X, Y, Z) :- nonvar(Y), sample(X), pls(X, Y, Z).
plus(X, Y, Z) :- nonvar(X), sample(Y), pls(X, Y, Z).
plus(X, Y, Z) :- var(X), var(Y), var(Z), sample(X), sample(Y), pls(X, Y, Z).
