%input facts
top_cell(red, left, input).
bottom_cell(blue, left, input).
vpair(green, right, input).

% alternative facts
% top_cell(cyan, right, input).
%bottom_cell(magenta, right, input).
%vpair(yellow, left, input).

% model relations
top_cell(C, right, output) :- top_cell(C, _, input).
bottom_cell(C, right, output) :- bottom_cell(C, _, input).
vpair(black, left, output) :- vpair(_, left, input).
vpair(C, left, output) :- vpair(C, right, input).

% render
cell(1, 0, C) :- top_cell(C, _, output).
cell(1, 1, C) :- bottom_cell(C, _, output).
cell(0, 0, C) :- vpair(C, _, output).
cell(0, 1, C) :- vpair(C, _, output).

#show cell/3.