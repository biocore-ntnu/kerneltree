from distutils.core import setup
from distutils.extension import Extension

from setuptools import find_packages, Extension, Command
from Cython.Build import cythonize

from setuptools import setup, find_packages

install_requires = ["cython"]

setup(
    name="kerneltree",
    ext_modules = cythonize([Extension("kerneltree", ["src/kerneltree.pyx", "src/interval_tree.c", "src/rbtree.c"])]),
    packages=find_packages(),
    package_data={'': ['*.pyx', '*.pxd', '*.h', '*.c']},
    include_dirs=[".", "src/"],
    version="0.0.2",
    url="http://github.com/endrebak/kerneltree",
    description="Ultrafast interval tree implementation.",
    author="Endre Bakken Stovner",
    author_email="endrebak85@gmail.com",
    keywords=["intervaltree"],
    license=["GPL2"],
    install_requires=install_requires,
)
