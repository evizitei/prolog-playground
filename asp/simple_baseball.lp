strike(isaac, 1). strike(isaac, 2).
ball(isaac, 3). ball(isaac, 4). hit(isaac, 5).
ball(vincent, 6). ball(vincent, 7). ball(vincent, 8). ball(vincent, 9).

ball(charlie, 10). strike(charlie, 11). strike(charlie, 12). strike(charlie, 13).

strike_out(P, S3) :- strike(P, S1), 
                     strike(P, S2), 
                     strike(P, S3), 
                     S1 < S2, S2 < S3.
                     
walk(P, B4) :- ball(P, B1), ball(P, B2), 
               ball(P, B3), ball(P, B4), 
               B1 < B2, B2 < B3, B3 < B4.