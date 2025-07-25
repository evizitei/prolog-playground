iprod([],[],0).
iprod([X|Xs],[Y|Ys],IP) :- iprod(Xs, Ys, P), IP is P + (X * Y).