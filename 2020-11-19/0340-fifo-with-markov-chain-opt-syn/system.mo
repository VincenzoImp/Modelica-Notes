

model System

Markov_Chain mc(samplePeriod=0.1);
Controller ctr;
FIFO fifo;
Monitor monitor;
Monitor2 kpi2;

Real p_in, p_out, y;

equation

y = ((mc.x - 1.0)/(mc.size - 1.0));

p_in = 3.5 + 2*(-1 + 2*y);

//p_in = 3.5 + 2.0*(-1 + 2*r_in.r1024);

p_out = 3.5;



connect(fifo.p_out, p_out);
connect(fifo.p_in, p_in);
connect(monitor.x, fifo.x);
connect(kpi2.x, fifo.x);
connect(fifo.x, ctr.x);
connect(fifo.u, ctr.u);


end System;