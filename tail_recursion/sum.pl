sumlist([], 0).
sumlist([X|Xs], S) :- sumlist(Xs, S1), S is S1 + X.

isumlist(Xs, S) :- isumlist(Xs, 0, S).

isumlist([], Sum, Sum).
isumlist([X|Xs], Temp, Sum) :- Temp1 is Temp + X, 
                               isumlist(Xs, Temp1, Sum).