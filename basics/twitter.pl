tweep(matt).
tweep(mark).
tweep(ruben).
tweep(ethan).
tweep(clem).
tweep(ale).

bad_thing(fighting).
bad_thing(freelancing).
bad_thing(javascripting).

tweets(matt, [compute, is, expensive]).
tweets(mark, [semantics, are, important, and, often, neglected]).
tweets(ethan, [maybe, i, should, talk, about, prolog]).
tweets(ethan, [bleh, twitter]).
tweets(matt, [yall, stop, ThisThing]) :- bad_thing(ThisThing).
tweets(ethan, [yall, stop, javascripting]).