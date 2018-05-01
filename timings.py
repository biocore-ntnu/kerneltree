from time import time
import datetime

from numpy.random import randint
import numpy as np

import pandas as pd

import intervaltree as it
import quicksect as qs
import kerneltree as kt

total_nb = int(1e6)

starts = randint(0, int(1e8), total_nb)
ends = starts + randint(1, 200, total_nb)
values = np.array(range(total_nb))


def test_build_it(starts, ends, values):

    start = time()

    it_it = it.IntervalTree()
    for s, e, v in zip(starts, ends, values):
        it_it[s:e] = v

    end = time()

    total = end - start

    total_dt = datetime.datetime.fromtimestamp(total)

    minutes, seconds = total_dt.strftime('%M\t%S\n').split()

    print("Python based intervaltrees took", minutes, "minutes and", seconds, "seconds to build the tree.")


def test_build_qs(starts, ends, values):

    start = time()

    qs_it = qs.IntervalTree()
    for s, e, v in zip(starts, ends, values):
        qs_it.add(s, e, v)

    end = time()
    total = end - start

    total_dt = datetime.datetime.fromtimestamp(total)

    minutes, seconds = total_dt.strftime('%M\t%S\n').split()

    print("Cython based intervaltrees took", minutes, "minutes and", seconds, "seconds to build the tree.")


def test_build_kt(starts, ends, values):

    start = time()

    kt_it = kt.IntervalTree()
    for s, e, v in zip(starts, ends, values):
        kt_it.add(s, e, v)

    end = time()
    total = end - start

    total_dt = datetime.datetime.fromtimestamp(total)

    minutes, seconds = total_dt.strftime('%M\t%S\n').split()

    print("C based intervaltrees took", minutes, "minutes and", seconds, "seconds to build the tree.")


def test_build_kt_helper(starts, ends, values):

    start = time()

    kt_it = kt.IntervalTree()

    kt_it.build(starts, ends, values)

    end = time()
    total = end - start

    total_dt = datetime.datetime.fromtimestamp(total)

    minutes, seconds = total_dt.strftime('%M\t%S\n').split()

    print("C based intervaltrees took", minutes, "minutes and", seconds, "seconds to build the tree using the helper function build.")

print("Starting to build.")

test_build_kt_helper(starts, ends, values)

# test_build_it(list(starts), list(ends), list(values))
# test_build_qs(list(starts), list(ends), list(values))
# starts, ends, values = list(starts), list(ends), list(values)
# test_build_kt(starts, ends, values)

# it_qs = qs.IntervalTree()
# it_kt = kt.IntervalTree()
