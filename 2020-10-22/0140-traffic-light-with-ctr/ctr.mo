
block Ctr   // car controller

input TrafficLightSignal y;

output Driver u;

equation //questo non é algorithm perché le indicazioni sottostanti devnon valere sempre 
//se seguenti indicazioni sonmp molto esplicative
	if (y == TrafficLightSignal.green) then 
	       u = Driver.go;
     
	elseif (y == TrafficLightSignal.orange) then
	       u = Driver.go;
     
	else  // y == TrafficLightSignal.red
	       u = Driver.stop;
     	end if;

end Ctr;


/*
questo block sarebbe in controllo automatico della macchina che fa quindi da driver
prende in input lo stato del semaforo e ritorna lo stato del driver


il controllore fa go sul verde e sul giallo e stop sul rosso
questo succede sempre, anche quando la car é distante chilometri oppure ha gia superato lincrocio
il controllore quindi é piú responsabile ma un po' tonto perché si ferma anche buffo
si potrebbe anche fermare in mezzo all'incrocio invece di completare l'attraversamento perché é scattato il rosso nel mentre
*/
