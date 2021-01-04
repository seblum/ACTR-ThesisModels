# -*- coding: utf-8 -*-
"""
Created on Thu Jul 25 11:22:00 2019

@author: s.blum@campus.tu-berlin.de
"""

import pandas as pd
import sys
import os

import actr
import actcv as cv
import actms as ms
import NMsaveresults as sr
import NMdispatchercmds as cmd


# Get path of current directory and convert it to lisp
directory_path = os.path.join(os.path.dirname(__file__))

def convertPath(path):
     sep = os.path.sep
     print('separator: ' + sep)
     return path.replace(os.path.sep, ';') 
 
directory_path_lisp = convertPath(directory_path)[1:]


sys.path.append(directory_path)
sys.path


# Load Dispatcher commands
cmd.load_actms_commands()
cmd.load_actcv_commands()

# create .csv with headers
sr.writeReHeaderCsv(directory_path)

# LOAD ACT-R MODELS
def loadmodels():
    actr.load_act_r_model(directory_path_lisp + ";WS-normativemodel.lisp")
    actr.load_act_r_model(directory_path_lisp + ";WS-submodel-normative.lisp")

# load ACT-R models and set main model to current    
loadmodels()
actr.set_current_model("normative-main")          



## ----- -----
# loop over all datasets

session = [3]
  
for ses in session:
    print('Looping Participant: {0}'.format(ses))

    cv.resetstatelist()
    cv.resetindex()
    cv.resettimeoffset()

    # LOOP AND SCHEDULE EVENT 4
    print('Looping Scenario: 2 | Event: 4')
    data = pd.read_csv(directory_path + '/Data/session_{0}_sce_2.csv'.format(ses),
                        sep = ';', dtype = {'ALTITUDE' : float, 'SPEED' : float, 'AOI' : object, 'AlarmActive' : float, 'Action' : float})

    cv.actCVLoop(data,0,0)

    addindex = cv.getindex()
    addtime = cv.gettimeoffset()
    
    # LOOP AND SCHEDULE EVENT 10
    print('Looping Scenario: 2 | Event: 10')
    data_2 = pd.read_csv(directory_path + '/Data/session_{0}_sce_4.csv'.format(ses),
                        sep = ';', dtype = {'ALTITUDE' : float, 'SPEED' : float, 'AOI' : object, 'AlarmActive' : float, 'Action' : float})

    cv.actCVLoop(data_2,addtime,addindex)

    ms.terminal_run_output()      

    # set goal state to start and scenario to 2       
    actr.schedule_event(0,"set-goal-state", maintenance = True )

    ms.schedule_start_sce()
    ms.schedule_end_sce()

    actr.run_until_condition("end-program",True)

    # SAVE RESULTS
    ms.saveparticipant(ses)
    sr.appendresultlist()
    sr.writeResultsCsv(directory_path)
    print("-"*32 + " Result saved " + "-"*30)         

    
    actr.reset()
    loadmodels()
    cmd.load_actms_commands()
    cmd.load_actcv_commands()
    print("-"*32 + " Models Reloaded " + "-"*32)         

    ms.resetresultlist()

    # reload act-r
    actr.set_current_model("normative-main")
    actr.delete_all_visicon_features()

print("-"*30 + " " + "-"*22 + " " + "-"*30)
print("-"*32 + "   END SIMULATION   " + "-"*32)         
print("-"*30 + " " + "-"*22 + " " + "-"*30)



