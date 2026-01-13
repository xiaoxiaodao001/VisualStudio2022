
    program main
    implicit none
    !character(len=4):: a='12345', b = '1234', c(2), d
    character(len=1):: a, b='1'
    !character(len=:), allocatable:: p
    !integer(kind=4):: a(2, 1), b(2), c(2, 0), a1 = 1, a2 = 2, a3 = 3
    !integer(kind=4), allocatable:: d(:, :)
    !character(len=1), allocatable:: temp(:)
    !integer(kind=4):: c(4) = (/ 1, 2, 3, 4 /)
    !integer(kind=4):: d(4) = (/ 1, 2, 2, 1 /), e(4)
    !integer(kind=4):: i
    !real(kind=8):: pi = 3.14159265358979323846d0, mu_0 = 4.d0 * pi * 1.d-7
    !b = [a1, a2]
    !d = b
    print *, "Hello, world."
    !a = b + 1
    !print *, ichar("12")
    !print *, size(a, 2)
    !print *, size(c, 2)
    !print *, size(b, 2)
    !c(1) = a
    !print *, c(1)
    !!print *, a(1)
    !d = ''
    !p = ''
    !print *, p
    !print *, len(p)
    !print *, len_trim(p)
    !print *, size(c)
    !
    !!character(len=:), allocatable:: temp(2)
    !allocate(character(len=1):: temp(2))
    !deallocate(temp)
    !print *, min(c)
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