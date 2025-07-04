
div(X, X, 1).
div(X, Y, 0) :- X < Y.
div(X, Y, Z) :- var(Z), X > Y, X1 is X - Y, div(X1, Y, Z1), Z is Z1 + 1.
