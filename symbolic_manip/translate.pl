% example of a mapping relation.

dict(the, le).
dict(chases, chasse).
dict(dog, chien).
dict(cat, chat).

translate([],[]).
translate([W|Words],[M|Mots]) :- dict(W, M), translate(Words, Mots).