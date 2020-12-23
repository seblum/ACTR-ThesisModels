 # -*- coding: utf-8 -*-
"""
Created on Thu Jul 25 11:22:00 2019

@author: THO1NR
"""

import pandas as pd
import numpy as np
import sys
import os
import random

# Get path of current directory and convert it to lisp
directory_path = os.path.join(os.path.dirname(__file__))

def convertPath(path):
     #sep = os.path.sep
     #print('separator: ' + sep)
     return path.replace(os.path.sep, ';') 
 
directory_path_lisp = convertPath(directory_path)[1:]


sys.path.append(directory_path)
sys.path


import actr
import actcv as cv
import actms as ms
import MMsaveresults as sr
import MMdispatchercmds as cmd


# Load Dispatcher commands
cmd.load_actms_commands()


# create .csv with headers
sr.writeReHeaderCsv(directory_path)

# LOAD ACT-R MODELS
def loadmodels():
    actr.load_act_r_model(directory_path_lisp + ";EF-metamodel.lisp")
    actr.load_act_r_model(directory_path_lisp + ";EF-submodel-left.lisp")
    actr.load_act_r_model(directory_path_lisp + ";EF-submodel-middle.lisp")
    actr.load_act_r_model(directory_path_lisp + ";EF-submodel-right.lisp")

loadmodels()
actr.set_current_model("main-model")          

#ms.getutility()
#ms.saveutility()

timesRun = 1
## ----- -----
# loop over all datasets
session = [2,3,4,5,7,9,10,13]
#session = [5,7,13]
session = [5]

for tr in range(timesRun):
    random.shuffle(session)

    print("-"*40 + "-----------------------------")
    print("-"*40 + '   Run: ' + str(tr) )
    print("-"*40 + "-----------------------------")
    print("-"*40 + '  List: ' + str(session) )
    print("-"*40 + "-----------------------------")

    #                                                                                             ms.setsaveutility()

    for ses in session:
        print('Looping Participant: {0}'.format(ses))


        # LOOP AND SCHEDULE EVENT 4
        print('Looping Scenario: 2 | Event: 3')
        data = pd.read_csv(directory_path + '/Data/Session_{0}_scenario_2.csv'.format(ses),
                            sep = ';', dtype = {'ALTITUDE' : float, 'SPEED' : float, 'AOI' : object, 'AlarmActive' : float, 'AOIpT' : str})
            
        head = list(data)
        #print(head)
        actcv = cv.ActCV(data, "TIME")         
        

        actcv.load_States()
        actcv.schedule_Visicon()
        actcv.schedule_Tone(freq = 3000, duration = 3)

        exit()

        ms.end_scenario()

        ms.terminal_run_output()        
        actr.run_until_condition("end-program", True)
        
        ms.saveparticipant(ses)
        ms.savetimesRun(tr)
        sr.appendresultlist()
        sr.writeResultsCsv(directory_path)
        print("-"*30 + " Result saved " + "-"*32)         
        
        #ms.resetutility()
        #ms.getutility()

        actr.reset()
        loadmodels()
        cmd.load_actms_commands()
        #cmd.load_actcv_commands()
        print("-"*30 + " Models Reloaded " + "-"*30)         

        #ms.setutility()
        
        
        ms.resetresultlist()

        # reload act-r
        actr.set_current_model("main-model")
        actr.delete_all_visicon_features()

    print("-"*30 + " " + "-"*22 + " " + "-"*30)
    print("-"*30 + "    END SIMULATION     " + "-"*30)         
    print("-"*30 + " " + "-"*22 + " " + "-"*30)



