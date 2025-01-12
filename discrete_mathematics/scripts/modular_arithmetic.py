def additive_inverse(a, m):
    """
    Computes the additive inverse of a modulo m.

    Args:
        a (int): The number whose additive inverse is to be found.
        m (int): The modulus.
    
    Returns:
        int: The additive inverse of a modulo m.
    
    Example:
        >>> additive_inverse(3, 7)
        4
    """
    return (-a) % m


def multiplicative_inverse(a, m):
    """
    Computes the multiplicative inverse of a modulo m using the extended Euclidean algorithm.

    Args:
        a (int): The number whose multiplicative inverse is to be found.
        m (int): The modulus.
    
    Returns:
        int: The multiplicative inverse of a modulo m, or raises ValueError if no inverse exists.
    
    Example:
        >>> multiplicative_inverse(3, 7)
        5
    """
    # Extended Euclidean Algorithm
    t, new_t = 0, 1
    r, new_r = m, a
    
    while new_r != 0:
        quotient = r // new_r
        t, new_t = new_t, t - quotient * new_t
        r, new_r = new_r, r - quotient * new_r
    
    if r > 1:
        raise ValueError(f"{a} has no multiplicative inverse modulo {m}")
    if t < 0:
        t = t + m
    
    return t

