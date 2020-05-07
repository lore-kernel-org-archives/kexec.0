Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from userp2130.oracle.com ([156.151.31.86])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jWUfG-0003c6-4O
 for kexec@lists.infradead.org; Thu, 07 May 2020 00:45:30 +0000
From: Anthony Yznaga <anthony.yznaga@oracle.com>
Subject: [RFC 32/43] shmem: PKRAM: preserve shmem files a chunk at a time
Date: Wed,  6 May 2020 17:41:58 -0700
Message-Id: <1588812129-8596-33-git-send-email-anthony.yznaga@oracle.com>
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

To prepare for multithreading the work done to a preserve a file,
divide the work into subranges of the total index range of the file.
The chunk size is a rather arbitrary 256k indices.

A new API call, pkram_prepare_save_chunk(), is added.  It is called
after calling pkram_prepare_save_obj(), and it initializes pkram_stream
with the index range of the next available range of pages to save.
find_get_pages_range() can then be used to get the pages in the range.
When no more index ranges are available, pkram_prepare_save_chunk()
returns -ENODATA.

Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 include/linux/pkram.h |  6 +++++
 mm/pkram.c            | 26 +++++++++++++++++++++
 mm/shmem_pkram.c      | 63 +++++++++++++++++++++++++++++++++++----------------
 3 files changed, 75 insertions(+), 20 deletions(-)

