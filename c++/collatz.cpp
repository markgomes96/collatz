//Mark Gomes
//CSC 330
//Dr. Pounds
//Assignment 3 - Collatz Conjecture
#include <iostream>
#include <climits>

using namespace std;

void UpdateArray(int count, unsigned long long int num, unsigned long long int maxcounts[10][2], int mincount);
void ArraySort(unsigned long long int maxcounts[10][2], int mode);

int main(int argc, char* argv[])
{
    unsigned long long int num = 1; 
    unsigned long long int n;
    int count = 0;
    int mincount = 0;
    //long check = 0;
    unsigned long long int maxcounts[10][2];    // counts, number
    
    //Zero out the array
    for(int i = 0; i < 10; i++)
    {
        maxcounts[i][0] = (unsigned long long int)0;
        maxcounts[i][1] = (unsigned long long int)0;
    }
        
    while(num < ULLONG_MAX)
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
        cout << "Number " << num << " has " << count << " steps." << endl;
        if(count > mincount)
        {
            UpdateArray(count, num, maxcounts, mincount);
        }
        num = num + 1;
        count = 0;
    }
//End:
    //Sorted by step length
    cout << "***Array Sorted by Step Length***" << endl;
    ArraySort(maxcounts, 0);
    for(int i = 0; i < 10; i++)
    {
        cout << i << " : Number " << maxcounts[i][1] << " has " << maxcounts[i][0] << " steps" << endl;
    }
        
    //Sorted by number magnitude
    cout << "***Array Sorted by Number Magnitude***" << endl;
    ArraySort(maxcounts, 1);
    for(int i = 0; i < 10; i++)
    {
        cout << i << " : Number " << maxcounts[i][1] << " has " << maxcounts[i][0] << " steps" << endl;
    }
}

void UpdateArray(int count, unsigned long long int num, unsigned long long int maxcounts[10][2], int mincount)
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
        maxcounts[index][0] = (unsigned long long int)count;
        maxcounts[index][1] = num;
    }
}
    
void ArraySort(unsigned long long int maxcounts[10][2], int mode)    //Mode: [1]Sort by step number; [2]Sort by number magnitude
{
    unsigned long long int temp[10][2];
    int maxval = 0,count = 0,index = 0;
    long num = 0;
        
    for(int x = 0; x < 10; x++)
    {
        for(int i = 0; i < 10; i++)
        {
            if(maxcounts[i][mode] >= (unsigned long long int)maxval)
            {
                maxval = (int)maxcounts[i][mode];
                count = (int)maxcounts[i][0];
                num = maxcounts[i][1];
                index = i;
            }
        }
        temp[x][0] = (unsigned long long int)count;
        temp[x][1] = num;
        maxcounts[index][0] = 0;
        maxcounts[index][1] = 0;
        maxval = 0;
    }
    maxcounts = temp;
}