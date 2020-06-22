# -*- coding: utf-8 -*-
"""
Created on Wed Sep 11 14:00:02 2019

@author: s.blum@campus.tu-berlin.de
"""

import actr
import actms as ms
import actcv as cv

'''
ACT-MS COMMANDS
'''
def load_actms_commands():    
    actr.add_command("state-initialized", ms.state_initialized, "back to main function")
    actr.add_command("state-hear-tone", ms.state_hear_tone, "back to main function")
    actr.add_command("state-submodel-correct", ms.state_submodel_correct, "back to main function")
    actr.add_command("state-submodel-not-correct", ms.state_submodel_not_correct, "back to main function")
    
    actr.add_command("simulate-focus-left",ms.simulate_focus_left, "back to main function")
    actr.add_command("simulate-focus-right",ms.simulate_focus_right, "back to main function")
    
    actr.add_command("simulate-action-left",ms.simulate_action_left, "back to main function")
    actr.add_command("simulate-action-right",ms.simulate_action_right, "back to main function")
  #  actr.add_command("simulate-action-normative",actms.simulate_action_normative, "back to main function")
    
    actr.add_command("return-focus-left",ms.return_focus_left, "back to main function")
    actr.add_command("return-focus-right",ms.return_focus_right, "back to main function")
    
    actr.add_command("return-duration-left",ms.return_duration_left, "back to main function")
    actr.add_command("return-duration-right",ms.return_duration_right, "back to main function")
  #  actr.add_command("return-duration-normative",actms.return_duration_normative, "back to main function")
    
    actr.add_command("state-anticipation",ms.state_anticipation, "feedback results to python")
    actr.add_command("state-anticipation-correct",ms.state_anticipation_correct, "feedback results to python")
    actr.add_command("state-anticipation-not-correct",ms.state_anticipation_not_correct, "feedback results to python")

    # FINISHED COMMAND TO RUN THE MODEL
    actr.add_command("end-program",ms.end_program,"returns that model is finished")

    actr.add_command("set-goal-state",ms.set_goal_state,"returns that model is finished")
    actr.add_command("set-goal-state-renew",ms.set_goal_state_renew,"returns that model is finished")
    actr.add_command("set-goal-state-end-run",ms.set_goal_state_end_run,"returns that model is finished")
    actr.add_command("end-scenario",ms.end_scenario,"returns that model is finished")
    actr.add_command("start-scenario",ms.start_scenario,"returns that model is finished")
    
    
'''
ACT-CV COMMANDS
'''
def load_actcv_commands():
    actr.add_command("current-to-visicon",cv.current_to_visicon,"puts the current line to the visicon")
    actr.add_command("initialize-visicon",cv.initialize_visicon,"puts the current line to the visicon")
