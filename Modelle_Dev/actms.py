# -*- coding: utf-8 -*-
"""
2020-12-24

@author: seblum
"""

import actr
import numpy as np
import pandas as pd

'''ToDo
- check printers
- check utility learning # seems to work
- add number of runs and more information to printer.
- insert docstrings
'''

# can only be called after current model is set
class ActMS:

	def __init__(self, modelname):
		self.name = modelname
		self.dict = {}
		self.initial_utility = self.get_utility()
		self.new_utility = []

		actr.add_command("simulate-submodel", self.simulate_submodel, "back to main function")
		actr.add_command("return-from-submodel", self.return_from_submodel, "back to main function")
		actr.add_command("quit-simulation", self.quit_simulation,"returns that model is finished")
	
	
	def write_Protocol(self, name, variable):
	    self.dict.update( { name : variable } )


	def get_Protocol(self):
	    return pd.DataFrame([self.dict])


	def simulate_submodel(self, model, action):
	    actr.set_current_model(model)
	    actr.schedule_mod_buffer_chunk("goal",["state", "simulate", "action", action],0) # simulate dynamic
	    self.write_Protocol(f"action-{action}", f"simulate-{model}")


	def return_from_submodel(self, input, action, goalstatevar, imaginalslot):
	    actr.set_current_model(self.name)
	    actr.schedule_mod_buffer_chunk("goal", ["state", goalstatevar], 0)
	    actr.schedule_mod_buffer_chunk("imaginal", [imaginalslot, "\'" + input + "\'"], 0)
	    self.write_Protocol(f"forward-to-{self.name}-{action}", input)


	def quit_simulation(self, input):
	    if input == 1:
	        return True


	def reset_model(self, modelname):
		self.name = modelname
		self.dict = {}


	def reset_utility(self):
		self.initial_utility = []


	def get_utility(self):
	    return actr.spp([':name', ':u'])


	def save_utility(self):
		# get new utility
		self.new_utility = self.get_utility()
		#self.initial_utility = self.new_utility

		# save new utility
		for idx, val in enumerate(self.new_utility[0:14]):
			self.new_utility[idx][1] = 0


	def set_utility(self):
		for idx, val in enumerate(self.new_utility):
			actr.spp(val[0],':u',val[1])
		print("> utility reset ")


