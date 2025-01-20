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

foo = Queue(4)
foo.enqueu(1)
print(foo.dequeue())
print(foo.dequeue())
print(foo.dequeue())
print(foo.dequeue())
foo.enqueu(1)
foo.enqueu(2)
foo.enqueu(3)
foo.enqueu(4)
print(foo.dequeue())
print(foo.dequeue())
print(foo.dequeue())
print(foo.dequeue())
