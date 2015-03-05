#Algorithms in Ruby (mostly) and Javascript

### What is this code?

This is a collection of scripts I put together while exploring different data structures and algorithms. <br>
They include many useful and classic examples that are used in many applications.

### Structure of the repository

I thought it would be useful to divide scripts based either on application or data structure

- Graphs
  - [Union Find](graph/union_find.rb)
  - [Union Find - While vs Recursion Benchmark](graph/union_find_benchmarks.rb)
  - [Find Strong Connected Components in a Graph](graph/scc_graph.rb)
  - [Find the Minimum Cut in a Graph](graph/min_cut_graph.rb)
  - [Use BFS in a Graph to find path in a maze](graph/bfs_shortest_path.rb)
  - [Dijkstra find shortest path for a vertex to all other](graph/dijkstra_shortest_path.rb)

- Tree like structures
  - [Heap (min heap)](tree/min_heap.rb)

- Hash Table
  - [Using a hash table to solve the 2sum problem](hash/2sum.rb)
  - [NOT using a hash table to solve 2sum problem](hash/2sum.rb)
    the code not using the hash table to narrow down the values is not as elegant but about 350% faster!

- List structures
  - [Stack](list/stack.rb)
  - [Queue](list/queue.rb)

- Sorting
  - [Merge Sort](sorting/merge_sort.rb)
    - [Count Inversions Made by Merge Sort](sorting/merge_sort_inversions.rb)
  - [Quick Sort](sorting/quick_sort.rb)
    <br>
    Count Comparisons made by Quick Sort depending on the choice of pivot
    - [Quick Sort - pivot: first element](sorting/quick_sort_comparison_count.rb)
    - [Quick Sort - pivot: last element](sorting/quick_sort_comparison_count_last.rb)
    - [Quick Sort - pivot: median element](sorting/quick_sort_comparison_count_median.rb)
  - [Quick Sort JS](sorting/quick_sort.js)

all the data used can be found in the [test_data directory](test_data)
