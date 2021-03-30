Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from aserp2130.oracle.com ([141.146.126.79])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lRLsq-004vUO-0y
 for kexec@lists.infradead.org; Tue, 30 Mar 2021 21:26:48 +0000
From: Anthony Yznaga <anthony.yznaga@oracle.com>
Subject: [RFC v2 04/43] mm: PKRAM: implement page stream operations
Date: Tue, 30 Mar 2021 14:35:39 -0700
Message-Id: <1617140178-8773-5-git-send-email-anthony.yznaga@oracle.com>
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

Using the pkram_save_file_page() function, one can populate PKRAM objects
with in-memory pages which can later be loaded using the pkram_load_file_page()
function. Saving a page to PKRAM is accomplished by recording its pfn and
mapping index and incrementing its refcount so that it will not be freed
after the last user puts it.

Originally-by: Vladimir Davydov <vdavydov.dev@gmail.com>
Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 include/linux/pkram.h |  42 +++++++-
 mm/pkram.c            | 282 +++++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 317 insertions(+), 7 deletions(-)

diff --git a/include/linux/pkram.h b/include/linux/pkram.h
index a4d55af392c0..9d8a6fd96dd9 100644
--- a/include/linux/pkram.h
+++ b/include/linux/pkram.h
@@ -8,22 +8,47 @@
 
 struct pkram_node;
 struct pkram_obj;
+struct pkram_link;
 
 /**
  * enum pkram_data_flags - definition of data types contained in a pkram obj
  * @PKRAM_DATA_none: No data types configured
+ * @PKRAM_DATA_pages: obj contains file page data
  */
 enum pkram_data_flags {
-	PKRAM_DATA_none		= 0x0,  /* No data types configured */
+	PKRAM_DATA_none		= 0x0,	/* No data types configured */
+	PKRAM_DATA_pages	= 0x1,	/* Contains file page data */
+};
+
+struct pkram_data_stream {
+	/* List of link pages to add/remove from */
+	__u64 *head_link_pfnp;
+	__u64 *tail_link_pfnp;
+
+	struct pkram_link *link;	/* current link */
+	unsigned int entry_idx;		/* next entry in link */
 };
 
 struct pkram_stream {
 	gfp_t gfp_mask;
 	struct pkram_node *node;
 	struct pkram_obj *obj;
+
+	__u64 *pages_head_link_pfnp;
+	__u64 *pages_tail_link_pfnp;
+};
+
+struct pkram_pages_access {
+	unsigned long next_index;
 };
 
-struct pkram_access;
+struct pkram_access {
+	enum pkram_data_flags dtype;
+	struct pkram_stream *ps;
+	struct pkram_data_stream pds;
+
+	struct pkram_pages_access pages;
+};
 
 #define PKRAM_NAME_MAX		256	/* including nul */
 
@@ -41,8 +66,19 @@ int pkram_prepare_save(struct pkram_stream *ps, const char *name,
 void pkram_finish_load(struct pkram_stream *ps);
 void pkram_finish_load_obj(struct pkram_stream *ps);
 
+#define PKRAM_PDS_INIT(name, stream, type) {			\
+	.head_link_pfnp=(stream)->type##_head_link_pfnp,	\
+	.tail_link_pfnp=(stream)->type##_tail_link_pfnp,	\
+	}
+
+#define PKRAM_ACCESS_INIT(name, stream, type) {			\
+	.dtype = PKRAM_DATA_##type,				\
+	.ps = (stream),						\
+	.pds = PKRAM_PDS_INIT(name, stream, type),		\
+	}
+
 #define PKRAM_ACCESS(name, stream, type)			\
-	struct pkram_access name
+	struct pkram_access name = PKRAM_ACCESS_INIT(name, stream, type)
 
 void pkram_finish_access(struct pkram_access *pa, bool status_ok);
 
diff --git a/mm/pkram.c b/mm/pkram.c
index 7c977c5982f8..9c42db66d022 100644
--- a/mm/pkram.c
+++ b/mm/pkram.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/err.h>
 #include <linux/gfp.h>
+#include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/list.h>
 #include <linux/mm.h>
@@ -10,8 +11,39 @@
 #include <linux/string.h>
 #include <linux/types.h>
 
