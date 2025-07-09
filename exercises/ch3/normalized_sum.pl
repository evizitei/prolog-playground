nat(0).
nat(N) :- M is N - 1, M < 100, M >= 0, nat(M).
constant(N) :- nat(N).
nrml_sum(X) :- nat(X).
nrml_sum(X + Y) :- nat(X), nrml_sum(Y).