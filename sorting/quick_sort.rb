def quick_sort(array, l_bound=0, u_bound=array.size-1)
  return array if u_bound <= l_bound || l_bound >= u_bound

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

  quick_sort(array, low_up_bound_index, u_bound)
  quick_sort(array, l_bound, low_up_bound_index-2)
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

unsorted_array = (0..100_000).map { |i| rand(100_001) }
p quick_sort(unsorted_array.dup) == unsorted_array.sort
