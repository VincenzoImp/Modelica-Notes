
block Car

parameter Real CrossingTimer = 2;
parameter Real BeforeTimer = 1;
parameter Real PastTimer = 1;
parameter Real ArrivalDelay = 10;

parameter Real T = 0.2;   // time step

parameter CarState x0 = CarState.before;  // initial signal value
parameter Real c0 = ArrivalDelay;  // arrival delay

input  Driver u;
output CarState x;

//protected
Real counter;

initial equation
counter = c0;
x = x0;

algorithm

when sample(0, T) then


if (pre(counter) <= 0)
then
	if (pre(x) == CarState.before) then
	       if (u == Driver.go) then 
	           x := CarState.crossing;
		   counter := CrossingTimer;
	       else // u == Driver.stop
	           x := pre(x);
		   counter := 0;
               end if;
    
     
	elseif (pre(x) == CarState.crossing) then
	       if (u == Driver.go) then 
	           x := CarState.past;
                  counter := PastTimer;	           
	       else // u == Driver.stop
	           x := pre(x);
		   counter := 0;	           
               end if;
 
else  // pre(x) == CarState.past
	      x := CarState.past;
              counter := 0;
end if;

else
   counter := pre(counter) - T;
end if;


end when;

end Car;