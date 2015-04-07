"""Simple implementation of clustering algorithm using
   bit hamming to determine verticies distance
"""

import os
import sys
misc_path = os.path.abspath(os.path.join('..', 'misc'))
sys.path.append(misc_path)
from bitmasks import bitmasks
from union_find_clustering import UnionFind
import numpy as np
import itertools

class Graph():

    """simple Graph class to run clustering algorithm"""

    def __init__(self, file_name):
        self._verticies = np.zeros(2**24, dtype=bool)
        self.process_lines(file_name)
        self._bitmasks = [i for i in itertools.chain(bitmasks(24,2),
                                                     bitmasks(24,1))]

    def process_lines(self, file_name):
        with open(file_name) as myfile:
            for line in myfile:
                self._verticies[int("".join(line.split()), base=2)] = True
        self._union_find = UnionFind(arr=self._verticies)

    def clustering(self):
        """ """
        for vertex in self._verticies.nonzero()[0]:
            for mask in self._bitmasks:
                if self._verticies[vertex ^ mask]:
                    self._union_find.union(vertex, vertex^mask)
        return self._union_find.sets

    def clustering_numpy(self):
        """ """
        verticies = self._verticies.nonzero()[0]
        for mask in self._bitmasks:
            for v_index, connected_vertex in enumerate(verticies ^ mask):
                if self._verticies[connected_vertex]:
                    self._union_find.union(verticies[v_index], connected_vertex)
        return self._union_find.sets

# import profile
graph = Graph('../test_data/graph/clustering_big.txt')
# profile.run("graph.clustering()")
# profile.run("print(graph.clustering_numpy())")

print(graph.clustering_numpy())
