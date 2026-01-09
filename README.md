# VisualStudio2022
这是我个人的VisualStudio2022学习项目。  
目前用于测试Fortran代码是否可行，以及新代码的编写，算法的学习。
## Fortran关键词intel帮助文档
### 1 `adjustl`
**Elemental Intrinsic Function (Generic)** 
: Adjusts a character string to the left
, removing leading blanks and inserting trailing blanks.
```fortran
result = ADJUSTL (string)
```
`string` (Input) Must be of type character.  
`results` The result type is character with the same length and kind parameter as string.
The value of the result is the same as string,
except that any leading blanks have been removed and inserted as trailing blanks.  

Example
```
CHARACTER(16) STRING 
STRING= ADJUSTL('   Fortran 90   ') ! returns 'Fortran 90      '

ADJUSTL ('    SUMMERTIME')     ! has the value 'SUMMERTIME    '
```
### 2 `NameList`
**Statement** :
Associates a name with a list of variables.
This group name can be referenced in some input/output operations.  
```fortran
NAMELIST /group/ var-list[[,] /group/ var-list]...
```
| group | Is the name of the group. |  
| var-list | Is a list of variables (separated by commas)
that are to be associated with the preceding group name.
The variables can be of any data type. |

**Description**
The namelist group name is used by namelist I/O statements instead of an I/O list. 
The unique group name identifies a list whose entities can be modified or transferred.

A variable can appear in more than one namelist group.

Each variable in var-list must be accessed by use or host association, 
or it must have its type, type parameters, 
and shape explicitly or implicitly specified in the same scoping unit. 
If the variable is implicitly typed, 
it can appear in a subsequent type declaration only if that declaration confirms the implicit typing.

You cannot specify an assumed-size array in a namelist group.

Only the variables specified in the namelist can be read or written in namelist I/O. 
It is not necessary for the input records in a namelist input statement to define every variable in the associated namelist.

The order of variables in the namelist controls the order in which the values appear on namelist output. 
Input of namelist values can be in any order.

If the group name has the PUBLIC attribute, 
no item in the variable list can have the PRIVATE attribute.

The group name can be specified in more than one NAMELIST statement in a scoping unit. 
The variable list following each successive appearance of the group name is treated as a continuation of the list for that group name.

**Example**
In the following example, D and E are added to the variables A, B, and C for group name LIST:
```fortran
NAMELIST /LIST/ A, B, C

NAMELIST /LIST/ D, E
```
In the following example, two group names are defined:
```fortran
CHARACTER*30 NAME(25)
NAMELIST /INPUT/ NAME, GRADE, DATE /OUTPUT/ TOTAL, NAME
```
Group name INPUT contains variables NAME, GRADE, and DATE. Group name OUTPUT contains variables TOTAL and NAME.

The following shows another example:
```fortran
 NAMELIST /example/ i1, l1, r4, r8, z8, z16, c1, c10, iarray
 ! The corresponding input statements could be:
 &example
 i1  = 11
 l1  = .TRUE.
 r4  = 24.0
 r8  = 28.0d0
 z8  = (38.0, 0.0)
 z16 = (316.0d0, 0.0d0)
 c1  = 'A'
 c10 = 'abcdefghij'
 iarray(8) = 41, 42, 43
 /
```
A sample program, NAMELIST.F90, is included in the \<install-dir>/samples subdirectory.
## 力扣100
### 1 两数之和
给定一个整数数组`nums`和一个整数目标值`target`，
请你在该数组中找出`和`为目标值`target`的那`两个`整数，
并返回它们的数组下标。  

你可以假设每种输入只会对应一个答案，并且你不能使用两次相同的元素。  

你可以按任意顺序返回答案。  

示例 1：
```
输入：nums = [2,7,11,15], target = 9
输出：[0,1]
解释：因为 nums[0] + nums[1] == 9 ，返回 [0, 1] 。
```

