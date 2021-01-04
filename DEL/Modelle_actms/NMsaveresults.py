
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
    with open(path +'/Results/Results_Engine_Fire_normative.csv', "a", newline="") as f:
        writer = csv.writer(f)
        writer.writerow(resultlist)

def writeReHeaderCsv(path):
    header = ['Participant','Time.alert', \
              'NaN','NaN','NaN','NaN','NaN', \
              'NaN','NaN','N.action.1','Time.action.1','lowertime.action.1','ticktime.action.1','uppertime.action.1', \
              'correct.1', \
              'NaN','NaN','N.action.2','Time.action.2','lowertime.action.2','ticktime.action.2','uppertime.action.2', \
              'correct.2',"failed.action.1","failed.action.2","Runtime"]
    with open(path +'/Results/Results_Engine_Fire_normative.csv', "w", newline="") as f:
        writer = csv.writer(f)
        writer.writerow(header)
