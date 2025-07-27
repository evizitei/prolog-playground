max_list(Xs, X) :- max_list(Xs, 0, X).
max_list([], X, X).
max_list([X|Xs], PrevMax, Max) :- 
  X > PrevMax,
  max_list(Xs, X, Max).
  
max_list([X|Xs], PrevMax, Max) :-
  X =< PrevMax,
  max_list(Xs, PrevMax, Max).