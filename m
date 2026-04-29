Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B2D6FF8867
	for <kexec@archiver.kernel.org>; Wed, 29 Apr 2026 13:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Db16u/o8Bl9R3A+gUowH13nNiAOqM6eGtUya+uogmHc=; b=M5lNaMgoDL8UHssUcRQhlJ+2ow
	PIQXUtUBOIGAFr+qvn7zMg42u6GFEQ0Ss1H7w+haOCCGrcSE97hkykXj8KZLRmtZlDvE0JTpfOw2N
	tPdfUPFhgFSPE6tzLO04SA+dy6nXRd+xDX0+mvmebpEkssQ5Q/S9U8mvDzajrRcg45KaxwOMyWjSW
	6DFUD9aXF+CZbZY6O6bJAJ7gpgWzqXEajqTV076nH3reEHwrIJkcUt3QaIxK0t1HUzgab25pjMVfq
	HTVrND7nhAoVRQECG07lgouVtzWKWt0uGq8M4q+5HbJRuRvTpIgRhW8Y4Qhkge8Roi2OQHUEDRACx
	JOswAiHA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wI59D-00000003gnn-12iC;
	Wed, 29 Apr 2026 13:40:15 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wI59A-00000003gka-2hsb
	for kexec@lists.infradead.org;
	Wed, 29 Apr 2026 13:40:13 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 59A61442AC;
	Wed, 29 Apr 2026 13:40:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F2C0C19425;
	Wed, 29 Apr 2026 13:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777470012;
	bh=LU55tlcL/y5Dvw2CMKDLuxBuqllrlC4je9HKT4siEk8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jOI2WwuTUXT2dH3dciuVs5qQuyVHqmJNVUXJRlNurMr4RX0gyj4zxKIhZrOzCxaXf
	 PAmGuruB1l9XDdcCwTALDN6OaZiPz6XmYXakHUrh8dU9o19yMdRacl7acevPpu+AwS
	 ypmAG/C84+iiDatEdM86DKP+Drbw8FjjFtbPdGPG3DBahsp5BKvz7U5qDyD1aqk773
	 F53HFBD2W95qGohKSv5mo949+LDrOGFCq3x53gn7KM7UTPdD6cpXqvJxw3mbf3mtyK
	 9GiC/GJfcmoXyX02ITWyEZl891R8WPzYbo/fuaOVroftoIf9Kid1g7TVQpTRs18xko
	 Oexn/U5s7VlEw==
From: Pratyush Yadav <pratyush@kernel.org>
To: Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Alexander Graf <graf@amazon.com>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jason Miu <jasonmiu@google.com>
Cc: kexec@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 12/12] mm/hugetlb: make bootmem allocation work with KHO
Date: Wed, 29 Apr 2026 15:39:14 +0200
Message-ID: <20260429133928.850721-13-pratyush@kernel.org>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
In-Reply-To: <20260429133928.850721-1-pratyush@kernel.org>
References: <20260429133928.850721-1-pratyush@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260429_064012_731494_E9E61AF4 
X-CRM114-Status: GOOD (  27.95  )
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

From: "Pratyush Yadav (Google)" <pratyush@kernel.org>

Gigantic page allocation is somewhat broken currently when KHO is used.

Firstly, they break KHO scratch size accounting. RSRV_KERN is used to
track how much memory is reserved for use by the kernel. Since
alloc_bootmem() calls the memblock_alloc*() APIs, the hugepages
allocated also get marked as RSRV_KERN.

Allocations marked RSRV_KERN are used by KHO to calculate how much
scratch space it should reserve to make sure the next kernel has enough
memory to boot when it is in scratch-only phase. Counting hugepages in
that blows up scratch size, and can lead to the scratch allocation
failing, making KHO unusable. This will show up when huge pages make up
more than 50% of the system, which is a fairly common use case.

Secondly, while not supported right now, huge pages are user memory and
can be preserved via KHO. The scratch spaces should not have any
preserved memory. Allocating hugepages from scratch (on a KHO boot) can
lead to them being un-preservable.

