Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83604606A324
	for <kexec@archiver.kernel.org>; Tue,  3 Nov 2026 17:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=D78YMbGV;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JuqPUtXY
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=QBNeyKGgsk+FmC6nEM5xjOZsGGaqbtElvO5AoS80vXU=; b=D78YMbGVDbd1zD64YMfzFU1UZh
	7oN+1R+wmyViRML/VTuzsP6L+k4e6Se9UMInR86aDRvqwcj1NJNSDaWRgNbrh/7pgaUgsRE+SuBId
	kjCq5zUu/KzMo92S09fYdohh8ztSwM52WJL0N/ljDhdqTThoER7G9hW400wKFYHAmwnMkT9YgcGnQ
	ljb1lGD9hTnW7hwuggyaDmG3T5lBAJdwPdQHbbWUkUPkWcwtfPfJwvoohCt5XRXSfkLjTIatJj0RV
	YswY8089qvzc5PbjbI6HLZnUAmxDfcAU6DfT6Mo2gcJ92F50KeG4VeOU9qyaVNIS1+GFO6LbAVz94
	Pg8lOalw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOIE0-00000003IPG-3yYz;
	Tue, 03 Nov 2026 17:23:08 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOIDu-00000003IOa-2lBZ
	for kexec@lists.infradead.org;
	Tue, 03 Nov 2026 17:23:07 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 026454247C;
	Tue,  3 Nov 2026 17:23:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FECC1F000C1;
	Tue,  3 Nov 2026 17:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793726581;
	bh=QBNeyKGgsk+FmC6nEM5xjOZsGGaqbtElvO5AoS80vXU=;
	h=From:To:Cc:Subject:Date;
	b=JuqPUtXY3lVPSVcRFVuZA/BBRi9VAdMSiGG3EoccW24PuUNhBStcghlFoPv/6s4Cj
	 gYVe/iHq/vcBu9u/sqoU++k46+HQKMvQc8aXh6nq2leFbBx+vUroM+Rsedf3Fx/Pvu
	 0Ikqgtps5Ubp2z068GGtW+sagTUMCPhzsQJO4Eyd/RjE9a6KC5cfC7Cg6kw559ksw1
	 +riXeRcidDwEzg/YGoRHLOQ/kYPjjH6PfHbSGXVHTk331C/LckAIx19SGkDkToy9CT
	 8JnHrjbzS4APBE6am6Cwp55+4hIjDRD6VLoBG+qZcD62u+9nN+wgAYMG3Aqt3A4rx6
	 lKDIYu/p6m+dw==
From: Pratyush Yadav <pratyush@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>,
	Mike Rapoport <rppt@kernel.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v2] mm/memfd_luo: don't use memfd_pin_folios()
Date: Tue,  3 Nov 2026 18:22:50 +0100
Message-ID: <20261103172251.2348370-1-pratyush@kernel.org>
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: "Pratyush Yadav (Google)" <pratyush@kernel.org>

memfd_luo takes a snapshot of the folios in the file's mapping. To make
sure the snapshot does not go out of sync, it pins the folios in the
file via memfd_pin_folios(). The pinning also migrates the folios out of
MIGRATE_MOVABLE to make sure doesn't land in KHO boot memory or in a CMA
region.

memfd_pin_folios() does not lock the folios. So it can race with
shmem_writeout(). A folio returned by memfd_pin_folios() might already
be in swap cache. This happens to work but is fragile. memfd_luo looks
at folio flags and index on a folio that isn't in the memfd's page
cache.

In addition, memfd_pin_folios() needs the caller to allocate an array of
folios. memfd_luo does not really need that since it will vmalloc
folios_ser and store the information there anyway. The folios array is
unnecessary overhead.

Finally, memfd_pin_folios() fills in holes in the memfd. This makes
preserving sparse memfds very expensive in both compute and memory.
While this patch doesn't yet stop filling in the holes, it sets up the
infrastructure to make it simpler.