+#include "internal.h"
+
+
+/*
+ * Represents a reference to a data page saved to PKRAM.
+ */
+typedef __u64 pkram_entry_t;
+
+#define PKRAM_ENTRY_FLAGS_SHIFT	0x5
+#define PKRAM_ENTRY_FLAGS_MASK	0x7f
+
+/*
+ * Keeps references to data pages saved to PKRAM.
+ * The structure occupies a memory page.
+ */
+struct pkram_link {
+	__u64	link_pfn;	/* points to the next link of the object */
+	__u64	index;		/* mapping index of first pkram_entry_t */
+
+	/*
+	 * the array occupies the rest of the link page; if the link is not
+	 * full, the rest of the array must be filled with zeros
+	 */
+	pkram_entry_t entry[0];
+};
+
+#define PKRAM_LINK_ENTRIES_MAX \
+	((PAGE_SIZE-sizeof(struct pkram_link))/sizeof(pkram_entry_t))
+
 struct pkram_obj {
-	__u64   obj_pfn;	/* points to the next object in the list */
+	__u64	pages_head_link_pfn;	/* the first pages link of the object */
+	__u64	pages_tail_link_pfn;	/* the last pages link of the object */
+	__u64	obj_pfn;	/* points to the next object in the list */
 };
 
 /*
@@ -19,6 +51,10 @@ struct pkram_obj {
  * independently of each other. The nodes are identified by unique name
  * strings.
  *
+ * References to data pages saved to a preserved memory node are kept in a
+ * singly-linked list of PKRAM link structures (see above), the node has a
+ * pointer to the head of.
+ *
  * The structure occupies a memory page.
  */
 struct pkram_node {
@@ -68,6 +104,41 @@ static struct pkram_node *pkram_find_node(const char *name)
 	return NULL;
 }
 
