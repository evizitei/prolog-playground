% surrounded cells go from black to yellow
% input facts from example 1
surrounded_black_cell(2,2).
surrounded_black_cell(3,3).

% task rule
yellow_output_cell(X, Y) :- 
    surrounded_black_cell(X, Y).
