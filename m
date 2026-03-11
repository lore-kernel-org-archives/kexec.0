Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1368F1062899
	for <kexec@archiver.kernel.org>; Wed, 11 Mar 2026 12:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TW0km3bXDENe5wGoGb6FEEMiWhpRGEIF35PCM40YhbE=; b=sc2lSFUG97DcIKxktYkTNftib9
	LfGe/EDGTVeTYDM7t5p6A1kiG6229uWYS6IFuDSlDu+8wwS86LWZji6JSbSlCZvfoje9sSkeH1kZb
	LoDrv6sNdMW6LCnZ3qly0rY2rHEm9olAXu6sGHJTbmKf7NG4q1QG65crnEHmeOWq9ia6qxy3q46RN
	bnFglHf4+Z5p012Kp3ArIycJ5NJ+0Aak4mZFN3u9bUHfmj58xBob4xraQrBS9oyu4lafynEUNKj4T
	iiV9g0j5ATgBRkvejOVJGw4wq6ai+yL+4lSTwDHG+Q7vdvNhMWJuJzRiWt1XZ3OCsAuuMj0QBfgPS
	WfTPcnHQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0J6U-0000000BbN8-4AG3;
	Wed, 11 Mar 2026 12:55:58 +0000
Received: from mail-ej1-x649.google.com ([2a00:1450:4864:20::649])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0J6Q-0000000BbLb-23sq
	for kexec@lists.infradead.org;
	Wed, 11 Mar 2026 12:55:55 +0000
Received: by mail-ej1-x649.google.com with SMTP id a640c23a62f3a-b941d4b7f2cso563822566b.1
        for <kexec@lists.infradead.org>; Wed, 11 Mar 2026 05:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773233752; x=1773838552; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TW0km3bXDENe5wGoGb6FEEMiWhpRGEIF35PCM40YhbE=;
        b=J/1YDshn91UBt8tQ4nlo7YsGJud3p2LRfvxMskZX5YXk8EVXqHjyREjRM1QqP94Bko
         My8CvEfA/nxp5g30Nk3G4K9P2kjm9D5wvE7nVtC8iWvaULTozsMhBqba9HiVO7s4pYct
         oqkLBF/VhKKgEARDUrqByi0kunun7wR7IMuqCOZ8a+jZz02671EoSO5g+GBZGui03RYB
         OLEzAOBLLldx0dFczTUUKg8VClQJrTQrquuPFFV0MrnP7oWvDBXNIGXAfSqps3oYLj6u
         548cA6T+YvHlh+hpRdueT6GxGgQBk0niwOJYU5FQ8EU0hi5zu0v3fbMzahZemMeVaoLV
         4h4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773233752; x=1773838552;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TW0km3bXDENe5wGoGb6FEEMiWhpRGEIF35PCM40YhbE=;
        b=V/F4FD+G+NdfthJQrblGEuq7fC68bO7G4j041Wi4/p/KeShUsVOVRYu67Y5d1jghsD
         Ehm6arOU4eGj/aLa+AlJVGwey3SUpGHJexO0Bcpa3Y6eQT+L0wc06qa3dKu9wfqbIw3D
         zzBXHii1z081JzQ304WNhaS8m4f3rSY006lpEAo7A7PUe8XwQhE5v3j+59PSHl9/G9F1
         gy0SMBjTJWsyUK1W7Qmi30eRzguvFk7vi7lPiOiEcGBl0GsM4DeS0rsc+JMQg3RpRhcz
         9y8OkKS9m5yFs0FYKRiK/aWjnh2Rqb/Wes0lG9MrOdnarAK2VPHUoKs1lJIheAtGzSUI
         +5hA==
X-Forwarded-Encrypted: i=1; AJvYcCXhV+dhGE4HqY+w8mIec3BhlX+jrDytgfF76u6qr3I8v06vVyo8FqsqQlgz1l1nOWY7eJ2s9Q==@lists.infradead.org
X-Gm-Message-State: AOJu0Yy1C1cUtirJ9v80zi9WhoLWAf8xmyrZGcQjov7QnylWGg2BJ6N2
	n8KNVXWOtqsDAe+Zq8gfkQLL6pDa2bUshnbsYY8iJbkFj9OBXOjyo4b30dBh5W/SnYMGZTI7ipO
	kITWoIOexTlIq/UEbNg9l5A==