+static void pkram_truncate_link(struct pkram_link *link)
+{
+	struct page *page;
+	pkram_entry_t p;
+	int i;
+
+	for (i = 0; i < PKRAM_LINK_ENTRIES_MAX; i++) {
+		p = link->entry[i];
+		if (!p)
+			continue;
+		page = pfn_to_page(PHYS_PFN(p));
+		put_page(page);
+	}
+}
+
+static void pkram_truncate_links(unsigned long link_pfn)
+{
+	struct pkram_link *link;
+
+	while (link_pfn) {
+		link = pfn_to_kaddr(link_pfn);
+		pkram_truncate_link(link);
+		link_pfn = link->link_pfn;
+		pkram_free_page(link);
+		cond_resched();
+	}
+}
+
+static void pkram_truncate_obj(struct pkram_obj *obj)
+{
+	pkram_truncate_links(obj->pages_head_link_pfn);
+	obj->pages_head_link_pfn = 0;
+	obj->pages_tail_link_pfn = 0;
+}
+
 static void pkram_truncate_node(struct pkram_node *node)
 {
 	unsigned long obj_pfn;
@@ -76,6 +147,7 @@ static void pkram_truncate_node(struct pkram_node *node)
 	obj_pfn = node->obj_pfn;
 	while (obj_pfn) {
 		obj = pfn_to_kaddr(obj_pfn);
+		pkram_truncate_obj(obj);
 		obj_pfn = obj->obj_pfn;
 		pkram_free_page(obj);
 		cond_resched();
@@ -83,6 +155,83 @@ static void pkram_truncate_node(struct pkram_node *node)
 	node->obj_pfn = 0;
 }
 
+static void pkram_add_link(struct pkram_link *link, struct pkram_data_stream *pds)
+{
+	__u64 link_pfn = page_to_pfn(virt_to_page(link));
+
+	if (!*pds->head_link_pfnp) {
+		*pds->head_link_pfnp = link_pfn;
+		*pds->tail_link_pfnp = link_pfn;
+	} else {
+		struct pkram_link *tail = pfn_to_kaddr(*pds->tail_link_pfnp);
+
+		tail->link_pfn = link_pfn;
+		*pds->tail_link_pfnp = link_pfn;
+	}
+}
+
+static struct pkram_link *pkram_remove_link(struct pkram_data_stream *pds)
+{
+	struct pkram_link *link;
+
+	if (!*pds->head_link_pfnp)
+		return NULL;
+
+	link = pfn_to_kaddr(*pds->head_link_pfnp);
+	*pds->head_link_pfnp = link->link_pfn;
+	if (!*pds->head_link_pfnp)
+		*pds->tail_link_pfnp = 0;
+	else
+		link->link_pfn = 0;
+
+	return link;
+}
+
+static struct pkram_link *pkram_new_link(struct pkram_data_stream *pds, gfp_t gfp_mask)
+{
+	struct pkram_link *link;
+	struct page *link_page;
+
+	link_page = pkram_alloc_page((gfp_mask & GFP_RECLAIM_MASK) |
+				    __GFP_ZERO);
+	if (!link_page)
+		return NULL;
+
+	link = page_address(link_page);
+	pkram_add_link(link, pds);
+	pds->link = link;
+	pds->entry_idx = 0;
+
+	return link;
+}
+
+static void pkram_add_link_entry(struct pkram_data_stream *pds, struct page *page)
+{
+	struct pkram_link *link = pds->link;
+	pkram_entry_t p;
+	short flags = 0;
+
+	p = page_to_phys(page);
+	p |= ((flags & PKRAM_ENTRY_FLAGS_MASK) << PKRAM_ENTRY_FLAGS_SHIFT);
+	link->entry[pds->entry_idx] = p;
+	pds->entry_idx++;
+}
+
+static int pkram_next_link(struct pkram_data_stream *pds, struct pkram_link **linkp)
+{
+	struct pkram_link *link;
+
+	link = pkram_remove_link(pds);
+	if (!link)
+		return -ENODATA;
+
+	pds->link = link;
+	pds->entry_idx = 0;
+	*linkp = link;
+
+	return 0;
+}
+
 static void pkram_stream_init(struct pkram_stream *ps,
 			     struct pkram_node *node, gfp_t gfp_mask)
 {
@@ -159,6 +308,9 @@ int pkram_prepare_save_obj(struct pkram_stream *ps, enum pkram_data_flags flags)
 
 	BUG_ON((node->flags & PKRAM_ACCMODE_MASK) != PKRAM_SAVE);
 
+	if (flags & ~PKRAM_DATA_pages)
+		return -EINVAL;
+
 	page = pkram_alloc_page(ps->gfp_mask | __GFP_ZERO);
 	if (!page)
 		return -ENOMEM;
@@ -168,6 +320,10 @@ int pkram_prepare_save_obj(struct pkram_stream *ps, enum pkram_data_flags flags)
 		obj->obj_pfn = node->obj_pfn;
 	node->obj_pfn = page_to_pfn(page);
 
+	if (flags & PKRAM_DATA_pages) {
+		ps->pages_head_link_pfnp = &obj->pages_head_link_pfn;
+		ps->pages_tail_link_pfnp = &obj->pages_tail_link_pfn;
+	}
 	ps->obj = obj;
 	return 0;
 }
@@ -275,8 +431,17 @@ int pkram_prepare_load_obj(struct pkram_stream *ps)
 		return -ENODATA;
 
 	obj = pfn_to_kaddr(node->obj_pfn);
+	if (!obj->pages_head_link_pfn) {
+		WARN_ON(1);
+		return -EINVAL;
+	}
+
 	node->obj_pfn = obj->obj_pfn;
 
+	if (obj->pages_head_link_pfn) {
+		ps->pages_head_link_pfnp = &obj->pages_head_link_pfn;
+		ps->pages_tail_link_pfnp = &obj->pages_tail_link_pfn;
+	}
 	ps->obj = obj;
 	return 0;
 }
@@ -293,6 +458,7 @@ void pkram_finish_load_obj(struct pkram_stream *ps)
 
 	BUG_ON((node->flags & PKRAM_ACCMODE_MASK) != PKRAM_LOAD);
 
+	pkram_truncate_obj(obj);
 	pkram_free_page(obj);
 }
 
