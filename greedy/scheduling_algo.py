"""This is a simple and fast implementation of a scheduling algorithm
   The algorithm uses 2 generators to read lines from a file
   the file_gen simply opens a file and reads one line at a time
   the line_to_int_list as it says converts a line to a list of ints.
   The lines_from_file is a generator used as an iterable passed to the
   built in sorted() along with a lambda as key to be used for sorting
   In this case we sort using the difference 'job_weight - job_time' and
   in case of a tie we sort by largest weight
   Note this is not an optimal algorithm, it only serves the purpose of
   an exercise!
   once we have a job_list we can use the built in reduce to calculate
   total_time and total_weight using the calc_weight callback function
"""
from functools import reduce

def line_to_int_list(line_seq):
    for line in line_seq:
        yield [int(i) for i in line.split()]

def file_gen(file_name):
    with open(file_name) as myfile:
        for line in myfile:
            yield line

def calc_weight(time_weight_dict, job):
    time_weight_dict['total_time'] += job[1]
    time_weight_dict['total_weight'] += time_weight_dict['total_time'] * job[0]
    return time_weight_dict

int_lists_from_file = line_to_int_list(file_gen('../test_data/greedy/jobs.txt'))

job_list = sorted(int_lists_from_file,
                  key=lambda job: (-(job[0] - job[1]),
                                   -job[0]))

print(reduce(calc_weight, job_list, {'total_time': 0, 'total_weight': 0}))
