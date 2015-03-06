=begin
WARNING: Please note that this algorithm uses a recursive version of Depth First Search
With large Graphs if can throw a "stack level too deep" error. I successfully used
this manually increasing the default stack level.
An example of to this in jruby:
jruby -J-Xmn512m -J-Xms2048m -J-Xmx2048m -J-Xss48000k scc_graph.rb
=end

require_relative "../list/stack.rb"

class Graph

  attr_reader :reversed_vertices_adj, :vertices_adj, :visited_verticies, :vertex_dfs_finish, :scc_size

  def initialize(edges_list_file)
    @reversed_vertices_adj = []
    @vertices_adj = []
    @visited_verticies = [true]
    @vertex_dfs_finish = Stack.new
    @scc_size = []
    parse_edges_list(edges_list_file)
  end

  def parse_edges_list(edges_list_file)
    File.open(edges_list_file, "r") do |f|
      f.each do |edge_string|
        edge = edge_string.split("\s").map(&:to_i)

        if @vertices_adj[edge[0]]
          @vertices_adj[edge[0]] << edge[1]
        else
          @vertices_adj[edge[0]] = [edge[1]]
        end
        if @reversed_vertices_adj[edge[1]]
          @reversed_vertices_adj[edge[1]] << edge[0]
        else
          @reversed_vertices_adj[edge[1]] = [edge[0]]
        end
      end
    end
  end

  def depth_first_search(vertex)
    return nil if visited?(vertex)
    mark_visited(vertex)
    if @vertices_adj[vertex]
      @vertices_adj[vertex].each do |connected_vertex|
        unless visited?(connected_vertex)
          depth_first_search(connected_vertex)
        end
      end
    end
    @vertex_dfs_finish.add(vertex)
  end

  def reverse_dfs(vertex)
    return nil if visited?(vertex)
    mark_visited(vertex)
    if @reversed_vertices_adj[vertex]
      @reversed_vertices_adj[vertex].each do |connected_vertex|
        reverse_dfs(connected_vertex)
      end
    end
    @last_scc_size += 1
  end

  def find_top_size_scc
    first_dfs
    reset_visited!
    second_dfs_reverse
  end

  def first_dfs
    @vertices_adj.each_index do |i|
      unless visited?(i)
        depth_first_search(i)
      end
    end
  end

  def second_dfs_reverse
    until @vertex_dfs_finish.empty?
      next_vertex = @vertex_dfs_finish.pop
      unless visited?(next_vertex)
        @last_scc_size = 0
        reverse_dfs(next_vertex)
        trim_scc_array
      end
    end
  end

  private

# this is a very naive implementation to keep the array of SCC down to 5
# it was a simple requirement for a course exercise
  def trim_scc_array
    if @scc_size.size > 0
      @scc_size.sort!
      if @scc_size.size < 5
        if @scc_size.first > @last_scc_size
          @scc_size.push(@last_scc_size)
        else
          @scc_size.unshift(@last_scc_size)
        end
      else
        if @last_scc_size > @scc_size.first
          @scc_size[0] = @last_scc_size
        end
      end
    else
      @scc_size.push(@last_scc_size)
    end
  end

  def reset_visited!
    @visited_verticies = []
  end

  def visited?(vertex)
    !!@visited_verticies[vertex]
  end

  def mark_visited(vertex)
    @visited_verticies[vertex] = true
  end

end

t = Time.now
graph = Graph.new("../test_data/graph/SCC.txt") # I removed this file from the repo because it's 69mb!
# graph = Graph.new("../test_data/graph/scc_test.txt")
# graph = Graph.new("../test_data/graph/test_list.txt")
p "time elapsed #{Time.now - t}"

dfs_t = Time.now
graph.find_top_size_scc

p "time elapsed for 2 * dfs #{Time.now - dfs_t}"

p graph.scc_size
