require_relative "max_heap"
require_relative "min_heap"

class MedianHeap

  def initialize
    @low = MaxHeap.new
    @high = MinHeap.new
  end

  def add(el)
    if size < 2
      @high.add(el)
    else
      if el <= @low[0]
        @low.add(el)
      else
        @high.add(el)
      end
    end
    rebalance_heaps
  end

  def peek_median
    if @low.size == @high.size
      @low[0]
    else
      @high[0]
    end
  end

  def size
    @low.size + @high.size
  end

  def rebalance_heaps
    modifier = size.even? ? 0 : 1
    until @low.size + modifier == @high.size
      if @low.size + modifier > @high.size
        @high.add(@low.extract_max)
      else
        @low.add(@high.extract_min)
      end
    end
  end
end

median_heap = MedianHeap.new
median_sum = 0

File.open('../test_data/tree/Median.txt') do |file|
  file.each do |num_string|
    median_heap.add(num_string.to_i)
    median_sum += median_heap.peek_median
  end
end
  p median_sum % 10_000
