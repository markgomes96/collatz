#!/usr/bin/python
#Mark Gomes
#CSC 330
#Dr. Pounds
#Assignment 3 - Collatz Conjecture

import sys

num = 5000000000
n = 0
count = 0
mincount = 0 
# Create array
maxcounts = [[0 for j in range(2)] for i in range(10)]
temp = [[0 for j in range(2)] for i in range(10)]
temp2 = [[0 for j in range(2)] for i in range(10)]

def reccount(n):        #Recursion to find collatz sequence count
    if n == 1:
        return 0
    else:
        if n%2 == 0:
            return 1 + reccount(n/2)
        else:
            return 1 + reccount((n*3)+1)

# Zero array
for i in range(0,10):
    for j in range(0,2):
        maxcounts[i][j] = 0
        temp[i][j] = 0
        temp2[i][j] = 0

while num > 1:
    n = num
    count = reccount(n)              #Preforms the collatz algorithm with recursion
    
    #print " : Number: ", num, "    Steps: ", count
    if count > mincount:
        ind = -1
        diff = 0
        mincount = count
        for i in range(0,10):
            if maxcounts[i][0] < mincount:
                mincount = maxcounts[i][0]              #Stores the lowest count in the array
            if count - maxcounts[i][0] > diff:         #Keeps track of index that produces the largest difference between counts
                diff = count - maxcounts[i][0]
                ind = i        
        if ind != -1:
            maxcounts[ind][0] = count
            maxcounts[ind][1] = num
    num = num - 1
    count = 0

#Sorted by step length
print "***Array Sorted by Step Length***"
count = 0
ind = 0
num = 0

for j in range(0,10):
    for i in range(0,10):
        if maxcounts[i][0] >= count:
            count = maxcounts[i][0]
            num = maxcounts[i][1]
            ind = i
    temp[j][0] = count
    temp[j][1] = num
    maxcounts[ind][0] = 0
    maxcounts[ind][1] = 0
    count = 0
maxcounts = temp

for i in range(0,10):
    print " : Number: ", maxcounts[i][1], "    Steps: ", maxcounts[i][0]
        
#Sorted by number magnitude
print "***Array Sorted by Number Magnitude***"
count = 0
ind = 0
num = 0

for j in range(0,10):
    for i in range(0,10):
        if maxcounts[i][1] >= num:
            count = maxcounts[i][0]
            num = maxcounts[i][1]
            ind = i
    temp2[j][0] = count
    temp2[j][1] = num
    maxcounts[ind][0] = 0
    maxcounts[ind][1] = 0
    num = 0
maxcounts = temp2

for i in range(0,10):
    print " : Number: ", maxcounts[i][1], "    Steps: ", maxcounts[i][0]