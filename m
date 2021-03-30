Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from aserp2120.oracle.com ([141.146.126.78])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lRLsq-004vUQ-6X
 for kexec@lists.infradead.org; Tue, 30 Mar 2021 21:26:48 +0000
From: Anthony Yznaga <anthony.yznaga@oracle.com>
Subject: [RFC v2 06/43] mm: PKRAM: implement byte stream operations
Date: Tue, 30 Mar 2021 14:35:41 -0700
Message-Id: <1617140178-8773-7-git-send-email-anthony.yznaga@oracle.com>
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

This patch adds the ability to save an arbitrary byte streams to a
a PKRAM object using pkram_write() to be restored later using pkram_read().

Originally-by: Vladimir Davydov <vdavydov.dev@gmail.com>
Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 include/linux/pkram.h |  11 +++++
 mm/pkram.c            | 123 ++++++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 130 insertions(+), 4 deletions(-)

diff --git a/include/linux/pkram.h b/include/linux/pkram.h
index 9d8a6fd96dd9..4f95d4fb5339 100644
--- a/include/linux/pkram.h
+++ b/include/linux/pkram.h
@@ -14,10 +14,12 @@
  * enum pkram_data_flags - definition of data types contained in a pkram obj
  * @PKRAM_DATA_none: No data types configured
  * @PKRAM_DATA_pages: obj contains file page data
+ * @PKRAM_DATA_bytes: obj contains byte data
  */
 enum pkram_data_flags {
 	PKRAM_DATA_none		= 0x0,	/* No data types configured */
 	PKRAM_DATA_pages	= 0x1,	/* Contains file page data */
+	PKRAM_DATA_bytes	= 0x2,	/* Contains byte data */
 };
 
 struct pkram_data_stream {
@@ -36,18 +38,27 @@ struct pkram_stream {
 
 	__u64 *pages_head_link_pfnp;
 	__u64 *pages_tail_link_pfnp;
+
+	__u64 *bytes_head_link_pfnp;
+	__u64 *bytes_tail_link_pfnp;
 };
 
 struct pkram_pages_access {
 	unsigned long next_index;
 };
 
+struct pkram_bytes_access {
+	struct page *data_page;		/* current page */
+	unsigned int data_offset;	/* offset into current page */
+};
+
 struct pkram_access {
 	enum pkram_data_flags dtype;
 	struct pkram_stream *ps;
 	struct pkram_data_stream pds;
 
 	struct pkram_pages_access pages;
+	struct pkram_bytes_access bytes;
 };
 
 #define PKRAM_NAME_MAX		256	/* including nul */
diff --git a/mm/pkram.c b/mm/pkram.c
index da44a6060c5f..d81af26c9a66 100644
--- a/mm/pkram.c
+++ b/mm/pkram.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/err.h>
 #include <linux/gfp.h>
+#include <linux/highmem.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/list.h>
@@ -46,6 +47,9 @@ struct pkram_link {
 struct pkram_obj {
 	__u64	pages_head_link_pfn;	/* the first pages link of the object */
 	__u64	pages_tail_link_pfn;	/* the last pages link of the object */
+	__u64	bytes_head_link_pfn;	/* the first bytes link of the object */
+	__u64	bytes_tail_link_pfn;	/* the last bytes link of the object */
+	__u64	data_len;	/* byte data size */
 	__u64	obj_pfn;	/* points to the next object in the list */
 };
 
@@ -140,6 +144,11 @@ static void pkram_truncate_obj(struct pkram_obj *obj)
 	pkram_truncate_links(obj->pages_head_link_pfn);
 	obj->pages_head_link_pfn = 0;
 	obj->pages_tail_link_pfn = 0;
+
+	pkram_truncate_links(obj->bytes_head_link_pfn);
+	obj->bytes_head_link_pfn = 0;
+	obj->bytes_tail_link_pfn = 0;
+	obj->data_len = 0;
 }
 
 static void pkram_truncate_node(struct pkram_node *node)
@@ -315,7 +324,7 @@ int pkram_prepare_save_obj(struct pkram_stream *ps, enum pkram_data_flags flags)
 
 	BUG_ON((node->flags & PKRAM_ACCMODE_MASK) != PKRAM_SAVE);
 
-	if (flags & ~PKRAM_DATA_pages)
+	if (flags & ~(PKRAM_DATA_pages | PKRAM_DATA_bytes))
 		return -EINVAL;
 
 	page = pkram_alloc_page(ps->gfp_mask | __GFP_ZERO);
@@ -331,6 +340,10 @@ int pkram_prepare_save_obj(struct pkram_stream *ps, enum pkram_data_flags flags)
 		ps->pages_head_link_pfnp = &obj->pages_head_link_pfn;
 		ps->pages_tail_link_pfnp = &obj->pages_tail_link_pfn;
 	}
+	if (flags & PKRAM_DATA_bytes) {
+		ps->bytes_head_link_pfnp = &obj->bytes_head_link_pfn;
+		ps->bytes_tail_link_pfnp = &obj->bytes_tail_link_pfn;
+	}
 	ps->obj = obj;
 	return 0;
 }
@@ -438,7 +451,7 @@ int pkram_prepare_load_obj(struct pkram_stream *ps)
 		return -ENODATA;
 
 	obj = pfn_to_kaddr(node->obj_pfn);
