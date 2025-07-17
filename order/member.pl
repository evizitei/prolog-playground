member(X,[X|Xs]).
member(X,[Y|Xs]) :- X \= Y, member(X,Xs).

nonmember(X, []).
nonmember(X, [Y|Xs]) :- X \= Y, nonmember(X,Xs).

members([X|Xs], Ys) :- member(X, Xs), members(Xs, Ys).
members([], Any).