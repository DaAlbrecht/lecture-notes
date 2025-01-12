def fermat_little_theorem(a, p):
    """
    Verifies Fermat's Little Theorem: a^(p-1) ≡ 1 (mod p) where p is a prime number.
    
    Args:
        a (int): The integer to test.
        p (int): A prime number.
        
    Returns:
        bool: True if Fermat's Little Theorem holds for a and p, otherwise False.
    """
    if p <= 1:
        raise ValueError("p must be a prime number greater than 1.")
    
    # Check if p is prime
    if not is_prime(p):
        raise ValueError(f"{p} is not a prime number.")
    
    # Apply Fermat's Little Theorem: a^(p-1) % p should be 1
    return pow(a, p - 1, p) == 1

def is_prime(n):
    """Helper function to check if a number is prime."""
    if n <= 1:
        return False
    for i in range(2, int(n**0.5) + 1):
        if n % i == 0:
            return False
    return True

def prime_factors(n):
    """
    Berechnet die Primfaktorzerlegung einer Zahl.
    
    Args:
        n (int): Die Zahl, die zerlegt werden soll.
    
    Returns:
        list: Eine Liste von Primfaktoren, die n bilden.
    """
    factors = []
    
    # Zuerst alle 2er Faktoren herausnehmen
    while n % 2 == 0:
        factors.append(2)
        n = n // 2
    
    # Danach die ungeraden Zahlen von 3 bis √n prüfen
    for i in range(3, int(n**0.5) + 1, 2):
        while n % i == 0:
            factors.append(i)
            n = n // i
    
    # Wenn n immer noch größer als 2 ist, dann ist n ein Primfaktor
    if n > 2:
        factors.append(n)
    
    return factors

