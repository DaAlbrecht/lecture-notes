#import "@preview/codly:1.2.0": *
#import "@preview/codly-languages:0.1.1": *
#show: codly-init.with()
#codly(languages: codly-languages, number-format: none, display-icon: false )

#show raw: set text(font: "Berkeley Mono", size: 5pt, spacing: 30%)

= Dsa

== Landau-Notation

Big `O` notation is a mathematical notation that describes the behavior of a *function* when the
*arguments* tends towards a particular value or infinity.

In Computer science, `big O` notation is used to classify algorithms according to how their run time
or space requirements grow as the input size grows.

#figure(
    image("./assets/big_o.png", height: 50%)
)

#table(
    columns: 3,
    table.header([Notion], [Name], [Example]),
    align: (left, left, left),
    [$cal(O)(1)$], [constant], [Finding the median value for a sorted array of numbers],
    [$cal(O)(log(n))$], [logarithmic], [Finding an item in a sorted array with a binary search],
    [$cal(O)(n)$], [linear], [Finding an item in an unsorted list],
    [$cal(O)(n log(n))$], [linearithmic, loglinear],[heapsort],
    [$cal(O)(n^2)$],[quadratic],[bubble sort],
    [$cal(O)(n^c)$],[polynomial],[maximum matching for bipartite graphs],
    [$cal(O)(d^n); c > 1$], [exponential], [travelling salesman problem],
    [$cal(O)(n!)$],[factorial],[enumerating all partitions of a set],
)

#pagebreak()

== Data structures

=== Array list

An array list is a dynamic array. An array list implementation could look like this

```rs
pub struct Vec<T> {
    ptr: *mut T,
    cap: usize,
    len: usize,
}

```

=== Linked list

Python implementation of a linked list

```py
from typing import Optional

class LinkedList:
    """
    Class for doubly linked lists.
    """
    class Node:
        """ Helper class for the nodes of the linked list. """
        def __init__(self, val):
            self.val = val
            self.next: Optional[LinkedList.Node] = None
            self.prev: Optional[LinkedList.Node] = None

    def __init__(self):
        self.__length = 0
        self.__node: Optional[LinkedList.Node] = None
        """ Initializes an empty list. """

    def __str__(self):
        """ String representation of a list. """
        res = '['
        node = self.__node
        while node is not None:
            res += repr(node.val) + ", "
            node = node.next
        if len(res) == 1:
            return "[]"
        return res[:-2] + ']'

    def __repr__(self):
        """ String representation of a list. """
        return type(self).__name__ + '(' + str(self) +')'

    def __getnode(self, index):
        """ Internal method that returns the node at a given index. """
        if index >= self.__length or index < -self.__length:
            raise IndexError("list index out of range")
        if index < 0:
            index += self.__length

        node = self.__node
        for _ in range(index):
            if node is None:
                raise ValueError("Optional value is None, List is broken")
            node = node.next
        return node


    def __getitem__(self, index):
        """
        Magic method to access the element at a given index.
        Used when accessing ll[index].
        """
        if index < 0 or index >= self.__length:
            raise IndexError

        node = self.__getnode(index)

        if node is None:
            raise ValueError("Optional value is None, List is broken")

        return node.val

    def __setitem__(self, index, val):
        """
        Magic method to change the value of an element at a given index.
        Used in statements like ll[index] = val.
        """
        if index < 0 or index >= self.__length:
            raise IndexError

        node = self.__getnode(index)
        if node is None:
            raise ValueError("Optional value is None, List is broken")

        node.val = val

    def __len__(self):
        """
        Magic method for the number of elements in a list.
        Used with len(ll).
        """
        return self.__length

    def __contains__(self, val):
        """
        Magic method to test whether a value exists in the list.
        Used with `el in ll`.
        """
        node = self.__node
        while node is not None:
            if node.val == val:
                return True
            node = node.next
        return False


    def append(self, val):
        """ 
        Method to add a new element to the end of the list.
        """
        new_node = self.Node(val)

        if self.__node is None:
            self.__node = new_node
        else:
            node = self.__node

            while node.next is not None:
                node = node.next

            new_node.prev = node
            node.next = new_node

        self.__length += 1


    def insert(self, index, val):
        """ 
        Method to add a new element at any position in the list.
        """
        current_node = self.__node

        try:
            current_node = self.__getnode(index)
        except IndexError:
            self.append(val)
            return

        new_node = self.Node(val)

        if current_node is None:
            raise ValueError("Optional value is None, List is broken")

        if current_node.prev is None:
            self.__node = new_node
            current_node.prev = new_node
        else:
            current_node.prev.next = new_node
            new_node.prev = current_node.prev

        new_node.next = current_node
        self.__length += 1

    def pop(self, index=None):
        """
        Method to remove an element from the list. 
        If no index is provided, the last element will be removed.
        The removed element is returned.
        """
        if index is None:
            index = self.__length - 1

        if index < 0 or index >= self.__length:
            raise IndexError

        node = self.__getnode(index)

        if node is None:
            raise ValueError("Optional value is None, List is broken")

        if node.prev is not None:
            node.prev.next = node.next
        else:
            self.__node = node.next

        if node.next is not None:
            node.next.prev = node.prev

        self.__length -= 1

        return node.val

    def __iter__(self):
        """
        Creates a new iterator for the list.
        """
        class LL_iter:
            """
            Iterator class for linked lists.
            (This class does not necessarily have to be defined inside the __iter__ method.)
            """
            def __init__(self, node):
                self.__next = node

            def __iter__(self):
                return self

            def __next__(self):
                """ 
                Magic method for the next element.
                If there are no more elements, 
                a StopIteration exception is raised.
                """
                if self.__next is None:
                    raise StopIteration
                val = self.__next.val
                self.__next = self.__next.next
                return val

        return LL_iter(self.__node)
```
#pagebreak()

