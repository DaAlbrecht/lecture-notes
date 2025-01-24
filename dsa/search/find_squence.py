class SequenceFinder:
    def __init__(self, arr):
        self.sorted_array = arr
    
    # Implementieren Sie diese Methode
    def contains_sequence(self, sequence):
        if sequence is None or len(sequence) == 0:
            return True
        if len(self.sorted_array) < len(sequence):
            return False
        
        for i in range(len(self.sorted_array) - len(sequence) + 1):
            found = True
            for idx, c in enumerate(sequence):
                if c != self.sorted_array[i + idx]:
                    found = False
                    break  # Stop checking further for this starting index
            if found:
                return True  # Found a match, return immediately
        
        return False  # No match found

