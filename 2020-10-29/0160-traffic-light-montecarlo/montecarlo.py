import os
import sys
import math
import numpy as np
import time
import os.path

from OMPython import OMCSessionZMQ


omc = OMCSessionZMQ()
omc.sendExpression("getVersion()")
omc.sendExpression("cd()")
omc.sendExpression("loadModel(Modelica)")
omc.sendExpression("getErrorString()")

omc.sendExpression("loadFile(\"types.mo\")")
omc.sendExpression("getErrorString()")

omc.sendExpression("loadFile(\"car.mo\")")
omc.sendExpression("getErrorString()")

omc.sendExpression("loadFile(\"traffic-light.mo\")")
omc.sendExpression("getErrorString()")

omc.sendExpression("loadFile(\"ctr.mo\")")
omc.sendExpression("getErrorString()")

omc.sendExpression("loadFile(\"monitor.mo\")")
omc.sendExpression("getErrorString()")

omc.sendExpression("loadFile(\"system.mo\")")
omc.sendExpression("getErrorString()")

omc.sendExpression("buildModel(System, stopTime=50)")
#omc.sendExpression("getErrorString()")

#  begin testing

# seed random number generator
np.random.seed(1)   #scelgo un random seed

num_pass = 0        # contatore dei test passati
num_fail = 0        # contatore dei test falliti
y = 0.0

with open ("log", 'wt') as f:           # conservo in questo file i dati di log (gli input delle esecuzioni)
    f.write("Begin log"+"\n")
    f.flush()
    os.fsync(f)
        
with open ("output.txt", 'wt') as f:    # conservo in output.txt i dati di uscita (gli output delle esecuzioni)
    f.write("Outcomes"+"\n\n")
    f.flush()
    os.fsync(f)

for i in range(100):    # faccio 100 test
#    print "Test ", i

    with open ("modelica_rand.in", 'wt') as f:
        rand1 = math.trunc(np.random.uniform(0,20)*10.0)/10.0 #decido che randimicamente che ArrivalDelay sará un numerotra 0 e 20 conservando una sola cifra decimale
        f.write("q.ArrivalDelay="+str(rand1)+"\n") #qui il passaggio é importamte, ora serve modificare la variabile ArrivalDelay della classe car. ma ci ricordiamo di aver compilato il System (che sarebbe la root) definendo che la variabile q fosse l'ogetto car, uindi in sintesi devo modificare la variabile q.ArrivalDelay. questo perché noi abbiamoeseguito system che aveva la variabile q e q ha altre variabili al suo interno
        # se ho piú marametri da dover sovrascrivere faccio piú write su questo file
        f.flush()
        os.fsync(f)

    with open ("log", 'a') as f:    #scrivo sul file di log il numero del test che sto andando ad eseguire
        f.write("\nTest "+str(i)+" :\n")
        f.flush()
        os.fsync(f)
        
    os.system("./System -overrideFile=modelica_rand.in >> log") #qui dico di sovrascrive nel file System tutti i valori che trova nel file modelica_rand.in, dove ci viene messo ogni volta il nuovo valore della variabile q.ArrivalDelay. questo é possibile grazie alla flag -overrideFile e scrivo sul file log i mossibili output di questa operzione
    time.sleep(1.0)         # Delay to avoid races on file re-writings. Can be dropped for non-toy examples.
    os.system("rm -f modelica_rand.in")    # .... to be on the safe side. rimuovo il file che non serve piú giusto per essere sicuri

    y = omc.sendExpression("val(m.y, 50.0, \"System_res.mat\")") #con il comando val(_,_,_) chiedo di leggere dal file System_res.mat (dove solitamente vengono scritti i risultati delle variabili della simulazione in ogni istante di tempo) il valore di una variabile, nel nostro caso m.y (che siccome il monitor in System si chiama m, m.y sarebbe la variabile y del monitor ) nellistante di tempo scelto, nel nostro caso dopo 50.0 secondi. questa m.y non é altro che la variabil ehc econtrolla se il monitor ha superato il test oppure no (é 1 se appena fallisce, e rimane 1 fino alla fine del test)
    os.system("rm -f System_res.mat")      # .... to be on the safe side. rimuovo il file che non serve piú giusto per essere sicuri
        
    print("Monitor value at iteration", i, ": ",  y) #stampo per debugging questa riga
        
    with open ("output.txt", 'a') as g: #nell'output scrivo per ogni test fatto se il monitor lo ha superato
        if (y <= 0.5):
            num_pass = num_pass + 1.0 #conto i test passati
            g.write("y["+str(i)+"] = "+str(y)+": PASS with ArrivalDelay = "+str(rand1)+"\n") #riportando il numero del test, lo stato di y se fa pass (quindi 0) e l'ArrivalDelay con cui é stato svolto il test
        else:
            num_fail = num_fail + 1.0 #conto i test falliti
            g.write("y["+str(i)+"] = "+str(y)+": FAIL with ArrivalDelay = "+str(rand1)+"\n") #riportando il numero del test, lo stato di y se fa fail (quindi 1) e l'ArrivalDelay con cui é stato svolto il test
        g.flush()
        os.fsync(g)

#stampo le statistiche dei test fatti
print ("num pass = ", num_pass)
print ("num fail = ", num_fail)
print ("total tests = ",  num_pass + num_fail)
print ("pass prob = ", num_pass/(num_pass + num_fail))
print ("fail prob = ", num_fail/(num_pass + num_fail))

"""
OMPython si usa su python per interfacciarsi con modelica
questa funzionalitá permette di aprire una sessione per inviare i comandi che solitamente erano in run.mos
OMPython quindi ci permette di eseguire lo script modelica tante volte
per rendere tutto piú efficiente l'idea é quella di eseguire una sola volta la compilazione e tante volte l'esecuzione
a questo scopo é utile buildModel(_,_) che genera un eseguibile da poter riutiizzare, invece che usare Symulate(_,_)
"""
