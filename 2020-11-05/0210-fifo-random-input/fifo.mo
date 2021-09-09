
block FIFO

    parameter Real x0 = 3.5;  // MB in FIFO. numero di mb presenti nel buffer al tempo 0

    input Real p_out;  // output MB/sec. flusso di dati in uscita
    input Real p_in;  // input MB/sec. flusso di dati in entrata
    input Integer u; // numero che controlla se l'input nel buffer in quel momento viene ammesso oppure no

    output Real x;   // FIFO  MB. numero di mb nel buffer


    initial equation
    x = x0;

    equation

    der(x) = u*p_in - p_out; //dico come varia il numero di mb nel buffer al variare del tempo. questo in modelica si puó monitorare usando la funzione der(), che credo moditori la variazione di una variabile in tempo continuo. in questo caso se u=1 ammetto in ingresso nel buffer i mb che chiedono di entrare, se u=0 non ammetto. la variazione di x é dettata dal delta tra p_in - p_out, ovvero quelli che entrano meno quelli che escono


end FIFO;


/*
il codice monitora la capienza del buffer
il codice riceve input il rate di mb in ingresso e in uscita, e la variabile u che decide se ammettere i mb in ingresso
*/
