
cimport ckerneltree as k

cdef class IntervalTree:

    cdef k.rb_root root

    def __cinit__(self):

        self.root = k.rb_root()

    cpdef add(self, unsigned long start, unsigned long end, int value):

        cdef k.interval_tree_node node

        node.start=start
        node.last=end
        node.val=value

        k.interval_tree_insert(&node, &self.root)

    cpdef print_region(self, int start, int end):

        cdef k.interval_tree_node *n = k.interval_tree_iter_first(&self.root, start, end)
        print("1", n.start, n.last, n.val)

        # while (n):
        #     print("2", n.start, n.last, n.val)
        #     n = k.interval_tree_iter_next(n, start, end)
