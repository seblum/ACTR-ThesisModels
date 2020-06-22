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
import MMsaveresults as sr
import MMdispatchercmds as cmd


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
    actr.load_act_r_model(directory_path_lisp + ";EF-metamodel.lisp")
    actr.load_act_r_model(directory_path_lisp + ";EF-submodel-left.lisp")
    actr.load_act_r_model(directory_path_lisp + ";EF-submodel-middle.lisp")
    actr.load_act_r_model(directory_path_lisp + ";EF-submodel-right.lisp")


loadmodels()
actr.set_current_model("main-model")          


## ----- -----
# loop over all datasets
session = [2,3,4,5,7,9,10,13]

for ses in session:
    print('Looping Participant: {0}'.format(ses))

    cv.resetstatelist()
    cv.resetindex()
    cv.resettimeoffset()

    # LOOP AND SCHEDULE EVENT 4
    print('Looping Scenario: 2 | Event: 3')
    data = pd.read_csv(directory_path + '/Data/Session_{0}_scenario_2.csv'.format(ses),
                        sep = ';', dtype = {'ALTITUDE' : float, 'SPEED' : float, 'AOI' : object, 'AlarmActive' : float, 'AOIpT' : str})
       
    cv.actCVLoop(data,0,0)         

    ms.schedule_end_run()

    ms.terminal_run_output()        
    actr.run_until_condition("end-program", True)
    
    ms.saveparticipant(ses)
    sr.appendresultlist()
    sr.writeResultsCsv(directory_path)
    print("-"*32 + " Result saved " + "-"*32)         
  
    ms.resetutility()
    ms.getutility()
    
    actr.reset()
    loadmodels()
    cmd.load_actms_commands()
    cmd.load_actcv_commands()
    print("-"*32 + " Models Reloaded " + "-"*32)         

    ms.setutility()
        
    ms.resetresultlist()

    # reload act-r
    actr.set_current_model("main-model")
    actr.delete_all_visicon_features()

print("-"*30 + " " + "-"*22 + " " + "-"*30)
print("-"*32 + "   END SIMULATION   " + "-"*32)         
print("-"*30 + " " + "-"*22 + " " + "-"*30)


