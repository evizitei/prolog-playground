row(1..8).
col(1..8).

{ queen(I, J) : col(I), row(J) }.

:- not 8 { queen(I, J) } 8.
:- queen(I, J), queen(I, JJ), J != JJ.
:- queen(I, J), queen(II, J), I != II.
:- queen(I, J), queen(II, JJ), (I, J) != (II, JJ), 
                                I - J == II - JJ.
:- queen(I, J), queen(II, JJ), (I, J) != (II, JJ), 
                               I + J == II + JJ.

#show queen/2.