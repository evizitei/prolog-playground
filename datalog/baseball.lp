#include "random_pitches.lp".

% player ( name, knee-height, shoulder-height)
player(vincent, 13, 52).
player(jim, 10, 42).
player(isaac, 12, 54).

thrown_pitch(Player, Height, Distance, 1) :- would_pitch(Player, Height, Distance, 1).

swing(Player, Pitchnum) :- would_swing(Player, Pitchnum),
                           thrown_pitch(Player, _, _, Pitchnum).

hit(Player, Pitchnum, Strength) :- would_hit(Player, Pitchnum, Strength),
                                   thrown_pitch(Player, _, _, Pitchnum).

thrown_pitch(Player, Height, Distance, Pitchnum + 1) :- 
   thrown_pitch(Player, _, _, Pitchnum),
   would_pitch(Player, Height, Distance, Pitchnum + 1),
   not strike_out(Player, Pitchnum),
   not walk(Player, Pitchnum),
   not hit(Player, Pitchnum, _).

strike(Player, Pitchnum) :- thrown_pitch(Player, Height, Distance, Pitchnum), 
                            Distance > 14, Distance < 34,
                            Height > KH, Height < SH,
                            player(Player, KH, SH),
                            not hit(Player, Pitchnum, _).

strike(Player, Pitchnum) :- thrown_pitch(Player, _, _, Pitchnum), 
                            swing(Player, Pitchnum), 
                            not hit(Player, Pitchnum, _).

ball(Player, Pitchnum) :- thrown_pitch(Player, Height, Distance, Pitchnum), 
                          not strike(Player, Pitchnum),
                          not hit(Player, Pitchnum, _).

strike_out(P, S3) :- strike(P, S1), strike(P, S2), 
                  strike(P, S3), S1 < S2, S2 < S3.

walk(P, B4) :- ball(P, B1), ball(P, B2), 
          ball(P, B3), ball(P, B4), 
          B1 < B2, B2 < B3, B3 < B4.

safe(P, 1) :- walk(P, _).
safe(P, 1) :- hit(P, _, single).
safe(P, 2) :- hit(P, _, double).

safe(P, X + 1) :- hit(Q, _, weak), was_safe(P, X), P != Q.
safe(P, X + 1) :- hit(Q, _, single), was_safe(P, X), P != Q.
safe(P, X + 2) :- hit(Q, _, double), was_safe(P, X), P != Q.

run(X + 1) :- safe(P, B), B >= 4, was_runs(X).

base_out(P, 1) :- hit(P, _, weak).
