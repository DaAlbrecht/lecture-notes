from typing import List

def qs(nums: List[int], lo: int, hi: int, recursive_limit: int) -> List[int]:
    if lo >= hi:
        return nums
    pivot = partition(nums, lo, hi)
    if recursive_limit <= 0:
        return heap_sort(nums, lo, hi + 1) 
    qs(nums, lo, pivot - 1, recursive_limit - 1)
    qs(nums, pivot + 1, hi, recursive_limit - 1)
    return nums

def partition(nums: List[int], lo: int, hi: int) -> int:
    pivot = nums[hi]
    idx = lo - 1
    for i in range(lo, hi):
        if nums[i] <= pivot:
            idx += 1
            nums[i], nums[idx] = nums[idx], nums[i] 
    nums[hi], nums[idx + 1] = nums[idx + 1], nums[hi]
    return idx + 1

def heap_sort(array: List[int], start: int, end: int) -> List[int]:
    def heapify(array: List[int], heap_size: int, root_index: int) -> None:
        largest_element_index = root_index
        left_child_index = 2 * root_index + 1
        right_child_index = 2 * root_index + 2

        # Check if the left child is larger than the root
        if left_child_index < heap_size and array[root_index] < array[left_child_index]:
            largest_element_index = left_child_index

        # Check if the right child is larger than the current largest
        if right_child_index < heap_size and array[largest_element_index] < array[right_child_index]:
            largest_element_index = right_child_index

        # Swap and continue heapifying if the root is not the largest
        if largest_element_index != root_index:
            array[root_index], array[largest_element_index] = array[largest_element_index], array[root_index]
            heapify(array, heap_size, largest_element_index)

    if start < 0 or end > len(array) or start >= end:
        raise ValueError("Invalid start or end indices")

    range_length = end - start

    for i in range(range_length // 2 - 1, -1, -1):
        heapify(array, range_length, i + start)  # Adjust index with start offset

    # Extract elements from the heap
    for i in range(range_length - 1, 0, -1):  # Correct loop
        array[start + i], array[start] = array[start], array[start + i]  # Swap
        heapify(array, i, start)  # Adjust root of the heap

    return array

if __name__ == "__main__":
    nums = [3, 2, 1, 5, 6, 4]
    qs(nums, 0, len(nums) - 1, 2)
    print(nums)

    nums = [3, 2, 1, 5, 6, 4, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]
    qs(nums, 0, len(nums) - 1, 2)
    print(nums)

