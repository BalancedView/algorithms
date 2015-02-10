def merge_sort(array)
  return array if array.size < 2

  mid_index = (array.size) / 2
  first_half = merge_sort(array[0..mid_index-1])
  second_half = merge_sort(array[mid_index..-1])
  first_index = 0
  second_index = 0
  inversions = 0

  0.upto(array.size-1) do |index|
    return array[0..index-1] + second_half[second_index..-1] unless first_half[first_index]
    return array[0..index-1] + first_half[first_index..-1] unless second_half[second_index]

    if first_half[first_index] < second_half[second_index]
      array[index] = first_half[first_index]
      first_index += 1
    else
      array[index] = second_half[second_index]
      second_index += 1
    end
  end
  array
end

p merge_sort([2,1,6,4,7,5,3])
