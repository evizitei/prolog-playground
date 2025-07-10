:- op(200, fy, ~).    % ~ as unary prefix operator



bool_atom(true).
bool_atom(false).

disjunction(X | Y) :- bool_atom(X), bool_atom(Y).

cnf_element(X) :- bool_atom(X).
cnf_element(X) :- disjunction(X).
cnf_element(~X) :- cnf_element(X).

cnf(X) :- cnf_element(X).
cnf(X ^ Y) :- cnf_element(X), cnf_element(Y).





bool(X) :- bool_atom(X).
bool(~X) :- bool(X).
bool(X ^ Y) :- bool(X), bool(Y).
bool(X | Y) :- bool(X), bool(Y).