
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
        
        
        
        subroutine sub_intToRoman(x, xR)
        implicit none
        integer(kind=4), intent(in):: x
        character(len=:), allocatable, intent(out):: xR
        
        integer(kind=4):: xi(0:3), i, temp, j
        character(len=4):: xRi(0:9, 0:3) = ' '
        character(len=15):: xRtemp = ' '
        
        xRi(:, 0) = (/ '', 'I', 'II', 'III', 'IV', 'V', 'VI', 'VII', 'VIII', 'IX' /)
        xRi(:, 1) = (/ '', 'X', 'XX', 'XXX', 'XL', 'L', 'LX', 'LXX', 'LXXX', 'XC' /)
        xRi(:, 2) = (/ '', 'C', 'CC', 'CCC', 'CD', 'D', 'DC', 'DCC', 'DCCC', 'CM' /)
        xRi(0:3, 3) = (/ '', 'M', 'MM', 'MMM' /)
        temp = x
        i = -1
        do while(temp > 0)
            i = i + 1
            xi(i) = mod(temp, 10)
            temp = temp / 10
        end do
        do j = i, 0, -1
            xRtemp = trim(xRtemp) // trim(xRi(xi(j), j))
        end do
        xR = trim(xRtemp)
         
        return
        end subroutine sub_intToRoman
    
    end module mod_LeeCode0011