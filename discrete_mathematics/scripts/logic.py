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
