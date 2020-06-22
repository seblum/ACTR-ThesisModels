# -*- coding: utf-8 -*-
"""
Created on Wed Sep 11 14:00:02 2019

@author: THO1NR
"""

import actr
import actms
import actcv

'''
ACT-MS COMMANDS
'''
def load_actms_commands():    
    actr.add_command("state-initialized", actms.state_initialized, "back to main function")
    actr.add_command("state-hear-tone", actms.state_hear_tone, "back to main function")
    actr.add_command("state-submodel-correct", actms.state_submodel_correct, "back to main function")
    actr.add_command("state-submodel-not-correct", actms.state_submodel_not_correct, "back to main function")
    
    actr.add_command("simulate-submodel",actms.simulate_submodel, "back to main function")

    actr.add_command("simulate-action-one-normative",actms.simulate_action_one_normative, "back to main function")
    actr.add_command("simulate-action-two-normative",actms.simulate_action_two_normative, "back to main function")

    actr.add_command("return-action-one-normative",actms.return_action_one_normative, "back to main function")   
    actr.add_command("return-action-two-normative",actms.return_action_two_normative, "back to main function")

    actr.add_command("state-anticipation",actms.state_anticipation, "feedback results to python")
    actr.add_command("state-anticipation-correct",actms.state_anticipation_correct, "feedback results to python")
    actr.add_command("state-anticipation-not-correct",actms.state_anticipation_not_correct, "feedback results to python")

    actr.add_command("action-one-correct",actms.action_one_correct, "back to main function")

    # FINISHED COMMAND TO RUN THE MODEL
    actr.add_command("end-program",actms.end_program,"returns that model is finished")

    
'''
ACT-CV COMMANDS
'''
def load_actcv_commands():
    actr.add_command("current-to-visicon",actcv.current_to_visicon,"puts the current line to the visicon")
    actr.add_command("initialize-visicon",actcv.initialize_visicon,"puts the current line to the visicon")
