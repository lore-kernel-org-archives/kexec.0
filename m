Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4155BF589AF
	for <kexec@archiver.kernel.org>; Thu, 23 Apr 2026 12:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=n+Dh7KSlcp6Lw1KRHGg/D7cc8wD+JiYC9HaMh3gpNxs=; b=L04eXw1LwaJDEeaJWzBgvA06Wo
	7LU57zNJ+M1P15knTNvgjIym6XxOo9VaXG5oD5BZfBmtNm2Eu+8xNnVoYkvoe0f+gvLLS8ZPRBpaV
	Qavdv+Oj5YHVYaKM/I2OaNl4iW1qQAUSjS7TLJkYicnu/fszUaMePEQ/LOiukGajaZYCDmmco5fhd
	7IlfoVu5ihcA9neSx+edvV6mG5IuDaqaqOh/YnJ9TAuWYqJLkYS+Ho5aueCgjpbvzewRPLTRLGyRh
	LwBwxUPHJZBtooOyodLQFLKsBQD7jwOh8NHLw909XWopkgrwN+cruvFCYhS3+FXH+LMI3g1SfseqI
	ylJl9Siw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wFt7z-0000000Bc05-1qUc;
	Thu, 23 Apr 2026 12:25:55 +0000
Received: from mail-ej1-x649.google.com ([2a00:1450:4864:20::649])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wFt7t-0000000Bbxm-23Cv
	for kexec@lists.infradead.org;
	Thu, 23 Apr 2026 12:25:54 +0000
Received: by mail-ej1-x649.google.com with SMTP id a640c23a62f3a-b8ff07df5e4so533140366b.3
        for <kexec@lists.infradead.org>; Thu, 23 Apr 2026 05:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776947146; x=1777551946; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=n+Dh7KSlcp6Lw1KRHGg/D7cc8wD+JiYC9HaMh3gpNxs=;
        b=Fs5CgV+RHq3E8MIh2S+3wLcSzBsuk4SbRx53FDsJll0CGLROW3guAL1eZqj8VylJQR
         3sAcS9VR4uKtVqyQyUh/EGoWh73+YlzqW6ve0odfpTYHclvaPgDjYy70ZBnwnSikqeAy
         qFp1lk8JOOv54euJDsx1v8ebOwy8zO4X/08tstIkyzhx247e2JA7QAwpFmr6Z50PNOVP
         bYi7yErtsjjObr4o71SXvBBRURgl0oEoMCjKPtHV3HiH6gXg/ain+XHb7zIZP3/FnX3q
         +BtwrxR4K5NhE4dKgY64UOTtgoUTYNSo3tnYQ1ssaQhxSKX+hWVyRWaeDMdG5+q4Hj1V
         sU8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776947146; x=1777551946;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n+Dh7KSlcp6Lw1KRHGg/D7cc8wD+JiYC9HaMh3gpNxs=;
        b=OWX4x+sBwH2MoBduycmgC8Q/AasEU9RokjGpOCmBnZw9ZzYxUXhiv5xLClwfMKNmhv
         7F4g0bJOBRaRDqz21vbt8chYcR9sSBL1/d77y+2/AxLMTW0C9UdW+gMuKyvdnZvx4O/5
         UpUJ5e82OGVs8r+UAyG06yU+0cDc4whYgp0VVjHcQlB13nPLW14lHG9c1I1tMVKEyyKW
         CHW35K4IVWDjvyhAthg2pNargGLfmTbp4m8roCC03cL2fIuVkXra2B35HHsVEZuuagiB
         iFkzr0USFqnUgrNp0NA3NIkXS3Fx2KqN5j5WbWOxohw9ykI/Tu1YS8zxQmDuBBZM6d2R
         id0w==
X-Forwarded-Encrypted: i=1; AFNElJ+7/meBkAx+EB2rn03jw9u/TfbnOJrKsJfVnffm2DoG6JxXqX85V6ABs9btnh5OAVzhU4Ba9Q==@lists.infradead.org
X-Gm-Message-State: AOJu0YznFdrwq0K+rO7cMYsXbz2a4Ag3TufpSgcLSixNaTD/r3JznTmp
	zW20UlKhgbA7Sbe1ofs+p+zTCZJZ0BN12Z9Vs81tWwQ8ug5IM+7vk0ucmzRu+Gjq/tOVjm6Zoiy
	XXZFBrJbhuscA1XnKPPHB5w==
