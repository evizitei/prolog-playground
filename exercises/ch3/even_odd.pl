even(0).
even(s(X)) :- odd(X).

odd(s(X)) :- even(X).