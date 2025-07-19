sample(0).
sample(1).
sample(2).
sample(3). 

pls(X, Y, Z) :- nonvar(X), nonvar(Y), Z is X + Y.
pls(X, Y, Z) :- nonvar(X), nonvar(Z), Y is Z - X.
pls(X, Y, Z) :- nonvar(Y), nonvar(Z), X is Z - Y.

plus(X, Y, Z) :- pls(X, Y, Z).
plus(X, Y, Z) :- nonvar(Z), sample(X), pls(X, Y, Z).
plus(X, Y, Z) :- nonvar(Y), sample(X), pls(X, Y, Z).
plus(X, Y, Z) :- nonvar(X), sample(Y), pls(X, Y, Z).
plus(X, Y, Z) :- var(X), var(Y), var(Z), sample(X), sample(Y), pls(X, Y, Z).

gcd(I, 0, I).
gcd(I, J, Gcd) :- J > 0, J1 is I mod J, gcd(J, J1, Gcd).

factorial(0, 1).
factorial(N, F) :- N > 0, N1 is N - 1, factorial(N1, F1), F is N * F1.

triangle(0, 0).
triangle(N, V) :- N > 0, N1 is N - 1, triangle(N1, V1), V is V1 + N.

power(X, 0, 1).
power(X, N, V) :- N > 0, N1 is N - 1, power(X, N1, V1), V is X * V1.