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
