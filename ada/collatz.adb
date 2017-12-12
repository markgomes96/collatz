--Mark Gomes
--CSC 330 
--Dr. Pounds
--Assignment 3 : Collatz Conjecture

with Ada.text_IO;
with Ada.Integer_Text_IO;
with Ada.Long_Long_Integer_Text_IO;
use Ada.Text_IO;
use Ada.Integer_Text_IO;
use Ada.Long_Long_Integer_Text_IO;

procedure collatz is
    num        : Long_Long_Integer := 1; 
    n          : Long_Long_Integer;
    count      : Long_Long_Integer := 0; 
    mincount   : Long_Long_Integer := 0;
    type Array_Number is array (1 .. 2) of Long_Long_Integer;
    type Array_Count is array (1 .. 10) of Array_Number;
    maxcounts  : Array_Count;    --counts, nunber
    temp       : Array_Count;
    index      : Integer := -1;
    diff       : Integer := 0;

begin
    for i in 1..10 loop        --Zero out the array
        maxcounts(i)(1) := 0;
        maxcounts(i)(2) := 0;
    end loop;
    
    loop
        exit when num > 5000000000;    --Preform collatz until that number
        n := num;
        loop
            if n mod 2 = 0 then
                n := n/2;            
            else
                n := (n*3)+1;
            end if;
            count := count + 1;
            exit when n = 1;
        end loop;
        
        --Displays number with sequence as it loops
        --Put("Number "); Put(num); Put(" has "); Put(count); Put(" steps.");
        --New_Line;
        
        if count >= mincount then    --If count is larger than min count in array then add it
            index := -1;
            diff  := 0;
            mincount := count; 
            for i in 1..10 loop
                if maxcounts(i)(1) < mincount then      --Updates the mincount
                    mincount := maxcounts(i)(1);
                end if;
                if integer(count - maxcounts(i)(1)) > diff then    --Keeps track of index that produces the largest difference between counts
                    diff := integer(count - maxcounts(i)(1));
                    index := i;
                end if;
            end loop;
            if index /= -1 then
                maxcounts(index)(1) := count;
                maxcounts(index)(2) := num;
            end if;
        end if;
        
        num := num + 1;
        count := 0;
    end loop;
    
    --Sorted by step length
    Put("***Array Sorted by Step Length***"); New_Line;
    count := 0; index := 0; num := 0;
    for i in 1..10 loop        --Zero out the array
        temp(i)(1) := 0;
        temp(i)(2) := 0;
    end loop;
    
    for x in 1..10 loop
        for i in 1..10 loop
            if maxcounts(i)(1) >= count then
                count := maxcounts(i)(1);
                num := maxcounts(i)(2);
                index := i;
            end if;
        end loop;
        temp(x)(1) := count;
        temp(x)(2) := num;
        maxcounts(index)(1) := 0;
        maxcounts(index)(2) := 0;
        count := 0;
    end loop;
    maxcounts := temp;
    
    --Display the numbers and steps
    for i in 1..10 loop
        Put("Number: "); Put(maxcounts(i)(2)); Put(" Steps: "); Put(maxcounts(i)(1));
        New_Line;
    end loop;
        
    --Sorted by number magnitude
    Put("***Array Sorted by Number Magnitude***"); New_Line;
    count := 0; index := 0; num := 0;
    for i in 1..10 loop        --Zero out the array
        temp(i)(1) := 0;
        temp(i)(2) := 0;
    end loop;
    
    for x in 1..10 loop
        for i in 1..10 loop
            if maxcounts(i)(2) >= num then
                count := maxcounts(i)(1);
                num := maxcounts(i)(2);
                index := i;
            end if;
        end loop;
        temp(x)(1) := count;
        temp(x)(2) := num;
        maxcounts(index)(1) := 0;
        maxcounts(index)(2) := 0;
        num := 0;
    end loop;
    maxcounts := temp;
    
    --Display the numbers and steps
    for i in 1..10 loop
        Put("Number: "); Put(maxcounts(i)(2)); Put(" Steps: "); Put(maxcounts(i)(1));
        New_Line;
    end loop;
    
end collatz;