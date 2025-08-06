% Now we can try to get ALL the cells, dealing with the background.
% facts from example 1

input_cell(0, 0, black).
input_cell(1, 0, black).
input_cell(2, 0, black).
input_cell(3, 0, black).
input_cell(4, 0, black).
input_cell(5, 0, black).
input_cell(6, 0, black).
input_cell(7, 0, black).
input_cell(8, 0, black).
input_cell(0, 1, black).
input_cell(1, 1, pink).
input_cell(2, 1, pink).
input_cell(3, 1, pink).
input_cell(4, 1, black).
input_cell(5, 1, black).
input_cell(6, 1, black).
input_cell(7, 1, black).
input_cell(8, 1, black).
input_cell(0, 2, black).
input_cell(1, 2, pink).
input_cell(2, 2, black).
input_cell(3, 2, black).
input_cell(4, 2, pink).
input_cell(5, 2, black).
input_cell(6, 2, black).
input_cell(7, 2, black).
input_cell(8, 2, black).
input_cell(0, 3, black).
input_cell(1, 3, black).
input_cell(2, 3, pink).
input_cell(3, 3, black).
input_cell(4, 3, black).
input_cell(5, 3, pink).
input_cell(6, 3, black).
input_cell(7, 3, black).
input_cell(8, 3, black).
input_cell(0, 4, black).
input_cell(1, 4, black).
input_cell(2, 4, black).
input_cell(3, 4, pink).
input_cell(4, 4, black).
input_cell(5, 4, black).
input_cell(6, 4, pink).
input_cell(7, 4, black).
input_cell(8, 4, black).
input_cell(0, 5, black).
input_cell(1, 5, black).
input_cell(2, 5, black).
input_cell(3, 5, black).
input_cell(4, 5, pink).
input_cell(5, 5, pink).
input_cell(6, 5, pink).
input_cell(7, 5, black).
input_cell(8, 5, black).
input_cell(0, 6, black).
input_cell(1, 6, black).
input_cell(2, 6, black).
input_cell(3, 6, black).
input_cell(4, 6, black).
input_cell(5, 6, black).
input_cell(6, 6, black).
input_cell(7, 6, black).
input_cell(8, 6, black).
input_cell(0, 7, black).
input_cell(1, 7, black).
input_cell(2, 7, red).
input_cell(3, 7, red).
input_cell(4, 7, red).
input_cell(5, 7, black).
input_cell(6, 7, black).
input_cell(7, 7, black).
input_cell(8, 7, black).
input_cell(0, 8, black).
input_cell(1, 8, black).
input_cell(2, 8, red).
input_cell(3, 8, black).
input_cell(4, 8, black).
input_cell(5, 8, red).
input_cell(6, 8, black).
input_cell(7, 8, black).
input_cell(8, 8, black).
input_cell(0, 9, black).
input_cell(1, 9, black).
input_cell(2, 9, black).
input_cell(3, 9, red).
input_cell(4, 9, red).
input_cell(5, 9, red).
input_cell(6, 9, black).
input_cell(7, 9, black).
input_cell(8, 9, black).
input_cell(0, 10, black).
input_cell(1, 10, black).
input_cell(2, 10, black).
input_cell(3, 10, black).
input_cell(4, 10, black).
input_cell(5, 10, black).
input_cell(6, 10, black).
input_cell(7, 10, black).
input_cell(8, 10, black).
input_cell(0, 11, black).
input_cell(1, 11, black).
input_cell(2, 11, black).
input_cell(3, 11, black).
input_cell(4, 11, black).
input_cell(5, 11, black).
input_cell(6, 11, black).
input_cell(7, 11, black).
input_cell(8, 11, black).
input_cell(0, 12, black).
input_cell(1, 12, black).
input_cell(2, 12, black).
input_cell(3, 12, black).
input_cell(4, 12, black).
input_cell(5, 12, black).
input_cell(6, 12, black).
input_cell(7, 12, black).
input_cell(8, 12, black).
input_cell(0, 13, black).
input_cell(1, 13, black).
input_cell(2, 13, black).
input_cell(3, 13, black).
input_cell(4, 13, black).
input_cell(5, 13, black).
input_cell(6, 13, black).
input_cell(7, 13, black).
input_cell(8, 13, black).

:- table max_row/1.
:- table max_col/1.
% Find maximum row and column values from input cells
max_row(MaxRow) :-
    findall(Y, input_cell(_, Y, _), Rows),
    max_list(Rows, MaxRow).

max_col(MaxCol) :-
    findall(X, input_cell(X, _, _), Cols), 
    max_list(Cols, MaxCol).

% lines are colored cells next to each other horizontally (in X)
input_hline(X, Y, Color, Width) :-
  input_cell(X, Y, Color),
  Color \= black,
  max_consecutive_cells(X, Y, Color, 1, Width),
  Width > 1.

% same accumulate and cut procedure as for consecutive slices.
max_consecutive_cells(X, Y, Color, CurrentCount, CurrentCount) :-
  NextX is X + CurrentCount,
  \+ input_cell(NextX, Y, Color), !.
