
% example 1
input_pattern(thorns, medium, blue).
% example 2
input_pattern(checkerboard, medium, blue).
% example 3
input_pattern(wall, medium, blue).

output_pattern(Pattern, tall, red) :- input_pattern(Pattern, medium, blue).