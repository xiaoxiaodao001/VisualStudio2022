! adjustl  NameList  size
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