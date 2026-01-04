
    ! 判断文件夹是否存在，不存在则新建一个。
    subroutine sub_mkdir(DirName)
    use ifport  
    implicit none
    character(len=256), intent(in):: DirName
    
    integer(kind=4):: DirExist, res
    
    inquire(directory = trim(DirName), exist = DirExist)
    if(.not. DirExist) then
        res = makedirqq(trim(DirName))
        if (res) then
            print *, ("文件夹不存在，已通过ifport新建：" // trim(DirName))
        else
            print *, ("错误：文件夹创建失败！路径：" // trim(DirName))
        end if
    else
        print *, ("文件夹已存在，无需重复创建：" // trim(DirName))
    end if
    
    return 
    end subroutine sub_mkdir
    
    
    subroutine sub_Logging(LogName, str)
    implicit none
    character(len=256), intent(in):: LogName, str
    
    integer(kind=4):: ierr, idlog = 11
    character(len=32):: str_DateTime    

    ! 打开日志文件（使用目标配置）
    open(unit=idlog, file=trim(LogName), status='unknown', position='append', action='write', iostat=ierr)

    ! 错误处理：日志文件打开失败
    if (ierr /= 0) then
        print *, "ERROR: 无法打开日志文件 ", trim(LogName)
        print *, "错误状态码：", ierr
        stop
    end if
    
    call sub_DateTime2str(str_DateTime)    
    write(idlog, "(a)") (trim(str_DateTime) // trim(str))
    close(idlog)
    
    return
    end subroutine sub_Logging
    
    
    ! 将当前时间转成这样的字符串：“(+08:00 2026/01/04 10:36:29.000)”
    subroutine sub_DateTime2str(str_DateTime)
    implicit none 
    character(len=32), intent(out):: str_DateTime
    
    character(len=12):: date, time, zone
    integer(kind=4):: DateTime(8)
    character(len=6):: str_zone
    character(len=10):: str_date
    character(len=12):: str_time
    
    call date_and_time(date, time, zone, DateTime)
    
    call sub_zone2str(DateTime(4), str_zone)
    write(str_date, "(i4.4, '/', i2.2, '/', i2.2)") DateTime(1:3)
    write(str_time, "(i2.2, ':', i2.2, ':', i2.2, '.', i3.3)") DateTime(5:8)
    
    str_DateTime = '(' // str_zone // ' ' // str_date // ' ' // str_time // ')'
    
    return 
    end subroutine sub_DateTime2str
    
    
    ! 将时区信息转换为这样的字符串：“+08:00”
    subroutine sub_zone2str(zone, str_zone)
    implicit none
    integer(kind=4), intent(in):: zone
    character(len=6), intent(out):: str_zone
    
    integer(kind=4):: zone_hh, zone_mm, abs_zone
    
    if (zone == 0) then
        str_zone = "+00:00"
    else if(zone > 0) then
        zone_hh = zone / 60
        zone_mm = mod(zone, 60)
        write(str_zone, "('+', i2.2, ':', i2.2)") zone_hh, zone_mm
    else 
        abs_zone = abs(zone)
        zone_hh = abs_zone / 60
        zone_mm = mod(abs_zone, 60)
        write(str_zone, "('-', i2.2, ':', i2.2)") zone_hh, zone_mm
    end if
    
    return
    end subroutine sub_zone2str
    
    
    ! 1234567.000s(00day00h00min00s000ms)
    subroutine sub_msTime2str(msTime, str_msTime)
    implicit none 
    integer(kind=8), intent(in):: msTime
    character(len=35), intent(out):: str_msTime
    
    integer(kind=4):: DateTime(8)
    
    call sub_msTime2DateTime(msTime, DateTime)
    write(str_msTime, "(i7, '.', i3.3, 's(', i2.2, 'day', i2.2, 'h', i2.2, 'min', i2.2, 's', i3.3, 'ms')") DateTime(7:8), DateTime(3), DateTime(5:8)
    
    return
    end subroutine sub_msTime2str
    
    
    ! “00 00:00:00.000”(日 时分秒毫秒) 默认大于0
    subroutine sub_msTime2DateTime(msTime, DateTime)
    implicit none
    integer(kind=8), intent(in):: msTime
    integer(kind=4), intent(out):: DateTime(8)
    
    integer(kind=4):: DD, hh, mm, ss, ms
    integer(kind=8):: in8temp
    
    DateTime = 0
    if (msTime == 0) then
        return
    else if (msTime > 0) then
        ms = mod(msTime, 1000)
        DateTime(8) = ms
        in8temp = msTime / 1000
        if (in8temp == 0) then
            return
        else
            ss = mod(in8temp, 60)
            DateTime(7) = ss
            in8temp = in8temp / 60
            if (in8temp == 0) then
                return
            else
                mm = mod(in8temp, 60)
                DateTime(6) = mm
                in8temp = in8temp / 60
                if (in8temp == 0) then
                    return
                else
                    hh = mod(in8temp, 24)
                    DateTime(5) = hh
                    in8temp = in8temp / 24
                    if (in8temp == 0) then
                        return
                    else
                        dd = in8temp
                        DateTime(3) = dd
                        return
                    end if
                end if
            end if
        end if
    else
        error stop "msTime < 0"
    end if
    
    return
    end subroutine sub_msTime2DateTime
    
    
    ! 利用date_and_time([date,time,zone,values])中的values(1:8)计算所用时间
    subroutine sub02_msUsedTime(DateTime1, DateTime2, msUsedTime)
    implicit none
    integer(kind=4), intent(in):: DateTime1(8), DateTime2(8)
    integer(kind=8), intent(out):: msUsedTime
    
    integer(kind=8):: msUTCtime1, msUTCtime2
    
    msUsedTime = 0
    if (all(DateTime1 == DateTime2)) return
    
    call sub_DateTime2msUTCtime(DateTime1, msUTCtime1)
    call sub_DateTime2msUTCtime(DateTime2, msUTCtime2)
    
    msUsedTime = msUTCtime2 - msUTCtime1
    
    return
    end subroutine sub02_msUsedTime
    
    
    ! 从(+00:00 2026/01/01 00:00:00.000)开始计算
    subroutine sub_DateTime2msUTCtime(DateTime, msUTCtime)
    implicit none 
    integer(kind=4), intent(in):: DateTime(8)
    integer(kind=8), intent(out):: msUTCtime
    
    integer(kind=4):: dateINmonth(12) = (/ 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 /)
    integer(kind=4):: YY, Mo, DD, zone, hh, mm, ss, ms, i
    integer(kind=8):: int8hh, int8mm, int8ss
    
    YY = DateTime(1)
    Mo = DateTime(2)
    DD = DateTime(3)
    zone = DateTime(4)
    hh = DateTime(5)
    mm = DateTime(6)
    ss = DateTime(7)
    ms = DateTime(8)
    
    if (((mod(YY, 4) == 0) .and. (mod(YY, 100) /= 0)) .or. (mod(YY, 400) == 0)) dateINmonth(2) = 29

    do i = 1, (Mo - 1), 1
        DD = DD + dateINmonth(i)
    end do
    
    do i = 2026, (YY - 1), 1
        if (((mod(i, 4) == 0) .and. (mod(i, 100) /= 0)) .or. (mod(i, 400) == 0)) then
            DD = DD + 366
        else
            DD = DD + 365
        end if
    end do
    
    int8hh = DD * 24 + hh
    int8mm = int8hh * 60 + mm - zone
    int8ss = int8mm * 60 + ss
    msUTCtime = int8ss * 1000 + ms
    
    return
    end subroutine sub_DateTime2msUTCtime