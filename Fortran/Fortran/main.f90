
    program main
    implicit none
    character(len=4):: a='1234', b = '1234'
    !integer(kind=4):: i
    !real(kind=8):: pi = 3.14159265358979323846d0, mu_0 = 4.d0 * pi * 1.d-7
    !print *, "Hello, world."
    !print "(sp, i3.2, ss, i2.2)", -12, 12
    print "(i, i)", 1, 2
    print *, (a == b)
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