示例 2：
```
输入：nums = [3,2,4], target = 6
输出：[1,2]
```

示例 3：
```
输入：nums = [3,3], target = 6
输出：[0,1]
```

提示
- ` 2 <= nums.length <= 10^4 `
- ` -10^9 <= nums[i] <= 10^9 `
- ` -10^9 <= target <= 10^9 `
- **只会存在一个有效答案**

进阶：你可以想出一个时间复杂度小于 O(n^2^) 的算法吗？

**我的答案**
```fortran

    integer(kind=4):: nums(4) = (/ 1, 2, 3, 4 /), targ = 3, inde(2)
    call sub_twosum(size(nums), nums, targ, inde)

    subroutine sub_twosum(n, nums, targ, inde)
    implicit none
    integer(kind=4), intent(in):: n, nums(n), targ
    integer(kind=4), intent(out):: inde(2)
    integer(kind=4):: i, j

    inde = 0
    do i = 1, n, 1
        do j = i+1, n, 1
            if (targ == (nums(i) + nums(j))) then
                inde = [i, j]
                return
            end if
        end do
    end do
    
    return
    end subroutine sub_twosum
```
### 2 两数相加
给你两个`非空`的链表，表示两个非负的整数。它们每位数字都是按照`逆序`的方式存储的，并且每个节点只能存储`一位`数字。  
请你将两个数相加，并以相同形式返回一个表示和的链表。  
你可以假设除了数字 0 之外，这两个数都不会以 0 开头。  

**示例1**  

![](./images/Leecode002_addtwonumber1.jpg)  
>输入：l1 = [2,4,3], l2 = [5,6,4]  
输出：[7,0,8]  
解释：342 + 465 = 807.

**示例2**  
>输入：l1 = [0], l2 = [0]  
输出：[0]  

**示例3**  
>输入：l1 = [9,9,9,9,9,9,9], l2 = [9,9,9,9]  
输出：[8,9,9,9,0,0,0,1]  

**提示**：  
- 每个链表中的节点数在范围`[1, 100]`内  
- ` 0 <= Node.val <= 9 `  
- 题目数据保证列表表示的数字不含前导零  

**我的答案**
```fortran

    use mod_LeeCode001
    integer(kind=4):: l1(7) = (/ 9, 9, 9, 9, 9, 9, 9 /), l2(4) = (/ 9, 9, 9, 9 /)
    integer(kind=4), allocatable:: l3(:)
    call sub_addTwoNumbers(size(l1), l1, size(l2), l2, l3)



    module mod_LeeCode001
    implicit none
    contains

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
    
    end module mod_LeeCode001
```

