member(X,[X|Xs]).
member(X,[Y|Xs]) :- X \= Y, member(X,Xs).