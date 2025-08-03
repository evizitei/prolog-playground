% surrounded cells go from black to yellow
% input facts from example 1
surrounded_black_cell(2,2, ex1).
surrounded_black_cell(3,3, ex1).


% input facts from example 2.
surrounded_black_cell(6,4, ex2).

% task rule
yellow_output_cell(X, Y, EX) :- 
    surrounded_black_cell(X, Y, EX).