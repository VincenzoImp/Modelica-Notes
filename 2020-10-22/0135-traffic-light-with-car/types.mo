
type TrafficLightSignal = enumeration( //stati del semaforo che giá abbiamo trattato
green "Go",
orange "PrepareToStop",
red "Stop");


type CarState = enumeration( //stati della macchina che puó stare prima dell'incrocio, sull'incrocio (quindi lo sta attraversando), oppure dopo l'incrocio
before "About to cross",
crossing "Crossing",
past "Crossing completed");

type Driver = enumeration( //il guidatore della macchina che puó muovere la macchina o fermarla
go  "move car ahead",
stop "stop car");
