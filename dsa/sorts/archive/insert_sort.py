from typing import List


def insert_sort(arr: List[int]) -> List[int]:
    for i in range(1, len(arr)):
        j = i - 1
        needle = arr[i]
        while j >= 0 and arr[j] > needle:
            arr[j + 1] = arr[j]
            j -= 1
        arr[j + 1] = needle
    return arr



if __name__ == '__main__':
    arr = [30, 10, 50, 20, 60, 40]
    print(insert_sort(arr))
