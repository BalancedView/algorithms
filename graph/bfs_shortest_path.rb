require_relative "../primitives/queue.rb"

class Graph

  attr_reader :vertices_adj, :start, :goal, :path, :path_cost, :visited_verticies

  def initialize(map_array)
    @vertices_adj = []
    @row_size = map_array[0].size
    @col_size = map_array.size
    @map_string = map_array.join
    @start = @map_string.index("S")
    @goal = @map_string.index("G")
    @wall = '#'
    parse_map_to_adjlist
  end

  def parse_map_to_adjlist
    @map_string.each_char.with_index do |cell_value, i|
      @vertices_adj[i] = [cell_value]
      next if cell_value == @wall

      add_row_neighbors(i)
      add_col_neighbors(i)

    end
  end

  def bfs(start=@start)
    @visited_verticies = []
    @path_cost = []
    @path = []

    @visited_verticies[start] = true
    @path_cost[start] = 0
    @path[start] = []
    @queue = Queue.new
    enqueue_node_with_origin(@vertices_adj[start][1..-1], start)
    until @queue.empty?
      node, from = @queue.dequeue
      @visited_verticies[node] = true
      @path_cost[node] = @path_cost[from] + 1
      @path[node] = @path[from] + [from]
      if node == @goal
        return true
      else
        enqueue_node_with_origin(@vertices_adj[node][1..-1], node)
      end
    end
    return false
  end

  def render_path
    string = @map_string.dup
    @path[@goal][1..-1].each do |path_cell|
      string[path_cell] = "o"
    end
    string.gsub('.',' ').each_char.each_slice(@row_size) do |row|
      puts row.join(' ')
    end
  end

  private

  def add_row_neighbors(index)
    col_position = index/ @row_size
    [index-1, index+1].each do |neighbor|
      next if (neighbor / @row_size != col_position) || @map_string[neighbor] == @wall
      @vertices_adj[index] << neighbor
    end
  end

  def add_col_neighbors(index)
    [index-@row_size, index+@row_size].each do |neighbor|
      next if (not (0..@map_string.size-1) === neighbor) || @map_string[neighbor] == @wall
      @vertices_adj[index] << neighbor
    end
  end

  def enqueue_node_with_origin(destinations, origin)
    destinations.each do |to|
      next if @visited_verticies[to]
      @queue.enqueue([to, origin])
    end
  end


end

map_array = [
  '####################',
  '#..................#',
  '#....######.#......#',
  '#...........#####.##',
  '#########...#......#',
  '#...........#.G.##.#',
  '#..##########...#..#',
  '#........S..#####..#',
  '#...........#......#',
  '#...........#.######',
  '#...........#......#',
  '#...........######.#',
  '#..................#',
  '####################'
]


t = Time.now
graph = Graph.new(map_array)
if graph.bfs
  puts "The total steps from start to goal are #{graph.path_cost[graph.goal] -1}"
  puts
  graph.render_path
  puts
end
puts "time elapsed #{Time.now - t}"
