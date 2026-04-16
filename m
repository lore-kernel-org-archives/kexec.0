Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B684F8A15E
	for <kexec@archiver.kernel.org>; Thu, 16 Apr 2026 11:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=v5dV2LMJtAOOBBBsjxKBUavRi9Ccqee2XzO+Iu2tpbA=; b=iPDZ8rEkpZU6hBINgxxY6DVHCK
	Ae5+cNxIssTA1UQVZ6vy0DZY8M1a4Wgbg4IcmOdYDr9RdyFyB1KIjL+ceI3aDL0GVvwETkSH+DW+5
	H4HSFoRLFXRV4WfBzfLEeG2Dgnqi1xcFIs+H442OjV1WHn2/iqhyWgqTVwJtQsbpHSSJxAD93yDFs
	hDOVHS5DgEv8+DYe0kDcxt8DuW2dMb+qjuW8IpCfHleyL48Wm1GdwaaujASTRqJ2tkR66XAQ1JT+X
	09Nhy3oVshz5C1cnXbEQF2FJPtnypV75pYDfLN9hlel/0fTvgfVV0Kf4jC7Um96q1z277Uj/rBif/
	cFbYgQtw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDKYv-00000002LVc-2i9d;
	Thu, 16 Apr 2026 11:07:09 +0000
Received: from mail-lf1-x149.google.com ([2a00:1450:4864:20::149])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDKYs-00000002LUO-2nls
	for kexec@lists.infradead.org;
	Thu, 16 Apr 2026 11:07:07 +0000
Received: by mail-lf1-x149.google.com with SMTP id 2adb3069b0e04-5a2a203916cso5203960e87.3
        for <kexec@lists.infradead.org>; Thu, 16 Apr 2026 04:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776337624; x=1776942424; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=v5dV2LMJtAOOBBBsjxKBUavRi9Ccqee2XzO+Iu2tpbA=;
        b=fUFyyGX2VkqgxhxpDCumhn18zD5u6C9MOopPv6xopUvjomA6DZ10mR5kA/EQJDfRRk
         sdLEroIt6s3w2j3O+vrbTg8xgSMXxleolqQqk2+opp1etWWCubTxEmBWsDtfCk67zKDV
         6SxFTefFZWfZF5ZqZomfum1AgOhg4/q8DYToUO6gYH6QYKsdkRXenXOU0fDrKVNeAQ6l
         U6gIqYPXfSOsex0VOklJWuZKau7qKHjdcYhHIqsmyBoQqzxThwM0lDmyQZ+N39v8H5Dz
         u+UMMvA3A/07myTq3AisqDKfUeiYwVhDooGb/uE84BnfDgIdJpTF+FcQtWawi8m8g8FW
         lmlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776337624; x=1776942424;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v5dV2LMJtAOOBBBsjxKBUavRi9Ccqee2XzO+Iu2tpbA=;
        b=tXnzfdDEFl9X3/qFmxPL7NFxB5UdfVm8/B+CBjBMlCLhDKsBWiji7NSvZLB43L7Gq/
         QnRBDsKlrXRSnd2UlVL12m/6Zymj/9E7QS4L/aVLbZEZ+7vaNHOIZITEY3oJfawIm7mq
         CwzayNJTRpqoROA+CrjbdA4A2BSb3x34njw7ETAG3sulUZmEq881JMxEV4yaBOMkXMHr
         THy/btvMtV6OslXnkarqQoo2n+2KXmUwIsBQnNYqpF0hkl/B9ZaYm7umkjg/Rw/U+q3D
         XzlTOTZdna4XyoeTb2g/EsShIdcpaUCZrDQl0lYhv2DBfGOZ/hdJKCAGHgNwklPbSDYy
         +ayg==
