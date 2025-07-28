subterm(Term, Term).
subterm(Sub,Term) :- compound(Term), functor(Term, F, N), subterm(N, Sub, Term).
subterm(N,Sub,Term) :- N > 1, N1 is N - 1, subterm(N1, Sub, Term).
subterm(N,Sub,Term) :- arg(N,Term,Arg), subterm(Sub, Arg).