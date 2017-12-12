#Mark Gomes
#CSC 330
#Dr. Pounds
#Assignment 3 - Collatz Conjecture

$num = 5000000000;
$count = 0;
$mincount = 0;
@maxcounts = ([0, 0], [0,0], [0,0], [0, 0], [0,0], [0,0], [0, 0], [0,0], [0,0], [0, 0]);
@temp = ([0, 0], [0,0], [0,0], [0, 0], [0,0], [0,0], [0, 0], [0,0], [0,0], [0, 0]);

while ($num > 1) 
{
    $n = $num;
    $count = RecCount($n);      #Preform Collatz algorithm with recursion
    
    #print "Number: $num    Steps: $count \n";
    if(count >= mincount)        #If count is larger than min count in array then add it
    {
        $index = -1;
        $diff = 0;
        $mincount = $count;
   
        for($i = 0; $i < 10; $i++)
        {
            if($maxcounts[$i][1] < $mincount)
            {
                $mincount  = $maxcounts[$i][1];        #Stores the lowest count in the array
            }
            if($count - $maxcounts[$i][1] > $diff)     #Keeps track of index that produces the largest difference between counts
            {
                $diff = $count - $maxcounts[$i][1];
                $index = $i;
            } 
        }
        if($index != -1)
        {
            $maxcounts[$index][1] = $count;
            $maxcounts[$index][0] = $num;
        }
    }
    $num = $num - 1;
    $count = 0;
}

$num = 0;
$count = 0;
for($x = 0; $x < 10; $x++)        #Sort by Step Length
{
    for($i = 0; $i < 10; $i++)
    {
        if($maxcounts[$i][1] >= $count)
        {
            $count = $maxcounts[$i][1];
            $num = $maxcounts[$i][0];
            $index = $i;
        }
    }
    $temp[$x][1] = $count;
    $temp[$x][0] = $num;
    $maxcounts[$index][0] = 0;
    $maxcounts[$index][1] = 0;
    $count = 0;
}
for($i = 0; $i < 10; $i++)
{
    $maxcounts[$i][0] = $temp[$i][0];
    $maxcounts[$i][1] = $temp[$i][1];
}

print "***Array Sorted by Step Length*** \n";
for($i = 0; $i < 10; $i++)        #Display list by Step Length
{
    print "Number: $maxcounts[$i][0]    Steps: $maxcounts[$i][1] \n";
}

$num = 0;
$count = 0;
for($x = 0; $x < 10; $x++)        #Sort by Number Magnitude
{
    for($i = 0; $i < 10; $i++)
    {
        if($maxcounts[$i][0] >= $num)
        {
            $count = $maxcounts[$i][1];
            $num = $maxcounts[$i][0];
            $index = $i;
        }
    }
    $temp[$x][1] = $count;
    $temp[$x][0] = $num;
    $maxcounts[$index][0] = 0;
    $maxcounts[$index][1] = 0;
    $num = 0;
}
for($i = 0; $i < 10; $i++)
{
    $maxcounts[$i][0] = $temp[$i][0];
    $maxcounts[$i][1] = $temp[$i][1];
}

print "***Array Sorted by Number Magnitude*** \n";
for($i = 0; $i < 10; $i++)        #Display list by Number Magnitude
{
    print "Number: $maxcounts[$i][0]    Steps: $maxcounts[$i][1] \n";
}

sub RecCount                  #Recursion to find collatz sequence count
{
    my($n) = @_;
    if($n == 1)
    {
        return 0;
    }
    else
    { 
        if($n%2 == 0)
        {
            return 1 + RecCount($n/2);
        }
        else
        {
            return 1 + RecCount(($n*3)+1);
        }
    }
}