import math
def heap_sort(lst):
    for idx, _ in enumerate(lst):
        heapify_down(lst,idx)
    pass

def heapify_down(lst,idx):
    left_index = idx*2 +1
    right_index = idx*2 +2
    if left_index >= len(lst) or len(lst) <= 1 or right_index >= len(lst):
        return lst
    value_left = lst[left_index]
    value_right = lst[right_index]
    value = lst[idx]

    if value_left <= value_right and value_left < value:
        lst[idx] = value_left
        lst[left_index] = value
        heapify_down(lst,left_index)
    elif value_right < value_left and value_right < value:
        lst[idx] = value_right
        lst[right_index] = value
        heapify_down(lst,right_index)







foo = [23,12,3,1,213,34,5,23,123123,98009432,31378,123,6713,13164189]

    
heap_sort(foo)
print(foo)
