# This Heap expects an object that responds to #id so that it can easily update values

class MinHeap

  def initialize
    @heap = []
    @id_to_position = []
  end

  def add(value)
    value_i = @heap.size
    @id_to_position[value.id] = value_i
    @heap << value
    bubble_up(value_i)
    value
  end

  def delete_at(i)
    i_value = @heap[i]
    @id_to_position[i_value.id] = nil
    @heap[i] = @heap.pop
    bubble_down(i)
    i_value
  end

  def extract_min
    delete_at(0)
  end

  def peek(id)
    @heap[@id_to_position[id]]
  end

  def decrease(meth, value, id)
    value_i = @id_to_position[id]
    @heap[value_i].send(meth, value)
    bubble_up(value_i)
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
    @id_to_position[@heap[child_i].id] = parent_i
    @id_to_position[@heap[parent_i].id] = child_i
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