
    subroutine sub_test
    !implicit none
    !use mod_LeeCode0011
    !integer(kind=4):: a(4) = (/ 2, 2, 2, 2 /), maxArea
    !call sub_maxArea(size(a), a, maxArea)
    !print *, maxArea
    
    use mod_LeeCode0011
    integer(kind=4):: x = 3749
    character(len=:), allocatable:: xR
    call sub_intToRoman(x, xR)
    print *, xR
    
    
    return
    end subroutine sub_test