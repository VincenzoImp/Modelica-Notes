class System


TrafficLight p;
Car q;
Ctr k;


equation

connect(k.y, p.x); //questa connect connette il semaforo espresso nel controllore k, con il semaforo espresso in p
connect(q.u, k.u); //questa connect connette il driver espresso nella car q con il driver espresso nel controllore k

end System;


/*
in questa system devono valere sempre queste due connect
*/
