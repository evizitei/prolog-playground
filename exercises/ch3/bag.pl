% bag(element, count, restOfBag) ; void is empty bag

% example
bag(a, 3, bag(b, 2, void)).

member(X, bag(X, _, _)).
member(X, bag(Y, _, B)) :- X \= Y, member(X, B).

remove(_, void, void).
remove(X, bag(X, _, B), B).
remove(X, bag(Y, YN, B), bag(Y, YN, B1)) :- remove(X, B, B1).

get(X, bag(X, N, _), N).
get(X, bag(Y, _, B), M) :- X \= Y, get(X, B, M).

union(void, void, void).
union(X, void, X).
union(void, X, X).
union(bag(X, N, B1), bag(X, M, B2), bag(X, A, B3)) :- A is N + M, union(B1, B2, B3).
union(bag(X, XN, B1), bag(Y, YN, B2), bag(X, XN, B3)) :- (\+ member(X, B2)), union(B1, bag(Y, YN, B2), B3).
union(bag(X, XN, B1), bag(Y, YN, B2), bag(X, SUM, B3)) :- member(X, B2), 
  get(X, B2, Xalt), SUM is XN + Xalt, remove(X, B2, B2clean), union(B1, bag(Y, YN, B2clean), B3).
