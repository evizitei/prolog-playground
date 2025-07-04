:- use_module(library(clpfd)).

div(X, Y, Z) :- Y #> 0, X #= Y * Z + R, R #>= 0, R #< Y.