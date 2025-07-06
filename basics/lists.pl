list([]).
list([_|Xs]) :- list(Xs).

append([], Xs, Xs).
append([X|Xs], Ys, [X|Zs]) :- append(Xs, Ys, Zs).

prefix(Xs, Ys) :- append(Xs, _, Ys).
suffix(Xs, Ys) :- append(_, Xs, Ys).
member(X, Ys) :- append(_, [X|_], Ys).
sublist(Xs, Ys) :- append(_, Zs, Ys), append(Xs, _, Zs).
adjacent(X, Y, Zs) :- sublist([X, Y], Zs).
last(X, Xs) :- append(_, [X], Xs).

reverse([], []).
reverse([X|Xs], Zs) :- reverse(Xs, Ys), append(Ys, [X], Zs).

rev([], Xs, Xs).
rev([X|Xs], Acc, Ys) :- rev(Xs, [X|Acc], Ys).
rev(Xs, Ys) :- rev(Xs, [], Ys).

len([], 0).
len([_|Xs], N) :- len(Xs, M), N is M + 1.

rec_adjacent(X, Y, [X, Y | _]).
rec_adjacent(X, Y, [_ | Zs]) :- rec_adjacent(X, Y, Zs).

rec_last(X, [X]).
rec_last(X, [_|Xs]) :- rec_last(X, Xs).

double([], []).
double([X | Xs], [X, X | Ys]) :- double(Xs, Ys).

delete([X | Xs], X, Ys) :- delete(Xs, X, Ys).
delete([Z | Xs], X, [Z | Ys]) :- X \= Z, delete(Xs, X, Ys).
delete([], _, []).

select([], _, []).
select([X | Xs], X, Xs).
select([X | Xs], Z, [X | Zs]) :- X \= Z, select(Xs, Z, Zs).