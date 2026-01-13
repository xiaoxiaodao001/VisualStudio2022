
    subroutine sub_test
    !implicit none
    !use mod_LeeCode0011
    !integer(kind=4):: a(4) = (/ 2, 2, 2, 2 /), maxArea
    !call sub_maxArea(size(a), a, maxArea)
    !print *, maxArea
    
    !use mod_LeeCode0011
    !integer(kind=4):: x = 3333
    !character(len=:), allocatable:: xR
    !call sub_intToRoman(x, xR)
    !print *, xR
    !call sub_romanToInt(xR, x)
    !print *, x
    
    !use mod_LeeCode0011
    !character(len=200):: s1(3) = ["flower","flow","flight"], s2(3) = ["dog","racecar","car"]
    !character(len=:), allocatable:: p
    !!s(1) = "flower"
    !!s(2) = "flow"
    !!s(3) = "flight"
    !!s(1) = "dog"
    !!s(2) = "racecar"
    !!s(3) = "car"
    !call sub_longestCommonPrefix(size(s1), s1, p)
    !print *, p
    
    !use mod_LeeCode0011
    !integer(kind=4):: num(6) = [-1,0,1,2,-1,-4], i, num2(3)=[0,1,1], num3(3)= [0,0,0]
    !integer(kind=4), allocatable:: threeSum(:, :)
    !
    !call sub_threeSum(size(num), num, threeSum)
    !do i = 1, size(threeSum, 2), 1
    !    print *, threeSum(:, i)
    !end do
    !deallocate(threeSum)
    !
    !print *
    !call sub_threeSum(size(num2), num2, threeSum)
    !do i = 1, size(threeSum, 2), 1
    !    print *, threeSum(:, i)
    !end do
    !deallocate(threeSum)
    !
    !print *
    !call sub_threeSum(size(num3), num3, threeSum)
    !do i = 1, size(threeSum, 2), 1
    !    print *, threeSum(:, i)
    !end do
    !deallocate(threeSum)
    
    !use mod_LeeCode0011
    !integer(kind=4):: nums(4) = [-1, 2, 1, -4], targe = 1, threeSum, nums1(3)=0
    !call sub_threeSumClosest(size(nums), nums, targe, threeSum)
    !print *, threeSum
    !call sub_threeSumClosest(size(nums1), nums1, targe, threeSum)
    !print *, threeSum
    
    use mod_LeeCode0011
    character(len=4):: digits = '2'
    character(len=:), allocatable:: s(:)
    call sub_letterCombinations(len_trim(digits), digits, s)
    print *, s
    
    return
    end subroutine sub_test