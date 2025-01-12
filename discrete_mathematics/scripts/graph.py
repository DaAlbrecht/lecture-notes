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
