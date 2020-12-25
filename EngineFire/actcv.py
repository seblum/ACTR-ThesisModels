# -*- coding: utf-8 -*-
"""
Created on Wed Aug 28 10:22:41 2019

@author: s.blum@campus.tu-berlin.de
"""

import actr
import pandas as pd

header =  []
statelist = []
state_start = pd.Series
time_offset = 0
index  = 0

def returnstatelist():
    return statelist

def getindex():
    return index

def gettimeoffset():
    return time_offset

def resetstatelist():
    statelist.clear()

def resetindex():
    global index
    index = 0
    
def resettimeoffset():
    global time_offset
    time_offset = 0

def savestate(input):
    statelist.append(input)

def saveheader(input):
    global header
    header = input

def savestart(state):
    global state_start
    state_start = state


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
        if head_name == 'AOIpT': # needs to be extra to create a string
            try:
                actr.add_visicon_features(['isa', 'visual-location', 
                                           'value', "\'" + value + "\'",
                                           'color', head_name,
                                           'screen-x', 0, 
                                           'screen-y', 0, 
                                           'width', 50, 
                                           'height', 15])
            except:
                   actr.add_visicon_features(['isa', 'visual-location', 
                                           'value', "NAN",
                                           'color', head_name,
                                           'screen-x', 0, 
                                           'screen-y', 0, 
                                           'width', 50, 
                                           'height', 15])
        else:
            actr.add_visicon_features(['isa', 'visual-location', 
                               'value', value,
                               'color', head_name,
                               'screen-x', 0, 
                               'screen-y', 0, 
                               'width', 50, 
                               'height', 15])

         
    
def actCVLoop(data,starttime = 0,indexinput = 0):    
    global index
    global time_offset
    
    global header
    global state_start
    global statelist
    
    print("-"*32 + " Start scheduling " + "-"*30)         
    
    index = indexinput
    tmp = data

    # get the header names
    header = list(tmp)
    
    # reset index
   # saveheader(header)      

    tmp.dtypes
    tmp = tmp.where((pd.notnull(tmp)), None)
    tmp.iloc[:,0:-3] = tmp.iloc[:,0:-3].astype('float')
    
    # set start time    
    time_start = tmp['TIME'][0]
    time_last_current = time_start

    # set states
    state_start = tmp.iloc[0]
    state_previous = state_start

    
    # savestart(state_start)
    
    actr.schedule_event(starttime,"initialize-visicon",maintenance=True )     

    for state_iter in tmp.index:
        time_current = tmp['TIME'][state_iter]
        time_offset = time_current - time_start
        time_offset = time_offset + starttime
        time_difference = time_current - time_last_current

        if time_difference > 0.01:          
            time_last_current = time_current
            state_current = tmp.iloc[state_iter]
            previous_value = state_previous[header[1]]
            current_value = state_current[header[1]]
            alarm_active = state_current[header[-2]]
            
            statelist.append(state_current)
            #savestate(state_current)
            print(time_offset)
            actr.schedule_event(time_offset,"current-to-visicon",params = [index],maintenance=True )     
            index += 1
            #print(state_current[header[-1]])
            #print(current_value)
            #print(time_current)
            ### ----- ----- ----- PROCEDURE ALERT ----- ----- -----
            if previous_value != current_value and previous_value == 0.0 and alarm_active == 1.0:
                actr.new_tone_sound(3000, 3, time_offset)
                print("-"*32 + " Tone scheduled " + "-"*32)     
                #print(time_current)
                
            state_previous = state_current               
    print("-"*32 + " Scheduling successfull" + "-"*25)         
    exit()
    
    
    