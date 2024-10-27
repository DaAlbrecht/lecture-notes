from typing import List

def merge_sort(nums: List[int]) -> List[int]:
    temp = []
    if len(nums) == 1:
        return nums

    left, right = nums[:len(nums)//2], nums[len(nums)//2:]
    left = merge_sort(left)
    right = merge_sort(right)
    temp = merge(left, right) 
    return temp




def merge(left: List[int], right: List[int]) -> List[int]:
    new_list = []
    while left and right:
        if left[0] < right[0]:
            new_list.append(left.pop(0))
        else:
            new_list.append(right.pop(0))
    while left:
        new_list.append(left.pop(0))
    while right:
        new_list.append(right.pop(0))
    return new_list




if __name__ == "__main__":
    nums = [4,2,1,3,5,6,7,8]
    print(merge_sort(nums))
