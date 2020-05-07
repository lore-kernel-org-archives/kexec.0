Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from aserp2120.oracle.com ([141.146.126.78])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jWUfL-0003g5-7r
 for kexec@lists.infradead.org; Thu, 07 May 2020 00:45:34 +0000
From: Anthony Yznaga <anthony.yznaga@oracle.com>
Subject: [RFC 36/43] PKRAM: add support for loading pages in bulk
Date: Wed,  6 May 2020 17:42:02 -0700
Message-Id: <1588812129-8596-37-git-send-email-anthony.yznaga@oracle.com>
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

This patch adds three functions:

pkram_prepare_load_pages()
  Called after calling pkram_prepare_load_obj()

pkram_load_pages()
  Loads some number of pages that are contiguous by their original
  file index values.  The index of the first page, an array of the
  page pointers, and the number of pages in the array are provided
  to the caller.

pkram_finish_load_pages()
  Called when no more pages will be loaded from the pkram_obj.

Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 include/linux/pkram.h |   6 +++
 mm/pkram.c            | 106 ++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 112 insertions(+)

diff --git a/include/linux/pkram.h b/include/linux/pkram.h
index bf2e138b044e..3f059791f88c 100644
--- a/include/linux/pkram.h
+++ b/include/linux/pkram.h
@@ -18,6 +18,9 @@ struct pkram_stream {
 	struct pkram_link *link;		/* current link */
 	unsigned int entry_idx;		/* next entry in link */
 
+	struct page **pages;
+	unsigned int nr_pages;
+
 	unsigned long next_index;
 	struct address_space *mapping;
 	struct mm_struct *mm;
@@ -60,14 +63,17 @@ void pkram_discard_save(struct pkram_stream *ps);
 
 int pkram_prepare_load(struct pkram_stream *ps, const char *name);
 int pkram_prepare_load_obj(struct pkram_stream *ps);
+int pkram_prepare_load_pages(struct pkram_stream *ps);
 void pkram_finish_load(struct pkram_stream *ps);
 void pkram_finish_load_obj(struct pkram_stream *ps);
+void pkram_finish_load_pages(struct pkram_stream *ps);
 
 #define PKRAM_PAGE_TRANS_HUGE	0x1	/* page is a transparent hugepage */
 
 int pkram_save_page(struct pkram_stream *ps, struct page *page, short flags);
 struct page *pkram_load_page(struct pkram_stream *ps, unsigned long *index,
 			     short *flags);
+int pkram_load_pages(struct pkram_stream *ps, unsigned long *index);
 
 ssize_t pkram_write(struct pkram_stream *ps, const void *buf, size_t count);
 size_t pkram_read(struct pkram_stream *ps, void *buf, size_t count);
diff --git a/mm/pkram.c b/mm/pkram.c
index 042c14dedc25..ef092aa5ce7a 100644
--- a/mm/pkram.c
+++ b/mm/pkram.c
@@ -820,6 +820,37 @@ int pkram_prepare_load_obj(struct pkram_stream *ps)
 }
 
 /**
+ * Initialize stream @ps for loading preserved pages from it.
+ *
+ * Returns 0 on success, -errno on failure.
+ *
+ * Error values:
+ *	%ENOMEM: insufficient memory available
+ *
+ * After the load has finished, pkram_finish_load_pages() is to be called.
+ */
+int pkram_prepare_load_pages(struct pkram_stream *ps)
+{
+	BUG_ON((ps->node->flags & PKRAM_ACCMODE_MASK) != PKRAM_LOAD);
+
+	ps->pages = kzalloc(PAGE_SIZE, GFP_KERNEL);
+	if (!ps->pages)
+		return -ENOMEM;
+
+	return 0;
+}
+
+/**
+ * Finish the load of preserved pages started with pkram_prepare_load_pages()
+ */
+void pkram_finish_load_pages(struct pkram_stream *ps)
+{
+	BUG_ON((ps->node->flags & PKRAM_ACCMODE_MASK) != PKRAM_LOAD);
+
+	kfree(ps->pages);
+}
+
+/**
  * Finish the load of a preserved memory object started with
  * pkram_prepare_load_obj() freeing the object and any data that has not
  * been loaded from it.
@@ -1066,6 +1097,81 @@ struct page *pkram_load_page(struct pkram_stream *ps, unsigned long *index, shor
 }
 
 /**
+ * Load pages from the preserved memory object associated with stream
+ * @ps. The stream must have been initialized with pkram_prepare_load(),
+ * pkram_prepare_load_obj(), and pkram_prepare_load_pages().
+ * The page entries of a single pkram_link are processed, and the stream
+ * 'pages' buffer is populated with the page pointers.
+ *
+ * Returns 0 if one or more pages are loaded or -ENODATA if there are no
+ * pages to load.
+ *
+ * The pages loaded have an incremented refcount either because the page
+ * was initialized with a refcount of 1 at boot or because the page was
+ * subsequently preserved which increased the refcount.
+ */
+int pkram_load_pages(struct pkram_stream *ps, unsigned long *index)
+{
+	struct pkram_link *link = ps->link;
+	int nr_entries = 0;
+	int i;
+
+	if (!link) {
+		link = pkram_remove_link(ps->obj);
+		if (!link)
+			return -ENODATA;
+	}
+
+	*index = link->index;
+
+	for (i = 0; i < PKRAM_LINK_ENTRIES_MAX; i++) {
+		unsigned long p = link->entry[i];
+		struct page *page;
+		short flags;
+
+		if (!p)
+			break;
+
+		flags = (p >> PKRAM_ENTRY_FLAGS_SHIFT) & PKRAM_ENTRY_FLAGS_MASK;
+		nr_entries++;
+
+		page = pfn_to_page(PHYS_PFN(p));
+		ps->pages[i] = page;
+
+		if (flags & PKRAM_PAGE_TRANS_HUGE) {
+			int order = p & PKRAM_ENTRY_ORDER_MASK;
+			int nr_pages = 1 << order;
+			int j;
+
+			for (j = 0; j < nr_pages; j++) {
+				struct page *p = page + j;
+
+				ClearPageReserved(p);
+			}
+
+			prep_compound_page(page, order);
+			prep_transhuge_page(page);
+		} else {
+			ClearPageReserved(page);
+		}
+
+		pkram_remove_identity_map(page);
+	}
+
+	ps->nr_pages = nr_entries;
+
+	/* Advance to next pkram_link page and free this one */
+	if (link->link_pfn)
+		ps->link = pfn_to_kaddr(link->link_pfn);
+	else
+		ps->link = NULL;
+
+	pkram_free_page(link);
+
+	return 0;
+}
+
+/**
  * Copy @count bytes from @buf to the preserved memory node and object
  * associated with stream @ps. The stream must have been initialized with
  * pkram_prepare_save() and pkram_prepare_save_obj().
-- 
2.13.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
