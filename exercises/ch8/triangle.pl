% 8.3.1.i
triangle(Nth, Value) :- triangle(Nth, 0, Value).
triangle(0, V, V).
triangle(N, Acc, Value) :- Acc1 is Acc + N, N1 is N - 1, triangle(N1, Acc1, Value).