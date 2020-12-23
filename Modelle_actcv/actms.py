# -*- coding: utf-8 -*-
"""
Created on Wed Aug 28 08:24:27 2019

@author: THO1NR
"""

import actr
import numpy as np

resultlist = [np.nan for x in range(1,29)]
utilitylist = list
savelist = list
actiononecount = 0
actiontwocount = 0


def resetresultlist():
    global resultlist
    global actiononecount
    global actiontwocount

    resultlist = [np.nan for x in range(1,29)]
    actiononecount = 0
    actiontwocount = 0   

def getlist():
    return resultlist

def saveparticipant(participant):
    global resultlist
    resultlist[0] = participant

def savetimesRun(tr):
    global resultlist
    resultlist[25] = tr

def state_normative():
    global resultlist
    resultlist[2] = 'normative'


def saveresult(result):
    resultlist[5] = result
    resultlist[6] = str(actr.get_time())

def saveanticipationresult(correct,ticktime,uppertime,lowertime):
    resultlist[18] = actr.get_time()    
    resultlist[19] = lowertime
    resultlist[20] = ticktime
    resultlist[21] = uppertime
    resultlist[22] = correct

def saveanticipationresultfailed(correct,ticktime,uppertime,lowertime,action):
    if action == 0:
        resultlist[14] = 'failedFocus'
        resultlist[22] = 'failedFocus'  
    elif action == 1:
        resultlist[10] = str(actr.get_time())
        resultlist[11] = lowertime
        resultlist[12] = ticktime
        resultlist[13] = uppertime
        resultlist[14] = correct
        resultlist[22] = correct
    elif action == 2:
        resultlist[18] = actr.get_time()    
        resultlist[19] = lowertime
        resultlist[20] = ticktime
        resultlist[21] = uppertime
        resultlist[22] = correct

    # normlist = [np.nan for x in range(1,25)]


'''
PRINTERS IN PYTHON
'''
def terminal_active_output():
    print("-"*30 + " " + str(actr.current_model()) + " is now ACTIVE" )
def terminal_return_output(input,step):
    print(" "*30 + " " + str(step) + ": " + str(input) )
def terminal_run_output():
    print("-"*30 + " " + "-"*22 + " " + "-"*30)
    print("-"*30 + " Meta Model has STARTED " + "-"*30)
    print("-"*30 + " " + "-"*22 + " " + "-"*30)
    

'''
PRINTERS IN ACT-R
'''
def state_initialized(input):
    terminal_active_output()
    print(" "*30 + " Initialized   ")
    print(" "*30 + " Monitoring... ")
    global actiononecount
    global actiontwocount
    resultlist[23] = actiononecount
    resultlist[24] = actiontwocount


def state_hear_tone(input):
    print("-"*30 + " Tone heard " + " "*13 + "-"*29)
    print(" "*29 + "> Simulate focus...")
    resultlist[1] = actr.get_time()  

def state_submodel_correct(input,result):
    print(" "*30 + " Submodel CORRECT ")
    print(" "*29 + "> Simulate action-1...")
    saveresult(result)
    
def state_submodel_not_correct(input):
    print(" "*30 + " Submodel not correct ")

def print_ticktime(ticks):
    print(" "*30 + " Ticks: " + str(ticks))

def print_keepinmind(ticks):
    print(" "*30 + " KeepInMind: " + str(ticks))

def save_keepinmind(ticks,nr):
    if nr == 1:
        resultlist[26] = ticks
    elif nr == 2:
        resultlist[27] = ticks
def runtime_failure(ticks):
    print(" "*30 + " Failed to simulate within limit... ")

def action_count(action,num,ticks,uppertime,lowertime):
    global actiononecount
    global actiontwocount
    if(action == 1):
        actiononecount += num
        print(" "*30 + " " + str(lowertime) + " < " + str(ticks) + " < " + str(uppertime) )
        print(" "*30 + " Below limit | try action-1 again...")
    elif(action == 2):
        actiontwocount += num
        print(" "*30 + " " + str(lowertime) + " < " + str(ticks) + " < " + str(uppertime) )
        print(" "*30 + " Below limit | try action-2 again...")
    else:
        pass

'''
CALL TO RETURN ACTION SIMULATION RESULTS TO THE MAIN MODEL
''' 

def state_anticipation(input):
    pass#resultlist[17] = input

def state_anticipation_correct(correct,ticktime,uppertime,lowertime):
    saveanticipationresult(correct,ticktime,uppertime,lowertime)
    print("-"*30 + " Anticipation correct | successful action-2 " + "-"*3)
    print(" "*30 + " Time: " + str(actr.get_time()) )
    print(" "*30 + " " + str(lowertime) + " < " + str(ticktime) + " < " + str(uppertime) )
    print(" "*30 + " Monitoring... ")
    resultlist[23] = actiononecount
    resultlist[24] = actiontwocount


