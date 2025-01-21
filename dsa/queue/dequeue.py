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


foo = DeQue()
foo.enqueue(1)
print(foo.dequeue())
print(foo.dequeue())
print(foo.dequeue())
foo.enqueue(2)
foo.enqueuRight(3)
foo.enqueue(1)
foo.enqueue(5)
print(foo.dequeueLeft())
print(foo.dequeue())
print(foo.dequeue())
print(foo.dequeue())
print(foo.dequeue())
