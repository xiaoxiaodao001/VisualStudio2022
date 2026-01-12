
    program main
    implicit none
    !character(len=4):: a='1234', b = '1234'
    !integer(kind=4):: c(2, 2) = (/ 1, 2, 3, 4, 5 /)
    !integer(kind=4):: d(4) = (/ 1, 2, 2, 1 /), e(4)
    !integer(kind=4):: i
    !real(kind=8):: pi = 3.14159265358979323846d0, mu_0 = 4.d0 * pi * 1.d-7
    print *, "Hello, world."
    !print *, a(2:)
    !print *, a(1:0)
    !b(1:0) = a(1:0)
    !print *, c
    !print *, c(:, 1)
    !print *, c(:, 2)
    !print "(sp, i3.2, ss, i2.2)", -12, 12
    !print "(i, i)", 1, 2
    !print *, (a == b)
    !print *, abs(int(-huge(1)-1, kind=8))
    !e = d(4:1:-1)
    !print *, (e == d)
    !b = a(4:1:-1)
    !print *, b
    !print *, size((/1, 2/))
    !do i = 1, 10
    !    print *, i
    !    i = i + 1
    !end do
    
    call sub_test
    
    stop
    end program main 