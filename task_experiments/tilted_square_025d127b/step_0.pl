input_skewed_rect(top, pink, medium).
input_skewed_rect(center, red, small).

output_skewed_rect(PLACE, COLOR, SIZE) :- 
  input_skewed_rect(PLACE, COLOR, SIZE).