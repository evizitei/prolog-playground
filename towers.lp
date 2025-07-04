#const moves=9.
#const disks=3.

peg(a;b;c).
disk(1..disks).
init_on(1..disks, a).
goal_on(1..disks, c).
step(1..moves).

% generating
1 { move(D,P,T) : disk(D), peg(P) } 1 :- step(T).

% defining
move(D, T) :- move(D, _, T).

on(D, P, 0) :- init_on(D, P).
on(D, P, T) :- move(D, P, T).
on(D, P, T + 1) :- on(D, P, T), not move(D, T + 1), T < moves.

blocked(D - 1, P, T + 1) :- on(D, P, T), T < moves, disk(D).
blocked(D - 1, P, T) :- blocked(D, P, T), disk(D).

% testing
:- move(D,P,T), blocked(D-1,P,T).
:- move(D,P,T), on(D,P,T-1).
:- move(D,T), on(D,P,T-1), blocked(D,P,T).
:- disk(D), T = 1..moves, not 1 { on(D, P, T) } 1.

:- goal_on(D,P), not on(D,P,moves).

#show move/3.