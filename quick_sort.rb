def quick_sort(array)
  return array if array.size <= 1
  pivot_index = array.size / 2
  sorted_array = quick_sort_helper(array, pivot_index)
  array1 = sorted_array[0..pivot_index-1]
  array2 = sorted_array[pivot_index..array.length-1]
  quick_sort(array1) + quick_sort(array2)
end

def quick_sort_helper(array, pivot_index)
  lesser = []
  greater = []
  pivot = []
  array.each do |e|
    if e > array[pivot_index]
      greater << e
    elsif e < array[pivot_index]
      lesser << e
    else
      pivot << e
    end
  end
  lesser + pivot + greater
end

p quick_sort([1,21,55,6,33,100])
p quick_sort([1,1000,90,1002,100,90,500,100])
