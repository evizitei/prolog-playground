.decl water_temp(Location: symbol, Temperature: number)
.decl temp_category(Location: symbol, Category: symbol)

water_temp("sink", 52).
water_temp("fridge", 36).
water_temp("ice_bucket", 25).
water_temp("stove", 212).

temp_category(L, "boiling") :- water_temp(L, T), T >= 212.
temp_category(L, "hot") :- water_temp(L, T), T >= 100.
temp_category(L, "room") :- water_temp(L, T), T >= 50, T < 100.
temp_category(L, "cold") :- water_temp(L, T), T < 50.
temp_category(L, "freezing") :- water_temp(L, T), T <= 32.

.output temp_category