X-Received: from edfg22-n1.prod.google.com ([2002:a05:6402:a256:10b0:65c:72cb:9cb6])
 (user=mclapinski job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:7286:b0:b88:5e32:5357 with SMTP id a640c23a62f3a-b972e5ae4e0mr140513666b.59.1773233751844;
 Wed, 11 Mar 2026 05:55:51 -0700 (PDT)
Date: Wed, 11 Mar 2026 13:55:38 +0100
In-Reply-To: <20260311125539.4123672-1-mclapinski@google.com>
Mime-Version: 1.0
References: <20260311125539.4123672-1-mclapinski@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260311125539.4123672-2-mclapinski@google.com>
Subject: [PATCH v6 1/2] kho: fix deferred init of kho scratch
From: Michal Clapinski <mclapinski@google.com>
To: Evangelos Petrongonas <epetron@amazon.de>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Mike Rapoport <rppt@kernel.org>, Pratyush Yadav <pratyush@kernel.org>, Alexander Graf <graf@amazon.com>, 
	Samiullah Khawaja <skhawaja@google.com>, kexec@lists.infradead.org, linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	Michal Clapinski <mclapinski@google.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260311_055554_565044_EC6D62CA 
X-CRM114-Status: GOOD (  21.85  )
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

Currently, if DEFERRED is enabled, kho_release_scratch will initialize
the struct pages and set migratetype of kho scratch. Unless the whole
scratch fit below first_deferred_pfn, some of that will be overwritten
either by deferred_init_pages or memmap_init_reserved_pages.

To fix it, I initialize kho scratch early and modify every other
path to leave the scratch alone.

In detail:
1. Modify deferred_init_memmap_chunk to not initialize kho
scratch, since we already did that. Then, modify deferred_free_pages
to not set the migratetype. Also modify reserve_bootmem_region to skip
initializing kho scratch.

2. Since kho scratch is now not initialized by any other code, we have
to initialize it ourselves also on cold boot. On cold boot memblock
doesn't mark scratch as scratch, so we also have to modify the
initialization function to not use memblock regions.

Signed-off-by: Michal Clapinski <mclapinski@google.com>
---
My previous idea of marking scratch as CMA late, after deferred struct
page init was done, was bad since allocations can be made before that
and if they land in kho scratch, they become unpreservable.
Such was the case with iommu page tables.
---
 include/linux/kexec_handover.h     |  6 +++++
 include/linux/memblock.h           |  2 --
 kernel/liveupdate/kexec_handover.c | 35 +++++++++++++++++++++++++++++-
 mm/memblock.c                      | 22 -------------------
 mm/mm_init.c                       | 17 ++++++++++-----
 5 files changed, 52 insertions(+), 30 deletions(-)

diff --git a/include/linux/kexec_handover.h b/include/linux/kexec_handover.h
index ac4129d1d741..612a6da6127a 100644
--- a/include/linux/kexec_handover.h
+++ b/include/linux/kexec_handover.h
@@ -35,6 +35,7 @@ void *kho_restore_vmalloc(const struct kho_vmalloc *preservation);
 int kho_add_subtree(const char *name, void *fdt);
 void kho_remove_subtree(void *fdt);
 int kho_retrieve_subtree(const char *name, phys_addr_t *phys);
+bool pfn_is_kho_scratch(unsigned long pfn);
 
 void kho_memory_init(void);
 
@@ -109,6 +110,11 @@ static inline int kho_retrieve_subtree(const char *name, phys_addr_t *phys)
 	return -EOPNOTSUPP;
 }
 
+static inline bool pfn_is_kho_scratch(unsigned long pfn)
+{
+	return false;
+}
+
 static inline void kho_memory_init(void) { }
 
 static inline void kho_populate(phys_addr_t fdt_phys, u64 fdt_len,
diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index 6ec5e9ac0699..3e217414e12d 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -614,11 +614,9 @@ static inline void memtest_report_meminfo(struct seq_file *m) { }
 #ifdef CONFIG_MEMBLOCK_KHO_SCRATCH
 void memblock_set_kho_scratch_only(void);
 void memblock_clear_kho_scratch_only(void);
-void memmap_init_kho_scratch_pages(void);
 #else
 static inline void memblock_set_kho_scratch_only(void) { }
 static inline void memblock_clear_kho_scratch_only(void) { }
-static inline void memmap_init_kho_scratch_pages(void) {}
 #endif
 
 #endif /* _LINUX_MEMBLOCK_H */
diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index 532f455c5d4f..09cb6660ade7 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -1327,6 +1327,23 @@ int kho_retrieve_subtree(const char *name, phys_addr_t *phys)
 }
 EXPORT_SYMBOL_GPL(kho_retrieve_subtree);
 
+bool pfn_is_kho_scratch(unsigned long pfn)
+{
+	unsigned int i;
+	phys_addr_t scratch_start, scratch_end, phys = __pfn_to_phys(pfn);
+
+	for (i = 0; i < kho_scratch_cnt; i++) {
+		scratch_start = kho_scratch[i].addr;
+		scratch_end = kho_scratch[i].addr + kho_scratch[i].size;
+
+		if (scratch_start <= phys && phys < scratch_end)
+			return true;
+	}
+
+	return false;
+}
+EXPORT_SYMBOL_GPL(pfn_is_kho_scratch);
+
 static int __init kho_mem_retrieve(const void *fdt)
 {
 	struct kho_radix_tree tree;
@@ -1453,12 +1470,27 @@ static __init int kho_init(void)
 }
 fs_initcall(kho_init);
 
