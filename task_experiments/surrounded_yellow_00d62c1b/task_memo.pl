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