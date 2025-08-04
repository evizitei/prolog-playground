
% raw cells
input_cell(0,0,black). input_cell(1,0,black). input_cell(2,0,black). input_cell(3,0,black). input_cell(4,0,black). input_cell(5,0,black).
input_cell(0,1,black). input_cell(1,1,black). input_cell(2,1,green). input_cell(3,1,black). input_cell(4,1,black). input_cell(5,1,black).
input_cell(0,2,black). input_cell(1,2,green). input_cell(2,2,black). input_cell(3,2,green). input_cell(4,2,black). input_cell(5,2,black).
input_cell(0,3,black). input_cell(1,3,black). input_cell(2,3,green). input_cell(3,3,black). input_cell(4,3,green). input_cell(5,3,black).
input_cell(0,4,black). input_cell(1,4,black). input_cell(2,4,black). input_cell(3,4,green). input_cell(4,4,black). input_cell(5,4,black).
input_cell(0,5,black). input_cell(1,5,black). input_cell(2,5,black). input_cell(3,5,black). input_cell(4,5,black). input_cell(5,5,black).

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