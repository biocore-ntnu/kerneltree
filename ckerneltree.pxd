
cdef extern from "src/rbtree.h":

    cdef struct rb_node:
        pass
        # unsigned long start
        # unsigned long last
        # int val

    cdef struct rb_root:
        rb_node node

    # rb_root* RB_ROOT()

cdef extern from "src/interval_tree.h":

    cdef struct interval_tree_node:
        unsigned long start
        unsigned long last
        int val

    void interval_tree_insert(interval_tree_node *node, rb_root *root)

    void interval_tree_remove(interval_tree_node *node, rb_root *root)

    interval_tree_node * interval_tree_iter_first(rb_root *root, unsigned long start, unsigned long last)

    interval_tree_node * interval_tree_iter_next(interval_tree_node *node, unsigned long start, unsigned long last)
