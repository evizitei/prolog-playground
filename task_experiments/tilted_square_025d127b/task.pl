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

output_cell(XCell, YCell, Color) :- foreground_out_cell(XCell, YCell, Color).
output_cell(XCell, YCell, Color) :- background_out_cell(XCell, YCell, Color).