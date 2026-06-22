Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39336CDB475
	for <kexec@archiver.kernel.org>; Mon, 22 Jun 2026 20:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PX1SOH85oCvoNlJIK1aAqVrdC4MnLqs5gBNvDLGgYDs=; b=dSues6wzUtjLT6EPl8V6eXiqaJ
	xcGQIjMiwF5RMaHQsYbIVU9gX0ySnYlybWSbjKp19gJw9wXnidMTL0RD+9nHsuesA7PgBSbNbZKgW
	lgcTRcm4NSLke+qxqOI11sq5jrLHVR6ZIuubUPO07DRJZoli6HSj2HTaBrN3HtWFJwjnJl6YJAOxw
	FweZsZ23jv7u8qminJ6b6NVJJ4syfYXlQyKhzYmggIBAFGh7BHdcx+8OwOO+WXECQ8mvhH+GT9Z18
	sJBWLlxCvhNGZqiZvV6SHv35c2uYiMEiHixknPc6EQcFUM9znfYjH7aRAaBGhI4d0h8tQCBIW2jbp
	61XIOFTg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wblge-00000005Ni0-01YQ;
	Mon, 22 Jun 2026 20:56:08 +0000
Received: from esa1.hc555-34.eu.iphmx.com ([23.90.104.144])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wblgb-00000005Nfh-0H8R
	for kexec@lists.infradead.org;
	Mon, 22 Jun 2026 20:56:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=mobileye.com; i=@mobileye.com; q=dns/txt; s=MoEyIP;
  t=1782161765; x=1813697765;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eFxRHzradr11Y6VaOc+OEm/AcX8JO3KuNVXgcBn35aw=;
  b=I0BbnAYDtTOU6Rt3uRa7qvgn/+NnFJ5IxEQSkk36uZrjTLY98MfMAR7V
   2d7ibUvr3S0gDt7g1IMS4s/TjTPYX+ifc9ECbcIJbbNFuj5bTP/cVW/Cf
   0FgGPrEC+SXXDiBgiGWyoCA4Z8N5mbYT78FU9MyFxUiRII38e2tV1HcKW
   Gl+HlzwVFca6X2Ozd20eb3NhlqvJ7rMEWBHqGLlPDRKcCM8qR4OsAcXuq
   EfKhn13dGl3TPzIpm8dt0zMQz/e/ouKoTpFCcQfcg+47XtxY0BAko/GPf
   clz37w/7fJlA4SfFXl5wwgmm9rVcyFcfVtHPj6vIeMKgs4eVUdVXBkYBC
   g==;
X-CSE-ConnectionGUID: 25uvBqGFQ8maQWbClrd9hw==
X-CSE-MsgGUID: HOJWuRvQQ6+v1JEDYWfsYA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from unknown (HELO ces04_data.me-crop.lan) ([146.255.191.134])
  by esa1.hc555-34.eu.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2026 23:56:03 +0300
X-CSE-ConnectionGUID: WT69FjwWRfe83I8mX48wew==
X-CSE-MsgGUID: YHfXk2VjSeuhdZLdnZ/8pA==
Received: from unknown (HELO epgd034.me-corp.lan) ([10.154.54.2])
  by ces04_data.me-crop.lan with SMTP; 23 Jun 2026 00:01:10 +0300
Received: by epgd034.me-corp.lan (sSMTP sendmail emulation); Mon, 22 Jun 2026 23:56:02 +0300
From: Pnina Feder <pnina.feder@mobileye.com>
To: kexec@lists.infradead.org
Cc: horms@kernel.org,
	Pnina Feder <pnina.feder@mobileye.com>
Subject: [PATCH 03/10] util_lib: Add maple tree walker for VMA enumeration
Date: Mon, 22 Jun 2026 23:54:41 +0300
Message-ID: <20260622205550.1087163-4-pnina.feder@mobileye.com>
In-Reply-To: <20260622205550.1087163-1-pnina.feder@mobileye.com>
References: <20260622205550.1087163-1-pnina.feder@mobileye.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260622_135605_584611_295FE939 
X-CRM114-Status: GOOD (  23.02  )
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Port the maple tree traversal logic from crash-utility to support
walking the kernel's VMA maple tree structure. Supports count,
search, gather, and dump operations.

This is needed for enumerating process virtual memory areas (VMAs)
when building per-task memory snapshots.
Needed for Linux 6.x and up.

Signed-off-by: Pnina Feder <pnina.feder@mobileye.com>
---
 util_lib/include/maple_tree.h | 137 +++++++
 util_lib/maple_tree.c         | 715 ++++++++++++++++++++++++++++++++++
 2 files changed, 852 insertions(+)
 create mode 100644 util_lib/include/maple_tree.h
 create mode 100644 util_lib/maple_tree.c

