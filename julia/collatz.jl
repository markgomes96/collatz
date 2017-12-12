num = Int64(0)       #Declaration of all nessasary variables
count = Int64(0)
n = Int64(0)
mincount = Int64(0)

num = 10000
count = 0
mincount = 0
maxcounts = Array{Int64}(10,2)

function updatearray(num, count, maxcounts, mincount)
  ind = -1
  diff = 0
  mincount = count
  
  i = 1
  while (i <= 10)
      if (maxcounts[i][2] < mincount)
          mincount = maxcounts[i][2]              #Stores the lowest count in the array
      end
      if (count - maxcounts[i][2]) > diff         #Keeps track of index that produces the largest difference between counts
          diff = count - maxcounts[i][2]
          ind = i
      end
      i += 1
  end
  if (ind != -1)
      maxcounts[ind][1] = num
      maxcounts[ind][2] = count
  end
end

maxcounts(1,1) = 0 

i = 1
while (i <= 10)                #Zero out the array
    maxcounts[i][1] = 0             
    maxcounts[i][2] = 0
end

while (num > 1)                      #Interate through inputted domain         
    n = num
    while (n != 1)                    #Preform collatz algorithm for number
        if (n%2 == 0)                 #If n is even then divide by 2
            n = n/2
        else                          #If n is odd then multiply by 3 and add 1
            n = (n*3)+1
        end
        count = count + 1
    end
    #println( "Number: ", num, "    Steps: ", count )
    if (count > mincount)
        updatearray(count, num, maxcounts, mincount)
    end
    num = num - 1
    count = 0
end

exit(0)