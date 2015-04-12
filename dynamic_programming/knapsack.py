"""the classic knapsack algorithm using dynamic programming
   INPUT: a list of tuples where each tuple has 2 elements
          (value, weight)
   OUTPUT: with 2 values -> (max_value, selected_items)
   NOTE: if there are multiple combination of possible items
         the algorithm will only return one of them
"""


def knapsack(capacity, items_list):
    values_weights = [[0] * (capacity + 1) for _ in range(len(items_list))]
    items_list_enum = (enumerate(items_list))
    # process the first item separately
    # since it has nothing to inherit from any previous items
    index, item = next(items_list_enum)
    for weight_i in range(1, capacity + 1):
        if weight_i >= item[1]:
            values_weights[index][weight_i] = item[0]
    # iterate through values and compute the best value
    # for each value and any previous items
    for (index, item) in items_list_enum:
        for weight_i in range(1, capacity + 1):
            if weight_i >= item[1] and \
               values_weights[index - 1][weight_i - item[1]] + item[0] > \
               values_weights[index - 1][weight_i]:
                    values_weights[index][weight_i] = \
                     values_weights[index - 1][weight_i - item[1]] + item[0]
            else:
                values_weights[index][weight_i] = \
                  values_weights[index - 1][weight_i]

    # set up empty list to accumulate selected items
    # then loop through the values_weights backwards
    selected_items = []
    val_i = len(values_weights) - 1
    weight_i = capacity
    while weight_i > 0:
        current_val = values_weights[val_i][weight_i]
        prev_val = values_weights[val_i - 1][weight_i]
        if current_val > prev_val:
            selected_items.append(items_list[val_i])
            weight_i = weight_i - items_list[val_i][1]
        val_i = val_i - 1

    return values_weights[-1][-1], selected_items


myval = [(3, 2), (4, 2), (5, 3), (7, 3), (5, 1), (9, 4)]

print(knapsack(7, myval))
