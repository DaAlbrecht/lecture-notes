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

foo = Queue()
foo.enqueue(2)
print(foo.peek())
print(foo.dequeue())
print(foo.dequeue())
foo.enqueue(1)
foo.enqueue(2)
foo.enqueue(3)
print(foo.dequeue())
foo.enqueue(4)
print(foo.dequeue())
print(foo.dequeue())
print(foo.dequeue())
print(foo.dequeue())
