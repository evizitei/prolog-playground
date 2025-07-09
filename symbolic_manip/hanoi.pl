append([], Xs, Xs).
append([X|Xs], Ys, [X|Zs]) :- append(Xs, Ys, Zs).

hanoi(1, A, B, _, [to(A,B)]).
hanoi(N, A, B, C, Moves) :- M is N - 1, hanoi(M, A, C, B, Ms1), 
                            hanoi(M, C, B, A, Ms2), append(Ms1, [to(A, B) | Ms2], Moves).