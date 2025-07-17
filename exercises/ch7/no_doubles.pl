member(X, [X|_]).
member(X, [_|Xs]) :- member(X, Xs).

nonmember(_, []).
nonmember(X, [Y|Xs]) :- X \= Y, nonmember(X, Xs).


no_doubles(Xs, Ys) :- no_doubles(Xs, [], Ys).
no_doubles([X|Xs], Acc, Ys) :- member(X, Acc), no_doubles(Xs, Acc, Ys).
no_doubles([X|Xs], Acc, Ys) :- nonmember(X, Acc), no_doubles(Xs, [X|Acc], Ys).
no_doubles([], Ys, Ys).