X-Received: from ejchd40.prod.google.com ([2002:a17:907:96a8:b0:b9c:3f30:f4d9])
 (user=mclapinski job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:d03:b0:baa:2d37:cbf9 with SMTP id a640c23a62f3a-baa2d37ce1bmr465780066b.1.1776947145985;
 Thu, 23 Apr 2026 05:25:45 -0700 (PDT)
Date: Thu, 23 Apr 2026 14:25:36 +0200
In-Reply-To: <20260423122538.140993-1-mclapinski@google.com>
Mime-Version: 1.0
References: <20260423122538.140993-1-mclapinski@google.com>
X-Mailer: git-send-email 2.54.0.rc2.533.g4f5dca5207-goog
Message-ID: <20260423122538.140993-2-mclapinski@google.com>
Subject: [PATCH v9 1/3] kho: fix deferred initialization of scratch areas
From: Michal Clapinski <mclapinski@google.com>
To: Evangelos Petrongonas <epetron@amazon.de>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Mike Rapoport <rppt@kernel.org>, Pratyush Yadav <pratyush@kernel.org>, Alexander Graf <graf@amazon.com>, 
	Samiullah Khawaja <skhawaja@google.com>, kexec@lists.infradead.org, linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Brendan Jackman <jackmanb@google.com>, Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
	Michal Clapinski <mclapinski@google.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260423_052549_572271_8F33A8F1 
X-CRM114-Status: GOOD (  18.26  )
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

Currently, if CONFIG_DEFERRED_STRUCT_PAGE_INIT is enabled,
kho_release_scratch() will initialize the struct pages and set migratetype
of KHO scratch. Unless the whole scratch fits below first_deferred_pfn,
some of that will be overwritten either by deferred_init_pages() or
memmap_init_reserved_range().

To fix it, make memmap_init_range(), deferred_init_memmap_chunk() and
__init_page_from_nid() recognize KHO scratch regions and set
migratetype of pageblocks in those regions to MIGRATE_CMA.

Co-developed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Signed-off-by: Michal Clapinski <mclapinski@google.com>
---
 include/linux/memblock.h           | 21 +++++++++--
 kernel/liveupdate/kexec_handover.c | 25 -------------
 mm/memblock.c                      | 56 ++++++++++++------------------
 mm/mm_init.c                       | 30 +++++++++-------
 4 files changed, 58 insertions(+), 74 deletions(-)

diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index b0f750d22a7b..5afcd99aa8c1 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -613,11 +613,28 @@ static inline void memtest_report_meminfo(struct seq_file *m) { }
 #ifdef CONFIG_MEMBLOCK_KHO_SCRATCH
 void memblock_set_kho_scratch_only(void);
 void memblock_clear_kho_scratch_only(void);
-void memmap_init_kho_scratch_pages(void);
+bool memblock_is_kho_scratch_memory(phys_addr_t addr);
+
+static inline enum migratetype kho_scratch_migratetype(unsigned long pfn,
+						       enum migratetype mt)
+{
+	if (memblock_is_kho_scratch_memory(PFN_PHYS(pfn)))
+		return MIGRATE_CMA;
+	return mt;
+}
 #else
 static inline void memblock_set_kho_scratch_only(void) { }
 static inline void memblock_clear_kho_scratch_only(void) { }
-static inline void memmap_init_kho_scratch_pages(void) {}
+static inline bool memblock_is_kho_scratch_memory(phys_addr_t addr)
+{
+	return false;
+}
+
+static inline enum migratetype kho_scratch_migratetype(unsigned long pfn,
+						       enum migratetype mt)
+{
+	return mt;
+}
 #endif
 
 #endif /* _LINUX_MEMBLOCK_H */
diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index 18509d8082ea..a507366a2cf9 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -1576,35 +1576,10 @@ static __init int kho_init(void)
 }
 fs_initcall(kho_init);
 
