def merge_sort(lst):
    #Base case
    if len(lst) <= 1:
        return lst
    mid = len(lst) // 2
    #Recursion
    left = merge_sort(lst[:mid])
    right = merge_sort(lst[mid:])
    return  merge(left,right)

def merge(left,right):
    temp = []
    i = j = 0
    while i < len(left) and j < len(right):
        if left[i] < right[j]:
            temp.append(left[i])
            i += 1
        else:
            temp.append(right[j])
            j += 1
    # append any remaining elements
    temp.extend(left[i:])
    temp.extend(right[j:])
    return temp


foo = [9,2,6,1,4,8,30,123,31,5]
sorted = merge_sort(foo)
print(sorted)
