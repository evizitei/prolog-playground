:- use_module(library(clpfd)).

test(X, Y) :-  
  X in 0..10, 
  Y in 4..8, 
  X #> Y.

complete_test(Y, Z) :-
  Z in 12..15,
  Y in 0..13,
  Y #> Z.
