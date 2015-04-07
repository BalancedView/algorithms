"""Simple implementation of clustering algorithm using
   Kruskal's Minimum Spanning Tree Algorithm as a base
"""

from union_find import UnionFind


class Graph():

    """simple Graph class to run clustering algorithm"""

    def __init__(self, file_name):
        lines = self.get_edges_size(self.open_file(file_name))
        self.sorted_edges = tuple(sorted(self.process_line(lines),
                                         key=lambda edge: edge[2])
                                  )

    def open_file(self, file_name):
        """simple lines generator"""
        with open(file_name) as myfile:
            for line in myfile:
                yield line

    def get_edges_size(self, line_seq):
        """get the number of vertices as given in the first line of file
           setup the vertices as a tuple so we don't waste memory
           populate the __vertecies tuple with lists of tuples of vertex,cost
        """
        num_verticies = int(next(line_seq).split()[0])
        # next(line_seq)
        self._union_find = UnionFind(num_verticies)
        for line in line_seq:
            yield line

    def process_line(self, line_seq):
        for line in line_seq:
            types = (int, int, int)
            yield tuple(fun(val) for fun, val in zip(types, line.split()))

    def clustering(self):
        """ """
        edges = (val for val in self.sorted_edges)
        while self._union_find.sets > 4:
            edge = next(edges)
            if not self._union_find.connected(edge[0], edge[1]):
                self._union_find.union(edge[0], edge[1])
        while self._union_find.connected(edge[0], edge[1]):
            edge = next(edges)
        return edge

graph = Graph('../test_data/graph/clustering1.txt')
# print(graph._union_find)
print(graph.clustering())
