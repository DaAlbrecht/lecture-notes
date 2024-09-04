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



import unittest

class TestLinkedList(unittest.TestCase):
    def setUp(self):
        self.ll = (ll := LinkedList())
        ll.append(10)
        ll.append(20)
        ll.append(30)
        ll.append(40)
        ll.append(50)

    def to_list(self, ll):
        li = []
        for val in self.ll:
            li.append(val)
        return li

    def arrayEqual(self, ll, li):
        self.assertEqual(self.to_list(ll), li)

    def test_simple(self):
        self.assertEqual(self.ll[0], 10)
        self.assertEqual(self.ll[1], 20)
        self.assertEqual(self.ll[2], 30)
        self.assertEqual(self.ll[3], 40)
        self.assertEqual(self.ll[4], 50)

    def test_set(self):
        self.ll[2] = 333
        self.arrayEqual(self.ll, [10, 20, 333, 40, 50])
        with self.assertRaises(IndexError):
            self.ll[5] = 42
        self.arrayEqual(self.ll, [10, 20, 333, 40, 50])

    def test_iterator(self):
        li = self.to_list(self.ll)
        self.assertEqual(li, [10, 20, 30, 40, 50])

    def test_len(self):
        self.assertEqual(len(self.ll), 5)

    def test_pop(self):
        self.assertEqual(len(self.ll), 5)
        self.assertEqual(self.ll.pop(), 50)
        self.assertEqual(len(self.ll), 4)
        self.arrayEqual(self.ll, [10, 20, 30, 40])
        self.assertEqual(self.ll.pop(1), 20)
        self.arrayEqual(self.ll, [10, 30, 40])
        self.assertEqual(len(self.ll), 3)
        with self.assertRaises(IndexError):
            self.ll.pop(3)
        with self.assertRaises(IndexError):
            self.ll.pop(-4)
        with self.assertRaises(IndexError):
            LinkedList().pop()

    def test_contains(self):
        self.assertTrue(40 in self.ll)
        self.assertTrue(50 in self.ll)
        self.assertFalse(55 in self.ll)
    
    def test_append(self):
        self.ll.append(60)
        self.arrayEqual(self.ll, [10, 20, 30, 40, 50, 60])
        
    def test_insert(self):
        self.ll.insert(0, 60)
        self.arrayEqual(self.ll, [60, 10, 20, 30, 40, 50])
        self.ll.insert(-1, 70)
        self.arrayEqual(self.ll, [60, 10, 20, 30, 40, 70, 50])
        self.ll.insert(len(self.ll), 80)
        self.arrayEqual(self.ll, [60, 10, 20, 30, 40, 70, 50, 80])
        
           
if __name__ == "__main__":
    unittest.main(argv=[''], exit=False)
