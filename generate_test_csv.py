from numpy.random import randint, rand
import numpy as np

import pandas as pd

total_nb = int(1e7)

starts = randint(0, int(1e8), total_nb)
ends = starts + 100
values = rand(total_nb)

df = pd.concat([pd.Series(s) for s in [starts, ends, values]],
               axis=1)

df.to_csv("test.csv", sep=",", header=False, index=False)
