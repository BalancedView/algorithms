function quick_sort (array, l_bound, u_bound) {
  l_bound = (typeof l_bound === "undefined") ? 0 : l_bound;
  u_bound = (typeof u_bound === "undefined") ? array.length -1 : u_bound;
  if ( u_bound <= l_bound || l_bound >= u_bound ) return array;

  var pivot_index = l_bound
  var pivot_val = array[pivot_index]
  var low_up_bound_index = l_bound+1

  for (var i = l_bound + 1 ; i <= u_bound; i++) {
    if (array[i] <= pivot_val) {
      var swap_value = array[i];
       array[i] = array[low_up_bound_index];
      array[low_up_bound_index] = swap_value;
      low_up_bound_index += 1
    }
  }

  var swap_pivot = array[pivot_index];
  array[pivot_index] = array[low_up_bound_index-1];
  array[low_up_bound_index-1] = swap_pivot;

  quick_sort(array, low_up_bound_index, u_bound)
  return quick_sort(array, l_bound, low_up_bound_index-2);

}

console.log(quick_sort([2,8,3,7,45,77,4,5,6, 22, 43, 56, 65, 102, 23, 45, 99]));