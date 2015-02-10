def merge_sort_inv(array)
  return [array, 0] if array.size < 2

  mid_index = (array.size) / 2
  first_half, first_inv = merge_sort_inv(array[0..mid_index-1])
  second_half, second_inv = merge_sort_inv(array[mid_index..-1])
  first_index = 0
  second_index = 0
  inversions = first_inv + second_inv

  0.upto(array.size-1) do |index|
    return [array[0..index-1] + second_half[second_index..-1], inversions]unless first_half[first_index]
    return [array[0..index-1] + first_half[first_index..-1], inversions]unless second_half[second_index]

    if first_half[first_index] < second_half[second_index]
      array[index] = first_half[first_index]
      first_index += 1
    else
      array[index] = second_half[second_index]
      second_index += 1
      inversions += first_half.size - first_index
    end
  end
  [array, inversions]
end

parse = Proc.new {|n| n.chomp; n.to_i }
unsorted_list = File.readlines('unsorted_list.txt').map(&parse)

p merge_sort_inv(unsorted_list)[1]