X-Forwarded-Encrypted: i=1; AFNElJ8coCV5wGjFcQJDyzSd2+wvmu/2LR/2ofqijPMrecHOmsFOWjtCPdEaIFhOnyJFibw+0z+6gA==@lists.infradead.org
X-Gm-Message-State: AOJu0YxsjJITMp8X40TVmJJYuX01gHBBN9eU7YrziPoQRB/TzBTZHjzQ
	Oc4g3UxQPfwEsfSWqkUtFmgVxuss1zfMxpwy9JUNsyLAmnORI9AgPMAJL51AAMC8wl6UbNaZ8dd
	Lt/Am4EKv5zyCqWWODqa9RQ==
X-Received: from lfe15.prod.google.com ([2002:a05:6512:290f:b0:5a4:5d8:6190])
 (user=mclapinski job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6512:2252:b0:5a4:d21:de07 with SMTP id 2adb3069b0e04-5a40d21de29mr1675847e87.1.1776337623788;
 Thu, 16 Apr 2026 04:07:03 -0700 (PDT)
Date: Thu, 16 Apr 2026 13:06:53 +0200
In-Reply-To: <20260416110654.247398-1-mclapinski@google.com>
Mime-Version: 1.0
References: <20260416110654.247398-1-mclapinski@google.com>
X-Mailer: git-send-email 2.54.0.rc1.555.g9c883467ad-goog
Message-ID: <20260416110654.247398-2-mclapinski@google.com>
Subject: [PATCH v8 1/2] kho: fix deferred initialization of scratch areas
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
X-CRM114-CacheID: sfid-20260416_040706_749970_6EEA241C 
X-CRM114-Status: GOOD (  18.59  )
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
memmap_init_reserved_range() recognize KHO scratch regions and set
migratetype of pageblocks in those regions to MIGRATE_CMA.

Signed-off-by: Michal Clapinski <mclapinski@google.com>
Co-developed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 include/linux/memblock.h           |  7 +++--
 kernel/liveupdate/kexec_handover.c | 25 ------------------
 mm/memblock.c                      | 41 ++++++++++++++----------------
 mm/mm_init.c                       | 27 ++++++++++++++------
 4 files changed, 43 insertions(+), 57 deletions(-)

diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index 6ec5e9ac0699..410f2a399691 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -614,11 +614,14 @@ static inline void memtest_report_meminfo(struct seq_file *m) { }
 #ifdef CONFIG_MEMBLOCK_KHO_SCRATCH
 void memblock_set_kho_scratch_only(void);
 void memblock_clear_kho_scratch_only(void);
-void memmap_init_kho_scratch_pages(void);
+bool memblock_is_kho_scratch_memory(phys_addr_t addr);
 #else
 static inline void memblock_set_kho_scratch_only(void) { }
 static inline void memblock_clear_kho_scratch_only(void) { }
-static inline void memmap_init_kho_scratch_pages(void) {}
+static inline bool memblock_is_kho_scratch_memory(phys_addr_t addr)
+{
+	return false;
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
index 4224fdaa8918..fab234f732c3 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -17,6 +17,7 @@
 #include <linux/seq_file.h>
 #include <linux/memblock.h>
 #include <linux/mutex.h>
+#include <linux/page-isolation.h>
 
 #ifdef CONFIG_KEXEC_HANDOVER
 #include <linux/libfdt.h>
@@ -959,28 +960,6 @@ __init void memblock_clear_kho_scratch_only(void)
 {
 	kho_scratch_only = false;
 }
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
 #endif
 
 /**
@@ -1971,6 +1950,18 @@ bool __init_memblock memblock_is_map_memory(phys_addr_t addr)
 	return !memblock_is_nomap(&memblock.memory.regions[i]);
 }
 
+#ifdef CONFIG_MEMBLOCK_KHO_SCRATCH
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
 int __init_memblock memblock_search_pfn_nid(unsigned long pfn,
 			 unsigned long *start_pfn, unsigned long *end_pfn)
 {
@@ -2262,6 +2253,12 @@ static void __init memmap_init_reserved_range(phys_addr_t start,
 		 * access it yet.
 		 */
 		__SetPageReserved(page);
+
+#ifdef CONFIG_MEMBLOCK_KHO_SCRATCH
+		if (memblock_is_kho_scratch_memory(PFN_PHYS(pfn)) &&
+		    pageblock_aligned(pfn))
+			init_pageblock_migratetype(page, MIGRATE_CMA, false);
+#endif
 	}
 }
 
