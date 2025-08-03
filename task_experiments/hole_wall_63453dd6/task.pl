
rows(16).
cols(16).
% there is a blue wall in the task somewhere
divider(11).
% the whole grid to the right of the vertical wall is empty of shapes in the input.
% the shapes are all rigidly translated right until they touch the blue wall.
% every "enclosed hole" in a shape that has a border directly touching the blue wall transforms
% the 