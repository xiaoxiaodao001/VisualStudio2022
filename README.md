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


