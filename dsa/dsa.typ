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

=== Binary search tree

```py
class Bst:
    def __init__(self, value=None, parent=None):
        self.value = value
        self.parent = parent
        self.left = None
        self.right = None
    def __str__(self) -> str:
        return str(self.value)

    def insert(self, value):
        if self.value is None:
            self.value = value
            return

        if value < self.value:
            if self.left is None:
                self.left = Bst(value, self)
            else:
                self.left.insert(value)
        elif value > self.value:
            if self.right is None:
                self.right = Bst(value, self)
            else:
                self.right.insert(value)

    def search(self, node, target):
        if node is None:
            return None 
        elif node.value == target:
            return node
        elif target < node.value:
            return self.search(node.left, target)
        else:
            return self.search(node.right, target)


def in_order_traversal(node):
    if node.left is not None:
        in_order_traversal(node.left)
    print(node.value)
    if node.right is not None:
        in_order_traversal(node.right)

foo = Bst(200)
foo.insert(32)
foo.insert(94)
foo.insert(12)
foo.insert(22)
foo.insert(23)
foo.insert(40)
foo.insert(40)
foo.insert(30)
print("found:", foo.search(foo,30))
print("in order traversal prints a bst in order")
in_order_traversal(foo)
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
=== Red Black Tree

by: https://www.geeksforgeeks.org/red-black-tree-in-python/
```py
# class to implement node of RB Tree
class RBNode:
        # cnostructor
    def __init__(self, value, color='red'):
        self.value = value
        self.color = color
        self.left = None
        self.right = None
        self.parent = None

    # function to get the grandparent of node
    def grandparent(self):
        if self.parent is None:
            return None
        return self.parent.parent

    # function to get the sibling of node
    def sibling(self):
        if self.parent is None:
            return None
        if self == self.parent.left:
            return self.parent.right
        return self.parent.left

    # function to get the uncle of node
    def uncle(self):
        if self.parent is None:
            return None
        return self.parent.sibling()

# function to implement Red Black Tree


class RedBlackTree:
        # constructor to initialize the RB tree
    def __init__(self):
        self.root = None

    # function to search a value in RB Tree
    def search(self, value):
        curr_node = self.root
        while curr_node is not None:
            if value == curr_node.value:
                return curr_node
            elif value < curr_node.value:
                curr_node = curr_node.left
            else:
                curr_node = curr_node.right
        return None

    # function to insert a node in RB Tree, similar to BST insertion
    def insert(self, value):
        # Regular insertion
        new_node = RBNode(value)
        if self.root is None:
            self.root = new_node
        else:
            curr_node = self.root
            while True:
                if value < curr_node.value:
                    if curr_node.left is None:
                        curr_node.left = new_node
                        new_node.parent = curr_node
                        break
                    else:
                        curr_node = curr_node.left
                else:
                    if curr_node.right is None:
                        curr_node.right = new_node
                        new_node.parent = curr_node
                        break
                    else:
                        curr_node = curr_node.right
        self.insert_fix(new_node)

    # Function to fix RB tree properties after insertion
    def insert_fix(self, new_node):
        while new_node.parent and new_node.parent.color == 'red':
            if new_node.parent == new_node.grandparent().left:
                uncle = new_node.uncle()
                if uncle and uncle.color == 'red':
                    new_node.parent.color = 'black'
                    uncle.color = 'black'
                    new_node.grandparent().color = 'red'
                    new_node = new_node.grandparent()
                else:
                    if new_node == new_node.parent.right:
                        new_node = new_node.parent
                        self.rotate_left(new_node)
                    new_node.parent.color = 'black'
                    new_node.grandparent().color = 'red'
                    self.rotate_right(new_node.grandparent())
            else:
                uncle = new_node.uncle()
                if uncle and uncle.color == 'red':
                    new_node.parent.color = 'black'
                    uncle.color = 'black'
                    new_node.grandparent().color = 'red'
                    new_node = new_node.grandparent()
                else:
                    if new_node == new_node.parent.left:
                        new_node = new_node.parent
                        self.rotate_right(new_node)
                    new_node.parent.color = 'black'
                    new_node.grandparent().color = 'red'
                    self.rotate_left(new_node.grandparent())
        self.root.color = 'black'

    # function to delete a value from RB Tree
    def delete(self, value):
        node_to_remove = self.search(value)

        if node_to_remove is None:
            return

        if node_to_remove.left is None or node_to_remove.right is None:
            self._replace_node(
                node_to_remove, node_to_remove.left or node_to_remove.right)
        else:
            successor = self._find_min(node_to_remove.right)
            node_to_remove.value = successor.value
            self._replace_node(successor, successor.right)

        self.delete_fix(node_to_remove)

    # function to fix RB Tree properties after deletion
    def delete_fix(self, x):
        while x != self.root and x.color == 'black':
            if x == x.parent.left:
                sibling = x.sibling()
                if sibling.color == 'red':
                    sibling.color = 'black'
                    x.parent.color = 'red'
                    self.rotate_left(x.parent)
                    sibling = x.sibling()
                if (sibling.left is None or sibling.left.color == 'black') and (sibling.right is None or sibling.right.color == 'black'):
                    sibling.color = 'red'
                    x = x.parent
                else:
                    if sibling.right is None or sibling.right.color == 'black':
                        sibling.left.color = 'black'
                        sibling.color = 'red'
                        self.rotate_right(sibling)
                        sibling = x.sibling()
                    sibling.color = x.parent.color
                    x.parent.color = 'black'
                    if sibling.right:
                        sibling.right.color = 'black'
                    self.rotate_left(x.parent)
                    x = self.root
            else:
                sibling = x.sibling()
                if sibling.color == 'red':
                    sibling.color = 'black'
                    x.parent.color = 'red'
                    self.rotate_right(x.parent)
                    sibling = x.sibling()
                if (sibling.left is None or sibling.left.color == 'black') and (sibling.right is None or sibling.right.color == 'black'):
                    sibling.color = 'red'
                    x = x.parent
                else:
                    if sibling.left is None or sibling.left.color == 'black':
                        sibling.right.color = 'black'
                        sibling.color = 'red'
                        self.rotate_left(sibling)
                        sibling = x.sibling()
                    sibling.color = x.parent.color
                    x.parent.color = 'black'
                    if sibling.left:
                        sibling.left.color = 'black'
                    self.rotate_right(x.parent)
                    x = self.root
        x.color = 'black'

    # Function for left rotation of RB Tree
    def rotate_left(self, node):
        right_child = node.right
        node.right = right_child.left

        if right_child.left is not None:
            right_child.left.parent = node

        right_child.parent = node.parent

        if node.parent is None:
            self.root = right_child
        elif node == node.parent.left:
            node.parent.left = right_child
        else:
            node.parent.right = right_child

        right_child.left = node
        node.parent = right_child

    # function for right rotation of RB Tree
    def rotate_right(self, node):
        left_child = node.left
        node.left = left_child.right

        if left_child.right is not None:
            left_child.right.parent = node

        left_child.parent = node.parent

        if node.parent is None:
            self.root = left_child
        elif node == node.parent.right:
            node.parent.right = left_child
        else:
            node.parent.left = left_child

        left_child.right = node
        node.parent = left_child

    # function to replace an old node with a new node
    def _replace_node(self, old_node, new_node):
        if old_node.parent is None:
            self.root = new_node
        else:
            if old_node == old_node.parent.left:
                old_node.parent.left = new_node
            else:
                old_node.parent.right = new_node
        if new_node is not None:
            new_node.parent = old_node.parent

    # function to find node with minimum value in a subtree
    def _find_min(self, node):
        while node.left is not None:
            node = node.left
        return node

    # function to perform inorder traversal
    def _inorder_traversal(self, node):
        if node is not None:
            self._inorder_traversal(node.left)
            print(node.value, end=" ")
            self._inorder_traversal(node.right)


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

