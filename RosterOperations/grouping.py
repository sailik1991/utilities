#!/usr/bin/python

import sys
import random

def shuffleList(nameList):
	''' Utility function for suffles a list multiple times'''
	NumOfShuffles = random.randint(1, MAX_SHUFFLE)
	for i in range(NumOfShuffles):
		random.shuffle(nameList)

def printGroups(namelist, groupSize):
	'''Utility function for printing out the groups'''
	i = 0
	for name in nameList:
		if i % groupSize == 0:
			print '----------'
			print ("Group %d" % (i/groupSize))
			print '----------'
		i+=1
		print name

''' Actual code that parses command line inputs and generates groups'''
MAX_SHUFFLE = 5

if not (len(sys.argv) == 3):
	print "Incorrect format. Please use python grouping.py <RoosterFile> <GroupSize>"
	exit()

fileName = sys.argv[1]
groupSize = int(sys.argv[2])
names = open(fileName, 'r')
nameList = []

for name in names:
	nameList.append(name)

shuffleList(nameList)
printGroups(nameList, groupSize)