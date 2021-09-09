
class System

Controller ctr; //prendo un controllore
FIFO fifo; //prendo un buffer
Monitor monitor; //prendo un monitor

//RandomNumberGenerator r_in; //prendo un generatore randomico per generare i valori di input per il buffer
//RandomNumberGenerator r_out; //prendo un generatore randomico per generare i valori di output che chiederannol'accesso al buffer

//in questo caso i due generatori randomici voglio definirli manualmente, quindi li dichiaro in quest'altro modo
RandomNumberGenerator r_in(samplePeriod=1.0,globalSeed=30020,localSeed=614657); //samplePeriod=1.0 genero il valore ogni 1.0 secondi
RandomNumberGenerator r_out(samplePeriod=0.5,globalSeed=44315,localSeed=213467); //samplePeriod=0.5 genero il valore ogni 0.5 secondi

Real p_out, p_in; //mb in uscita e mb in ingresso

equation

p_out = 1.5 + 4.5*r_out.r1024; //mb in uscita. questo valore é un numero da 1.5 a 6 (da considerare che r_out.r1024 genera un numero tra 0 e 1)
p_in = 4.0 + 0.5*r_in.r1024; //mb in ingresso. questo valore é un numero da 4.0 a 4.5 (da considerare che r_in.r1024 genera un numero tra 0 e 1)

//faccio tutte le connect del caso
fifo.p_out = p_out;
fifo.p_in = p_in;
fifo.x = ctr.x;
fifo.u = ctr.u;
monitor.x = fifo.x;

end System;
