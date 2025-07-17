btree(void).
btree(tree(_, L, R)) :- btree(L), btree(R).

tree_member(Element, tree(Element, _, _)).
tree_member(Element, tree(_, L, _)) :- tree_member(Element, L).
tree_member(Element, tree(_, _, R)) :- tree_member(Element, R).

iso_tree(void, void).
iso_tree(tree(X, L, R), tree(X, L1, R1)) :- iso_tree(L, L1), iso_tree(R,R1).
iso_tree(tree(X, L, R), tree(X, L1, R1)) :- iso_tree(L, R1), iso_tree(R,L1).

substree(_, _, void, void).
substree(X, Y, tree(X, L1, R1), 
               tree(Y, L2, R2)) :- substree(X, Y, L1, L2),
                                   substree(X, Y, R1, R2).
substree(X, Y, tree(Z, L1, R1), 
               tree(Z, L2, R2)) :- X \= Z, 
                                   substree(X, Y, L1, L2),
                                   substree(X, Y, R1, R2).

tree_size(void, 0).
tree_size(tree(_, L, R), Size) :- 
    tree_size(L, LeftSize),
    tree_size(R, RightSize),
    Size is LeftSize + RightSize + 1.
