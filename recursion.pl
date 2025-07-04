natural_number(0).
natural_number(s(X)) :- natural_number(X).

lte(0, X) :- natural_number(X).
lte(s(X), s(Y)) :- lte(X, Y).

plus(0, X, X) :- natural_number(X).
plus(s(X), Y, s(Z)) :- plus(X, Y, Z).

times(0, X, 0) :- natural_number(X).
times(s(X), Y, Z) :- times(X, Y, XY),
                     plus(XY, Y, Z).
                     

exp(s(X), 0, s(0)) :- natural_number(X).     
exp(0, s(X), 0) :- natural_number(X).
exp(X, s(Y), Z) :- exp(X, Y, XY), times(XY, X, Z).

factorial(0, s(0)).
factorial(s(X), F) :- factorial(X, FP), times(FP, s(X), F).


min(X, Y, X) :- lte(X, Y).
min(X, Y, Y) :- lte(Y, X).

lt(0, s(X)) :- natural_number(X).
lt(s(X), s(Y)) :- lt(X, Y).

gt(s(X), 0) :- natural_number(X).
gt(s(X), s(Y)) :- gt(X, Y).

mod(X, Y, Z) :- natural_number(Q), lt(Z, Y), times(Y, Q, QY), plus(Z, QY, X).


rmod(X, Y, X) :- lt(X, Y).
rmod(X, Y, Z) :- natural_number(X1), plus(X1, Y, X), rmod(X1, Y, Z).