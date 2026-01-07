
    subroutine sub_test
    !implicit none
    !character(len=256):: dirname = "dir01/"    
    !call sub_mkdir(dirname)
    !integer(kind=4):: zone = 0
    !character(len=6):: str_zone
    !call sub_zone2str(zone, str_zone)
    !character(len=32):: str_DateTime
    !call sub_DateTime2str(str_DateTime)
    !print *, str_DateTime
    
    !character(len=12):: char_date, char_time, char_zone
    !integer(kind=4):: DateTime(8)
    !integer(kind=8):: msUTCtime
    !call date_and_time(char_date, char_time, char_zone, DateTime)
    !call sub_DateTime2msUTCtime(DateTime, msUTCtime)
    !character(len=12):: char_date, char_time, char_zone
    !integer(kind=4):: DateTime1(8), DateTime2(8), i
    !integer(kind=8):: msUsedTime
    !call date_and_time(char_date, char_time, char_zone, DateTime1)
    !call date_and_time(char_date, char_time, char_zone, DateTime2)
    !call sub02_msUsedTime(DateTime1, DateTime2, msUsedTime)
    
    !integer(kind=4):: DateTime(8)
    !integer(kind=8):: msTime = 86400000*1000-1
    !call sub_msTime2DateTime(msTime, DateTime)
    !character(len=12):: char_date, char_time, char_zone
    !integer(kind=4):: DateTime1(8), DateTime2(8)
    !integer(kind=8):: msUsedTime
    !character(len=35):: str_msTime
    !call date_and_time(char_date, char_time, char_zone, DateTime1)
    !call date_and_time(char_date, char_time, char_zone, DateTime2)
    !call sub02_msUsedTime(DateTime1, DateTime2, msUsedTime)
    !call sub_msTime2str(msUsedTime, str_msTime)
    
    !character(len=256):: DirName = "dir01/", LogName = "log.txt", str = ' '
    !call sub_mkdir(DirName)
    !LogName = trim(DirName) // trim(LogName)
    !str = "第一行记录"
    !call sub_Logging(LogName, str)
    !str = "第二行记录"
    !call sub_Logging(LogName, str)
    
    !integer(kind=4):: nums(4) = (/ 1, 2, 3, 4 /), targ = 3, inde(2)
    !call sub_twosum(size(nums), nums, targ, inde)
    !use mod_LeeCode001
    !integer(kind=4):: l1(7) = (/ 9, 9, 9, 9, 9, 9, 9 /), l2(4) = (/ 9, 9, 9, 9 /)
    !integer(kind=4), allocatable:: l3(:)
    !call sub_addTwoNumbers(size(l1), l1, size(l2), l2, l3)
    
    !use mod_LeeCode001
    !character(len=6):: s = "pwwkew"
    !integer(kind=4):: n
    !call sub_lengthOfLongestSubstring(s, n)
    !print *, n
    
    use mod_LeeCode001
    integer(kind=4):: nums1(5) = (/ 1, 4, 5, 6, 7/), nums2(2) = (/ 2, 3 /)
    real(kind=8):: mid
    call sub_findMedianSortedArrays(size(nums1), nums1, size(nums2), nums2, mid)
    print *, mid
    
    return
    end subroutine sub_test