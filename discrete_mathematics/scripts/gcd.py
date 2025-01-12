def gcd_with_steps(a, b):
    """
    Computes the Greatest Common Divisor (GCD) of two integers using the Euclidean Algorithm.
    Outputs each step of the algorithm.

    Args:
        a (int): The first integer.
        b (int): The second integer.
    
    Returns:
        int: The greatest common divisor of a and b.
    
    Example:
        >>> gcd_with_steps(400, 225)
        Step 1: gcd(400, 225) -> 400 % 225 = 175
        Step 2: gcd(225, 175) -> 225 % 175 = 50
        Step 3: gcd(175, 50) -> 175 % 50 = 25
        Step 4: gcd(50, 25) -> 50 % 25 = 0
        GCD is 25
    """
    step = 1
    while b != 0:
        print(f"Schritt {step}: gcd({a}, {b}) -> {a} % {b} = {a % b}")
        a, b = b, a % b
        step += 1
    print(f"GCD ist {a}")
    return a

def extended_gcd(a, b):
    """
    Computes the Greatest Common Divisor (GCD) of a and b using the extended Euclidean algorithm.
    Outputs each step of the algorithm, including coefficients for Bézout's identity.

    Bézout's identity: ax + by = gcd(a, b)

    Args:
        a (int): The first integer.
        b (int): The second integer.

    Returns:
        tuple: (gcd, x, y), where gcd is the greatest common divisor of a and b,
               and x, y are the Bézout coefficients.
    
    Example:
        >>> extended_gcd(240, 46)
        Step 1: r = 240, r_next = 46, q = 5, x = 1, x_next = 0, y = 0, y_next = 1
        Step 2: r = 46, r_next = 10, q = 4, x = 0, x_next = 1, y = 1, y_next = -5
        Step 3: r = 10, r_next = 6, q = 1, x = 1, x_next = -4, y = -5, y_next = 21
        Step 4: r = 6, r_next = 4, q = 1, x = -4, x_next = 5, y = 21, y_next = -26
        Step 5: r = 4, r_next = 2, q = 2, x = 5, x_next = -14, y = -26, y_next = 73
        Step 6: r = 2, r_next = 0, q = 2, x = -14, x_next = 33, y = 73, y_next = -172
        GCD is 2, x = -14, y = 73
    """
    # Initial values for the extended algorithm
    x, y, x_next, y_next = 1, 0, 0, 1
    step = 1

    print(f"Initial values: a = {a}, b = {b}")
    while b != 0:
        q = a // b  # Quotient
        r = a % b   # Remainder
        print(f"Step {step}: r = {a}, r_next = {b}, q = {q}, x = {x}, x_next = {x_next}, y = {y}, y_next = {y_next}")
        
        # Update values
        a, b = b, r
        x, x_next = x_next, x - q * x_next
        y, y_next = y_next, y - q * y_next
        step += 1

    print(f"GCD is {a}, x = {x}, y = {y}")
    return a, x, y

