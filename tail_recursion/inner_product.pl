iprod([],[],0).
iprod([X|Xs],[Y|Ys],IP) :- iprod(Xs, Ys, P), IP is P + (X * Y).

itprod([],[], IP, IP).
itprod([X|Xs],[Y|Ys], Temp, IP) :- 
  T1 is Temp + (X * Y), 
  itprod(Xs, Ys, T1, IP).
itprod(Xs, Ys, IP) :- itprod(Xs, Ys, 0, IP).