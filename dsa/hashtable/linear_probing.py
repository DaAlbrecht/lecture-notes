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

import unittest

class TestHashMap(unittest.TestCase):
    def setUp(self):
        self.map = HashMap(10)  # Small capacity for testing collisions

    def test_insert_and_retrieve(self):
        self.map.insert("apple")
        self.assertIn("apple", self.map.data)
        
        self.map.insert("banana")
        self.assertIn("banana", self.map.data)
    
    def test_collision_handling(self):
        """Ensure linear probing resolves collisions."""
        value1 = "abc"  # Adjust these strings so they cause a collision
        value2 = "cab"  # Same hash index as 'abc' in a small table
        
        self.map.insert(value1)
        self.map.insert(value2)
        
        self.assertIn(value1, self.map.data)
        self.assertIn(value2, self.map.data)
    
    def test_remove(self):
        self.map.insert("grape")
        self.assertIn("grape", self.map.data)
        
        self.map.remove("grape")
        self.assertNotIn("grape", self.map.data)
        
        # Ensure slot is marked as deleted
        idx = self.map._HashMap__hash_function("grape")
        self.assertEqual(self.map.data[idx], self.map.TOMBSTONE)
    
    def test_remove_non_existent(self):
        self.map.remove("pear")  # Should not raise an error
        self.assertNotIn("pear", self.map.data)
    
    def test_table_full(self):
        for i in range(10):
            self.map.insert(str(i))
        
        with self.assertRaises(IndexError):
            self.map.insert("overflow")

if __name__ == "__main__":
    unittest.main()

