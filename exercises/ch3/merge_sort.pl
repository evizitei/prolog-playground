len([], 0).
len([_|Xs], N) :- len(Xs, M), N is M + 1.

append([], Xs, Xs).
append([X|Xs], Ys, [X|Zs]) :- append(Xs, Ys, Zs).

split([], [], []).
split([X], [X], []).
split([X,Y], [X], [Y]).
split([X, Y | Xs], [X|I], [Y|J]) :- split(Xs, I, J).

merge([], [], []).
merge(Xs, [], Xs).
merge([], Xs, Xs).
merge([X|Xs], [Y|Ys], [X|Zs]) :- X =< Y, merge(Xs, [Y|Ys], Zs).
merge([X|Xs], [Y|Ys], [Y|Zs]) :- X > Y, merge([X|Xs], Ys, Zs).

merge_sort([], []).
merge_sort([X], [X]).
merge_sort(Xs, Ys) :- split(Xs, X1s, X2s), 
                      merge_sort(X1, X1s), merge_sort(X2, X2s),
                      merge(X1s, X2s, Ys).
