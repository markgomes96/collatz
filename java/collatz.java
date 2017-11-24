/* Mark Gomes
 * CSC 330 
 * Dr. Pounds
 * Assignment 3 : Collatz Conjecture
 */

public class collatz
{
    public static void main(String[] args)
    {
        long num = 1; 
        long n;
        int count = 0;
        int mincount = 0;
        //long check = 0;
        
        long[][] maxcounts = new long[10][2];    // counts, number
        
        while(num < Long.MAX_VALUE)
        {
            n = num;
            do
            {
                if(n%2 == 0)
                {
                    n = n/2;            
                }
                else
                {
                    //check = n;
                    n = (n*3)+1;
                    //if(n < check)      //Checks if number is too high to be computed by the algorithm
                    //    goto End;
                }
                count = count + 1;
                //System.out.print("Count: " + count + ": " + n + "\n");
            }while(n != 1);
            System.out.print("Number " + num + " has " + count + " steps. \n");
            if(count > mincount)
            {
                UpdateArray(count, num, maxcounts, mincount);
            }
            num = num + 1;
            count = 0;
        }
    //End:
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
            if(count - (int)maxcounts[i][0] > diff)
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