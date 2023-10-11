import os
import networkx as nx
import pydot

def load_dot_file(file_path):
    graph = pydot.graph_from_dot_file(file_path)[0]
    nx_graph = nx.DiGraph()

    for edge in graph.get_edge_list():
        source = edge.get_source()
        target = edge.get_destination()
        nx_graph.add_edge(source, target)

    return nx_graph

def are_dot_files_equivalent(file1, file2):
    try:
        g1 = load_dot_file(file1)
        g2 = load_dot_file(file2)
    except Exception as e:
        print(e)
        return False
    
    return nx.is_isomorphic(g1, g2)


def diff(file1Name, file2Name):
    if not are_dot_files_equivalent(file1Name, file2Name):
        print(file1Name + " is different from " + file2Name)

entries = os.listdir('graph/k_10/to_600/')
for i in range(9,10):
    for entry in entries:
        if not entry.endswith("pdf") and not entry.endswith("txt"):
            diff("graph/k_10/to_600/" + entry, "graph/k_{}/to_600/".format(i) + entry)