### 3 无重复字符的最长子串
给定一个字符串`s`，请你找出其中不含有重复字符的**最长**
[子串](https://github.com "**子字符串** 是字符串中连续的**非空**字符序列") 的长度。  

示例1
>输入: s = "abcabcbb"  
输出: 3  
解释: 因为无重复字符的最长子串是 "abc"，所以其长度为 3。注意 "bca" 和 "cab" 也是正确答案。 

示例2
>输入: s = "bbbbb"  
输出: 1  
解释: 因为无重复字符的最长子串是 "b"，所以其长度为 1。  

示例3
>输入: s = "pwwkew"  
输出: 3  
解释: 因为无重复字符的最长子串是`"wke"`，所以其长度为 3。  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
请注意，你的答案必须是**子串**的长度，`"pwke"` 是一个子序列，不是子串。  

提示：
* `0 <= s.length <= 5 * 10^4`
* `s` 由英文字母、数字、符号和空格组成  

我的答案
```fortran
    use mod_LeeCode001
    character(len=6):: s = "pwwkew"
    integer(kind=4):: n
    call sub_lengthOfLongestSubstring(s, n)
    print *, n            


    module mod_LeeCode001
    implicit none
    contains
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
    
    end module mod_LeeCode001

```

### 4 寻找两个正序数组的中位数
给定两个大小分别为`m`和`n`的正序（从小到大）数组`nums1`和`nums2`。请你找出并返回这两个正序数组的**中位数**。  

算法的时间复杂度应该为`O(log (m+n))`。  

示例1  
>**输入**：nums1 = [1,3], nums2 = [2]  
**输出**：2.00000  
**解释**：合并数组 = [1,2,3] ，中位数 2  

示例2  
>**输入**：nums1 = [1,2], nums2 = [3,4]  
**输出**：2.50000  
**解释**：合并数组 = [1,2,3,4] ，中位数 (2 + 3) / 2 = 2.5  

提示：  
- `nums1.length == m`
- `nums2.length == n`
- `0 <= m <= 1000`
- `0 <= n <= 1000`
- `1 <= m + n <= 2000`
- `-10^6 <= nums1[i], nums2[i] <= 10^6`

我的答案
```fortran
    use mod_LeeCode001
    integer(kind=4):: nums1(5) = (/ 1, 4, 5, 6, 7/), nums2(2) = (/ 2, 3 /)
    real(kind=8):: mid
    call sub_findMedianSortedArrays(size(nums1), nums1, size(nums2), nums2, mid)
    print *, mid

    module mod_LeeCode001
    implicit none
    contains
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
```

### 5 最长回文子串
给你一个字符串`s`，找到`s`中最长的
[回文](https://leetcode.cn/ "回文性：如果字符向前和向后读都相同，则它满足回文性")
[子串](https://leetcode.cn/ "子字符串是字符串中连续的 非空 字符序列")。  
示例 1：
>输入：s = "babad"  
输出："bab"  
解释："aba" 同样是符合题意的答案。  

示例 2：
>输入：s = "cbbd"  
输出："bb"  

提示：  
- `1 <= s.length <= 1000`  
- `s`仅由数字和英文字母组成  

我的答案
```fortran
    
    use mod_LeeCode001
    character(len=256):: s = 'cbbd'
    character(len=:), allocatable:: subPs
    
    call sub_longestPalindrome(trim(s), subPs)
    print *, subPs



    module mod_LeeCode001
    implicit none
    contains
        
        subroutine sub_longestPalindrome(s, subPs)
        implicit none
        character(len=*), intent(in):: s
        character(len=:), allocatable, intent(out):: subPs
        
        character(len=:), allocatable:: temp
        integer(kind=4):: i, j, slen, sublen, k, lenmid, i1, j1, len1, len2
        
        slen = len(s)
        i1 = 1
        j1 = 1
        len1 = 1
        do i = 1, slen, 1
            do j = slen, i, -1
                sublen = j - i + 1
                lenmid = sublen / 2
                k = 0
                do while(k < lenmid)
                    if (s(i+k : i+k) == s(j-k : j-k)) then
                        k = k + 1
                    else
                        exit
                    end if                    
                end do
                if (k == lenmid) then
                    len2 = sublen
                    if (len2 > len1) then
                        len1 = len2
                        i1 = i
                        j1 = j
                    end if
                    if (len1 > (slen-i+1)) exit
                else
                    cycle
                end if                
            end do
        end do
        subPs = s(i1 : j1)
        
        return
        end subroutine sub_longestPalindrome
    
    end module mod_LeeCode001
```

### 6 Z字形变换  
将一个给定字符串`s`根据给定的行数`numRows`，以从上往下、从左到右进行Z字形排列。  

比如输入字符串为`"PAYPALISHIRING"`行数为`3`时，排列如下：  
>P   A   H   N  
A P L S I I G  
Y   I   R  

之后，你的输出需要从左往右逐行读取，产生出一个新的字符串，比如：`"PAHNAPLSIIGYIR"`。  

请你实现这个将字符串进行指定行数变换的函数：  
>string convert(string s, int numRows);  

**示例 1：**  
>输入：s = "PAYPALISHIRING", numRows = 3  
输出："PAHNAPLSIIGYIR"  

**示例 2：**  
>输入：s = "PAYPALISHIRING", numRows = 4  
输出："PINALSIGYAHRPI"  
解释：  
P     I    N  
A   L S  I G  
Y A   H R  
P     I  

**示例 3：**  
>输入：s = "A", numRows = 1  
输出："A"  

**提示：**  
- `1 <= s.length <= 1000`  
- `s` 由英文字母（小写和大写）、`','`和`'.'`组成  
- `1 <= numRows <= 1000`  

我的答案
```fortran
    
    use mod_LeeCode001
    character(len=256):: s = 'PAYPALISHIRING', sNew = ' '
    integer(kind=4):: numRows = 4
    
    call sub_convert(trim(s), numRows, sNew)
    print *, trim(sNew)



    module mod_LeeCode001
    implicit none
    contains
        
        subroutine sub_convert(s, numRows, sNew)
        character(len=*), intent(in):: s
        integer(kind=4), intent(in):: numRows
        character(len=len(s)), intent(out):: sNew
        
        integer(kind=4):: i, ind, slen, indNew, T, T1, T2
        
        slen = len(s)
        if (numRows == 1) then
            sNew = s
            return
        end if
        
        T = numRows + numRows - 2
        indNew = 0
        i = 1
        ind = i
        do while(ind <= slen)
            indNew = indNew + 1
            sNew(indNew : indNew) = s(ind : ind)
            ind = ind + T
        end do
        do i = 2, numRows-1, 1
            ind = i
            T2 = i + i - 2
            T1 = T - T2
            do while(ind <= slen)
                indNew = indNew + 1
                sNew(indNew : indNew) = s(ind : ind)
                ind = ind + T1
                if (ind <= slen) then
                    indNew = indNew + 1
                    sNew(indNew : indNew) = s(ind : ind)
                    ind = ind + T2
                end if
            end do
        end do
        i = numRows
        ind = i
        do while(ind <= slen)
            indNew = indNew + 1
            sNew(indNew : indNew) = s(ind : ind)
            ind = ind + T
        end do
        
        return
        end subroutine sub_convert
    
    end module mod_LeeCode001  
```

### 7 整数反转  
给你一个 32 位的有符号整数`x`，返回将`x`中的数字部分反转后的结果。  

如果反转后整数超过 32 位的有符号整数的范围`[−2^31,  2^31 − 1]`，就返回 0。  

**假设环境不允许存储 64 位整数（有符号或无符号）。**  

示例 1：  
>输入：x = 123  
输出：321  

示例 2：  
>输入：x = -123  
输出：-321  

示例 3：  
>输入：x = 120  
输出：21  

示例 4：  
>输入：x = 0  
输出：0  

提示：  
- `-2^31 <= x <= 2^31 - 1`  

我的答案
```fortran
    use mod_LeeCode001
    integer(kind=4):: x = -huge(1)-1, xr
    call sub_reverse(x, xr)
    print *, xr



    module mod_LeeCode001
    implicit none
    contains
        
        subroutine sub_reverse(x, xr)
        implicit none
        integer(kind=4), intent(in):: x
        integer(kind=4), intent(out):: xr
        
        integer(kind=4):: xi, int4 = 1
        integer(kind=8):: xabs, temp, xrtemp
        
        xr = 0
        if (x == 0) return
        
        xabs = abs(int(x, kind=8))
        temp = xabs
        xrtemp = 0
        do while(temp > 0)
            xi = mod(temp, 10)
            temp = temp / 10
            xrtemp = xrtemp * 10 + xi
        end do
        xrtemp = sign(xrtemp, x)
        
        if (((-huge(int4)-1) <= xrtemp) .and. (xrtemp <= huge(int4))) xr = xrtemp
        
        return
        end subroutine sub_reverse
    
    end module mod_LeeCode001
```

### 8 字符串转换整数 (atoi)  
请你来实现一个`myAtoi(string s)`函数，使其能将字符串转换成一个 32 位有符号整数。  

函数`myAtoi(string s)`的算法如下：  

1. 空格：读入字符串并丢弃无用的前导空格（`" "`）  
2. 符号：检查下一个字符（假设还未到字符末尾）为`'-'`还是`'+'`。如果两者都不存在，则假定结果为正。  
3. 转换：通过跳过前置零来读取该整数，直到遇到非数字字符或到达字符串的结尾。如果没有读取数字，则结果为0。  
4. 舍入：如果整数数超过 32 位有符号整数范围`[−2^31,  2^31 − 1]`，需要截断这个整数，使其保持在这个范围内。
具体来说，小于`−2^31`的整数应该被舍入为`−2^31`，大于`2^31 − 1`的整数应该被舍入为`2^31 − 1`。  

返回整数作为最终结果。  

**示例 1**：  
>输入：s = "42"  
输出：42  
解释：加粗的字符串为已经读入的字符，插入符号是当前读取的字符。  
带下划线线的字符是所读的内容，插入符号是当前读入位置。  
第 1 步："42"（当前没有读入字符，因为没有前导空格）  
&emsp;&emsp;&emsp;&emsp;&ensp;^  
第 2 步："42"（当前没有读入字符，因为这里不存在 '-' 或者 '+'）  
&emsp;&emsp;&emsp;&emsp;&ensp;^  
第 3 步："42"（读入 "42"）  
&emsp;&emsp;&emsp;&emsp;&emsp;^  

**示例 2**： 
>输入：s = " -042"  
输出：-42  
解释：  
第 1 步："<u>&ensp;&ensp;&ensp;</u>-042"（读入前导空格，但忽视掉）  
&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;^  
第 2 步："&ensp;&ensp;&ensp;<u>-</u>042"（读入 '-' 字符，所以结果应该是负数）  
&emsp;&emsp;&emsp;&emsp;&emsp;&emsp; ^  
第 3 步："&ensp;&ensp;&ensp;<u>-042</u>"（读入 "042"，在结果中忽略前导零）  
&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&ensp;^  

**示例 3**：  
>输入：s = "1337c0d3"  
输出：1337  
解释：  
第 1 步："1337c0d3"（当前没有读入字符，因为没有前导空格）  
&emsp;&emsp;&emsp;&emsp;&ensp;^  
第 2 步："1337c0d3"（当前没有读入字符，因为这里不存在 '-' 或者 '+'）  
&emsp;&emsp;&emsp;&emsp;&ensp;^  
第 3 步："1337c0d3"（读入 "1337"；由于下一个字符不是一个数字，所以读入停止）  
&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&ensp;^  

**示例 4**：  
>输入：s = "0-1"  
输出：0  
解释：  
第 1 步："0-1" (当前没有读入字符，因为没有前导空格)  
&emsp;&emsp;&emsp;&emsp;&ensp;^  
第 2 步："0-1" (当前没有读入字符，因为这里不存在 '-' 或者 '+')  
&emsp;&emsp;&emsp;&emsp;&ensp;^  
第 3 步："<u>0</u>-1" (读入 "0"；由于下一个字符不是一个数字，所以读入停止)  
&emsp;&emsp;&emsp;&emsp;&emsp;^  

**示例 5**：  
>输入：s = "words and 987"  
输出：0  
解释：  
读取在第一个非数字字符“w”处停止。   

提示：  

- `0 <= s.length <= 200`  
- `s`由英文字母（大写和小写）、数字（`0-9`）、`' '`、`'+'`、`'-'`和`'.'`组成  

```fortran

    use mod_LeeCode001
    character(len=200):: s1 = "42"
    character(len=200):: s2 = " -042"
    character(len=200):: s3 = "1337c0d3"
    character(len=200):: s4 = "0-1"
    character(len=200):: s5 = "words and 987"
    integer(kind=4):: x
    call sub_myAtoi(s1, x)
    print *, x
    call sub_myAtoi(s2, x)
    print *, x
    call sub_myAtoi(s3, x)
    print *, x
    call sub_myAtoi(s4, x)
    print *, x
    call sub_myAtoi(s5, x)
    print *, x    



    module mod_LeeCode001
    implicit none
    contains
        
        subroutine sub_myAtoi(s, x)
        character(len=*), intent(in):: s
        integer(kind=4), intent(out):: x
        
        character(len=1):: si = ' '
        integer(kind=4):: slen, i, int4 = 1, xi, xsign, ichar_0
        integer(kind=8):: temp, int4huge
        
        x = 0
        slen = len(s)
        if (slen == 0) return
        ! char, ichar
        i = 0
        do while ((si == ' ') .and. (i < slen))
            i = i + 1
            si = s(i:i)
        end do
        
        xsign = 1
        if (si == '-') then
            xsign = -1
            i = i + 1
            if (i <= slen) then
                si = s(i:i)
            else
                return
            end if
        end if
        if (si == '+') then
            i = i + 1
            if (i <= slen) then
                si = s(i:i)
            else
                return
            end if
        end if
        int4huge = huge(int4)
        ichar_0 = ichar('0')
        do while ((si == '0') .and. (i < slen))
            i = i + 1
            si = s(i:i)
        end do
        
        temp = 0        
        do while (('0' <= si) .and. (si <= '9') .and. (i < slen))
            xi = ichar(si) - ichar_0
            temp = temp * 10 + xi
            if (temp > (int4huge + 1)) exit
            i = i + 1
            si = s(i:i)
        end do
        temp = temp * xsign
        if (temp < -int4huge-1) then
            x = -int4huge-1
        else if (temp > int4huge) then 
            x = int4huge
        else 
            x = temp
        end if
        
        return
        end subroutine sub_myAtoi
    
    end module mod_LeeCode001
```

### 9 回文数  
给你一个整数`x`，如果`x`是一个回文整数，返回`true`；否则，返回`false`。  

[回文数](https://leetcode.cn/ "是指正序（从左向右）和倒序（从右向左）读都是一样的整数。")
是指正序（从左向右）和倒序（从右向左）读都是一样的整数。  

例如，`121`是回文，而`123`不是。  

**示例 1**：  
>输入：x = 121  
输出：true  

**示例 2**：
>输入：x = -121  
输出：false  
解释：从左向右读, 为 -121 。 从右向左读, 为 121- 。因此它不是一个回文数。  

**示例 3**：
>输入：x = 10  
输出：false  
解释：从右向左读, 为 01 。因此它不是一个回文数。  

提示：  
- `-2^31 <= x <= 2^31 - 1`  

**进阶**：你能不将整数转为字符串来解决这个问题吗？  

我的答案：
```fortran
    use mod_LeeCode001
    integer(kind=4):: x = 1234
    logical(kind=4):: ISorNOT
    call sub_isPalindrome(x, ISorNOT)
    print *, ISorNOT



    module mod_LeeCode001
    implicit none
    contains
        
        subroutine sub_isPalindrome(x, ISorNOT)
        implicit none
        integer(kind=4), intent(in):: x
        logical(kind=4), intent(out):: ISorNOT
        
        integer(kind=4):: xi(10), i, temp
        
        ISorNOT = .false.
        if (x < 0) return
        if ((0 <= x) .and. (x <= 9)) then
            ISorNOT = .true.
            return
        end if
        
        temp = x
        i = 0
        do while(temp > 0)
            i = i + 1
            xi(i) = mod(temp, 10)
            temp = temp / 10
        end do
        
        if (all(xi(1 : i) == xi (i : 1 : -1))) then
            ISorNOT = .true.
            return
        end if
        
        return
        end subroutine sub_isPalindrome
    
    end module mod_LeeCode001

```
