
block Controller

    parameter Real T = 0.05;
    parameter Real ctr_min = 4.555;
    parameter Real ctr_max = 4.611;

    // ad conversion parameters
    input Real Delta = 0.01;  // 10 KB
    input Real LoVal = 0;
    input Real HiVal = 6;

    input Real x;  // FIFO MB
    output Integer u;  // u=0 no admission, u=1 admission

    Real sensor;

    initial equation
        u = 1;

    equation
        when sample(0, T) then
            sensor = ad(Delta, LoVal, HiVal, x);

            if (sensor <= ctr_min) then 
                u = 1;
            else 
                if (sensor >= ctr_max) then 
                    u = 0;
                else 
                    u = pre(u);
                end if;
            end if;
        end when ;


end Controller;

//controllore che decide se acquisire il flusso in input o meno, osservando la quantitá di dati giá presente nel buffer



