# -*- coding: utf-8 -*-
"""
Created on Thu Jul 25 11:22:00 2019

@author: THO1NR
"""

import pandas as pd
import sys
import os
import random

# Get path of current directory and convert it to lisp
directory_path = os.path.join(os.path.dirname(__file__))

def convertPath(path):
     sep = os.path.sep
     print('separator: ' + sep)
     return path.replace(os.path.sep, ';') 
 
directory_path_lisp = convertPath(directory_path)[1:]


sys.path.append(directory_path)
sys.path


import actr
import actcv as cv
import actms as ms
import NMsaveresults as sr
import NMdispatchercmds as cmd


# Load Dispatcher commands
cmd.load_actms_commands()

# create .csv with headers
sr.writeReHeaderCsv(directory_path)

# LOAD ACT-R MODELS
def loadmodels():
    actr.load_act_r_model(directory_path_lisp + ";EF-normativemodel.lisp")
    actr.load_act_r_model(directory_path_lisp + ";EF-submodel-normative.lisp")

    
loadmodels()


actr.set_current_model("normative-main")          



timesRun = 13

## ----- -----
# loop over all datasets
session = [2,3,4,5,7,9,10,13]
#session = [ 3]

for tr in range(timesRun):
    random.shuffle(session)

    print("-"*40 + "-----------------------------")
    print("-"*40 + '   Run: ' + str(tr) )
    print("-"*40 + "-----------------------------")
    print("-"*40 + '  List: ' + str(session) )
    print("-"*40 + "-----------------------------")

    for ses in session:
        print('Looping Participant: {0}'.format(ses))

        # LOOP AND SCHEDULE EVENT 4
        print('Looping Scenario: 2 | Event: 3')
        data = pd.read_csv(directory_path + '/Data/Session_{0}_scenario_2.csv'.format(ses),
                            sep = ';', dtype = {'ALTITUDE' : float, 'SPEED' : float, 'AOI' : object, 'AlarmActive' : float, 'AOIpT' : str})
       
        header = list(data)
        data = data.where((pd.notnull(data)), None)
               
        cv.setCVsettings()
        cv.schedule_Visicon(data, header, header[-2], header[1], header[0], 3000, 3, 0, 0, 0.01)
        
        ms.terminal_run_output()        
        actr.run_until_condition("end-program")

        ms.saveparticipant(ses)
        ms.savetimesRun(tr)
        ms.state_normative()
        sr.appendresultlist()
        sr.writeResultsCsv(directory_path)
        print("-"*32 + " Result saved " + "-"*32)         

        actr.reset()
        loadmodels()
        cmd.load_actms_commands()
        print("-"*32 + " Models Reloaded " + "-"*32)         

        ms.resetresultlist()

        # reload act-r
        actr.set_current_model("normative-main")
        actr.delete_all_visicon_features()

    print("-"*30 + " " + "-"*22 + " " + "-"*30)
    print("-"*32 + "   END SIMULATION   " + "-"*32)         
    print("-"*30 + " " + "-"*22 + " " + "-"*30)


