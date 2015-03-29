"""This is a simple and fast implementation of a scheduling algorithm
   The algorithm reads one line at a time and applies a line_fn to each
   line to be processed (in this case we convert to int).
   The file_gen is used as an iterable and passed to the built in sorted()
   along with lambda as key to be used for sorting
   In this case we sort using the difference 'job_weight - job_time' and
   in case of a tie we sort by largest weight
   Note this is not an optimal algorithm, it only serves the purpose of
   an exercise!
   once we have a job_list we can use the built in reduce to calculate
   total_time and total_weight
"""

def line_to_int_tuple(line):
    return tuple(int(i) for i in line.split())

def file_gen(file_name, line_fn):
    with open(file_name) as myfile:
        for line in myfile:
            int_tuple = line_fn(line)
            yield int_tuple

def calc_weight(time_weight_dict, job):
    time_weight_dict['total_time'] += job[1]
    time_weight_dict['total_weight'] += time_weight_dict['total_time'] * job[0]
    return time_weight_dict

job_list = sorted(file_gen('../test_data/greedy/jobs.txt', line_to_int_tuple),
                  key=lambda job_list: (-(job_list[0] - job_list[1]),
                                         -job_list[0]))

print(reduce(calc_weight, job_list, {'total_time': 0, 'total_weight': 0}))
