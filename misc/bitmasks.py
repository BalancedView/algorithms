def bitmasks(n, dist):
    """Returns list of numbers that XORed with any integer
       will give another integer within given hamming distance
       'dist' away
    n : an integer indicating the number of bits
    dist : Hamming distance
    """
    if dist < n:
        if dist > 0:
            for x in bitmasks(n - 1, dist - 1):
                yield (1 << (n - 1)) + x
            for x in bitmasks(n - 1, dist):
                yield x
        else:
            yield 0
    else:
        yield (1 << n) - 1