Fix all this by walking the page cache directly using shmem_get_folio()
with SGP_CACHE. This returns a locked folio with an elevated refcount.
memfd_luo holds that reference until the memfd is unpreserved. This
blocks compaction, migration, etc.

There is still a need to migrate folios out of MIGRATE_MOVABLE page
blocks. This is because those might be CMA or KHO scratch. memfd_luo
will hold a longterm reference to the folios so it will block migration
in that pageblock. Introduce memfd_luo_migrate_folio() to do this.

Also factor out folio unpreservation logic into memfd_luo_put_folios()
and use it from memfd_luo_unpreserve_folios() and from error paths in
memfd_luo_preserve_folios().

Since shmem_get_folio() always returns uptodate folios, drop the folio
zeroing logic.

This change also improves preservation performance, shown in the table
below.

|------------------+----------+------------+-------|
| memfd            | baseline | this patch | delta |
|------------------+----------+------------+-------|
| 4K pages, 32 GiB | 748 ms   | 600 ms     |  -20% |
| THP, 4 GiB       | 0.59 ms  | 0.59 ms    |    0% |
| THP, 16 GiB      | 2.99 ms  | 2.61 ms    |  -13% |
| THP, 32 GiB      | 4.83 ms  | 5.21 ms    |   +8% |
| sparse, 32 GiB   | 8695 ms  | 7269 ms    |  -16% |
|------------------+----------+------------+-------|

Acked-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>

---

The diff is unfortunately hard to read. It would be easier to review the
patch by applying it and looking at the final code.

This patch is picked from a separate series I sent [0]. It is more or
less an independent change. It fixed a race for that series so I added
it there, but since that series might take longer to go through, I think
it is useful to take this patch separately.

[0] https://lore.kernel.org/all/20261027173031.763213-2-pratyush@kernel.org/

Changes since v1:

- Add memfd_luo_get_folio() which combines shmem_get_folio() and the
  migration logic.
- Collect tags.
- Rebase to v7.4-rc1.

---
 mm/memfd_luo.c | 305 ++++++++++++++++++++++++++++++-------------------
 1 file changed, 189 insertions(+), 116 deletions(-)

diff --git a/mm/memfd_luo.c b/mm/memfd_luo.c
index 6b68220275ebe..9fd9abf9fedf6 100644
--- a/mm/memfd_luo.c
+++ b/mm/memfd_luo.c
@@ -77,26 +77,160 @@
 #include <linux/kexec_handover.h>
 #include <linux/kho/abi/memfd.h>
 #include <linux/liveupdate.h>
+#include <linux/migrate.h>
+#include <linux/sched/mm.h>
+#include <linux/sched/signal.h>
 #include <linux/shmem_fs.h>
+#include <linux/swap.h>
 #include <linux/vmalloc.h>
 #include <linux/memfd.h>
 #include <uapi/linux/memfd.h>
 
 #include "internal.h"
 
