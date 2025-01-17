#import "@preview/codly:1.2.0": *
#import "@preview/codly-languages:0.1.1": *
#show: codly-init.with()
#codly(languages: codly-languages, number-format: none, display-icon: false )

#show raw: set text(font: "Berkeley Mono", size: 5pt, spacing: 30%)

= Scripts

== Relation

=== Cartesian product

```py
import itertools

def kartesisches_prdukt(myList):
    """
    Berechnet und gibt das kartesische Produkt der Eingabeliste von Iterablen aus.

    Diese Funktion verwendet `itertools.product`, um das kartesische Produkt aller
    Iterablen in der Eingabeliste `myList` zu berechnen. Jede Kombination wird 
    als Tupel ausgegeben.

    Argumente:
        myList (Liste von Iterablen): Eine Liste, die die Iterablen enthält, 
                                      für die das kartesische Produkt berechnet wird.

    Beispiel:
        >>> myList = [[1, 2], ['a', 'b']]
        >>> kartesisches_prdukt(myList)
        (1, 'a')
        (1, 'b')
        (2, 'a')
        (2, 'b')

    Hinweis:
        - Jedes Element in `myList` sollte eine Iterabel sein.
        - Die Funktion gibt die Ergebnisse direkt aus, anstatt sie zurückzugeben.
    """
    for element in itertools.product(*myList):
        print(element)

```

=== Inverse Relation

```py
def inverse_relation(relation):
    """
    Computes the inverse of a given relation.

    Args:
        relation (set of tuple): A set of ordered pairs representing the relation.
    
    Returns:
        set of tuple: A set of ordered pairs where each pair (a, b) in the input 
                      is swapped to (b, a).
    
    Example:
        >>> relation = {(1, 2), (3, 4), (5, 6)}
        >>> inverse_relation(relation)
        {(2, 1), (4, 3), (6, 5)}
    """
    return {(b, a) for a, b in relation}
```
#pagebreak()

=== Compose Relation

```py
def compose_relations(R, S):
    """
    Computes the composition of two relations R and S.

    Args:
        R (set of tuple): The first relation, a set of ordered pairs (a, b).
        S (set of tuple): The second relation, a set of ordered pairs (b, c).
    
    Returns:
        set of tuple: A set of ordered pairs (a, c) such that there exists a b
                      where (a, b) is in R and (b, c) is in S.

    Example:
        >>> R = {(1, 2), (2, 3)}
        >>> S = {(2, 4), (3, 5)}
        >>> compose_relations(R, S)
        {(1, 4), (2, 5)}
    """
    return {(a, c) for (a, b1) in R for (b2, c) in S if b1 == b2}
```

=== Plot relation graph

```py
import networkx as nx
import matplotlib.pyplot as plt

def plot_relation_graph(relation):
    """
    Plots a directed graph representing the given relation.

    Args:
        relation (set of tuple): A set of ordered pairs representing the relation.
    
    Example:
        >>> relation = {(1, 2), (2, 3), (1, 3)}
        >>> plot_relation_graph(relation)
    """
    # Create a directed graph
    graph = nx.DiGraph()
    
    # Add edges for each pair in the relation
    graph.add_edges_from(relation)
    
    # Draw the graph
    pos = nx.spring_layout(graph)  # Position the nodes
    nx.draw(graph, pos, with_labels=True, node_size=2000, node_color="lightblue", arrowsize=20)
    plt.title("Directed Graph Representation of Relation")
    plt.show()
```

#pagebreak()

== Logic

=== Create truth table