== Queue

=== Queue (linked list)

```py
from typing import Optional

class Node:
    def __init__(self, value):
        self.value = value
        self.next : Optional[Node] = None
    def __repr__(self) -> str:
        return str(self.value)
class Queue:
    def __init__(self):
        self.tail : Optional[Node] = None
        self.head : Optional[Node] = None
        self.count = 0

    def enqueue(self, value):
        new_node = Node(value)

        if self.tail is None:
            self.head = self.tail = new_node
        else:
            self.tail.next = new_node
            self.tail = new_node
        self.count = self.count + 1
    
    def __len__(self):
        return self.count

    def isEmpty(self):
        return self.count == 0
    
    def dequeue(self):
        if self.isEmpty():
            return None
        if len(self) == 1:
            temp = self.head
            self.head = None
            self.tail = None
            self.count = 0
            return temp

        temp = self.head
        if self.head is not None:
            self.head = self.head.next

        self.count = self.count - 1
        return temp 
    
    def peek(self):
        if self.head is None:
            return None
        else:
            return self.head.value
    def rear(self):
        if self.tail is None:
            return None
        else:
            return self.tail.value
```

=== Circular Queue

```py
class Queue:
    def __init__(self, cap):
        self.head = 0
        self.tail = 0
        self.count = 0
        self.__cap = cap
        self.elements = [0 for _ in range(cap)]

    def enqueu(self,value):
        if len(self) >= len(self.elements):
            raise IndexError
        if len(self) == 0:
            self.elements[self.head] = value
            self.tail = 1
        else:
            self.tail = (self.tail + 1) % self.__cap
            self.elements[self.tail] = value
        self.count +=1

    def dequeue(self):
        if self.count ==0:
            return None

        self.count -=1
        temp = self.elements[self.head]
        self.head = (self.head +1) % self.__cap
        return temp

    def __len__(self):
        return self.count
```

=== DeQue

A `DeQue` is a double ended queue.

```py
from typing import Optional
class Node:
    def __init__(self, value):
        self.value = value
        self.prev: Optional[Node] = None
        self.next: Optional[Node] = None
    def __str__(self) -> str:
        return str(self.value)
class DeQue:
    def __init__(self):
        self.head = Node(0)
        self.tail = Node(0)
        self.count = 0

    def __len__(self):
        return self.count
    
    def enqueue(self,value):
        newNode = Node(value)
        if self.count == 0:
            self.head = self.tail = newNode
        else:
            temp = self.tail
            self.tail.next = newNode
            self.tail = newNode
            self.tail.prev = temp
        self.count+=1

    def enqueuRight(self,value):
        newNode = Node(value)
        if self.count == 0:
            self.head = self.tail = newNode
        else:
            temp = self.head
            self.head.prev = newNode
            self.head = newNode
            self.head.next = temp
        self.count+=1

    def dequeue(self):
        if self.count == 0:
            return None
        if self.count == 1:
            temp = self.head
            self.head = Node(0)
            self.tail = Node(0) 
            self.count = 0
            return temp

        temp = self.head
        self.head = temp.next
        self.count -=1
        return temp
    def dequeueLeft(self):
        if self.count == 0:
            return None
        if self.count == 1:
            temp = self.head
            self.head = Node(0)
            self.tail = Node(0)
            self.count = 0
            return temp
        
        temp = self.tail
        self.tail = temp.prev
        self.count -=1
        return temp
```

=== Min-Heap

```py
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
```

=== Max-Heap

```py
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
```

== Tree traversal (DFS)

```py
class Node:
    def __init__(self,value) -> None:
        self.left = None
        self.right = None
        self.value = value

def pre_order_traversal(node):
    print(node.value)
    if node.left is not None:
        pre_order_traversal(node.left)
    if node.right is not None:
        pre_order_traversal(node.right)

def in_order_traversal(node):
    if node.left is not None:
        in_order_traversal(node.left)
    print(node.value)
    if node.right is not None:
        in_order_traversal(node.right)

def post_order_traversal(node):
    if node.left is not None:
        post_order_traversal(node.left)
    if node.right is not None:
        post_order_traversal(node.right)
    print(node.value)


root = Node(5)
root.left = Node(3)
root.right = Node(8)
root.left.left = Node(1)
root.left.right = Node(4)
root.right.left = Node(7)
root.right.right = Node(9)

# Sample binary tree structure:
#
#         5
#       /   \
#      3     8
#     / \   / \
#    1   4 7   9
print("pre order:")
pre_order_traversal(root)
print()
print("in order:")
in_order_traversal(root)
print()
print("post order:")
post_order_traversal(root)

#pre order:
#5
#3
#1
#4
#8
#7
#9
#
#in order:
#1
#3
#4
#5
#7
#8
#9
#
#post order:
#1
#4
#3
#7
#9
#8
#5
```

=== Breadth first search / Level traversal

```py
from collections import deque 

class Node:
    def __init__(self, value) -> None:
        self.value = value
        self.left = None
        self.right = None

def breadth_first_search(node):
    queue = deque([node])
    while len(queue) != 0:
        curr = queue.popleft()
        if curr.left is not None:
            queue.append(curr.left)
        if curr.right is not None:
            queue.append(curr.right)
        print(curr.value)

```

== Sorts

=== Merge-Sort

```py
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
```

=== Quick-Sort

```py
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
```
