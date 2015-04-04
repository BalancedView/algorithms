"""Simple implementation of Prim's Minimum Spanning Tree Algorithm
   In this implementation we only check the cost of the MST but we
   don't store the actual edges. Doing so would be a very simple change
"""

from fibonacci_heap_mod import Fibonacci_heap
from random import randint
import threading
import queue
import sys
import itertools

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
        for x in range(1, len(self.__vertices)):
            self.__vertex_to_heap[x] = self.__heap.enqueue(x, 999999999)

    def file_lines(self, file_name):
        """simple lines generator"""
        with open(file_name) as myfile:
            for line in myfile:
                yield line

    def process_lines(self, in_queue, out_queue):

        while True:
            line = in_queue.get()

            # exit signal
            if line is None:
                return
            line_list = line.split()
            # if len(line_list) == 3:
            vertex, neighbor = int(line_list[0]), int(line_list[1])
            cost = float(line_list[2])
            out_queue.put(vertex, neighbor, cost)
            in_queue.task_done()

    def parse_edges_from_file(self, line_seq):
        """get the number of vertices as given in the first line of file
           setup the vertices as a tuple so we don't waste memory
           populate the __vertices tuple with lists of tuples of vertex,cost
        """
        num_vertices = int(next(line_seq).split()[0])
        self.__vertices = [{ 'visited': False, 'v':[]}
                                 for n in range(num_vertices+1)]

    def prim_mst(self):
        """pick a random start_vertex then extract from heap until empty"""
        total_cost = 0
        start_vertex = randint(1, len(self.__vertices)-1)
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
        for neighbor, cost in self.__vertices[vertex]['v']:
            heap_entry = self.__vertex_to_heap[neighbor]
            if not self.is_visited(neighbor) and cost < heap_entry.get_priority():
                self.__heap.decrease_key(heap_entry, cost)

    def vertices(self):
        return self.__vertices

    def mark_visited(self, vertex):
        self.__vertices[vertex]['visited'] = True

    def is_visited(self, vertex):
        return self.__vertices[vertex]['visited']


if __name__ == "__main__":
    graph = Graph('../test_data/graph/largeEWG.txt')
    num_workers = 6

    work_queue = queue.Queue()
    results = queue.Queue()

    # start for workers
    pool = []
    for i in range(num_workers):
        t = threading.Thread(target=graph.process_lines, args=(work_queue, results))
        t.daemon = True
        t.start()

    # produce data
    with open("../test_data/graph/largeEWG.txt") as f:
        iters = itertools.chain(f, (None,)*num_workers)
        next(iters)
        next(iters)
        for line in iters:
            work_queue.put(line)


    work_queue.join()

    for i in range(results._qsize()):

        print(results.get())
    sys.exit()
    # print(graph.prim_mst())
