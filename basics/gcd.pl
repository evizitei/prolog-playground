natural_number(0).
natural_number(s(X)) :- natural_number(X).

lt(0, s(X)) :- natural_number(X).
lt(s(X), s(Y)) :- lt(X, Y).

plus(0, X, X) :- natural_number(X).
plus(s(X), Y, s(Z)) :- plus(X, Y, Z).

mod(X, Y, X) :- lt(X, Y).
mod(X, Y, Z) :- natural_number(X1), plus(X1, Y, X), mod(X1, Y, Z).

gcd(X, Y, G) :- mod(X, Y, Z), gcd(Y, Z, G).
gcd(X, 0, X) :- lt(0, X).