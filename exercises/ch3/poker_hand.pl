


rank(H, 8) :- has_straight(H, _), has_flush(H, _).
rank(H, 7) :- has_set(H, _, 4).
rank(H, 6) :- has_full_house(H, _, _).
rank(H, 5) :- has_straight(H, _). % and not flush
rank(H, 4) :- has_flush(H, _). % and not not straight
rank(H, 3) :- has_set(H, _, 3). % and not 4, and no full house.
rank(H, 2) :- has_set(H, N, 2), has_set(H, M, 2). % and no full house.
rank(H, 1) :- has_set(H, _, 2). % and not 3, and not 4, and no full house.

equal_rank(H1, H2) :- rank(H1, R1), rank(H2, R2), R1 = R2.

better_hand(H1, H2, H1) :- rank(H1, R1), rank(H2, R2), R1 > R2.
better_hand(H1, H2, H2) :- rank(H1, R1), rank(H2, R2), R1 < R2.
better_hand(H1, H2, H1) :- equal_rank(H1, H2), denom(H1, N1), denom(H2, N2), H1 > H2.
better_hand(H1, H2, H2) :- equal_rank(H1, H2), denom(H1, N1), denom(H2, N2), H1 < H2.