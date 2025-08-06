:- use_module(library(clpfd)).

increase([]).
increase([_]).
increase([X, Y | Xs]) :- X #< Y, increase([Y | Xs]).
