% background knowledge (facts)
base(1). base(2). base(3). base(4).
force_out(1).

% current state (facts)
runner_on(2).
runner_on(1).

% mechanics (rules)
force_out(B) :- runner_on(B - 1), force_out(B - 1), base(B).

#show force_out/1.