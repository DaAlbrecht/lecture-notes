from typing import List

def heap_sort(array: List[int], start: int, end: int) -> List[int]:
    def heapify(array: List[int], heap_size: int, root_index: int, offset: int) -> None:
        largest_element_index = root_index
        left_child_index = 2 * root_index + 1
        right_child_index = 2 * root_index + 2

        # Adjust indices to consider the offset
        left_child_index += offset
        right_child_index += offset
        largest_element_index += offset
        root_index += offset

        # Check if the left child is larger than the root
        if left_child_index < heap_size and array[root_index] < array[left_child_index]:
            largest_element_index = left_child_index

        # Check if the right child is larger than the current largest
        if right_child_index < heap_size and array[largest_element_index] < array[right_child_index]:
            largest_element_index = right_child_index

        # Swap and continue heapifying if the root is not the largest
        if largest_element_index != root_index:
            array[root_index], array[largest_element_index] = array[largest_element_index], array[root_index]
            heapify(array, heap_size, largest_element_index - offset, offset)

    if start < 0 or end > len(array) or start >= end:
        raise ValueError("Invalid start or end indices")

    range_length = end - start

    for i in range(range_length // 2 - 1, -1, -1):
        heapify(array, end, i, start)

    # Extract elements from the heap within the specified range
    for i in range(end - 1, start, -1):
        # Move current root to end
        array[i], array[start] = array[start], array[i]
        # Call max heapify on the reduced heap
        heapify(array, i, 0, start)

    return array


# Test the function with a start and end index
arr = [12, 11, 13, 5, 6, 7]
print(heap_sort(arr, 1, 5))  # This will sort only the subarray from index 1 to 4
print(heap_sort(arr, 0, len(arr)))  # This will sort the entire array
