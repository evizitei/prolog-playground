
% Facts

male(tom).
male(bob).
male(steve).
female(ann).
female(pat).
female(liz).
female(jane).

parent(liz, tom).
parent(tom, bob).
parent(tom, steve).
parent(jane, bob).
parent(jane, steve).
parent(bob, ann).
parent(bob, pat).


% Rules
father(X, Y) :- parent(X, Y), male(X).
grandparent(X, Z) :- parent(X, Y), parent(Y, Z).
grandfather(X, Z) :- grandparent(X, Z), male(X).
