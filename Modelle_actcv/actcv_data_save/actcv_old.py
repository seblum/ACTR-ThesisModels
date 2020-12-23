# -*- coding: utf-8 -*-
"""
Created on Wed Aug 28 10:22:41 2019

@author: Sebastian Blum
"""
import actr
import pandas as pd


header =  []
statelist = []
state_start = pd.Series
time_offset = 0
index  = 0



def initialize_visicon():
    global header
    global state_start
    for headiter in header:
         head_name = headiter
         value = (state_start[headiter])
         actr.add_visicon_features(['isa', 'visual-location', 
                                    'value', value,
                                    'color', head_name,
                                    'screen-x', 0, 
                                    'screen-y', 0, 
                                    'width', 50, 
                                    'height', 15])        


def current_to_visicon(index):
    global header
    global statelist
    state_current = statelist[index]
    actr.delete_all_visicon_features()
    
    for headiter in header:
        head_name = headiter
        value = state_current[headiter]
        actr.add_visicon_features(['isa', 'visual-location', 
                           'value', value,
                           'color', head_name,
                           'screen-x', 0, 
                           'screen-y', 0, 
                           'width', 50, 
                           'height', 15])


# readin with header
def schedule_Visicon(data, head, alarmactivecolumn, alarmnumbercolumn, timecolumnname, freq, duration, starttime = 0, indexinput = 0, timebreak = 0.01):    
    global index
    global time_offset
    global header
    global state_start
    global statelist
    
    print("-"*30 + " Start scheduling ")         
    
    index = indexinput
    tmp = data
    header = head

    # this should be done before
#    tmp.dtypes
 #   tmp = tmp.where((pd.notnull(tmp)), None)
  #  tmp.iloc[:,0:-3] = tmp.iloc[:,0:-3].astype('float')
    
    # set start time    
    time_start = tmp[timecolumnname][0]
    time_last_current = time_start

    # set states
    state_start = tmp.iloc[0] # the iloc seems critical
    state_previous = state_start

        
    actr.schedule_event(starttime, "initialize-visicon", maintenance = True )     

    for state_iter in tmp.index:
        time_current = tmp[timecolumnname][state_iter]
        time_offset = time_current - time_start
        time_offset = time_offset + starttime
        time_difference = time_current - time_last_current

        if time_difference > timebreak:          
            time_last_current = time_current
            state_current = tmp.iloc[state_iter]
            previous_value = state_previous[alarmnumbercolumn]
            current_value = state_current[alarmnumbercolumn]
            alarm_active = state_current[alarmactivecolumn]
            
            statelist.append(state_current)
            #savestate(state_current)

            actr.schedule_event(time_offset, "current-to-visicon", params = [index], maintenance = True )     
            index += 1

            ### ----- ----- ----- PROCEDURE ALERT ----- ----- -----
            if previous_value != current_value and previous_value == 0.0 and alarm_active == 1.0:
                actr.new_tone_sound(freq, duration, time_offset) # input these variables
                print("-"*30 + " Tone scheduled ")     
                
            state_previous = state_current               

    print("-"*30 + " Scheduling successful ")         


def setCVsettings():    
    global index
    global time_offset
    
    index = 0
    time_offset = 0
    statelist.clear()
    actr.add_command("current-to-visicon", current_to_visicon, "connection to put the current line in the visicon")
    actr.add_command("initialize-visicon", initialize_visicon, "connection to run initialize the visicon")

    
def getstatelist():
    return statelist

def getindex():
    return index

def gettimeoffset():
    return time_offset


    

