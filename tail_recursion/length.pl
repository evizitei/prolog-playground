% can DETERMINE length, ALSO can generate
length1(Xs, N) :- length1(Xs, 0, N).
length1([], N, N).
length1([_|Xs], M, N) :- Acc is M + 1, length1(Xs, Acc, N).

% can test, can generate, cannot determing length
len2([], 0).
len2([_|Xs], N) :- N > 0, N1 is N - 1, length(Xs,N1).


% can determine length, can test, cannot generate
len3([X|Xs], N) :- len3(Xs, N1), N is N1 + 1.
len3([], 0).