```py
import sympy as sp
from sympy.logic.boolalg import And, Or, Not, Implies

def create_truth_table(expression, variables):
    """
    Erzeugt eine Wahrheitstabelle für einen gegebenen logischen Ausdruck und druckt diese.

    Diese Funktion generiert alle möglichen Kombinationen von Wahrheitswerten
    für die angegebenen Variablen, berechnet das Ergebnis des logischen
    Ausdrucks für jede Kombination und gibt die Wahrheitstabelle aus.

    Parameter:
    expression (sympy.Expr): Der logische Ausdruck, für den die Wahrheitstabelle erstellt wird.
    variables (list): Eine Liste von sympy-Variablen, die im logischen Ausdruck verwendet werden.
    
    Beispiel:

    >>> A, B, C = sp.symbols('A B C')
    >>> expression = And(A,Or(B,C))
    >>> create_truth_table(expression, [A, B, C])
    """
    # Erstelle eine Liste aller möglichen Kombinationen der Wahrheitswerte
    num_vars = len(variables)
    
    # Header für die Tabelle
    print(" ".join([str(var) for var in variables] + ["Result"]))
    
    # Generiere alle möglichen Kombinationen der Wahrheitswerte
    for i in range(2**num_vars):
        # Erstelle eine Zuordnung von Wahrheitswerten für jede Kombination
        row = [(variables[j], (i >> j) & 1) for j in range(num_vars)]
        values = dict(row)
        # Berechne das Ergebnis des Ausdrucks für die gegebene Kombination
        result = str(expression.subs(values))
        
        print(" ".join([str(values[var]) for var in variables] + [result]))
```
#pagebreak()

== Modular arithmetic

=== additive inverse

```py
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

```

=== Multiplicative inverse 

```py
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
```

#pagebreak()


== Number theory

=== GCD (Euclidean algorithm)

```py
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
```

=== Extended Euclidean algorithm

```py
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

```

#pagebreak()

=== Fermat's little theorem

```py
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
```

=== Is Prime

```py
def is_prime(n):
    """Helper function to check if a number is prime."""
    if n <= 1:
        return False
    for i in range(2, int(n**0.5) + 1):
        if n % i == 0:
            return False
    return True
```

=== Prime factors

```py
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

```

#pagebreak()

== Graph theory

=== Sum of degree

```py
def sum_of_degrees(graph):
    """
    Berechnet die Summe der Grade aller Knoten in einem Graphen.
    
    Der Grad eines Knotens ist die Anzahl der Kanten, die mit diesem Knoten verbunden sind.
    Die Summe der Grade aller Knoten ist gleich der doppelten Anzahl der Kanten.
    
    Args:
        graph (dict): Ein Graph als Adjazenzliste, wobei die Schlüssel die Knoten sind 
                      und die Werte Listen von benachbarten Knoten darstellen.
    
    Returns:
        int: Die Summe der Grade aller Knoten.
    
    Beispiel:
        >>> graph = {
        >>>     1: [2, 3],
        >>>     2: [1, 3],
        >>>     3: [1, 2]
        >>> }
        >>> sum_of_degrees(graph)
        6
    """
    degree_sum = 0
    for vertex in graph:
        degree_sum += len(graph[vertex])  # Anzahl der Nachbarn (Grad des Knotens)
    return degree_sum
```

=== number of edges

```py
def number_of_edges(graph):
    """
    Berechnet die Anzahl der Kanten in einem ungerichteten Graphen.
    
    Die Anzahl der Kanten ist die Hälfte der Summe der Grade aller Knoten,
    da jede Kante in der Adjazenzliste zweimal gezählt wird.
    
    Args:
        graph (dict): Ein Graph als Adjazenzliste.
    
    Returns:
        int: Die Anzahl der Kanten im Graphen.
    
    Beispiel:
        >>> graph = {
        >>>     1: [2, 3],
        >>>     2: [1, 3],
        >>>     3: [1, 2]
        >>> }
        >>> number_of_edges(graph)
        3
    """
    return sum_of_degrees(graph) // 2  # Jede Kante wird zweimal gezählt
```

#pagebreak()

== Find Cycle

```py
def find_cycle(graph):
    """
    Findet einen Zyklus in einem ungerichteten Graphen und gibt diesen aus, wenn er existiert.
    
    Der Zyklus wird als Liste von Knoten ausgegeben, beginnend und endend beim gleichen Knoten.
    
    Args:
        graph (dict): Ein Graph als Adjazenzliste, wobei die Schlüssel die Knoten sind 
                      und die Werte Listen von benachbarten Knoten darstellen.
    
    Returns:
        list: Eine Liste von Knoten, die den Zyklus bilden, oder None, wenn kein Zyklus gefunden wird.
    
    Beispiel:
        >>> graph = {
        >>>     1: [2, 3],
        >>>     2: [1, 3],
        >>>     3: [1, 2]
        >>> }
        >>> find_cycle(graph)
        [3, 2, 1, 3]
    """
    
    def dfs(v, parent, visited, path):
        visited[v] = True
        path.append(v)
        
        for neighbor in graph[v]:
            if not visited[neighbor]:
                if dfs(neighbor, v, visited, path):
                    return True
            # Rückkante gefunden
            elif neighbor != parent:
                cycle_index = path.index(neighbor)
                cycle = path[cycle_index:] + [neighbor]
                print(f"Cycle detected: {cycle}")
                return True
        
        path.pop()
        return False

    visited = {node: False for node in graph}
    for node in graph:
        if not visited[node]:
            path = []
            if dfs(node, None, visited, path):
                return path
    return None

```