@@ -318,7 +484,41 @@ void pkram_finish_load(struct pkram_stream *ps)
  */
 void pkram_finish_access(struct pkram_access *pa, bool status_ok)
 {
-	BUG();
+	if (status_ok)
+		return;
+
+	if (pa->ps->node->flags == PKRAM_SAVE)
+		return;
+
+	if (pa->pds.link)
+		pkram_truncate_link(pa->pds.link);
+}
+
+/*
+ * Add file page to a PKRAM obj allocating a new PKRAM link if necessary.
+ */
+static int __pkram_save_page(struct pkram_access *pa, struct page *page,
+			     unsigned long index)
+{
+	struct pkram_data_stream *pds = &pa->pds;
+	struct pkram_link *link = pds->link;
+
+	if (!link || pds->entry_idx >= PKRAM_LINK_ENTRIES_MAX ||
+	    index != pa->pages.next_index) {
+		link = pkram_new_link(pds, pa->ps->gfp_mask);
+		if (!link)
+			return -ENOMEM;
+
+		pa->pages.next_index = link->index = index;
+	}
+
+	get_page(page);
+
+	pkram_add_link_entry(pds, page);
+
+	pa->pages.next_index++;
+
+	return 0;
 }
 
 /**
@@ -328,10 +528,80 @@ void pkram_finish_access(struct pkram_access *pa, bool status_ok)
  * with PKRAM_ACCESS().
  *
  * Returns 0 on success, -errno on failure.
+ *
+ * Error values:
+ *	%ENOMEM: insufficient amount of memory available
+ *
+ * Saving a page to preserved memory is simply incrementing its refcount so
+ * that it will not get freed after the last user puts it. That means it is
+ * safe to use the page as usual after it has been saved.
  */
 int pkram_save_file_page(struct pkram_access *pa, struct page *page)
 {
-	return -ENOSYS;
+	struct pkram_node *node = pa->ps->node;
+
+	BUG_ON((node->flags & PKRAM_ACCMODE_MASK) != PKRAM_SAVE);
+
+	BUG_ON(PageCompound(page));
+
+	return __pkram_save_page(pa, page, page->index);
+}
+
+static struct page *__pkram_prep_load_page(pkram_entry_t p)
+{
+	struct page *page;
+	short flags;
+
+	flags = (p >> PKRAM_ENTRY_FLAGS_SHIFT) & PKRAM_ENTRY_FLAGS_MASK;
+	page = pfn_to_page(PHYS_PFN(p));
+
+	return page;
+}
+
+/*
+ * Extract the next page from preserved memory freeing a PKRAM link if it
+ * becomes empty.
+ */
+static struct page *__pkram_load_page(struct pkram_access *pa, unsigned long *index)
+{
+	struct pkram_data_stream *pds = &pa->pds;
+	struct pkram_link *link = pds->link;
+	struct page *page;
+	pkram_entry_t p;
+	int ret;
+
+	if (!link) {
+		ret = pkram_next_link(pds, &link);
+		if (ret)
+			return NULL;	// XXX return error value?
+
+		if (index)
+			pa->pages.next_index = link->index;
+	}
+
+	BUG_ON(pds->entry_idx >= PKRAM_LINK_ENTRIES_MAX);
+
+	p = link->entry[pds->entry_idx];
+	BUG_ON(!p);
+
+	page = __pkram_prep_load_page(p);
+
+	if (index) {
+		*index = pa->pages.next_index;
+		pa->pages.next_index++;
+	}
+
+	/* clear to avoid double free (see pkram_truncate_link()) */
+	link->entry[pds->entry_idx] = 0;
+
+	pds->entry_idx++;
+	if (pds->entry_idx >= PKRAM_LINK_ENTRIES_MAX ||
+	    !link->entry[pds->entry_idx]) {
+		pds->link = NULL;
+		pkram_free_page(link);
+	}
+
+	return page;
 }
 
 /**
@@ -349,7 +619,11 @@ int pkram_save_file_page(struct pkram_access *pa, struct page *page)
  */
 struct page *pkram_load_file_page(struct pkram_access *pa, unsigned long *index)
 {
-	return NULL;
+	struct pkram_node *node = pa->ps->node;
+
+	BUG_ON((node->flags & PKRAM_ACCMODE_MASK) != PKRAM_LOAD);
+
+	return __pkram_load_page(pa, index);
 }
 
 /**
-- 
1.8.3.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
