Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1T9E1t-00022y-FA
 for kexec@lists.infradead.org; Wed, 05 Sep 2012 11:44:28 +0000
From: Matthew Leach <matthew.leach@arm.com>
Subject: [RFC PATCH 3/4] Add the dtc for device-tree manipulation
Date: Wed,  5 Sep 2012 12:44:02 +0100
Message-Id: <1346845443-32242-4-git-send-email-matthew.leach@arm.com>
In-Reply-To: <1346845443-32242-1-git-send-email-matthew.leach@arm.com>
References: <1346845443-32242-1-git-send-email-matthew.leach@arm.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: Matthew Leach <matthew.leach@arm.com>, will.deacon@arm.com

The dtc includes functions for generating a dtb for the currently
running kernel that is exposed in /proc/device-tree. Include the dtc
so a dtb can be generated for a new kernel without the user having to
obtain a dtb file.

Signed-off-by: Matthew Leach <matthew.leach@arm.com>
---
 util_lib/Makefile          |   2 +
 util_lib/dtc/Makefile.dtc  |   9 +
 util_lib/dtc/data.c        | 321 ++++++++++++++++++++++
 util_lib/dtc/dtc.c         |  44 +++
 util_lib/dtc/dtc.h         | 244 +++++++++++++++++
 util_lib/dtc/flattree.c    | 649 +++++++++++++++++++++++++++++++++++++++++++++
 util_lib/dtc/fstree.c      |  91 +++++++
 util_lib/dtc/livetree.c    | 579 ++++++++++++++++++++++++++++++++++++++++
 util_lib/dtc/srcpos.c      | 252 ++++++++++++++++++
 util_lib/dtc/srcpos.h      |  87 ++++++
 util_lib/dtc/util.c        |  59 +++++
 util_lib/dtc/util.h        |  56 ++++
 util_lib/dtc/version_gen.h |   1 +
 13 files changed, 2394 insertions(+)
 create mode 100644 util_lib/dtc/Makefile.dtc
 create mode 100644 util_lib/dtc/data.c
 create mode 100644 util_lib/dtc/dtc.c
 create mode 100644 util_lib/dtc/dtc.h
 create mode 100644 util_lib/dtc/flattree.c
 create mode 100644 util_lib/dtc/fstree.c
 create mode 100644 util_lib/dtc/livetree.c
 create mode 100644 util_lib/dtc/srcpos.c
 create mode 100644 util_lib/dtc/srcpos.h
 create mode 100644 util_lib/dtc/util.c
 create mode 100644 util_lib/dtc/util.h
 create mode 100644 util_lib/dtc/version_gen.h

diff --git a/util_lib/Makefile b/util_lib/Makefile
index 54ccdc5..8b00944 100644
--- a/util_lib/Makefile
+++ b/util_lib/Makefile
@@ -1,6 +1,8 @@
 #
 # Utility function library
 #
+include $(srcdir)/util_lib/dtc/Makefile.dtc
+
 UTIL_LIB_SRCS +=
 UTIL_LIB_SRCS += util_lib/compute_ip_checksum.c
 UTIL_LIB_SRCS += util_lib/sha256.c
