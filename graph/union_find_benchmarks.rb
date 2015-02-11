class UnionFind

  def initialize(size)
    @members = Array.new(size+1) {|i| i }
    @rank = Array.new(size+1, 1)
    @sets = size
  end

  def connected?(node1, node2)
    find_root(node1) == find_root(node2)
  end

  def connected_r?(node1, node2)
    find_root_r(node1) == find_root_r(node2)
  end

  def union(node1, node2)
    root1 = find_root(node1)
    root2 = find_root(node2)
    return nil if root1 == root2

    @sets -= 1

    if @rank[root1] < @rank[root2]
      @rank[root2] += @rank[root1]
      @members[root1] = root2
    else
      @rank[root1] += @rank[root2]
      @members[root2] = root1
    end
  end

  def union_r(node1, node2)
    root1 = find_root_r(node1)
    root2 = find_root_r(node2)
    return nil if root1 == root2

    @sets -= 1

    if @rank[root1] < @rank[root2]
      @rank[root2] += @rank[root1]
      @members[root1] = root2
    else
      @rank[root1] += @rank[root2]
      @members[root2] = root1
    end
  end

  def number_of_sets
    @sets
  end

  private

  def find_root(node)
    while node != @members[node]
      @members[node] = @members[@members[node]]
      node = @members[node]
    end
    node
  end

  def find_root_r(node)
    return node if node == @members[node]
    @members[node] = find_root(@members[node])
  end

end


require 'benchmark'

uf = UnionFind.new(10_000_000)

Benchmark.bmbm do |x|
  x.report("while find_root") do
    uw = uf.dup
    srand 12345
    1_000_000.times do
      uw.union(rand(2_500_000),rand(2_500_001..5_000_000))
      uw.union(rand(5_000_001..7_500_000),rand(7_500_001..10_000_000))
    end
    1_000_000.times do
      uw.union(rand(5_000_000),rand(5_000_001..10_000_000))
    end
    1_000_000.times do
      uw.connected?(rand(5_000_000),rand(5_000_001..10_000_000))
    end
  end
  x.report("recursive find_root") do
    ur = uf.dup
    srand 12345
    1_000_000.times do
      ur.union_r(rand(2_500_000),rand(2_500_001..5_000_000))
      ur.union_r(rand(5_000_001..7_500_000),rand(7_500_001..10_000_000))
    end
    1_000_000.times do
      ur.union_r(rand(5_000_000),rand(5_000_001..10_000_000))
    end
    1_000_000.times do
      ur.connected_r?(rand(5_000_000),rand(5_000_001..10_000_000))
    end
  end
end
