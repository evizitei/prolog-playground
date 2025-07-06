len([], 0).
len([_|Xs], N) :- len(Xs, M), N is M + 1.

append([], Xs, Xs).
append([X|Xs], Ys, [X|Zs]) :- append(Xs, Ys, Zs).

take(_, 0, []).
take([X|Xs], N, [X|Zs]) :- N > 0, M is N - 1, take(Xs, M, Zs).

first_half(Xs, Ys) :- len(Xs, Xl), Xl2 is Xl // 2, take(Xs, Xl2, Ys).
second_half(Xs, Ys) :- first_half(Xs, Xh), append(Xh, Ys, Xs).

merge([], [], []).
merge(Xs, [], Xs).
merge([], Xs, Xs).
merge([X|Xs], [Y|Ys], [X|Zs]) :- X =< Y, merge(Xs, [Y|Ys], Zs).
merge([X|Xs], [Y|Ys], [Y|Zs]) :- X > Y, merge([X|Xs], Ys, Zs).

merge_sort([], []).
merge_sort([X], [X]).
merge_sort(Xs, Ys) :- first_half(Xs, X1), second_half(Xs, X2), 
                      merge_sort(X1, X1s), merge_sort(X2, X2s),
                      merge(X1s, X2s, Ys).