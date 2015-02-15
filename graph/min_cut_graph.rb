require_relative "union_find"

class Graph

  attr_reader :union_find, :edges, :min_cut_count

  def initialize(adj_list_file)
    @verticies_size = nil
    @edges = []
    @union_find = nil
    @min_cut_count = Float::INFINITY
    init_edges(parse_verticies_adj_list(adj_list_file))
  end

  def parse_verticies_adj_list(adj_list_file)
    list = File.readlines(adj_list_file)
    list.each_index { |i| list[i] = list[i].chomp.split("\s").map(&:to_i)[1..-1] }
    @verticies_size = list.size
    # prepend nil value so that I can treat indexes as the vertex value 1 to N
    list.unshift(nil)
    list
  end

  def init_edges(adj_list)
    1.upto(adj_list.size-1) do |vertex|
      adj_list[vertex].each do |connected_vertex|
        @edges << [vertex, connected_vertex]
        adj_list[connected_vertex].delete(vertex)
      end
    end
  end

  def cut_graph
    @union_find = UnionFind.new(@verticies_size)
    @edges.shuffle!
    edges_enum = @edges.each
    until @union_find.number_of_sets == 2
      v1,v2 = edges_enum.next
      @union_find.union(v1, v2)
    end
  end

  def count_cross_edges
    count = 0
    @edges.each do |edge|
      unless @union_find.connected?(edge[0], edge[1])
        count += 1
      end
    end
    if count < @min_cut_count && count > 0
      @min_cut_count = count
    end
  end

  def find_min_cut(n_times=nil)
    if n_times
      (n_times).times do
        cut_graph
        count_cross_edges
      end
    else
      (@verticies_size**2 / 2).times do
        cut_graph
        count_cross_edges
      end
    end
  end
end

graph = Graph.new("../test_data/graph/kargerMinCut.txt")
# graph = Graph.new("../test_data/graph/test_list1.txt")
# graph = Graph.new("../test_data/graph/test_list.txt")

t = Time.now
    graph.find_min_cut
p "time elapsed #{Time.now - t}"

p "min cut count is #{graph.min_cut_count}"

