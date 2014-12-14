def quick_sort(array, l_bound=0, h_bound=array.size-1)
  return array if h_bound <= l_bound || l_bound >= h_bound
  pivot_index = (h_bound + l_bound) / 2
  pivot_val = array[pivot_index]

  partitioned_array = [pivot_val]
  new_pivot_index = l_bound

  l_bound.upto(h_bound) do |index|
    next if index == pivot_index
    if array[index] <= pivot_val
      partitioned_array.unshift(array[index])
      new_pivot_index += 1
    else
      partitioned_array << array[index]
    end
  end
  array[l_bound..h_bound] = partitioned_array
  array = quick_sort(array, new_pivot_index+1, h_bound)
  quick_sort(array, l_bound, new_pivot_index-1)
end