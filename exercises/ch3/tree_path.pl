tree_member(Element, tree(Element, _, _)).
tree_member(Element, tree(_, L, _)) :- tree_member(Element, L).
tree_member(Element, tree(_, _, R)) :- tree_member(Element, R).

path(X, tree(X, _, _), [X]).
path(X, tree(Y, L, _), [Y|P]) :- tree_member(X, L), path(X, L, P).
path(X, tree(Y, _, R), [Y|P]) :- tree_member(X, R), path(X, R, P).