=== BFS

```py
from collections import deque

def bfs(graph, start):
    """
    Perform a Breadth-First Search (BFS) on a graph and print each step.
    
    Args:
        graph (dict): A graph represented as an adjacency list.
        start (int): The starting node for BFS.
    """
    visited = set()  # Set to keep track of visited nodes
    queue = deque([start])  # Initialize the queue with the start node
    
    print(f"Starting BFS from node {start}")
    
    while queue:
        # Dequeue the next node to visit
        node = queue.popleft()
        print(f"Visiting node: {node}, Queue: {list(queue)}")
        
        if node not in visited:
            visited.add(node)  # Mark the node as visited
            
            # Add all unvisited neighbors to the queue
            for neighbor in graph[node]:
                if neighbor not in visited:
                    queue.append(neighbor)
                    print(f"Adding neighbor {neighbor} to the queue.")
        
    print("BFS traversal complete.")
```

== Cryptography

=== Generate RSA Key

```py
from sympy import isprime
# Hilfsfunktion zum Berechnen des größten gemeinsamen Teilers (GCD)
def gcd(a, b):
    while b != 0:
        a, b = b, a % b
    return a

# Funktion zur Berechnung des modularen Inversen von a modulo m
def mod_inverse(a, m):
    m0, x0, x1 = m, 0, 1
    while a > 1:
        q = a // m
        m, a = a % m, m
        x0, x1 = x1 - q * x0, x0
    return x1 + m0 if x1 < 0 else x1

# Funktion zum Generieren von RSA-Schlüsselpaaren mit benutzerdefinierten p, q und e
def generate_rsa_keys_from_input(p, q, e= 65537):
    # Sicherstellen, dass p und q Primzahlen sind
    if not isprime(p):
        raise ValueError(f"{p} ist keine Primzahl.")
    if not isprime(q):
        raise ValueError(f"{q} ist keine Primzahl.")
    
    print(f"Schritt 1: Berechne n = p * q")
    # Berechnung von n = p * q
    n = p * q
    print(f"n = {p} * {q} = {n}")
    
    # Berechnung von phi(n) = (p-1) * (q-1)
    print(f"Schritt 2: Berechne phi(n) = (p-1) * (q-1)")
    phi_n = (p - 1) * (q - 1)
    print(f"phi(n) = ({p} - 1) * ({q} - 1) = {phi_n}")
    
    # Sicherstellen, dass e teilerfremd zu phi(n) ist
    print(f"Schritt 3: Überprüfe, ob e = {e} teilerfremd zu phi(n) ist")
    if gcd(e, phi_n) != 1:
        raise ValueError(f"{e} ist nicht teilerfremd zu phi(n). Wählen Sie einen anderen Wert für e.")
    print(f"e = {e} ist teilerfremd zu phi(n).")
    
    # Berechnung von d, dem privaten Exponenten
    print(f"Schritt 4: Berechne d als das modulare Inverse von e modulo phi(n)")
    d = mod_inverse(e, phi_n)
    print(f"d = {d} (modularer Inverser von {e} mod {phi_n})")
    
    # Rückgabe des Schlüsselpaares
    public_key = (e, n)
    private_key = (d, n)
    
    print(f"Öffentlicher Schlüssel: ({e}, {n})")
    print(f"Privater Schlüssel: ({d}, {n})")
    
    return public_key, private_key
```

#pagebreak()

=== RSA encrypt

