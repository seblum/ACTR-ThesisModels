# -*- coding: utf-8 -*-
"""
2021-04-29

@author: seblum
"""

import pandas as pd
import numpy as np
import sys
import os
import random
import itertools

import actr
import actcv as cv
import actms as ms


# Get path of current directory and convert it to lisp
directory_path = os.path.join(os.path.dirname(__file__))
directory_path_lisp = directory_path.replace(os.path.sep, ";")[1:]
sys.path.append(directory_path)


# LOAD ACT-R MODELS
def loadmodels():
    actr.load_act_r_model(directory_path_lisp + ";EF-metamodel.lisp")
    actr.load_act_r_model(directory_path_lisp + ";EF-submodel-left.lisp")
    actr.load_act_r_model(directory_path_lisp + ";EF-submodel-middle.lisp")
    actr.load_act_r_model(directory_path_lisp + ";EF-submodel-right.lisp")


loadmodels()
actr.set_current_model("main-model")

# initialize ActMS
actms = ms.ActMS(
    "main-model",
)


printer_total = pd.DataFrame()

quit_timelist = [
    59.020,
    59.110,
    59.210,
    59.220,
    59.310,
    59.245,
    59.430,
    59.050,
    59.015,
    58.020,
    58.110,
    58.210,
    58.220,
    58.310,
    58.245,
    58.430,
    58.050,
    58.015,
]

sessionlist = [2, 3, 4, 5, 7, 9, 10, 13]
run_list = []
nr_per_pilot = 3

# shuffle and permutate
permutations_list = list(itertools.permutations(sessionlist))
# print(f"Total # permutations: {len(permutations_list)}")
random.shuffle(permutations_list)
permutations_subset = random.sample(permutations_list, 1000)
for i in sessionlist:
    i_list = list(filter(lambda x: x[-1] == i, permutations_subset))
    random.shuffle(i_list)
    for nr in range(nr_per_pilot):
        run_list.append(i_list.pop())
random.shuffle(run_list)
# print(f"Total # permutations to run: {len(run_list)}")
# print(f"Permutations to run: {run_list}")
# breakpoint()

# runs for non-UL-model:
run_list_2 = [
    (
        3,
        7,
        5,
        1,
        2,
        3,
        2,
        5,
        4,
        13,
        9,
        3,
        10,
        13,
        4,
        10,
        7,
        9,
        10,
        9,
        4,
        13,
        7,
        5,
        2,
        7,
        5,
        3,
        9,
        13,
        4,
        10,
        10,
        9,
        4,
        13,
        7,
        5,
        2,
        3,
    )
]
run_list = run_list_2
print(f"Permutations to run: {run_list}")

# loop over all datasets
for tr in range(len(run_list)):
    print("-" * 20 + f" Run: {tr} ")

    for index, ses in enumerate(run_list[tr]):
        print(f"Looping Participant: {ses} of list: {run_list[tr]}")
        plimit = len(run_list[tr]) - 1

        # Loading Scenario: 2 | Event: 3
        data = pd.read_csv(
            directory_path + f"/Data/Session_{ses}_scenario_2.csv",
            sep=";",
            dtype={
                "ALTITUDE": float,
                "SPEED": float,
                "AOI": str,
                "AlarmActive": float,
                "AOIpT": str,
            },
        )

        data = data.fillna("nanana")
        data.columns = data.columns.str.replace("[", "").str.replace("]", "")

        actcv = cv.ActCV(data, "TIME", "AOIpT")
        actcv.load_States()
        actcv.schedule_Visicon()
        actcv.schedule_Tone(freq=3000, duration=3)

        actms.reset_model("main-model")

        # if index == plimit:
        actms.write_Protocol("Run", tr)
        actms.write_Protocol("Session", ses)

        for time in quit_timelist:
            actcv.schedule_force_quit(time)

        breakpoint()
        actr.run_until_condition("quit-simulation", True)

        # if index == plimit:
        printer_current_run = actms.get_Protocol()
        print(printer_current_run)
        printer_total = pd.concat([printer_total, printer_current_run])

        # reset and reload for new run
        # actms.save_utility()
        actr.reset()
        loadmodels()

        actr.set_current_model("main-model")
        actr.delete_all_visicon_features()

        # if index != plimit:
        # actms.set_utility()
        print("> models reloaded ")

    printer_total.to_csv("simulation_results.csv")

print("> end simulation ")