def state_anticipation_not_correct(correct,ticktime,uppertime,lowertime,action):
    global actiononecount
    global actiontwocount

    if correct == "failed-2":
        resultlist[23] = actiononecount
        resultlist[24] = actiontwocount
        if (lowertime == 0 and ticktime == 0 and uppertime == 0):
            saveanticipationresultfailed(correct,ticktime,uppertime,lowertime,action)
            print("-"*30 + " Anticipation not correct | failed FOCUS    " + "-"*7)
            print(" "*30 + " Time: " + str(actr.get_time()) )
        else:
            saveanticipationresultfailed(correct,ticktime,uppertime,lowertime,action)
            print("-"*30 + " Anticipation not correct | failed action-2 " + "-"*7)
            print(" "*30 + " Time: " + str(actr.get_time()) )
            print(" "*30 + " " + str(lowertime) + " < " + str(ticktime) + " < " + str(uppertime) )
            print(" "*30 + " Monitoring... ")
    elif correct == "failed-1":
        saveanticipationresultfailed(correct,ticktime,uppertime,lowertime,action)
        print("-"*30 + " Anticipation not correct | failed action-1 " + "-"*7)
        print(" "*30 + " Time: " + str(actr.get_time()) )
        print(" "*30 + " " + str(lowertime) + " < " + str(ticktime) + " < " + str(uppertime) )
        print(" "*29 + "> Simulate action-2...")



'''
CALL FOR SIMULATION BY ACT-R
'''
def simulate_submodel(model,action):
    if action == 0:
        if model == "left":
            simulate_focus_left()
        elif model == "middle":
            simulate_focus_middle()
        elif model == "right":
            simulate_focus_right()
    elif action == 1:
        if model == "left":
            simulate_action_one_left()
        elif model == "middle":
            simulate_action_one_middle()
        elif model == "right":
            simulate_action_one_right()
        elif model == "normative":
            simulate_action_one_normative()
    elif action == 2:
        if model == "left":
            simulate_action_two_left()
        elif model == "middle":
            simulate_action_two_middle()
        elif model == "right":
            simulate_action_two_right()
        elif model == "normative":
            simulate_action_two_normative()


'''
CALL FOR SIMULATION OF FOCUS
'''
def simulate_focus_left():
    actr.set_current_model("left-model")
    terminal_active_output()
    actr.schedule_mod_buffer_chunk("goal",["state","simulate","action",0],0)
     
def simulate_focus_middle():
    actr.set_current_model("middle-model")
    terminal_active_output()
    actr.schedule_mod_buffer_chunk("goal",["state","simulate","action",0],0)
 
def simulate_focus_right():
    actr.set_current_model("right-model")
    terminal_active_output()
    actr.schedule_mod_buffer_chunk("goal",["state","simulate","action",0],0)


 
'''
CALL FOR SIMULATION OF ACTION-1
'''   
def simulate_action_one_left():
    actr.set_current_model("left-model")
    terminal_active_output()
    actr.schedule_mod_buffer_chunk("goal",["state","simulate","action",1],0)
 
def simulate_action_one_middle():
    actr.set_current_model("middle-model")
    terminal_active_output()
    actr.schedule_mod_buffer_chunk("goal",["state","simulate","action",1],0)
 
def simulate_action_one_right():
    actr.set_current_model("right-model")
    terminal_active_output()
    actr.schedule_mod_buffer_chunk("goal",["state","simulate","action",1],0)
       
def simulate_action_one_normative():
    actr.set_current_model("submodel-normative")
    terminal_active_output()
    actr.schedule_mod_buffer_chunk("goal",["state","simulate","action",1],0)


'''
CALL FOR SIMULATION OF ACTION-2
'''   
def simulate_action_two_left():
    actr.set_current_model("left-model")
    terminal_active_output()
    actr.schedule_mod_buffer_chunk("goal",["state","simulate","action",2],0)
 
def simulate_action_two_middle():
    actr.set_current_model("middle-model")
    terminal_active_output()
    actr.schedule_mod_buffer_chunk("goal",["state","simulate","action",2],0)
 
def simulate_action_two_right():
    actr.set_current_model("right-model")
    terminal_active_output()
    actr.schedule_mod_buffer_chunk("goal",["state","simulate","action",2],0)
       
def simulate_action_two_normative():
    actr.set_current_model("submodel-normative")
    terminal_active_output()
    actr.schedule_mod_buffer_chunk("goal",["state","simulate","action",2],0)



'''
CALL TO RETURN FOCUS SIMULATION RESULTS TO THE MAIN MODEL
''' 
def return_focus_left(input):
    actr.set_current_model("main-model")
    actr.schedule_mod_buffer_chunk("imaginal",["resultfocus","\'" + input + "\'"],0)
    actr.schedule_mod_buffer_chunk("goal",["state","match-focus"],0)
    resultlist[2] = input
    terminal_return_output(input,"Focus returned")
 
def return_focus_middle(input):
    actr.set_current_model("main-model")
    actr.schedule_mod_buffer_chunk("imaginal",["resultfocus","\'" + input + "\'"],0)
    actr.schedule_mod_buffer_chunk("goal",["state","match-focus"],0)
    resultlist[3] = input
    terminal_return_output(input,"Focus returned")
 
