Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from userp2120.oracle.com ([156.151.31.85])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jWUfg-0003xk-Ux
 for kexec@lists.infradead.org; Thu, 07 May 2020 00:46:04 +0000
From: Anthony Yznaga <anthony.yznaga@oracle.com>
Subject: [RFC 42/43] shmem: reduce time holding xa_lock when inserting pages
Date: Wed,  6 May 2020 17:42:08 -0700
Message-Id: <1588812129-8596-43-git-send-email-anthony.yznaga@oracle.com>
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

Rather than adding one page at a time to the page cache and taking the
page cache xarray lock each time, where possible add pages in bulk by
first populating an xarray node outside of the page cache before taking
the lock to insert it.
When a group of pages to be inserted will fill an xarray node, add them
to a local xarray, export the xarray node, and then take the lock on the
page cache xarray and insert the node.

Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 mm/shmem.c | 145 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 138 insertions(+), 7 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index f621d863e362..9d3c4e1f2dc1 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -732,17 +732,130 @@ static void shmem_delete_from_page_cache(struct page *page, void *radswap)
 	BUG_ON(error);
 }
 
+static int shmem_add_aligned_to_page_cache(struct page *pages[], int npages,
+					   struct address_space *mapping,
+					   pgoff_t index, gfp_t gfp, int order)
+{
+	int xa_shift = order + XA_CHUNK_SHIFT - (order % XA_CHUNK_SHIFT);
+	XA_STATE_ORDER(xas, &mapping->i_pages, index, xa_shift);
+	struct xa_state *xas_ptr = &xas;
+	struct xarray xa_tmp;
+	/*
+	 * Specify order so xas_create_range() only needs to be called once
+	 * to allocate the entire range.  This guarantees that xas_store()
+	 * will not fail due to lack of memory.
+	 * Specify index == 0 so the minimum necessary nodes are allocated.
+	 */
+	XA_STATE_ORDER(xas_tmp, &xa_tmp, 0, xa_shift);
+	unsigned long nr = 1UL << order;
+	struct xa_node *node;
+	int i;
+
+	if (npages * nr != 1 << xa_shift) {
+		WARN_ONCE(1, "npages (%d) not aligned to xa_shift\n", npages);
+		return -EINVAL;
+	}
+	if (!IS_ALIGNED(index, 1 << xa_shift)) {
+		WARN_ONCE(1, "index (%lu) not aligned to xa_shift\n", index);
+		return -EINVAL;
+	}
+
+	for (i = 0; i < npages; i++) {
+		VM_BUG_ON_PAGE(PageTail(pages[i]), pages[i]);
+		VM_BUG_ON_PAGE(!PageLocked(pages[i]), pages[i]);
+		VM_BUG_ON_PAGE(!PageSwapBacked(pages[i]), pages[i]);
+
+		page_ref_add(pages[i], nr);
+		pages[i]->mapping = mapping;
+		pages[i]->index = index + (i * nr);
+	}
+
+	xa_init(&xa_tmp);
+	do {
+		xas_lock(&xas_tmp);
+		xas_create_range(&xas_tmp);
+		if (xas_error(&xas_tmp))
+			goto unlock;
+		for (i = 0; i < npages; i++) {
+			int j = 0;
+next:
+			xas_store(&xas_tmp, pages[i]);
+			if (++j < nr) {
+				xas_next(&xas_tmp);
+				goto next;
+			}
+			if (i < npages - 1)
+				xas_next(&xas_tmp);
+		}
+		xas_set_order(&xas_tmp, 0, xa_shift);
+		node = xas_export_node(&xas_tmp);
+unlock:
+		xas_unlock(&xas_tmp);
+	} while (xas_nomem(&xas_tmp, gfp));
+
+	if (xas_error(&xas_tmp)) {
+		xas_ptr = &xas_tmp;
+		goto error;
+	}
+
+	do {
+		xas_lock_irq(&xas);
+		xas_import_node(&xas, node);
+		if (xas_error(&xas))
+			goto unlock1;
+		mapping->nrpages += nr * npages;
+		xas_unlock(&xas);
+		for (i = 0; i < npages; i++) {
+			__mod_node_page_state(page_pgdat(pages[i]), NR_FILE_PAGES, nr);
+			__mod_node_page_state(page_pgdat(pages[i]), NR_SHMEM, nr);
+			if (PageTransHuge(pages[i])) {
+				count_vm_event(THP_FILE_ALLOC);
+				__inc_node_page_state(pages[i], NR_SHMEM_THPS);
+			}
+		}
+		local_irq_enable();
+		break;
+unlock1:
+		xas_unlock_irq(&xas);
+	} while (xas_nomem(&xas, gfp));
+
+	if (!xas_error(&xas))
+		return 0;
+
+error:
+	for (i = 0; i < npages; i++) {
+		pages[i]->mapping = NULL;
+		page_ref_sub(pages[i], nr);
+	}
+	return xas_error(xas_ptr);
+}
+
 static int shmem_add_pages_to_cache(struct page *pages[], int npages,
 				struct address_space *mapping,
 				pgoff_t start, gfp_t gfp)
 {
 	pgoff_t index = start;
 	int err = 0;
-	int i;
+	int i, j;
 
 	i = 0;
 	while (i < npages) {
 		if (PageTransHuge(pages[i])) {
+			if (IS_ALIGNED(index, 4096) && i+8 <= npages) {
+				for (j = 1; j < 8; j++) {
+					if (!PageTransHuge(pages[i+j]))
+						break;
+				}
+				if (j == 8) {
+					err = shmem_add_aligned_to_page_cache(&pages[i], 8, mapping, index, gfp, HPAGE_PMD_ORDER);
+					if (err)
+						goto done;
+					index += HPAGE_PMD_NR * 8;
+					i += 8;
+					continue;
+				}
+			}
+
 			err = shmem_add_to_page_cache_fast(pages[i], mapping, index, gfp);
 			if (err)
 				break;
@@ -751,13 +864,31 @@ static int shmem_add_pages_to_cache(struct page *pages[], int npages,
 			continue;
 		}
 
-		err = shmem_add_to_page_cache_fast(pages[i], mapping, index, gfp);
-		if (err)
-			break;
-		index++;
-		i++;
-	}
+		for (j = 1; i + j < npages; j++) {
+			if (PageTransHuge(pages[i + j]))
+				break;
+		}
+
+		while (j > 0) {
+			if (IS_ALIGNED(index, 64) && j >= 64) {
+				err = shmem_add_aligned_to_page_cache(&pages[i], 64, mapping, index, gfp, 0);
+				if (err)
+					goto done;
+				index += 64;
+				i += 64;
+				j -= 64;
+				continue;
+			}
 
+			err = shmem_add_to_page_cache_fast(pages[i], mapping, index, gfp);
+			if (err)
+				goto done;
+			index++;
+			i++;
+			j--;
+		}
+	}
+done:
 	return err;
 }
 
-- 
2.13.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
