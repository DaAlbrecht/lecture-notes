import math
class MinHeap:
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
        if self.len == 1:
            self.len = 0
            return self.data[0]
        out = self.data[0]
        self.len -=1
        self.data[0] = self.data[self.len]
        self.__heapify_down(0)
        return out

    def __heapify_down(self,idx):
        left_idx = self.__get_left_child(idx)
        right_idx = self.__get_right_child(idx)

        if idx == self.len or left_idx >= self.len:
            return

        left_val = self.data[left_idx]
        right_val = self.data[right_idx]
        value = self.data[idx]

        if left_val <= right_val and value > left_val:
            self.data[idx] = left_val
            self.data[left_idx] = value
            self.__heapify_down(left_idx)
        elif right_val <= left_val and value > right_val:
            self.data[idx] = right_val 
            self.data[right_idx] = value
            self.__heapify_down(right_idx)

    def __heapify_up(self,idx):
        if idx == 0:
            return
        parent_idx = self.__get_parent(idx)
        parent_value = self.data[parent_idx]
        value = self.data[idx]

        if value < parent_value:
            self.data[parent_idx] = value
            self.data[idx] = parent_value
            self.__heapify_up(parent_idx)

    def __get_parent(self,idx):
        return math.floor((idx -1) /2)
    def __get_left_child(self,idx):
        return idx *2 + 1
    def __get_right_child(self,idx):
        return idx *2 + 2

heap = MinHeap()
heap.insert(10)
assert heap.pop() == 10
assert heap.len == 0
heap = MinHeap()
heap.insert(10)
heap.insert(20)
heap.insert(5)
heap.insert(15)

assert heap.pop() == 5  # The smallest element
assert heap.pop() == 10  # Next smallest
assert heap.pop() == 15  # Next smallest
assert heap.pop() == 20  # Last element

assert heap.len == 0  # Heap should be empty after popping all elements

