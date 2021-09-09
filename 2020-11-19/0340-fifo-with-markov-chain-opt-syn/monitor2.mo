
class Monitor2

input Real x;  // fifo level
output Real y;

protected
Real z;

initial equation
y = 0;

equation

z = abs(x - 4.5); //z é lo scostamento medio dal punto ideale che il monitor2 ha deciso. ovvero il monitor2 ha deciso che vorrebbe restare su 4.5 ogni istante mediamente

// y(t) = Integral(0, t)(z)/t //questo é il caso in cui sto nel continuo e vorrei fare la media. ma modelica non sa fare gli integrali quindi usiamo la formula appena sotto commentata

// der(y) = -(1/t^2)*Integral(0, t)(z) + (1/t)*z = -(1/t)*y + (1/t)*z = (z - y)/t //questa é la somma per fara la media di z nel tempo continuo senza svolgere l'integrale


der(y) = (z - y)/(time + 0.1); //questa formula si ottiene dalla specifica del rigo commentato precedente //questo + 0.01 (epsilon) serve solo per non far fare casino al compilatore nel caso in sui si ritrovi a fare la divisione per 0

end Monitor2;


/*
il primo monitor (monitor.mo) controlla che non ci sia underflow e overflow
questo monitor invece (monitor2.mo) controllase sia rispettato un range di volatilitá dei mb nel buffer
siccome lo stream di output é costante é meglio avere in media un numero di mb nel buffer che sia maggiore della metá intuitivamente
*/
