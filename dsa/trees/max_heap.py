import math
class MaxHeap:
    def __init__(self) -> None:
        self.data = []
        self.len = 0

    def insert(self,value):
        if self.len == 0:
            self.data.append(value)
            self.len +=1
        else:
            self.data.append(value)
            self.__heapify_up(self.len)
            self.len +=1

    def pop(self):
        if self.len == 0:
            raise IndexError
        elif self.len == 1:
            self.len = 0
            return self.data[0]
        out = self.data[0]
        self.len -=1
        self.data[0] = self.data[self.len]
        self.__heapify_down(0)
        return out

    def __heapify_up(self,idx):
        if idx == 0:
            return
        idx_parent = self.__get_parent(idx)
        value = self.data[idx]
        value_parent = self.data[idx_parent]

        if value > value_parent:
            self.data[idx_parent] = value
            self.data[idx] = value_parent
            self.__heapify_up(idx_parent)

    def __heapify_down(self,idx):
        left_idx = self.__get_child_left(idx)
        right_idx = self.__get_child_right(idx)

        if idx >= self.len or left_idx >= self.len:
            return
        
        value_left = self.data[left_idx]
        value_right = self.data[right_idx]
        value = self.data[idx]

        if value_left >= value_right and value_left > value:
            self.data[idx] = value_left
            self.data[left_idx] = value
            self.__heapify_down(left_idx)
        elif value_right > value_left and value_right > value:
            self.data[idx] = value_right
            self.data[right_idx] = value
            self.__heapify_down(right_idx)

    
    def __get_parent(self,idx):
        return math.floor((idx -1) /2)
    def __get_child_left(self,idx):
        return idx * 2 + 1
    def __get_child_right(self,idx):
        return idx * 2 + 2
heap = MaxHeap()
heap.insert(10)
assert heap.pop() == 10  # Should return the only element
assert heap.len == 0  # Heap should be empty after popping

heap = MaxHeap()
heap.insert(10)
heap.insert(20)
heap.insert(5)
heap.insert(15)

assert heap.pop() == 20  # The largest element
assert heap.pop() == 15  # Next largest
assert heap.pop() == 10  # Next largest
assert heap.pop() == 5  # Last element

assert heap.len == 0  # Heap should be empty after popping all elements

heap = MaxHeap()
heap.insert(10)
heap.insert(10)
heap.insert(5)
heap.insert(5)

assert heap.pop() == 10  # The largest element (first 10)
assert heap.pop() == 10  # The second 10
assert heap.pop() == 5   # The first 5
assert heap.pop() == 5   # The second 5

assert heap.len == 0  # Heap should be empty after popping all elements
