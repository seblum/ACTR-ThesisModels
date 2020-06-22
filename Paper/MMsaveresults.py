
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
              'L.focus','M.focus','R.focus','correct.focus','Time.focus', \
              'L.action.1','M.action.1','R.action.1','Time.action.1','lowertime.action.1','ticktime.action.1','uppertime.action.1', \
              'correct.1', \
              'L.action.2','M.action.2','R.action.2','Time.action.2','lowertime.action.2','ticktime.action.2','uppertime.action.2', \
              'correct.2',"failed.action.1","failed.action.2","Runtime","real.ticks.1","real.ticks.2"]
    with open(path +'/Results/Results_Engine_Fire.csv', "w", newline="") as f:
        writer = csv.writer(f)
        writer.writerow(header)
