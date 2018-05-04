from gzip import open as zopen
from kerneltree import IntervalTree

it = IntervalTree()

it.add(1, 5, 7)
it.add(2, 3, 4)
it.add(0, 1, 5)
it.add(3, 4, 42)
it.add(1, 2, 349)

it.search(0, 2)
it.search(3, 3)
it.search(10, 200)

for i, line in enumerate(zopen("tests/test_file.txt.gz")):
    start, end, _ = line.split()
    start, end = int(start), int(end)
    it.add(start, end, i)
    print(i)