```py
# RSA Verschlüsselung: Verschlüsselt eine Nachricht mit dem öffentlichen Schlüssel
def encrypt(public_key, message):
    """
    Verschlüsselt eine Nachricht mit dem öffentlichen Schlüssel (e, n).
    
    Args:
        public_key: Ein Tupel (e, n), wobei e der öffentliche Exponent und n der Modulus ist.
        message: Die Nachricht (als ganze Zahl), die verschlüsselt werden soll.
        
    Returns:
        encrypted_message: Die verschlüsselte Nachricht.
        
    Beispiel:
        public_key = (17, 3233)
        message = 123
        encrypted_message = encrypt(public_key, message)
        print(encrypted_message)  # Gibt die verschlüsselte Nachricht aus
    """
    e, n = public_key
    print(f"Verschlüsselung: (M^e) mod n = ({message}^{e}) mod {n}")
    encrypted_message = pow(message, e, n)
    return encrypted_message
```

=== RSA decrypt

```py
# RSA Entschlüsselung: Entschlüsselt eine Nachricht mit dem privaten Schlüssel
def decrypt(private_key, encrypted_message):
    """
    Entschlüsselt eine Nachricht mit dem privaten Schlüssel (d, n).
    
    Args:
        private_key: Ein Tupel (d, n), wobei d der private Exponent und n der Modulus ist.
        encrypted_message: Die verschlüsselte Nachricht, die entschlüsselt werden soll.
        
    Returns:
        decrypted_message: Die entschlüsselte Nachricht.
        
    Beispiel:
        private_key = (2753, 3233)
        encrypted_message = 2202
        decrypted_message = decrypt(private_key, encrypted_message)
        print(decrypted_message)  # Gibt die entschlüsselte Nachricht aus
    """
    d, n = private_key
    print(f"Entschlüsselung: (C^d) mod n = ({encrypted_message}^{d}) mod {n}")
    decrypted_message = pow(encrypted_message, d, n)
    return decrypted_message
```

#pagebreak()

=== Diffie-Hellman

```py
# Hilfsfunktion zur Berechnung der Potenzmodulo
def power_mod(base, exponent, modulus):
    return pow(base, exponent, modulus)

# Diffie-Hellman-Schlüsselaustausch
def diffie_hellman(p, g, private_key_a, private_key_b):
    # A und B berechnen jeweils ihre öffentlichen Schlüssel
    public_key_a = power_mod(g, private_key_a, p)
    public_key_b = power_mod(g, private_key_b, p)
    
    # Austausch der öffentlichen Schlüssel (öffentlich)
    print(f"Öffentlicher Schlüssel A: {public_key_a}")
    print(f"Öffentlicher Schlüssel B: {public_key_b}")
    
    # A berechnet den gemeinsamen Schlüssel mit B's öffentlichem Schlüssel
    shared_secret_a = power_mod(public_key_b, private_key_a, p)
    
    # B berechnet den gemeinsamen Schlüssel mit A's öffentlichem Schlüssel
    shared_secret_b = power_mod(public_key_a, private_key_b, p)
    
    # Überprüfen, ob der gemeinsame Schlüssel korrekt ist
    if shared_secret_a == shared_secret_b:
        print(f"Der gemeinsame geheime Schlüssel ist: {shared_secret_a}")
        return shared_secret_a
    else:
        print("Es gab einen Fehler bei der Berechnung des gemeinsamen Geheimnisses.")
        return None

# Beispiel für den Diffie-Hellman-Schlüsselaustausch
def example_diffie_hellman():
    # Definiere p (Primzahl) und g (Basis)
    p = 23  # Beispiel für eine kleine Primzahl
    g = 5   # Beispiel für eine primitive Basis

    # Zwei private Schlüssel für Alice (A) und Bob (B)
    private_key_a = 6
    private_key_b = 15

    # Berechne das gemeinsame Geheimnis
    shared_secret = diffie_hellman(p, g, private_key_a, private_key_b)
```

#pagebreak()

=== ElGamal

