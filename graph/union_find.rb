class UnionFind

  def initialize(size)
    @members = Array.new(size+1) {|i| i }
    @rank = Array.new(size+1, 1)
    @sets = size
  end

  def connected?(node1, node2)
    find_root(node1) == find_root(node2)
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

  def number_of_sets
    @sets
  end

  private

  def find_root(node)
    return node if node == @members[node]
    @members[node] = find_root(@members[node])
  end

end