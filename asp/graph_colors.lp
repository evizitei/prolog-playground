% problem instance
node(1..6).

edge(1, 2..4).
edge(2, 4..6).
edge(3, 4..6).
edge(4, 5).
edge(5, 6).
edge(X, Y) :- edge(Y, X).

color(r; g; b).

% Generate
1 { color(X, C) : color(C) } 1 :- node(X).
% Test
:- edge(X, Y), color(X, C), color(Y, C).

#show color/2.