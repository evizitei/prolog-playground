resistor(power, n1).
resistor(power, n2).

transistor(n2,ground,n1).
transistor(n3,n4,n2).
transistor(n5,ground,n4).

inverter(Inp, Oup) :- transistor(Inp,ground,Oup), resistor(power, Oup).

nand_gate(I1, I2, O) :- 
    transistor(I1,X,O),
    transistor(I2,ground,X),
    resistor(power,O).

and_gate(I1,I2,O) :- 
    nand_gate(I1,I2,X),
    inverter(X,O).