from libc.stdlib cimport calloc

cimport ckerneltree as ckt

cdef class IntervalTree:


    cdef ckt.rb_root root


    def __cinit__(self):

        self.root = ckt.rb_root()

    def __dealloc__(self):

        # print("Before dealloc")
        ckt.interval_tree_free(&self.root)
        print("After dealloc")


    cpdef add(self, unsigned long start, unsigned long end, int value):

        cdef ckt.interval_tree_node* node

        node = <ckt.interval_tree_node*>calloc(1, sizeof(ckt.interval_tree_node))

        node.start = start
        node.last = end
        node.val = value

        ckt.interval_tree_insert(node, &self.root)


    cdef cadd(self, unsigned long start, unsigned long end, int value):

        cdef ckt.interval_tree_node* node

        node = <ckt.interval_tree_node*>calloc(1, sizeof(ckt.interval_tree_node))

        node.start = start
        node.last = end
        node.val = value

        ckt.interval_tree_insert(node, &self.root)


    cpdef build_tree(self, long [::1] starts, long [::1] ends, int [::1] values):

        cdef int nb_elems = len(starts)
        cdef int i = 0;

        while i < nb_elems:
            self.cadd(starts[i], ends[i], values[i])
            i += 1


    cpdef search(self, long start, long end):

        cdef ckt.interval_tree_node *n

        results = []
        n = ckt.interval_tree_iter_first(&self.root, start, end)

        while (n):
            results.append((n.start, n.last, n.val))
            n = ckt.interval_tree_iter_next(n, start, end)

        return results
