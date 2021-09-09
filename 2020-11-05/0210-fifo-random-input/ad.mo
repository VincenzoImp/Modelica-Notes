function ad

    input Real Delta;
    input Real LoVal;
    input Real HiVal;
    input Real x;

    output Real y;

    algorithm

    if (x <= LoVal) then
        y := LoVal;
    else 
        if (x >= HiVal) then
            y := HiVal;
        else
            y := Delta*floor((x/Delta) + 0.5);
        end if;
    end if;

end ad;


/*
funzione che "raffina" x, che rappresenta il valore generato da random
faffinare significa modellarlo per il nostro sistema
che puó ricevere in input al meno LoVal mb e al piú HiVal mb
i numeri dopo la virgola dei valori in mezzo a LoVal e HiVal, sono definiti dalla grana Delta
*/
