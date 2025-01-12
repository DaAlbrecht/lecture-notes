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

# Beispiele
if __name__ == "__main__":
    # Aufgabe 1: Binomialkoeffizient
    term_count = binomial_term_count()
    print(f"Der Term a^3 * b^5 kommt {term_count}-mal vor.")

    # Aufgabe 2: Mengentheorie
    A, B, C = ereignismengen()
    print(f"Ereignismenge A: {sorted(A)}")
    print(f"Ereignismenge B: {sorted(B)}")
    print(f"Schnittmenge C: {sorted(C)}")

    # Aufgabe 3: Satz von Bayes
    probability = bayes_wahrscheinlichkeit()
    print(f"Die Wahrscheinlichkeit, dass ein kontrollierter Fahrgast Schwarzfahrer ist, beträgt {probability:.2%}.")

