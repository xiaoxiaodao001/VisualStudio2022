
    module mod_LeeCode0011
    implicit none
    contains
    
        subroutine sub_maxArea(n, height, maxArea)
        implicit none
        integer(kind=4), intent(in):: n, height(n)
        integer(kind=4), intent(out):: maxArea
        
        integer(kind=4):: i, j, temp
        
        maxArea = (n - 1) * min(height(1), height(n))
        do i = 1, n-1, 1
            do j = n, i+1, -1
                temp = (j - i) * min(height(i), height(j))
                maxArea = max(maxArea, temp)
            end do
        end do
                        
        return
        end subroutine sub_maxArea
    
    end module mod_LeeCode0011