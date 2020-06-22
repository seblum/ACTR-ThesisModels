# -*- coding: utf-8 -*-
"""
Created on Wed Aug 28 08:24:27 2019

@author: s.blum@campus.tu-berlin.de
"""

import actr
import numpy as np

resultlist = [np.nan for x in range(1,24)]
utilitylist = list

def resetresultlist():
    global resultlist
    resultlist = [np.nan for x in range(1,24)]
    
def getlist():
    return resultlist

def saveparticipant(participant):
    global resultlist
    resultlist[0] = participant

def saveresult(result):
    global resultlist
    resultlist[8] = result
    resultlist[9] = actr.get_time()    

def saveanticipationresult(correct,value,ticktime,uppertime,lowertime):
    resultlist[17] = correct
    resultlist[18] = value
    resultlist[19] = uppertime
    resultlist[20] = ticktime
    resultlist[21] = lowertime
    resultlist[22] = actr.get_time()    


# normlist = [np.nan for x in range(1,25)]



'''
PRINTERS IN PYTHON
'''
def terminal_active_output():
    print("-"*29 + " " + str(actr.current_model()) + " is now ACTIVE" + "  " + "-"*29)
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

def state_hear_tone(input):
    print("-"*32 + " Tone heard " + "-"*32)
    resultlist[1] = actr.get_time()  

def state_submodel_correct(input,result):
    print("-"*29 + " Submodel CORRECT " + "-"*29)
    saveresult(result)
    
def state_submodel_not_correct(input):
    print("-"*29 + " Submodel not correct " + "-"*29)



'''
CALL TO RETURN ACTION SIMULATION RESULTS TO THE MAIN MODEL
''' 

def state_anticipation(input):
    resultlist[16] = input

def state_anticipation_correct(correct,value,ticktime,uppertime,lowertime):
    saveanticipationresult(correct,value,ticktime,uppertime,lowertime)
    print("-"*29 + " Anticipation correct " + "-"*29)
    print("-"*32 + "  Time: " + str(actr.get_time()) + "  " + "-"*32)
    print("-"*33 + "  " + str(lowertime) + " < " + str(ticktime) + " < " + str(uppertime) + "  " + "-"*32)

def state_anticipation_not_correct(correct,value,ticktime,uppertime,lowertime):
    saveanticipationresult(correct,value,ticktime,uppertime,lowertime)
    print("-"*29 + " Anticipation not correct " + "-"*29)
    print("-"*29 + "     Time: " + str(actr.get_time()) + "      " + "-"*29)



'''
CALL FOR SIMULATION OF FOCUS
All three models
'''
def simulate_focus_left(input):
    actr.set_current_model("left-model")
    terminal_active_output()
    actr.schedule_mod_buffer_chunk("goal",["state","simulate-left"],0)
    resultlist[2] = "left"
     
def simulate_focus_middle(input):
    actr.set_current_model("middle-model")
    terminal_active_output()
    actr.schedule_mod_buffer_chunk("goal",["state","simulate-middle"],0)
    resultlist[3] = "middle"
 
def simulate_focus_right(input):
    actr.set_current_model("right-model")
    terminal_active_output()
    actr.schedule_mod_buffer_chunk("goal",["state","simulate-right"],0)
    resultlist[4] = "right"
 
def simulate_focus_normative(input):
    actr.set_current_model("normative-model")
    terminal_active_output()
    actr.schedule_mod_buffer_chunk("goal",["state","simulate-right"],0)
    resultlist[4] = "right"


'''
CALL TO RETURN FOCUS SIMULATION RESULTS TO THE MAIN MODEL
''' 
def return_focus_left(input):
    actr.set_current_model("main-model")
    actr.schedule_mod_buffer_chunk("imaginal",["resultleft","\'" + input + "\'"],0)
    actr.schedule_mod_buffer_chunk("goal",["state","match-left"],0)
    terminal_return_output(input,"Focus returned")
    resultlist[5] = input
 
def return_focus_middle(input):
    actr.set_current_model("main-model")
    actr.schedule_mod_buffer_chunk("imaginal",["resultmiddle","\'" + input + "\'"],0)
    actr.schedule_mod_buffer_chunk("goal",["state","match-middle"],0)
    terminal_return_output(input,"Focus returned")
    resultlist[6] = input
 
def return_focus_right(input):
    actr.set_current_model("main-model")
    actr.schedule_mod_buffer_chunk("imaginal",["resultright","\'" + input + "\'"],0)
    actr.schedule_mod_buffer_chunk("goal",["state","match-right"],0)
    terminal_return_output(input,"Focus returned")
    resultlist[7] = input
      
              
 
'''
CALL FOR SIMULATION OF ACTION
Only one model
'''   
def simulate_action_left(input):
    actr.set_current_model("left-model")
    terminal_active_output()
    actr.schedule_mod_buffer_chunk("goal",["state","simulate-action"],0)
    resultlist[10] = "left"
 
def simulate_action_middle(input):
    actr.set_current_model("middle-model")
    terminal_active_output()
    actr.schedule_mod_buffer_chunk("goal",["state","simulate-action"],0)
    resultlist[11] = "middle"
 
def simulate_action_right(input):
    actr.set_current_model("right-model")
    terminal_active_output()
    actr.schedule_mod_buffer_chunk("goal",["state","simulate-action"],0)
    resultlist[12] = "right"
       
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
    resultlist[13] = input
 
def return_duration_middle(input):
    actr.set_current_model("main-model")
    actr.schedule_mod_buffer_chunk("imaginal",["resultactionmodel","\'" + input + "\'"],0)
    terminal_return_output(input,"Duration returned")
    resultlist[14] = input

def return_duration_right(input):
    actr.set_current_model("main-model")
    actr.schedule_mod_buffer_chunk("imaginal",["resultactionmodel","\'" + input + "\'"],0)
    terminal_return_output(input,"Duration returned")
    resultlist[15] = input
 
def return_duration_normative(input):
    actr.set_current_model("normative-main")
    actr.schedule_mod_buffer_chunk("imaginal",["resultactionmodel","\'" + input + "\'"],0)
    terminal_return_output(input,"Duration returned")
    resultlist[13] = input
    resultlist[14] = 0
    resultlist[15] = 0


              
'''
STATE THAT PROGRAM HAS ENDED
''' 
def end_program(input):
    if input == 1:
        return True

def schedule_end_run():
    actr.schedule_event(59.020,"end-program", [1], maintenance = True )    
    actr.schedule_event(59.110,"end-program", [1], maintenance = True )    
    actr.schedule_event(59.210,"end-program", [1], maintenance = True )    
    actr.schedule_event(59.220,"end-program", [1], maintenance = True )    
    actr.schedule_event(59.310,"end-program", [1], maintenance = True )    
    actr.schedule_event(59.245,"end-program", [1], maintenance = True )    
    actr.schedule_event(59.430,"end-program", [1], maintenance = True )    
    actr.schedule_event(59.050,"end-program", [1], maintenance = True )    
    actr.schedule_event(59.015,"end-program", [1], maintenance = True )    




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

    for idx,val in enumerate(utilitylist[0:14]):
            utilitylist[idx][1] = 0

    for idx,val in enumerate(utilitylist):
        actr.spp(val[0],':u',val[1])
    print("-"*32 + " Utility Reset " + "-"*32)         



