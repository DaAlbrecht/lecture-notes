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
