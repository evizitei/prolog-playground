
rows(16).
cols(16).
% there is a blue wall in the task somewhere
divider(11).
% the whole grid to the right of the vertical wall is empty of shapes in the input.
% there are some black shapes in the input anchored by the right most cell,
% filter to the
shape(one, 5).
shape(two, 10).

% each shape has holes in it shape_hole_cell(shape_name, cell_x, cell_y).

shape_hole_cell(one, 4, 4). 
shape_hole_cell(one, 2, 1).
shape_hole_cell(one, 4, 5).
shape_hole_cell(one, 4, 6).

shape_hole_cell(two, 9, 12).
shape_hole_cell(two, 9, 13).

% the shapes are all rigidly translated right until they touch the blue wall.
translate_right(SHAPE_NAME, N) :- 
  shape(SHAPE_NAME, START), 
  divider(GOAL),
  N is GOAL - (START + 1).

out_shape_hole_cell(NAME, X, Y) :-
  shape_hole_cell(NAME, Start_x, Y),
  translate_right(NAME, N),
  X is Start_x + N.

% every "enclosed hole" in a shape that has a border directly touching the blue wall transforms
% the whole row to the right of the wall.
right_of_wall_highlight(ROW_NUM) :- 
    divider(N), 
    CELL_X is N - 2.
    out_shape_hole_cell(_, CELL_X, ROW_NUM).




