class System

parameter Real[2,2] A = {{0.5, 10}, {-10, 0.5}};

Real[2] x;

initial equation

x[1] = 2;
x[2] = 2;

equation

der(x) = A*x;

// This means:
// der(x[1]) = A[1,1]*x[1] + A[1, 2]*x[2];
// der(x[2]) = A[2,1]*x[1] + A[2, 2]*x[2];

end System;


//simulazione di sistemi lineari a tempo continuo. matrice per vettore