+static void __init kho_init_scratch_pages(void)
+{
+	if (!IS_ENABLED(CONFIG_DEFERRED_STRUCT_PAGE_INIT))
+		return;
+
+	for (int i = 0; i < kho_scratch_cnt; i++) {
+		unsigned long pfn = PFN_DOWN(kho_scratch[i].addr);
+		unsigned long end_pfn = PFN_UP(kho_scratch[i].addr + kho_scratch[i].size);
+		int nid = early_pfn_to_nid(pfn);
+
+		for (; pfn < end_pfn; pfn++)
+			init_deferred_page(pfn, nid);
+	}
+}
+
 static void __init kho_release_scratch(void)
 {
 	phys_addr_t start, end;
 	u64 i;
 
-	memmap_init_kho_scratch_pages();
+	kho_init_scratch_pages();
 
 	/*
 	 * Mark scratch mem as CMA before we return it. That way we
@@ -1487,6 +1519,7 @@ void __init kho_memory_init(void)
 			kho_in.fdt_phys = 0;
 	} else {
 		kho_reserve_scratch();
+		kho_init_scratch_pages();
 	}
 }
 
diff --git a/mm/memblock.c b/mm/memblock.c
index b3ddfdec7a80..ae6a5af46bd7 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -959,28 +959,6 @@ __init void memblock_clear_kho_scratch_only(void)
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
-	 * reserve_bootmem_region()
-	 */
-	__for_each_mem_range(i, &memblock.memory, NULL, NUMA_NO_NODE,
-			     MEMBLOCK_KHO_SCRATCH, &start, &end, &nid) {
-		for (pfn = PFN_UP(start); pfn < PFN_DOWN(end); pfn++)
-			init_deferred_page(pfn, nid);
-	}
-}
 #endif
 
 /**
diff --git a/mm/mm_init.c b/mm/mm_init.c
index cec7bb758bdd..969048f9b320 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -798,7 +798,8 @@ void __meminit reserve_bootmem_region(phys_addr_t start,
 	for_each_valid_pfn(pfn, PFN_DOWN(start), PFN_UP(end)) {
 		struct page *page = pfn_to_page(pfn);
 
-		__init_deferred_page(pfn, nid);
+		if (!pfn_is_kho_scratch(pfn))
+			__init_deferred_page(pfn, nid);
 
 		/*
 		 * no need for atomic set_bit because the struct
@@ -2008,9 +2009,12 @@ static void __init deferred_free_pages(unsigned long pfn,
 
 	/* Free a large naturally-aligned chunk if possible */
 	if (nr_pages == MAX_ORDER_NR_PAGES && IS_MAX_ORDER_ALIGNED(pfn)) {
-		for (i = 0; i < nr_pages; i += pageblock_nr_pages)
+		for (i = 0; i < nr_pages; i += pageblock_nr_pages) {
+			if (pfn_is_kho_scratch(page_to_pfn(page + i)))
+				continue;
 			init_pageblock_migratetype(page + i, MIGRATE_MOVABLE,
 					false);
+		}
 		__free_pages_core(page, MAX_PAGE_ORDER, MEMINIT_EARLY);
 		return;
 	}
@@ -2019,7 +2023,7 @@ static void __init deferred_free_pages(unsigned long pfn,
 	accept_memory(PFN_PHYS(pfn), nr_pages * PAGE_SIZE);
 
 	for (i = 0; i < nr_pages; i++, page++, pfn++) {
-		if (pageblock_aligned(pfn))
+		if (pageblock_aligned(pfn) && !pfn_is_kho_scratch(pfn))
 			init_pageblock_migratetype(page, MIGRATE_MOVABLE,
 					false);
 		__free_pages_core(page, 0, MEMINIT_EARLY);
@@ -2090,9 +2094,11 @@ deferred_init_memmap_chunk(unsigned long start_pfn, unsigned long end_pfn,
 			unsigned long mo_pfn = ALIGN(spfn + 1, MAX_ORDER_NR_PAGES);
 			unsigned long chunk_end = min(mo_pfn, epfn);
 
-			nr_pages += deferred_init_pages(zone, spfn, chunk_end);
-			deferred_free_pages(spfn, chunk_end - spfn);
+			// KHO scratch is MAX_ORDER_NR_PAGES aligned.
+			if (!pfn_is_kho_scratch(spfn))
+				deferred_init_pages(zone, spfn, chunk_end);
 
+			deferred_free_pages(spfn, chunk_end - spfn);
 			spfn = chunk_end;
 
 			if (can_resched)
@@ -2100,6 +2106,7 @@ deferred_init_memmap_chunk(unsigned long start_pfn, unsigned long end_pfn,
 			else
 				touch_nmi_watchdog();
 		}
+		nr_pages += epfn - spfn;
 	}
 
 	return nr_pages;
-- 
2.53.0.473.g4a7958ca14-goog