diff --git a/util_lib/dtc/Makefile.dtc b/util_lib/dtc/Makefile.dtc
new file mode 100644
index 0000000..3433d76
--- /dev/null
+++ b/util_lib/dtc/Makefile.dtc
@@ -0,0 +1,9 @@
+DTC_INCLUDES = dtc.h srcpos.h util.h version_gen.h
+DTC_SRCS = fstree.c flattree.c srcpos.c util.c livetree.c data.c dtc.c
+DTC_OBJS = $(DTC_SRCS:%.c=%.o)
+
+CPPFLAGS += -I$(srcdir)/util_lib/dtc/
+
+dist += util_lib/dtc/Makefile.dtc \
+        $(DTC_SRCS:%=util_lib/dtc/%) \
+        $(DTC_INCLUDES:%=util_lib/dtc/%)
\ No newline at end of file
diff --git a/util_lib/dtc/data.c b/util_lib/dtc/data.c
new file mode 100644
index 0000000..fe555e8
--- /dev/null
+++ b/util_lib/dtc/data.c
@@ -0,0 +1,321 @@
+/*
+ * (C) Copyright David Gibson <dwg@au1.ibm.com>, IBM Corporation.  2005.
+ *
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of the
+ * License, or (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307
+ *                                                                   USA
+ */
+
+#include "dtc.h"
+
+void data_free(struct data d)
+{
+	struct marker *m, *nm;
+
+	m = d.markers;
+	while (m) {
+		nm = m->next;
+		free(m->ref);
+		free(m);
+		m = nm;
+	}
+
+	if (d.val)
+		free(d.val);
+}
+
+struct data data_grow_for(struct data d, int xlen)
+{
+	struct data nd;
+	int newsize;
+
+	if (xlen == 0)
+		return d;
+
+	nd = d;
+
+	newsize = xlen;
+
+	while ((d.len + xlen) > newsize)
+		newsize *= 2;
+
+	nd.val = xrealloc(d.val, newsize);
+
+	return nd;
+}
+
+struct data data_copy_mem(const char *mem, int len)
+{
+	struct data d;
+
+	d = data_grow_for(empty_data, len);
+
+	d.len = len;
+	memcpy(d.val, mem, len);
+
+	return d;
+}
+
+static char get_oct_char(const char *s, int *i)
+{
+	char x[4];
+	char *endx;
+	long val;
+
+	x[3] = '\0';
+	strncpy(x, s + *i, 3);
+
+	val = strtol(x, &endx, 8);
+
+	assert(endx > x);
+
+	(*i) += endx - x;
+	return val;
+}
+
+static char get_hex_char(const char *s, int *i)
+{
+	char x[3];
+	char *endx;
+	long val;
+
+	x[2] = '\0';
+	strncpy(x, s + *i, 2);
+
+	val = strtol(x, &endx, 16);
+	if (!(endx  > x))
+		die("\\x used with no following hex digits\n");
+
+	(*i) += endx - x;
+	return val;
+}
+
+struct data data_copy_escape_string(const char *s, int len)
+{
+	int i = 0;
+	struct data d;
+	char *q;
+
+	d = data_grow_for(empty_data, strlen(s)+1);
+
+	q = d.val;
+	while (i < len) {
+		char c = s[i++];
+
+		if (c != '\\') {
+			q[d.len++] = c;
+			continue;
+		}
+
+		c = s[i++];
+		assert(c);
+		switch (c) {
+		case 'a':
+			q[d.len++] = '\a';
+			break;
+		case 'b':
+			q[d.len++] = '\b';
+			break;
+		case 't':
+			q[d.len++] = '\t';
+			break;
+		case 'n':
+			q[d.len++] = '\n';
+			break;
+		case 'v':
+			q[d.len++] = '\v';
+			break;
+		case 'f':
+			q[d.len++] = '\f';
+			break;
+		case 'r':
+			q[d.len++] = '\r';
+			break;
+		case '0':
+		case '1':
+		case '2':
+		case '3':
+		case '4':
+		case '5':
+		case '6':
+		case '7':
+			i--; /* need to re-read the first digit as
+			      * part of the octal value */
+			q[d.len++] = get_oct_char(s, &i);
+			break;
+		case 'x':
+			q[d.len++] = get_hex_char(s, &i);
+			break;
+		default:
+			q[d.len++] = c;
+		}
+	}
+
+	q[d.len++] = '\0';
+	return d;
+}
+
+struct data data_copy_file(FILE *f, size_t maxlen)
+{
+	struct data d = empty_data;
+
+	while (!feof(f) && (d.len < maxlen)) {
+		size_t chunksize, ret;
+
+		if (maxlen == -1)
+			chunksize = 4096;
+		else
+			chunksize = maxlen - d.len;
+
+		d = data_grow_for(d, chunksize);
+		ret = fread(d.val + d.len, 1, chunksize, f);
+
+		if (ferror(f))
+			die("Error reading file into data: %s", strerror(errno));
+
+		if (d.len + ret < d.len)
+			die("Overflow reading file into data\n");
+
+		d.len += ret;
+	}
+
+	return d;
+}
+
+struct data data_append_data(struct data d, const void *p, int len)
+{
+	d = data_grow_for(d, len);
+	memcpy(d.val + d.len, p, len);
+	d.len += len;
+	return d;
+}
+
+struct data data_insert_at_marker(struct data d, struct marker *m,
+				  const void *p, int len)
+{
+	d = data_grow_for(d, len);
+	memmove(d.val + m->offset + len, d.val + m->offset, d.len - m->offset);
+	memcpy(d.val + m->offset, p, len);
+	d.len += len;
+
+	/* Adjust all markers after the one we're inserting at */
+	m = m->next;
+	for_each_marker(m)
+		m->offset += len;
+	return d;
+}
+
+static struct data data_append_markers(struct data d, struct marker *m)
+{
+	struct marker **mp = &d.markers;
+
+	/* Find the end of the markerlist */
+	while (*mp)
+		mp = &((*mp)->next);
+	*mp = m;
+	return d;
+}
+
+struct data data_merge(struct data d1, struct data d2)
+{
+	struct data d;
+	struct marker *m2 = d2.markers;
+
+	d = data_append_markers(data_append_data(d1, d2.val, d2.len), m2);
+
+	/* Adjust for the length of d1 */
+	for_each_marker(m2)
+		m2->offset += d1.len;
+
+	d2.markers = NULL; /* So data_free() doesn't clobber them */
+	data_free(d2);
+
+	return d;
+}
+
+struct data data_append_cell(struct data d, cell_t word)
+{
+	cell_t beword = cpu_to_fdt32(word);
+
+	return data_append_data(d, &beword, sizeof(beword));
+}
+
+struct data data_append_re(struct data d, const struct fdt_reserve_entry *re)
+{
+	struct fdt_reserve_entry bere;
+
+	bere.address = cpu_to_fdt64(re->address);
+	bere.size = cpu_to_fdt64(re->size);
+
+	return data_append_data(d, &bere, sizeof(bere));
+}
+
+struct data data_append_addr(struct data d, uint64_t addr)
+{
+	uint64_t beaddr = cpu_to_fdt64(addr);
+
+	return data_append_data(d, &beaddr, sizeof(beaddr));
+}
+
+struct data data_append_byte(struct data d, uint8_t byte)
+{
+	return data_append_data(d, &byte, 1);
+}
+
+struct data data_append_zeroes(struct data d, int len)
+{
+	d = data_grow_for(d, len);
+
+	memset(d.val + d.len, 0, len);
+	d.len += len;
+	return d;
+}
+
+struct data data_append_align(struct data d, int align)
+{
+	int newlen = ALIGN(d.len, align);
+	return data_append_zeroes(d, newlen - d.len);
+}
+
+struct data data_add_marker(struct data d, enum markertype type, char *ref)
+{
+	struct marker *m;
+
+	m = xmalloc(sizeof(*m));
+	m->offset = d.len;
+	m->type = type;
+	m->ref = ref;
+	m->next = NULL;
+
+	return data_append_markers(d, m);
+}
+
+int data_is_one_string(struct data d)
+{
+	int i;
+	int len = d.len;
+
+	if (len == 0)
+		return 0;
+
+	for (i = 0; i < len-1; i++)
+		if (d.val[i] == '\0')
+			return 0;
+
+	if (d.val[len-1] != '\0')
+		return 0;
+
+	return 1;
+}
diff --git a/util_lib/dtc/dtc.c b/util_lib/dtc/dtc.c
new file mode 100644
index 0000000..b812dfc
--- /dev/null
+++ b/util_lib/dtc/dtc.c
@@ -0,0 +1,44 @@
+/*
+ * (C) Copyright David Gibson <dwg@au1.ibm.com>, IBM Corporation.  2005.
+ *
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of the
+ * License, or (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307
+ *                                                                   USA
+ */
+
+#include "dtc.h"
+#include "srcpos.h"
+
+#include "version_gen.h"
+
+static void fill_fullpaths(struct node *tree, const char *prefix)
+{
+	struct node *child;
+	const char *unit;
+
+	tree->fullpath = join_path(prefix, tree->name);
+
+	unit = strchr(tree->name, '@');
+	if (unit)
+		tree->basenamelen = unit - tree->name;
+	else
+		tree->basenamelen = strlen(tree->name);
+
+	for_each_child(tree, child)
+		fill_fullpaths(child, tree->fullpath);
+}
+
+
+
diff --git a/util_lib/dtc/dtc.h b/util_lib/dtc/dtc.h
new file mode 100644
index 0000000..afb26f6
--- /dev/null
+++ b/util_lib/dtc/dtc.h
@@ -0,0 +1,244 @@
+#ifndef _DTC_H
+#define _DTC_H
+
+/*
+ * (C) Copyright David Gibson <dwg@au1.ibm.com>, IBM Corporation.  2005.
+ *
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of the
+ * License, or (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307
+ *                                                                   USA
+ */
+
+#include <stdio.h>
+#include <string.h>
+#include <stdlib.h>
+#include <stdint.h>
+#include <stdarg.h>
+#include <assert.h>
+#include <ctype.h>
+#include <errno.h>
+#include <unistd.h>
+
+#include <libfdt_env.h>
+#include <fdt.h>
+
+#include "util.h"
+
+#ifdef DEBUG
+#define debug(fmt,args...)	printf(fmt, ##args)
+#else
+#define debug(fmt,args...)
+#endif
+
+
+#define DEFAULT_FDT_VERSION	17
+
+/*
+ * Command line options
+ */
+extern int quiet;		/* Level of quietness */
+extern int reservenum;		/* Number of memory reservation slots */
+extern int minsize;		/* Minimum blob size */
+extern int padsize;		/* Additional padding to blob */
+extern int phandle_format;	/* Use linux,phandle or phandle properties */
+
+#define PHANDLE_LEGACY	0x1
+#define PHANDLE_EPAPR	0x2
+#define PHANDLE_BOTH	0x3
+
+typedef uint32_t cell_t;
+
+
+#define streq(a, b)	(strcmp((a), (b)) == 0)
+#define strneq(a, b, n)	(strncmp((a), (b), (n)) == 0)
+
+#define ALIGN(x, a)	(((x) + (a) - 1) & ~((a) - 1))
+#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
+
+/* Data blobs */
+enum markertype {
+	REF_PHANDLE,
+	REF_PATH,
+	LABEL,
+};
+
+struct  marker {
+	enum markertype type;
+	int offset;
+	char *ref;
+	struct marker *next;
+};
+
+struct data {
+	int len;
+	char *val;
+	struct marker *markers;
+};
+
+
+#define empty_data ((struct data){ /* all .members = 0 or NULL */ })
+
+#define for_each_marker(m) \
+	for (; (m); (m) = (m)->next)
+#define for_each_marker_of_type(m, t) \
+	for_each_marker(m) \
+		if ((m)->type == (t))
+
+void data_free(struct data d);
+
+struct data data_grow_for(struct data d, int xlen);
+
+struct data data_copy_mem(const char *mem, int len);
+struct data data_copy_escape_string(const char *s, int len);
+struct data data_copy_file(FILE *f, size_t len);
+
+struct data data_append_data(struct data d, const void *p, int len);
+struct data data_insert_at_marker(struct data d, struct marker *m,
+				  const void *p, int len);
+struct data data_merge(struct data d1, struct data d2);
+struct data data_append_cell(struct data d, cell_t word);
+struct data data_append_re(struct data d, const struct fdt_reserve_entry *re);
+struct data data_append_addr(struct data d, uint64_t addr);
+struct data data_append_byte(struct data d, uint8_t byte);
+struct data data_append_zeroes(struct data d, int len);
+struct data data_append_align(struct data d, int align);
+
+struct data data_add_marker(struct data d, enum markertype type, char *ref);
+
+int data_is_one_string(struct data d);
+
+/* DT constraints */
+
+#define MAX_PROPNAME_LEN	31
+#define MAX_NODENAME_LEN	31
+
+/* Live trees */
+struct label {
+	char *label;
+	struct label *next;
+};
+
+struct property {
+	char *name;
+	struct data val;
+
+	struct property *next;
+
+	struct label *labels;
+};
+
+struct node {
+	char *name;
+	struct property *proplist;
+	struct node *children;
+
+	struct node *parent;
+	struct node *next_sibling;
+
+	char *fullpath;
+	int basenamelen;
+
+	cell_t phandle;
+	int addr_cells, size_cells;
+
+	struct label *labels;
+};
+
+#define for_each_label(l0, l) \
+	for ((l) = (l0); (l); (l) = (l)->next)
+
+#define for_each_property(n, p) \
+	for ((p) = (n)->proplist; (p); (p) = (p)->next)
+
+#define for_each_child(n, c)	\
+	for ((c) = (n)->children; (c); (c) = (c)->next_sibling)
+
+void add_label(struct label **labels, char *label);
+
+struct property *build_property(char *name, struct data val);
+struct property *chain_property(struct property *first, struct property *list);
+struct property *reverse_properties(struct property *first);
+
+struct node *build_node(struct property *proplist, struct node *children);
+struct node *name_node(struct node *node, char *name);
+struct node *chain_node(struct node *first, struct node *list);
+struct node *merge_nodes(struct node *old_node, struct node *new_node);
+
+void add_property(struct node *node, struct property *prop);
+void add_child(struct node *parent, struct node *child);
+
+const char *get_unitname(struct node *node);
+struct property *get_property(struct node *node, const char *propname);
+cell_t propval_cell(struct property *prop);
+struct property *get_property_by_label(struct node *tree, const char *label,
+				       struct node **node);
+struct marker *get_marker_label(struct node *tree, const char *label,
+				struct node **node, struct property **prop);
+struct node *get_subnode(struct node *node, const char *nodename);
+struct node *get_node_by_path(struct node *tree, const char *path);
+struct node *get_node_by_label(struct node *tree, const char *label);
+struct node *get_node_by_phandle(struct node *tree, cell_t phandle);
+struct node *get_node_by_ref(struct node *tree, const char *ref);
+cell_t get_node_phandle(struct node *root, struct node *node);
+
+uint32_t guess_boot_cpuid(struct node *tree);
+
+/* Boot info (tree plus memreserve information */
+
+struct reserve_info {
+	struct fdt_reserve_entry re;
+
+	struct reserve_info *next;
+
+	struct label *labels;
+};
+
+struct reserve_info *build_reserve_entry(uint64_t start, uint64_t len);
+struct reserve_info *chain_reserve_entry(struct reserve_info *first,
+					 struct reserve_info *list);
+struct reserve_info *add_reserve_entry(struct reserve_info *list,
+				       struct reserve_info *new);
+
+
+struct boot_info {
+	struct reserve_info *reservelist;
+	struct node *dt;		/* the device tree */
+	uint32_t boot_cpuid_phys;
+};
+
+struct boot_info *build_boot_info(struct reserve_info *reservelist,
+				  struct node *tree, uint32_t boot_cpuid_phys);
+void sort_tree(struct boot_info *bi);
+
+/* Checks */
+
+void process_checks(int force, struct boot_info *bi);
+
+/* Flattened trees */
+
+void* dt_to_blob_buf(off_t* size, struct boot_info *bi, int version);
+
+struct boot_info *dt_from_blob(const char *fname);
+
+/* Tree source */
+
+void dt_to_source(FILE *f, struct boot_info *bi);
+struct boot_info *dt_from_source(const char *f);
+
+/* FS trees */
+
+struct boot_info *dt_from_fs(const char *dirname);
+
+#endif /* _DTC_H */
diff --git a/util_lib/dtc/flattree.c b/util_lib/dtc/flattree.c
new file mode 100644
index 0000000..d110001
--- /dev/null
+++ b/util_lib/dtc/flattree.c
@@ -0,0 +1,649 @@
+/*
+ * (C) Copyright David Gibson <dwg@au1.ibm.com>, IBM Corporation.  2005.
+ *
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of the
+ * License, or (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307
+ *                                                                   USA
+ */
+
+#include "dtc.h"
+#include "srcpos.h"
+
+#define FTF_FULLPATH	0x1
+#define FTF_VARALIGN	0x2
+#define FTF_NAMEPROPS	0x4
+#define FTF_BOOTCPUID	0x8
+#define FTF_STRTABSIZE	0x10
+#define FTF_STRUCTSIZE	0x20
+#define FTF_NOPS	0x40
+
+static struct version_info {
+	int version;
+	int last_comp_version;
+	int hdr_size;
+	int flags;
+} version_table[] = {
+	{1, 1, FDT_V1_SIZE,
+	 FTF_FULLPATH|FTF_VARALIGN|FTF_NAMEPROPS},
+	{2, 1, FDT_V2_SIZE,
+	 FTF_FULLPATH|FTF_VARALIGN|FTF_NAMEPROPS|FTF_BOOTCPUID},
+	{3, 1, FDT_V3_SIZE,
+	 FTF_FULLPATH|FTF_VARALIGN|FTF_NAMEPROPS|FTF_BOOTCPUID|FTF_STRTABSIZE},
+	{16, 16, FDT_V3_SIZE,
+	 FTF_BOOTCPUID|FTF_STRTABSIZE|FTF_NOPS},
+	{17, 16, FDT_V17_SIZE,
+	 FTF_BOOTCPUID|FTF_STRTABSIZE|FTF_STRUCTSIZE|FTF_NOPS},
+};
+
+struct emitter {
+	void (*cell)(void *, cell_t);
+	void (*string)(void *, char *, int);
+	void (*align)(void *, int);
+	void (*data)(void *, struct data);
+	void (*beginnode)(void *, struct label *labels);
+	void (*endnode)(void *, struct label *labels);
+	void (*property)(void *, struct label *labels);
+};
+
+static void bin_emit_cell(void *e, cell_t val)
+{
+	struct data *dtbuf = e;
+
+	*dtbuf = data_append_cell(*dtbuf, val);
+}
+
+static void bin_emit_string(void *e, char *str, int len)
+{
+	struct data *dtbuf = e;
+
+	if (len == 0)
+		len = strlen(str);
+
+	*dtbuf = data_append_data(*dtbuf, str, len);
+	*dtbuf = data_append_byte(*dtbuf, '\0');
+}
+
+static void bin_emit_align(void *e, int a)
+{
+	struct data *dtbuf = e;
+
+	*dtbuf = data_append_align(*dtbuf, a);
+}
+
+static void bin_emit_data(void *e, struct data d)
+{
+	struct data *dtbuf = e;
+
+	*dtbuf = data_append_data(*dtbuf, d.val, d.len);
+}
+
+static void bin_emit_beginnode(void *e, struct label *labels)
+{
+	bin_emit_cell(e, FDT_BEGIN_NODE);
+}
+
+static void bin_emit_endnode(void *e, struct label *labels)
+{
+	bin_emit_cell(e, FDT_END_NODE);
+}
+
+static void bin_emit_property(void *e, struct label *labels)
+{
+	bin_emit_cell(e, FDT_PROP);
+}
+
+static struct emitter bin_emitter = {
+	.cell = bin_emit_cell,
+	.string = bin_emit_string,
+	.align = bin_emit_align,
+	.data = bin_emit_data,
+	.beginnode = bin_emit_beginnode,
+	.endnode = bin_emit_endnode,
+	.property = bin_emit_property,
+};
+
+
+#define ASM_EMIT_BELONG(f, fmt, ...) \
+	{ \
+		fprintf((f), "\t.byte\t((" fmt ") >> 24) & 0xff\n", __VA_ARGS__); \
+		fprintf((f), "\t.byte\t((" fmt ") >> 16) & 0xff\n", __VA_ARGS__); \
+		fprintf((f), "\t.byte\t((" fmt ") >> 8) & 0xff\n", __VA_ARGS__); \
+		fprintf((f), "\t.byte\t(" fmt ") & 0xff\n", __VA_ARGS__); \
+	}
+
+
+
+
+static int stringtable_insert(struct data *d, const char *str)
+{
+	int i;
+
+	/* FIXME: do this more efficiently? */
+
+	for (i = 0; i < d->len; i++) {
+		if (streq(str, d->val + i))
+			return i;
+	}
+
+	*d = data_append_data(*d, str, strlen(str)+1);
+	return i;
+}
+
+static void flatten_tree(struct node *tree, struct emitter *emit,
+			 void *etarget, struct data *strbuf,
+			 struct version_info *vi)
+{
+	struct property *prop;
+	struct node *child;
+	int seen_name_prop = 0;
+
+	emit->beginnode(etarget, tree->labels);
+
+	if (vi->flags & FTF_FULLPATH)
+		emit->string(etarget, tree->fullpath, 0);
+	else
+		emit->string(etarget, tree->name, 0);
+
+	emit->align(etarget, sizeof(cell_t));
+
+	for_each_property(tree, prop) {
+		int nameoff;
+
+		if (streq(prop->name, "name"))
+			seen_name_prop = 1;
+
+		nameoff = stringtable_insert(strbuf, prop->name);
+
+		emit->property(etarget, prop->labels);
+		emit->cell(etarget, prop->val.len);
+		emit->cell(etarget, nameoff);
+
+		if ((vi->flags & FTF_VARALIGN) && (prop->val.len >= 8))
+			emit->align(etarget, 8);
+
+		emit->data(etarget, prop->val);
+		emit->align(etarget, sizeof(cell_t));
+	}
+
+	if ((vi->flags & FTF_NAMEPROPS) && !seen_name_prop) {
+		emit->property(etarget, NULL);
+		emit->cell(etarget, tree->basenamelen+1);
+		emit->cell(etarget, stringtable_insert(strbuf, "name"));
+
+		if ((vi->flags & FTF_VARALIGN) && ((tree->basenamelen+1) >= 8))
+			emit->align(etarget, 8);
+
+		emit->string(etarget, tree->name, tree->basenamelen);
+		emit->align(etarget, sizeof(cell_t));
+	}
+
+	for_each_child(tree, child) {
+		flatten_tree(child, emit, etarget, strbuf, vi);
+	}
+
+	emit->endnode(etarget, tree->labels);
+}
+
+static struct data flatten_reserve_list(struct reserve_info *reservelist,
+				 struct version_info *vi)
+{
+	struct reserve_info *re;
+	struct data d = empty_data;
+
+	for (re = reservelist; re; re = re->next) {
+		d = data_append_re(d, &re->re);
+	}
+
+	return d;
+}
+
+static void make_fdt_header(struct fdt_header *fdt,
+			    struct version_info *vi,
+			    int reservesize, int dtsize, int strsize,
+			    int boot_cpuid_phys)
+{
+	int reserve_off;
+
+	reservesize += sizeof(struct fdt_reserve_entry);
+
+	memset(fdt, 0xff, sizeof(*fdt));
+
+	fdt->magic = cpu_to_fdt32(FDT_MAGIC);
+	fdt->version = cpu_to_fdt32(vi->version);
+	fdt->last_comp_version = cpu_to_fdt32(vi->last_comp_version);
+
+	/* Reserve map should be doubleword aligned */
+	reserve_off = ALIGN(vi->hdr_size, 8);
+
+	fdt->off_mem_rsvmap = cpu_to_fdt32(reserve_off);
+	fdt->off_dt_struct = cpu_to_fdt32(reserve_off + reservesize);
+	fdt->off_dt_strings = cpu_to_fdt32(reserve_off + reservesize
+					  + dtsize);
+	fdt->totalsize = cpu_to_fdt32(reserve_off + reservesize + dtsize + strsize);
+
+	if (vi->flags & FTF_BOOTCPUID)
+		fdt->boot_cpuid_phys = cpu_to_fdt32(boot_cpuid_phys);
+	if (vi->flags & FTF_STRTABSIZE)
+		fdt->size_dt_strings = cpu_to_fdt32(strsize);
+	if (vi->flags & FTF_STRUCTSIZE)
+		fdt->size_dt_struct = cpu_to_fdt32(dtsize);
+}
+
+void* dt_to_blob_buf(off_t* size, struct boot_info *bi, int version)
+{
+	struct version_info *vi = NULL;
+	int i;
+	struct data blob       = empty_data;
+	struct data reservebuf = empty_data;
+	struct data dtbuf      = empty_data;
+	struct data strbuf     = empty_data;
+	struct fdt_header fdt;
+	int padlen = 0;
+
+	for (i = 0; i < ARRAY_SIZE(version_table); i++) {
+		if (version_table[i].version == version)
+			vi = &version_table[i];
+	}
+
+	if (!vi)
+		die("Unknown device tree blob version %d\n", version);
+
+	flatten_tree(bi->dt, &bin_emitter, &dtbuf, &strbuf, vi);
+	bin_emit_cell(&dtbuf, FDT_END);
+
+	reservebuf = flatten_reserve_list(bi->reservelist, vi);
+
+	/* Make header */
+	make_fdt_header(&fdt, vi, reservebuf.len, dtbuf.len, strbuf.len,
+			bi->boot_cpuid_phys);
+
+	if (padlen > 0) {
+		int tsize = fdt32_to_cpu(fdt.totalsize);
+		tsize += padlen;
+		fdt.totalsize = cpu_to_fdt32(tsize);
+	}
+
+	/*
+	 * Assemble the blob: start with the header, add with alignment
+	 * the reserve buffer, add the reserve map terminating zeroes,
+	 * the device tree itself, and finally the strings.
+	 */
+	blob = data_append_data(blob, &fdt, vi->hdr_size);
+	blob = data_append_align(blob, 8);
+	blob = data_merge(blob, reservebuf);
+	blob = data_append_zeroes(blob, sizeof(struct fdt_reserve_entry));
+	blob = data_merge(blob, dtbuf);
+	blob = data_merge(blob, strbuf);
+
+	*size = blob.len;
+
+	return blob.val;
+}
+
+
+struct inbuf {
+	char *base, *limit, *ptr;
+};
+
+static void inbuf_init(struct inbuf *inb, void *base, void *limit)
+{
+	inb->base = base;
+	inb->limit = limit;
+	inb->ptr = inb->base;
+}
+
+static void flat_read_chunk(struct inbuf *inb, void *p, int len)
+{
+	if ((inb->ptr + len) > inb->limit)
+		die("Premature end of data parsing flat device tree\n");
+
+	memcpy(p, inb->ptr, len);
+
+	inb->ptr += len;
+}
+
+static uint32_t flat_read_word(struct inbuf *inb)
+{
+	uint32_t val;
+
+	assert(((inb->ptr - inb->base) % sizeof(val)) == 0);
+
+	flat_read_chunk(inb, &val, sizeof(val));
+
+	return fdt32_to_cpu(val);
+}
+
+static void flat_realign(struct inbuf *inb, int align)
+{
+	int off = inb->ptr - inb->base;
+
+	inb->ptr = inb->base + ALIGN(off, align);
+	if (inb->ptr > inb->limit)
+		die("Premature end of data parsing flat device tree\n");
+}
+
+static char *flat_read_string(struct inbuf *inb)
+{
+	int len = 0;
+	const char *p = inb->ptr;
+	char *str;
+
+	do {
+		if (p >= inb->limit)
+			die("Premature end of data parsing flat device tree\n");
+		len++;
+	} while ((*p++) != '\0');
+
+	str = xstrdup(inb->ptr);
+
+	inb->ptr += len;
+
+	flat_realign(inb, sizeof(uint32_t));
+
+	return str;
+}
+
+static struct data flat_read_data(struct inbuf *inb, int len)
+{
+	struct data d = empty_data;
+
+	if (len == 0)
+		return empty_data;
+
+	d = data_grow_for(d, len);
+	d.len = len;
+
+	flat_read_chunk(inb, d.val, len);
+
+	flat_realign(inb, sizeof(uint32_t));
+
+	return d;
+}
+
+static char *flat_read_stringtable(struct inbuf *inb, int offset)
+{
+	const char *p;
+
+	p = inb->base + offset;
+	while (1) {
+		if (p >= inb->limit || p < inb->base)
+			die("String offset %d overruns string table\n",
+			    offset);
+
+		if (*p == '\0')
+			break;
+
+		p++;
+	}
+
+	return xstrdup(inb->base + offset);
+}
+
+static struct property *flat_read_property(struct inbuf *dtbuf,
+					   struct inbuf *strbuf, int flags)
+{
+	uint32_t proplen, stroff;
+	char *name;
+	struct data val;
+
+	proplen = flat_read_word(dtbuf);
+	stroff = flat_read_word(dtbuf);
+
+	name = flat_read_stringtable(strbuf, stroff);
+
+	if ((flags & FTF_VARALIGN) && (proplen >= 8))
+		flat_realign(dtbuf, 8);
+
+	val = flat_read_data(dtbuf, proplen);
+
+	return build_property(name, val);
+}
+
+
+static struct reserve_info *flat_read_mem_reserve(struct inbuf *inb)
+{
+	struct reserve_info *reservelist = NULL;
+	struct reserve_info *new;
+	struct fdt_reserve_entry re;
+
+	/*
+	 * Each entry is a pair of u64 (addr, size) values for 4 cell_t's.
+	 * List terminates at an entry with size equal to zero.
+	 *
+	 * First pass, count entries.
+	 */
+	while (1) {
+		flat_read_chunk(inb, &re, sizeof(re));
+		re.address  = fdt64_to_cpu(re.address);
+		re.size = fdt64_to_cpu(re.size);
+		if (re.size == 0)
+			break;
+
+		new = build_reserve_entry(re.address, re.size);
+		reservelist = add_reserve_entry(reservelist, new);
+	}
+
+	return reservelist;
+}
+
+
+static char *nodename_from_path(const char *ppath, const char *cpath)
+{
+	int plen;
+
+	plen = strlen(ppath);
+
+	if (!strneq(ppath, cpath, plen))
+		die("Path \"%s\" is not valid as a child of \"%s\"\n",
+		    cpath, ppath);
+
+	/* root node is a special case */
+	if (!streq(ppath, "/"))
+		plen++;
+
+	return xstrdup(cpath + plen);
+}
+
+static struct node *unflatten_tree(struct inbuf *dtbuf,
+				   struct inbuf *strbuf,
+				   const char *parent_flatname, int flags)
+{
+	struct node *node;
+	char *flatname;
+	uint32_t val;
+
+	node = build_node(NULL, NULL);
+
+	flatname = flat_read_string(dtbuf);
+
+	if (flags & FTF_FULLPATH)
+		node->name = nodename_from_path(parent_flatname, flatname);
+	else
+		node->name = flatname;
+
+	do {
+		struct property *prop;
+		struct node *child;
+
+		val = flat_read_word(dtbuf);
+		switch (val) {
+		case FDT_PROP:
+			if (node->children)
+				fprintf(stderr, "Warning: Flat tree input has "
+					"subnodes preceding a property.\n");
+			prop = flat_read_property(dtbuf, strbuf, flags);
+			add_property(node, prop);
+			break;
+
+		case FDT_BEGIN_NODE:
+			child = unflatten_tree(dtbuf,strbuf, flatname, flags);
+			add_child(node, child);
+			break;
+
+		case FDT_END_NODE:
+			break;
+
+		case FDT_END:
+			die("Premature FDT_END in device tree blob\n");
+			break;
+
+		case FDT_NOP:
+			if (!(flags & FTF_NOPS))
+				fprintf(stderr, "Warning: NOP tag found in flat tree"
+					" version <16\n");
+
+			/* Ignore */
+			break;
+
+		default:
+			die("Invalid opcode word %08x in device tree blob\n",
+			    val);
+		}
+	} while (val != FDT_END_NODE);
+
+	return node;
+}
+
+
+struct boot_info *dt_from_blob(const char *fname)
+{
+	FILE *f;
+	uint32_t magic, totalsize, version, size_dt, boot_cpuid_phys;
+	uint32_t off_dt, off_str, off_mem_rsvmap;
+	int rc;
+	char *blob;
+	struct fdt_header *fdt;
+	char *p;
+	struct inbuf dtbuf, strbuf;
+	struct inbuf memresvbuf;
+	int sizeleft;
+	struct reserve_info *reservelist;
+	struct node *tree;
+	uint32_t val;
+	int flags = 0;
+
+	f = srcfile_relative_open(fname, NULL);
+
+	rc = fread(&magic, sizeof(magic), 1, f);
+	if (ferror(f))
+		die("Error reading DT blob magic number: %s\n",
+		    strerror(errno));
+	if (rc < 1) {
+		if (feof(f))
+			die("EOF reading DT blob magic number\n");
+		else
+			die("Mysterious short read reading magic number\n");
+	}
+
+	magic = fdt32_to_cpu(magic);
+	if (magic != FDT_MAGIC)
+		die("Blob has incorrect magic number\n");
+
+	rc = fread(&totalsize, sizeof(totalsize), 1, f);
+	if (ferror(f))
+		die("Error reading DT blob size: %s\n", strerror(errno));
+	if (rc < 1) {
+		if (feof(f))
+			die("EOF reading DT blob size\n");
+		else
+			die("Mysterious short read reading blob size\n");
+	}
+
+	totalsize = fdt32_to_cpu(totalsize);
+	if (totalsize < FDT_V1_SIZE)
+		die("DT blob size (%d) is too small\n", totalsize);
+
+	blob = xmalloc(totalsize);
+
+	fdt = (struct fdt_header *)blob;
+	fdt->magic = cpu_to_fdt32(magic);
+	fdt->totalsize = cpu_to_fdt32(totalsize);
+
+	sizeleft = totalsize - sizeof(magic) - sizeof(totalsize);
+	p = blob + sizeof(magic)  + sizeof(totalsize);
+
+	while (sizeleft) {
+		if (feof(f))
+			die("EOF before reading %d bytes of DT blob\n",
+			    totalsize);
+
+		rc = fread(p, 1, sizeleft, f);
+		if (ferror(f))
+			die("Error reading DT blob: %s\n",
+			    strerror(errno));
+
+		sizeleft -= rc;
+		p += rc;
+	}
+
+	off_dt = fdt32_to_cpu(fdt->off_dt_struct);
+	off_str = fdt32_to_cpu(fdt->off_dt_strings);
+	off_mem_rsvmap = fdt32_to_cpu(fdt->off_mem_rsvmap);
+	version = fdt32_to_cpu(fdt->version);
+	boot_cpuid_phys = fdt32_to_cpu(fdt->boot_cpuid_phys);
+
+	if (off_mem_rsvmap >= totalsize)
+		die("Mem Reserve structure offset exceeds total size\n");
+
+	if (off_dt >= totalsize)
+		die("DT structure offset exceeds total size\n");
+
+	if (off_str > totalsize)
+		die("String table offset exceeds total size\n");
+
+	if (version >= 3) {
+		uint32_t size_str = fdt32_to_cpu(fdt->size_dt_strings);
+		if (off_str+size_str > totalsize)
+			die("String table extends past total size\n");
+		inbuf_init(&strbuf, blob + off_str, blob + off_str + size_str);
+	} else {
+		inbuf_init(&strbuf, blob + off_str, blob + totalsize);
+	}
+
+	if (version >= 17) {
+		size_dt = fdt32_to_cpu(fdt->size_dt_struct);
+		if (off_dt+size_dt > totalsize)
+			die("Structure block extends past total size\n");
+	}
+
+	if (version < 16) {
+		flags |= FTF_FULLPATH | FTF_NAMEPROPS | FTF_VARALIGN;
+	} else {
+		flags |= FTF_NOPS;
+	}
+
+	inbuf_init(&memresvbuf,
+		   blob + off_mem_rsvmap, blob + totalsize);
+	inbuf_init(&dtbuf, blob + off_dt, blob + totalsize);
+
+	reservelist = flat_read_mem_reserve(&memresvbuf);
+
+	val = flat_read_word(&dtbuf);
+
+	if (val != FDT_BEGIN_NODE)
+		die("Device tree blob doesn't begin with FDT_BEGIN_NODE (begins with 0x%08x)\n", val);
+
+	tree = unflatten_tree(&dtbuf, &strbuf, "", flags);
+
+	val = flat_read_word(&dtbuf);
+	if (val != FDT_END)
+		die("Device tree blob doesn't end with FDT_END\n");
+
+	free(blob);
+
+	fclose(f);
+
+	return build_boot_info(reservelist, tree, boot_cpuid_phys);
+}
diff --git a/util_lib/dtc/fstree.c b/util_lib/dtc/fstree.c
new file mode 100644
index 0000000..f377453
--- /dev/null
+++ b/util_lib/dtc/fstree.c
@@ -0,0 +1,91 @@
+/*
+ * (C) Copyright David Gibson <dwg@au1.ibm.com>, IBM Corporation.  2005.
+ *
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of the
+ * License, or (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307
+ *                                                                   USA
+ */
+
+#include "dtc.h"
+
+#include <dirent.h>
+#include <sys/stat.h>
+
+static struct node *read_fstree(const char *dirname)
+{
+	DIR *d;
+	struct dirent *de;
+	struct stat st;
+	struct node *tree;
+
+	d = opendir(dirname);
+	if (!d)
+		die("Couldn't opendir() \"%s\": %s\n", dirname, strerror(errno));
+
+	tree = build_node(NULL, NULL);
+
+	while ((de = readdir(d)) != NULL) {
+		char *tmpnam;
+
+		if (streq(de->d_name, ".")
+		    || streq(de->d_name, ".."))
+			continue;
+
+		tmpnam = join_path(dirname, de->d_name);
+
+		if (lstat(tmpnam, &st) < 0)
+			die("stat(%s): %s\n", tmpnam, strerror(errno));
+
+		if (S_ISREG(st.st_mode)) {
+			struct property *prop;
+			FILE *pfile;
+
+			pfile = fopen(tmpnam, "r");
+			if (! pfile) {
+				fprintf(stderr,
+					"WARNING: Cannot open %s: %s\n",
+					tmpnam, strerror(errno));
+			} else {
+				prop = build_property(xstrdup(de->d_name),
+						      data_copy_file(pfile,
+								     st.st_size));
+				add_property(tree, prop);
+				fclose(pfile);
+			}
+		} else if (S_ISDIR(st.st_mode)) {
+			struct node *newchild;
+
+			newchild = read_fstree(tmpnam);
+			newchild = name_node(newchild, xstrdup(de->d_name));
+			add_child(tree, newchild);
+		}
+
+		free(tmpnam);
+	}
+
+	closedir(d);
+	return tree;
+}
+
+struct boot_info *dt_from_fs(const char *dirname)
+{
+	struct node *tree;
+
+	tree = read_fstree(dirname);
+	tree = name_node(tree, "");
+
+	return build_boot_info(NULL, tree, guess_boot_cpuid(tree));
+}
+
diff --git a/util_lib/dtc/livetree.c b/util_lib/dtc/livetree.c
new file mode 100644
index 0000000..1420804
--- /dev/null
+++ b/util_lib/dtc/livetree.c
@@ -0,0 +1,579 @@
+/*
+ * (C) Copyright David Gibson <dwg@au1.ibm.com>, IBM Corporation.  2005.
+ *
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of the
+ * License, or (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307
+ *                                                                   USA
+ */
+
+#include "dtc.h"
+
+/*
+ * Tree building functions
+ */
+
+void add_label(struct label **labels, char *label)
+{
+	struct label *new;
+
+	/* Make sure the label isn't already there */
+	for_each_label(*labels, new)
+		if (streq(new->label, label))
+			return;
+
+	new = xmalloc(sizeof(*new));
+	new->label = label;
+	new->next = *labels;
+	*labels = new;
+}
+
+struct property *build_property(char *name, struct data val)
+{
+	struct property *new = xmalloc(sizeof(*new));
+
+	memset(new, 0, sizeof(*new));
+
+	new->name = name;
+	new->val = val;
+
+	return new;
+}
+
+struct property *chain_property(struct property *first, struct property *list)
+{
+	assert(first->next == NULL);
+
+	first->next = list;
+	return first;
+}
+
+struct property *reverse_properties(struct property *first)
+{
+	struct property *p = first;
+	struct property *head = NULL;
+	struct property *next;
+
+	while (p) {
+		next = p->next;
+		p->next = head;
+		head = p;
+		p = next;
+	}
+	return head;
+}
+
+struct node *build_node(struct property *proplist, struct node *children)
+{
+	struct node *new = xmalloc(sizeof(*new));
+	struct node *child;
+
+	memset(new, 0, sizeof(*new));
+
+	new->proplist = reverse_properties(proplist);
+	new->children = children;
+
+	for_each_child(new, child) {
+		child->parent = new;
+	}
+
+	return new;
+}
+
+struct node *name_node(struct node *node, char *name)
+{
+	assert(node->name == NULL);
+
+	node->name = name;
+
+	return node;
+}
+
+struct node *merge_nodes(struct node *old_node, struct node *new_node)
+{
+	struct property *new_prop, *old_prop;
+	struct node *new_child, *old_child;
+	struct label *l;
+
+	/* Add new node labels to old node */
+	for_each_label(new_node->labels, l)
+		add_label(&old_node->labels, l->label);
+
+	/* Move properties from the new node to the old node.  If there
+	 * is a collision, replace the old value with the new */
+	while (new_node->proplist) {
+		/* Pop the property off the list */
+		new_prop = new_node->proplist;
+		new_node->proplist = new_prop->next;
+		new_prop->next = NULL;
+
+		/* Look for a collision, set new value if there is */
+		for_each_property(old_node, old_prop) {
+			if (streq(old_prop->name, new_prop->name)) {
+				/* Add new labels to old property */
+				for_each_label(new_prop->labels, l)
+					add_label(&old_prop->labels, l->label);
+
+				old_prop->val = new_prop->val;
+				free(new_prop);
+				new_prop = NULL;
+				break;
+			}
+		}
+
+		/* if no collision occurred, add property to the old node. */
+		if (new_prop)
+			add_property(old_node, new_prop);
+	}
+
+	/* Move the override child nodes into the primary node.  If
+	 * there is a collision, then merge the nodes. */
+	while (new_node->children) {
+		/* Pop the child node off the list */
+		new_child = new_node->children;
+		new_node->children = new_child->next_sibling;
+		new_child->parent = NULL;
+		new_child->next_sibling = NULL;
+
+		/* Search for a collision.  Merge if there is */
+		for_each_child(old_node, old_child) {
+			if (streq(old_child->name, new_child->name)) {
+				merge_nodes(old_child, new_child);
+				new_child = NULL;
+				break;
+			}
+		}
+
+		/* if no collision occurred, add child to the old node. */
+		if (new_child)
+			add_child(old_node, new_child);
+	}
+
+	/* The new node contents are now merged into the old node.  Free
+	 * the new node. */
+	free(new_node);
+
+	return old_node;
+}
+
+struct node *chain_node(struct node *first, struct node *list)
+{
+	assert(first->next_sibling == NULL);
+
+	first->next_sibling = list;
+	return first;
+}
+
+void add_property(struct node *node, struct property *prop)
+{
+	struct property **p;
+
+	prop->next = NULL;
+
+	p = &node->proplist;
+	while (*p)
+		p = &((*p)->next);
+
+	*p = prop;
+}
+
+void add_child(struct node *parent, struct node *child)
+{
+	struct node **p;
+
+	child->next_sibling = NULL;
+	child->parent = parent;
+
+	p = &parent->children;
+	while (*p)
+		p = &((*p)->next_sibling);
+
+	*p = child;
+}
+
+struct reserve_info *build_reserve_entry(uint64_t address, uint64_t size)
+{
+	struct reserve_info *new = xmalloc(sizeof(*new));
+
+	memset(new, 0, sizeof(*new));
+
+	new->re.address = address;
+	new->re.size = size;
+
+	return new;
+}
+
+struct reserve_info *chain_reserve_entry(struct reserve_info *first,
+					struct reserve_info *list)
+{
+	assert(first->next == NULL);
+
+	first->next = list;
+	return first;
+}
+
+struct reserve_info *add_reserve_entry(struct reserve_info *list,
+				      struct reserve_info *new)
+{
+	struct reserve_info *last;
+
+	new->next = NULL;
+
+	if (! list)
+		return new;
+
+	for (last = list; last->next; last = last->next)
+		;
+
+	last->next = new;
+
+	return list;
+}
+
+struct boot_info *build_boot_info(struct reserve_info *reservelist,
+				  struct node *tree, uint32_t boot_cpuid_phys)
+{
+	struct boot_info *bi;
+
+	bi = xmalloc(sizeof(*bi));
+	bi->reservelist = reservelist;
+	bi->dt = tree;
+	bi->boot_cpuid_phys = boot_cpuid_phys;
+
+	return bi;
+}
+
+/*
+ * Tree accessor functions
+ */
+
+const char *get_unitname(struct node *node)
+{
+	if (node->name[node->basenamelen] == '\0')
+		return "";
+	else
+		return node->name + node->basenamelen + 1;
+}
+
+struct property *get_property(struct node *node, const char *propname)
+{
+	struct property *prop;
+
+	for_each_property(node, prop)
+		if (streq(prop->name, propname))
+			return prop;
+
+	return NULL;
+}
+
+cell_t propval_cell(struct property *prop)
+{
+	assert(prop->val.len == sizeof(cell_t));
+	return fdt32_to_cpu(*((cell_t *)prop->val.val));
+}
+
+struct property *get_property_by_label(struct node *tree, const char *label,
+				       struct node **node)
+{
+	struct property *prop;
+	struct node *c;
+
+	*node = tree;
+
+	for_each_property(tree, prop) {
+		struct label *l;
+
+		for_each_label(prop->labels, l)
+			if (streq(l->label, label))
+				return prop;
+	}
+
+	for_each_child(tree, c) {
+		prop = get_property_by_label(c, label, node);
+		if (prop)
+			return prop;
+	}
+
+	*node = NULL;
+	return NULL;
+}
+
+struct marker *get_marker_label(struct node *tree, const char *label,
+				struct node **node, struct property **prop)
+{
+	struct marker *m;
+	struct property *p;
+	struct node *c;
+
+	*node = tree;
+
+	for_each_property(tree, p) {
+		*prop = p;
+		m = p->val.markers;
+		for_each_marker_of_type(m, LABEL)
+			if (streq(m->ref, label))
+				return m;
+	}
+
+	for_each_child(tree, c) {
+		m = get_marker_label(c, label, node, prop);
+		if (m)
+			return m;
+	}
+
+	*prop = NULL;
+	*node = NULL;
+	return NULL;
+}
+
+struct node *get_subnode(struct node *node, const char *nodename)
+{
+	struct node *child;
+
+	for_each_child(node, child)
+		if (streq(child->name, nodename))
+			return child;
+
+	return NULL;
+}
+
+struct node *get_node_by_path(struct node *tree, const char *path)
+{
+	const char *p;
+	struct node *child;
+
+	if (!path || ! (*path))
+		return tree;
+
+	while (path[0] == '/')
+		path++;
+
+	p = strchr(path, '/');
+
+	for_each_child(tree, child) {
+		if (p && strneq(path, child->name, p-path))
+			return get_node_by_path(child, p+1);
+		else if (!p && streq(path, child->name))
+			return child;
+	}
+
+	return NULL;
+}
+
+struct node *get_node_by_label(struct node *tree, const char *label)
+{
+	struct node *child, *node;
+	struct label *l;
+
+	assert(label && (strlen(label) > 0));
+
+	for_each_label(tree->labels, l)
+		if (streq(l->label, label))
+			return tree;
+
+	for_each_child(tree, child) {
+		node = get_node_by_label(child, label);
+		if (node)
+			return node;
+	}
+
+	return NULL;
+}
+
+struct node *get_node_by_phandle(struct node *tree, cell_t phandle)
+{
+	struct node *child, *node;
+
+	assert((phandle != 0) && (phandle != -1));
+
+	if (tree->phandle == phandle)
+		return tree;
+
+	for_each_child(tree, child) {
+		node = get_node_by_phandle(child, phandle);
+		if (node)
+			return node;
+	}
+
+	return NULL;
+}
+
+struct node *get_node_by_ref(struct node *tree, const char *ref)
+{
+	if (ref[0] == '/')
+		return get_node_by_path(tree, ref);
+	else
+		return get_node_by_label(tree, ref);
+}
+
+
+uint32_t guess_boot_cpuid(struct node *tree)
+{
+	struct node *cpus, *bootcpu;
+	struct property *reg;
+
+	cpus = get_node_by_path(tree, "/cpus");
+	if (!cpus)
+		return 0;
+
+
+	bootcpu = cpus->children;
+	if (!bootcpu)
+		return 0;
+
+	reg = get_property(bootcpu, "reg");
+	if (!reg || (reg->val.len != sizeof(uint32_t)))
+		return 0;
+
+	/* FIXME: Sanity check node? */
+
+	return propval_cell(reg);
+}
+
+static int cmp_reserve_info(const void *ax, const void *bx)
+{
+	const struct reserve_info *a, *b;
+
+	a = *((const struct reserve_info * const *)ax);
+	b = *((const struct reserve_info * const *)bx);
+
+	if (a->re.address < b->re.address)
+		return -1;
+	else if (a->re.address > b->re.address)
+		return 1;
+	else if (a->re.size < b->re.size)
+		return -1;
+	else if (a->re.size > b->re.size)
+		return 1;
+	else
+		return 0;
+}
+
+static void sort_reserve_entries(struct boot_info *bi)
+{
+	struct reserve_info *ri, **tbl;
+	int n = 0, i = 0;
+
+	for (ri = bi->reservelist;
+	     ri;
+	     ri = ri->next)
+		n++;
+
+	if (n == 0)
+		return;
+
+	tbl = xmalloc(n * sizeof(*tbl));
+
+	for (ri = bi->reservelist;
+	     ri;
+	     ri = ri->next)
+		tbl[i++] = ri;
+
+	qsort(tbl, n, sizeof(*tbl), cmp_reserve_info);
+
+	bi->reservelist = tbl[0];
+	for (i = 0; i < (n-1); i++)
+		tbl[i]->next = tbl[i+1];
+	tbl[n-1]->next = NULL;
+
+	free(tbl);
+}
+
+static int cmp_prop(const void *ax, const void *bx)
+{
+	const struct property *a, *b;
+
+	a = *((const struct property * const *)ax);
+	b = *((const struct property * const *)bx);
+
+	return strcmp(a->name, b->name);
+}
+
+static void sort_properties(struct node *node)
+{
+	int n = 0, i = 0;
+	struct property *prop, **tbl;
+
+	for_each_property(node, prop)
+		n++;
+
+	if (n == 0)
+		return;
+
+	tbl = xmalloc(n * sizeof(*tbl));
+
+	for_each_property(node, prop)
+		tbl[i++] = prop;
+
+	qsort(tbl, n, sizeof(*tbl), cmp_prop);
+
+	node->proplist = tbl[0];
+	for (i = 0; i < (n-1); i++)
+		tbl[i]->next = tbl[i+1];
+	tbl[n-1]->next = NULL;
+
+	free(tbl);
+}
+
+static int cmp_subnode(const void *ax, const void *bx)
+{
+	const struct node *a, *b;
+
+	a = *((const struct node * const *)ax);
+	b = *((const struct node * const *)bx);
+
+	return strcmp(a->name, b->name);
+}
+
+static void sort_subnodes(struct node *node)
+{
+	int n = 0, i = 0;
+	struct node *subnode, **tbl;
+
+	for_each_child(node, subnode)
+		n++;
+
+	if (n == 0)
+		return;
+
+	tbl = xmalloc(n * sizeof(*tbl));
+
+	for_each_child(node, subnode)
+		tbl[i++] = subnode;
+
+	qsort(tbl, n, sizeof(*tbl), cmp_subnode);
+
+	node->children = tbl[0];
+	for (i = 0; i < (n-1); i++)
+		tbl[i]->next_sibling = tbl[i+1];
+	tbl[n-1]->next_sibling = NULL;
+
+	free(tbl);
+}
+
+static void sort_node(struct node *node)
+{
+	struct node *c;
+
+	sort_properties(node);
+	sort_subnodes(node);
+	for_each_child(node, c)
+		sort_node(c);
+}
+
+void sort_tree(struct boot_info *bi)
+{
+	sort_reserve_entries(bi);
+	sort_node(bi->dt);
+}
diff --git a/util_lib/dtc/srcpos.c b/util_lib/dtc/srcpos.c
new file mode 100644
index 0000000..36a38e9
--- /dev/null
+++ b/util_lib/dtc/srcpos.c
@@ -0,0 +1,252 @@
+/*
+ * Copyright 2007 Jon Loeliger, Freescale Semiconductor, Inc.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of the
+ * License, or (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307
+ *                                                                   USA
+ */
+
+#define _GNU_SOURCE
+
+#include <stdio.h>
+
+#include "dtc.h"
+#include "srcpos.h"
+
+
+static char *dirname(const char *path)
+{
+	const char *slash = strrchr(path, '/');
+
+	if (slash) {
+		int len = slash - path;
+		char *dir = xmalloc(len + 1);
+
+		memcpy(dir, path, len);
+		dir[len] = '\0';
+		return dir;
+	}
+	return NULL;
+}
+
+FILE *depfile; /* = NULL */
+struct srcfile_state *current_srcfile; /* = NULL */
+
+/* Detect infinite include recursion. */
+#define MAX_SRCFILE_DEPTH     (100)
+static int srcfile_depth; /* = 0 */
+
+FILE *srcfile_relative_open(const char *fname, char **fullnamep)
+{
+	FILE *f;
+	char *fullname;
+
+	if (streq(fname, "-")) {
+		f = stdin;
+		fullname = xstrdup("<stdin>");
+	} else {
+		if (!current_srcfile || !current_srcfile->dir
+		    || (fname[0] == '/'))
+			fullname = xstrdup(fname);
+		else
+			fullname = join_path(current_srcfile->dir, fname);
+
+		f = fopen(fullname, "r");
+		if (!f)
+			die("Couldn't open \"%s\": %s\n", fname,
+			    strerror(errno));
+	}
+
+	if (depfile)
+		fprintf(depfile, " %s", fullname);
+
+	if (fullnamep)
+		*fullnamep = fullname;
+	else
+		free(fullname);
+
+	return f;
+}
+
+void srcfile_push(const char *fname)
+{
+	struct srcfile_state *srcfile;
+
+	if (srcfile_depth++ >= MAX_SRCFILE_DEPTH)
+		die("Includes nested too deeply");
+
+	srcfile = xmalloc(sizeof(*srcfile));
+
+	srcfile->f = srcfile_relative_open(fname, &srcfile->name);
+	srcfile->dir = dirname(srcfile->name);
+	srcfile->prev = current_srcfile;
+
+	srcfile->lineno = 1;
+	srcfile->colno = 1;
+
+	current_srcfile = srcfile;
+}
+
+int srcfile_pop(void)
+{
+	struct srcfile_state *srcfile = current_srcfile;
+
+	assert(srcfile);
+
+	current_srcfile = srcfile->prev;
+
+	if (fclose(srcfile->f))
+		die("Error closing \"%s\": %s\n", srcfile->name,
+		    strerror(errno));
+
+	/* FIXME: We allow the srcfile_state structure to leak,
+	 * because it could still be referenced from a location
+	 * variable being carried through the parser somewhere.  To
+	 * fix this we could either allocate all the files from a
+	 * table, or use a pool allocator. */
+
+	return current_srcfile ? 1 : 0;
+}
+
+/*
+ * The empty source position.
+ */
+
+struct srcpos srcpos_empty = {
+	.first_line = 0,
+	.first_column = 0,
+	.last_line = 0,
+	.last_column = 0,
+	.file = NULL,
+};
+
+#define TAB_SIZE      8
+
+void srcpos_update(struct srcpos *pos, const char *text, int len)
+{
+	int i;
+
+	pos->file = current_srcfile;
+
+	pos->first_line = current_srcfile->lineno;
+	pos->first_column = current_srcfile->colno;
+
+	for (i = 0; i < len; i++)
+		if (text[i] == '\n') {
+			current_srcfile->lineno++;
+			current_srcfile->colno = 1;
+		} else if (text[i] == '\t') {
+			current_srcfile->colno =
+				ALIGN(current_srcfile->colno, TAB_SIZE);
+		} else {
+			current_srcfile->colno++;
+		}
+
+	pos->last_line = current_srcfile->lineno;
+	pos->last_column = current_srcfile->colno;
+}
+
+struct srcpos *
+srcpos_copy(struct srcpos *pos)
+{
+	struct srcpos *pos_new;
+
+	pos_new = xmalloc(sizeof(struct srcpos));
+	memcpy(pos_new, pos, sizeof(struct srcpos));
+
+	return pos_new;
+}
+
+
+
+void
+srcpos_dump(struct srcpos *pos)
+{
+	printf("file        : \"%s\"\n",
+	       pos->file ? (char *) pos->file : "<no file>");
+	printf("first_line  : %d\n", pos->first_line);
+	printf("first_column: %d\n", pos->first_column);
+	printf("last_line   : %d\n", pos->last_line);
+	printf("last_column : %d\n", pos->last_column);
+	printf("file        : %s\n", pos->file->name);
+}
+
+
+char *
+srcpos_string(struct srcpos *pos)
+{
+	const char *fname = "<no-file>";
+	char *pos_str;
+	int rc;
+
+	if (pos)
+		fname = pos->file->name;
+
+
+	if (pos->first_line != pos->last_line)
+		rc = asprintf(&pos_str, "%s:%d.%d-%d.%d", fname,
+			      pos->first_line, pos->first_column,
+			      pos->last_line, pos->last_column);
+	else if (pos->first_column != pos->last_column)
+		rc = asprintf(&pos_str, "%s:%d.%d-%d", fname,
+			      pos->first_line, pos->first_column,
+			      pos->last_column);
+	else
+		rc = asprintf(&pos_str, "%s:%d.%d", fname,
+			      pos->first_line, pos->first_column);
+
+	if (rc == -1)
+		die("Couldn't allocate in srcpos string");
+
+	return pos_str;
+}
+
+void
+srcpos_verror(struct srcpos *pos, char const *fmt, va_list va)
+{
+       const char *srcstr;
+
+       srcstr = srcpos_string(pos);
+
+       fprintf(stdout, "Error: %s ", srcstr);
+       vfprintf(stdout, fmt, va);
+       fprintf(stdout, "\n");
+}
+
+void
+srcpos_error(struct srcpos *pos, char const *fmt, ...)
+{
+	va_list va;
+
+	va_start(va, fmt);
+	srcpos_verror(pos, fmt, va);
+	va_end(va);
+}
+
+
+void
+srcpos_warn(struct srcpos *pos, char const *fmt, ...)
+{
+	const char *srcstr;
+	va_list va;
+	va_start(va, fmt);
+
+	srcstr = srcpos_string(pos);
+
+	fprintf(stderr, "Warning: %s ", srcstr);
+	vfprintf(stderr, fmt, va);
+	fprintf(stderr, "\n");
+
+	va_end(va);
+}
diff --git a/util_lib/dtc/srcpos.h b/util_lib/dtc/srcpos.h
new file mode 100644
index 0000000..ce980ca
--- /dev/null
+++ b/util_lib/dtc/srcpos.h
@@ -0,0 +1,87 @@
+/*
+ * Copyright 2007 Jon Loeliger, Freescale Semiconductor, Inc.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of the
+ * License, or (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307
+ *                                                                   USA
+ */
+
+#ifndef _SRCPOS_H_
+#define _SRCPOS_H_
+
+#include <stdio.h>
+
+struct srcfile_state {
+	FILE *f;
+	char *name;
+	char *dir;
+	int lineno, colno;
+	struct srcfile_state *prev;
+};
+
+extern FILE *depfile; /* = NULL */
+extern struct srcfile_state *current_srcfile; /* = NULL */
+
+FILE *srcfile_relative_open(const char *fname, char **fullnamep);
+void srcfile_push(const char *fname);
+int srcfile_pop(void);
+
+struct srcpos {
+    int first_line;
+    int first_column;
+    int last_line;
+    int last_column;
+    struct srcfile_state *file;
+};
+
+#define YYLTYPE struct srcpos
+
+#define YYLLOC_DEFAULT(Current, Rhs, N)						\
+	do {									\
+		if (N) {							\
+			(Current).first_line = YYRHSLOC(Rhs, 1).first_line;	\
+			(Current).first_column = YYRHSLOC(Rhs, 1).first_column;	\
+			(Current).last_line = YYRHSLOC(Rhs, N).last_line;	\
+			(Current).last_column  = YYRHSLOC (Rhs, N).last_column;	\
+			(Current).file = YYRHSLOC(Rhs, N).file;			\
+		} else {							\
+			(Current).first_line = (Current).last_line =		\
+				YYRHSLOC(Rhs, 0).last_line;			\
+			(Current).first_column = (Current).last_column =	\
+				YYRHSLOC(Rhs, 0).last_column;			\
+			(Current).file = YYRHSLOC (Rhs, 0).file;		\
+		}								\
+	} while (0)
+
+
+/*
+ * Fictional source position used for IR nodes that are
+ * created without otherwise knowing a true source position.
+ * For example,constant definitions from the command line.
+ */
+extern struct srcpos srcpos_empty;
+
+extern void srcpos_update(struct srcpos *pos, const char *text, int len);
+extern struct srcpos *srcpos_copy(struct srcpos *pos);
+extern char *srcpos_string(struct srcpos *pos);
+extern void srcpos_dump(struct srcpos *pos);
+
+extern void srcpos_verror(struct srcpos *pos, char const *, va_list va)
+     __attribute__((format(printf, 2, 0)));
+extern void srcpos_error(struct srcpos *pos, char const *, ...)
+     __attribute__((format(printf, 2, 3)));
+extern void srcpos_warn(struct srcpos *pos, char const *, ...)
+     __attribute__((format(printf, 2, 3)));
+
+#endif /* _SRCPOS_H_ */
diff --git a/util_lib/dtc/util.c b/util_lib/dtc/util.c
new file mode 100644
index 0000000..d7ac27d
--- /dev/null
+++ b/util_lib/dtc/util.c
@@ -0,0 +1,59 @@
+/*
+ * Copyright 2008 Jon Loeliger, Freescale Semiconductor, Inc.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of the
+ * License, or (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307
+ *                                                                   USA
+ */
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <stdarg.h>
+#include <string.h>
+
+#include "util.h"
+
+char *xstrdup(const char *s)
+{
+	int len = strlen(s) + 1;
+	char *dup = xmalloc(len);
+
+	memcpy(dup, s, len);
+
+	return dup;
+}
+
+char *join_path(const char *path, const char *name)
+{
+	int lenp = strlen(path);
+	int lenn = strlen(name);
+	int len;
+	int needslash = 1;
+	char *str;
+
+	len = lenp + lenn + 2;
+	if ((lenp > 0) && (path[lenp-1] == '/')) {
+		needslash = 0;
+		len--;
+	}
+
+	str = xmalloc(len);
+	memcpy(str, path, lenp);
+	if (needslash) {
+		str[lenp] = '/';
+		lenp++;
+	}
+	memcpy(str+lenp, name, lenn+1);
+	return str;
+}
diff --git a/util_lib/dtc/util.h b/util_lib/dtc/util.h
new file mode 100644
index 0000000..9cead84
--- /dev/null
+++ b/util_lib/dtc/util.h
@@ -0,0 +1,56 @@
+#ifndef _UTIL_H
+#define _UTIL_H
+
+/*
+ * Copyright 2008 Jon Loeliger, Freescale Semiconductor, Inc.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of the
+ * License, or (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307
+ *                                                                   USA
+ */
+
+static inline void __attribute__((noreturn)) die(char * str, ...)
+{
+	va_list ap;
+
+	va_start(ap, str);
+	fprintf(stderr, "FATAL ERROR: ");
+	vfprintf(stderr, str, ap);
+	exit(1);
+}
+
+static inline void *xmalloc(size_t len)
+{
+	void *new = malloc(len);
+
+	if (!new)
+		die("malloc() failed\n");
+
+	return new;
+}
+
+static inline void *xrealloc(void *p, size_t len)
+{
+	void *new = realloc(p, len);
+
+	if (!new)
+		die("realloc() failed (len=%d)\n", len);
+
+	return new;
+}
+
+extern char *xstrdup(const char *s);
+extern char *join_path(const char *path, const char *name);
+
+#endif /* _UTIL_H */
diff --git a/util_lib/dtc/version_gen.h b/util_lib/dtc/version_gen.h
new file mode 100644
index 0000000..6158b86
--- /dev/null
+++ b/util_lib/dtc/version_gen.h
@@ -0,0 +1 @@
+#define DTC_VERSION "DTC 1.2.0-g37c0b6a0"
-- 
1.7.12


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
