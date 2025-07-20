% 

huffman([], [Tree|[]], Tree).

huffman([], [ATree|OtherTrees] , Tree) :- 
  min_freq([ATree|OtherTrees], tree(char_freqs(C1, N1), L1, R1)),
  select([ATree|OtherTrees], tree(char_freqs(C1, N1), L1, R1), LessOneTrees),
  min_freq(LessOneTrees, tree(char_freqs(C2, N2), L2, R2)),
  select(LessOneTrees, tree(char_freqs(C2, N2), L2, R2), LessTwoTrees),
  concat(C1, C2, C3),
  N_SUM is N1 + N2,
  huffman([], [tree(char_freqs(C3, N_SUM), tree(char_freqs(C1, N1), L1, R1), tree(char_freqs(C2, N2), L2, R2))  |LessTwoTrees], Tree).

huffman([char_freq(C, N) | Others], Acc, Tree) :- 
  huffman(Others, [tree(char_freqs([C], N), void, void) | Acc], Tree).

huffman([], void).
huffman(List, Tree) :- huffman(List, [], Tree).

min_freq([CN | []], CN).
min_freq([tree(char_freqs(C, N), L, R) | Others], tree(char_freqs(C, N), L, R)) :- 
  min_freq(Others, tree(char_freqs(_, N2), _, _)),
  N =< N2.
min_freq([tree(char_freqs(_, N), _, _) | Others], tree(char_freqs(C2, N2), L, R)) :- 
  min_freq(Others, tree(char_freqs(C2, N2), L, R)),
  N > N2.



select([], _, []).
select([X | Xs], X, Xs).
select([X | Xs], Z, [X | Zs]) :- X \= Z, select(Xs, Z, Zs).

concat([], Xs, Xs).
concat([X|Xs], Ys, [X | Rest]) :- concat(Xs, Ys, Rest).

