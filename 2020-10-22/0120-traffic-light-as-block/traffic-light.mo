
block TrafficLight

parameter Real RedTimer = 6; //questi tre parameter servono a dichiarare le tre variabili reali che corrispondono alla durata degli stati del semaforo che verrá dichiarato poi con la variabile x0
parameter Real GreenTimer = 6;
parameter Real OrangeTimer = 3;
// parameter Real OrangeTimer = 1;   // t0o short, ctr fails

parameter Real T = 0.1;   // time step, indica il clock che verrá usato in seguito

parameter TrafficLightSignal x0 = TrafficLightSignal.green;  // initial signal value. stato iniziale del semaforo (automa)
parameter Real c0 = GreenTimer;  //timer relativo allo stato iniziale del semaforo (automa)

output TrafficLightSignal x;

//protected
Real counter;

initial equation //ci dice quali sono le variabili al tempo zero, serebbero i vincoli da rispettare all'inizio
counter = c0; //il vero contatore "counter" prende il valore di c0
x = x0; //il vero semaforo "x" prende il velore di x0

algorithm

when sample(0, T)  then //ogni T secondi viene eseguito il codice dentro al when


if (pre(counter) <= 0) //qui si controlla che il nostro timer sia <= 0
then // se lo é vuol dire che il timer dello stato corrente é scaduto e bisogna cambiare stato e timer 
	if (pre(x) == TrafficLightSignal.green)  then//infatti se lo stato di x prima del clock che ci ha permesso l'ingresso nel when era green, lo stato deve essere cambiato in giallo e il timer deve essere cambiato nel timer giallo
	       x := TrafficLightSignal.orange;
               counter := OrangeTimer;
     
	elseif (pre(x) == TrafficLightSignal.orange) then //stessa analoga cosa se il semaforo prima del clock era giallo, e quindi va cambiato in rosso
     	      x := TrafficLightSignal.red;
	      counter := RedTimer;
     
	else  // pre(x) == TrafficLightSignal.red. nell'ultimo daso il semaforo da rosso deve cambiare in verde
     	       x := TrafficLightSignal.green;
	       counter := GreenTimer;
     	end if;
else //se il timer non é <=0 allora dobbiamo decrementare counter con il valore di T perché é passato un lasso di tempo uguale a T
   counter := pre(counter) - T; //quindi il counter dopo il colpo di clock é il count precedente al colpo di clock - T
end if;


end when;

end TrafficLight;







/*
block é un oggetto (anche le funcition sono oggetti)
a differenza di function, block puó avere uno stato interno
block puó quindi avere input e output come una funcition

osservazione che potrebbe essere vera e spiegare molte cose:
avendo il "when semple(_,_) then" e il comando "pre(x)" dentro il when, allora pre(x) é il valore di x nel lasso di tempo precedente all'ultimo colpo di clock (che poi sarebbe quello che ci ha permesso l'ingresso nel when)
non credo si possa usare il pre(_) fuori dal when a questo punto
e credo che se nel when non ci sono assegnazioni di x diverse da (x := pre(x)), allora (pre(x)==x) é vera
e qui un ultimo dubbio: se non assegno un nuovo valore a x quando scatta il clock, c'é un assegnamento automatico del tipo x := pre(x)? oppure vanno sempre aggiornate obbligatoriamente le variabili ad ogni colpo di clock?
ultimo dubbio: visto il comportamento del pre(_), é fortemente consigliato (oppure buona norma) dichiarare lo stato iniziale delle variabili?
*/
