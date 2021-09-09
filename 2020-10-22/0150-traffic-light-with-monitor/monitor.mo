
block Monitor

input TrafficLightSignal x; //prendiamo il semaforo
input CarState z; //prendiamo la macchina
output Boolean y; //restituiamo un valore booleano

Boolean w; //espressione di controllo

initial equation //inizializziamo i valori
y = false;
w = false;

equation

w = (x == TrafficLightSignal.red) and (z == CarState.crossing); //questa espressione é vera quando il semaforo é rosso e la macchina sta attraversando l'incrocio

algorithm

when edge(w) then //in qualsiasi momento, quando la variabile w passa da 0 a 1, si entra nel when
y := true;
end when;





end Monitor;

/*
edge(x) vale true quando x passa da 0 a 1
questo monitor serve per capire quando il driver sta guidando correttamente la macchina e quando invece commette degli errori decisionali
quindi quando l'espressione w é vera allora il driver sta sbagliando
se il driver sbaglia, grazie al when facciamo diventare true la nostra variabile che ci dirá se c'é stato un errore o meno
OSS: true corrisponde a 1 e false corrisponde a 0
*/
