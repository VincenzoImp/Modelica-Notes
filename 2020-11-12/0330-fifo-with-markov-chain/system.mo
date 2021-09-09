

model System

    Markov_Chain mc(samplePeriod=0.1); //sovrascrivo samplePeriod

    Controller ctr;
    FIFO fifo;
    Monitor monitor;

    Real p_in, p_out, y;

    equation

    y = ((mc.x - 1.0)/(mc.size - 1.0)); //y é tra 0 e 1 ma la probabilitá che y cada tra 0 e 1 non é uniforme, ma dipende dalla matrice di transizione (mc) definita in mc.mo

    p_in = 3.5 + 2.0*(-1 + 2*y);

    //p_in = 3.5 + 2.0*(-1 + 2*r_in.r1024);

    p_out = 3.5;



    connect(fifo.p_out, p_out);
    connect(fifo.p_in, p_in);
    connect(fifo.x, ctr.x);
    connect(fifo.u, ctr.u);
    connect(monitor.x, fifo.x);

end System;
