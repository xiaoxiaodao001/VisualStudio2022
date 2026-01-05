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

**个人答案**
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

