class System


Boolean x, u;

initial equation

x = true;
u = true;


equation

when sample(0, 1) then

u = not(pre(u)); //generazione dell'input da dare all'automa

x = next(pre(x), pre(u)); //il nuovo stato viene deciso dalla funzione next

end when;



end System;
