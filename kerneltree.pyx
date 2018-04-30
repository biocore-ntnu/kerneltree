cimport ckerneltree as k

cdef class IntervalTree:

    cdef k.rb_root root
    # cdef k.rb_node node

    def __cinit__(self):

        self.root = k.rb_root()
        # self.root.node = NULL

    cdef add(self, int start, int end, int value):

        cdef k.interval_tree_node *node

        node.start=start #, last=end, val=value
        node.last=end
        node.val=value

        k.interval_tree_insert(node, &self.root)

    cpdef print_region(self, int start, int end):

        cdef k.interval_tree_node *n = k.interval_tree_iter_first(&self.root, start, end)

        while (n):
            print(n.start, n.last, n.val)
            n = k.interval_tree_iter_next(n, start, end)
