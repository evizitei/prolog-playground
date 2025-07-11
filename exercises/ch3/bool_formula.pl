:- op(200, fy, ~).    % ~ as unary prefix operator



bool_atom(true).
bool_atom(false).

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






