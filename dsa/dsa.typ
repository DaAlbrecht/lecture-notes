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

=== Queue with a linked list

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

=== Queue with an array
