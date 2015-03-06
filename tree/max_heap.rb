# NOTES:
# The heap uses #object_id to track at what index the values are in the array
# The initialize takes:
#  - an optional array that can be "heapified"
#  - an optional priority_meth_sym a symbol that will be sent to the object to determine its priority
#  - an optional update_meth_sym that will be used when using decrease_key, if no method is passed the value will replace the object itself

class MaxHeap

  def initialize(array=[], priority_meth_sym=:itself, update_meth_sym=nil)
    @heap = array
    @id_to_index = {}
    @priority_sym = priority_meth_sym
    @update_sym = update_meth_sym
    heapify!
  end

  def add(value)
    value_i = @heap.size
    @id_to_index[value.object_id] = value_i
    @heap << value
    bubble_up(value_i)
    value
  end

  def delete_at(i)
    value = @heap[i]
    @id_to_index.delete(value.object_id)
    new_value = @heap.pop
    return value if @heap.empty?
    @heap[i] = new_value
    bubble_down(i)
    value
  end

  def extract_max
    delete_at(0)
  end

  def index_of(obj)
    @id_to_index[obj.object_id]
  end

  def [](index)
    @heap[index]
  end

  def increase_key(obj, value)
    value_i = index_of(obj)
    if @update_sym
      @heap[value_i].send(@update_sym, value)
    else
      @heap[value_i] = value
    end
    bubble_up(value_i)
  end

  def empty?
    @heap.empty?
  end

  def heapify!
    return true if @heap.empty?
    (@heap.size-1).downto(1) do |i|
      bubble_up(i)
    end
    @heap.each.with_index do |value, i|
      @id_to_index[value.object_id] || @id_to_index[value.object_id] = i
    end
  end

  def size
    @heap.size
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

  def children_bigger?(parent_i)
    left(parent_i) && priority(@heap[parent_i]) < priority(left(parent_i)) or
    right(parent_i) && priority(@heap[parent_i]) < priority(right(parent_i))
  end

  def swap_at(child_i, parent_i)
    @id_to_index[@heap[child_i].object_id] = parent_i
    @id_to_index[@heap[parent_i].object_id] = child_i
    @heap[child_i], @heap[parent_i] = @heap[parent_i], @heap[child_i]
  end

  def bubble_up(value_i)
    parent_i = parent(value_i)
    while priority(@heap[value_i]) > priority(@heap[parent_i])
      swap_at(value_i, parent_i)
      value_i = parent_i
      parent_i = parent(parent_i)
    end
  end

  def bubble_down(parent_i)
    while children_bigger?(parent_i)
      if (priority(left(parent_i)) or -Float::INFINITY) > (priority(right(parent_i)) or -Float::INFINITY)
        swap_at(left_i(parent_i), parent_i)
        parent_i = left_i(parent_i)
      else
        swap_at(right_i(parent_i), parent_i)
        parent_i = right_i(parent_i)
      end
    end
  end

  def priority(obj)
    obj.send(@priority_sym) if obj
  end
end
