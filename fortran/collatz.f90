!Mark Gomes
!CSC 330 
!Dr. Pounds
!Assignment 3 : Collatz Conjecture

program collatz

integer(kind=8) :: num
integer(kind=8) :: n
integer(kind=8) :: count
integer(kind=8) :: mincount
integer(kind=8), dimension(10, 2) :: maxcounts
integer :: i
integer :: j

interface

subroutine UpdateArray(num, count, mincount, maxcounts)
integer(kind=8) :: num
integer(kind=8) :: count
integer(kind=8) :: mincount
integer(kind=8), dimension(10, 2) :: maxcounts
end subroutine UpdateArray

subroutine ArraySort(maxcounts, mode)
integer(kind=8), dimension(10, 2) :: maxcounts
integer :: mode
end subroutine ArraySort

end interface
num = 5000000000
count = 0
mincount = 0 
forall(i = 1:10, j = 1:2) maxcounts(i,j) = 0       ! Zero out the cube

do while (num > 0)
    n = num
    do while (n /= 1)
        if(mod(n,2) == 0) then 
            n = n/2
        else
            n = (n*3)+1
        end if
        count = count + 1 
    end do
    !write(*, 5) " : Number: ", num, "    Steps: ", count
    !   5 format(A, I9, A, I9)
    if(count > mincount) then
        call UpdateArray(num, count, mincount, maxcounts)
    end if
    num = num - 1
    count = 0
end do

!!!Sorted by step length
Print *, "***Array Sorted by Step Length***"
call ArraySort(maxcounts, 1)
do i=1,10
    write(*, 20) " : Number: ", maxcounts(i,2), "    Steps: ", maxcounts(i,1)
    20 format(A, I9, A, I9)
end do
        
!!!Sorted by number magnitude
Print *, "***Array Sorted by Number Magnitude***"
call ArraySort(maxcounts, 2)
do i=1,10
    write(*, 30) " : Number: ", maxcounts(i,2), "    Steps: ", maxcounts(i,1)
    30 format(A, I9, A, I9)
end do

end program collatz

subroutine UpdateArray(num, count, mincount, maxcounts)
integer(kind=8) :: num
integer(kind=8) :: count
integer(kind=8) :: mincount
integer(kind=8), dimension(10, 2) :: maxcounts

integer :: index
integer :: diff

index = -1
diff = 0
mincount = count
do i=1,10
    if (maxcounts(i,1) < mincount) then
        mincount = maxcounts(i,1)              !Stores the lowest count in the array
    end if
    if (count - maxcounts(i,1) > diff) then     !Keeps track of index that produces the largest difference between counts
        diff = count - maxcounts(i,1)
        index = i
    end if
end do
if (index /= -1) then
    maxcounts(index,1) = count
    maxcounts(index,2) = num
end if

end subroutine UpdateArray

subroutine ArraySort(maxcounts, mode)
integer(kind=8), dimension(10, 2) :: maxcounts
integer :: mode

integer(kind=8) :: count = 0
integer :: index = 0
integer(kind=8) :: num = 0
integer(kind=8), dimension(10, 2) :: temp
integer(kind=8) :: maxval = 0

forall(i = 1:10, j = 1:2) temp(i,j) = 0       ! Zero out the cube

do j=1,10
    do i=1,10
        if (maxcounts(i,mode) >= maxval) then        ! Mode: [1]Sort by step number; [2]Sort by number magnitude
            maxval = maxcounts(i,mode)
            count = maxcounts(i,1)
            num = maxcounts(i,2)
            index = i
        end if
    end do
    temp(j,1) = count
    temp(j,2) = num
    maxcounts(index,1) = 0
    maxcounts(index,2) = 0
    maxval = 0
end do
maxcounts = temp

end subroutine ArraySort