:- op(200, fy, ~).    % ~ as unary prefix operator



bool_atom(true).
bool_atom(false).
% variables
bool_atom(a).
bool_atom(b).
bool_atom(c).
bool_atom(d).
bool_atom(x).
bool_atom(y).
bool_atom(z).

disjunct_element(X) :- bool_atom(X).
disjunct_element(~X) :- bool_atom(X).
disjunct_element(X | Y) :- disjunct_element(X), disjunct_element(Y).
disjunction(X | Y) :- disjunct_element(X), disjunct_element(Y).

cnf_element(X) :- bool_atom(X).
cnf_element(~X) :- bool_atom(X).
cnf_element(X) :- disjunction(X).


cnf(X) :- cnf_element(X).
cnf(X ^ Y) :- cnf_element(X), cnf_element(Y).





bool(X) :- bool_atom(X).
bool(~X) :- bool(X).
bool(X ^ Y) :- bool(X), bool(Y).
bool(X | Y) :- bool(X), bool(Y).


negation_inwards(X, X) :- cnf_element(X).
negation_inwards(~(X ^ Y), (X1 | Y1)) :- bool(X), bool(Y), 
  negation_inwards(~(X), X1), negation_inwards(~(Y), Y1).
negation_inwards(~(X | Y), (X1 ^ Y1)) :- bool(X), bool(Y), 
  negation_inwards(~(X), X1), negation_inwards(~(Y), Y1).
negation_inwards(~(~X), Y) :- bool(X), negation_inwards(X, Y).


to_cnf(X, X) :- cnf(X).
to_cnf((X | Y), X | Y) :- disjunct_element(X), disjunct_element(Y).
to_cnf(X | Y, X | Y) :- disjunct_element(X), disjunct_element(Y).
to_cnf(~X, Y) :- negation_inwards(~X, YN), to_cnf(YN, Y).
to_cnf(X1 | (X2 ^ X3), Y1 ^ Y2) :- 
  to_cnf((X1 | X2), Y1), to_cnf((X1 | X3), Y2).
to_cnf(X ^ Y, X1 ^ Y1) :- 
  to_cnf(X, X1), to_cnf(Y, Y1).



