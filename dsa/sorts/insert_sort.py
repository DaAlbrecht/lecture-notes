def insert_sort(lst):
    if lst is None or len(lst) <=1:
        return lst
    for i in range(1, len(lst)):
      j = i  
      while j > 0 and lst[j] < lst[j - 1]:
          lst[j], lst[j - 1] = lst[j - 1], lst[j]  # Swap elements
          j -= 1

foo = [9,2,6,1,4,8,30,123,31,5]
insert_sort(foo)
print(foo)
