/* Mark Gomes
 * CSC 330 
 * Dr. Pounds
 * Assignment 3 : Collatz Conjecture
 */

public class collatzrec
{
    public static void main(String[] args)
    {
        long num = 5000000000; 
        int count = 0;
        int mincount = 0;
        
        long[][] maxcounts = new long[10][2];    // counts, number
        
        //Preform Collatz Algorithm
        while(num > 0)
        {
            count = RecCount(num);    //Collatz sequence recursion
            //System.out.print("Number " + num + " has " + count + " steps. \n");
            if(count > mincount)      //If count is larger than min count in array then add it
            {
                UpdateArray(count, num, maxcounts, mincount);
            }
            num = num - 1;
            count = 0;
        }
        
        //Sorted by step length
        System.out.print("***Array Sorted by Step Length*** \n");
        maxcounts = ArraySort(maxcounts, 0);
        for(int i = 0; i < 10; i++)
        {
            System.out.print(i + " : Number " + maxcounts[i][1] + " has " + maxcounts[i][0] + " steps \n");
        }
        
        //Sorted by number magnitude
        System.out.print("***Array Sorted by Number Magnitude*** \n");
        maxcounts = ArraySort(maxcounts, 1);
        for(int i = 0; i < 10; i++)
        {
            System.out.print(i + " : Number " + maxcounts[i][1] + " has " + maxcounts[i][0] + " steps \n");
        }
    }   
    
    static int RecCount(long n)
    {
        if(n == 1)
        {
             return 0;
        }
        else if(n%2 == 0)
        {
            return 1 + RecCount(n/2);
        }
        else
        {
            return 1 + RecCount((n*3)+1);
        }
    }
    
    static void UpdateArray(int count, long num, long[][] maxcounts, int mincount)
    {
        int index = -1;
        int diff = 0;
        mincount = count;
        for(int i = 0; i < 10; i++)
        {
            if((int)maxcounts[i][0] < mincount)
            {
                mincount  = (int)maxcounts[i][0];      //Stores the lowest count in the array
            }
            if(count - (int)maxcounts[i][0] > diff)    //Keeps track of index that produces the largest difference between counts
            {
                diff = count - (int)maxcounts[i][0];
                index = i;
            } 
        }
        if(index != -1)
        {
            maxcounts[index][0] = (long)count;
            maxcounts[index][1] = num;
        }
    }
    
    static long[][] ArraySort(long[][] maxcounts, int mode)    //Mode: [1]Sort by step number; [2]Sort by number magnitude
    {
        long[][] temp = new long[10][2];
        int maxval = 0,count = 0,index = 0;
        long num = 0;
        
        for(int x = 0; x < 10; x++)
        {
            for(int i = 0; i < 10; i++)
            {
                if(maxcounts[i][mode] >= (long)maxval)
                {
                    maxval = (int)maxcounts[i][mode];
                    count = (int)maxcounts[i][0];
                    num = maxcounts[i][1];
                    index = i;
                }
            }
            temp[x][0] = (long)count;
            temp[x][1] = num;
            maxcounts[index][0] = 0;
            maxcounts[index][1] = 0;
            maxval = 0;
        }
        return temp;
    }
}