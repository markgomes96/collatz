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
        ulong num = 1; 
        ulong n;
        int count = 0;
        int mincount = 0;
        
        ulong[,] maxcounts = new ulong[10, 2];    // counts, number
        
        while(num < 5000000000)
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
                    n = (n*3)+1;
                }
                count = count + 1;
                //Console.Write("Count: " + count + ": " + n + "\n");
            }while(n != 1);
            //Console.Write("Number " + num + " has " + count + " steps. \n");
            if(count >= mincount)      //If count is larger than min count in array then add it
            {
                UpdateArray(count, num, maxcounts, mincount);
            }
            num = num + 1;
            count = 0;
        }
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
