nat(0).
nat(1).
nat(2).
nat(3).
nat(4).
nat(5).
nat(6).
nat(7).
nat(8).
nat(9).
nat(10).
constant(N) :- nat(N).

polynomial(X, X).
polynomial(Term, X) :- constant(Term).
polynomial(Term1 + Term2, X) :- polynomial(Term1, X), polynomial(Term2, X).
polynomial(Term1 - Term2, X) :- polynomial(Term1, X), polynomial(Term2, X).
polynomial(Term1 * Term2, X) :- polynomial(Term1, X), polynomial(Term2, X).
polynomial(Term1 / Term2, X) :- polynomial(Term1, X), polynomial(Term2, X).
polynomial(exponnet(Term, N), X) :- polynomial(Term, X), nat(N).