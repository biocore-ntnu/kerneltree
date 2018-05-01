#include <stdlib.h>
#include <stddef.h>

#include "interval_tree.h"
#include "interval_tree_generic.h"
#include "rbtree.h"

#define START(node) ((node)->start)
#define LAST(node)  ((node)->last)


/* This should be added to the interval_tree_generic.h I guess. - EBS */

void * interval_tree_free(const struct rb_root *root){

  struct rb_node *rb_node = root->rb_node;
  struct rb_node *temp;
  struct interval_tree_node *it_node;

  temp = rb_node;
  rb_node = rb_first_postorder(rb_node);

  do {
    it_node = rb_entry(temp, struct interval_tree_node, rb);
    free(it_node);
    free(temp);
    temp = rb_node;
    rb_node = rb_next_postorder(rb_node);
  } while (rb_node);

}
