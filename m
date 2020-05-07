Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from aserp2120.oracle.com ([141.146.126.78])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jWUfZ-0003r9-0i
 for kexec@lists.infradead.org; Thu, 07 May 2020 00:45:54 +0000
From: Anthony Yznaga <anthony.yznaga@oracle.com>
Subject: [RFC 40/43] shmem: initial support for adding multiple pages to
 pagecache
Date: Wed,  6 May 2020 17:42:06 -0700
Message-Id: <1588812129-8596-41-git-send-email-anthony.yznaga@oracle.com>
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

shmem_insert_pages() currently loops over the array of pages passed
to it and calls shmem_add_to_page_cache() for each one. Prepare
for adding pages to the pagecache in bulk by adding and using a
shmem_add_pages_to_cache() call.  For now it just iterates over
an array and adds pages individually, but improvements in performance
when multiple threads are adding to the same pagecache are achieved
by calling a new shmem_add_to_page_cache_fast() function that does
not check for conflicts and drops the xarray lock before updating stats.

Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 mm/shmem.c | 95 ++++++++++++++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 84 insertions(+), 11 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 678a396ba8d3..f621d863e362 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -660,6 +660,57 @@ static int shmem_add_to_page_cache(struct page *page,
 	return 0;
 }
 
+static int shmem_add_to_page_cache_fast(struct page *page,
+				   struct address_space *mapping,
+				   pgoff_t index, gfp_t gfp)
+{
+	XA_STATE_ORDER(xas, &mapping->i_pages, index, compound_order(page));
+	unsigned long nr = compound_nr(page);
+	unsigned long i = 0;
+
+	VM_BUG_ON_PAGE(PageTail(page), page);
+	VM_BUG_ON_PAGE(index != round_down(index, nr), page);
+	VM_BUG_ON_PAGE(!PageLocked(page), page);
+	VM_BUG_ON_PAGE(!PageSwapBacked(page), page);
+
+	page_ref_add(page, nr);
+	page->mapping = mapping;
+	page->index = index;
+
+	do {
+		xas_lock_irq(&xas);
+		xas_create_range(&xas);
+		if (xas_error(&xas))
+			goto unlock;
+next:
+		xas_store(&xas, page);
+		if (++i < nr) {
+			xas_next(&xas);
+			goto next;
+		}
+		mapping->nrpages += nr;
+		xas_unlock(&xas);
+		if (PageTransHuge(page)) {
+			count_vm_event(THP_FILE_ALLOC);
+			__inc_node_page_state(page, NR_SHMEM_THPS);
+		}
+		__mod_node_page_state(page_pgdat(page), NR_FILE_PAGES, nr);
+		__mod_node_page_state(page_pgdat(page), NR_SHMEM, nr);
+		local_irq_enable();
+		break;
+unlock:
+		xas_unlock_irq(&xas);
+	} while (xas_nomem(&xas, gfp));
+
+	if (xas_error(&xas)) {
+		page->mapping = NULL;
+		page_ref_sub(page, nr);
+		return xas_error(&xas);
+	}
+
+	return 0;
+}
+
 /*
  * Like delete_from_page_cache, but substitutes swap for page.
  */
@@ -681,6 +732,35 @@ static void shmem_delete_from_page_cache(struct page *page, void *radswap)
 	BUG_ON(error);
 }
 
+static int shmem_add_pages_to_cache(struct page *pages[], int npages,
+				struct address_space *mapping,
+				pgoff_t start, gfp_t gfp)
+{
+	pgoff_t index = start;
+	int err = 0;
+	int i;
+
+	i = 0;
+	while (i < npages) {
+		if (PageTransHuge(pages[i])) {
+			err = shmem_add_to_page_cache_fast(pages[i], mapping, index, gfp);
+			if (err)
+				break;
+			index += HPAGE_PMD_NR;
+			i++;
+			continue;
+		}
+
+		err = shmem_add_to_page_cache_fast(pages[i], mapping, index, gfp);
+		if (err)
+			break;
+		index++;
+		i++;
+	}
+
+	return err;
+}
+
 int shmem_insert_page(struct mm_struct *mm, struct inode *inode, pgoff_t index,
 		      struct page *page)
 {
@@ -844,17 +924,10 @@ int shmem_insert_pages(struct mm_struct *mm, struct inode *inode, pgoff_t index,
 
 	}
 
-	for (i = 0; i < npages; i++) {
-		err = shmem_add_to_page_cache(pages[i], mapping, index,
-					NULL, gfp & GFP_RECLAIM_MASK);
-		if (err)
-			goto out_truncate;
-
-		if (PageTransHuge(pages[i]))
-			index += HPAGE_PMD_NR;
-		else
-			index++;
-	}
+	err = shmem_add_pages_to_cache(pages, npages, mapping, index,
+					gfp & GFP_RECLAIM_MASK);
+	if (err)
+		goto out_truncate;
 
 	spin_lock(&info->lock);
 	info->alloced += nr;
-- 
2.13.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
