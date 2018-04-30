# cdef extern from "src/intervaltree.h":
#     struct interval_tree_node:
#         struct rb_node

#     void interval_tree_insert(struct interval_tree_node *node, struct rb_root *root)

#     void interval_tree_remove(struct interval_tree_node *node, struct rb_root *root)

#     struct interval_tree_node * interval_tree_iter_first(struct rb_root *root, unsigned long start, unsigned long last)

#     struct interval_tree_node * interval_tree_iter_next(struct interval_tree_node *node, unsigned long start, unsigned long last)

cdef extern from "src/rbtree.h":
    ctypedef struct rb_root:
        pass
