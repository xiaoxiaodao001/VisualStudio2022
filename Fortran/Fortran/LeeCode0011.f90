
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
        
        
        
        subroutine sub_longestCommonPrefix(n, s, p)
        integer(kind=4), intent(in):: n
        character(len=200), intent(in):: s(n)
        character(len=:), allocatable, intent(out):: p
        
        integer(kind=4):: silen(n), i, minsilen, j, plen
        character(len=1), allocatable:: temp(:, :)
        character(len=:), allocatable:: sitemp
        character(len=1):: p_i
        
        if (n == 1) then
            p = s(1)
            return
        end if
        
        minsilen = 200
        do i = 1, n, 1
            silen(i) = len_trim(s(i))
            minsilen = min(minsilen, silen(i))
        end do
        if (minsilen == 0) then
            p = ''
            return
        end if
        
        allocate(character(len=1):: temp(minsilen, n))
        allocate(character(len=minsilen):: sitemp)
        do j = 1, n, 1
            sitemp = s(j)
            do i = 1, minsilen, 1
                temp(i, j) = sitemp(i:i)
            end do            
        end do
        
        Loop1: do i = 1, minsilen, 1
            p_i = temp(i, 1)
            do j = 2, n, 1
                if (p_i /= temp(i, j)) then
                    exit Loop1
                end if
            end do
        end do Loop1
        plen = i - 1
        ! transfer:: p = transfer(temp(1:plen, 1), p)
        !p = sitemp(1 : plen)
        allocate(character(len=plen):: p)
        p = transfer(temp(1:plen, 1), p)
        
        return
        end subroutine sub_longestCommonPrefix
        
        
        
        subroutine sub_threeSum(n, num, threeSum)
        integer(kind=4), intent(in):: n, num(n)
        integer(kind=4), allocatable, intent(out):: threeSum(:, :)
        
        integer(kind=4):: i, j, k, numi, numj, numk, twosum, threeNum, count, numi1, numj1, numk1, tempi(3), count1, tempj(3)
        real(kind=8):: realthreeNum = 1.d0
        integer(kind=4), allocatable:: temp(:, :), threeNumi(:)
        
        if (n == 3) then
            if (sum(num) == 0) then
                allocate(threeSum(3, 1))
                threeSum(:, 1) = num
            else
                allocate(threeSum(3, 0))
            end if
            return
        end if
        i = min(3, n-3)
        do j = 1, i, 1
            realthreeNum = realthreeNum * real(n-i+j, kind=8) / real(j, kind=8)
        end do
        threeNum = int(realthreeNum)
        allocate(temp(3, threeNum))
        count = 0
        do i = 1, n-2, 1
            numi = num(i)
            twosum = 0 - numi
            do j = i+1, n-1, 1
                numj = num(j)
                numk = twosum - numj
                do k = j+1, n, 1
                    if (numk == num(k)) then
                        count = count + 1
                        numi1 = min(numi, numj, numk)
                        numk1 = max(numi, numj, numk)
                        numj1 = 0 - numi1 - numk1
                        temp(:, count) = [numi1, numj1, numk1]
                    end if
                end do
            end do
        end do
        if (count == 0) then
            allocate(threeSum(3, 0))
            return
        end if
        
        allocate(threeNumi(count))
        threeNumi = 1
        count1 = count
        do i = 1, count-1, 1
            if (threeNumi(i) == 0) cycle
            tempi = temp(:, i)
            do j = i+1, count, 1
                if (threeNumi(j) == 0) cycle
                tempj = temp(:, j)
                if (all(tempi == tempj)) then
                    count1 = count1 - 1
                    threeNumi(j) = 0
                end if
            end do
        end do
        allocate(threeSum(3, count1))
        j = 0
        do i = 1, count, 1
            if (threeNumi(i) == 1) then
                j = j + 1
                threeSum(:, j) = temp(:, i)
            end if
        end do
        
        return
        end subroutine sub_threeSum
        
    
    end module mod_LeeCode0011