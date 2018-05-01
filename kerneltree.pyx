from libc.stdlib cimport calloc

cimport ckerneltree as ckt

cimport cython

cdef class IntervalTree:


    cdef ckt.rb_root root


    def __cinit__(self):

        self.root = ckt.rb_root()

    def __dealloc__(self):

        ckt.interval_tree_free(&self.root)


    cpdef add(self, unsigned long start, unsigned long end, long value):

        cdef ckt.interval_tree_node* node

        node = <ckt.interval_tree_node*>calloc(1, sizeof(ckt.interval_tree_node))

        node.start = start
        node.last = end
        node.val = value

        ckt.interval_tree_insert(node, &self.root)


    cdef cadd(self, unsigned long start, unsigned long end, long value):

        cdef ckt.interval_tree_node* node

        node = <ckt.interval_tree_node*>calloc(1, sizeof(ckt.interval_tree_node))

        node.start = start
        node.last = end
        node.val = value

        ckt.interval_tree_insert(node, &self.root)


    @cython.boundscheck(False)
    @cython.wraparound(False)
    cpdef build(self, long [::1] starts, long [::1] ends, long [::1] values):

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
