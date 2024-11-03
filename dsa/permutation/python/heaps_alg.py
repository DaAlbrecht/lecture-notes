from typing import List

def permutations(n: int) -> List[List[int]]:
    """
    Generate all permutations of the numbers 0, 1, 2, ..., n-1
    """
    perms = []
    generate(n, list(range(n)), perms)
    return perms

def generate(k: int, A: List[int], perms: List[List[int]]):
    if k <= 1:
        perms.append(A.copy())
        return
    else:
        generate(k - 1, A, perms)
        for i in range(k - 1): 
            if k % 2 == 0:  
                A[i], A[k - 1] = A[k - 1], A[i]
            else:  
                A[0], A[k - 1] = A[k - 1], A[0]
            generate(k - 1, A, perms)


import unittest
import math

class Tests_Permutations(unittest.TestCase):
        
    def _test_permutations(self, n):
        perms = sorted(permutations(n))
        self.assertEqual(len(perms), math.perm(n), 
                         "The number of permutations must be n!")
        self.assertFalse(any(p1 == p2 for (p1, p2) in zip(perms[1:], perms[:-1])),
                         "All permutations must be different")
        self.assertTrue(all({len(perm) == n for perm in perms}), 
                        "All permutations should have same length n")
        num = set(range(n))
        self.assertTrue(all(set(perm) == num for perm in perms),
                       "The permutations must be permutations of range(n)")

    def test_permutations_0(self):
        self._test_permutations(0)
        
    def test_permutations_1(self):
        self._test_permutations(1)
        
    def test_permutations_2(self):
        self._test_permutations(2)
        
    def test_permutations_3(self):
        self._test_permutations(3)
        
    def test_permutations_5(self):
        self._test_permutations(5)
        
           
if __name__ == "__main__":
    unittest.main(argv=[''], exit=False)

