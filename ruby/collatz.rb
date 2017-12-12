#!/usr/bin/ruby
#Mark Gomes
#CSC 330
#Dr. Pounds
#Assignment 3 - Collatz Conjecture

num = 5000000000
n = 0
count = 0
mincount = 0 
maxcounts = Array.new(10){Array.new(2)}

def updatearray (count, num, maxcounts, mincount)
  ind = -1
  diff = 0
  mincount = count
  
  i = 0
  while i < 10  do
      if maxcounts[i][1] < mincount
          mincount = maxcounts[i][1]              #Stores the lowest count in the array
      end
      if count - maxcounts[i][1] > diff         #Keeps track of index that produces the largest difference between counts
          diff = count - maxcounts[i][1]
          ind = i
      end
      i += 1
  end
  if ind != -1
      maxcounts[ind][0] = num
      maxcounts[ind][1] = count
  end
end

def arraysort(maxcounts, mode)
    count = 0
    ind = 0
    num = 0
    maxval = 0
    temp = Array.new(10){Array.new(2)}

    i = 0                #Zero out the array
    while i < 10 do
        temp[i][0] = 0
        temp[i][1] = 0
        i += 1
    end

    j = 0
    while j < 10 do
        i = 0
        while i < 10 do
            if maxcounts[i][mode] >= maxval
                maxval = maxcounts[i][mode]
                count = maxcounts[i][1]
                num = maxcounts[i][0]
                ind = i
            end
            i += 1
        end
        temp[j][1] = count
        temp[j][0] = num
        maxcounts[ind][0] = 0
        maxcounts[ind][1] = 0
        maxval = 0
        j += 1
    end
    i = 0                #Zero out the array
    while i < 10 do
        maxcounts[i][0] = temp[i][0]
        maxcounts[i][1] = temp[i][1]
        i += 1
    end
end

i = 0                #Zero out the array
while i < 10 do
    maxcounts[i][0] = 0
    maxcounts[i][1] = 1
    i += 1
end

until num == 1
    n = num
    until n == 1              #Preforms the collatz algorithm
        if n%2 == 0
            n = n/2
        else
            n = (n*3)+1
        end
        count = count + 1 
    end
    #puts "Number: #{num}    Steps: #{count}"
    if count > mincount
        updatearray count, num, maxcounts, mincount
    end
    num = num - 1
    count = 0
end

arraysort maxcounts, 1                            #Sort array by step length
puts "***Array Sorted by Step Length***"
i = 0                #Display the array
while i < 10 do
    puts "Number:  #{maxcounts[i][0]}    Steps:  #{maxcounts[i][1]}"
    i += 1
end

arraysort maxcounts, 0                            #Sort array by number magnitude
puts "***Array Sorted by Number Magnitude***"
i = 0                #Display the array
while i < 10 do
    puts "Number:  #{maxcounts[i][0]}    Steps:  #{maxcounts[i][1]}"
    i += 1
end