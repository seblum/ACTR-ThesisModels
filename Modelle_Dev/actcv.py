# -*- coding: utf-8 -*-
"""
2020-12-23

@author: seblum
"""

import actr
import pandas as pd
import numpy as np
import time

'''ToDo
- instert variable column names
- insert data load check
- insert docstrings
'''


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
        #    tmp = tmp.where((pd.notnull(tmp)), None)

        # Column names are not allowed to have brackets as using itertuples
        # data.columns = data.columns.str.replace('[', '').str.replace(']', '')
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
        for head, value in state.items(): 
            if isinstance(value, (int, float)):
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
        index = 0 # using the index makes it slow(er)
        for startstate_tuple in self.data.iloc[0].to_frame().transpose().itertuples():
            offsetdict[index] = startstate_tuple.TIME
            statedict[index] = startstate_tuple
            previousstate_tuple = startstate_tuple

        for currentstate_tuple in self.data.itertuples():
            time_current = currentstate_tuple[timecolumnname_index]
            time_offset = ( time_current - time_start ) + self.starttime
            time_difference = time_current - time_last_current

            if time_difference > self.timebreak:          
                time_last_current = time_current                
                current_alarmstate = currentstate_tuple.AUD_FwsNumber # set dynamical to number
                previous_alarmstate = previousstate_tuple.AUD_FwsNumber

                statedict[index] = currentstate_tuple
                offsetdict[index] = time_offset
                index += 1
                if previous_alarmstate != current_alarmstate and previous_alarmstate == 0.0 and currentstate_tuple.AlarmActive == 1.0:
                    tonelist.append(time_offset)

                previousstate_tuple = currentstate_tuple
        return offsetdict, statedict, tonelist



    def load_States(self):
        t0 = time.time()
        self.offsetdict, self.statedict, self.tonelist = self.set_states()
        print(f"load states took: { round(time.time()-t0, 5) } seconds")



    def schedule_Visicon(self):
        t0 = time.time()
        for key, value in self.offsetdict.items():  
            timepoint = value
            actr.schedule_event(timepoint, "commit-to-visicon", params = [key], maintenance = True ) # this impedes runtime
        print(f"schedule visicon took: { round(time.time()-t0, 5) } seconds")



    def schedule_Tone(self, freq, duration):            
        t0 = time.time()
        for key in self.tonelist:
            actr.new_tone_sound(freq, duration, key) # this impedes runtime
        print(f"schedule tone took: { round(time.time()-t0, 5) } seconds")

