# kerneltree

Ultrafast interval tree implementation stolen from the kernel, modified and wrapped for Python.

Currently the nodes only store (start, end, int), so if you need to store additional data you need to create an int -> val hash.

For a sane number of intervals, the other Python and Cython implementations are going to be plenty fast enough. See the timings below.

## Authors

Andrea Arcangeli, David Woodhouse, Michel Lespinasse, Mark Fasheh, Endre Bakken Stovner

## License

GPU 2

## Install

(Not added yet)

```bash
pip install kerneltree
```

## Usage

```python
from kerneltree import IntervalTree

it = IntervalTree()

it.add(10, 15, 42)

it.search(0, 5)
# []

it.search(11, 12)
# [(10, 15, 42)]

import pandas as pd

starts = pd.Series(range(0, 10))
ends = starts + 10
vals = starts

it.build(starts.values, ends.values, vals.values)

it.search(1, 3)
# [(0, 10, 0), (1, 11, 1), (2, 12, 2), (3, 13, 3)]
```

## Timings

For 10 and 100 million values I also use the helper function it.build(), which iterates over the numpy arrays starts, ends and values to build the tree completely in C-land. The speedup is a passable 20-30%, but it also means that you do not have to make lists out of the arrays before building the trees, which is another speed win.

#### 1 mill values

```
Python based intervaltrees took 01 minutes and 37 seconds to build the tree.
Cython based intervaltrees took 00 minutes and 08 seconds to build the tree.
C based intervaltrees took 00 minutes and 00 seconds to build the tree.
```

#### 10 mill values

```
Python based intervaltrees took 16 minutes and 51 seconds to build the tree.
Cython based intervaltrees took 02 minutes and 10 seconds to build the tree.
C based intervaltrees took 00 minutes and 17 seconds to build the tree.
C based intervaltrees took 00 minutes and 14 seconds to build the tree using the helper function build.
```

#### 100 mill values

(Could not be bothered to let the Python or Cython versions finish)

```
C based intervaltrees took 05 minutes and 37 seconds to build the tree.
C based intervaltrees took 03 minutes and 59 seconds to build the tree using the helper function build.
```

## Immediate TODO

* Add to PyPI
* Continuous integration
* Make the intervaltree objects more robust by providing error messages for wrong usage.
<!-- * Have C function that parses bed file and builds tree at the same time, so that the IO and CPU operations are interleaved. -->

## Future work

I would like to make the intervaltrees pickleable. However, this would require storing the nodes in preorder and building the tree when deserializing so it is not on my immediate todo. If I release a second paper on pyranges, this would be a nice addition as it would allow building the GRanges objects in parallel.

<!-- This might be a solution: [Pickle Cython Class with C pointers](https://stackoverflow.com/a/36309509/992687) -->

There is nothing preventing the interval tree from taking arbitrary Python objects (or rather pointers to PyObjects on the heap), but as I am rather busy and do not need it I am not going to implement it anytime soon. I would not mind maintaing such a feature if you make a PR.

## See also

[Chaim-Leib Halbert's intervaltree library](https://github.com/chaimleib/intervaltree) - the best pure Python interval tree implementation I have found.

[Brent Pedersen's quicksect](https://github.com/brentp/quicksect) - Cython-based implementation of an intervaltree able to store arbitrary Python objects.

[Mark Fasheh's C library](https://github.com/markfasheh/interval-tree) - The library kerneltrees was forked from.