+static void memfd_luo_put_folios(const struct memfd_luo_folio_ser *folios_ser,
+				 u64 nr_folios)
+{
+	u64 i;
+
+	for (i = 0; i < nr_folios; i++) {
+		const struct memfd_luo_folio_ser *pfolio = &folios_ser[i];
+		struct folio *folio;
+
+		if (!pfolio->pfn)
+			continue;
+
+		folio = pfn_folio(pfolio->pfn);
+
+		kho_unpreserve_folio(folio);
+		folio_put(folio);
+	}
+}
+
+/* How many times to retry isolating a folio someone else has isolated. */
+#define MEMFD_LUO_MIGRATE_RETRIES	3
+
+/*
+ * Move a folio out of ZONE_MOVABLE or CMA, so it can be held until the next
+ * kernel. Called with a reference on the unlocked folio, which is always
+ * dropped. The caller must look up the folio again afterwards.
+ *
+ * Returns 0 on success, -EBUSY if the folio could not be isolated (e.g.
+ * because someone else has it isolated right now), or -ENOMEM if migration
+ * failed.
+ */
+static int memfd_luo_migrate_folio(struct folio *folio)
+{
+	struct migration_target_control mtc = {
+		.nid = NUMA_NO_NODE,
+		/* Not movable, so the target is neither in ZONE_MOVABLE nor CMA. */
+		.gfp_mask = GFP_USER | __GFP_NOWARN,
+		.reason = MR_LONGTERM_PIN,
+	};
+	LIST_HEAD(source);
+	bool isolated;
+
+	/* Flush per-CPU LRU batches holding the folio so isolation works. */
+	lru_cache_drain_for_folio(folio, 1, NULL);
+	isolated = isolate_folio_to_list(folio, &source);
+	/* Isolation holds its own reference. */
+	folio_put(folio);
+	if (!isolated)
+		return -EBUSY;
+
+	if (migrate_pages(&source, alloc_migration_target, NULL,
+			  (unsigned long)&mtc, MIGRATE_SYNC, MR_LONGTERM_PIN,
+			  NULL)) {
+		putback_movable_pages(&source);
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+/*
+ * Look up the folio at @index, allocating it if needed, and make sure it can be
+ * held until the next kernel. Folios that are not longterm pinnable are migrated
+ * out first, retrying a few times if someone else has them isolated.
+ *
+ * On success, returns 0 with *@foliop locked and holding a reference.
+ */
+static int memfd_luo_get_folio(struct inode *inode, pgoff_t index,
+			       struct folio **foliop)
+{
+	int err, busy_retries = 0;
+	struct folio *folio;
+
+	for (;;) {
+		err = shmem_get_folio(inode, index, 0, &folio, SGP_CACHE);
+		if (err)
+			return err;
+
+		if (likely(folio_is_longterm_pinnable(folio)))
+			break;
+
+		folio_unlock(folio);
+		err = memfd_luo_migrate_folio(folio);
+		/* Someone else might have it isolated, retry a bit. */
+		if (err == -EBUSY && ++busy_retries < MEMFD_LUO_MIGRATE_RETRIES)
+			continue;
+		if (err)
+			return err;
+	}
+
+	*foliop = folio;
+	return 0;
+}
+
+static int memfd_luo_preserve_folio(struct folio *folio,
+				    struct memfd_luo_folio_ser *pfolio)
+{
+	int err;
+
+	err = kho_preserve_folio(folio);
+	if (err)
+		return err;
+
+	/*
+	 * A dirty folio is one which has been written to. A clean folio
+	 * is its opposite. Since a clean folio does not carry user
+	 * data, it can be freed by page reclaim under memory pressure.
+	 *
+	 * Saving the dirty flag at prepare() time doesn't work since it
+	 * can change later. Saving it at freeze() also won't work
+	 * because the dirty bit is normally synced at unmap and there
+	 * might still be a mapping of the file at freeze().
+	 *
+	 * To see why this is a problem, say a folio is clean at
+	 * preserve, but gets dirtied later. The pfolio flags will mark
+	 * it as clean. After retrieve, the next kernel might try to
+	 * reclaim this folio under memory pressure, losing user data.
+	 *
+	 * Unconditionally mark it dirty to avoid this problem. This
+	 * comes at the cost of making clean folios un-reclaimable after
+	 * live update.
+	 */
+	folio_mark_dirty(folio);
+
+	pfolio->pfn = folio_pfn(folio);
+	pfolio->flags = MEMFD_LUO_FOLIO_DIRTY | MEMFD_LUO_FOLIO_UPTODATE;
+	pfolio->index = folio->index;
+
+	return 0;
+}
+
 static int memfd_luo_preserve_folios(struct file *file,
 				     struct kho_vmalloc *kho_vmalloc,
 				     struct memfd_luo_folio_ser **out_folios_ser,
 				     u64 *nr_foliosp)
 {
+	struct memfd_luo_folio_ser *folios_ser, *shrunk;
 	struct inode *inode = file_inode(file);
-	struct memfd_luo_folio_ser *folios_ser;
-	unsigned int max_folios;
-	long i, size, nr_pinned;
-	struct folio **folios;
-	int err = -EINVAL;
-	pgoff_t offset;
-	u64 nr_folios;
+	u64 nr_folios = 0, max_folios;
+	unsigned int pin_flags;
+	pgoff_t index = 0, end;
+	int err;
+	loff_t size;
 
 	size = i_size_read(inode);
 	/*
@@ -113,98 +247,65 @@ static int memfd_luo_preserve_folios(struct file *file,
 	 * Guess the number of folios based on inode size. Real number might end
 	 * up being smaller if there are higher order folios.
 	 */
-	max_folios = PAGE_ALIGN(size) / PAGE_SIZE;
-	folios = kvmalloc_objs(*folios, max_folios);
-	if (!folios)
+	end = DIV_ROUND_UP_ULL(size, PAGE_SIZE);
+	max_folios = end;
+	folios_ser = vmalloc_array(max_folios, sizeof(*folios_ser));
+	if (!folios_ser)
 		return -ENOMEM;
 
 	/*
-	 * Pin the folios so they don't move around behind our back. This also
-	 * ensures none of the folios are in CMA -- which ensures they don't
-	 * fall in KHO bootmem. It also moves swapped out folios back to memory.
+	 * The folios are held until the next kernel, so keep newly allocated
+	 * ones out of ZONE_MOVABLE and CMA -- which also ensures they don't
+	 * fall in KHO bootmem. Existing ones are migrated below.
 	 *
-	 * A side effect of doing this is that it allocates a folio for all
-	 * indices in the file. This might waste memory on sparse memfds. If
-	 * that is really a problem in the future, we can have a
-	 * memfd_pin_folios() variant that does not allocate a page on empty
-	 * slots.
+	 * A side effect of this is that it allocates a folio for all indices in
+	 * the file. This might waste memory on sparse memfds. If that is really
+	 * a problem in the future, this loop can be taught to skip empty slots.
 	 */
-	nr_pinned = memfd_pin_folios(file, 0, size - 1, folios, max_folios,
-				     &offset);
-	if (nr_pinned < 0) {
-		err = nr_pinned;
-		pr_err("failed to pin folios: %d\n", err);
-		goto err_free_folios;
-	}
-	nr_folios = nr_pinned;
+	pin_flags = memalloc_pin_save();
+	while (index < end) {
+		struct folio *folio;
 
-	folios_ser = vcalloc(nr_folios, sizeof(*folios_ser));
-	if (!folios_ser) {
-		err = -ENOMEM;
-		goto err_unpin;
-	}
+		cond_resched();
 
-	for (i = 0; i < nr_folios; i++) {
-		struct memfd_luo_folio_ser *pfolio = &folios_ser[i];
-		struct folio *folio = folios[i];
+		if (fatal_signal_pending(current)) {
+			err = -EINTR;
+			goto err_restore;
+		}
 
-		err = kho_preserve_folio(folio);
+		if (WARN_ON_ONCE(nr_folios >= max_folios)) {
+			err = -EINVAL;
+			goto err_restore;
+		}
+
+		err = memfd_luo_get_folio(inode, index, &folio);
 		if (err)
-			goto err_unpreserve;
-
-		folio_lock(folio);
-
-		/*
-		 * A dirty folio is one which has been written to. A clean folio
-		 * is its opposite. Since a clean folio does not carry user
-		 * data, it can be freed by page reclaim under memory pressure.
-		 *
-		 * Saving the dirty flag at prepare() time doesn't work since it
-		 * can change later. Saving it at freeze() also won't work
-		 * because the dirty bit is normally synced at unmap and there
-		 * might still be a mapping of the file at freeze().
-		 *
-		 * To see why this is a problem, say a folio is clean at
-		 * preserve, but gets dirtied later. The pfolio flags will mark
-		 * it as clean. After retrieve, the next kernel might try to
-		 * reclaim this folio under memory pressure, losing user data.
-		 *
-		 * Unconditionally mark it dirty to avoid this problem. This
-		 * comes at the cost of making clean folios un-reclaimable after
-		 * live update.
-		 */
-		folio_mark_dirty(folio);
-
-		/*
-		 * If the folio is not uptodate, it was fallocated but never
-		 * used. Saving this flag at prepare() doesn't work since it
-		 * might change later when someone uses the folio.
-		 *
-		 * Since we have taken the performance penalty of allocating,
-		 * zeroing, and pinning all the folios in the holes, take a bit
-		 * more and zero all non-uptodate folios too.
-		 *
-		 * NOTE: For someone looking to improve preserve performance,
-		 * this is a good place to look.
-		 */
-		if (!folio_test_uptodate(folio)) {
-			folio_zero_range(folio, 0, folio_size(folio));
-			flush_dcache_folio(folio);
-			folio_mark_uptodate(folio);
-		}
+			goto err_restore;
 
+		err = memfd_luo_preserve_folio(folio, &folios_ser[nr_folios]);
+		index = folio_next_index(folio);
 		folio_unlock(folio);
-
-		pfolio->pfn = folio_pfn(folio);
-		pfolio->flags = MEMFD_LUO_FOLIO_DIRTY | MEMFD_LUO_FOLIO_UPTODATE;
-		pfolio->index = folio->index;
+		if (err) {
+			folio_put(folio);
+			goto err_restore;
+		}
+		nr_folios++;
 	}
+	memalloc_pin_restore(pin_flags);
+
+	/*
+	 * Free the unused tail so it doesn't get preserved. If vrealloc fails,
+	 * the folios_ser is still valid.
+	 */
+	shrunk = vrealloc(folios_ser, array_size(nr_folios, sizeof(*folios_ser)),
+			  GFP_KERNEL);
+	if (shrunk)
+		folios_ser = shrunk;
 
 	err = kho_preserve_vmalloc(folios_ser, kho_vmalloc);
 	if (err)
-		goto err_unpreserve;
+		goto err_put;
 
-	kvfree(folios);
 	*nr_foliosp = nr_folios;
 	*out_folios_ser = folios_ser;
 
@@ -215,15 +316,11 @@ static int memfd_luo_preserve_folios(struct file *file,
 	 */
 	return 0;
 
-err_unpreserve:
-	for (i = i - 1; i >= 0; i--)
-		kho_unpreserve_folio(folios[i]);
+err_restore:
+	memalloc_pin_restore(pin_flags);
+err_put:
+	memfd_luo_put_folios(folios_ser, nr_folios);
 	vfree(folios_ser);
-err_unpin:
-	unpin_folios(folios, nr_folios);
-err_free_folios:
-	kvfree(folios);
-
 	return err;
 }
 
@@ -231,26 +328,11 @@ static void memfd_luo_unpreserve_folios(struct kho_vmalloc *kho_vmalloc,
 					struct memfd_luo_folio_ser *folios_ser,
 					u64 nr_folios)
 {
-	long i;
-
 	if (!nr_folios)
 		return;
 
 	kho_unpreserve_vmalloc(kho_vmalloc);
-
-	for (i = 0; i < nr_folios; i++) {
-		const struct memfd_luo_folio_ser *pfolio = &folios_ser[i];
-		struct folio *folio;
-
-		if (!pfolio->pfn)
-			continue;
-
-		folio = pfn_folio(pfolio->pfn);
-
-		kho_unpreserve_folio(folio);
-		unpin_folio(folio);
-	}
-
+	memfd_luo_put_folios(folios_ser, nr_folios);
 	vfree(folios_ser);
 }
 
@@ -287,15 +369,6 @@ static int memfd_luo_preserve(struct liveupdate_file_op_args *args)
 	ser->pos = args->file->f_pos;
 	inode_size = i_size_read(inode);
 
-	/*
-	 * memfd_pin_folios() caps at UINT_MAX folios; refuse larger
-	 * files to avoid silently preserving only a prefix.
-	 */
-	if (DIV_ROUND_UP_ULL(inode_size, PAGE_SIZE) > UINT_MAX) {
-		err = -EFBIG;
-		goto err_free_ser;
-	}
-
 	ser->size = inode_size;
 	ser->seals = seals;
 

base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.56.0.385.gac671c819a-goog