```py
import random
from sympy import mod_inverse

# ElGamal-Schlüsselgenerierung
def elgamal_keygen(p, g):
    """
    Schlüsselpaar für ElGamal generieren:
    p: Primzahl
    g: primitive Wurzel modulo p
    
    Gibt das öffentliche und private Schlüsselpaar zurück.
    """
    # Privater Schlüssel x
    x = random.randint(2, p-2)
    
    # Öffentlicher Schlüssel y = g^x mod p
    y = pow(g, x, p)
    
    # Rückgabe des Schlüsselpaares
    return (p, g, y), (p, g, x)

# ElGamal-Verschlüsselung
def elgamal_encrypt(public_key, m):
    """
    Verschlüsselt eine Nachricht m mit dem öffentlichen Schlüssel.
    
    public_key: (p, g, y)
    m: Die Nachricht (als ganze Zahl)
    
    Gibt den verschlüsselten Text (c1, c2) zurück.
    """
    p, g, y = public_key
    
    # Wähle eine zufällige Zahl k
    k = random.randint(2, p-2)
    
    # Berechne c1 = g^k mod p
    c1 = pow(g, k, p)
    
    # Berechne c2 = (m * y^k) mod p
    c2 = (m * pow(y, k, p)) % p
    
    # Rückgabe des verschlüsselten Texts
    return c1, c2

# ElGamal-Entschlüsselung
def elgamal_decrypt(private_key, ciphertext):
    """
    Entschlüsselt den verschlüsselten Text mit dem privaten Schlüssel.
    
    private_key: (p, g, x)
    ciphertext: (c1, c2)
    
    Gibt die entschlüsselte Nachricht zurück.
    """
    p, g, x = private_key
    c1, c2 = ciphertext
    
    # Berechne m = c2 * (c1^x)^-1 mod p
    s = pow(c1, x, p)  # Berechne c1^x mod p
    s_inv = mod_inverse(s, p)  # Berechne das Inverse von s modulo p
    
    m = (c2 * s_inv) % p  # Entschlüsselte Nachricht
    
    return m
```

#pagebreak()

```py
# Beispiel für den ElGamal-Verschlüsselungsprozess
def example_elgamal():
    # Definiere eine Primzahl p und eine primitive Wurzel g
    p = 23  # Beispiel für eine kleine Primzahl
    g = 5   # Beispiel für eine primitive Wurzel
    
    # Generiere das Schlüsselpaar
    public_key, private_key = elgamal_keygen(p, g)
    
    print(f"Öffentlicher Schlüssel: {public_key}")
    print(f"Privater Schlüssel: {private_key}")
    
    # Nachricht, die verschlüsselt werden soll
    message = 15
    
    print(f"Nachricht: {message}")
    
    # Verschlüsseln der Nachricht
    ciphertext = elgamal_encrypt(public_key, message)
    print(f"Verschlüsselter Text: {ciphertext}")
    
    # Entschlüsseln der Nachricht
    decrypted_message = elgamal_decrypt(private_key, ciphertext)
    print(f"Entschlüsselte Nachricht: {decrypted_message}")
```
#pagebreak()

== Probability

=== binomial_term_count

```py
import math

def binomial_term_count(n=8, k=3):
    """
    Berechnet, wie oft ein spezifischer Term a^k * b^(n-k) beim Ausmultiplizieren von (a + b)^n vorkommt.

    Algorithmus: Binomialkoeffizient

    n: Exponent (Standard ist 8 für (a + b)^8)
    k: Potenz von a im gesuchten Term (Standard ist 3 für a^3 * b^5)

    Rückgabe:
    Anzahl der Vorkommen des Terms
    """
    return math.comb(n, k)
```

=== ereignismengen

```py
def ereignismengen():
    """
    Berechnet die Ereignismengen A, B und C basierend auf der Aufgabenstellung.

    Algorithmus: Mengentheorie und Teilbarkeit

    A: Zahlen von 1 bis 100, die durch 8 oder 9 teilbar sind.
    B: Zahlen von 1 bis 100, die durch 9 oder 15 teilbar sind.
    C: Schnittmenge von A und B

    Rückgabe:
    Tuple mit den Mengen A, B und C
    """
    A = {x for x in range(1, 101) if x % 8 == 0 or x % 9 == 0}
    B = {x for x in range(1, 101) if x % 9 == 0 or x % 15 == 0}
    C = A & B
    
    return A, B, C
```

=== bayes_wahrscheinlichkeit

