 # -*- coding: utf-8 -*-
"""
Created on Thu Jul 25 11:22:00 2019

@author: seblum
"""

import pandas as pd
import numpy as np
import sys
import os
import random

import actr
import actcv as cv
import actms as ms
#import MMsaveresults as sr


# Get path of current directory and convert it to lisp
directory_path = os.path.join(os.path.dirname(__file__))

def convertPath(path):
     return path.replace(os.path.sep, ';') 
 
directory_path_lisp = convertPath(directory_path)[1:]


sys.path.append(directory_path)
sys.path

# LOAD ACT-R MODELS
def loadmodels():
    actr.load_act_r_model(directory_path_lisp + ";EF-metamodel.lisp")
    actr.load_act_r_model(directory_path_lisp + ";EF-submodel-left.lisp")
    actr.load_act_r_model(directory_path_lisp + ";EF-submodel-middle.lisp")
    actr.load_act_r_model(directory_path_lisp + ";EF-submodel-right.lisp")

loadmodels()


actr.set_current_model("main-model")          

actms = ms.ActMS("main-model",)


printer_total = pd.DataFrame() # wirklich dict?


timesRun = 1
session = [2,3,4,5,7,9,10,13]
#session = [5,7,13]
session = [5]


# loop over all datasets
for tr in range(timesRun):
    print("-"*20 + f' Run: {tr} ' )
    
    random.shuffle(session)
    for ses in session:
        print(f'Looping Participant: {ses} of list: {session}')

        # Looping Scenario: 2 | Event: 3
        data = pd.read_csv(directory_path + f'/Data/Session_{ses}_scenario_2.csv',
                            sep = ';', 
                            dtype = {'ALTITUDE' : float, 
                                    'SPEED' : float, 
                                    'AOI' : object, 
                                    'AlarmActive' : float, 
                                    'AOIpT' : str})
            
        data.columns = data.columns.str.replace('[', '').str.replace(']', '')
        head = list(data)
        #print(head)

        actcv = cv.ActCV(data, "TIME")         
        actcv.load_States()
        actcv.schedule_Visicon()
        actcv.schedule_Tone(freq = 3000, duration = 3)
        #sessionexit()
        actms.reset_model('main-model')
        actms.write_Protocol("Session", ses)
        actms.write_Protocol("timesRun", tr)

        #exit()

        actr.run_until_condition("quit-simulation", True)       

        printer_current_run = actms.get_Protocol()
        print(printer_current_run)
        printer_total = pd.concat([printer_total, printer_current_run])


        actms.save_utility()

        # reset and reload for new run
        actr.reset()

        loadmodels()

        actr.set_current_model("main-model")
        actr.delete_all_visicon_features()

        actms.set_utility()
        print("> models reloaded ")         


printer_total.to_csv('simulation_results.csv')

print('> end simulation ')

