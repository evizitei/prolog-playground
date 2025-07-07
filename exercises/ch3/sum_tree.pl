sum_tree(void, 0).
sum_tree(tree(X, L, R), SM) :- sum_tree(L, Sl), sum_tree(R, Sr), 
                               SM is X + Sl + Sr.