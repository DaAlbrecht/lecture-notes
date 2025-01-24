class HashMap:
    def __init__(self, cap=100):
        self.data = [[] for _ in range(cap)]

    def insert(self,value):
        idx = self.__hash_function(value)
        lst = self.data[idx]
        if not lst.__contains__(value):
            lst.append(value)
    def remove(self,value):
        idx = self.__hash_function(value)
        lst = self.data[idx]
        if not lst.__contains__(value):
            return
        for item in lst:
            if item == value:
                lst.remove(item)
    def get(self, value):
        idx = self.__hash_function(value)
        lst = self.data[idx]
        if not lst.__contains__(value):
            return
        for item in lst:
            if item == value:
                return item
        return

    def __hash_function(self, value):
        # Simple hash function: sum of character codes modulo the number of buckets
        return sum(ord(char) for char in value) % len(self.data)
import unittest

class TestHashMap(unittest.TestCase):
    def setUp(self):
        self.map = HashMap(10)  # Small capacity for testing collisions

    def test_insert_and_retrieve(self):
        self.map.insert("apple")
        self.assertIn("apple", self.map.get("apple"))
        
        self.map.insert("banana")
        self.assertIn("banana", self.map.get("banana"))
    
    def test_collision_handling(self):
        """Ensure linear probing resolves collisions."""
        value1 = "abc"  # Adjust these strings so they cause a collision
        value2 = "cab"  # Same hash index as 'abc' in a small table
        
        self.map.insert(value1)
        self.map.insert(value2)
        
        self.assertEqual(value1, self.map.get(value1))
        self.assertEqual(value2, self.map.get(value2))
    
    def test_remove(self):
        self.map.insert("grape")
        self.assertEqual("grape", self.map.get("grape"))
        
        self.map.remove("grape")
        self.assertNotEqual("grape", self.map.get("grape"))
        
    
    def test_remove_non_existent(self):
        self.map.remove("pear")  # Should not raise an error
        self.assertNotIn("pear", self.map.data)
    

if __name__ == "__main__":
    unittest.main()

