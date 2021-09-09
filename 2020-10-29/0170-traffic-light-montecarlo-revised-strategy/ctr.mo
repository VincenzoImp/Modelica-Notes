
block Ctr   // car controller

input TrafficLightSignal y;

input CarState x;

output Driver u;

equation

if (x == CarState.before) then

    if (y == TrafficLightSignal.green) then
        u = Driver.go;
     
    elseif (y == TrafficLightSignal.orange) then
        u = Driver.stop;
     
    else  // y == TrafficLightSignal.red
        u = Driver.stop;
    end if;

else  // CarState is crossing or past
    u = Driver.go;
end if;

end Ctr;

/*
con questo codice ha l'obbiettivo di considerare solo quando il semaforo é difronte a noi e non anche dopo
il controllore quindi accelera sempre se si trova dopo il semaforo
se si trova davanti, accellera con il verde e invece con il guiallo e rosso frena
*/
