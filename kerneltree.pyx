cimport ckerneltree as k
from libc.stdlib cimport calloc
from libc.limits cimport ULONG_MAX


cdef class IntervalTree:

    cdef k.rb_root root

    def __cinit__(self):

        self.root = k.rb_root()

    def __dealloc__(self):

        k.interval_tree_free(&self.root)



    cpdef print_region(self, unsigned long start, unsigned long end):

        cdef k.interval_tree_node *n

        n = k.interval_tree_iter_first(&self.root, start, end)

        while (n):
            print("Once!", n.start, n.last, n.val)
            n = k.interval_tree_iter_next(n, start, end)


    cpdef add(self, unsigned long start, unsigned long end, int value):

        cdef k.interval_tree_node* node

        node = <k.interval_tree_node*>calloc(1, sizeof(k.interval_tree_node))

        node.start = start
        node.last = end
        node.val = value

        k.interval_tree_insert(node, &self.root)
