
class Controller

    parameter Real T = 1.0; //frequenza di attivazione del controllore, ogni 1.0 secondi il controllore si attiva e svolge il suo compito 

    // ad conversion parameters
    input Real Delta = 0.01;  // 10 KB. questa é la grana (trama) dei valori in ingresso
    input Real LoVal = 0; //minimo valore che possiamo ricevere in ingresso
    input Real HiVal = 6; //massimo valore che possiamo ricevere in ingresso

    input Real x;  // FIFO MB. mb che vogliono entrare nel buffer
    output Integer u;  // u=0 fifo closed, u=1 fifo opened. variabile che il controllore da in out che decide se i dati possono entrare o meno

    Real sensor;

    initial equation

    u = 0;

    equation

    when sample(0, T) then

        sensor = ad(Delta, LoVal, HiVal, x); //chiamo la funzione ad descritta in un altro file. fornisce i mb che vogliono entrare nel buffer "raffinando" x

        if (sensor <= 3.4) then //se la capienza del buffer é <= 3.4 mb allora faccio accedere i dati
            u = 1;
        else //altrimenti
            if (sensor >= 3.6) then//se la capienza del buffer é >= 3.6 mb allora NON faccio accedere i dati
                u = 0;
            else //altrimenti la decisione del controllore sará come l'ultima decisione presa
                u = pre(u); 
            end if;
        end if;

    end when ;

end Controller;


/*
il cervello del sistema (ció che dobbiamo programmare) 
decide se permettere l'accesso al buffer ai mb che devono entrare
*/
