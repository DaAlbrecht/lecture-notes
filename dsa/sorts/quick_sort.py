def qs(lst,lo,high):
    if lo >= high:
        return;
    pivotIdx = partition(lst,lo,high)

    qs(lst,lo,pivotIdx-1)
    qs(lst,pivotIdx+ 1,high)

def partition(lst,low,high) -> int:
    pivot = lst[high]
    idx = low -1
    i = low
    while i < high:
        if lst[i] <= pivot:
            idx +=1;
            temp = lst[idx]
            lst[idx] = lst[i] 
            lst[i] = temp
        i+=1
    idx +=1
    lst[high] = lst[idx]
    lst[idx] = pivot
    return idx

def quick_sort(lst):
    qs(lst,0,len(lst)- 1)



foo = [9,2,6,1,4,8,30,123,31,5]
quick_sort(foo)
print(foo)
