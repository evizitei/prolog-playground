% wrong (from the book) because it misses the closure
area([], 0).
area([_|[]], 0).
area([(X1,Y1), (X2,Y2) | XYs], Area) :-
  area([(X2,Y2)|XYs],Area1),
  Area is (((X1*Y2) - (Y1*X2))/2) + Area1.