=== Insert sort
```py
def insert_sort(lst):
    if lst is None or len(lst) <=1:
        return lst
    for i in range(1, len(lst)):
      j = i  
      while j > 0 and lst[j] < lst[j - 1]:
          lst[j], lst[j - 1] = lst[j - 1], lst[j]  # Swap elements
          j -= 1
```

== Hashing

=== HashTable linear probing

```py
class HashMap:
    def __init__(self, cap=100):
        self.size = 0
        self.data = [None for _ in range(cap)]
        self.TOMBSTONE = object()

    def insert(self,value):
        if self.size >= len(self.data):
            raise IndexError

        idx = self.__hash_function(value)
        if self.data[idx] is None or self.data[idx] == object():
            self.size +=1
            self.data[idx] = value
            return

        while self.data[idx] is not None and self.data[idx] is not self.TOMBSTONE:
            # linear probing and wrap around
            idx = (idx + 1) % len(self.data)
            # Avoid inserting duplicates
            if self.data[idx] == value: 
                return  

        self.size +=1
        self.data[idx] = value

    def remove(self,value):
        idx = starting_idx = self.__hash_function(value)
        if self.data[idx] == value:
            out = self.data[idx]
            self.data[idx] = self.TOMBSTONE
            return out
        while self.data[idx] != value:
            idx = (idx + 1) % len(self.data)
            if idx == starting_idx:
                return None
        self.data[idx] = self.TOMBSTONE
        
    def __hash_function(self, value):
        # Simple hash function: sum of character codes modulo the number of buckets
        return sum(ord(char) for char in value) % len(self.data)
```
=== HashTable with chaining

```py
class HashMap:
    def __init__(self, cap=100):
        self.data = [[] for _ in range(cap)]

    def insert(self,value):
        idx = self.__hash_function(value)
        lst = self.data[idx]
        if not lst.__contains__(value):
            lst.append(value)
    def remove(self,value):
        idx = self.__hash_function(value)
        lst = self.data[idx]
        if not lst.__contains__(value):
            return
        for item in lst:
            if item == value:
                lst.remove(item)
    def get(self, value):
        idx = self.__hash_function(value)
        lst = self.data[idx]
        if not lst.__contains__(value):
            return
        for item in lst:
            if item == value:
                return item
        return

    def __hash_function(self, value):
        # Simple hash function: sum of character codes modulo the number of buckets
        return sum(ord(char) for char in value) % len(self.data)
```
