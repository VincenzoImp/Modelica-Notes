
class Controller


parameter Real T = 0.1;

// ad conversion parameters
input Real Delta = 0.1;  // 1 KL 
input Real LoVal = 0;
input Real HiVal = 6;

input Real x;  // FIFO bits
output Integer u;  // u=0 no admission, u=1 admission

Real sensor;

initial equation

u = 1;


equation


when sample(0, T) then

sensor = ad(Delta, LoVal, HiVal, x);

if (sensor <= 4.0) 
then u = 1;
else if (sensor >= 3.9) 
      then u = 0;
      else u = pre(u);
      end if;
end if;

end when ;


end Controller;




