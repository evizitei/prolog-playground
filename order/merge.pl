merge([X|Xs],[Y|Ys],[X|Zs]) :- X < Y, merge(Xs, [Y|Ys], Zs).
merge([X|Xs],[Y|Ys],[Y|Zs]) :- X > Y, merge([X|Xs], Ys, Zs).
merge([X|Xs],[Y|Ys],[X,Y|Zs]) :- X =:= Y, merge(Xs, Ys, Zs).
% written this way so that merging [] and [] only hits
% one rule
merge([], [X|Xs], [X|Xs]). 
merge(Xs, [], Xs).