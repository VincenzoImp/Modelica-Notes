
class Monitor

input Real x;  // fifo level. mb nel bubber
output Boolean y; //valore booleano per notificare se c'é stato un overflow o un underflow

Boolean z;

initial equation
y = false;
z = false;

equation

z = (x >= 5) or (x <= 0); //se l'equazione risulta vera c'é stato qualcosa di sbagliato

algorithm

when edge(z) then //se la z passa a true
y := true; //il valore che notifica se ci sono stati errori passa a true
end when;



end Monitor;

/*
monitora se rientriamo nei limiti del buffer (tra 0 e 5)
e quindi ci notific se é avvenuto un overflow o un underflow
*/
