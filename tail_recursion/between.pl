between(I, J, I) :- I =< J.
between(I,J,K) :- I < J, I1 is  I + 1, between(I1, J, K).