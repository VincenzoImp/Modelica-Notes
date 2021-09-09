
function next
input TrafficLightSignal present_state;
output TrafficLightSignal next_state;

algorithm

if (present_state == TrafficLightSignal.green) then
     next_state := TrafficLightSignal.orange;
     
elseif (present_state == TrafficLightSignal.orange) then
     next_state := TrafficLightSignal.red;
     
else  // present_state == TrafficLightSignal.red
     next_state := TrafficLightSignal.green;
     
end if;

end next;


/*
questa é la funzione di transizione da uno stato allaltro dellautoma
per definire una funzione usiamo "function <nomefunzione>" e per terminarla "end <nomefunzione>;"
function é un tipo di classe che prende un input e restituisce un output e si comporta come una funzione appunto
la funzione prende come input lo stato attuale del tipo TrafficLightSignal descritto in types.mo
e restituisce il prossimo stato nel quale il tipo TrafficLightSignal dovrá andare
algorithm é una oparola chiave che sta a significare che le istruzioni scritte sotto dovranno essere eseguite sequenzialmente come un normale argoritmo
l'altra parola chiave al postio di algorithm é equations e serve a definire i vincoli che devono valere per qualunque istante di tempo, mentre in questo caso non importa l'odrdine delle istruzioni 
algorithm e equations possono coesistere? pare di si, vedremo piú avanti
present_state e next_state sono due variabili di tipo TrafficLightSignal
lalgoritmo ritorna il colore del semaforo successivo secondo il normale funzionamento di un semaforo stradale
*/

