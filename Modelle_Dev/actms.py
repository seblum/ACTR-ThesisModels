# -*- coding: utf-8 -*-
"""
Created on Wed Aug 28 08:24:27 2019

@author: Sebastian Blum
"""

from . import actr
import numpy as np
import pandas as pd



class ActMSProtocol:

	def __init__(self):
		self.dict = {}

	def writeToProtocol(self, name, variable):
	    self.dict.update( { name : variable } )

	def getProtocol(self):
	    return pd.DataFrame([self.dict])

	def deleteProtocol(self):
	    self.dict.clear()




class ActMS:

	def __init__(self, modelname):
		self.name = modelname
		actr.add_command("simulate-submodel", self.simulate_submodel, "back to main function")
		actr.add_command("return-from-submodel", self.return_from_submodel, "back to main function")
		actr.add_command("end-program", self.end_program,"returns that model is finished")
	   
	def simulate_submodel(self, model, action):
	    actr.set_current_model(model)
	    actr.schedule_mod_buffer_chunk("goal",["state", "simulate", "action", action],0) # simulate dynamic
	    writeToProtocol( "action-" + str(action), "simulate-" + str(model))

	def return_from_submodel(self, input, action, goalstatevar, imaginalslot):
	    actr.set_current_model(self.name)
	    actr.schedule_mod_buffer_chunk("goal", ["state", goalstatevar], 0)
	    actr.schedule_mod_buffer_chunk("imaginal", [imaginalslot, "\'" + input + "\'"], 0)
	    writeToProtocol(f"forwardto-{self.name}-{action}", input)

	def end_program(self, input):
	    if input == 1:
	        return True



class ActMSUtility:
	'''
	UTILITY LEARNING OVER MODELS
	''' 
	def __init__(self):
		self.initial_utility = list()
		self.new_utility = self.getutility()

	def getutility(self):
	    #self.new_utility
	    return actr.spp([':name', ':u'])

	def model_start(self):
		self.initial_utility = self.new_utility

	def model_end(self):
		# get new utility
		self.new_utility = self.getutility()
		# save new utility
		for idx, val in enumerate(self.new_utility[0:14]):
			self.new_utility[idx][1] = 0
			
		for idx, val in enumerate(self.new_utility):
			actr.spp(val[0],':u',val[1])
			print("-"*30 + " Utility Reset ")


'''
	def reset_utility(self):
	    self.new_utility = list()

	def save_utility(self):
	    self.initial_utility = self.new_utility

	def set_new_utility(self):
	    for idx,val in enumerate(self.new_utility[0:14]):
	            self.new_utility[idx][1] = 0

	    for idx,val in enumerate(self.new_utility):
	        actr.spp(val[0],':u',val[1])
	    	print("-"*30 + " Utility Reset ")         

	def set_initial_utility():
	    for idx,val in enumerate(self.initial_utility[0:14]):
	            self.initial_utility[idx][1] = 0

	    for idx,val in enumerate(self.initial_utility):
	        actr.spp(val[0],':u',val[1])
	    	print("-"*30 + " Utility Reset ")       
'''
