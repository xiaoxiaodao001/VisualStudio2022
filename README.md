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

### 3 `transfer`  
**Transformational Intrinsic Function (Generic)**: 
Converts the bit pattern of the first argument according to the type and kind parameters of the second argument.  

result = TRANSFER (source,mold[,size])  

| source | (Input) Must be a scalar or array (of any data type). |  
| mold | (Input) Must be a scalar or array (of any data type). It provides the type characteristics (not a value) for the result. |  
| size | (Input; optional) Must be scalar and of type integer. It provides the number of elements for the output result. |  

**Results**  
The result has the same type and type parameters as mold.  
If mold is a scalar and size is omitted, the result is a scalar.  
If mold is an array and size is omitted, the result is a rank-one array.
Its size is the smallest that is possible to hold all of source.  
If size is present, the result is a rank-one array of size size.  
When the size of source is greater than zero, mold must not be an array with elements of size zero.  
If the internal representation of the result occupies m bits, 
and the internal representation of source occupies n bits, 
then if m > n, the right-most src bits of result contain the bit pattern contained in source, 
and the m minus n left-most bits of result are undefined. 
If m < n, then result contains the bit pattern of the right-most m bits of source, 
and the left-most n minus m bits of source are ignored. 
Otherwise, the result contains the bit pattern contained in source.  

**Example**  
TRANSFER (1082130432, 0.0) has the value 4.0 
(on processors that represent the values 4.0 and 1082130432 as the string of binary digits 0100 0000 1000 0000 0000 0000 0000 0000).  
TRANSFER ((/2.2, 3.3, 4.4/), ((0.0, 0.0))) results in a scalar whose value is (2.2, 3.3).  
TRANSFER ((/2.2, 3.3, 4.4/), (/(0.0, 0.0)/)) results in a complex rank-one array of length 2. 
Its first element is (2.2,3.3) and its second element has a real part with the value 4.4 and an undefined imaginary part.  
TRANSFER ((/2.2, 3.3, 4.4/), (/(0.0, 0.0)/), 1) results in a complex rank-one array having one element with the value (2.2, 3.3).  

The following shows another example:  
```fortran
 COMPLEX CVECTOR(2), CX(1)
 !  The next statement sets CVECTOR to
 !  [ 1.1 + 2.2i, 3.3 + 0.0i ]
 CVECTOR = TRANSFER((/1.1, 2.2, 3.3, 0.0/), &
                    (/(0.0, 0.0)/))
 !  The next statement sets CX to [ 1.1 + 2.2i ]
 CX = TRANSFER((/1.1, 2.2, 3.3/) , (/(0.0, 0.0)/), &
               SIZE= 1)
 WRITE(*,*) CVECTOR
 WRITE(*,*) CX
 END
 ```
 The following example shows an error because the source size is greater than zero 
 but mold is an array whose elements have zero size:  
 ```fortran
CHARACTER(0),PARAMETER :: nothing1(100) = '' 
PRINT *,SIZE(TRANSFER(111014,nothing1))         ! error
...
 ```


## 力扣100  
先不追求高级算法，用自己的笨方法做一遍  
### 11 盛最多水的容器  
给定一个长度为`n`的整数数组`height`。有`n`条垂线，第`i`条线的两个端点是`(i, 0)`和`(i, height[i])`。  
找出其中的两条线，使得它们与`x`轴共同构成的容器可以容纳最多的水。  
返回容器可以储存的最大水量。  
说明：你不能倾斜容器。   

**示例 1**：  

![](./images/Leecode0011_maxArea1.jpg)  
>输入：[1,8,6,2,5,4,8,3,7]  
输出：49  
解释：图中垂直线代表输入数组 [1,8,6,2,5,4,8,3,7]。
在此情况下，容器能够容纳水（表示为蓝色部分）的最大值为 49。  

**示例 2**：  
>输入：height = [1,1]  
输出：1  

提示：
- `n == height.length`
- `2 <= n <= 105`
- `0 <= height[i] <= 104`

