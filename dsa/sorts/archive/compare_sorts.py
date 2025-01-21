import random
from typing import List
import time

# Import sorting functions
def qs(nums: List[int], lo: int, hi: int):
    if lo >= hi:
        return nums
    pivot = partition(nums, lo, hi)
    qs(nums, lo, pivot - 1)
    qs(nums, pivot + 1, hi)

def partition(nums: List[int], lo: int, hi: int) -> int:
    pivot = nums[hi]
    idx = lo - 1
    for i in range(lo, hi):
        if nums[i] <= pivot:
            idx += 1
            nums[i], nums[idx] = nums[idx], nums[i]
    nums[hi], nums[idx + 1] = nums[idx + 1], pivot
    return idx + 1

def insert_sort(arr: List[int]) -> List[int]:
    for i in range(1, len(arr)):
        j = i - 1
        needle = arr[i]
        while j >= 0 and arr[j] > needle:
            arr[j + 1] = arr[j]
            j -= 1
        arr[j + 1] = needle
    return arr

# Main function for testing
def main():
    for exp in range(1, 6):  # Testing 10^1 to 10^5
        size = 10 ** exp
        nums = [random.randint(1, size) for _ in range(size)]

        # Test quicksort
        qs_nums = nums.copy()
        start_time = time.time()
        qs(qs_nums, 0, len(qs_nums) - 1)
        print(f"QuickSort with 10^{exp} elements took {time.time() - start_time:.5f} seconds")

        # Test insertion sort
        ins_nums = nums.copy()
        start_time = time.time()
        insert_sort(ins_nums)
        print(f"Insertion Sort with 10^{exp} elements took {time.time() - start_time:.5f} seconds")

if __name__ == "__main__":
    main()

