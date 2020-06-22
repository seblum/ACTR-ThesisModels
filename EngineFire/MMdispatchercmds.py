# -*- coding: utf-8 -*-
"""
Created on Wed Sep 11 14:00:02 2019

@author: s.blum@campus.tu-berlin.de
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
    
    actr.add_command("simulate-focus-left",actms.simulate_focus_left, "back to main function")
    actr.add_command("simulate-focus-middle",actms.simulate_focus_middle, "back to main function")
    actr.add_command("simulate-focus-right",actms.simulate_focus_right, "back to main function")
    
    actr.add_command("simulate-action-left",actms.simulate_action_left, "back to main function")
    actr.add_command("simulate-action-middle",actms.simulate_action_middle, "back to main function")
    actr.add_command("simulate-action-right",actms.simulate_action_right, "back to main function")
  #  actr.add_command("simulate-action-normative",actms.simulate_action_normative, "back to main function")
    
    actr.add_command("return-focus-left",actms.return_focus_left, "back to main function")
    actr.add_command("return-focus-middle",actms.return_focus_middle, "back to main function")
    actr.add_command("return-focus-right",actms.return_focus_right, "back to main function")
    
    actr.add_command("return-duration-left",actms.return_duration_left, "back to main function")
    actr.add_command("return-duration-middle",actms.return_duration_middle, "back to main function")
    actr.add_command("return-duration-right",actms.return_duration_right, "back to main function")
  #  actr.add_command("return-duration-normative",actms.return_duration_normative, "back to main function")
    
    actr.add_command("state-anticipation",actms.state_anticipation, "feedback results to python")
    actr.add_command("state-anticipation-correct",actms.state_anticipation_correct, "feedback results to python")
    actr.add_command("state-anticipation-not-correct",actms.state_anticipation_not_correct, "feedback results to python")

    # FINISHED COMMAND TO RUN THE MODEL
    actr.add_command("end-program",actms.end_program,"returns that model is finished")
    
'''
ACT-CV COMMANDS
'''
def load_actcv_commands():
    actr.add_command("current-to-visicon",actcv.current_to_visicon,"puts the current line to the visicon")
    actr.add_command("initialize-visicon",actcv.initialize_visicon,"puts the current line to the visicon")
