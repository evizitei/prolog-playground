btree(void).
btree(tree(_, L, R)) :- btree(L), btree(R).

tree_member(Element, tree(Element, _, _)).
tree_member(Element, tree(_, L, _)) :- tree_member(Element, L).
tree_member(Element, tree(_, _, R)) :- tree_member(Element, R).