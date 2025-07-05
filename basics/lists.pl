list([]).
list([_|Xs]) :- list(Xs).

append([], Xs, Xs).
append([X|Xs], Ys, [X|Zs]) :- append(Xs, Ys, Zs).

prefix(Xs, Ys) :- append(Xs, _, Ys).
suffix(Xs, Ys) :- append(_, Xs, Ys).
member(X, Ys) :- append(_, [X|_], Ys).
sublist(Xs, Ys) :- append(_, Zs, Ys), append(Xs, _, Zs).
