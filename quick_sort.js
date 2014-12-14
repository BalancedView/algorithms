function quick_sort (array, l_bound, h_bound) {
  l_bound = (typeof l_bound === "undefined") ? 0 : l_bound;
  h_bound = (typeof h_bound === "undefined") ? array.length -1 : h_bound;
  if ( h_bound <= l_bound || l_bound >= h_bound )return array;

  var pivot_index = ~~((h_bound + l_bound) / 2);
  var pivot_val = array[pivot_index];

  var partitioned_array = [pivot_val];
  var new_pivot_index = l_bound;

  for (var i = h_bound; i >= l_bound; i--) {
    if (i !== pivot_index) {
      if (array[i] <= pivot_val) {
        partitioned_array.unshift(array[i]);
        new_pivot_index += 1;
      } else {
        partitioned_array.push(array[i]);
      }
    }
  }
  var args = [l_bound,(h_bound-l_bound+1)].concat(partitioned_array);
  array.splice.apply(array, args);

  array = quick_sort(array, new_pivot_index+1, h_bound);
  return quick_sort(array, l_bound, new_pivot_index-1);

}

console.log(quick_sort([2,8,3,7,45,77,4,5,6]));