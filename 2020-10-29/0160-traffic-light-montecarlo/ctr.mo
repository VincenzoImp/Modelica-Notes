
block Ctr   // car controller

input TrafficLightSignal y;

output Driver u;

equation

	if (y == TrafficLightSignal.green) then
	       u = Driver.go;
     
	elseif (y == TrafficLightSignal.orange) then
	       u = Driver.stop;
     
	else  // y == TrafficLightSignal.red
	       u = Driver.stop;
     	end if;

end Ctr;
