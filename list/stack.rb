class Stack

  def initialize
    @stack = []
  end

  def add(el)
    @stack << el
  end

  def pop
    @stack.pop
  end

  def peek
    @stack[-1]
  end

  def empty?
    @stack.empty?
  end
end