diff --git a/include/linux/pkram.h b/include/linux/pkram.h
index cbb79d2803c0..e71ccb91d6a6 100644
--- a/include/linux/pkram.h
+++ b/include/linux/pkram.h
@@ -20,6 +20,11 @@ struct pkram_stream {
 	struct address_space *mapping;
 	struct mm_struct *mm;
 
+	unsigned long start_idx;	/* first index in range to save */
+	unsigned long end_idx;		/* last index in range to save */
+	unsigned long max_idx;		/* maximum index to save */
+	atomic64_t *next_idx;		/* first index of next range to save */
+
 	/* byte data */
 	struct page *data_page;
 	unsigned int data_offset;
@@ -46,6 +51,7 @@ void pkram_free_pgt_walk_pgd(pgd_t *pgd);
 int pkram_prepare_save(struct pkram_stream *ps, const char *name,
 		       gfp_t gfp_mask);
 int pkram_prepare_save_obj(struct pkram_stream *ps);
+int pkram_prepare_save_chunk(struct pkram_stream *ps);
 void pkram_finish_save(struct pkram_stream *ps);
 void pkram_finish_save_obj(struct pkram_stream *ps);
 void pkram_discard_save(struct pkram_stream *ps);
diff --git a/mm/pkram.c b/mm/pkram.c
index b83d31740619..5f4e4d12865f 100644
--- a/mm/pkram.c
+++ b/mm/pkram.c
@@ -638,6 +638,25 @@ int pkram_prepare_save(struct pkram_stream *ps, const char *name, gfp_t gfp_mask
 	return 0;
 }
 
+unsigned long max_pages_per_chunk = 512 * 512;
+
+/*
+ * Initialize the stream @ps for the next index range to save.
+ *
+ * Returns 0 on success, -ENODATA if no index range is available
+ *
+ */
+int pkram_prepare_save_chunk(struct pkram_stream *ps)
+{
+	ps->start_idx = atomic64_fetch_add(max_pages_per_chunk, ps->next_idx);
+	if (ps->start_idx >= ps->max_idx)
+		return -ENODATA;
+
+	ps->end_idx = ps->start_idx + max_pages_per_chunk - 1;
+
+	return 0;
+}
+
 /**
  * Create a preserved memory object and initialize stream @ps for saving data
  * to it.
@@ -667,6 +686,11 @@ int pkram_prepare_save_obj(struct pkram_stream *ps)
 		obj->obj_pfn = node->obj_pfn;
 	node->obj_pfn = page_to_pfn(page);
 
+	ps->next_idx = kmalloc(sizeof(atomic64_t), GFP_KERNEL);
+	if (!ps->next_idx)
+		return -ENOMEM;
+	atomic64_set(ps->next_idx, 0);
+
 	pkram_stream_init_obj(ps, obj);
 	return 0;
 }
@@ -679,6 +703,8 @@ void pkram_finish_save_obj(struct pkram_stream *ps)
 	struct pkram_node *node = ps->node;
 
 	BUG_ON((node->flags & PKRAM_ACCMODE_MASK) != PKRAM_SAVE);
+
+	kfree(ps->next_idx);
 }
 
 /**
diff --git a/mm/shmem_pkram.c b/mm/shmem_pkram.c
index c97d64393822..2f4d0bdf3e05 100644
--- a/mm/shmem_pkram.c
+++ b/mm/shmem_pkram.c
@@ -74,58 +74,81 @@ static int save_page(struct page *page, struct pkram_stream *ps)
 	return err;
 }
 
-static int save_file_content(struct pkram_stream *ps)
+static int save_file_content_range(struct address_space *mapping,
+				   struct pkram_stream *ps)
 {
+	unsigned long index, end;
 	struct pagevec pvec;
-	pgoff_t indices[PAGEVEC_SIZE];
-	pgoff_t index = 0;
 	struct page *page;
-	int i, err = 0;
+	int err = 0;
+	int i;
+
+	index = ps->start_idx;
+	end = ps->end_idx;
 
 	pagevec_init(&pvec);
 	for ( ; ; ) {
-		pvec.nr = find_get_entries(ps->mapping, index, PAGEVEC_SIZE,
-				pvec.pages, indices);
+		pvec.nr = find_get_pages_range(mapping, &index, end,
+				PAGEVEC_SIZE, pvec.pages);
 		if (!pvec.nr)
 			break;
-		for (i = 0; i < pagevec_count(&pvec); i++) {
+		for (i = 0; i < pagevec_count(&pvec); ) {
 			page = pvec.pages[i];
-			index = indices[i];
-
-			if (WARN_ON_ONCE(xa_is_value(page))) {
-				err = -EINVAL;
-				break;
-			}
-
 			lock_page(page);
 
 			if (PageTransTail(page)) {
 				WARN_ONCE(1, "PageTransTail returned true\n");
 				unlock_page(page);
+				i++;
 				continue;
 			}
 
-			BUG_ON(page->mapping != ps->mapping);
+			BUG_ON(page->mapping != mapping);
 			err = save_page(page, ps);
 
-			i += compound_nr(page) - 1;
-			index += compound_nr(page) - 1;
+			if (PageCompound(page)) {
+				index = page->index + compound_nr(page);
+				i += compound_nr(page);
+			} else {
+				i++;
+			}
 
 			unlock_page(page);
 			if (err)
 				break;
 		}
-		pagevec_remove_exceptionals(&pvec);
 		pagevec_release(&pvec);
-		if (err)
+		if (err || (index > end))
 			break;
 		cond_resched();
-		index++;
 	}
 
 	return err;
 }
 
+static int do_save_file_content(struct pkram_stream *ps)
+{
+	int ret;
+
+	do {
+		ret = pkram_prepare_save_chunk(ps);
+		if (!ret)
+			ret = save_file_content_range(ps->mapping, ps);
+	} while (!ret);
+
+	if (ret == -ENODATA)
+		ret = 0;
+
+	return ret;
+}
+
+static int save_file_content(struct pkram_stream *ps)
+{
+	ps->max_idx = DIV_ROUND_UP(i_size_read(ps->mapping->host), PAGE_SIZE);
+
+	return do_save_file_content(ps);
+}
+
 static int save_file(struct dentry *dentry, struct pkram_stream *ps)
 {
 	struct inode *inode = dentry->d_inode;
-- 
2.13.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
