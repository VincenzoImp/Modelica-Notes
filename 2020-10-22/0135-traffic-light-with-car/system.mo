class System


TrafficLight p; //qui dichiaro i tre oggetti che mi servono
Car q;
Driver u;

initial equation
u = Driver.go; //inizializzo lo stato di driver perché é lunico di cui non abbiamo un inizzializzazione

equation

u = Driver.go; 

connect(q.u, u);
//connect(y, p.x);

end System;

/*
da notare che la riga "u = Driver.go;" dopo equation indica che il driver varrá sempre go
in questo caso driver fa go a prescindere, perché ancora dobbiamo programmarlo bene
infatti avremo un driver squilibrato che accellera incondizionatamente davanti ad un semaforo
*/
