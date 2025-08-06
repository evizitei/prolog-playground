:- use_module(library(clpfd)).

trains([[1,2,0,1], % from station, to station, departs at, arrives at
        [1,4,1,3],
        [1,3,5,7],
        [2,3,4,5],
        [2,3,0,1],
        [2,4,5,9],
        [3,4,5,6],
        [3,4,2,3],
        [3,4,8,9],
        [3,5,10,11],
        [4,5,10,11],
        [4,5,12,13],
        [5,6,14,15]]).

threepath(From, To, Path) :-
  Path = [[From, X1, T0, T1], [X1, X2, T2, T3], [X2, To, T4, T5]],
  T2 #> T1,
  T4 #> T3,
  trains(Ts),
  tuples_in(Path, Ts),
  label([From, To, X1, X2, T0, T1, T2, T3, T4, T5]).