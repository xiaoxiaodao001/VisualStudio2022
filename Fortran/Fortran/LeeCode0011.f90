
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
        
        character(len=4):: xRi(0:9, 0:3) =  (/ ' ', 'I', 'II', 'III', 'IV', 'V', 'VI', 'VII', 'VIII', 'IX', &
                                            ' ', 'X', 'XX', 'XXX', 'XL', 'L', 'LX', 'LXX', 'LXXX', 'XC', &
                                             ' ', 'C', 'CC', 'CCC', 'CD', 'D', 'DC', 'DCC', 'DCCC', 'CM', &
                                             ' ', 'M', 'MM', 'MMM', ' ', ' ', ' ', ' ', ' ', ' ' /)
        integer(kind=4):: xi(0:3), i, temp, j
        character(len=15):: xRtemp = ' '
        
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
        
        
        
        subroutine sub_romanToInt(xR, x)
        character(len=*), intent(in):: xR
        integer(kind=4), intent(out):: x
        
        character(len=4):: xRi(0:9, 0:3) =  (/ ' ', 'I', 'II', 'III', 'IV', 'V', 'VI', 'VII', 'VIII', 'IX', &
                                            ' ', 'X', 'XX', 'XXX', 'XL', 'L', 'LX', 'LXX', 'LXXX', 'XC', &
                                             ' ', 'C', 'CC', 'CCC', 'CD', 'D', 'DC', 'DCC', 'DCCC', 'CM', &
                                             ' ', 'M', 'MM', 'MMM', ' ', ' ', ' ', ' ', ' ', ' ' /)
        integer(kind=4):: i, i1, i2, xRlen, xRilen
        character(len=4):: xR3=' ', xR2=' ', xR1=' ', xR0=' ', xRin(4) = ' ', xRii
        
        i = 1
        i1 = i
        xRlen = len_trim(xR)
        do while(i <= xRlen)
            if (xR(i:i) == 'M') then
                i = i + 1
            else
                exit
            end if            
        end do
        i2 = i - 1
        xR3(1 : (i2-i1+1)) = xR(i1 : i2)
        
        do while(i <= xRlen)
            if ((xR(i:i) == 'C') .or. (xR(i:i) == 'D') .or. (xR(i:i) == 'M')) then
                i = i + 1
            else
                exit
            end if
        end do
        i1 = i2 + 1
        i2 = i - 1
        xR2(1 : (i2-i1+1)) = xR(i1 : i2)
        
        do while(i <= xRlen)
            if ((xR(i:i) == 'X') .or. (xR(i:i) == 'L') .or. (xR(i:i) == 'C')) then
                i = i + 1
            else
                exit
            end if
        end do
        i1 = i2 + 1
        i2 = i - 1
        xR1(1 : (i2-i1+1)) = xR(i1 : i2)
        
        do while(i <= xRlen)
            if ((xR(i:i) == 'I') .or. (xR(i:i) == 'V') .or. (xR(i:i) == 'X')) then
                i = i + 1
            else
                exit
            end if
        end do
        i1 = i2 + 1
        i2 = i - 1
        xR0(1 : (i2-i1+1)) = xR(i1 : i2)
        
        x = 0
        
        xRilen = len_trim(xR0)
        i = 1
        if (xRilen /= 0) then
            i = i + 1
            select case(xR0(1:1))
            case('I')
                x = x + 1
                do while(i <= xRilen)
                    select case(xR0(i:i))
                    case('I')
                        x = x + 1
                        i = i + 1
                    case('V')
                        x = x + 5 - 2
                        i = i + 1
                    case('X')
                        x = x + 10 - 2
                        i = i + 1
                    end select                    
                end do
            case('V')
                x = x + 5
                do while(i <= xRilen)
                    x = x + 1                  
                    i = i + 1
                end do
            end select
        end if
        
        xRilen = len_trim(xR1)
        i = 1
        if (xRilen /= 0) then
            i = i + 1
            select case(xR1(1:1))
            case('X')
                x = x + 10
                do while(i <= xRilen)
                    select case(xR1(i:i))
                    case('X')
                        x = x + 10
                        i = i + 1
                    case('L')
                        x = x + 50 - 20
                        i = i + 1
                    case('C')
                        x = x + 100 - 20
                        i = i + 1
                    end select                    
                end do
            case('L')
                x = x + 50
                do while(i <= xRilen)
                    x = x + 10                  
                    i = i + 1
                end do
            end select
        end if
        
        
        xRilen = len_trim(xR2)
        i = 1
        if (xRilen /= 0) then
            i = i + 1
            select case(xR2(1:1))
            case('C')
                x = x + 100
                do while(i <= xRilen)
                    select case(xR2(i:i))
                    case('C')
                        x = x + 100
                        i = i + 1
                    case('D')
                        x = x + 500 - 200
                        i = i + 1
                    case('M')
                        x = x + 1000 - 200
                        i = i + 1
                    end select                    
                end do
            case('D')
                x = x + 500
                do while(i <= xRilen)
                    x = x + 100                  
                    i = i + 1
                end do
            end select
        end if
        
        x = x + len_trim(xR3) * 1000
        
        return
        end subroutine sub_romanToInt
    
    end module mod_LeeCode0011