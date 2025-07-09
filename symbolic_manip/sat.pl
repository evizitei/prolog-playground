sat(true).
sat(X ^ Y) :- sat(X), sat(Y).
sat(or(X, Y)) :- sat(X).
sat(or(X, Y)) :- sat(Y).
sat(not(X)) :- invalid(X).

invalid(false).
invalid(X ^ Y) :- invalid(X).
invalid(X ^ Y) :- invalid(Y).
invalid(or(X, Y)) :- invalid(X), invalid(Y).
invalid(not(X)) :- sat(X).