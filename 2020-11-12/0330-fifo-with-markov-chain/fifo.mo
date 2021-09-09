
class FIFO


parameter Real x0 = 3.5;  // MB in FIFO

input Real p_out;  // output MB/sec
input Real p_in;  //  input MB/sec
input Integer u;

Real x;   // FIFO  MB


initial equation
x = x0;

equation

der(x) = u*p_in - p_out;


end FIFO;




