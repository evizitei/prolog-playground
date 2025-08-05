% every tilted rectangle is untilted by a single step, anchored to its bottom right
% facts from example 1
% input_skewed_rect(X (top left), Y (top left), 
%                   color, width, height).

% an input skewed rectangle is formed by the following:
% 1. a horizontal line of some color/length/position
%   (X, Y, Color, Length)
% 2. a bunch of connecting cells down the next few rows
%    (XFirst, YFirst, Color, BorderRowWidth, BorderRowCount)
% 3. a final horizontal line of the same color/length.
%   (X, Y, Color, Length)
% so here are the new facts:
input_hline(1, 1, pink, 3).
input_hline(4, 5, pink, 3).

input_hline(2, 7, red, 3).
input_hline(3, 9, red, 3).

connected_border_slices(1, 2, pink, 4, 3).
connected_border_slices(2, 8, red, 4, 1).

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

output_bottom_u(X, YBottom, C, W) :-
  output_skewed_rect(X, Y, C, W, H),
  YBottom is (Y + H) - 2.

output_border_slices(XSlice, YSlice, Color, WSlice, Count) :-
  output_skewed_rect(X, Y, Color, W, H),
  XSlice is (X + H) - 3,
  Count is H - 3,
  YSlice is Y + 1,
  WSlice is W + 1.