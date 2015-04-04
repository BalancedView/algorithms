"""Simple implementation of Kruskal's Minimum Spanning Tree Algorithm
   In this implementation we only check the cost of the MST but we
   don't store the actual edges. Doing so would be a very simple change
"""

from union_find import UnionFind


class Graph():

    """simple Graph class to run Prim's MST algorithm"""

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
        next(line_seq)
        self.__union_find = UnionFind(num_verticies)
        for line in line_seq:
            yield line

    def process_line(self, line_seq):
        for line in line_seq:
            types = (int, int, float)
            yield tuple(fun(val) for fun, val in zip(types, line.split()))

    def kruskal_mst(self):
        """pick a random start_vertex then extract from heap until empty"""
        total_cost = 0
        edges = (val for val in self.sorted_edges)
        while self.__union_find.sets > 1:
            edge = next(edges)
            if self.__union_find.connected(edge[0], edge[1]):
                continue
            total_cost += edge[2]
            self.__union_find.union(edge[0], edge[1])
        return total_cost

graph = Graph('../test_data/graph/largeEWG.txt')
# print(graph.__union_find)
print(graph.kruskal_mst())
