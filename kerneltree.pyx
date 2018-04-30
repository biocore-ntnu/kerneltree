cimport ckerneltree

cdef class IntervalTree:

    cdef ckerneltree.rb_root root
    # cdef ckerneltree.rb_node node

    def __cinit__(self):

        self.root = ckerneltree.rb_root()
        # self.root.node = NULL

    cdef add(self, int start, int end, int value):

        cdef ckerneltree.interval_tree_node *n

        # n.start = start
        # n.end = end
        # n.value = value

        # ckerneltree.interval_tree_insert(n, self.root)
