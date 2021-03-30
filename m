Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from userp2130.oracle.com ([156.151.31.86])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lRLua-004w1Q-VC
 for kexec@lists.infradead.org; Tue, 30 Mar 2021 21:28:37 +0000
From: Anthony Yznaga <anthony.yznaga@oracle.com>
Subject: [RFC v2 40/43] shmem: initial support for adding multiple pages to
 pagecache
Date: Tue, 30 Mar 2021 14:36:15 -0700
Message-Id: <1617140178-8773-41-git-send-email-anthony.yznaga@oracle.com>
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
 mm/shmem.c | 123 +++++++++++++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 108 insertions(+), 15 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 63299da75166..f495af51042e 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -738,6 +738,74 @@ static int shmem_add_to_page_cache(struct page *page,
 	return error;
 }
 
+static int shmem_add_to_page_cache_fast(struct page *page,
+				   struct address_space *mapping,
+				   pgoff_t index, gfp_t gfp,
+				   struct mm_struct *charge_mm, bool skipcharge)
+{
+	XA_STATE_ORDER(xas, &mapping->i_pages, index, thp_order(page));
+	unsigned long nr = thp_nr_pages(page);
+	unsigned long i = 0;
+	int error;
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
+	if (!skipcharge && !PageSwapCache(page)) {
+		error = mem_cgroup_charge(page, charge_mm, gfp);
+		if (error) {
+			if (PageTransHuge(page)) {
+				count_vm_event(THP_FILE_FALLBACK);
+				count_vm_event(THP_FILE_FALLBACK_CHARGE);
+			}
+			goto error;
+		}
+	}
+	cgroup_throttle_swaprate(page, gfp);
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
+		__mod_lruvec_page_state(page, NR_FILE_PAGES, nr);
+		__mod_lruvec_page_state(page, NR_SHMEM, nr);
+		local_irq_enable();
+		break;
+unlock:
+		xas_unlock_irq(&xas);
+	} while (xas_nomem(&xas, gfp));
+
+	if (xas_error(&xas)) {
+		error = xas_error(&xas);
+		goto error;
+	}
+
+	return 0;
+error:
+	page->mapping = NULL;
+	page_ref_sub(page, nr);
+	return error;
+}
+
 /*
  * Like delete_from_page_cache, but substitutes swap for page.
  */
@@ -759,6 +827,41 @@ static void shmem_delete_from_page_cache(struct page *page, void *radswap)
 	BUG_ON(error);
 }
 
+static int shmem_add_pages_to_cache(struct page *pages[], int npages,
+				struct address_space *mapping,
+				pgoff_t start, gfp_t gfp,
+				struct mm_struct *charge_mm)
+{
+	pgoff_t index = start;
+	int i, err;
+
+	i = 0;
+	while (i < npages) {
+		if (PageTransHuge(pages[i])) {
+			err = shmem_add_to_page_cache_fast(pages[i], mapping, index, gfp, charge_mm, page_memcg(pages[i]) ? true : false);
+			if (err)
+				goto out_release;
+			index += thp_nr_pages(pages[i]);
+			i++;
+			continue;
+		}
+
+		err = shmem_add_to_page_cache_fast(pages[i], mapping, index, gfp, charge_mm, page_memcg(pages[i]) ? true : false);
+		if (err)
+			goto out_release;
+		index++;
+		i++;
+	}
+	return 0;
+
+out_release:
+	while (i < npages) {
+		delete_from_page_cache(pages[i]);
+		i--;
+	}
+	return err;
+}
+
 int shmem_insert_page(struct mm_struct *mm, struct inode *inode, pgoff_t index,
 		      struct page *page)
 {
@@ -889,17 +992,10 @@ int shmem_insert_pages(struct mm_struct *charge_mm, struct inode *inode,
 		__SetPageReferenced(pages[i]);
 	}
 
-	for (i = 0; i < npages; i++) {
-		bool ischarged = page_memcg(pages[i]) ? true : false;
-
-		err = shmem_add_to_page_cache(pages[i], mapping, index,
-					NULL, gfp & GFP_RECLAIM_MASK,
-					charge_mm, ischarged);
-		if (err)
-			goto out_release;
-
-		index += thp_nr_pages(pages[i]);
-	}
+	err = shmem_add_pages_to_cache(pages, npages, mapping, index,
+					gfp & GFP_RECLAIM_MASK, charge_mm);
+	if (err)
+		goto out_unlock;
 
 	spin_lock(&info->lock);
 	info->alloced += nr;
@@ -922,10 +1018,7 @@ int shmem_insert_pages(struct mm_struct *charge_mm, struct inode *inode,
 
 	return 0;
 
-out_release:
-	while (--i >= 0)
-		delete_from_page_cache(pages[i]);
-
+out_unlock:
 	for (i = 0; i < npages; i++)
 		unlock_page(pages[i]);
 
-- 
1.8.3.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