```py
def bayes_wahrscheinlichkeit():
    """
    Berechnet die Wahrscheinlichkeit, dass ein kontrollierter Fahrgast Schwarzfahrer ist.

    Algorithmus: Satz von Bayes

    Rückgabe:
    Wahrscheinlichkeit P(S|K)
    """
    # Gegebene Wahrscheinlichkeiten
    P_S = 0.1  # Schwarzfahrer
    P_E = 0.9  # Ehrliche Fahrgäste
    P_K_given_S = 0.7  # Keine Fahrkarte bei Schwarzfahrern
    P_F_given_S = 0.3  # Gefälschte Fahrkarte bei Schwarzfahrern
    P_K_given_E = 0.05  # Keine Fahrkarte bei ehrlichen Fahrgästen

    # Gesamtwahrscheinlichkeit für kontrollierte Fahrgäste ohne Fahrkarte
    P_K = P_K_given_S * P_S + P_K_given_E * P_E

    # Wahrscheinlichkeit P(S|K)
    P_S_given_K = (P_K_given_S * P_S) / P_K

    return P_S_given_K
```

#pagebreak()

=== laplace_probability

```py
def laplace_probability(favorable_cases, total_cases):
    """
    Berechnet die Laplace-Wahrscheinlichkeit.
    :param favorable_cases: Anzahl der günstigen Fälle
    :param total_cases: Anzahl der möglichen Fälle
    :return: Wahrscheinlichkeit
    """
    return favorable_cases / total_cases
print(laplace_probability(1, 6))  # Würfel: Wahrscheinlichkeit für eine 6
```

=== combinations

```py
import math

def combinations(n, k):
    """
    Berechnet die Anzahl der Varianten (Kombinationen) von k Zügen aus n Kugeln ohne Zurücklegen.
    :param n: Gesamtanzahl der Kugeln
    :param k: Anzahl der zu ziehenden Kugeln
    :return: Anzahl der Kombinationen
    """
    if k > n:
        return 0  # Es können nicht mehr Kugeln gezogen werden als vorhanden
    return math.factorial(n) // (math.factorial(k) * math.factorial(n - k))

# Beispiel: Anzahl der Varianten bei 3 Zügen aus 6 Kugeln
print(combinations(6, 3))  # Ausgabe: 20
```

=== variations_with_replacement

```py
def variations_with_replacement(n, k):
    """
    Berechnet die Anzahl der Varianten (Ziehen mit Zurücklegen und Berücksichtigung der Reihenfolge).
    :param n: Gesamtanzahl der Kugeln
    :param k: Anzahl der Züge
    :return: Anzahl der Varianten
    """
    return n ** k

# Beispiel: Anzahl der Varianten bei 3 Zügen aus 6 Kugeln
print(variations_with_replacement(6, 3))  # Ausgabe: 216
```

=== conditional_probability

```py
def conditional_probability(P_A_and_B, P_B):
    """
    Berechnet die bedingte Wahrscheinlichkeit.
    :param P_A_and_B: Wahrscheinlichkeit von A und B
    :param P_B: Wahrscheinlichkeit von B
    :return: Bedingte Wahrscheinlichkeit
    """
    return P_A_and_B / P_B
print(conditional_probability(0.3, 0.5))  # Beispielwerte für P(A ∩ B) und P(B)
```

#pagebreak()

=== check_independence

```py
def check_independence(P_A, P_B, P_A_and_B):
    """
    Prüft, ob zwei Ereignisse unabhängig sind.
    :param P_A: Wahrscheinlichkeit von A
    :param P_B: Wahrscheinlichkeit von B
    :param P_A_and_B: Wahrscheinlichkeit von A und B
    :return: True, wenn unabhängig, sonst False
    """
    return P_A_and_B == P_A * P_B
print(check_independence(0.5, 0.4, 0.2))  # Prüft Unabhängigkeit
```

=== sensitivity

```py
def sensitivity(true_positives, actual_positives):
    """
    Berechnet die Sensitivität.
    :param true_positives: Anzahl der richtig positiven Fälle
    :param actual_positives: Anzahl aller tatsächlichen positiven Fälle
    :return: Sensitivität
    """
    return true_positives / actual_positives
print(sensitivity(90, 100))  # Sensitivität mit 90 von 100 erkannten Fällen
```

=== specificity

```py
def specificity(true_negatives, actual_negatives):
    """
    Berechnet die Spezifität.
    :param true_negatives: Anzahl der richtig negativen Fälle
    :param actual_negatives: Anzahl aller tatsächlichen negativen Fälle
    :return: Spezifität
    """
    return true_negatives / actual_negatives
print(specificity(180, 200))  # Spezifität mit 180 von 200 erkannten Gesunden
```