-static void __init kho_release_scratch(void)
-{
-	phys_addr_t start, end;
-	u64 i;
-
-	memmap_init_kho_scratch_pages();
-
-	/*
-	 * Mark scratch mem as CMA before we return it. That way we
-	 * ensure that no kernel allocations happen on it. That means
-	 * we can reuse it as scratch memory again later.
-	 */
-	__for_each_mem_range(i, &memblock.memory, NULL, NUMA_NO_NODE,
-			     MEMBLOCK_KHO_SCRATCH, &start, &end, NULL) {
-		ulong start_pfn = pageblock_start_pfn(PFN_DOWN(start));
-		ulong end_pfn = pageblock_align(PFN_UP(end));
-		ulong pfn;
-
-		for (pfn = start_pfn; pfn < end_pfn; pfn += pageblock_nr_pages)
-			init_pageblock_migratetype(pfn_to_page(pfn),
-						   MIGRATE_CMA, false);
-	}
-}
-
 void __init kho_memory_init(void)
 {
 	if (kho_in.scratch_phys) {
 		kho_scratch = phys_to_virt(kho_in.scratch_phys);
-		kho_release_scratch();
 
 		if (kho_mem_retrieve(kho_get_fdt()))
 			kho_in.fdt_phys = 0;
diff --git a/mm/memblock.c b/mm/memblock.c
index a6a1c91e276d..01a962681726 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -1026,40 +1026,6 @@ int __init_memblock memblock_physmem_add(phys_addr_t base, phys_addr_t size)
 }
 #endif
 
-#ifdef CONFIG_MEMBLOCK_KHO_SCRATCH
-__init void memblock_set_kho_scratch_only(void)
-{
-	kho_scratch_only = true;
-}
-
-__init void memblock_clear_kho_scratch_only(void)
-{
-	kho_scratch_only = false;
-}
-
-__init void memmap_init_kho_scratch_pages(void)
-{
-	phys_addr_t start, end;
-	unsigned long pfn;
-	int nid;
-	u64 i;
-
-	if (!IS_ENABLED(CONFIG_DEFERRED_STRUCT_PAGE_INIT))
-		return;
-
-	/*
-	 * Initialize struct pages for free scratch memory.
-	 * The struct pages for reserved scratch memory will be set up in
-	 * memmap_init_reserved_pages()
-	 */
-	__for_each_mem_range(i, &memblock.memory, NULL, NUMA_NO_NODE,
-			     MEMBLOCK_KHO_SCRATCH, &start, &end, &nid) {
-		for (pfn = PFN_UP(start); pfn < PFN_DOWN(end); pfn++)
-			init_deferred_page(pfn, nid);
-	}
-}
-#endif
-
 /**
  * memblock_setclr_flag - set or clear flag for a memory region
  * @type: memblock type to set/clear flag for
@@ -2533,6 +2499,28 @@ int reserve_mem_release_by_name(const char *name)
 	return 1;
 }
 
+#ifdef CONFIG_MEMBLOCK_KHO_SCRATCH
+__init void memblock_set_kho_scratch_only(void)
+{
+	kho_scratch_only = true;
+}
+
+__init void memblock_clear_kho_scratch_only(void)
+{
+	kho_scratch_only = false;
+}
+
+bool __init_memblock memblock_is_kho_scratch_memory(phys_addr_t addr)
+{
+	int i = memblock_search(&memblock.memory, addr);
+
+	if (i == -1)
+		return false;
+
+	return memblock_is_kho_scratch(&memblock.memory.regions[i]);
+}
+#endif
+
 #ifdef CONFIG_KEXEC_HANDOVER
 
 static int __init reserved_mem_preserve(void)
diff --git a/mm/mm_init.c b/mm/mm_init.c
index f9f8e1af921c..eddc0f03a779 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -692,9 +692,11 @@ void __meminit __init_page_from_nid(unsigned long pfn, int nid)
 	}
 	__init_single_page(pfn_to_page(pfn), pfn, zid, nid);
 
-	if (pageblock_aligned(pfn))
-		init_pageblock_migratetype(pfn_to_page(pfn), MIGRATE_MOVABLE,
-				false);
+	if (pageblock_aligned(pfn)) {
+		enum migratetype mt =
+			kho_scratch_migratetype(pfn, MIGRATE_MOVABLE);
+		init_pageblock_migratetype(pfn_to_page(pfn), mt, false);
+	}
 }
 
 #ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
@@ -927,7 +929,8 @@ void __meminit memmap_init_range(unsigned long size, int nid, unsigned long zone
 static void __init memmap_init_zone_range(struct zone *zone,
 					  unsigned long start_pfn,
 					  unsigned long end_pfn,
-					  unsigned long *hole_pfn)
+					  unsigned long *hole_pfn,
+					  enum migratetype mt)
 {
 	unsigned long zone_start_pfn = zone->zone_start_pfn;
 	unsigned long zone_end_pfn = zone_start_pfn + zone->spanned_pages;
@@ -940,8 +943,7 @@ static void __init memmap_init_zone_range(struct zone *zone,
 		return;
 
 	memmap_init_range(end_pfn - start_pfn, nid, zone_id, start_pfn,
-			  zone_end_pfn, MEMINIT_EARLY, NULL, MIGRATE_MOVABLE,
-			  false);
+			  zone_end_pfn, MEMINIT_EARLY, NULL, mt, false);
 
 	if (*hole_pfn < start_pfn)
 		init_unavailable_range(*hole_pfn, start_pfn, zone_id, nid);
@@ -957,6 +959,8 @@ static void __init memmap_init(void)
 
 	for_each_mem_pfn_range(i, MAX_NUMNODES, &start_pfn, &end_pfn, &nid) {
 		struct pglist_data *node = NODE_DATA(nid);
+		enum migratetype mt =
+			kho_scratch_migratetype(start_pfn, MIGRATE_MOVABLE);
 
 		for (j = 0; j < MAX_NR_ZONES; j++) {
 			struct zone *zone = node->node_zones + j;
@@ -965,7 +969,7 @@ static void __init memmap_init(void)
 				continue;
 
 			memmap_init_zone_range(zone, start_pfn, end_pfn,
-					       &hole_pfn);
+					       &hole_pfn, mt);
 			zone_id = j;
 		}
 	}
@@ -1970,7 +1974,7 @@ unsigned long __init node_map_pfn_alignment(void)
 
 #ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
 static void __init deferred_free_pages(unsigned long pfn,
-		unsigned long nr_pages)
+		unsigned long nr_pages, enum migratetype mt)
 {
 	struct page *page;
 	unsigned long i;
@@ -1983,8 +1987,7 @@ static void __init deferred_free_pages(unsigned long pfn,
 	/* Free a large naturally-aligned chunk if possible */
 	if (nr_pages == MAX_ORDER_NR_PAGES && IS_MAX_ORDER_ALIGNED(pfn)) {
 		for (i = 0; i < nr_pages; i += pageblock_nr_pages)
-			init_pageblock_migratetype(page + i, MIGRATE_MOVABLE,
-					false);
+			init_pageblock_migratetype(page + i, mt, false);
 		__free_pages_core(page, MAX_PAGE_ORDER, MEMINIT_EARLY);
 		return;
 	}
@@ -1994,8 +1997,7 @@ static void __init deferred_free_pages(unsigned long pfn,
 
 	for (i = 0; i < nr_pages; i++, page++, pfn++) {
 		if (pageblock_aligned(pfn))
-			init_pageblock_migratetype(page, MIGRATE_MOVABLE,
-					false);
+			init_pageblock_migratetype(page, mt, false);
 		__free_pages_core(page, 0, MEMINIT_EARLY);
 	}
 }
@@ -2053,6 +2055,8 @@ deferred_init_memmap_chunk(unsigned long start_pfn, unsigned long end_pfn,
 	for_each_free_mem_range(i, nid, 0, &start, &end, NULL) {
 		unsigned long spfn = PFN_UP(start);
 		unsigned long epfn = PFN_DOWN(end);
+		enum migratetype mt =
+			kho_scratch_migratetype(spfn, MIGRATE_MOVABLE);
 
 		if (spfn >= end_pfn)
 			break;
@@ -2065,7 +2069,7 @@ deferred_init_memmap_chunk(unsigned long start_pfn, unsigned long end_pfn,
 			unsigned long chunk_end = min(mo_pfn, epfn);
 
 			nr_pages += deferred_init_pages(zone, spfn, chunk_end);
-			deferred_free_pages(spfn, chunk_end - spfn);
+			deferred_free_pages(spfn, chunk_end - spfn, mt);
 
 			spfn = chunk_end;
 
-- 
2.54.0.rc2.533.g4f5dca5207-goog


