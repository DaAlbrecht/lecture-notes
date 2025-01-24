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