我的答案  
```fortran
    use mod_LeeCode0011
    integer(kind=4):: a(4) = (/ 2, 2, 2, 2 /), maxArea
    call sub_maxArea(size(a), a, maxArea)
    print *, maxArea



    module mod_LeeCode0011
    implicit none
    contains
    
        subroutine sub_maxArea(n, height, maxArea)
        implicit none
        integer(kind=4), intent(in):: n, height(n)
        integer(kind=4), intent(out):: maxArea
        
        integer(kind=4):: i, j, temp
        
        maxArea = (n - 1) * min(height(1), height(n))
        do i = 1, n-1, 1
            do j = n, i+1, -1
                temp = (j - i) * min(height(i), height(j))
                maxArea = max(maxArea, temp)
            end do
        end do
                        
        return
        end subroutine sub_maxArea
    
    end module mod_LeeCode0011
```

### 12 整数转罗马数字  
七个不同的符号代表罗马数字，其值如下：  

| 符号 | 值 |  
| === | === |  
| I | 1 |  
| V | | 5 |  
| X | 10 |  
| L | 50 |  
| C | 100 |  
| D | 500 |  
| M | 1000 |  

罗马数字是通过添加从最高到最低的小数位值的转换而形成的。
将小数位值转换为罗马数字有以下规则：  
- 如果该值不是以 4 或 9 开头，请选择可以从输入中减去的最大值的符号，
将该符号附加到结果，减去其值，然后将其余部分转换为罗马数字。  
- 如果该值以 4 或 9 开头，使用 减法形式，表示从以下符号中减去一个符号，
例如 4 是 5 (`V`) 减 1 (`I`): `IV`，9 是 10 (`X`) 减 1 (`I`)：`IX`。
仅使用以下减法形式：4 (`IV`)，9 (`IX`)，40 (`XL`)，90 (`XC`)，400 (`CD`) 和 900 (`CM`)。  
- 只有 10 的次方（`I`, `X`, `C`, `M`）最多可以连续附加 3 次以代表 10 的倍数。
你不能多次附加 5 (`V`)，50 (`L`) 或 500 (`D`)。如果需要将符号附加4次，请使用 减法形式。  

给定一个整数，将其转换为罗马数字。  

**示例 1**：  
>输入：num = 3749  
输出： "MMMDCCXLIX"  
解释：  
3000 = MMM 由于 1000 (M) + 1000 (M) + 1000 (M)  
&ensp;700 = DCC 由于 500 (D) + 100 (C) + 100 (C)  
&ensp;&ensp;40 = XL 由于 50 (L) 减 10 (X)  
&ensp;&ensp;&ensp;9 = IX 由于 10 (X) 减 1 (I)  
注意：49 不是 50 (L) 减 1 (I) 因为转换是基于小数位  

**示例 2**：  
>输入：num = 58  
输出："LVIII"  
解释：  
50 = L  
8 = VIII  

**示例 3**：  
>输入：num = 1994  
输出："MCMXCIV"  
解释：  
1000 = M  
&ensp;900 = CM  
&ensp;&ensp;90 = XC  
&ensp;&ensp;&ensp;4 = IV  

提示：  
> `1 <= num <= 3999`
```fortran
    use mod_LeeCode0011
    integer(kind=4):: x = 1234
    character(len=:), allocatable:: xR
    call sub_intToRoman(x, xR)
    print *, xR



    module mod_LeeCode0011
    implicit none
    contains
    
        subroutine sub_intToRoman(x, xR)
        implicit none
        integer(kind=4), intent(in):: x
        character(len=:), allocatable, intent(out):: xR
        
        integer(kind=4):: xi(0:3), i, temp, j
        character(len=4):: xRi(0:9, 0:3) = ' '
        character(len=15):: xRtemp = ' '
        
        xRi(:, 0) = (/ '', 'I', 'II', 'III', 'IV', 'V', 'VI', 'VII', 'VIII', 'IX' /)
        xRi(:, 1) = (/ '', 'X', 'XX', 'XXX', 'XL', 'L', 'LX', 'LXX', 'LXXX', 'XC' /)
        xRi(:, 2) = (/ '', 'C', 'CC', 'CCC', 'CD', 'D', 'DC', 'DCC', 'DCCC', 'CM' /)
        xRi(0:3, 3) = (/ '', 'M', 'MM', 'MMM' /)
        temp = x
        i = -1
        do while(temp > 0)
            i = i + 1
            xi(i) = mod(temp, 10)
            temp = temp / 10
        end do
        do j = i, 0, -1
            xRtemp = trim(xRtemp) // trim(xRi(xi(j), j))
        end do
        xR = trim(xRtemp)
         
        return
        end subroutine sub_intToRoman
    
    end module mod_LeeCode0011
```
### 13 罗马数字转整数  
罗马数字包含以下七种字符:`I`，`V`，`X`，`L`，`C`，`D`和`M`。  

