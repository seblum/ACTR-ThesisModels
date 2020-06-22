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
    
    actr.add_command("simulate-focus-left",actms.simulate_focus_left, "back to main function")
    actr.add_command("simulate-focus-middle",actms.simulate_focus_middle, "back to main function")
    actr.add_command("simulate-focus-right",actms.simulate_focus_right, "back to main function")
    
    actr.add_command("simulate-action-one-left",actms.simulate_action_one_left, "back to main function")
    actr.add_command("simulate-action-one-middle",actms.simulate_action_one_middle, "back to main function")
    actr.add_command("simulate-action-one-right",actms.simulate_action_one_right, "back to main function")
  #  actr.add_command("simulate-action-normative",actms.simulate_action_normative, "back to main function")
 
    actr.add_command("simulate-action-two-left",actms.simulate_action_two_left, "back to main function")
    actr.add_command("simulate-action-two-middle",actms.simulate_action_two_middle, "back to main function")
    actr.add_command("simulate-action-two-right",actms.simulate_action_two_right, "back to main function")

    actr.add_command("return-focus-left",actms.return_focus_left, "back to main function")
    actr.add_command("return-focus-middle",actms.return_focus_middle, "back to main function")
    actr.add_command("return-focus-right",actms.return_focus_right, "back to main function")
    
    actr.add_command("return-action-one-left",actms.return_action_one_left, "back to main function")
    actr.add_command("return-action-one-middle",actms.return_action_one_middle, "back to main function")
    actr.add_command("return-action-one-right",actms.return_action_one_right, "back to main function")
  #  actr.add_command("return-duration-normative",actms.return_duration_normative, "back to main function")
    
    actr.add_command("return-action-two-left",actms.return_action_two_left, "back to main function")
    actr.add_command("return-action-two-middle",actms.return_action_two_middle, "back to main function")
    actr.add_command("return-action-two-right",actms.return_action_two_right, "back to main function")

    actr.add_command("state-anticipation",actms.state_anticipation, "feedback results to python")
    actr.add_command("state-anticipation-correct",actms.state_anticipation_correct, "feedback results to python")
    actr.add_command("state-anticipation-not-correct",actms.state_anticipation_not_correct, "feedback results to python")

    actr.add_command("action-one-correct",actms.action_one_correct, "back to main function")
    actr.add_command("action-two-correct",actms.action_two_correct, "back to main function")
    actr.add_command("action-count",actms.action_count, "counts actions")
    actr.add_command("print-ticktime",actms.print_ticktime, "counts actions")

    actr.add_command("print-keepinmind",actms.print_keepinmind, "counts actions")
    actr.add_command("save-keepinmind",actms.save_keepinmind, "counts actions")
    actr.add_command("runtime_failure",actms.runtime_failure, "counts actions")

    # FINISHED COMMAND TO RUN THE MODEL
    actr.add_command("end-program",actms.end_program,"returns that model is finished")
    
'''
ACT-CV COMMANDS
'''
def load_actcv_commands():
    actr.add_command("current-to-visicon",actcv.current_to_visicon,"puts the current line to the visicon")
    actr.add_command("initialize-visicon",actcv.initialize_visicon,"puts the current line to the visicon")
