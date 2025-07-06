member(X, [X|_]).
member(X, [Y|Xs]) :- X \= Y, member(X, Xs).

no_doubles([], []).
no_doubles([X|Xs], Ys) :- member(X, Xs), no_doubles(Xs, Ys).
no_doubles([X|Xs], [X|Ys]) :- no_doubles(Xs, Ys), \+ member(X, Xs).
