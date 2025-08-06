% what do the heights really mean?

% example 1
input_pattern(thorns, 6, blue).
% example 2
input_pattern(checkerboard, 6, blue).
% example 3
input_pattern(wall, 6, blue).

output_pattern(Pattern, OutHeight, red) :- 
  input_pattern(Pattern, InHeight, blue),
  OutHeight is InHeight + 3.