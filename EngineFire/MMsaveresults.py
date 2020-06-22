# -*- coding: utf-8 -*-
"""
Created on Wed Sep 11 14:00:02 2019

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
    with open(path +'/Results/Results_Engine_Fire.csv', "a", newline="") as f:
        writer = csv.writer(f)
        writer.writerow(resultlist)

def writeReHeaderCsv(path):
    header = ['Participant','Time.alert', \
              'L.run','M.run','R.run', \
              'L.focus','M.focus','R.focus', \
              'Result','Time.focus.result', \
              'L.action','M.action','R.action', \
              'L.duration','M.duration','R.duration', \
              'state.anticipation','correct','value.thrustlever', \
              'uppertime','ticktime','lowertime','Time.action.result']
    with open(path +'/Results/Results_Engine_Fire.csv', "w", newline="") as f:
        writer = csv.writer(f)
        writer.writerow(header)
