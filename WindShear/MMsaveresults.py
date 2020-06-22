# -*- coding: utf-8 -*-
"""
Created on Wed Sep 11 12:29:26 2019

@author: s.blum@campus.tu-berlin.de
"""

import actms
import csv

resultlist = []


'''
SAVE DATA TO A CSV FILE
'''

def appendresultlist():
    global resultlist
    resultlist = actms.getlist()

def writeResultsCsv(path):
    global resultlist
    with open(path + '/Results/Results_Wind_Shear.csv', "a", newline="") as f:
        writer = csv.writer(f)
        writer.writerow(resultlist)

def writeReHeaderCsv(path):
    header = ['Participant','Time.alert.4', \
              'L.run','R.run', \
              'L.action_4','R.action_4', \
              'Result','Time.action_4', \
              'L.model','R.model', \
              'L.action_10','R.action_10','Time.alert.10', \
              'correct','Behavior_4','Behavior_10', \
              'Time.action_10','Ticktime.4','Ticktime.10']
    with open(path + '/Results/Results_Wind_Shear.csv', "w", newline="") as f:
        writer = csv.writer(f)
        writer.writerow(header)