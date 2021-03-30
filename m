Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from userp2120.oracle.com ([156.151.31.85])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lRLul-004w4H-Hz
 for kexec@lists.infradead.org; Tue, 30 Mar 2021 21:28:48 +0000
From: Anthony Yznaga <anthony.yznaga@oracle.com>
Subject: [RFC v2 41/43] XArray: add xas_export_node() and xas_import_node()
Date: Tue, 30 Mar 2021 14:36:16 -0700
Message-Id: <1617140178-8773-42-git-send-email-anthony.yznaga@oracle.com>
In-Reply-To: <1617140178-8773-1-git-send-email-anthony.yznaga@oracle.com>
References: <1617140178-8773-1-git-send-email-anthony.yznaga@oracle.com>
MIME-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: willy@infradead.org, corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com, dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org, rppt@kernel.org, akpm@linux-foundation.org, hughd@google.com, ebiederm@xmission.com, keescook@chromium.org, ardb@kernel.org, nivedita@alum.mit.edu, jroedel@suse.de, masahiroy@kernel.org, nathan@kernel.org, terrelln@fb.com, vincenzo.frascino@arm.com, martin.b.radev@gmail.com, andreyknvl@google.com, daniel.kiper@oracle.com, rafael.j.wysocki@intel.com, dan.j.williams@intel.com, Jonathan.Cameron@huawei.com, bhe@redhat.com, rminnich@gmail.com, ashish.kalra@amd.com, guro@fb.com, hannes@cmpxchg.org, mhocko@kernel.org, iamjoonsoo.kim@lge.com, vbabka@suse.cz, alex.shi@linux.alibaba.com, david@redhat.com, richard.weiyang@gmail.com, vdavydov.dev@gmail.com, graf@amazon.com, jason.zeng@intel.com, lei.l.li@intel.com, daniel.m.jordan@oracle.com, steven.sistare@oracle.com, linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, kexec@lists.infradead.org

Contention on the xarray lock when multiple threads are adding to the
same xarray can be mitigated by providing a way to add entries in
bulk.

Allow a caller to allocate and populate an xarray node outside of
the target xarray and then only take the xarray lock long enough to
import the node into it.

Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 Documentation/core-api/xarray.rst |   8 +++
 include/linux/xarray.h            |   2 +
 lib/test_xarray.c                 |  45 +++++++++++++++++
 lib/xarray.c                      | 100 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 155 insertions(+)

diff --git a/Documentation/core-api/xarray.rst b/Documentation/core-api/xarray.rst
index a137a0e6d068..12ec59038fc8 100644
--- a/Documentation/core-api/xarray.rst
+++ b/Documentation/core-api/xarray.rst
@@ -444,6 +444,14 @@ called each time the XArray updates a node.  This is used by the page
 cache workingset code to maintain its list of nodes which contain only
 shadow entries.
 
+xas_export_node() is used to remove and return a node from an XArray
+while xas_import_node() is used to add a node to an XArray.  Together
+these can be used, for example, to reduce lock contention when multiple
+threads are updating an XArray by allowing a caller to allocate and
+populate a node outside of the target XArray in a local XArray, export
+the node, and then take the target XArray lock just long enough to import
+the node.
+
 Multi-Index Entries
 -------------------
 
diff --git a/include/linux/xarray.h b/include/linux/xarray.h
index 92c0160b3352..1eda38cbe020 100644
--- a/include/linux/xarray.h
+++ b/include/linux/xarray.h
@@ -1506,6 +1506,8 @@ static inline bool xas_retry(struct xa_state *xas, const void *entry)
 void xas_pause(struct xa_state *);
 
 void xas_create_range(struct xa_state *);
+struct xa_node *xas_export_node(struct xa_state *xas);
+void xas_import_node(struct xa_state *xas, struct xa_node *node);
 
 #ifdef CONFIG_XARRAY_MULTI
 int xa_get_order(struct xarray *, unsigned long index);
diff --git a/lib/test_xarray.c b/lib/test_xarray.c
index 8294f43f4981..9cca0921cf9b 100644
--- a/lib/test_xarray.c
+++ b/lib/test_xarray.c
@@ -1765,6 +1765,50 @@ static noinline void check_destroy(struct xarray *xa)
 #endif
 }
 
