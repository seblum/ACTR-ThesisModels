# -*- coding: utf-8 -*-
"""
Created on Wed Aug 28 10:22:41 2019

@author: Sebastian Blum
"""
import actr
import pandas as pd
import numpy as np
from tqdm.auto import tqdm
import time



class ActCV():

    def __init__(self, data, timecolumnname, indexinput = 0, timebreak = 0.01):
        self.timecolumnname = timecolumnname
        self.starttime = 0
        self.index = indexinput
        self.timebreak = timebreak
        self.offsetdict, self.statedict, self.tonelist = {}, {}, []
        try:
	        self.data = self.convert_data_frame(data)
        except:
            print(f"Not able to load {data}")
        actr.add_command("commit-to-visicon", self.commit_to_visicon, "load one row in the visicon")



    def convert_data_frame(self, dataframe):
        # check thath self.timecolumnname is in header
        # try - catch
        df = dataframe.replace(np.nan, 0, regex=True)
        return df



    def tuple_to_dict(self, namedtuple):
        tupleasdict = namedtuple._asdict()
        del tupleasdict["Index"]
        return tupleasdict



    def commit_to_visicon(self, index):
        state = self.tuple_to_dict(self.statedict[index])
        actr.delete_all_visicon_features()        
        for head, value in state.items(): # enumerate durch tuple
            value = np.float64(value)
            actr.add_visicon_features(['isa', 'visual-location', 
                                       'value', value,
                                       'color', head,
                                       'screen-x', 0, 
                                       'screen-y', 0, 
                                       'width', 50, 
                                       'height', 15])



    def set_states(self):
        # this needs to be dynamically adjustable later on
        timecolumnname_index = 1
        alarmnumbercolumn = 1
        alarmactivecolumn = -1

        # save parameters
        offsetdict = {}
        statedict = {}
        tonelist = []
        time_start = self.data[self.timecolumnname][0]
        time_last_current = time_start

        # set states
        index = 0 # using the index makes it slow
        for startstate_tuple in self.data.iloc[0].to_frame().transpose().itertuples():
            offsetdict[startstate_tuple.Index] = startstate_tuple.TIME
            statedict[startstate_tuple.Index] = startstate_tuple
            previousstate_tuple = startstate_tuple

        for currentstate_tuple in self.data.itertuples():
            time_current = currentstate_tuple[timecolumnname_index]
            time_offset = ( time_current - time_start ) + self.starttime
            time_difference = time_current - time_last_current

            if time_difference > self.timebreak:          
                time_last_current = time_current                
                current_alarmstate = currentstate_tuple.AUD_FwsNumber
                previous_alarmstate = previousstate_tuple.AUD_FwsNumber

                statedict[index] = currentstate_tuple
                offsetdict[index] = time_offset
                index += 1
                if previous_alarmstate != current_alarmstate and previous_alarmstate == 0.0:
                    tonelist.append(time_offset)
                previous_alarmstate = current_alarmstate
        return offsetdict, statedict, tonelist



    def schedule_States(self):
        t0 = time.time()
        self.offsetdict, self.statedict, self.tonelist = self.set_states(self.timecolumnname)
        print(f"schedule states  took: { round(time.time()-t0, 5) } seconds")



    def schedule_Visicon(self):
        t0 = time.time()
        for key in self.offsetdict:  
            timepoint = key
            actr.schedule_event(timepoint, "commit-to-visicon", params = [key], maintenance = True ) # this impedes runtime
        print(f"schedule visicon took: { round(time.time()-t0, 5) } seconds")



    def schedule_Tone(self, freq, duration):            
        t0 = time.time()
        for key in self.tonelist:
            actr.new_tone_sound(freq, duration, key) # this impedes runtime
            #print(key)
        print(f"schedule tone    took: { round(time.time()-t0, 5) } seconds")

