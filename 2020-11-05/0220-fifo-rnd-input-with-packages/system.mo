

model System

import Rng = MLibrary.Random.Generator ;

Controller ctr;
FIFO fifo;
Monitor monitor;

Rng.generator1024 r_in(samplePeriod=0.1, globalSeed = 156, localSeed = 1689);


Real p_in, p_out;

equation

p_in = 3.5 + 2.0*(-1 + 2*r_in.r1024);

p_out = 3.5;



fifo.p_out = p_out;
fifo.p_in = p_in;
fifo.x = ctr.x;
fifo.u = ctr.u;
monitor.x = fifo.x;

end System;