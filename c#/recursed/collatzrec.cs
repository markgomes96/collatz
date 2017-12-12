/* Mark Gomes
 * CSC 330 
 * Dr. Pounds
 * Assignment 3 : Collatz Conjecture
 */
using System;
using System.Diagnostics;

public class collatz
{
    static public void Main()
    {
        ulong num = 5000000000; 
        int count = 0;
        int mincount = 0;
        
        ulong[,] maxcounts = new ulong[10, 2];    // counts, number
        
        //Preform Collatz Algorithm
        NumCount(num, count, maxcounts, mincount);    // Recursion
        
        //Sorted by step length
        Console.Write("***Array Sorted by Step Length*** \n");
        maxcounts = ArraySort(maxcounts, 0);
        for(int i = 0; i < 10; i++)
        {
            Console.Write(i + " : Number " + maxcounts[i,1] + " has " + maxcounts[i,0] + " steps \n");
        }
        
        //Sorted by number magnitude
        Console.Write("***Array Sorted by Number Magnitude*** \n");
        maxcounts = ArraySort(maxcounts, 1);
        for(int i = 0; i < 10; i++)
        {
            Console.Write(i + " : Number " + maxcounts[i,1] + " has " + maxcounts[i,0] + " steps \n");
        }
    }   
    
    static void NumCount(ulong num, int count, ulong[,] maxcounts, int mincount)
    {
        if(num == 0)
        {
            //End Recursion
        }
        else
        {
            count = RecCount(num);
            if(count >= mincount)      //If count is larger than min count in array then add it
            {
                UpdateArray(count, num, maxcounts, mincount);
            }
            NumCount(num-1, count, maxcounts, mincount);
        }
    }
    
    static int RecCount(ulong n)
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
    
    static void UpdateArray(int count, ulong num, ulong[,] maxcounts, int mincount)
    {
        int index = -1;
        int diff = 0;
        mincount = count;
        for(int i = 0; i < 10; i++)
        {
            if((int)maxcounts[i,0] < mincount)
            {
                mincount  = (int)maxcounts[i,0];      //Stores the lowest count in the array
            }
            if(count - (int)maxcounts[i,0] > diff)     //Keeps track of index that produces the largest difference between counts
            {
                diff = count - (int)maxcounts[i,0];
                index = i;
            } 
        }
        if(index != -1)
        {
            maxcounts[index,0] = (ulong)count;
            maxcounts[index,1] = num;
        }
    }
    
    static ulong[,] ArraySort(ulong[,] maxcounts, int mode)    //Mode: [0]Sort by step number; [1]Sort by number magnitude
    {
        ulong[,] temp = new ulong[10,2];
        int maxval = 0,count = 0,index = 0;
        ulong num = 0;
        
        for(int x = 0; x < 10; x++)
        {
            for(int i = 0; i < 10; i++)
            {
                if(maxcounts[i,mode] >= (ulong)maxval)
                {
                    maxval = (int)maxcounts[i,mode];
                    count = (int)maxcounts[i,0];
                    num = maxcounts[i,1];
                    index = i;
                }
            }
            temp[x,0] = (ulong)count;
            temp[x,1] = num;
            maxcounts[index,0] = 0;
            maxcounts[index,1] = 0;
            maxval = 0;
        }
        return temp;
    }
}
