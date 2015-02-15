def quick_sort(array, l_bound=0, u_bound=array.size-1, count=array.size-1)
  return [array, count] if u_bound <= l_bound || l_bound >= u_bound
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

  first_part_size = u_bound > low_up_bound_index ? u_bound-low_up_bound_index : 0
  second_part_size = low_up_bound_index-2 > l_bound ? low_up_bound_index-2 - l_bound : 0
  array, new_count = quick_sort(array, low_up_bound_index, u_bound, count+first_part_size)
  quick_sort(array, l_bound, low_up_bound_index-2, new_count+second_part_size)
end

parse = Proc.new {|n| n.chomp; n.to_i }
quick_sort_list = File.readlines('../test_data/sorting/QuickSort.txt').map(&parse)
test_case = File.readlines('../test_data/sorting/1000.txt').map(&parse)

p quick_sort([5,1,2,3,4])
p quick_sort(quick_sort_list)
# p quick_sort([1,21,55,6,33,100]) #== [1, 6, 21, 33, 55, 100]
# p quick_sort([1,1000,90,1002,100,90,500,100]) #== [1, 90, 90, 100, 100, 500, 1000, 1002]
