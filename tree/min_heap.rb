class MinHeap

  def initialize
    @heap = []
  end

  def add(value)
    value_i = @heap.size
    @heap << value
    bubble_up(value_i)
    value
  end

  def delete(i=0)
    i_value = @heap[i]
    @heap[i] = @heap.pop
    bubble_down(i)
    i_value
  end

  def to_s
    levels = Math.log2(@heap.size).floor
    print " " * (1 << levels)
    puts @heap[0]
    1.upto(levels) do |n|
      start_i = (1 << n) - 1
      print " " * (1 << levels-n+1)
      @heap[start_i..(start_i << 1)].each do |val|
        print val
        print " "
      end
      puts
    end
  end

  private

  def left(i)
    @heap[2*i+1]
  end

  def left_i(i)
    2*i+1
  end

  def right(i)
    @heap[2*i+2]
  end

  def right_i(i)
    2*i+2
  end

  def parent(i)
    return i if i == 0
    if i.odd?
      i / 2
    else
      i / 2 - 1
    end
  end

  def children_smaller?(parent_i)
    left(parent_i) && @heap[parent_i] > left(parent_i) or
    right(parent_i) && @heap[parent_i] > right(parent_i)
  end

  def swap_at(child_i, parent_i)
    @heap[child_i], @heap[parent_i] = @heap[parent_i], @heap[child_i]
  end

  def bubble_up(value_i)
    parent_i = parent(value_i)
    while @heap[value_i] < @heap[parent_i]
      swap_at(value_i, parent_i)
      value_i = parent_i
      parent_i = parent(parent_i)
    end
  end

  def bubble_down(parent_i)
    while children_smaller?(parent_i)
      if (left(parent_i) or Float::INFINITY) < (right(parent_i) or Float::INFINITY)
        swap_at(left_i(parent_i), parent_i)
        parent_i = left_i(parent_i)
      else
        swap_at(right_i(parent_i), parent_i)
        parent_i = right_i(parent_i)
      end
    end
  end

end