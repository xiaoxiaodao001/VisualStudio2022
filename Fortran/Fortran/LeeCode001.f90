! adjustl  NameList  size
    module mod_LeeCode001
    implicit none
    contains
    
        subroutine sub_twosum(n, nums, targ, inde)
        implicit none
        integer(kind=4), intent(in):: n, nums(n), targ
        integer(kind=4), intent(out):: inde(2)
        integer(kind=4):: i, j, temp
    
        do i = 1, n-1, 1
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
        
        
        subroutine sub_lengthOfLongestSubstring(s, n)
        implicit none
        character(len=*), intent(in):: s
        integer(kind=4), intent(out):: n
        
        integer(kind=4):: slen, i, j, k, n1
        n = 1
        slen = len(s)
        do i = 1, slen, 1
            loop2: do j = i+1, slen, 1
                do k = i, j-1, 1
                    if (s(j:j) == s(k:k)) exit loop2
                end do
            end do loop2
            n1 = j - i
            n = max(n, n1)
            if (n > (slen - i + 1)) exit
        end do
        
        return
        end subroutine sub_lengthOfLongestSubstring
        
        
        subroutine sub_findMedianSortedArrays(m, nums1, n, nums2, mid)
        implicit none 
        integer(kind=4), intent(in):: m, nums1(m), n, nums2(n)
        real(kind=8), intent(out):: mid
        
        integer(kind=4):: i, j, idx, arr(m+n), i1, j1, ntotal, idxmid
        
        !av = (sum(m) + sum(n)) / (m + n)
        idx = 0
        i = 1
        j = 1
        do while ((i <= m) .and. (j <= n))
            idx = idx + 1
            if(nums1(i) <= nums2(j)) then
                arr(idx) = nums1(i)
                i = i + 1
            else
                arr(idx) = nums2(j)
                j = j + 1
            end if
        end do
        
        do i1 = i, m, 1
            idx = idx + 1
            arr(idx) = nums1(i1)
        end do
        do j1 = j, n, 1
            idx = idx + 1
            arr(idx) = nums2(j1)
        end do
        
        ntotal = m + n
        idxmid = ntotal / 2
        if (mod(ntotal, 2) == 0) then
            mid = real((arr(idxmid) + arr(idxmid + 1)), kind=8) / 2.d0
        else
            mid = real(arr(idxmid+1), kind=8)
        end if
        
        return
        end subroutine sub_findMedianSortedArrays
        
        
        subroutine sub_longestPalindrome(s, subPs)
        implicit none
        character(len=*), intent(in):: s
        character(len=:), allocatable, intent(out):: subPs
        
        character(len=:), allocatable:: temp
        integer(kind=4):: i, j, slen, sublen, k, lenmid, i1, j1, len1, len2
        
        slen = len(s)
        i1 = 1
        j1 = 1
        len1 = 1
        do i = 1, slen, 1
            do j = slen, i, -1
                sublen = j - i + 1
                lenmid = sublen / 2
                k = 0
                do while(k < lenmid)
                    if (s(i+k : i+k) == s(j-k : j-k)) then
                        k = k + 1
                    else
                        exit
                    end if                    
                end do
                if (k == lenmid) then
                    len2 = sublen
                    if (len2 > len1) then
                        len1 = len2
                        i1 = i
                        j1 = j
                    end if
                    if (len1 > (slen-i+1)) exit
                else
                    cycle
                end if                
            end do
        end do
        subPs = s(i1 : j1)
        
        return
        end subroutine sub_longestPalindrome
        
        
        
        subroutine sub_convert(s, numRows, sNew)
        character(len=*), intent(in):: s
        integer(kind=4), intent(in):: numRows
        character(len=len(s)), intent(out):: sNew
        
        integer(kind=4):: i, ind, slen, indNew, T, T1, T2
        
        slen = len(s)
        if (numRows == 1) then
            sNew = s
            return
        end if
        
        T = numRows + numRows - 2
        indNew = 0
        i = 1
        ind = i
        do while(ind <= slen)
            indNew = indNew + 1
            sNew(indNew : indNew) = s(ind : ind)
            ind = ind + T
        end do
        do i = 2, numRows-1, 1
            ind = i
            T2 = i + i - 2
            T1 = T - T2
            do while(ind <= slen)
                indNew = indNew + 1
                sNew(indNew : indNew) = s(ind : ind)
                ind = ind + T1
                if (ind <= slen) then
                    indNew = indNew + 1
                    sNew(indNew : indNew) = s(ind : ind)
                    ind = ind + T2
                end if
            end do
        end do
        i = numRows
        ind = i
        do while(ind <= slen)
            indNew = indNew + 1
            sNew(indNew : indNew) = s(ind : ind)
            ind = ind + T
        end do
        
        return
        end subroutine sub_convert
        
        
        
        subroutine sub_reverse(x, xr)
        implicit none
        integer(kind=4), intent(in):: x
        integer(kind=4), intent(out):: xr
        
        integer(kind=4):: i, xi, temp2, j, ie, int4 = 1
        integer(kind=8):: xabs, temp, xrtemp, int8_10 = 10
        
        xr = 0
        if (x == 0) return
        
        xabs = abs(int(x, kind=8))
        temp = xabs
        xrtemp = 0
        do while(temp > 0)
            xi = mod(temp, 10)
            temp = temp / 10
            xrtemp = xrtemp * 10 + xi
        end do
        
        xrtemp = sign(xrtemp, x)
        
        if (((-huge(int4)-1) <= xrtemp) .and. (xrtemp <= huge(int4))) xr = xrtemp
        
        return
        end subroutine sub_reverse
        
        
        
        subroutine sub_myAtoi(s, x)
        character(len=*), intent(in):: s
        integer(kind=4), intent(out):: x
        
        character(len=1):: si = ' '
        integer(kind=4):: slen, i, int4 = 1, xi, xsign, ichar_0
        integer(kind=8):: temp, int4huge
        
        x = 0
        slen = len(s)
        if (slen == 0) return
        ! char, ichar
        i = 0
        do while ((si == ' ') .and. (i < slen))
            i = i + 1
            si = s(i:i)
        end do
        
        xsign = 1
        if (si == '-') then
            xsign = -1
            i = i + 1
            if (i <= slen) then
                si = s(i:i)
            else
                return
            end if
        end if
        if (si == '+') then
            i = i + 1
            if (i <= slen) then
                si = s(i:i)
            else
                return
            end if
        end if
        int4huge = huge(int4)
        ichar_0 = ichar('0')
        do while ((si == '0') .and. (i < slen))
            i = i + 1
            si = s(i:i)
        end do
        
        temp = 0       
        do while (('0' <= si) .and. (si <= '9') .and. (i < slen))
            xi = ichar(si) - ichar_0
            temp = temp * 10 + xi
            if (temp > (int4huge + 1)) exit
            i = i + 1
            si = s(i:i)
        end do
        temp = temp * xsign
        if (temp < -int4huge-1) then
            x = -int4huge-1
        else if (temp > int4huge) then 
            x = int4huge
        else 
            x = temp
        end if
        
        return
        end subroutine sub_myAtoi
        
        
        
        subroutine sub_isPalindrome(x, ISorNOT)
        implicit none
        integer(kind=4), intent(in):: x
        logical(kind=4), intent(out):: ISorNOT
        
        integer(kind=4):: xi(10), i, temp
        
        ISorNOT = .false.
        if (x < 0) return
        if ((0 <= x) .and. (x <= 9)) then
            ISorNOT = .true.
            return
        end if
        
        temp = x
        i = 0
        do while(temp > 0)
            i = i + 1
            xi(i) = mod(temp, 10)
            temp = temp / 10
        end do
        
        if (all(xi(1 : i) == xi (i : 1 : -1))) then
            ISorNOT = .true.
            return
        end if
        
        return
        end subroutine sub_isPalindrome
    
    end module mod_LeeCode001