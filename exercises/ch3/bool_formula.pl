:- op(200, fy, ~).    % ~ as unary prefix operator


bool(true).
bool(false).
bool(~X) :- bool(X).
bool(X ^ Y) :- bool(X), bool(Y).
bool(X | Y) :- bool(X), bool(Y).