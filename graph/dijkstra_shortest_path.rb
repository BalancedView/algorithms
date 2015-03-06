require_relative "../tree/min_heap.rb"

class Vertex

  attr_accessor :distance, :from, :neighbors, :id

  def initialize(args)
    @id = args[:id]
    @from = args[:from]
    @distance = args[:distance] || 1_000_000
    @neighbors = args[:neighbors] || []
    @visited = args[:visited] || false
  end

  def visited?
    @visited
  end

  def mark_visited
    @visited = true
  end
end


class Graph

  attr_reader :vertices, :heap

  def initialize(adj_list_file, start=1)
    @frontier = nil
    @vertices = []
    @start_index = start
    parse_verticies_adj_list(adj_list_file)
  end

  def parse_verticies_adj_list(adj_list_file)
    File.open(adj_list_file, "r") do |f|
      f.each do |vertex_adj_string|
        string_array = vertex_adj_string.split(/\s/)
        vertex_id = string_array[0].to_i
        @vertices[vertex_id] = Vertex.new(
            id: vertex_id,
            neighbors: string_array[1..-1].map { |string| string.split(/,/).map(&:to_i) }
          )
      end
    end
    @frontier = MinHeap.new(@vertices[2..-1], :distance, :distance=)
  end

  def dijkstra
    start_vertex = @vertices[@start_index]
    start_vertex.distance = 0
    start_vertex.mark_visited
    start_vertex.neighbors.each do |neighbor|
      neighbor_i, neighbor_dis = neighbor
      @vertices[neighbor_i].from = @start_index
      @frontier.decrease_key(@vertices[neighbor_i], neighbor_dis)
    end
    until @frontier.empty?
      current_vertex = @frontier.extract_min
      current_vertex.mark_visited
      current_vertex.neighbors.each do |neighbor|
        neighbor_i, distance_to_neighbor = neighbor
        next if @vertices[neighbor_i].visited?
        new_distance = current_vertex.distance + distance_to_neighbor
        if new_distance < @vertices[neighbor_i].distance
          @vertices[neighbor_i].from = current_vertex.id
          @frontier.decrease_key(@vertices[neighbor_i], new_distance)
        end
      end

    end
  end

end


t = Time.now
graph = Graph.new("../test_data/graph/dijkstraData.txt")
graph.dijkstra

puts "time elapsed #{Time.now - t}"
graph.vertices[1..-1].sort_by(&:distance).each { |e| p [e.id, e.from, e.distance] }
