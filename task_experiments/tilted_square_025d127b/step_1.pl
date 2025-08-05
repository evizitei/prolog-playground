% every tilted rectangle is untilted by a single step, anchored to its bottom right
% facts from example 1
% input_skewed_rect(X (top left), Y (top left), 
%                   color, width, height).
input_skewed_rect(1, 1, pink, 3, 5).
input_skewed_rect(2, 7, red, 3, 3).
% target_outputs
% output_skewed_rect(2, 1, pink, 3, 5).
% output_skewed_rect(3, 7, red, 3, 3).

output_skewed_rect(Xnew, Y, C, W, H) :-
  input_skewed_rect(X, Y, C, W, H),
  Xnew is X + 1.

% this is particularly simple because the input and output have stable shapes
% that are functions of their position and size.