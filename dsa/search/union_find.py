class UnionSort:
    def __init__(self, n):
        self.parent = list(range(n))
        self.size = n

    def find(self, x):  
        if x >= self.size:
            return None
        return self.parent[x]

    def connected(self, x, y):
        return self.find(x) == self.find(y)

    def union(self, x, y):
        root_x = self.find(x)
        root_y = self.find(y)

        if root_x is not None and root_y is not None and root_x != root_y:
            for i in range(self.size):
                if self.find(i) == root_y:
                    self.parent[i] = root_x





# Test Case 1: Basic union and connectivity check
def test_union_sort_basic():
    us = UnionSort(5)
    us.union(0, 1)
    assert us.connected(0, 1), "Test Case 1 Failed: 0 and 1 should be connected"
    assert not us.connected(0, 2), "Test Case 1 Failed: 0 and 2 should not be connected"
    us.union(1, 2)
    assert us.connected(0, 2), "Test Case 1 Failed: 0 and 2 should now be connected"
    print("Test Case 1 Passed")

# Test Case 2: Multiple unions
def test_union_sort_multiple_unions():
    us = UnionSort(10)
    us.union(1, 2)
    us.union(2, 3)
    us.union(3, 4)
    assert us.connected(1, 4), "Test Case 2 Failed: 1 and 4 should be connected"
    assert not us.connected(1, 5), "Test Case 2 Failed: 1 and 5 should not be connected"
    us.union(5, 4)
    assert us.connected(1, 5), "Test Case 2 Failed: 1 and 5 should now be connected"
    print("Test Case 2 Passed")

# Test Case 3: Disconnected components
def test_union_sort_disconnected():
    us = UnionSort(6)
    us.union(0, 1)
    us.union(2, 3)
    assert us.connected(0, 1), "Test Case 3 Failed: 0 and 1 should be connected"
    assert us.connected(2, 3), "Test Case 3 Failed: 2 and 3 should be connected"
    assert not us.connected(0, 2), "Test Case 3 Failed: 0 and 2 should not be connected"
    us.union(1, 3)
    assert us.connected(0, 2), "Test Case 3 Failed: 0 and 2 should now be connected"
    print("Test Case 3 Passed")

# Test Case 4: Self connectivity
def test_union_sort_self_connectivity():
    us = UnionSort(4)
    assert us.connected(0, 0), "Test Case 4 Failed: 0 should be connected to itself"
    assert us.connected(3, 3), "Test Case 4 Failed: 3 should be connected to itself"
    print("Test Case 4 Passed")

# Test Case 5: Large scale union operations
def test_union_sort_large():
    us = UnionSort(1000)
    for i in range(999):
        us.union(i, i+1)
    assert us.connected(0, 999), "Test Case 5 Failed: 0 and 999 should be connected"
    assert not us.connected(0, 1000), "Test Case 5 Failed: 0 and 1000 should not be connected (out of bounds)"
    print("Test Case 5 Passed")

# Test Case 6: Random unions and connectivity
def test_union_sort_random():
    us = UnionSort(10)
    us.union(0, 5)
    us.union(1, 7)
    us.union(3, 9)
    us.union(5, 9)

    assert us.connected(0, 9), "Test Case 6 Failed: 0 and 9 should be connected"
    assert not us.connected(1, 3), "Test Case 6 Failed: 1 and 3 should not be connected"
    us.union(1, 3)
    assert us.connected(1, 9), "Test Case 6 Failed: 1 and 9 should now be connected"
    print("Test Case 6 Passed")

# Run all tests
test_union_sort_basic()
test_union_sort_multiple_unions()
test_union_sort_disconnected()
test_union_sort_self_connectivity()
test_union_sort_large()
test_union_sort_random()



