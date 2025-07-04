% Simple facts
person(alice).
person(bob).
person(charlie).

likes(alice, pizza).
likes(alice, sushi).
likes(bob, pizza).
likes(bob, burgers).
likes(charlie, sushi).

% A rule that demonstrates goal order
friends(X, Y) :- person(X), person(Y), likes(X, Z), likes(Y, Z), X \= Y. 