Introduce memblock_alloc_nid_user(). This does two things: first, it
instructs __memblock_alloc_range_nid() to not use scratch areas to
fulfill allocation. If KHO is in scratch-only mode, allocations will
only be made from extended scratch areas. Second, it removes RSRV_KERN
from the allocation to make sure it doesn't mess up scratch size
accounting.

To reduce duplication, introduce __memblock_alloc_range_nid() which does
exactly what memblock_alloc_range_nid() used to do, but takes the flags
from its caller. Then make memblock_alloc_range_nid() a wrapper to it.
This lets memblock_alloc_nid_user() re-use most of the logic without
causing churn to update all callers of memblock_alloc_range_nid() and
adding yet another argument to it.

Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>
---

Notes:
    Checkpatch complains here about the alignment of arguments of
    memblock_alloc_range_nid() with open parentheses. That can be ignored
    since the code already was mis-aligned, and for good reason.

 include/linux/memblock.h |   4 ++
 mm/hugetlb.c             |  19 ++----
 mm/memblock.c            | 138 ++++++++++++++++++++++++++++++---------
 3 files changed, 116 insertions(+), 45 deletions(-)

diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index 4f535ca4947a..c7056cf3f0f2 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -160,6 +160,7 @@ int memblock_mark_nomap(phys_addr_t base, phys_addr_t size);
 int memblock_clear_nomap(phys_addr_t base, phys_addr_t size);
 int memblock_reserved_mark_noinit(phys_addr_t base, phys_addr_t size);
 int memblock_reserved_mark_kern(phys_addr_t base, phys_addr_t size);
+int memblock_reserved_clear_kern(phys_addr_t base, phys_addr_t size);
 int memblock_mark_kho_scratch(phys_addr_t base, phys_addr_t size);
 int memblock_mark_kho_scratch_ext(phys_addr_t base, phys_addr_t size);
 int memblock_clear_kho_scratch(phys_addr_t base, phys_addr_t size);
@@ -431,6 +432,9 @@ void *memblock_alloc_try_nid(phys_addr_t size, phys_addr_t align,
 			     phys_addr_t min_addr, phys_addr_t max_addr,
 			     int nid);
 
