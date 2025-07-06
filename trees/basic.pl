btree(void).
btree(tree(_, L, R)) :- btree(L), btree(R).

tree_member(Element, tree(Element, _, _)).
tree_member(Element, tree(_, L, _)) :- tree_member(Element, L).
tree_member(Element, tree(_, _, R)) :- tree_member(Element, R).

iso_tree(void, void).
iso_tree(tree(X, L, R), tree(X, L1, R1)) :- iso_tree(L, L1), iso_tree(R,R1).
iso_tree(tree(X, L, R), tree(X, L1, R1)) :- iso_tree(L, R1), iso_tree(R,L1).