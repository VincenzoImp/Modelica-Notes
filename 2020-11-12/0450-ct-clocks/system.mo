
model System

Real x;

discrete Real z;

discrete Real y;

discrete Real w;

discrete Real td;

initial equation
x = 10;

equation

der(x) = -0.1*x;

y = sample(x, Clock(1, 1)); //scatta ogni 1/1 unitá di tempo

z = sample(x, Clock(2, 1)); //scatta ogni 2/1 unitá di tempo

w = sample(x, Clock(1, 5)); //scatta ogni 1/5 unitá di tempo

td = sample(time, Clock(1, 1)); //scatta ogni 1/1 unitá di tempo

end System;


//invece di usare when semple() si puó progettare un proprio clock
//gli argomenti di Clock devono essere sempre numeri razionali

//per usare questi clock il codice va compilato nel seguente modo: "omc +std=3.3 run.mos"
