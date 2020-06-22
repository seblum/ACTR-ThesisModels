# -*- coding: utf-8 -*-
"""
Created on Wed Aug 28 08:24:27 2019

@author: s.blum@campus.tu-berlin.de
"""

import actr
import numpy as np

resultlist = [np.nan for x in range(1,20)]
utilitylist = list

def resetresultlist():
    global resultlist
    resultlist = [np.nan for x in range(1,20)]
    
def getlist():
    return resultlist

def saveparticipant(participant):
    global resultlist
    resultlist[0] = participant

def saveresult(result,ticktime):
    global resultlist
    resultlist[6] = result
    resultlist[7] = actr.get_time()    
    resultlist[16] = ticktime

def saveanticipationresult(correct,b4,b10,a4,a10):
    global resultlist
    resultlist[13] = correct
    resultlist[14] = b4
    resultlist[15] = b10
    resultlist[16] = actr.get_time()    
    resultlist[17] = a4    
    resultlist[18] = a10    


# normlist = [np.nan for x in range(1,25)]



'''
PRINTERS IN PYTHON
'''
def terminal_active_output():
    print("-"*29 + " " + str(actr.current_model()) + " is now ACTIVE" + "  " + "-"*20)
def terminal_return_output(input,step):
    print("-"*29 + " " + str(step) + ": " + str(input) + "  " + "-"*29)
def terminal_run_output():
    print("-"*30 + " " + "-"*22 + " " + "-"*30)
    print("-"*30 + " Meta Model has STARTED " + "-"*30)
    print("-"*30 + " " + "-"*22 + " " + "-"*30)
    

'''
PRINTERS IN ACT-R
'''
def state_initialized(input):
    terminal_active_output()
    print("-"*29 + "    Initialized   " + "-"*29)
    print("-"*29 + " CSPM has control " + "-"*29)

def state_hear_tone(input,scenario):
    print("-"*32 + " Tone heard " + "-"*32)
    if scenario == 2:
        resultlist[1] = actr.get_time()  
    elif scenario == 4:
        resultlist[12] = actr.get_time()

def state_submodel_correct(input,result,ticktime):
    print("-"*29 + " Submodel CORRECT " + "-"*29)
    saveresult(result,ticktime)
    
def state_submodel_not_correct(input):
    print("-"*29 + " Submodel not correct " + "-"*29)



'''
CALL TO RETURN ACTION SIMULATION RESULTS TO THE MAIN MODEL
''' 

def state_anticipation(input):
    resultlist[16] = input
    print("-"*29 + " Anticipating: " + str(input) + " " + "-"*30)

def state_anticipation_correct(correct,b4,b10,a4,a10):
    saveanticipationresult(correct,b4,b10,a4,a10)
    print("-"*29 + " Anticipation correct " + "-"*20)
    print("-"*29 + "  Time: " + str(actr.get_time()) + "  " + "-"*29)
    print("-"*29 + "  Behavior 4: " + str(b4) + "  " + "-"*30)
    print("-"*29 + "  Behavior 10: " + str(b10) + "  " + "-"*29)

def state_anticipation_not_correct(correct,b4,b10,a4,a10):
    saveanticipationresult(correct,b4,b10,a4,a10)
    print("-"*29 + " Anticipation not correct " + "-"*21)
    print("-"*29 + "  Time: " + str(actr.get_time()) + "  " + "-"*32)
    print("-"*29 + "  Behavior 4: " + str(b4) + "  " + "-"*30)
    print("-"*29 + "  Behavior 10: " + str(b10) + "  " + "-"*29)



'''
CALL FOR SIMULATION OF FOCUS
All three models
'''
def simulate_focus_left(input):
    actr.set_current_model("left-model")
    terminal_active_output()
    actr.schedule_mod_buffer_chunk("goal",["state","simulate-left"],0)
    resultlist[2] = "left"
     
def simulate_focus_right(input):
    actr.set_current_model("right-model")
    terminal_active_output()
    actr.schedule_mod_buffer_chunk("goal",["state","simulate-right"],0)
    resultlist[3] = "right"
 


'''
CALL TO RETURN FOCUS SIMULATION RESULTS TO THE MAIN MODEL
''' 
def return_focus_left(input):
    actr.set_current_model("main-model")
    actr.schedule_mod_buffer_chunk("imaginal",["resultleft","\'" + input + "\'"],0)
    actr.schedule_mod_buffer_chunk("goal",["state","match-left"],0)
    terminal_return_output(input,"Focus returned")
    resultlist[4] = input
 
