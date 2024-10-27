from typing import List

def qs(nums: List[int], lo: int, hi: int):
    if lo >= hi:
        return nums
    pivot = partition(nums,lo,hi)
    qs(nums,lo,pivot -1)
    qs(nums,pivot +1, hi)



def partition(nums: List[int], lo: int, hi: int) -> int:
    pivot = nums[hi]
    idx = lo -1
    for i in range(lo,hi):
        if nums[i] <= pivot:
            idx +=1
            temp = nums[i]
            nums[i] = nums[idx]
            nums[idx] = temp
    nums[hi] = nums[idx + 1]
    nums[idx + 1] = pivot
    return idx + 1




if __name__ == "__main__":
    nums = [3,2,1,5,6,4]
    qs(nums,0,len(nums)-1)
    print(nums)
