
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
    
    use mod_LeeCode0011
    character(len=200):: s1(3) = ["flower","flow","flight"], s2(3) = ["dog","racecar","car"]
    character(len=:), allocatable:: p
    !s(1) = "flower"
    !s(2) = "flow"
    !s(3) = "flight"
    !s(1) = "dog"
    !s(2) = "racecar"
    !s(3) = "car"
    call sub_longestCommonPrefix(size(s1), s1, p)
    print *, p
    
    return
    end subroutine sub_test