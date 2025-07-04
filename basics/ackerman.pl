natural_number(0).
natural_number(s(X)) :- natural_number(X).

ackermann(0, X, s(X)) :- natural_number(X).
ackermann(s(X), 0, A) :- ackermann(X, s(0), A).
ackermann(s(X), s(Y), A) :- ackermann(X, A1, A), ackermann(s(X), Y, A1).