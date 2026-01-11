
    subroutine sub_test
    !implicit none
    use mod_LeeCode0011
    integer(kind=4):: a(4) = (/ 2, 2, 2, 2 /), maxArea
    call sub_maxArea(size(a), a, maxArea)
    print *, maxArea
    
    
    return
    end subroutine sub_test