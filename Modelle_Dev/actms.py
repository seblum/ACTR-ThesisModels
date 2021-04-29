# -*- coding: utf-8 -*-
"""
2021-04-29

@author: seblum
"""

import actr
import numpy as np
import pandas as pd

"""ToDo
- check utility learning # seems to work
- insert docstrings

"""

# can only be called after current model is set
class ActMS:
    def __init__(self, modelname):
        self.name = modelname
        self.dict = {}
        self.initial_utility = self.get_utility()
        self.new_utility = []
        self.count = 0

        actr.add_command(
            "simulate-submodel", self.simulate_submodel, "back to main function"
        )
        actr.add_command(
            "return-from-submodel",
            self.return_from_submodel,
            "back to main function",
        )
        actr.add_command("write-protocol", self.write_Protocol, "writes result to dict")
        actr.add_command(
            "write-counter",
            self.write_Counter,
            "sets a counter and writes it to the protocol dict",
        )
        actr.add_command(
            "write-actrtime",
            self.write_ActrTime,
            "writes the current actr time to dict",
        )

    def write_Protocol(self, name, variable):
        if name == "actrtime":
            self.dict.update({f"{name}.{variable}": str(actr.get_time())})
        else:
            self.dict.update({name: variable})

    def write_Counter(self, name, variable):
        self.count += variable
        self.dict.update({name: (self.dict.get(name, 0) + variable)})

    def write_ActrTime(self, name):
        self.dict.update({name: str(actr.get_time())})

    def get_Protocol(self):
        return pd.DataFrame([self.dict])

    def simulate_submodel(self, model, action):
        actr.set_current_model(model)
        actr.schedule_mod_buffer_chunk(
            "goal", ["state", "simulate", "action", action], 0
        )

    def return_from_submodel(self, input, action, goalstatevar, imaginalslot):
        actr.set_current_model(self.name)
        actr.schedule_mod_buffer_chunk("goal", ["state", goalstatevar], 0)
        actr.schedule_mod_buffer_chunk("imaginal", [imaginalslot, "'" + input + "'"], 0)

    def reset_model(self, modelname):
        self.name = modelname
        self.dict = {}

    def reset_utility(self):
        self.initial_utility = []

    def get_utility(self):
        return actr.spp([":name", ":u"])

    def save_utility(self):
        # get new utility
        self.new_utility = self.get_utility()
        # self.initial_utility = self.new_utility

        # save new utility
        for idx, val in enumerate(self.new_utility[0:14]):
            self.new_utility[idx][1] = 0

    def set_utility(self):
        for idx, val in enumerate(self.new_utility):
            actr.spp(val[0], ":u", val[1])
        print("> utility reset ")