diff --git a/mm/mm_init.c b/mm/mm_init.c
index f9f8e1af921c..890c3ae21ba0 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -916,8 +916,15 @@ void __meminit memmap_init_range(unsigned long size, int nid, unsigned long zone
 		 * over the place during system boot.
 		 */
 		if (pageblock_aligned(pfn)) {
-			init_pageblock_migratetype(page, migratetype,
-					isolate_pageblock);
+			int mt = migratetype;
+
+#ifdef CONFIG_MEMBLOCK_KHO_SCRATCH
+			if (memblock_is_kho_scratch_memory(page_to_phys(page)))
+				mt = MIGRATE_CMA;
+#endif
+
+			init_pageblock_migratetype(page, mt,
+						   isolate_pageblock);
 			cond_resched();
 		}
 		pfn++;
@@ -1970,7 +1977,7 @@ unsigned long __init node_map_pfn_alignment(void)
 
 #ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
 static void __init deferred_free_pages(unsigned long pfn,
-		unsigned long nr_pages)
+		unsigned long nr_pages, enum migratetype mt)
 {
 	struct page *page;
 	unsigned long i;
@@ -1983,8 +1990,7 @@ static void __init deferred_free_pages(unsigned long pfn,
 	/* Free a large naturally-aligned chunk if possible */
 	if (nr_pages == MAX_ORDER_NR_PAGES && IS_MAX_ORDER_ALIGNED(pfn)) {
 		for (i = 0; i < nr_pages; i += pageblock_nr_pages)
-			init_pageblock_migratetype(page + i, MIGRATE_MOVABLE,
-					false);
+			init_pageblock_migratetype(page + i, mt, false);
 		__free_pages_core(page, MAX_PAGE_ORDER, MEMINIT_EARLY);
 		return;
 	}
@@ -1994,8 +2000,7 @@ static void __init deferred_free_pages(unsigned long pfn,
 
 	for (i = 0; i < nr_pages; i++, page++, pfn++) {
 		if (pageblock_aligned(pfn))
-			init_pageblock_migratetype(page, MIGRATE_MOVABLE,
-					false);
+			init_pageblock_migratetype(page, mt, false);
 		__free_pages_core(page, 0, MEMINIT_EARLY);
 	}
 }
@@ -2051,6 +2056,7 @@ deferred_init_memmap_chunk(unsigned long start_pfn, unsigned long end_pfn,
 	u64 i = 0;
 
 	for_each_free_mem_range(i, nid, 0, &start, &end, NULL) {
+		enum migratetype mt = MIGRATE_MOVABLE;
 		unsigned long spfn = PFN_UP(start);
 		unsigned long epfn = PFN_DOWN(end);
 
@@ -2060,12 +2066,17 @@ deferred_init_memmap_chunk(unsigned long start_pfn, unsigned long end_pfn,
 		spfn = max(spfn, start_pfn);
 		epfn = min(epfn, end_pfn);
 
+#ifdef CONFIG_MEMBLOCK_KHO_SCRATCH
+		if (memblock_is_kho_scratch_memory(PFN_PHYS(spfn)))
+			mt = MIGRATE_CMA;
+#endif
+
 		while (spfn < epfn) {
 			unsigned long mo_pfn = ALIGN(spfn + 1, MAX_ORDER_NR_PAGES);
 			unsigned long chunk_end = min(mo_pfn, epfn);
 
 			nr_pages += deferred_init_pages(zone, spfn, chunk_end);
-			deferred_free_pages(spfn, chunk_end - spfn);
+			deferred_free_pages(spfn, chunk_end - spfn, mt);
 
 			spfn = chunk_end;
 
-- 
2.54.0.rc1.555.g9c883467ad-goog


