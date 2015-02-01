def quick_sort(array, l_bound=0, u_bound=array.size-1)
  return array if u_bound <= l_bound || l_bound >= u_bound
  pivot_index = l_bound
  pivot_val = array[pivot_index]
  low_up_bound_index = l_bound+1

  (l_bound+1).upto(u_bound) do |index|
    if array[index] <= pivot_val
      array[low_up_bound_index], array[index] = array[index], array[low_up_bound_index]
      low_up_bound_index += 1
    end
  end
  array[pivot_index], array[low_up_bound_index-1] = array[low_up_bound_index-1], array[pivot_index]

  array = quick_sort(array, low_up_bound_index, u_bound)
  quick_sort(array, l_bound, low_up_bound_index-2)
end

p quick_sort([1,21,55,6,33,100]) == [1, 6, 21, 33, 55, 100]
