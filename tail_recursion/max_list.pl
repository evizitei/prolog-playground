max_list(Xs, X) :- max_list(Xs, 0, X).
max_list([], X, X).
max_list([X|Xs], PrevMax, Max) :- 
  maximum(X, PrevMax, M),
  max_list(Xs, M, Max).

maximum(X,Y,Y) :- X =< Y.
maximum(X,Y,X) :- X > Y.