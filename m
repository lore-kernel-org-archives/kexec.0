Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from aserp2120.oracle.com ([141.146.126.78])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lRLuk-004w46-6E
 for kexec@lists.infradead.org; Tue, 30 Mar 2021 21:28:46 +0000
From: Anthony Yznaga <anthony.yznaga@oracle.com>
Subject: [RFC v2 42/43] shmem: reduce time holding xa_lock when inserting pages
Date: Tue, 30 Mar 2021 14:36:17 -0700
Message-Id: <1617140178-8773-43-git-send-email-anthony.yznaga@oracle.com>
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

Rather than adding one page at a time to the page cache and taking the
page cache xarray lock each time, where possible add pages in bulk by
first populating an xarray node outside of the page cache before taking
the lock to insert it.
When a group of pages to be inserted will fill an xarray node, add them
to a local xarray, export the xarray node, and then take the lock on the
page cache xarray and insert the node.

Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 mm/shmem.c | 162 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 156 insertions(+), 6 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index f495af51042e..a7c23b43b57f 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -827,17 +827,149 @@ static void shmem_delete_from_page_cache(struct page *page, void *radswap)
 	BUG_ON(error);
 }
 
+static int shmem_add_aligned_to_page_cache(struct page *pages[], int npages,
+					   struct address_space *mapping,
+					   pgoff_t index, gfp_t gfp, int order,
+					   struct mm_struct *charge_mm)
+{
+	int xa_shift = order + XA_CHUNK_SHIFT - (order % XA_CHUNK_SHIFT);
+	XA_STATE_ORDER(xas, &mapping->i_pages, index, xa_shift);
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
+	int i, error;
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
+		bool skipcharge = page_memcg(pages[i]) ? true : false;
+
+		VM_BUG_ON_PAGE(PageTail(pages[i]), pages[i]);
+		VM_BUG_ON_PAGE(!PageLocked(pages[i]), pages[i]);
+		VM_BUG_ON_PAGE(!PageSwapBacked(pages[i]), pages[i]);
+
+		page_ref_add(pages[i], nr);
+		pages[i]->mapping = mapping;
+		pages[i]->index = index + (i * nr);
+
+		if (!skipcharge && !PageSwapCache(pages[i])) {
+			error = mem_cgroup_charge(pages[i], charge_mm, gfp);
+			if (error) {
+				if (PageTransHuge(pages[i])) {
+					count_vm_event(THP_FILE_FALLBACK);
+					count_vm_event(THP_FILE_FALLBACK_CHARGE);
+				}
+				goto error;
+			}
+		}
+		cgroup_throttle_swaprate(pages[i], gfp);
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
+		error = xas_error(&xas_tmp);
+		i = npages - 1;
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
+			__mod_lruvec_page_state(pages[i], NR_FILE_PAGES, nr);
+			__mod_lruvec_page_state(pages[i], NR_SHMEM, nr);
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
+	if (xas_error(&xas)) {
+		error = xas_error(&xas);
+		goto error;
+	}
+
+	return 0;
+error:
+	while (i != 0) {
+		pages[i]->mapping = NULL;
+		page_ref_sub(pages[i], nr);
+		i--;
+	}
+	return error;
+}
+
 static int shmem_add_pages_to_cache(struct page *pages[], int npages,
 				struct address_space *mapping,
 				pgoff_t start, gfp_t gfp,
 				struct mm_struct *charge_mm)
 {
 	pgoff_t index = start;
-	int i, err;
+	int i, j, err;
 
 	i = 0;
 	while (i < npages) {
 		if (PageTransHuge(pages[i])) {
+			if (IS_ALIGNED(index, 4096) && i+8 <= npages) {
+				for (j = 1; j < 8; j++) {
+					if (!PageTransHuge(pages[i+j]))
+						break;
+				}
+				if (j == 8) {
+					err = shmem_add_aligned_to_page_cache(&pages[i], 8, mapping, index, gfp, HPAGE_PMD_ORDER, charge_mm);
+					if (err)
+						goto out_release;
+					index += HPAGE_PMD_NR * 8;
+					i += 8;
+					continue;
+				}
+			}
+
 			err = shmem_add_to_page_cache_fast(pages[i], mapping, index, gfp, charge_mm, page_memcg(pages[i]) ? true : false);
 			if (err)
 				goto out_release;
@@ -846,11 +978,29 @@ static int shmem_add_pages_to_cache(struct page *pages[], int npages,
 			continue;
 		}
 
-		err = shmem_add_to_page_cache_fast(pages[i], mapping, index, gfp, charge_mm, page_memcg(pages[i]) ? true : false);
-		if (err)
-			goto out_release;
-		index++;
-		i++;
+		for (j = 1; i + j < npages; j++) {
+			if (PageTransHuge(pages[i + j]))
+				break;
+		}
+
+		while (j > 0) {
+			if (IS_ALIGNED(index, 64) && j >= 64) {
+				err = shmem_add_aligned_to_page_cache(&pages[i], 64, mapping, index, gfp, 0, charge_mm);
+				if (err)
+					goto out_release;
+				index += 64;
+				i += 64;
+				j -= 64;
+				continue;
+			}
+
+			err = shmem_add_to_page_cache_fast(pages[i], mapping, index, gfp, charge_mm, page_memcg(pages[i]) ? true : false);
+			if (err)
+				goto out_release;
+			index++;
+			i++;
+			j--;
+		}
 	}
 	return 0;
 
-- 
1.8.3.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
