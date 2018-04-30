cimport ckerneltree as k
from libc.stdlib cimport calloc


cdef class IntervalTree:

    cdef k.rb_root root


    def __cinit__(self):

        self.root = k.rb_root()


    cpdef print_region(self, unsigned long start, unsigned long end):

        cdef k.interval_tree_node *n

        n = k.interval_tree_iter_first(&self.root, start, end)

        while (n):
            print("Once!", n.start, n.last, n.val)
            n = k.interval_tree_iter_next(n, start, end)


    cpdef add(self, unsigned long start, unsigned long end, int value):

        cdef k.interval_tree_node* node

        node = <k.interval_tree_node*>calloc(1, sizeof(k.interval_tree_node))

        # calloc set all to zero
        print("node.start", node.start)
        print("node.end", node.last)
        print("node.val", node.val)

        # these unsigned conversions do not seem to do anything?
        cdef unsigned long ustart = start
        cdef unsigned long uend = end
        node.start = ustart
        node.last = uend
        node.val = value

        # Values are good in struct are valid
        print("node.start", node.start)
        print("node.end", node.last)
        print("node.val", node.val)

        k.interval_tree_insert(node, &self.root)
