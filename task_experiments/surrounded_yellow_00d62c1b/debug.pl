input_cell(0, 0, black).
input_cell(1, 0, black).
input_cell(2, 0, black).
input_cell(3, 0, black).
input_cell(4, 0, black).
input_cell(5, 0, black).
input_cell(6, 0, black).
input_cell(7, 0, black).
input_cell(8, 0, black).
input_cell(9, 0, black).
input_cell(0, 1, black).
input_cell(1, 1, black).
input_cell(2, 1, green).
input_cell(3, 1, black).
input_cell(4, 1, green).
input_cell(5, 1, black).
input_cell(6, 1, black).
input_cell(7, 1, black).
input_cell(8, 1, black).
input_cell(9, 1, black).
input_cell(0, 2, black).
input_cell(1, 2, black).
input_cell(2, 2, black).
input_cell(3, 2, green).
input_cell(4, 2, black).
input_cell(5, 2, green).
input_cell(6, 2, black).
input_cell(7, 2, black).
input_cell(8, 2, black).
input_cell(9, 2, black).
input_cell(0, 3, black).
input_cell(1, 3, black).
input_cell(2, 3, green).
input_cell(3, 3, black).
input_cell(4, 3, black).
input_cell(5, 3, black).
input_cell(6, 3, green).
input_cell(7, 3, black).
input_cell(8, 3, black).
input_cell(9, 3, black).
input_cell(0, 4, black).
input_cell(1, 4, black).
input_cell(2, 4, black).
input_cell(3, 4, black).
input_cell(4, 4, black).
input_cell(5, 4, green).
input_cell(6, 4, black).
input_cell(7, 4, green).
input_cell(8, 4, black).
input_cell(9, 4, black).
input_cell(0, 5, black).
input_cell(1, 5, black).
input_cell(2, 5, black).
input_cell(3, 5, green).
input_cell(4, 5, black).
input_cell(5, 5, green).
input_cell(6, 5, green).
input_cell(7, 5, black).
input_cell(8, 5, black).
input_cell(9, 5, black).
input_cell(0, 6, black).
input_cell(1, 6, black).
input_cell(2, 6, green).
input_cell(3, 6, green).
input_cell(4, 6, green).
input_cell(5, 6, black).
input_cell(6, 6, black).
input_cell(7, 6, black).
input_cell(8, 6, black).
input_cell(9, 6, black).
input_cell(0, 7, black).
input_cell(1, 7, black).
input_cell(2, 7, black).
input_cell(3, 7, green).
input_cell(4, 7, black).
input_cell(5, 7, black).
input_cell(6, 7, black).
input_cell(7, 7, black).
input_cell(8, 7, black).
input_cell(9, 7, black).
input_cell(0, 8, black).
input_cell(1, 8, black).
input_cell(2, 8, black).
input_cell(3, 8, black).
input_cell(4, 8, black).
input_cell(5, 8, black).
input_cell(6, 8, black).
input_cell(7, 8, black).
input_cell(8, 8, black).
input_cell(9, 8, black).
input_cell(0, 9, black).
input_cell(1, 9, black).
input_cell(2, 9, black).
input_cell(3, 9, black).
input_cell(4, 9, black).
input_cell(5, 9, black).
input_cell(6, 9, black).
input_cell(7, 9, black).
input_cell(8, 9, black).
input_cell(9, 9, black).

% green cells are easy, they just unify with a constant
green_cell(X, Y) :- input_cell(X, Y, green).

% First identify boundary black cells
boundary_black_cell(X, Y) :-
  input_cell(X, Y, black),
  (X = 0; Y = 0; X = 5; Y = 5).


% Mark black cells connected to boundary recursively with visited tracking
connected_to_boundary(X, Y) :- 
    connected_to_boundary(X, Y, []).

connected_to_boundary(X, Y, _) :- boundary_black_cell(X, Y), !.
connected_to_boundary(X, Y, Visited) :-
    input_cell(X, Y, black),
    \+ member((X,Y), Visited),
    (
        % Check all 4 adjacent cells
        (X1 is X + 1, connected_to_boundary(X1, Y, [(X,Y)|Visited]), !);
        (X1 is X - 1, connected_to_boundary(X1, Y, [(X,Y)|Visited]), !);
        (Y1 is Y + 1, connected_to_boundary(X, Y1, [(X,Y)|Visited]), !);
        (Y1 is Y - 1, connected_to_boundary(X, Y1, [(X,Y)|Visited]), !)
    ).


% A black cell is surrounded if it's not connected to boundary
surrounded_black_cell(X, Y) :-
    input_cell(X, Y, black),
    \+ connected_to_boundary(X, Y).


% change rule
yellow_output_cell(X, Y) :- 
    surrounded_black_cell(X, Y).
% green cells stays where they are
green_output_cell(X, Y) :- green_cell(X, Y).
black_output_cell(X, Y) :- input_cell(X, Y, black), connected_to_boundary(X, Y).

output_cell(X, Y, black) :- black_output_cell(X, Y).
output_cell(X, Y, green) :- green_output_cell(X, Y).
output_cell(X, Y, yellow) :- yellow_output_cell(X, Y).