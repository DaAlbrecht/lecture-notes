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

def get_keys_at_level(node, level):
    result = []                       
    
    queue = deque([(node, 0)])     
    
    while queue:                         
        node, current_level = queue.popleft()
        
        if current_level == level:     
            result.append(node.value)     
        current_level +=1
        if node.left:                    
            queue.append((node.left, current_level))
        
        if node.right:                   
            queue.append((node.right, current_level))
    print(result) 

# Sample binary tree structure:
#
#         5
#       /   \
#      3     8
#     / \   / \
#    1   4 7   9

root = Node(5)
root.left = Node(3)
root.right = Node(8)
root.left.left = Node(1)
root.left.right = Node(4)
root.right.left = Node(7)
root.right.right = Node(9)

#breadth_first_search(root)
get_keys_at_level(root,2)
