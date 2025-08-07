border(missouri, kansas).
border(missouri, iowa).
border(missouri, arkansas).
border(missouri, oklahoma).
border(missouri, illinois).
border(missouri, tennessee).
border(missouri, kentucky).
border(missouri, nebraska).
border(kansas, nebraska).
border(nebraska, iowa).
border(iowa, illinois).
border(illinois, kentucky).
border(kentucky, tennessee).
border(tennessee, arkansas).
border(arkansas, oklahoma).
border(oklahoma, kansas).

state(X) :- border(X, _).
state(Y) :- border(_, Y).

color(C) :- member(C, [red, green, blue, yellow]).

coloring([], []).
coloring([State | States], [Color | Colors]) :-
  state(State),
  color(Color),
  no_conflicts(State, Color, States, Colors),
  coloring(States, Colors).

no_conflicts(_, _, [], []).
no_conflicts(State, Color, [State2 | States], [Color2 | Colors]) :-
  (border(State, State2); border(State2, State)),
  color(Color),
  color(Color2),
  Color \= Color2,
  no_conflicts(State, Color, States, Colors).

no_conflicts(State, Color, [State2 | States], [_Color2 | Colors]) :-
  \+ border(State, State2),
  \+ border(State2, State),
  no_conflicts(State, Color, States, Colors).