| 符号 | 值 |  
| === | === |  
| I | 1 |  
| V | | 5 |  
| X | 10 |  
| L | 50 |  
| C | 100 |  
| D | 500 |  
| M | 1000 |  

例如， 罗马数字`2`写做`II`，即为两个并列的`1`。`12`写做`XII`，即为`X`+`II`。`27`写做 `XXVII`, 即为`XX`+`V`+`II`。  

通常情况下，罗马数字中小的数字在大的数字的右边。但也存在特例，
例如`4`不写做`IIII`，而是`IV`。数字`1`在数字`5`的左边，所表示的数等于大数`5`减小数`1`得到的数值`4`。
同样地，数字`9`表示为`IX`。这个特殊的规则只适用于以下六种情况：  
- `I`可以放在`V`(5) 和`X`(10) 的左边，来表示`4`和`9`。  
- `X`可以放在`L`(50) 和`C`(100) 的左边，来表示`40`和`90`。  
- `C`可以放在`D`(500) 和`M`(1000) 的左边，来表示`400`和`900`。  
给定一个罗马数字，将其转换成整数。  

**示例 1**:  
>输入: s = "III"  
输出: 3  

**示例 2**:  
>输入: s = "IV"  
输出: 4  

**示例 3**:  
>输入: s = "IX"  
输出: 9  

**示例 4**:
>输入: s = "LVIII"  
输出: 58  
解释: L = 50, V= 5, III = 3.  

**示例 5**:
>输入: s = "MCMXCIV"  
输出: 1994  
解释: M = 1000, CM = 900, XC = 90, IV = 4.  

