substitute(_, _, [], []).
substitute(X, Y, [X | Xs], [Y | Ys]) :- substitute(X, Y, Xs, Ys).
substitute(X, Y, [Z | Xs], [Z | Zs]) :- Z \= X, substitute(X, Y, Xs, Zs).