+void *memblock_alloc_nid_user(phys_addr_t size, phys_addr_t align, int nid,
+			      bool exact_nid);
+
 static __always_inline void *memblock_alloc(phys_addr_t size, phys_addr_t align)
 {
 	return memblock_alloc_try_nid(size, align, MEMBLOCK_LOW_LIMIT,
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index f24bf49be047..5ba393b0a581 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3049,26 +3049,19 @@ static __init void *alloc_bootmem(struct hstate *h, int nid, bool node_exact)
 	if (hugetlb_early_cma(h))
 		m = hugetlb_cma_alloc_bootmem(h, &listnode, node_exact);
 	else {
-		if (node_exact)
-			m = memblock_alloc_exact_nid_raw(huge_page_size(h),
-				huge_page_size(h), 0,
-				MEMBLOCK_ALLOC_ACCESSIBLE, nid);
-		else {
-			m = memblock_alloc_try_nid_raw(huge_page_size(h),
-				huge_page_size(h), 0,
-				MEMBLOCK_ALLOC_ACCESSIBLE, nid);
+		m = memblock_alloc_nid_user(huge_page_size(h), huge_page_size(h),
+					    nid, node_exact);
+		if (m) {
 			/*
 			 * For pre-HVO to work correctly, pages need to be on
 			 * the list for the node they were actually allocated
 			 * from. That node may be different in the case of
-			 * fallback by memblock_alloc_try_nid_raw. So,
-			 * extract the actual node first.
+			 * fallback by memblock_alloc_try_nid_raw. So, extract
+			 * the actual node first.
 			 */
-			if (m)
+			if (node_exact)
 				listnode = early_pfn_to_nid(PHYS_PFN(__pa(m)));
-		}
 
-		if (m) {
 			m->flags = 0;
 			m->cma = NULL;
 		}
diff --git a/mm/memblock.c b/mm/memblock.c
index 79443e004361..504b5b0c8af7 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -178,11 +178,21 @@ bool __init_memblock memblock_has_mirror(void)
 	return system_has_some_mirror;
 }
 
-static enum memblock_flags __init_memblock choose_memblock_flags(void)
+static enum memblock_flags __init_memblock choose_memblock_flags(bool user)
 {
 	/* skip non-scratch memory for kho early boot allocations */
-	if (kho_scratch_only)
-		return MEMBLOCK_KHO_SCRATCH | MEMBLOCK_KHO_SCRATCH_EXT;
+	if (kho_scratch_only) {
+		enum memblock_flags flags = MEMBLOCK_KHO_SCRATCH_EXT;
+
+		/*
+		 * Scratch can only be used for kernel memory, since user memory
+		 * might be preserved and thus can not be in scratch.
+		 */
+		if (!user)
+			flags |= MEMBLOCK_KHO_SCRATCH;
+
+		return flags;
+	}
 
 	return system_has_some_mirror ? MEMBLOCK_MIRROR : MEMBLOCK_NONE;
 }
@@ -346,7 +356,7 @@ static phys_addr_t __init_memblock memblock_find_in_range(phys_addr_t start,
 					phys_addr_t align)
 {
 	phys_addr_t ret;
-	enum memblock_flags flags = choose_memblock_flags();
+	enum memblock_flags flags = choose_memblock_flags(false);
 
 again:
 	ret = memblock_find_in_range_node(size, align, start, end,
@@ -1173,6 +1183,20 @@ int __init_memblock memblock_reserved_mark_kern(phys_addr_t base, phys_addr_t si
 				    MEMBLOCK_RSRV_KERN);
 }
 
+/**
+ * memblock_reserved_clear_kern - Clear MEMBLOCK_RSRV_KERN flag for region
+ *
+ * @base: the base phys addr of the region
+ * @size: the size of the region
+ *
+ * Return: 0 on success, -errno on failure.
+ */
+int __init_memblock memblock_reserved_clear_kern(phys_addr_t base, phys_addr_t size)
+{
+	return memblock_setclr_flag(&memblock.reserved, base, size, 0,
+				    MEMBLOCK_RSRV_KERN);
+}
+
 /**
  * memblock_mark_kho_scratch - Mark a memory region as MEMBLOCK_KHO_SCRATCH.
  * @base: the base phys addr of the region
@@ -1532,37 +1556,11 @@ int __init_memblock memblock_set_node(phys_addr_t base, phys_addr_t size,
 	return 0;
 }
 
-/**
- * memblock_alloc_range_nid - allocate boot memory block
- * @size: size of memory block to be allocated in bytes
- * @align: alignment of the region and block's size
- * @start: the lower bound of the memory region to allocate (phys address)
- * @end: the upper bound of the memory region to allocate (phys address)
- * @nid: nid of the free area to find, %NUMA_NO_NODE for any node
- * @exact_nid: control the allocation fall back to other nodes
- *
- * The allocation is performed from memory region limited by
- * memblock.current_limit if @end == %MEMBLOCK_ALLOC_ACCESSIBLE.
- *
- * If the specified node can not hold the requested memory and @exact_nid
- * is false, the allocation falls back to any node in the system.
- *
- * For systems with memory mirroring, the allocation is attempted first
- * from the regions with mirroring enabled and then retried from any
- * memory region.
- *
- * In addition, function using kmemleak_alloc_phys for allocated boot
- * memory block, it is never reported as leaks.
- *
- * Return:
- * Physical address of allocated memory block on success, %0 on failure.
- */
-phys_addr_t __init memblock_alloc_range_nid(phys_addr_t size,
+static phys_addr_t __init __memblock_alloc_range_nid(phys_addr_t size,
 					phys_addr_t align, phys_addr_t start,
 					phys_addr_t end, int nid,
-					bool exact_nid)
+					bool exact_nid, enum memblock_flags flags)
 {
-	enum memblock_flags flags = choose_memblock_flags();
 	phys_addr_t found;
 
 	/*
@@ -1631,6 +1629,41 @@ phys_addr_t __init memblock_alloc_range_nid(phys_addr_t size,
 	return found;
 }
 
+/**
+ * memblock_alloc_range_nid - allocate boot memory block
+ * @size: size of memory block to be allocated in bytes
+ * @align: alignment of the region and block's size
+ * @start: the lower bound of the memory region to allocate (phys address)
+ * @end: the upper bound of the memory region to allocate (phys address)
+ * @nid: nid of the free area to find, %NUMA_NO_NODE for any node
+ * @exact_nid: control the allocation fall back to other nodes
+ *
+ * The allocation is performed from memory region limited by
+ * memblock.current_limit if @end == %MEMBLOCK_ALLOC_ACCESSIBLE.
+ *
+ * If the specified node can not hold the requested memory and @exact_nid
+ * is false, the allocation falls back to any node in the system.
+ *
+ * For systems with memory mirroring, the allocation is attempted first
+ * from the regions with mirroring enabled and then retried from any
+ * memory region.
+ *
+ * In addition, function using kmemleak_alloc_phys for allocated boot
+ * memory block, it is never reported as leaks.
+ *
+ * Return:
+ * Physical address of allocated memory block on success, %0 on failure.
+ */
+phys_addr_t __init memblock_alloc_range_nid(phys_addr_t size,
+					phys_addr_t align, phys_addr_t start,
+					phys_addr_t end, int nid,
+					bool exact_nid)
+{
+	enum memblock_flags flags = choose_memblock_flags(false);
+
+	return __memblock_alloc_range_nid(size, align, start, end, nid, exact_nid, flags);
+}
+
 /**
  * memblock_phys_alloc_range - allocate a memory block inside specified range
  * @size: size of memory block to be allocated in bytes
@@ -1782,6 +1815,47 @@ void * __init memblock_alloc_try_nid_raw(
 				       false);
 }
 
+/**
+ * memblock_alloc_nid_user - allocate boot memory for use by userspace
+ * @size: size of the memory block to be allocated in bytes
+ * @align: alignment of the region and block's size
+ * @exact_nid: control the allocation fall back to other nodes
+ *
+ * Public function, provides additional debug information (including caller
+ * info), if enabled. Does not zero allocated memory, does not panic if request
+ * cannot be satisfied.
+ *
+ * If the specified node can not hold the requested memory and @exact_nid is
+ * false, the allocation falls back to any node in the system. The allocated
+ * memory has no restrictions on minimum or maximum address, and does not count
+ * towards %MEMBLOCK_RSRV_KERN.
+ *
+ * Return:
+ * Virtual address of allocated memory block on success, %NULL on failure.
+ */
+void * __init memblock_alloc_nid_user(phys_addr_t size, phys_addr_t align,
+				      int nid, bool exact_nid)
+{
+	enum memblock_flags flags = choose_memblock_flags(true);
+	phys_addr_t alloc;
+
+	memblock_dbg("%s: %llu bytes align=0x%llx nid=%d %pS\n",
+		     __func__, (u64)size, (u64)align, nid, (void *)_RET_IP_);
+
+	alloc = __memblock_alloc_range_nid(size, align, 0, MEMBLOCK_ALLOC_ACCESSIBLE,
+					   nid, exact_nid, flags);
+	if (!alloc)
+		return NULL;
+
+	/* User memory should not be marked with RSRV_KERN. */
+	if (memblock_reserved_clear_kern(alloc, size)) {
+		memblock_phys_free(alloc, size);
+		return NULL;
+	}
+
+	return phys_to_virt(alloc);
+}
+
 /**
  * memblock_alloc_try_nid - allocate boot memory block
  * @size: size of memory block to be allocated in bytes
-- 
2.54.0.545.g6539524ca2-goog