-	if (!obj->pages_head_link_pfn) {
+	if (!obj->pages_head_link_pfn && !obj->bytes_head_link_pfn) {
 		WARN_ON(1);
 		return -EINVAL;
 	}
@@ -449,6 +462,10 @@ int pkram_prepare_load_obj(struct pkram_stream *ps)
 		ps->pages_head_link_pfnp = &obj->pages_head_link_pfn;
 		ps->pages_tail_link_pfnp = &obj->pages_tail_link_pfn;
 	}
+	if (obj->bytes_head_link_pfn) {
+		ps->bytes_head_link_pfnp = &obj->bytes_head_link_pfn;
+		ps->bytes_tail_link_pfnp = &obj->bytes_tail_link_pfn;
+	}
 	ps->obj = obj;
 	return 0;
 }
@@ -499,6 +516,9 @@ void pkram_finish_access(struct pkram_access *pa, bool status_ok)
 
 	if (pa->pds.link)
 		pkram_truncate_link(pa->pds.link);
+
+	if ((pa->dtype == PKRAM_DATA_bytes) && (pa->bytes.data_page))
+		pkram_free_page(page_address(pa->bytes.data_page));
 }
 
 /*
@@ -552,6 +572,22 @@ int pkram_save_file_page(struct pkram_access *pa, struct page *page)
 	return __pkram_save_page(pa, page, page->index);
 }
 
+static int __pkram_bytes_save_page(struct pkram_access *pa, struct page *page)
+{
+	struct pkram_data_stream *pds = &pa->pds;
+	struct pkram_link *link = pds->link;
+
+	if (!link || pds->entry_idx >= PKRAM_LINK_ENTRIES_MAX) {
+		link = pkram_new_link(pds, pa->ps->gfp_mask);
+		if (!link)
+			return -ENOMEM;
+	}
+
+	pkram_add_link_entry(pds, page);
+
+	return 0;
+}
+
 static struct page *__pkram_prep_load_page(pkram_entry_t p)
 {
 	struct page *page;
@@ -646,10 +682,53 @@ struct page *pkram_load_file_page(struct pkram_access *pa, unsigned long *index)
  *
  * On success, returns the number of bytes written, which is always equal to
  * @count. On failure, -errno is returned.
+ *
+ * Error values:
+ *    %ENOMEM: insufficient amount of memory available
  */
 ssize_t pkram_write(struct pkram_access *pa, const void *buf, size_t count)
 {
-	return -ENOSYS;
+	struct pkram_node *node = pa->ps->node;
+	struct pkram_obj *obj = pa->ps->obj;
+	size_t copy_count, write_count = 0;
+	void *addr;
+
+	BUG_ON((node->flags & PKRAM_ACCMODE_MASK) != PKRAM_SAVE);
+
+	while (count > 0) {
+		if (!pa->bytes.data_page) {
+			gfp_t gfp_mask = pa->ps->gfp_mask;
+			struct page *page;
+			int err;
+
+			page = pkram_alloc_page((gfp_mask & GFP_RECLAIM_MASK) |
+					       __GFP_HIGHMEM | __GFP_ZERO);
+			if (!page)
+				return -ENOMEM;
+			err = __pkram_bytes_save_page(pa, page);
+			if (err) {
+				pkram_free_page(page_address(page));
+				return err;
+			}
+			pa->bytes.data_page = page;
+			pa->bytes.data_offset = 0;
+		}
+
+		copy_count = min_t(size_t, count, PAGE_SIZE - pa->bytes.data_offset);
+		addr = kmap_atomic(pa->bytes.data_page);
+		memcpy(addr + pa->bytes.data_offset, buf, copy_count);
+		kunmap_atomic(addr);
+
+		buf += copy_count;
+		obj->data_len += copy_count;
+		pa->bytes.data_offset += copy_count;
+		if (pa->bytes.data_offset >= PAGE_SIZE)
+			pa->bytes.data_page = NULL;
+
+		write_count += copy_count;
+		count -= copy_count;
+	}
+	return write_count;
 }
 
 /**
@@ -663,5 +742,41 @@ ssize_t pkram_write(struct pkram_access *pa, const void *buf, size_t count)
  */
 size_t pkram_read(struct pkram_access *pa, void *buf, size_t count)
 {
-	return 0;
+	struct pkram_node *node = pa->ps->node;
+	struct pkram_obj *obj = pa->ps->obj;
+	size_t copy_count, read_count = 0;
+	char *addr;
+
+	BUG_ON((node->flags & PKRAM_ACCMODE_MASK) != PKRAM_LOAD);
+
+	while (count > 0 && obj->data_len > 0) {
+		if (!pa->bytes.data_page) {
+			struct page *page;
+
+			page = __pkram_load_page(pa, NULL);
+			if (!page)
+				break;
+			pa->bytes.data_page = page;
+			pa->bytes.data_offset = 0;
+		}
+
+		copy_count = min_t(size_t, count, PAGE_SIZE - pa->bytes.data_offset);
+		if (copy_count > obj->data_len)
+			copy_count = obj->data_len;
+		addr = kmap_atomic(pa->bytes.data_page);
+		memcpy(buf, addr + pa->bytes.data_offset, copy_count);
+		kunmap_atomic(addr);
+
+		buf += copy_count;
+		obj->data_len -= copy_count;
+		pa->bytes.data_offset += copy_count;
+		if (pa->bytes.data_offset >= PAGE_SIZE || !obj->data_len) {
+			put_page(pa->bytes.data_page);
+			pa->bytes.data_page = NULL;
+		}
+
+		read_count += copy_count;
+		count -= copy_count;
+	}
+	return read_count;
 }
-- 
1.8.3.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
