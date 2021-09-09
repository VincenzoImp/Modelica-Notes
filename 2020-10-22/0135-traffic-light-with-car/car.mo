
block Car

parameter Real CrossingTimer = 2; //la macchina ci mette due secondi ad attraversare
parameter Real BeforeTimer = 1; //sta un secondo nello stato prima di attraversare
parameter Real PastTimer = 1; //sta un secondo nello stato di superato
parameter Real ArrivalDelay = 10; //questo é quanto ci mette la macchina prima di arrivare al semaforo. questo serve per studiare differenti casi di arrivo, se questo valore dovesse essere modificato

parameter Real T = 0.2;   // time step. qui diamo un colpo di clock ogni 0.2 secondi

parameter CarState x0 = CarState.before;  // initial signal value. lo stato iniziae dell'auto é before giustamente 
parameter Real c0 = ArrivalDelay;  // arrival delay. il timer centrale al tempo di inizio, che ci é utile per capire quanto tempo manca ai passaggi di stato delle cose. viene iniziato a ArrivalDelay giustamente

input  Driver u; //input della macchina é lo stato del driver
output CarState x; //l'output é lo stato della macchina dato dalla variabile x

//protected
Real counter; //il timer centrale

initial equation //inizializiamo counter e x con i loro valori iniziali, cosí anche da consentire la funzione pre su queste variabili
counter = c0;
x = x0;

algorithm

when sample(0, T) then //se scatta il clock


    if (pre(counter) <= 0) then//e siamo giunti alla fine del timer counter

        if (pre(x) == CarState.before) then //se la macchina era prima del semaforo
            if (u == Driver.go) then //e l'autista dice go 
                x := CarState.crossing; //allora la macchina passa nello stato di crossing
            counter := CrossingTimer; //e il counter prende il valore del tempo di crossing
            else // u == Driver.stop. se l'autista non si muove
                x := pre(x); //la macchina rimane nello stasso stato di prima
            counter := 0; //e il counter resta <=0. si speri che l'autista cambi stato cosí da permettere anche il camvbio stato della macchina
            end if;
        
        elseif (pre(x) == CarState.crossing) then //se la macchina stava attraversando
            if (u == Driver.go) then //e l'autista é in go
                x := CarState.past; //allora la macchina va in arrtaversato
                counter := PastTimer; //e il timer viene messo a PastTimer per mermettere alla macchina di terminare questo nuovo stato   
            else // u == Driver.stop. se l'autista é stop
                x := pre(x); //allora la macchina rimane nel vecchio stato
                counter := 0; //e il counter resta <=0. si speri che l'autista cambi stato cosí da permettere anche il camvbio stato della macchina
            end if;
    
        else  // pre(x) == CarState.past. se la macchina stava in attraversato
            x := CarState.past; //rimane in attraversato indipendentemente dallo stato del driver, perche la car non puó fare nient'altro
            counter := 0; //e il counter viene messo a zero
        end if;

    else //se non siamo ancora giunti alla fine del timer counter lo decrementiamo solo di T secondi
        counter := pre(counter) - T;
    end if;


end when;

end Car;



/*
la car é molto simile al semaforo. questo non é un caso, é prorpio un approccio di modellazzione
da notare che in questo block vanno prese le decizioni sui cambi di stao dell'auto
*/
