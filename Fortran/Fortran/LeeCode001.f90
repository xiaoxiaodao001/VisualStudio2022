! adjustl  NameList  size
    module mod_LeeCode001
    implicit none
    contains
    
        subroutine sub_twosum(n, nums, targ, inde)
        implicit none
        integer(kind=4), intent(in):: n, nums(n), targ
        integer(kind=4), intent(out):: inde(2)
        integer(kind=4):: i, j, temp
    
        do i = 1, n, 1
            temp = targ - nums(i)
            do j = i+1, n, 1
                !if (targ == (nums(i) + nums(j))) then
                if (temp == nums(j)) then
                    inde = [i, j]
                    return
                end if
            end do
        end do
    
        return
        end subroutine sub_twosum
    
    
    
        subroutine sub_addTwoNumbers(n1, l1, n2, l2, l3)
        implicit none
        integer(kind=4), intent(in):: n1, l1(n1), n2, l2(n2)
        integer(kind=4), allocatable, intent(out):: l3(:)
    
        integer(kind=4):: i, n3
        integer(kind=4), allocatable:: temp(:)
    
        n3 = max(n1, n2)
        allocate(temp(n3+1))
    
        temp = 0
        temp(1:n1) = l1
        temp(1:n2) = temp(1:n2) + l2
    
        do i = 1, n3, 1
            if (temp(i) < 10) then
                continue
            end if
            temp(i) = temp(i) - 10
            temp(i+1) = temp(i+1) + 1
        end do
    
        if (temp(n3+1) == 0) then
            l3 = temp(1:n3)
        else
            l3 = temp
        end if
    
        return
        end subroutine sub_addTwoNumbers
    
    end module mod_LeeCode001