diff --git a/util_lib/include/maple_tree.h b/util_lib/include/maple_tree.h
new file mode 100644
index 00000000..c17c528c
--- /dev/null
+++ b/util_lib/include/maple_tree.h
@@ -0,0 +1,137 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+#ifndef _MAPLE_TREE_H
+#define _MAPLE_TREE_H
+/*
+ * Maple Tree - An RCU-safe adaptive tree for storing ranges
+ * Copyright (c) 2018-2022 Oracle
+ * Authors:     Liam R. Howlett <Liam.Howlett@Oracle.com>
+ *              Matthew Wilcox <willy@infradead.org>
+ *
+ * eXtensible Arrays
+ * Copyright (c) 2017 Microsoft Corporation
+ * Author: Matthew Wilcox <willy@infradead.org>
+ *
+ * See Documentation/core-api/xarray.rst for how to use the XArray.
+ */
+#include <stdbool.h>
+#include <limits.h>
+#include <sys/types.h>
+
+#include "vmcore_tasks_util.h"
+
+#define MAPLE_TREE_COUNT   (1)
+#define MAPLE_TREE_SEARCH  (2)
+#define MAPLE_TREE_DUMP    (3)
+#define MAPLE_TREE_GATHER  (4)
+#define MAPLE_TREE_DUMP_CB (5)
+
+/*
+ * The following are copied and modified from include/linux/maple_tree.h
+ */
+
+enum maple_type {
+	maple_dense,
+	maple_leaf_64,
+	maple_range_64,
+	maple_arange_64,
+};
+
+#define MAPLE_NODE_MASK		255UL
+
+#define MT_FLAGS_HEIGHT_OFFSET	0x02
+#define MT_FLAGS_HEIGHT_MASK	0x7C
+
+#define MAPLE_NODE_TYPE_MASK	0x0F
+#define MAPLE_NODE_TYPE_SHIFT	0x03
+
+#define MAPLE_RESERVED_RANGE	4096
+
+#define VERBOSE (0x1)
+#define TREE_ROOT_OFFSET_ENTERED  (VERBOSE << 1)
+#define TREE_NODE_OFFSET_ENTERED  (VERBOSE << 2)
+#define TREE_NODE_POINTER         (VERBOSE << 3)
+#define TREE_POSITION_DISPLAY     (VERBOSE << 4)
+#define TREE_STRUCT_RADIX_10      (VERBOSE << 5)
+#define TREE_STRUCT_RADIX_16      (VERBOSE << 6)
+#define TREE_PARSE_MEMBER         (VERBOSE << 7)
+#define TREE_READ_MEMBER          (VERBOSE << 8)
+#define TREE_LINEAR_ORDER         (VERBOSE << 9)
+#define TREE_STRUCT_VERBOSE       (VERBOSE << 10)
+
+/*Copied from linux/maple_tree.h*/
+/* 64bit sizes */
+#define MAPLE_NODE_SLOTS	31	/* 256 bytes including ->parent */
+#define MAPLE_RANGE64_SLOTS	16	/* 256 bytes */
+#define MAPLE_ARANGE64_SLOTS	10	/* 240 bytes */
+#define MAPLE_ALLOC_SLOTS	(MAPLE_NODE_SLOTS - 1)
+
+/*
+ * The following are copied and modified from include/linux/xarray.h
+ */
+
+#define XA_ZERO_ENTRY		xa_mk_internal(257)
+
+static inline ulong xa_mk_internal(ulong v)
+{
+	return (v << 2) | 2;
+}
+
+static inline bool xa_is_internal(ulong entry)
+{
+	return (entry & 3) == 2;
+}
+
+static inline bool xa_is_node(ulong entry)
+{
+	return xa_is_internal(entry) && entry > 4096;
+}
+
+static inline bool xa_is_value(ulong entry)
+{
+	return entry & 1;
+}
+
+static inline bool xa_is_zero(ulong entry)
+{
+	return entry == XA_ZERO_ENTRY;
+}
+
+static inline unsigned long xa_to_internal(ulong entry)
+{
+	return entry >> 2;
+}
+
+static inline unsigned long xa_to_value(ulong entry)
+{
+	return entry >> 1;
+}
+
+struct tree_data {
+	ulong flags;
+	ulong start;
+	long node_member_offset;
+	char **structname;
+	int structname_args;
+	int count;
+};
+
+struct list_pair {
+	ulong index;
+	void *value;
+};
+
+struct req_entry {
+	char *arg, *name, **member;
+	int *is_str, *is_ptr;
+	ulong *width, *offset;
+	int count;
+};
+
+extern const unsigned char mt_slots[];
+extern const unsigned char mt_pivots[];
+
+void maple_init(void);
+int do_mptree(struct tree_data *);
+ulong do_maple_tree(ulong, int, struct list_pair *);
+
+#endif /* _MAPLE_TREE_H */
diff --git a/util_lib/maple_tree.c b/util_lib/maple_tree.c
new file mode 100644
index 00000000..909dfdbf
--- /dev/null
+++ b/util_lib/maple_tree.c
@@ -0,0 +1,715 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Maple Tree implementation
+ * Copyright (c) 2018-2022 Oracle Corporation
+ * Authors: Liam R. Howlett <Liam.Howlett@oracle.com>
+ * 	    Matthew Wilcox <willy@infradead.org>
+ *
+ * The following are copied and modified from lib/maple_tree.c
+ */
+#include <stdlib.h>
+#include <string.h>
+#include <stdio.h>
+
+#include "maple_tree.h"
+#include "memory.h"
+#include "vmcore_info.h"
+
+const unsigned char mt_slots[] = {
+	[maple_dense]		= MAPLE_NODE_SLOTS,
+	[maple_leaf_64]		= MAPLE_RANGE64_SLOTS,
+	[maple_range_64]	= MAPLE_RANGE64_SLOTS,
+	[maple_arange_64]	= MAPLE_ARANGE64_SLOTS,
+};
+
+const unsigned char mt_pivots[] = {
+	[maple_dense]		= 0,
+	[maple_leaf_64]		= MAPLE_RANGE64_SLOTS - 1,
+	[maple_range_64]	= MAPLE_RANGE64_SLOTS - 1,
+	[maple_arange_64]	= MAPLE_ARANGE64_SLOTS - 1,
+};
+
+ulong mt_max[4] = {0};
+static FILE* fp;
+static bool maple_initialized = false;
+
+static uint64_t size_maple_tree;
+static uint64_t offset_maple_tree_ma_root;
+static uint64_t offset_maple_tree_ma_flags;
+
+/* maple_node offsets */
+static uint64_t size_maple_node;
+static uint64_t offset_maple_node_slot;
+static uint64_t offset_maple_node_parent;
+static uint64_t offset_maple_node_ma64;
+static uint64_t offset_maple_node_mr64;
+
+/* maple_range_64 size + offsets */
+static uint64_t offset_maple_range_64_pivot;
+static uint64_t offset_maple_range_64_slot;
+
+/* maple_metadata offsets */
+static uint64_t offset_maple_metadata_end;
+static uint64_t offset_maple_metadata_gap;
+
+/* maple_arange_64 size + offsets */
+static uint64_t offset_maple_arange_64_pivot;
+static uint64_t offset_maple_arange_64_slot;
+static uint64_t offset_maple_arange_64_gap;
+static uint64_t offset_maple_arange_64_meta;
+
+
+#define MAPLE_BUFSIZE			512
+#define BUFSIZE (1500)
+
+static inline ulong mte_to_node(ulong maple_enode_entry)
+{
+	return maple_enode_entry & ~MAPLE_NODE_MASK;
+}
+
+static inline enum maple_type mte_node_type(ulong maple_enode_entry)
+{
+	return (maple_enode_entry >> MAPLE_NODE_TYPE_SHIFT) &
+		MAPLE_NODE_TYPE_MASK;
+}
+
+static inline ulong mt_slot(void **slots, unsigned char offset)
+{
+	return (ulong)slots[offset];
+}
+
+static inline bool ma_is_leaf(const enum maple_type type)
+{
+	return type < maple_range_64;
+}
+
+/*************** For cmd_tree ********************/
+
+struct do_maple_tree_info {
+	ulong maxcount;
+	ulong count;
+	void *data;
+};
+
+struct maple_tree_ops {
+	void (*entry)(ulong node, ulong slot, const char *path,
+		      ulong index, void *private);
+	void *private;
+	bool is_td;
+};
+
+static const char spaces[] = "                                ";
+
+static void do_mt_range64(ulong, ulong, ulong, uint, char *, ulong *,
+			  struct maple_tree_ops *);
+static void do_mt_arange64(ulong, ulong, ulong, uint, char *, ulong *,
+			   struct maple_tree_ops *);
+static void do_mt_entry(ulong, ulong, ulong, uint, uint, char *, ulong *,
+			struct maple_tree_ops *);
+static void do_mt_node(ulong, ulong, ulong, uint, char *, ulong *,
+		       struct maple_tree_ops *);
+
+static int count_chars(const char *s, char c) {
+	int count = 0;
+	while (*s) if (*s++ == c) count++;
+	return count;
+}
+
+static void dump_struct(const char *name, ulong addr, int radix) {
+	printf("dump_struct not implemented\n");
+}
+
+struct req_entry *fill_member_offsets(char *name){
+	printf("fill_member_offsets - Not inmplemented\n");
+	return NULL;
+}
+
+void dump_struct_members_fast(struct req_entry *e, int radix , ulong addr){
+	printf("dump_struct_members_fast - Not inmplemented");
+}
+
+void dump_struct_members_for_tree(struct tree_data *td, int index, ulong addr){
+	printf("dump_struct_members_for_tree - Not inmplemented");
+}
+
+static void mt_dump_range(ulong min, ulong max, uint depth)
+{
+	if (min == max)
+		fprintf(fp, "%.*s%lu: ", depth * 2, spaces, min);
+	else
+		fprintf(fp, "%.*s%lu-%lu: ", depth * 2, spaces, min, max);
+}
+
+static inline bool mt_is_reserved(ulong entry)
+{
+       return (entry < MAPLE_RESERVED_RANGE) && xa_is_internal(entry);
+}
+
+static inline bool mte_is_leaf(ulong maple_enode_entry)
+{
+       return ma_is_leaf(mte_node_type(maple_enode_entry));
+}
+
+static uint mt_height(char *mt_buf)
+{
+	return (UINT(mt_buf + offset_maple_tree_ma_flags) &
+		MT_FLAGS_HEIGHT_MASK)
+	       >> MT_FLAGS_HEIGHT_OFFSET;
+}
+
+static void dump_mt_range64(char *mr64_buf)
+{
+	int i;
+
+	fprintf(fp, " contents: ");
+	for (i = 0; i < mt_slots[maple_range_64] - 1; i++)
+		fprintf(fp, "%p %lu ",
+			VOID_PTR(mr64_buf + offset_maple_range_64_slot
+				 + sizeof(void *) * i),
+			ULONG(mr64_buf + offset_maple_range_64_pivot
+			      + sizeof(ulong) * i));
+	fprintf(fp, "%p\n", VOID_PTR(mr64_buf + offset_maple_range_64_slot
+				     + sizeof(void *) * i));
+}
+
+static void dump_mt_arange64(char *ma64_buf)
+{
+	int i;
+
+	fprintf(fp, " contents: ");
+	for (i = 0; i < mt_slots[maple_arange_64]; i++)
+		fprintf(fp, "%lu ", ULONG(ma64_buf + offset_maple_arange_64_gap
+					  + sizeof(ulong) * i));
+
+	fprintf(fp, "| %02X %02X| ",
+		UCHAR(ma64_buf + offset_maple_arange_64_meta +
+		      offset_maple_metadata_end),
+		UCHAR(ma64_buf + offset_maple_arange_64_meta +
+		      offset_maple_metadata_gap));
+
+	for (i = 0; i < mt_slots[maple_arange_64] - 1; i++)
+		fprintf(fp, "%p %lu ",
+			VOID_PTR(ma64_buf + offset_maple_arange_64_slot +
+				 sizeof(void *) * i),
+			ULONG(ma64_buf + offset_maple_arange_64_pivot +
+			      sizeof(ulong) * i));
+	fprintf(fp, "%p\n", VOID_PTR(ma64_buf + offset_maple_arange_64_slot +
+				     sizeof(void *) * i));
+}
+
+static void dump_mt_entry(ulong entry, ulong min, ulong max, uint depth)
+{
+	mt_dump_range(min, max, depth);
+
+	if (xa_is_value(entry))
+		fprintf(fp, "value %ld (0x%lx) [0x%lx]\n", xa_to_value(entry),
+			xa_to_value(entry), entry);
+	else if (xa_is_zero(entry))
+		fprintf(fp, "zero (%ld)\n", xa_to_internal(entry));
+	else if (mt_is_reserved(entry))
+		fprintf(fp, "UNKNOWN ENTRY (0x%lx)\n", entry);
+	else
+		fprintf(fp, "0x%lx\n", entry);
+}
+
+static void dump_mt_node(ulong maple_node, char *node_data, uint type,
+			 ulong min, ulong max, uint depth)
+{
+	mt_dump_range(min, max, depth);
+
+	fprintf(fp, "node 0x%lx depth %d type %d parent %p",
+		maple_node, depth, type,
+		maple_node ? VOID_PTR(node_data + offset_maple_node_parent) :
+			     NULL);
+}
+
+static void do_mt_range64(ulong entry, ulong min, ulong max,
+			  uint depth, char *path, ulong *global_index,
+			  struct maple_tree_ops *ops)
+{
+	ulong maple_node_m_node = mte_to_node(entry);
+	char node_buf[MAPLE_BUFSIZE];
+	bool leaf = mte_is_leaf(entry);
+	ulong first = min, last;
+	int i;
+	int len = strlen(path);
+	struct tree_data *td = ops->is_td ? (struct tree_data *)ops->private : NULL;
+	char *mr64_buf;
+
+	if (size_maple_node > MAPLE_BUFSIZE) {
+		fprintf(fp, "MAPLE_BUFSIZE should be larger than maple_node struct");
+		return;
+	}
+
+	if (readmem(maple_node_m_node, node_buf, size_maple_node, "mt_dump_range64 read maple_node", KVADDR) < 0) {
+		fprintf(stderr, "do_mt_range64: failed to read maple_node at 0x%lx\n", maple_node_m_node);
+		return;
+	}
+
+	mr64_buf = node_buf + offset_maple_node_mr64;
+
+	if (td && td->flags & TREE_STRUCT_VERBOSE) {
+		dump_mt_range64(mr64_buf);
+	}
+
+	for (i = 0; i < mt_slots[maple_range_64]; i++) {
+		last = max;
+
+		if (i < (mt_slots[maple_range_64] - 1))
+			last = ULONG(mr64_buf + offset_maple_range_64_pivot +
+				     sizeof(ulong) * i);
+
+		else if (!VOID_PTR(mr64_buf + offset_maple_range_64_slot +
+			  sizeof(void *) * i) &&
+			 max != mt_max[mte_node_type(entry)])
+			break;
+		if (last == 0 && i > 0)
+			break;
+		if (leaf)
+			do_mt_entry(mt_slot((void **)(mr64_buf +
+						      offset_maple_range_64_slot), i),
+				    first, last, depth + 1, i, path, global_index, ops);
+		else if (VOID_PTR(mr64_buf + offset_maple_range_64_slot +
+				  sizeof(void *) * i)) {
+			sprintf(path + len, "/%d", i);
+			do_mt_node(mt_slot((void **)(mr64_buf +
+						     offset_maple_range_64_slot), i),
+				   first, last, depth + 1, path, global_index, ops);
+		}
+
+		if (last == max)
+			break;
+		if (last > max) {
+			fprintf(fp, "node %p last (%lu) > max (%lu) at pivot %d!\n",
+				mr64_buf, last, max, i);
+			break;
+		}
+		first = last + 1;
+	}
+}
+
+static void do_mt_arange64(ulong entry, ulong min, ulong max,
+			   uint depth, char *path, ulong *global_index,
+			   struct maple_tree_ops *ops)
+{
+	ulong maple_node_m_node = mte_to_node(entry);
+	char node_buf[MAPLE_BUFSIZE];
+	bool leaf = mte_is_leaf(entry);
+	ulong first = min, last;
+	int i;
+	int len = strlen(path);
+	struct tree_data *td = ops->is_td ? (struct tree_data *)ops->private : NULL;
+	char *ma64_buf;
+
+	if (size_maple_node > MAPLE_BUFSIZE) {
+		fprintf(fp, "MAPLE_BUFSIZE should be larger than maple_node struct");
+		return;
+	}
+
+	if (readmem(maple_node_m_node, node_buf, size_maple_node, "mt_dump_arange64 read maple_node", KVADDR) < 0) {
+		fprintf(stderr, "do_mt_arange64: failed to read maple_node at 0x%lx\n", maple_node_m_node);
+		return;
+	}
+
+	ma64_buf = node_buf + offset_maple_node_ma64;
+
+	if (td && td->flags & TREE_STRUCT_VERBOSE) {
+		dump_mt_arange64(ma64_buf);
+	}
+
+	for (i = 0; i < mt_slots[maple_arange_64]; i++) {
+		last = max;
+
+		if (i < (mt_slots[maple_arange_64] - 1))
+			last = ULONG(ma64_buf + offset_maple_arange_64_pivot +
+				     sizeof(ulong) * i);
+		else if (!VOID_PTR(ma64_buf + offset_maple_arange_64_slot +
+				   sizeof(void *) * i))
+			break;
+		if (last == 0 && i > 0)
+			break;
+
+		if (leaf)
+			do_mt_entry(mt_slot((void **)(ma64_buf +
+						      offset_maple_arange_64_slot), i),
+				    first, last, depth + 1, i, path, global_index, ops);
+		else if (VOID_PTR(ma64_buf + offset_maple_arange_64_slot +
+				  sizeof(void *) * i)) {
+			sprintf(path + len, "/%d", i);
+			do_mt_node(mt_slot((void **)(ma64_buf +
+						     offset_maple_arange_64_slot), i),
+				   first, last, depth + 1, path, global_index, ops);
+		}
+
+		if (last == max)
+			break;
+		if (last > max) {
+			fprintf(fp, "node %p last (%lu) > max (%lu) at pivot %d!\n",
+				ma64_buf, last, max, i);
+			break;
+		}
+		first = last + 1;
+	}
+}
+
+static void do_mt_entry(ulong entry, ulong min, ulong max, uint depth,
+			uint index, char *path, ulong *global_index,
+			struct maple_tree_ops *ops)
+{
+	int print_radix = 0, i;
+	static struct req_entry **e = NULL;
+	struct tree_data *td = ops->is_td ? (struct tree_data *)ops->private : NULL;
+
+	if (ops->entry && entry)
+		ops->entry(entry, entry, path, max, ops->private);
+
+	if (!td)
+		return;
+
+	if (!td->count && td->structname_args) {
+		/*
+		 * Retrieve all members' info only once (count == 0)
+		 * After last iteration all memory will be freed up
+		 */
+		e = (struct req_entry **)malloc(sizeof(*e) * td->structname_args);
+		for (i = 0; i < td->structname_args; i++)
+			e[i] = fill_member_offsets(td->structname[i]);
+	}
+
+	td->count++;
+
+	if (td->flags & TREE_STRUCT_VERBOSE) {
+		dump_mt_entry(entry, min, max, depth);
+	} else if (td->flags & VERBOSE && entry)
+		fprintf(fp, "%lx\n", entry);
+	if (td->flags & TREE_POSITION_DISPLAY && entry)
+		fprintf(fp, "  index: %ld  position: %s/%u\n",
+			++(*global_index), path, index);
+
+	if (td->structname && entry) {
+		if (td->flags & TREE_STRUCT_RADIX_10)
+			print_radix = 10;
+		else if (td->flags & TREE_STRUCT_RADIX_16)
+			print_radix = 16;
+		else
+			print_radix = 0;
+
+		for (i = 0; i < td->structname_args; i++) {
+			switch (count_chars(td->structname[i], '.')) {
+			case 0:
+				dump_struct(td->structname[i], entry, print_radix);
+				break;
+			default:
+				if (td->flags & TREE_PARSE_MEMBER)
+					dump_struct_members_for_tree(td, i, entry);
+				else if (td->flags & TREE_READ_MEMBER)
+					dump_struct_members_fast(e[i], print_radix, entry);
+			}
+		}
+	}
+
+	if (e) {
+		for (i = 0; i < td->structname_args; i++)
+			free(e[i]);
+		free(e);
+		e = NULL;
+	}
+}
+
+static void do_mt_node(ulong entry, ulong min, ulong max,
+		       uint depth, char *path, ulong *global_index,
+		       struct maple_tree_ops *ops)
+{
+	ulong maple_node = mte_to_node(entry);
+	uint type = mte_node_type(entry);
+	uint i;
+	char node_buf[MAPLE_BUFSIZE];
+	struct tree_data *td = ops->is_td ? (struct tree_data *)ops->private : NULL;
+
+	if (size_maple_node > MAPLE_BUFSIZE) {
+		fprintf(fp, "MAPLE_BUFSIZE should be larger than maple_node struct");
+		return;
+	}
+
+	if (readmem(maple_node, node_buf, size_maple_node, "mt_dump_node read maple_node", KVADDR) < 0) {
+		fprintf(stderr, "do_mt_node: failed to read maple_node at 0x%lx\n", maple_node);
+		return;
+	}
+
+	if (td && td->flags & TREE_STRUCT_VERBOSE) {
+		dump_mt_node(maple_node, node_buf, type, min, max, depth);
+	}
+
+	switch (type) {
+	case maple_dense:
+		for (i = 0; i < mt_slots[maple_dense]; i++) {
+			if (min + i > max)
+				fprintf(fp, "OUT OF RANGE: ");
+			do_mt_entry(mt_slot((void **)(node_buf + offset_maple_node_slot), i),
+				    min + i, min + i, depth, i, path, global_index, ops);
+		}
+		break;
+	case maple_leaf_64:
+	case maple_range_64:
+		do_mt_range64(entry, min, max, depth, path, global_index, ops);
+		break;
+	case maple_arange_64:
+		do_mt_arange64(entry, min, max, depth, path, global_index, ops);
+		break;
+	default:
+		fprintf(fp, " UNKNOWN TYPE\n");
+	}
+}
+
+static int do_maple_tree_traverse(ulong ptr, int is_root,
+				  struct maple_tree_ops *ops)
+{
+	char path[BUFSIZE] = {0};
+	char tree_buf[MAPLE_BUFSIZE];
+	ulong entry;
+	struct tree_data *td = ops->is_td ? (struct tree_data *)ops->private : NULL;
+	ulong global_index = 0;
+
+	if (size_maple_tree > MAPLE_BUFSIZE) {
+		fprintf(fp, "MAPLE_BUFSIZE should be larger than maple_tree struct");
+		return -1;
+	}
+
+	if (!is_root) {
+		strcpy(path, "direct");
+		do_mt_node(ptr, 0, mt_max[mte_node_type(ptr)],
+			   0, path, &global_index, ops);
+	} else {
+		if (readmem(ptr, tree_buf, size_maple_tree, "mt_dump read maple_tree", KVADDR) < 0) {
+			fprintf(stderr, "do_maple_tree_traverse: failed to read maple_tree at 0x%lx\n", ptr);
+			return -1;
+		}
+
+		entry = ULONG(tree_buf + offset_maple_tree_ma_root);
+
+		if (td && td->flags & TREE_STRUCT_VERBOSE) {
+			fprintf(fp, "maple_tree(%lx) flags %X, height %u root 0x%lx\n\n",
+				ptr, UINT(tree_buf + offset_maple_tree_ma_flags),
+				mt_height(tree_buf), entry);
+		}
+
+		if (!xa_is_node(entry))
+			do_mt_entry(entry, 0, 0, 0, 0, path, &global_index, ops);
+		else if (entry) {
+			strcpy(path, "root");
+			do_mt_node(entry, 0, mt_max[mte_node_type(entry)], 0,
+				   path, &global_index, ops);
+		}
+	}
+	return 0;
+}
+
+int do_mptree(struct tree_data *td)
+{
+	maple_init();
+
+	if (!fp) {
+		fprintf(stderr, "maple_tree: not initialized, call maple_init() first\n");
+		return -1;
+	}
+
+	struct maple_tree_ops ops = {
+		.entry		= NULL,
+		.private	= td,
+		.is_td		= true,
+	};
+
+	int is_root = !(td->flags & TREE_NODE_POINTER);
+
+	do_maple_tree_traverse(td->start, is_root, &ops);
+
+	return 0;
+}
+
+/************* For do_maple_tree *****************/
+static void do_maple_tree_count(ulong node, ulong slot, const char *path,
+				ulong index, void *private)
+{
+	struct do_maple_tree_info *info = private;
+	info->count++;
+}
+
+static void do_maple_tree_search(ulong node, ulong slot, const char *path,
+				 ulong index, void *private)
+{
+	struct do_maple_tree_info *info = private;
+	struct list_pair *lp = info->data;
+
+	if (lp->index == index) {
+		lp->value = (void *)slot;
+		info->count = 1;
+	}
+}
+
+static void do_maple_tree_dump(ulong node, ulong slot, const char *path,
+			       ulong index, void *private)
+{
+	struct do_maple_tree_info *info = private;
+	fprintf(fp, "[%lu] %lx\n", index, slot);
+	info->count++;
+}
+
+static void do_maple_tree_gather(ulong node, ulong slot, const char *path,
+				 ulong index, void *private)
+{
+	struct do_maple_tree_info *info = private;
+	struct list_pair *lp = info->data;
+
+	if (info->maxcount) {
+		lp[info->count].index = index;
+		lp[info->count].value = (void *)slot;
+
+		info->count++;
+		info->maxcount--;
+	}
+}
+
+static void do_maple_tree_dump_cb(ulong node, ulong slot, const char *path,
+				  ulong index, void *private)
+{
+	struct do_maple_tree_info *info = private;
+	struct list_pair *lp = info->data;
+	int (*cb)(ulong) = lp->value;
+
+	/* Caller defined operation */
+	if (!cb(slot)) {
+		fprintf(fp, "do_maple_tree: callback "
+			"operation failed: entry: %ld  item: %lx\n",
+			info->count, slot);
+		return;
+	}
+	info->count++;
+}
+
+/*
+ *  do_maple_tree argument usage:
+ *
+ *    root: Address of a maple_tree_root structure
+ *
+ *    flag: MAPLE_TREE_COUNT - Return the number of entries in the tree.
+ *          MAPLE_TREE_SEARCH - Search for an entry at lp->index; if found,
+ *            store the entry in lp->value and return a count of 1; otherwise
+ *            return a count of 0.
+ *          MAPLE_TREE_DUMP - Dump all existing index/value pairs.
+ *          MAPLE_TREE_GATHER - Store all existing index/value pairs in the
+ *            passed-in array of list_pair structs starting at lp,
+ *            returning the count of entries stored; the caller can/should
+ *            limit the number of returned entries by putting the array size
+ *            (max count) in the lp->index field of the first structure
+ *            in the passed-in array.
+ *          MAPLE_TREE_DUMP_CB - Similar with MAPLE_TREE_DUMP, but for each
+ *            maple tree entry, a user defined callback at lp->value will
+ *            be invoked.
+ *
+ *     lp: Unused by MAPLE_TREE_COUNT and MAPLE_TREE_DUMP.
+ *          A pointer to a list_pair structure for MAPLE_TREE_SEARCH.
+ *          A pointer to an array of list_pair structures for
+ *          MAPLE_TREE_GATHER; the dimension (max count) of the array may
+ *          be stored in the index field of the first structure to avoid
+ *          any chance of an overrun.
+ *          For MAPLE_TREE_DUMP_CB, the lp->value must be initialized as a
+ *          callback function.  The callback prototype must be: int (*)(ulong);
+ */
+ulong
+do_maple_tree(ulong root, int flag, struct list_pair *lp)
+{
+	maple_init();
+
+	if (!fp) {
+		fprintf(stderr, "maple_tree: not initialized, call maple_init() first\n");
+		return 0;
+	}
+
+	struct do_maple_tree_info info = {
+		.count		= 0,
+		.data		= lp,
+	};
+	struct maple_tree_ops ops = {
+		.private	= &info,
+		.is_td		= false,
+	};
+
+	switch (flag)
+	{
+	case MAPLE_TREE_COUNT:
+		ops.entry = do_maple_tree_count;
+		break;
+
+	case MAPLE_TREE_SEARCH:
+		ops.entry = do_maple_tree_search;
+		break;
+
+	case MAPLE_TREE_DUMP:
+		ops.entry = do_maple_tree_dump;
+		break;
+
+	case MAPLE_TREE_GATHER:
+		if (!(info.maxcount = lp->index))
+			info.maxcount = (ulong)(-1);   /* caller beware */
+
+		ops.entry = do_maple_tree_gather;
+		break;
+
+	case MAPLE_TREE_DUMP_CB:
+		if (lp->value == NULL) {
+			fprintf(fp, "do_maple_tree: need set callback function");
+			return 0;
+		}
+		ops.entry = do_maple_tree_dump_cb;
+		break;
+
+	default:
+		fprintf(fp, "do_maple_tree: invalid flag: %d\n", flag);
+		return 0;
+	}
+
+	do_maple_tree_traverse(root, true, &ops);
+	return info.count;
+}
+
+/***********************************************/
+void maple_init(void)
+{
+	if (maple_initialized)
+		return;
+	maple_initialized = true;
+
+	if (SIZE_EXISTS("maple_tree")) {
+		fp = stdout;
+
+		size_maple_tree = SIZE("maple_tree");
+		size_maple_node = SIZE("maple_node");
+
+		offset_maple_tree_ma_root = OFFSET("maple_tree.ma_root");
+		offset_maple_tree_ma_flags = OFFSET("maple_tree.ma_flags");
+
+		offset_maple_node_parent = OFFSET("maple_node.parent");
+		offset_maple_node_ma64 = OFFSET("maple_node.ma64");
+		offset_maple_node_mr64 = OFFSET("maple_node.mr64");
+		offset_maple_node_slot = OFFSET("maple_node.slot");
+
+		offset_maple_arange_64_pivot = OFFSET("maple_arange_64.pivot");
+		offset_maple_arange_64_slot = OFFSET("maple_arange_64.slot");
+		offset_maple_arange_64_gap = OFFSET("maple_arange_64.gap");
+		offset_maple_arange_64_meta = OFFSET("maple_arange_64.meta");
+
+		offset_maple_range_64_pivot = OFFSET("maple_range_64.pivot");
+		offset_maple_range_64_slot = OFFSET("maple_range_64.slot");
+
+		offset_maple_metadata_end = OFFSET("maple_metadata.end");
+		offset_maple_metadata_gap = OFFSET("maple_metadata.gap");
+
+		mt_max[maple_dense]           = mt_slots[maple_dense];
+		mt_max[maple_leaf_64]         = ULONG_MAX;
+		mt_max[maple_range_64]        = ULONG_MAX;
+		mt_max[maple_arange_64]       = ULONG_MAX;
+
+	} else {
+		pr_info("maple_tree not found in vmcoreinfo.\n");
+	}
+}
-- 
2.43.0


