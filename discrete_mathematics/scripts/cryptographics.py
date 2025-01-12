import random
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






# Diffie-Hellman-Schlüsselaustausch

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
