function  next

input Boolean x; //stato prima del colpo di clock
input Boolean u; //input dell'automa
output Boolean y;

algorithm

y := (not(x) and u) or (x and not(u)); //stato dopo il colpo di clock. funzione di transizione per passare da uno stato all'altro

end next;

