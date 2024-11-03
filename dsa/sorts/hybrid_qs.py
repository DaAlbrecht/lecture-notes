from typing import List

def insert_sort(arr: List[int], lo: int, hi: int):
    print("insert_sort")
    for i in range(lo + 1, hi + 1):
        j = i - 1
        needle = arr[i]
        while j >= lo and arr[j] > needle:
            arr[j + 1] = arr[j]
            j -= 1
        arr[j + 1] = needle

def qs(nums: List[int], lo: int, hi: int, threshold = 10):
    if lo >= hi:
        return nums
    pivot = partition(nums,lo,hi)

    if pivot - lo < threshold:
        insert_sort(nums,lo,pivot -1)
    else:
        print("qs")
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
    #using threshold
    nums = [3,2,1,5,6,4,7,8,9,10,11,12,13,14,15,16,17,18,19,20]
    qs(nums,0,len(nums)-1,5)
    print(nums)

