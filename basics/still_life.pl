left_of(pencil,hourglass).
left_of(bicycle,camera).
left_of(butterfly,fish).
left_of(hourglass,butterfly).

above(bicycle,pencil).
above(camera,butterfly).

left_of(A,C) :- left_of(A,B), left_of(B,C).
below(A,C) :- above(C,A).
right_of(A,C) :- left_of(C,A).