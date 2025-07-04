course(
    complexity,
    time(monday, 9, 11),
    lecturer(david, harel),
    location(feinberg, a)
).

course(
    complexity,
    time(tuesday, 9, 11),
    lecturer(david, harel),
    location(feinberg, a)
).

course(
    logic,
    time(tuesday, 8, 10),
    lecturer(stephen, dunkin),
    location(howlsly, c)
).

plus(9,1,10).
plus(9, 2, 11).
plus(9, 3, 12).

lecturer(Lecturer,Course) :- course(Course,_,Lecturer,_).
duration(Course,Length) :- course(Course,time(_,Start,End),_,_),
                           plus(Start,Length,End).

location(Course, Building) :- course(Course,_,_,location(Building, _)).
busy(Lecturer, Time) :- course(_,Time,Lecturer,_).

overlap(Name1, Name2) :- 
    course(Name1, time(Day, Start1, Finish1), _, _),
    course(Name2, time(Day, Start2, Finish2), _, _),
    Start1 < Finish2, Finish1 > Start2, Name1 \= Name2.

cannot_meet(L1, L2, Time) :- busy(L1, Time), L1 \= L2.
cannot_meet(L1, L2, Time) :- busy(L2, Time), L1 \= L2.
