def init
  @num_set = []
  @t_values = {}
end

def parse_input(file_path, t)
  File.open(file_path, "r") do |f|
    f.each do |num_string|
      @num_set << num_string.chomp.to_i
    end
  end
  @num_set.sort!
end

def find_xy(t, t_min, t_max)
  min_ptr = 0
  max_ptr = @num_set.size-1

  first_x = @num_set[0]
  y_min = t_min - first_x

  while @num_set[min_ptr] < y_min
    break if min_ptr >= max_ptr
    min_ptr += 1
  end

  @num_set.each.with_index do |num_x, i|
    break if i >= max_ptr

    y_max = t_max - num_x
    y_min = t_min - num_x
    while @num_set[max_ptr] > y_max
      break if max_ptr <= min_ptr
      max_ptr -= 1
    end

    while @num_set[min_ptr] > y_min
      break if min_ptr <= 0
      min_ptr -= 1
    end

    min_ptr.upto(max_ptr) do |index|
      num_y = @num_set[index]
      next if num_x == num_y
      sum = num_x + num_y
      if sum.between?(t_min, t_max)
        @t_values[sum] = true
      end
    end
  end
  @t_values.size
end

t_min = -10_000
t_max = 10_000
t = t_max - t_min

require 'benchmark'

Benchmark.bmbm do |x|
  x.report("init") { init }
  x.report("parse") { parse_input("../test_data/hash/2sum.txt", t) }
  x.report("find t") { find_xy(t, t_min, t_max) }
end

# Rehearsal ------------------------------------------
# init     0.000000   0.000000   0.000000 (  0.000003)
# parse    0.610000   0.010000   0.620000 (  0.626267)
# find t   0.410000   0.000000   0.410000 (  0.410478)
# --------------------------------- total: 1.030000sec

#              user     system      total        real
# init     0.000000   0.000000   0.000000 (  0.000004)
# parse    0.600000   0.010000   0.610000 (  0.617578)
# find t   0.420000   0.000000   0.420000 (  0.417428)
