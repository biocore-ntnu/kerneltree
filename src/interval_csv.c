#include <stdlib.h>
#include <stddef.h>
#include <stdio.h>

#include <unistd.h>
#include <errno.h>
#include <string.h>
#include <limits.h>

#include "interval_tree.h"
#include "interval_tree_generic.h"

static char *prog = "interval_tree";

static struct rb_root root = RB_ROOT;
static struct rb_root root2 = RB_ROOT;
static int extents = 0;

static void usage(void)
{
	printf("%s [-e] [-S search start] [-E search end] file\n\n", prog);
	printf("Loads (start, end) pairs from 'file' into an interval tree,\n");
	printf("and print a count of total space referenced by those pairs.\n");
	printf("'file' must be in csv format.\n\n");
	printf("Switches:\n");
	printf("\t-e\tLoad values in extent format (start, len)\n");
	printf("\t-S\tStart search from this value (defaults to 0)\n");
	printf("\t-E\tEnd search from this value (defaults to ULONG_MAX)\n");
	printf("\n");
}

static void print_nodes(unsigned long start, unsigned long end)
{
	struct interval_tree_node *n = interval_tree_iter_first(&root2,
								start, end);

	printf("Tree nodes:");
	while (n) {
		printf(" (%lu, %lu, %f)", n->start, n->last, n->val);
		n = interval_tree_iter_next(n, start, end);
	}
	printf("\n");
}

#define LINE_LEN	60
int main(int argc, char **argv)
{
	int c, ret;
	char *filename;
	char *s1, *s2, *s3;
	FILE *fp;
	char line[LINE_LEN];
	/* unsigned long unique_space; */
	unsigned long start = 0;
	unsigned long end = ULONG_MAX;

	while ((c = getopt(argc, argv, "e?S:E:"))
	       != -1) {
		switch (c) {
		case 'e':
			extents = 1;
			break;
		case 'S':
			start = atol(optarg);
			printf("start: %lu\n", start);
			break;
		case 'E':
			end = atol(optarg);
			printf("end: %lu\n", end);
			break;
		case '?':
		default:
			usage();
			return 0;
		}
	}

	if ((argc - optind) != 1) {
		usage();
		return 1;
	}

	filename = argv[optind];

	fp = fopen(filename, "r");
	if (fp == NULL) {
		ret = errno;
		fprintf(stderr, "Error %d while opening \"%s\": %s\n",
			ret, filename, strerror(ret));
	}


	while (fgets(line, LINE_LEN, fp)) {
		struct interval_tree_node *n;
		struct interval_tree_node *n2;

		n = calloc(1, sizeof(*n));
		n2 = calloc(1, sizeof(*n2));
		if (!n) {
			ret = ENOMEM;
			fprintf(stderr, "Out of memory.\n");
			goto out;
		}

		s1 = strtok(line, ",");
		s2 = strtok(NULL, ",");
		s3 = strtok(NULL, ",");
		if (!s1 || !s2 || !s3)
			continue;

		n->start = atol(s1);
		n->last = atol(s2);
		n->val = atof(s3);

		n2->start = atol(s1) + 1;
		n2->last = atol(s2) + 2;
		n2->val = atof(s3) + .042;

		interval_tree_insert(n, &root);
		interval_tree_insert(n2, &root2);
	}

	printf("Done building tree");

	print_nodes(start, end);
	printf("\n");

	ret = 0;
out:
	fclose(fp);
	return ret;
}
