fib(1, 1).
fib(2, 1).
fib(N, F) :- N > 2, 
             N1 is N - 1,
             N2 is N - 2,
             fib(N1, F2),
             fib(N2, F1),
             F is F1 + F2.