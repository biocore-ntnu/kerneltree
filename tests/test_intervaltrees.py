
import pytest

import pandas as pd

from io import StringIO

from kerneltree import IntervalTree


@pytest.fixture
def simple_data():

    c = """Start End Value
1 5 100000
10 20 -345"""

    return pd.read_table(StringIO(c), sep="\s+", header=0)


@pytest.fixture
def simple_tree(simple_data):

    df = simple_data

    it = IntervalTree()

    it.build(df.Start.values, df.End.values, df.Value.values)

    return it


def test_intervals_correct(simple_tree):

    it = simple_tree

    assert it.search(0, 1) == [(1, 5, 100000)]
    # assert it.search(0, 0) == []
    assert it.search(0, 9) == [(1, 5, 100000)]
    assert it.search(21, 22) == []
    assert it.search(19, 20) == [(10, 20, -345)]
