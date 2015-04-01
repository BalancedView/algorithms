"""Simple implementation of Prim's Minimum Spanning Tree Algorithm
   In this implementation we only check the cost of the MST but we
   don't store the actual edges. Doing so would be a very simple change
"""

from fibonacci_heap_mod import Fibonacci_heap
from random import randint


class Graph():
    """simple Graph class to run Prim's MST algorithm"""
    def __init__(self, file_name):
        self.__heap = Fibonacci_heap()
        self.__vertex_to_heap = dict()
        self.parse_edges_from_file(self.file_lines(file_name))
        self.pre_populate_heap()

    def pre_populate_heap(self):
        """enqueue vertices into the heap with a starting high priority
           we will decrease it later when running prim's algorithm
        """
        for x in range(1, len(self.__vertecies)):
            self.__vertex_to_heap[x] = self.__heap.enqueue(x, 999999999)

    def file_lines(self, file_name):
        """simple lines generator"""
        with open(file_name) as myfile:
            for line in myfile:
                yield line

    def parse_edges_from_file(self, line_seq):
        """get the number of vertices as given in the first line of file
           setup the vertices as a tuple so we don't waste memory
           populate the __vertecies tuple with lists of tuples of vertex,cost
        """
        num_verticies = int(next(line_seq).split()[0])
        self.__vertecies = tuple({'visited': False, 'v': []}
                                 for n in range(num_verticies+1)
                                 )

        for line in line_seq:
            line_list = line.split()
            vertex, neighbor = int(line_list[0]), int(line_list[1])
            cost = int(line_list[2])
            self.__vertecies[vertex]['v'].append((neighbor, cost))
            self.__vertecies[neighbor]['v'].append((vertex, cost))

    def prim_mst(self):
        """pick a random start_vertex then extract from heap until empty"""
        total_cost = 0
        start_vertex = randint(1, len(self.__vertecies)-1)
        self.__heap.delete(self.__vertex_to_heap[start_vertex])
        self.mark_visited(start_vertex)
        self.update_neighbors(start_vertex)
        while self.__heap.m_size > 0:
            total_cost += self.__heap.min().get_priority()
            vertex = self.__heap.dequeue_min().get_value()
            self.mark_visited(vertex)
            self.update_neighbors(vertex)
        return total_cost

    def update_neighbors(self, vertex):
        for neighbor, cost in self.__vertecies[vertex]['v']:
            heap_entry = self.__vertex_to_heap[neighbor]
            if not self.is_visited(neighbor) and cost < heap_entry.get_priority():
                self.__heap.decrease_key(heap_entry, cost)

    def mark_visited(self, vertex):
        self.__vertecies[vertex]['visited'] = True

    def is_visited(self, vertex):
        return self.__vertecies[vertex]['visited']

graph = Graph('../test_data/graph/edges.txt')
print(graph.prim_mst())
