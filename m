Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from userp2120.oracle.com ([156.151.31.85])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jWUdb-0007YQ-AW
 for kexec@lists.infradead.org; Thu, 07 May 2020 00:43:45 +0000
From: Anthony Yznaga <anthony.yznaga@oracle.com>
Subject: [RFC 06/43] mm: PKRAM: implement byte stream operations
Date: Wed,  6 May 2020 17:41:32 -0700
Message-Id: <1588812129-8596-7-git-send-email-anthony.yznaga@oracle.com>
In-Reply-To: <1588812129-8596-1-git-send-email-anthony.yznaga@oracle.com>
References: <1588812129-8596-1-git-send-email-anthony.yznaga@oracle.com>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: x86@kernel.org, linux-doc@vger.kernel.org, gustavo@embeddedor.com, peterz@infradead.org, kexec@lists.infradead.org, paul.c.lai@intel.com, dave.hansen@linux.intel.com, mhocko@kernel.org, lei.l.li@intel.com, nivedita@alum.mit.edu, ziqian.lzq@antfin.com, hpa@zytor.com, ardb@kernel.org, ashok.raj@intel.com, bhe@redhat.com, corbet@lwn.net, masahiroy@kernel.org, rafael.j.wysocki@intel.com, hughd@google.com, willy@infradead.org, rppt@linux.ibm.com, mingo@redhat.com, vdavydov.dev@gmail.com, ying.huang@intel.com, Thomas.Lendacky@amd.com, kevin.tian@intel.com, jroedel@suse.de, keescook@chromium.org, dan.j.williams@intel.com, bp@alien8.de, zhiyuan.lv@intel.com, luto@kernel.org, tglx@linutronix.de, andriy.shevchenko@linux.intel.com, dima@golovin.in, yang.shi@linux.alibaba.com, ndesaulniers@google.com, zhenzhong.duan@oracle.com, guro@fb.com, minchan@kernel.org, ebiederm@xmission.com, jason.zeng@intel.com, hannes@cmpxchg.org, linux-fsdevel@vger.kernel.org, akpm@linux-foundation.org, daniel.kiper@oracle.com

This patch adds the ability to save arbitrary byte streams up to a
total length of one page to a PKRAM object using pkram_write() to be
restored later using pkram_read().

Originally-by: Vladimir Davydov <vdavydov.dev@gmail.com>
Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 include/linux/pkram.h |  4 +++
 mm/pkram.c            | 84 +++++++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 86 insertions(+), 2 deletions(-)

diff --git a/include/linux/pkram.h b/include/linux/pkram.h
index 584cadb662b4..a58dd2ea835a 100644
--- a/include/linux/pkram.h
+++ b/include/linux/pkram.h
@@ -17,6 +17,10 @@ struct pkram_stream {
 	unsigned int entry_idx;		/* next entry in link */
 
 	unsigned long next_index;
+
+	/* byte data */
+	struct page *data_page;
+	unsigned int data_offset;
 };
 
 #define PKRAM_NAME_MAX		256	/* including nul */
diff --git a/mm/pkram.c b/mm/pkram.c
index 9164060e36f5..06b471eea0b0 100644
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
@@ -42,6 +43,8 @@ struct pkram_link {
 	((PAGE_SIZE-sizeof(struct pkram_link))/sizeof(pkram_entry_t))
 
 struct pkram_obj {
+	__u64	data_pfn;	/* points to the byte data */
+	__u64	data_len;	/* byte data size */
 	__u64	link_pfn;	/* points to the first link of the object */
 	__u64	obj_pfn;	/* points to the next object in the list */
 };
@@ -407,6 +410,9 @@ void pkram_finish_load_obj(struct pkram_stream *ps)
 		}
 	}
 
+	if (ps->data_page)
+		pkram_free_page(page_address(ps->data_page));
+
 	pkram_truncate_obj(obj);
 	pkram_free_page(obj);
 }
@@ -422,6 +428,9 @@ void pkram_finish_load(struct pkram_stream *ps)
 
 	BUG_ON((node->flags & PKRAM_ACCMODE_MASK) != PKRAM_LOAD);
 
+	if (ps->data_page)
+		put_page(ps->data_page);
+
 	pkram_truncate_node(node);
 	pkram_free_page(node);
 }
@@ -581,10 +590,41 @@ struct page *pkram_load_page(struct pkram_stream *ps, unsigned long *index, shor
  *
  * On success, returns the number of bytes written, which is always equal to
  * @count. On failure, -errno is returned.
+ *
+ * Error values:
+ *    %ENOMEM: insufficient amount of memory available
  */
 ssize_t pkram_write(struct pkram_stream *ps, const void *buf, size_t count)
 {
-	return -ENOSYS;
+	struct pkram_node *node = ps->node;
+	struct pkram_obj *obj = ps->obj;
+	void *addr;
+
+	BUG_ON((node->flags & PKRAM_ACCMODE_MASK) != PKRAM_SAVE);
+
+	if (!ps->data_page) {
+		struct page *page;
+
+		page = pkram_alloc_page((ps->gfp_mask & GFP_RECLAIM_MASK) |
+				       __GFP_HIGHMEM | __GFP_ZERO);
+		if (!page)
+			return -ENOMEM;
+
+		ps->data_page = page;
+		ps->data_offset = 0;
+		obj->data_pfn = page_to_pfn(page);
+	}
+
+	BUG_ON(count > PAGE_SIZE - ps->data_offset);
+
+	addr = kmap_atomic(ps->data_page);
+	memcpy(addr + ps->data_offset, buf, count);
+	kunmap_atomic(addr);
+
+	obj->data_len += count;
+	ps->data_offset += count;
+
+	return count;
 }
 
 /**
@@ -597,5 +637,45 @@ ssize_t pkram_write(struct pkram_stream *ps, const void *buf, size_t count)
  */
 size_t pkram_read(struct pkram_stream *ps, void *buf, size_t count)
 {
-	return 0;
+	struct pkram_node *node = ps->node;
+	struct pkram_obj *obj = ps->obj;
+	size_t copy_count;
+	char *addr;
+
+	BUG_ON((node->flags & PKRAM_ACCMODE_MASK) != PKRAM_LOAD);
+
+	if (!count || !obj->data_len)
+		return 0;
+
+	if (!ps->data_page) {
+		struct page *page;
+
+		page = pfn_to_page(obj->data_pfn);
+		if (!page)
+			return 0;
+
+		ps->data_page = page;
+		ps->data_offset = 0;
+		obj->data_pfn = 0;
+	}
+
+	BUG_ON(count > PAGE_SIZE - ps->data_offset);
+
+	copy_count = min_t(size_t, count, PAGE_SIZE - ps->data_offset);
+	if (copy_count > obj->data_len)
+		copy_count = obj->data_len;
+
+	addr = kmap_atomic(ps->data_page);
+	memcpy(buf, addr + ps->data_offset, copy_count);
+	kunmap_atomic(addr);
+
+	obj->data_len -= copy_count;
+	ps->data_offset += copy_count;
+
+	if (!obj->data_len) {
+		pkram_free_page(page_address(ps->data_page));
+		ps->data_page = NULL;
+	}
+
+	return copy_count;
 }
-- 
2.13.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
