

male(terach).
male(abraham).
male(nachor).
male(haran).
male(isaac).
male(lot).
male(bob).
male(charlie).
male(frank).

female(sara).
female(sarah).
female(milcah).
female(yiscah).
female(alice).
female(debbie).
female(eve).

parent(terach, abraham).
parent(terach,nachor).
parent(terach,haran).
parent(abraham, isaac).
parent(haran,lot).
parent(haran,milcah).
parent(haran,yiscah).
parent(sara,isaac).
parent(bob, charlie).
parent(alice, charlie).
parent(bob, frank).
parent(alice, frank).
parent(charlie, debbie).
parent(eve, debbie).

% rules
father(Dad, Kid) :- male(Dad),
                    parent(Dad, Kid).

mother(Mom, Kid) :- female(Mom), 
                    parent(Mom, Kid).
mother(Woman) :- mother(Woman, _).

son(Son, Parent) :- parent(Parent, Son),
                    male(Son).
daughter(Dght, Parent) :- parent(Parent, Dght),
                              female(Dght).
grandparent(X, Y) :- parent(X, Z), 
                     parent(Z, Y).
grandfather(X, Y) :- grandparent(X, Y), 
                     male(X).
grandmother(X, Y) :- grandparent(X, Y),
                     female(X).

brother(Brother, Sib) :- parent(X, Brother), 
                         parent(X, Sib), 
                         male(Brother),
                         Brother \= Sib.

