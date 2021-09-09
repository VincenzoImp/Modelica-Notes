
import os
import sys
import math
import numpy as np
import time
import os.path

from OMPython import OMCSessionZMQ

print("removing old System (if any) ...")
os.system("rm -f ./System")    # remove previous executable, if any.
print("done!")

omc = OMCSessionZMQ()
omc.sendExpression("getVersion()")
omc.sendExpression("cd()")

omc.sendExpression("loadModel(Modelica)")
omc.sendExpression("getErrorString()")

omc.sendExpression("loadFile(\"../../MLibrary/package.mo\")")
omc.sendExpression("getErrorString()")

omc.sendExpression("loadFile(\"mc.mo\")")
omc.sendExpression("getErrorString()")

omc.sendExpression("loadFile(\"ad.mo\")")
omc.sendExpression("getErrorString()")

omc.sendExpression("loadFile(\"fifo.mo\")")
omc.sendExpression("getErrorString()")

omc.sendExpression("loadFile(\"controller.mo\")")
omc.sendExpression("getErrorString()")

omc.sendExpression("loadFile(\"monitor.mo\")")
omc.sendExpression("getErrorString()")

omc.sendExpression("loadFile(\"monitor2.mo\")")
omc.sendExpression("getErrorString()")

omc.sendExpression("loadFile(\"system.mo\")")
omc.sendExpression("getErrorString()")

omc.sendExpression("buildModel(System, stopTime=1000)")
omc.sendExpression("getErrorString()")

#  Grid Search
#  Decision variables: ctr.T, ctr.ctr_min, ctr.ctr_max

p = 10    # number of grid points for each variable. quanto fitti devono essere gli intervelli sotto descritti

# bounds 
#il rate di controllo del conttrollore
min_T = 0.05
max_T = 0.2
delta_T = (max_T - min_T)/(p - 1)

#il valore fino a cui il controllore accetta l'input tranquillamente
max_ctrmin = 4.0  
min_ctrmin = 3.0
delta_ctrmin = (max_ctrmin - min_ctrmin)/(p - 1)

#il valore dopo cui il controllore rifiuta l'input tranquillamente
max_ctrmax = 4.5
min_ctrmax = 3.5
delta_ctrmax = (max_ctrmax - min_ctrmax)/(p - 1)

#vogliamo trovare la miglior combinazione dei tre valori del controllore descritti precedentemente
#lo scopo é quello di far contento il monitor2 per avvicinarsi il piú possibile al valore medio ideale precedentemente stabilito. e questo sará possibile trovando la migliore combinazione. oltre a quello di non ingrandire troppo il clock del controllore (T) perché c'é sempre il controllo del monitor che controlla l'overflow e l'underflow

best_obj = 10000.0
best_kpi2 = 0.0
best_val1 = 0.0
best_val2 = 0.0
best_val3 = 0.0

num_fail = 0.0
num_pass = 0.0
total_tests = 0.0

with open ("output.txt", 'wt') as f:
    f.write("Outcomes"+"\n\n")
    f.flush()
    os.fsync(f)


for i1 in range(0, p, 1):
        
    for i2 in range(0, p, 1):
            
        for i3 in range(0, p, 1):
                        
            par1 = min_T + delta_T*i1
            par2 = min_ctrmin + delta_ctrmin*i2
            par3 = min_ctrmax + delta_ctrmax*i3

            #print("Checking i1, i2, i3, par1, par2, par3: ",  i1, i2, i3, par1, par2, par3)
            total_tests = total_tests + 1
                        
            if (par2 >= par3) :
                # skip meaningless
                continue
                #print("Simulating i1, i2, i3, par1, par2, par3",  i1, i2, i3, par1, par2, par3)
                
                with open ("parameters.txt", 'wt') as f:                
                    f.write("ctr.T="+str(par1)+"\n"+"ctr.ctr_min="+str(par2)+"\n"+"ctr.ctr_max="+str(par3)+"\n")
                    f.flush()
                    os.fsync(f)
        
                    os.system("./System -s=rungekutta -overrideFile=parameters.txt > log")
	                time.sleep(1.0)         # Delay to avoid races on file re-writings. Can be dropped for non-toy examples.
                    #os.system("rm -f parameters.txt")    # .... to be on the safe side
                    #print("Simulation done!")
                        
	                y1 = omc.sendExpression("val(monitor.y, 1000.0, \"System_res.mat\")")
 	                y2 = omc.sendExpression("val(kpi2.y, 1000.0, \"System_res.mat\")")
                    y3 = 0.8*y2 - 0.2*par1
                    
                    #os.system("rm -f System_res.mat")      # .... to be on the safe side
        
                    # print("Monitor value at (sampling time = ", val2, ", iteration = ", i, ", arrival_delay =", rand1, "): ",  y)

                    if (y1 <= 0.5) :  
                        # feasible
                        num_pass = num_pass + 1.0
                        if (best_obj > y3):
                            best_obj = y3
                            best_kpi2 = y2
                            best_val1 = par1
                            best_val2 = par2
                            best_val3 = par3
                               
                            with open ("output.txt", 'a') as g:
                                g.write("Feasible: ctr.T="+str(par1)+"; "+"ctr.ctr_min="+str(par2)+"; "+"ctr.ctr_max="+str(par3)+"; "+"kpi2="+str(y2)+"; y3="+str(y3)+"; best-so-far="+str(best_obj)+"\n")
                                g.flush()
                                os.fsync(g)        
                    else:
                        # infeasible
                        num_fail = num_fail + 1.0
                        with open ("output.txt", 'a') as g:
                            g.write("Infeasible: ctr.T="+str(par1)+"; "+"ctr.ctr_min="+str(par2)+"; "+"ctr.ctr_max="+str(par3)+"; "+"kpi2="+str(y2)+"; y3="+str(y3)+"; best-so-far="+str(best_obj)+"\n")
                            g.flush()
                            os.fsync(g)
 


                
#print("sampling time = ", val2)
print("num feasible = ", num_pass, ", num infeasible = ", num_fail, ", total tests = ",  total_tests)
#print("pass prob = ", num_pass/total_tests, ", fail prob = ", num_fail/total_tests)
 

print("Best solution: ")
print("Obj = ", best_obj)
print("kpi2 = ", best_kpi2)
print("ctr.T = ", best_val1)
print("ctr.ctr_min = ", best_val2)
print("ctr.ctr_max = ", best_val3)
 