max_consecutive_cells(X, Y, Color, CurrentCount, FinalCount) :-
  NextX is X + CurrentCount,
  input_cell(NextX, Y, Color),
  NextCount is CurrentCount + 1,
  max_consecutive_cells(X, Y, Color, NextCount, FinalCount).

two_point_row(X, Y, Color, Width) :-
  input_cell(X, Y, Color),
  Color \= black,
  input_cell(OtherX, Y, Color),
  OtherX > X,
  Width is (OtherX - X) + 1,
  Width > 2.

% connected border slices are several contiguous rows of exactly
% two spaced cells of a fixed spacing, each row offset in the x direction
% by 1.
connected_border_slices(X, Y, Color, Width, Count) :-
  two_point_row(X, Y, Color, Width),
  max_consecutive_slices(X, Y, Color, Width, 1, Count).

% Helper to find the maximum consecutive count
% Note the two different clauses, one with negation that uses "cut" (!) to 
% stop the search, and it COMES FIRST.
% The other uses a separate CurrentCount vs FinalCount variable,
% and we know we will find the target two_point_row (Because if not we
% would have fallen into the prior predicate).
max_consecutive_slices(X, Y, Color, Width, CurrentCount, CurrentCount) :-
  NextX is X + CurrentCount,
  NextY is Y + CurrentCount,
  \+ two_point_row(NextX, NextY, Color, Width), !.
max_consecutive_slices(X, Y, Color, Width, CurrentCount, FinalCount) :-
  NextX is X + CurrentCount,
  NextY is Y + CurrentCount,
  two_point_row(NextX, NextY, Color, Width),
  NextCount is CurrentCount + 1,
  max_consecutive_slices(X, Y, Color, Width, NextCount, FinalCount).

% and now inferring the structure can be part of the model:
input_skewed_rect(X, Y, C, W, H) :-
  input_hline(X, Y, C, W),
  Y_BORDER_START is Y + 1,
  BORDER_WIDTH is W + 1,
  connected_border_slices(X, Y_BORDER_START, C, BORDER_WIDTH, BORDER_COUNT),
  H is BORDER_COUNT + 2,
  FinalX is X + BORDER_COUNT,
  FinalY is Y + BORDER_COUNT + 1,
  input_hline(FinalX, FinalY, C, W).


% target_outputs
% output_skewed_rect(2, 1, pink, 3, 5, 2).
% output_skewed_rect(3, 7, red, 3, 3, 0).

output_skewed_rect(Xnew, Y, C, W, H) :-
  input_skewed_rect(X, Y, C, W, H),
  Xnew is X + 1.

% we can break the output down into a similar structure to the input.
output_hline(X, Y, C, W) :- output_skewed_rect(X, Y, C, W, _).

output_bottom_u(XBottom, YBottom, C, W) :-
  output_skewed_rect(X, Y, C, W, H),
  YBottom is (Y + H) - 2,
  XBottom is (X + H) - 3.

% border slices can be broken down to individual rows
output_border_slices(XSlice, YSlice, Color, WSlice, Count) :-
  output_skewed_rect(X, Y, Color, W, H),
  XSlice is X,
  Count is H - 3,
  YSlice is Y + 1,
  WSlice is W + 1.

% Generate individual out_two_point_row instances based on Count
% its worth tracing this part.
out_two_point_row(XRow, YRow, Color, Width) :-
  output_border_slices(XSlice, YSlice, Color, Width, Count),
  Count > 0,
  MaxVal is Count - 1,
  between(0, MaxVal, Index),
  XRow is XSlice + Index,
  YRow is YSlice + Index.

:- table foreground_out_cell/3.
:- table background_out_cell/3.

% output cells can be inferred from lines and points and U shapes.
foreground_out_cell(XCell, Y, C) :- 
  output_hline(X, Y, C, Width),
  MaxX is Width - 1,
  between(0, MaxX, Index),
  XCell is X + Index.

foreground_out_cell(X, Y, Color) :- out_two_point_row(X, Y, Color, _).
foreground_out_cell(XCell, Y, Color) :- 
  out_two_point_row(X, Y, Color, Width),
  XCell is (X + Width) - 1.

foreground_out_cell(X, Y, Color) :- output_bottom_u(X, Y, Color, _).
foreground_out_cell(XCell, Y, Color) :-
  output_bottom_u(X, Y, Color, Width),
  XCell is (X + Width) - 1.

foreground_out_cell(XCell, YCell, Color) :-
  output_bottom_u(X, Y, Color, Width),
  YCell is Y + 1,
  MaxX is Width - 1,
  between(0, MaxX, Index),
  XCell is X + Index.

background_out_cell(XCell, YCell, black) :-
  max_col(MaxX),
  max_row(MaxY),
  between(0, MaxX, XCell),
  between(0, MaxY, YCell),
  \+ foreground_out_cell(XCell, YCell, _).

out_cell(XCell, YCell, Color) :- foreground_out_cell(XCell, YCell, Color).
out_cell(XCell, YCell, Color) :- background_out_cell(XCell, YCell, Color).