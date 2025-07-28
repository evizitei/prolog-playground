flatten([X|Xs], Ys) :-
  flatten(X, Ys1),
  flatten(Xs, Ys2),
  append(Ys1, Ys2, Ys).

flatten(X,[X]) :- constant(X), X \= [].
flatten([], []).

append([], Xs, Xs).
append([X|Xs], Ys, [X|Zs]) :- append(Xs, Ys, Zs).

constant(X) :- atomic(X).
list([]).
list([X|Xs]).

flat(Xs, Ys) :- flat(Xs, [], Ys).
flat([X|Xs], S, Ys) :- list(X), flat(X, [Xs|S], Ys).
flat([X|Xs], S, [X|Ys]) :- constant(X), X \= [], flat(Xs, S, Ys).
flat([], [X|S], Ys) :- flat(X,S,Ys).
flat([],[],[]).
