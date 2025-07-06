select([], _, []).
select([X | Xs], X, Xs).
select([X | Xs], Z, [X | Zs]) :- X \= Z, select(Xs, Z, Zs).

append([], Xs, Xs).
append([X|Xs], Ys, [X|Zs]) :- append(Xs, Ys, Zs).

permutation([], []).
permutation([X | Xs], [X | Ys]) :- permutation(Xs, Ys).
permutation([X | Xs], [Y | Ys]) :- Y \= X, select(Xs, Y, Xys), select(Ys, X, Yxs), permutation(Xys, Yxs).


ordered([]).
ordered([_]).
ordered([X, Y | Xs]) :- ordered([Y | Xs]), X =< Y. 

perm_sort(Xs, Ys) :- permutation(Xs, Ys), ordered(Ys).

insert(X, [], [X]).
insert(X, [Y|Ys], [Y|Zs]) :- X > Y, insert(X, Ys, Zs).
insert(X, [Y|Ys], [X, Y|Ys]) :- X =< Y.

ins_sort([], []).
ins_sort([X|Xs], Ys) :- ins_sort(Xs, Zs), insert(X, Zs, Ys).


partition([], _, [], []).
partition([X|Xs], Y, [X|Ls], Bs) :- X =< Y, partition(Xs, Y, Ls, Bs).
partition([X|Xs], Y, Ls, [X|Bs]) :- X > Y, partition(Xs, Y, Ls, Bs).

quicksort([], []).
quicksort([X], [X]).
quicksort([X|Xs], Ys) :- partition(Xs, X, Littles, Bigs),
                         quicksort(Littles, Ls), quicksort(Bigs, Bs),
                         append(Ls, [X|Bs], Ys).