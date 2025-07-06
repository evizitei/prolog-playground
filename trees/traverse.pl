list([]).
list([_|Xs]) :- list(Xs).

append([], Xs, Xs).
append([X|Xs], Ys, [X|Zs]) :- append(Xs, Ys, Zs).

tree(void).
tree(_, L, R) :- tree(L), tree(R).

preorder(void, []).
preorder(tree(X, L, R), [X|Ps]) :- preorder(L, Ls), preorder(R, Rs), append(Ls, Rs, Ps).

inorder(void, []).
inorder(tree(X, L, R), Is) :- inorder(L, Ls), inorder(R, Rs), append(Ls, [X|Rs], Is).

postorder(void, []).
postorder(tree(X, L, R), Ps) :- postorder(L, Ls), postorder(R, Rs),
                                append(Ls, Rs, Childs), append(Childs, [X], Ps).