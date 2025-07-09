
nat(0).
nat(s(X)) :- nat(X).

normalized_sum(X) :- nat(X).
normalized_sum(X + Y) :- nat(X), normalized_sum(Y).