def return_focus_right(input):
    actr.set_current_model("main-model")
    actr.schedule_mod_buffer_chunk("imaginal",["resultright","\'" + input + "\'"],0)
    actr.schedule_mod_buffer_chunk("goal",["state","match-right"],0)
    terminal_return_output(input,"Focus returned")
    resultlist[5] = input
      
              
 
'''
CALL FOR SIMULATION OF ACTION
Only one model
'''   
def simulate_action_left(input):
    actr.set_current_model("left-model")
    terminal_active_output()
    actr.schedule_mod_buffer_chunk("goal",["state","simulate-action"],0)
    resultlist[8] = "left"

def simulate_action_right(input):
    actr.set_current_model("right-model")
    terminal_active_output()
    actr.schedule_mod_buffer_chunk("goal",["state","simulate-action"],0)
    resultlist[9] = "right"
       
def simulate_action_normative(input):
    actr.set_current_model("submodel-normative")
    terminal_active_output()
    actr.schedule_mod_buffer_chunk("goal",["state","simulate-normative"],0)
    resultlist[10] = 'normative'
    resultlist[2] = 0
    resultlist[3] = 0
    resultlist[4] = 0
    resultlist[5] = 0
    resultlist[6] = 0
    resultlist[7] = 0
    resultlist[11] = 0
    resultlist[12] = 0


'''
CALL TO RETURN ACTION SIMULATION RESULTS TO THE MAIN MODEL
''' 
def return_duration_left(input):
    actr.set_current_model("main-model")
    actr.schedule_mod_buffer_chunk("imaginal",["resultactionmodel","\'" + input + "\'"],0)
    terminal_return_output(input,"Duration returned")
    resultlist[10] = input
 
def return_duration_right(input):
    actr.set_current_model("main-model")
    actr.schedule_mod_buffer_chunk("imaginal",["resultactionmodel","\'" + input + "\'"],0)
    terminal_return_output(input,"Duration returned")
    resultlist[11] = input

def return_duration_normative(input):
    actr.set_current_model("normative-main")
    actr.schedule_mod_buffer_chunk("imaginal",["resultactionmodel","\'" + input + "\'"],0)
    terminal_return_output(input,"Duration returned")
    resultlist[11] = input
    resultlist[14] = 0
    resultlist[15] = 0


              
'''
STATE THAT PROGRAM HAS ENDED
''' 
def end_program(input):
    if input == "yes":
        print("-"*29 + " End current run " + "-"*29)
        return True 
    else:
        1

def schedule_start_sce():
    actr.schedule_event(59.020,"set-goal-state-renew", maintenance = True )    
    actr.schedule_event(59.110,"set-goal-state-renew", maintenance = True )    
    actr.schedule_event(59.210,"set-goal-state-renew", maintenance = True )    
    actr.schedule_event(59.220,"set-goal-state-renew", maintenance = True )   

def schedule_end_sce():
    actr.schedule_event(119.040,"set-goal-state-end-run", maintenance = True )    
    actr.schedule_event(119.125,"set-goal-state-end-run", maintenance = True )    
    actr.schedule_event(119.240,"set-goal-state-end-run", maintenance = True )    
    actr.schedule_event(119.330,"set-goal-state-end-run", maintenance = True ) 
    
    

'''
WINDSHEAR EXTRAS
''' 
def set_goal_state():
    actr.schedule_mod_buffer_chunk("goal",["state","start","scenario",2],0)

def set_goal_state_renew():
    actr.schedule_mod_buffer_chunk("goal",["state","newscenario","scenario",4],0)

def set_goal_state_end_run():
    actr.schedule_mod_buffer_chunk("goal",["state","endprogram","scenario","end"],0)

def end_scenario(input):
    print("-"*29 + " End Scenario 2 " + "-"*29)

def start_scenario(input):
    print("-"*29 + " Start Scenario 4 " + "-"*29)



'''
UTILITY LEARNING OVER MODELS
''' 
def resetutility():
    global utilitylist
    utilitylist = list

def getutility():
    global utilitylist
    utilitylist = actr.spp([':name', ':u'])

def setutility():
    global utilitylist
    for idx,val in enumerate(utilitylist):
        actr.spp(val[0],':u',val[1])
    print("-"*32 + " Utility Reset " + "-"*32)         


