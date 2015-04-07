import numpy as np


class UnionFind(object):
    """simple implementation of UnionFind algorithm
       initialize members, rank and number of sets"""
    def __init__(self, size=2**24, arr=None):
        self.members = np.arange(size)
        self.rank = np.ones(size, dtype=int)
        self.sets = len(arr.nonzero()[0])

    def connected(self, node1, node2):
        """simply compare if 2 nodes have the same root"""
        return self.find_root(node1) == self.find_root(node2)

    def union(self, node1, node2):
        """find root of both nodes and return if they are already
           the same.
           Otherwise we need to unite them, in this case decrease
           the number of sets.
           Than simply change the root of the node which has lower rank"""
        root1 = self.find_root(node1)
        root2 = self.find_root(node2)

        if root1 == root2:
            return None

        self.sets -= 1

        if self.rank[root1] < self.rank[root2]:
            self.members[root1] = root2
        else:
            if self.rank[root1] == self.rank[root2]:
                self.rank[root1] += 1
            self.members[root2] = root1

    def find_root(self, node):
        """This implementation is the path compression principle
           of the UnionFind data structure. As we search for the root
           and go up the 'chain' we compress the path by assigning the
           root of each node to the root of their parent."""
        while node != self.members[node]:
            self.members[node] = self.members[self.members[node]]
            node = self.members[node]
        return node
