from distutils.core import setup
from distutils.extension import Extension

from setuptools import find_packages, Extension, Command
from Cython.Build import cythonize

setup(
    ext_modules = cythonize([Extension("kerneltree", ["kerneltree.pyx", "src/interval_tree.c", "src/rbtree.c"])]),
    packages=find_packages(),
    include_dirs=[".", "src/"]
)
