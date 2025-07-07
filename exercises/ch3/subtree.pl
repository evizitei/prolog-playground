subtree(void, _).
subtree(Tree, Tree).
subtree(S, tree(_, L, _)) :- subtree(S, L).
subtree(S, tree(_, _, R)) :- subtree(S, R).