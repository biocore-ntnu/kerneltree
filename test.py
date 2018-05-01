from kerneltree import IntervalTree

it = IntervalTree()

it.add(1, 5, 7)
it.add(2, 3, 4)
it.add(0, 1, 5)
it.add(3, 4, 42)
it.add(1, 2, 349)

print(it.search(0, 2))
print(it.search(3, 3))
print(it.search(10, 200))
