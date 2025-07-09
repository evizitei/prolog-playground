nat(0).
nat(M) :- nat(N), M = N + 1, M < 100.

derivative(X, X, 1).
derivative(exp(X, N), X, N * exp(X, M)) :- M is N - 1.
derivative(sin(X), X, cos(X)).
derivative(cos(X), X, -sin(X)).
derivative(exp(e, X), X, exp(e, X)).
derivative(log(X), X, 1/X).

derivative(F + G, X, DF + DG) :- derivative(F, X, DF), derivative(G, X, DG).
derivative(F - G, X, DF - DG) :- derivative(F, X, DF), derivative(G, X, DG).
derivative(F * G, X, (DF*G) + (DG*F)) :- derivative(F, X, DF), derivative(G, X, DG).
derivative(1/F, X, -DF/(F*F)) :- derivative(F, X, DF).
derivative(F/G, X, (G*DF - F*DG)/(G*G)) :- derivative(F, X, DF), derivative(G, X, DG).