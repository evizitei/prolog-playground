factorial(0, 0).
factorial(1, 1).
factorial(N, F) :- N > 1, N1 is N - 1, factorial(N1, F1), F is N * F1.

ifact(N, F) :- ifact(0, N, 1, F).
ifact(I, N, T, F) :- I < N, I1 is I + 1,
                     T1 is T*I1,
                     ifact(I1,N,T1,F).
ifact(N,N,F,F).