提示：  
- `1 <= s.length <= 15`  
- `s` 仅含字符 `('I', 'V', 'X', 'L', 'C', 'D', 'M')`  
- 题目数据保证 `s` 是一个有效的罗马数字，且表示整数在范围 `[1, 3999]` 内  
- 题目所给测试用例皆符合罗马数字书写规则，不会出现跨位等情况。  
- IL 和 IM 这样的例子并不符合题目要求，49 应该写作 XLIX，999 应该写作 CMXCIX 。  
- 关于罗马数字的详尽书写规则，可以参考
[罗马数字 - 百度百科](https://baike.baidu.com/item/%E7%BD%97%E9%A9%AC%E6%95%B0%E5%AD%97/772296)。  

我的答案：
```fortran
    
    use mod_LeeCode0011
    integer(kind=4):: x = 3749
    character(len=:), allocatable:: xR
    call sub_intToRoman(x, xR)
    print *, xR
    call sub_romanToInt(xR, x)
    print *, x
        
        
        
    module mod_LeeCode0011
    implicit none
    contains
    
        subroutine sub_romanToInt(xR, x)
        character(len=*), intent(in):: xR
        integer(kind=4), intent(out):: x
        
        character(len=4):: xRi(0:9, 0:3) =  (/ ' ', 'I', 'II', 'III', 'IV', 'V', 'VI', 'VII', 'VIII', 'IX', &
                                            ' ', 'X', 'XX', 'XXX', 'XL', 'L', 'LX', 'LXX', 'LXXX', 'XC', &
                                             ' ', 'C', 'CC', 'CCC', 'CD', 'D', 'DC', 'DCC', 'DCCC', 'CM', &
                                             ' ', 'M', 'MM', 'MMM', ' ', ' ', ' ', ' ', ' ', ' ' /)
        integer(kind=4):: i, i1, i2, xRlen, xRilen
        character(len=4):: xR3=' ', xR2=' ', xR1=' ', xR0=' ', xRin(4) = ' ', xRii
        
        i = 1
        i1 = i
        xRlen = len_trim(xR)
        do while(i <= xRlen)
            if (xR(i:i) == 'M') then
                i = i + 1
            else
                exit
            end if            
        end do
        i2 = i - 1
        xR3(1 : (i2-i1+1)) = xR(i1 : i2)
        
        do while(i <= xRlen)
            if ((xR(i:i) == 'C') .or. (xR(i:i) == 'D') .or. (xR(i:i) == 'M')) then
                i = i + 1
            else
                exit
            end if
        end do
        i1 = i2 + 1
        i2 = i - 1
        xR2(1 : (i2-i1+1)) = xR(i1 : i2)
        
        do while(i <= xRlen)
            if ((xR(i:i) == 'X') .or. (xR(i:i) == 'L') .or. (xR(i:i) == 'C')) then
                i = i + 1
            else
                exit
            end if
        end do
        i1 = i2 + 1
        i2 = i - 1
        xR1(1 : (i2-i1+1)) = xR(i1 : i2)
        
        do while(i <= xRlen)
            if ((xR(i:i) == 'I') .or. (xR(i:i) == 'V') .or. (xR(i:i) == 'X')) then
                i = i + 1
            else
                exit
            end if
        end do
        i1 = i2 + 1
        i2 = i - 1
        xR0(1 : (i2-i1+1)) = xR(i1 : i2)
        
        x = 0
        
        xRilen = len_trim(xR0)
        i = 1
        if (xRilen /= 0) then
            i = i + 1
            select case(xR0(1:1))
            case('I')
                x = x + 1
                do while(i <= xRilen)
                    select case(xR0(i:i))
                    case('I')
                        x = x + 1
                        i = i + 1
                    case('V')
                        x = x + 5 - 2
                        i = i + 1
                    case('X')
                        x = x + 10 - 2
                        i = i + 1
                    end select                    
                end do
            case('V')
                x = x + 5
                do while(i <= xRilen)
                    x = x + 1                  
                    i = i + 1
                end do
            end select
        end if
        
        xRilen = len_trim(xR1)
        i = 1
        if (xRilen /= 0) then
            i = i + 1
            select case(xR1(1:1))
            case('X')
                x = x + 10
                do while(i <= xRilen)
                    select case(xR1(i:i))
                    case('X')
                        x = x + 10
                        i = i + 1
                    case('L')
                        x = x + 50 - 20
                        i = i + 1
                    case('C')
                        x = x + 100 - 20
                        i = i + 1
                    end select                    
                end do
            case('L')
                x = x + 50
                do while(i <= xRilen)
                    x = x + 10                  
                    i = i + 1
                end do
            end select
        end if
        
        
        xRilen = len_trim(xR2)
        i = 1
        if (xRilen /= 0) then
            i = i + 1
            select case(xR2(1:1))
            case('C')
                x = x + 100
                do while(i <= xRilen)
                    select case(xR2(i:i))
                    case('C')
                        x = x + 100
                        i = i + 1
                    case('D')
                        x = x + 500 - 200
                        i = i + 1
                    case('M')
                        x = x + 1000 - 200
                        i = i + 1
                    end select                    
                end do
            case('D')
                x = x + 500
                do while(i <= xRilen)
                    x = x + 100                  
                    i = i + 1
                end do
            end select
        end if
        
        x = x + len_trim(xR3) * 1000
        
        return
        end subroutine sub_romanToInt
    
    end module mod_LeeCode0011
```

### 14 最长公共前缀  
编写一个函数来查找字符串数组中的最长公共前缀。  
如果不存在公共前缀，返回空字符串`""`。  

**示例 1**：  
>输入：strs = ["flower","flow","flight"]  
输出："fl"  

**示例 2**：  
>输入：strs = ["dog","racecar","car"]  
输出：""  
解释：输入不存在公共前缀。   

提示：  
- `1 <= strs.length <= 200`  
- `0 <= strs[i].length <= 200`  
- `strs[i]`如果非空，则仅由小写英文字母组成  

我的答案  
```fortran
    use mod_LeeCode0011
    character(len=200):: s1(3) = ["flower","flow","flight"], s2(3) = ["dog","racecar","car"]
    character(len=:), allocatable:: p
    call sub_longestCommonPrefix(size(s1), s1, p)
    print *, p
        
        
        
    module mod_LeeCode0011
    implicit none
    contains
    
        subroutine sub_longestCommonPrefix(n, s, p)
        integer(kind=4), intent(in):: n
        character(len=200), intent(in):: s(n)
        character(len=:), allocatable, intent(out):: p
        
        integer(kind=4):: silen(n), i, minsilen, j, plen
        character(len=1), allocatable:: temp(:, :)
        character(len=:), allocatable:: sitemp
        character(len=1):: p_i
        
        if (n == 1) then
            p = s(1)
            return
        end if
        
        minsilen = 200
        do i = 1, n, 1
            silen(i) = len_trim(s(i))
            minsilen = min(minsilen, silen(i))
        end do
        if (minsilen == 0) then
            p = ''
            return
        end if
        
        allocate(character(len=1):: temp(minsilen, n))
        allocate(character(len=minsilen):: sitemp)
        do j = 1, n, 1
            sitemp = s(j)
            do i = 1, minsilen, 1
                temp(i, j) = sitemp(i:i)
            end do            
        end do
        
        Loop1: do i = 1, minsilen, 1
            p_i = temp(i, 1)
            do j = 2, n, 1
                if (p_i /= temp(i, j)) then
                    exit Loop1
                end if
            end do
        end do Loop1
        plen = i - 1
        ! transfer:: p = transfer(temp(1:plen, 1), p)
        !p = sitemp(1 : plen)
        allocate(character(len=plen):: p)
        p = transfer(temp(1:plen, 1), p)
        
        return
        end subroutine sub_longestCommonPrefix
        
    
    end module mod_LeeCode0011
```

### 15 三数之和  
给你一个整数数组`nums`，判断是否存在三元组`[nums[i], nums[j], nums[k]]`满足`i != j`、`i != k`且`j != k`，
同时还满足`nums[i] + nums[j] + nums[k] == 0`。请你返回所有和为`0`且不重复的三元组。  
注意：答案中不可以包含重复的三元组。  

**示例 1**：  
>输入：nums = [-1,0,1,2,-1,-4]   
输出：[[-1,-1,2],[-1,0,1]]  
解释：   
nums[0] + nums[1] + nums[2] = (-1) + 0 + 1 = 0 。  
nums[1] + nums[2] + nums[4] = 0 + 1 + (-1) = 0 。  
nums[0] + nums[3] + nums[4] = (-1) + 2 + (-1) = 0 。  
不同的三元组是 [-1,0,1] 和 [-1,-1,2] 。  
注意，输出的顺序和三元组的顺序并不重要。  

**示例 2**：
>输入：nums = [0,1,1]  
输出：[]  
解释：唯一可能的三元组和不为 0 。  

**示例 3**：  
>输入：nums = [0,0,0]  
输出：[[0,0,0]]  
解释：唯一可能的三元组和为 0 。  

提示：
- `3 <= nums.length <= 3000`
- `-10^5 <= nums[i] <= 10^5`

```fortran    
    use mod_LeeCode0011
    integer(kind=4):: num(6) = [-1,0,1,2,-1,-4], i, num2(3)=[0,1,1], num3(3)= [0,0,0]
    integer(kind=4), allocatable:: threeSum(:, :)
    
    call sub_threeSum(size(num), num, threeSum)
    do i = 1, size(threeSum, 2), 1
        print *, threeSum(:, i)
    end do
    deallocate(threeSum)
    
    print *
    call sub_threeSum(size(num2), num2, threeSum)
    do i = 1, size(threeSum, 2), 1
        print *, threeSum(:, i)
    end do
    deallocate(threeSum)
    
    print *
    call sub_threeSum(size(num3), num3, threeSum)
    do i = 1, size(threeSum, 2), 1
        print *, threeSum(:, i)
    end do
    deallocate(threeSum)
        
        
        
    module mod_LeeCode0011
    implicit none
    contains

        subroutine sub_threeSum(n, num, threeSum)
        integer(kind=4), intent(in):: n, num(n)
        integer(kind=4), allocatable, intent(out):: threeSum(:, :)
        
        integer(kind=4):: i, j, k, numi, numj, numk, twosum, threeNum, count, numi1, numj1, numk1, tempi(3), count1, tempj(3)
        real(kind=8):: realthreeNum = 1.d0
        integer(kind=4), allocatable:: temp(:, :), threeNumi(:)
        
        if (n == 3) then
            if (sum(num) == 0) then
                allocate(threeSum(3, 1))
                threeSum(:, 1) = num
            else
                allocate(threeSum(3, 0))
            end if
            return
        end if
        i = min(3, n-3)
        do j = 1, i, 1
            realthreeNum = realthreeNum * real(n-i+j, kind=8) / real(j, kind=8)
        end do
        threeNum = int(realthreeNum)
        allocate(temp(3, threeNum))
        count = 0
        do i = 1, n-2, 1
            numi = num(i)
            twosum = 0 - numi
            do j = i+1, n-1, 1
                numj = num(j)
                numk = twosum - numj
                do k = j+1, n, 1
                    if (numk == num(k)) then
                        count = count + 1
                        numi1 = min(numi, numj, numk)
                        numk1 = max(numi, numj, numk)
                        numj1 = 0 - numi1 - numk1
                        temp(:, count) = [numi1, numj1, numk1]
                    end if
                end do
            end do
        end do
        if (count == 0) then
            allocate(threeSum(3, 0))
            return
        end if
        
        allocate(threeNumi(count))
        threeNumi = 1
        count1 = count
        do i = 1, count-1, 1
            if (threeNumi(i) == 0) cycle
            tempi = temp(:, i)
            do j = i+1, count, 1
                if (threeNumi(j) == 0) cycle
                tempj = temp(:, j)
                if (all(tempi == tempj)) then
                    count1 = count1 - 1
                    threeNumi(j) = 0
                end if
            end do
        end do
        allocate(threeSum(3, count1))
        j = 0
        do i = 1, count, 1
            if (threeNumi(i) == 1) then
                j = j + 1
                threeSum(:, j) = temp(:, i)
            end if
        end do
        
        return
        end subroutine sub_threeSum
        
    
    end module mod_LeeCode0011
```

### 16 最接近的三数之和  
给你一个长度为`n`的整数数组`nums`和 一个目标值`target`。
请你从`nums`中选出三个在**不同下标位置**的整数，使它们的和与`target`最接近。  
返回这三个数的和。  
假定每组输入只存在恰好一个解。  

**示例 1**：
>**输入**：nums = [-1,2,1,-4], target = 1  
**输出**：2  
**解释**：与 target 最接近的和是 2 (-1 + 2 + 1 = 2)。  

**示例 2**：
>**输入**：nums = [0,0,0], target = 1  
**输出**：0  
**解释**：与 target 最接近的和是 0（0 + 0 + 0 = 0）。  

提示：
- `3 <= nums.length <= 1000`  
- `-1000 <= nums[i] <= 1000`  
- `-10^4 <= target <= 10^4`  

```fortran    
    use mod_LeeCode0011
    integer(kind=4):: nums(4) = [-1, 2, 1, -4], targe = 1, threeSum, nums1(3)=0
    call sub_threeSumClosest(size(nums), nums, targe, threeSum)
    print *, threeSum
    call sub_threeSumClosest(size(nums1), nums1, targe, threeSum)
    print *, threeSum
        
        
        
    module mod_LeeCode0011
    implicit none
    contains

        subroutine sub_threeSumClosest(n, nums, targe, threeSum)
        integer(kind=4), intent(in):: n, nums(n), targe
        integer(kind=4), intent(out):: threeSum
        
        integer(kind=4):: i, j, k, numi, numj, numk, temp, disten1, disten2
        
        threeSum = sum(nums(1:3))
        
        if (n == 3) return
        disten1 = abs(threeSum - targe)
        do i = 1, n-2, 1
            numi = nums(i)
            do j = i+1, n-1, 1
                numj = nums(j)
                do k = j+1, n, 1
                    numk = nums(k)
                    temp = numi + numj + numk
                    disten2 = abs(temp - targe)
                    if (disten2 < disten1) then
                        disten1 = disten2
                        threeSum = temp
                    end if
                end do
            end do
        end do
        
        return
        end subroutine sub_threeSumClosest
    
    end module mod_LeeCode0011
```