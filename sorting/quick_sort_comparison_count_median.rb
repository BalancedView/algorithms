def quick_sort(array, l_bound=0, u_bound=array.size-1, count=array.size-1)
  return [array, count] if u_bound <= l_bound || l_bound >= u_bound

  median_index = select_median_pivot(array, l_bound, u_bound)
  pivot_val = array[median_index]
  array[median_index], array[l_bound] = array[l_bound], array[median_index]
  pivot_index = l_bound
  low_up_bound_index = l_bound+1

  (l_bound+1).upto(u_bound) do |index|
    if array[index] <= pivot_val
      array[low_up_bound_index], array[index] = array[index], array[low_up_bound_index]
      low_up_bound_index += 1
    end
  end
  array[pivot_index], array[low_up_bound_index-1] = array[low_up_bound_index-1], array[pivot_index]

  first_part_size = u_bound > low_up_bound_index ? u_bound-low_up_bound_index : 0
  second_part_size = low_up_bound_index-2 > l_bound ? low_up_bound_index-2 - l_bound : 0
  array, new_count = quick_sort(array, low_up_bound_index, u_bound, count+first_part_size)
  quick_sort(array, l_bound, low_up_bound_index-2, new_count+second_part_size)
end

def select_median_pivot(array, l_bound, u_bound)
  mid_index = (u_bound + l_bound) / 2
  if array[mid_index].between?(array[l_bound], array[u_bound]) ||
     array[mid_index].between?(array[u_bound], array[l_bound])
    mid_index
  elsif array[l_bound].between?(array[mid_index], array[u_bound]) ||
        array[l_bound].between?(array[u_bound], array[mid_index])
    l_bound
  else
    u_bound
  end
end

parse = Proc.new {|n| n.chomp; n.to_i }
quick_sort_list = File.readlines('QuickSort.txt').map(&parse)
test_case = File.readlines('1000.txt').map(&parse)

p quick_sort([1,2,3,4,7,5,3,5])
p quick_sort(test_case)[1]
p quick_sort(quick_sort_list)[1]

