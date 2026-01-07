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
    
    end module mod_LeeCode001