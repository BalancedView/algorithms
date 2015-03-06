def init
  @num_buckets = {}
  @num_array = []
  @t_values = {}
end

def parse_input(file_path, t)
  File.open(file_path, "r") do |f|
    f.each do |num_string|
      num = num_string.to_i
      if @num_buckets[num/t]
        @num_buckets[num/t] << num
      else
        @num_buckets[num/t] = [num]
      end
      @num_array << num
    end
  end
end

def find_xy(t, t_min, t_max)
  @num_array.each do |num_x|
    y_bucket = (t_min - num_x) / t
    y_bucket.upto(y_bucket+1) do |bucket|
      if @num_buckets[bucket]
        @num_buckets[bucket].each do |num_y|
          next if num_x == num_y
          sum = num_x + num_y
          if sum.between?(t_min, t_max)
            @t_values[sum] = true
          end
        end
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
# init     0.000000   0.000000   0.000000 (  0.000004)
# parse    1.350000   0.050000   1.400000 (  1.400130)
# find t   1.800000   0.010000   1.810000 (  1.805925)
# --------------------------------- total: 3.210000sec

#              user     system      total        real
# init     0.000000   0.000000   0.000000 (  0.000005)
# parse    1.290000   0.050000   1.340000 (  1.338514)
# find t   1.780000   0.000000   1.780000 (  1.781879)
