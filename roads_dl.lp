.decl road(City1: symbol, City2: symbol)
.decl blocked(City1: symbol, City2: symbol)
.decl route(City1: symbol, City2: symbol)
.decl drive(City: symbol)

road("berlin", "potsdam").
road("potsdam","werder").
road("werder","brandenburg").
road(X,Y) :- road(Y,X).

blocked("werder","brandenburg").

route(X,Y) :- road(X,Y), ! blocked(X,Y).
route(X,Y) :- route(X,Z), route(Z,Y).

drive(X) :- route("berlin",X).

.output route
.output drive