road(berlin, potsdam).
road(potsdam,werder).
road(werder,brandenburg).
road(X,Y) :- road(Y,X).

blocked(werder,brandenburg).

route(X,Y) :- road(X,Y), not blocked(X,Y).
route(X,Y) :- route(X,Z), route(Z,Y).

drive(X) :- route(berlin,X).


