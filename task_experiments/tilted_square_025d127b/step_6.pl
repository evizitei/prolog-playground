% We could build lines and two point rows from raw cells.
% facts from example 1

input_cell(1,1, pink). input_cell(2,1, pink). input_cell(3,1, pink).
input_cell(1,2, pink). input_cell(4,2, pink).
input_cell(2, 3, pink). input_cell(5, 3, pink).
input_cell(3,4,pink). input_cell(6,4,pink).
input_cell(4,5,pink). input_cell(5,5,pink). input_cell(6,5,pink).

input_cell(2,7,red). input_cell(3,7,red). input_cell(4,7,red).
input_cell(2,8,red). input_cell(5,8,red).
input_cell(3,9,red). input_cell(4,9,red). input_cell(5,9,red).

% lines are colored cells next to each other horizontally (in X)
input_hline(X, Y, Color, Width) :-
  input_cell(X, Y, Color),
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

