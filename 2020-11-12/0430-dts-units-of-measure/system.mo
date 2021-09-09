
model System
parameter Real T(quantity="Time", unit="s") = 1; //viene specificata l'unitá di misura, in questo caso il tempo viene rappresentato in secondi

Real x(quantity="Position", unit="m"); //la x rappresenta la posizione, in metri
Boolean y;
Integer z;

initial equation
x = 10;
y = false;
z = 2;

equation

when sample(1, T) then

x = next(pre(x), -2.4*pre(x));

y = not(pre(y));

end when;


when sample(1, 2*T) then

z = -pre(z);

end when;


end System;


//dichiarazione delle unitá di misura, utili per fare un sanity check, per evitare che si sommino le mele con le pere
