/*
	 much shorter quarreling children

	 16 children are to be seated in a
	 4 x 4 array of chairs.

    the children are 8 Cardinals Fans (numbered 1..8) and
	 8 Royals Fans (numbered 9..16).

     1,3,5,8 think royals fans are yucky
	 9,10,11,14 think Cardinals fans are gross

	 these pairs are enemies
     [[1,2], [4,6], [4,7], [4, 9],[9,11], [12, 14], [14,16]]

*/

:- use_module(library(clpfd)).

length_(Length, List) :- length(List, Length).
child_row(X) :- X ins 1..16.

% output stuff that works procedurally
ww(X) :- write(X), write('/').
print_row(Row) :- maplist(ww, Row), nl.

children(Class) :-
  length(Class, 4),
  maplist(length_(4), Class),
  maplist(child_row, Class),
  maplist(row_compatible, Class),
  transpose(Class, TransClass),
  maplist(row_compatible, TransClass),
  flatten(Class, FlatClass),
  all_different(FlatClass),
  maplist(label, Class),
  maplist(print_row, Class).

row_compatible([A,B,C,D]) :-
	compatible(A, B),
	compatible(B, C),
	compatible(C, D).

compatible(A, B) :-
	not_enemy(A, B),
	not_enemy(B, A),
	team_compatible(A, B),
	team_compatible(B, A).

not_enemy(A, B) :-
    A #\= 1 #\/ B #\= 2,
    A #\= 4 #\/ B #\= 6,
    A #\= 4 #\/ B #\= 7,
    A #\= 4 #\/ B #\= 9,
    A #\= 9 #\/ B #\= 11,
    A #\= 12 #\/ B #\= 14,
    A #\= 14 #\/ B #\= 16.

team_compatible(Child1, Child2) :-
  Child1 in 1\/3\/5\/8 #==> Child2 #=< 8,
  Child1 in 9..11\/14 #==> Child2 #> 8.