def return_focus_right(input):
    actr.set_current_model("main-model")
    actr.schedule_mod_buffer_chunk("imaginal",["resultfocus","\'" + input + "\'"],0)
    actr.schedule_mod_buffer_chunk("goal",["state","match-focus"],0)
    resultlist[4] = input
    terminal_return_output(input,"Focus returned")


'''
CALL TO RETURN ACTION-ONE SIMULATION RESULTS TO THE MAIN MODEL
''' 
def return_action_one_left(input):
    actr.set_current_model("main-model")
    actr.schedule_mod_buffer_chunk("goal",["state","retrieve-action"],0)
    actr.schedule_mod_buffer_chunk("imaginal",["resultactionone","\'" + input + "\'"],0)
    resultlist[7] = input
    terminal_return_output(input,"Duration returned")
 
def return_action_one_middle(input):
    actr.set_current_model("main-model")
    actr.schedule_mod_buffer_chunk("goal",["state","retrieve-action"],0)
    actr.schedule_mod_buffer_chunk("imaginal",["resultactionone","\'" + input + "\'"],0)
    resultlist[8] = input
    terminal_return_output(input,"Duration returned")

def return_action_one_right(input):
    actr.set_current_model("main-model")
    actr.schedule_mod_buffer_chunk("goal",["state","retrieve-action"],0)
    actr.schedule_mod_buffer_chunk("imaginal",["resultactionone","\'" + input + "\'"],0)
    resultlist[9] = input
    terminal_return_output(input,"Duration returned")
 
def return_action_one_normative(input):
    actr.set_current_model("normative-main")
    actr.schedule_mod_buffer_chunk("goal",["state","retrieve-action"],0)
    actr.schedule_mod_buffer_chunk("imaginal",["resultactionone","\'" + input + "\'"],0)
    resultlist[9] = input
    terminal_return_output(input,"Duration returned")

def action_one_correct(ticks,lowertime,uppertime):
    resultlist[10] = str(actr.get_time())
    resultlist[11] = lowertime
    resultlist[12] = ticks
    resultlist[13] = uppertime
    resultlist[14] = "successful-1"
    resultlist[23] = actiononecount
    actr.schedule_mod_buffer_chunk("goal",["keepinmind", 0],0)
    print(" "*30 + " " + str(lowertime) + " < " + str(ticks) + " < " + str(uppertime) )
    print(" "*30 + " action-1 correct")
    print(" "*29 + "> Simulate action-2...")


'''
CALL TO RETURN ACTION-TWO SIMULATION RESULTS TO THE MAIN MODEL
''' 
def return_action_two_left(input):
    actr.set_current_model("main-model")
    actr.schedule_mod_buffer_chunk("goal",["state","retrieve-action"],0)
    actr.schedule_mod_buffer_chunk("imaginal",["resultactiontwo","\'" + input + "\'"],0)
    resultlist[15] = input
    terminal_return_output(input,"Duration returned")
 
def return_action_two_middle(input):
    actr.set_current_model("main-model")
    actr.schedule_mod_buffer_chunk("goal",["state","retrieve-action"],0)
    actr.schedule_mod_buffer_chunk("imaginal",["resultactiontwo","\'" + input + "\'"],0)
    resultlist[16] = input
    terminal_return_output(input,"Duration returned")

def return_action_two_right(input):
    actr.set_current_model("main-model")
    actr.schedule_mod_buffer_chunk("goal",["state","retrieve-action"],0)
    actr.schedule_mod_buffer_chunk("imaginal",["resultactiontwo","\'" + input + "\'"],0)
    resultlist[17] = input
    terminal_return_output(input,"Duration returned")
 
def return_action_two_normative(input):
    actr.set_current_model("normative-main")
    actr.schedule_mod_buffer_chunk("goal",["state","retrieve-action"],0)
    actr.schedule_mod_buffer_chunk("imaginal",["resultactiontwo","\'" + input + "\'"],0)
    resultlist[17] = input
    terminal_return_output(input,"Duration returned")

def action_two_correct(ticks,lowertime,uppertime):
    print(" "*30 + " " + str(lowertime) + " < " + str(ticks) + " < " + str(uppertime) )
    print(" "*30 + " action-2 correct")
    print(" "*30 + " Monitoring... ")




              
'''
STATE THAT PROGRAM HAS ENDED
''' 
def end_program(input):
    if input == 1:
        return True

def end_scenario():
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

def saveutility():
    global savelist
    savelist = utilitylist

def getutility():
    global utilitylist
    utilitylist = actr.spp([':name', ':u'])

def setutility():
    global utilitylist

    for idx,val in enumerate(utilitylist[0:14]):
            utilitylist[idx][1] = 0

    for idx,val in enumerate(utilitylist):
        actr.spp(val[0],':u',val[1])
    print("-"*30 + " Utility Reset   " + "-"*30)         

def setsaveutility():
    global savelist
    for idx,val in enumerate(savelist[0:14]):
            savelist[idx][1] = 0

    for idx,val in enumerate(savelist):
        actr.spp(val[0],':u',val[1])
    print("-"*30 + " Utility Reset   " + "-"*30)       
