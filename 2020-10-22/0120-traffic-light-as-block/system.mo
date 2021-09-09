class System


TrafficLight p; //l'ogetto p di tipo TrafficLight raffigura l'ogetto creato in traffic-light.mo, che contiene le variabili x e count

TrafficLightSignal y; //l'ogetto y di tipo TrafficLightSignal raffigura i tre segnali verde giallo rosso

equation

connect(y, p.x); //connettiamo y che sarebbero gli stati del semaforo con p.x, anche perché TrafficLightSignal é usato in TrafficLight. p.x é la variabile x dell'ogetto p

end System;



/*
la system in questo caso si limita a connettere oggetti
*/
