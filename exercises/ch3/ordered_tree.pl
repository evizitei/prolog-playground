ordered_tree(void).
ordered_tree(tree(X, L, R)) :- ordered_left(X, L), ordered_right(X, R).

ordered_left(_, void).
ordered_left(X, T) :- ordered_tree(T), greater(X, T).

ordered_right(_, void).
ordered_right(X, T) :- ordered_tree(T), less(X, T).

greater(_, void).
greater(X, T) :- max(T, Max), X > Max.

less(_, void).
less(X, T) :- min(T, Min), X < Min.

max(tree(X, L, void), X) :- ordered_tree(tree(X, L, void)).
max(tree(X, L, R), MaxR) :- ordered_tree(tree(X, L, R)), max(R, MaxR).

min(tree(X, void, R), X) :- ordered_tree(tree(X, void, R)).
min(tree(X, L, R), MinL) :- ordered_tree(tree(X, L, R)), min(L, MinL).

insert(X, void, tree(X, void, void)).
insert(X, tree(X, L, R), tree(X, L, R)).
insert(X, tree(Y, L, R), tree(Y, L, R1)) :- X > Y, insert(X, R, R1).
insert(X, tree(Y, L, R), tree(Y, L1, R)) :- X < Y, insert(X, L, L1).