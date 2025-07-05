list([]).
list([_|Xs]) :- list(Xs).

member(X, [X|_]).
member(X, [_|Xs]) :- member(X, Xs).

prefix([], _).
prefix([X|Xs], [X|Ys]) :- prefix(Xs, Ys).

suffix(Xs, Xs).
suffix(Xs, [_|Ys]) :- suffix(Xs, Ys).

sublist(Xs, Ys) :- prefix(Xs, Zs), suffix(Zs, Ys).

append([], Xs, Xs).
append([X|Xs], Ys, [X|Zs]) :- append(Xs, Ys, Zs).