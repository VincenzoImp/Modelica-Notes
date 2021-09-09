class System


TrafficLightSignal x; //dichiariamo x un semaforo

initial equation //qui definiamo le equazioni (vincoli)

x = TrafficLightSignal.green; //ovvero che il semaforo parte col verde

algorithm //qui inizia l'algoritmo

when sample(1, 2) then //entra nel when quando l'espressione é vera

x := next(pre(x)); //qui la cosa é complessa. x sará il nuovo stato e questa riga viene eseguita dopo che il tick del sample é scattato, quindi in realtá ci troviamo temporalmente nel nuovo stato, quindi a next va dato lo stato precedente di x, che é quello che conosciamo ed é quello che fino a prima del tick di sample era corretto, ma dopo il tick va cambiato stato di x e quindi si chiama next e come argomento gli passiamo lo stato di x nel periodo di tempo precedente al tick che é lo stato di x nel tempo precedente 

end when;



end System;

/*
system é la root class
la classe system é quella principale potremmo dire, quella che rapppresanta il sistema
(il prof ha detto che si puó anche usare la parola chiave model al posto di questo tipo di dichiarazione di classe, vedremo piú avanti?)
sample(1, 2) significa che questa espressione é vera solo quando il tempo corrisponde al primo elemento del sample() oppure a tutti gli attimi di tempo che si ottengono sommando al primo elemento il secondo, in questo caso l'espressione é vera in 1 3 5 7 9 ... l'unitá di misura é il secondo
il when si comporta come un if, ma differisce da quest'ultimo perche il when agisce sul tempo, e viene eseguito infinite volte, e si entra dentro il when quando l'espressione da controllare nel when é vera
sample é come se fosse un clock
se duplico la riga "x := next(pre(x));" non succede nulla, perché il tempo mentre eseguo le due righe equivalenti é lo stesso e quindi il risultato é sempre lo stesso 
*/