+static noinline void check_export_import_1(struct xarray *xa,
+		unsigned long index, unsigned int order)
+{
+	int xa_shift = order + XA_CHUNK_SHIFT - (order % XA_CHUNK_SHIFT);
+	XA_STATE(xas, xa, index);
+	struct xa_node *node;
+	unsigned long i;
+
+	xa_store_many_order(xa, index, xa_shift);
+
+	xas_lock(&xas);
+	xas_set_order(&xas, index, xa_shift);
+	node = xas_export_node(&xas);
+	xas_unlock(&xas);
+
+	XA_BUG_ON(xa, !xa_empty(xa));
+
+	do {
+		xas_lock(&xas);
+		xas_set_order(&xas, index, xa_shift);
+		xas_import_node(&xas, node);
+		xas_unlock(&xas);
+	} while (xas_nomem(&xas, GFP_KERNEL));
+
+	for (i = index; i < index + (1UL << xa_shift); i++)
+		xa_erase_index(xa, i);
+
+	XA_BUG_ON(xa, !xa_empty(xa));
+}
+
+static noinline void check_export_import(struct xarray *xa)
+{
+	unsigned int order;
+	unsigned int max_order = IS_ENABLED(CONFIG_XARRAY_MULTI) ? 12 : 1;
+
+	for (order = 0; order < max_order; order += XA_CHUNK_SHIFT) {
+		int xa_shift = order + XA_CHUNK_SHIFT;
+		unsigned long j;
+
+		for (j = 0; j < XA_CHUNK_SIZE; j++)
+			check_export_import_1(xa, j << xa_shift, order);
+	}
+}
+
 static DEFINE_XARRAY(array);
 
 static int xarray_checks(void)
@@ -1797,6 +1841,7 @@ static int xarray_checks(void)
 	check_workingset(&array, 0);
 	check_workingset(&array, 64);
 	check_workingset(&array, 4096);
+	check_export_import(&array);
 
 	printk("XArray: %u of %u tests passed\n", tests_passed, tests_run);
 	return (tests_run == tests_passed) ? 0 : -EINVAL;
diff --git a/lib/xarray.c b/lib/xarray.c
index 5fa51614802a..58d58333f0d0 100644
--- a/lib/xarray.c
+++ b/lib/xarray.c
@@ -510,6 +510,30 @@ static void xas_delete_node(struct xa_state *xas)
 		xas_shrink(xas);
 }
 
+static void xas_unlink_node(struct xa_state *xas)
+{
+	struct xa_node *node = xas->xa_node;
+	struct xa_node *parent;
+
+	parent = xa_parent_locked(xas->xa, node);
+	xas->xa_node = parent;
+	xas->xa_offset = node->offset;
+
+	if (!parent) {
+		xas->xa->xa_head = NULL;
+		xas->xa_node = XAS_BOUNDS;
+		return;
+	}
+
+	parent->slots[xas->xa_offset] = NULL;
+	parent->count--;
+	XA_NODE_BUG_ON(parent, parent->count > XA_CHUNK_SIZE);
+
+	xas_update(xas, parent);
+
+	xas_delete_node(xas);
+}
+
 /**
  * xas_free_nodes() - Free this node and all nodes that it references
  * @xas: Array operation state.
@@ -1690,6 +1714,82 @@ static void xas_set_range(struct xa_state *xas, unsigned long first,
 }
 
 /**
+ * xas_export_node() - remove and return a node from an XArray
+ * @xas: XArray operation state
+ *
+ * The range covered by @xas must be aligned to and cover a single node
+ * at any level of the tree.
+ *
+ * Return: On success, returns the removed node.  If the range is invalid,
+ * returns %NULL and sets -EINVAL in @xas.  Otherwise returns %NULL if the
+ * node does not exist.
+ */
+struct xa_node *xas_export_node(struct xa_state *xas)
+{
+	struct xa_node *node;
+
+	if (!xas->xa_shift || xas->xa_sibs) {
+		xas_set_err(xas, -EINVAL);
+		return NULL;
+	}
+
+	xas->xa_shift -= XA_CHUNK_SHIFT;
+
+	if (!xas_find(xas, xas->xa_index))
+		return NULL;
+	node = xas->xa_node;
+	xas_unlink_node(xas);
+	node->parent = NULL;
+
+	return node;
+}
+
+/**
+ * xas_import_node() - add a node to an XArray
+ * @xas: XArray operation state
+ * @node: The node to add
+ *
+ * The range covered by @xas must be aligned to and cover a single node
+ * at any level of the tree.  No nodes should already exist within the
+ * range.
+ * Sets an error in @xas if the range is invalid or xas_create() fails
+ */
+void xas_import_node(struct xa_state *xas, struct xa_node *node)
+{
+	struct xa_node *parent = NULL;
+	void __rcu **slot = &xas->xa->xa_head;
+	int count = 0;
+
+	if (!xas->xa_shift || xas->xa_sibs) {
+		xas_set_err(xas, -EINVAL);
+		return;
+	}
+
+	if (xas->xa_index || xa_head_locked(xas->xa)) {
+		xas_set_order(xas, xas->xa_index, node->shift + XA_CHUNK_SHIFT);
+		xas_create(xas, true);
+
+		if (xas_invalid(xas))
+			return;
+
+		parent = xas->xa_node;
+	}
+
+	if (parent) {
+		slot = &parent->slots[xas->xa_offset];
+		node->offset = xas->xa_offset;
+		count++;
+	}
+
+	RCU_INIT_POINTER(node->parent, parent);
+	node->array = xas->xa;
+
+	rcu_assign_pointer(*slot, xa_mk_node(node));
+
+	update_node(xas, parent, count, 0);
+}
+
+/**
  * xa_store_range() - Store this entry at a range of indices in the XArray.
  * @xa: XArray.
  * @first: First index to affect.
-- 
1.8.3.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
