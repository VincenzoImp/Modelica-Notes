
block Ctr   // car controller

parameter Real T = 3;

input TrafficLightSignal y;

input CarState x;

output Driver u;

equation

when sample(0, T) then

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

end when;

end Ctr;


/*
nei controllori precedenti si usava equation senza "when sample(0, T)", il che vuol dire che il controllore guardava il semaforo ogni istante
questo puó essere dispendioso, quindi questo controllore guarda il semaforo, per prendere decisioni, ogni T secondi
*/
