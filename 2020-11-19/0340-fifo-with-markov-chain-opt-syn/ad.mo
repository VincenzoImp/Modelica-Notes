function ad

input Real Delta;
input Real LoVal;
input Real HiVal;
input Real x;

output Real y;

algorithm

if (x <= LoVal) 
then  y := LoVal;
else  if (x >= HiVal)
      then y := HiVal;
      else y := Delta*floor((x/Delta) + 0.5);
      end if;
end if;

end ad;



//funzione che trasforma la x da analogico a digitale
//dati gli input (x: valore da arrotondare, delta: quanto fitta é la griglia, LoVal: minimo valore possibile, HiVal: massimo valore possibile)
//si ottiene in output l'arrotondamento di x ad un valore y che é un intervallo possibile
