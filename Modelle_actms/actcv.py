# -*- coding: utf-8 -*-
"""
Created on Wed Aug 28 10:22:41 2019

@author: Sebastian Blum
"""
import actr
import pandas as pd
from tqdm.auto import tqdm

class ActCV():

    def __init__(self, data, head, indexinput = 0):
        self.header =  list()
        self.statelist = list()
        self.state_start = list()
        self.time_offset = 0
        self.header = head
        self.index = indexinput
        try:
	        self.data = data
        except:
            print(f"Not able to load {data}")
        actr.add_command("commit-to-visicon", self.commit_to_visicon, "load the current line in the visicon")
       # actr.add_command("initialize-visicon", initialize_visicon, "run initialize the visicon")

    ''' DELETE '''
    def initialize_visicon(self):
        #for index, test_case in enumerate(test_cases):
        #    print index, test_case.ident
        for headiter in self.header:
             head_name = headiter
             value = (self.state_start[headiter])
             actr.add_visicon_features(['isa', 'visual-location', 
                                        'value', value,
                                        'color', head_name,
                                        'screen-x', 0, 
                                        'screen-y', 0, 
                                        'width', 50, 
                                        'height', 15])        


    def commit_to_visicon(self, indices, statelist):
        state_current = statelist[indices]
        actr.delete_all_visicon_features()        
        for index, headname in enumerate(self.header):
            value = state_current[index]
            actr.add_visicon_features(['isa', 'visual-location', 
                                       'value', value,
                                       'color', headname,
                                       'screen-x', 0, 
                                       'screen-y', 0, 
                                       'width', 50, 
                                       'height', 15])

    # readin with header
    '''
        fucking slow in class
    '''
    def schedule_Visicon(self, alarmactivecolumn, alarmnumbercolumn, timecolumnname, freq, duration, starttime = 0, timebreak = 0.01):            
        print(" Start scheduling ")         
        
        # set start time    
        time_start = self.data[timecolumnname][0]
        time_last_current = time_start

        # set states
        self.state_start = self.data.iloc[0] # the iloc seems critical
        state_previous = self.state_start
        self.statelist.append(state_previous.values.tolist())
        self.index += 1
        #actr.schedule_event(starttime, "initialize-visicon", maintenance = True )     

        actr.schedule_event(starttime, "commit-to-visicon", params = [0, self.statelist], maintenance = True )     

        for state_iter in tqdm(self.data.index):
            #print(state_iter)
            time_current = self.data[timecolumnname][state_iter]
            self.time_offset = time_current - time_start
            self.time_offset = self.time_offset + starttime
            time_difference = time_current - time_last_current

            if time_difference > timebreak:          
                time_last_current = time_current
                state_current = self.data.iloc[state_iter]
                previous_value = state_previous[alarmnumbercolumn]
                current_value = state_current[alarmnumbercolumn]
                alarm_active = state_current[alarmactivecolumn]
                
                self.statelist.append(state_current.values.tolist())
                actr.schedule_event(self.time_offset, "commit-to-visicon", params = [self.index, self.statelist], maintenance = True )     
                self.index += 1

                ### ----- ----- ----- PROCEDURE ALERT ----- ----- -----
                if previous_value != current_value and previous_value == 0.0 and alarm_active == 1.0:
                    actr.new_tone_sound(freq, duration, self.time_offset) # input these variables
                    print(f" Tone scheduled at {self.time_offset}")     
                    
                state_previous = state_current               

        print(" Scheduling successful ")         

'''
I probably do not need this anymore
def init_actcv():    
    global index
    global time_offset
    
    index = 0
    time_offset = 0
    statelist.clear()
    actr.add_command("current-to-visicon", current_to_visicon, "connection to put the current line in the visicon")
    actr.add_command("initialize-visicon", initialize_visicon, "connection to run initialize the visicon")
'''
'''

    def getstatelist(self):
        return self.statelist

    def getindex(self):
        return self.index

    def gettimeoffset(self):
        return self.time_offset

'''

    

