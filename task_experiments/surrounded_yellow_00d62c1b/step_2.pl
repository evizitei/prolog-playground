
surrounded_black_cell(2,2).
surrounded_black_cell(3,3).
green_cell(2,1). green_cell(3,2). green_cell(4,3).
green_cell(1,2). green_cell(2,3). green_cell(3,4).

% change rule
yellow_output_cell(X, Y) :- 
    surrounded_black_cell(X, Y).
% green cells stays where they are
green_output_cell(X, Y) :- green_cell(X, Y).