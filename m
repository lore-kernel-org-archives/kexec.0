Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 037B8FC72AD
	for <kexec@archiver.kernel.org>; Sun, 22 Mar 2026 14:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vFbpHj9Ylh4VB7+cHCNcaRXL1Mg+u1DAcbDf1G8cnp0=; b=mFZAYE6f31a/TDFXIlHBar1F2t
	3+WaeBBCAZrIzloR5WcxHxVhoz+RGVwqKTRDDnExAaVKnX/9Naw/lH9CjysYRQlGkc4NXoKDwCPlw
	c0Uzb6AiyCkOVvyQIE0YgYLuPTlANbFDA4JDHtjozLp+Eyd1WQaH3g3UjthtoMff111dM2Q+O7MF8
	Q46U0ulsxvJYTkRb35AbP8V7McB2yeFCJcF7nHRr18MQfCsc8Ju4qmALW4jw+CFzdwVU+TMU1qT0C
	39kla8XFY/rJ4poKpBuqn4Rul5Mw6YJXpkYFuHRhgExieX1iNizyek/Wrz7av9UkuhYbO3i62p/mr
	wMnrAYcg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w4K4J-0000000FQM4-2QD5;
	Sun, 22 Mar 2026 14:46:19 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w4K4H-0000000FQLa-0Mrz
	for kexec@lists.infradead.org;
	Sun, 22 Mar 2026 14:46:18 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 2346441A04;
	Sun, 22 Mar 2026 14:46:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 226CEC19424;
	Sun, 22 Mar 2026 14:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774190769;
	bh=UmZC99nocgg1YVGjI8yiz5biS1mqjo8v4w880aAeNYc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e1AoBaSy8g/+cbm34AGIBMhWz7WAR5eQ+m4Iq+AgK3neWwLadWWsYIR1yZXi+O16a
	 CXx1GqQmGCbHGvbkco6C6OTB9D1CBJN7SIFwC2zQ5T645v9UMtNJ8/ujLD9SpuiMOa
	 Zz3PiHRNz1YwsUAJ89I8JWVSj8I1MbUVwHm30aWbJS4/1AKmC7c1Yr2hkqUUIDQd6p
	 YrrpVF0fF4s7TRlqfihlS07WItCjqcRSLVG0eNx3Y/hsJ0NPMg6xjx/kqejD3EQQ6u
	 QkjqBMcgeDbjg9DGS6SWNmVc/7TMA06uNZr7l2UYjad5wwdRaaj5S3p21Qiqq9LvWv
	 x0FLVPAslkgRg==
Date: Sun, 22 Mar 2026 16:45:59 +0200
From: Mike Rapoport <rppt@kernel.org>
To: =?utf-8?B?TWljaGHFgiBDxYJhcGnFhHNraQ==?= <mclapinski@google.com>
Cc: Zi Yan <ziy@nvidia.com>, Evangelos Petrongonas <epetron@amazon.de>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Alexander Graf <graf@amazon.com>,
	Samiullah Khawaja <skhawaja@google.com>, kexec@lists.infradead.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v7 2/3] kho: fix deferred init of kho scratch
Message-ID: <acAAp4JaTGn_STBH@kernel.org>
References: <20260317141534.815634-3-mclapinski@google.com>
 <AD9E1B18-C813-480E-894C-FEEB51EE8A93@nvidia.com>
 <CAAi7L5dSOxXETv-bYs4hJ1SfixMBQXS4fmfKs3SzVvQ=yY7oSg@mail.gmail.com>
 <76559EF5-8740-4691-8776-0ADD1CCBF2A4@nvidia.com>
 <CAAi7L5ex+66qgFzRkLDbuOmC=cVrMyBctPZv6wd15n1rc2U9KQ@mail.gmail.com>
 <0D1F59C7-CA35-49C8-B341-32D8C7F4A345@nvidia.com>
 <CAAi7L5fvUPUqd3A4m6wubeYh90NH+S2KBRE1R8WKerBYhkU8kg@mail.gmail.com>
 <58A8B1B4-A73B-48D2-8492-A58A03634644@nvidia.com>
 <aburnbP64n9axmu_@kernel.org>
 <CAAi7L5evx8ta8BifNiGNfUoTiaBUsv4cgQRbm_15RoAfdKPcMw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAi7L5evx8ta8BifNiGNfUoTiaBUsv4cgQRbm_15RoAfdKPcMw@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260322_074617_178102_FDFB27CC 
X-CRM114-Status: GOOD (  46.10  )
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

On Thu, Mar 19, 2026 at 07:17:48PM +0100, Michał Cłapiński wrote:
> On Thu, Mar 19, 2026 at 8:54 AM Mike Rapoport <rppt@kernel.org> wrote:
> >
> > Hi,
> >
> > On Wed, Mar 18, 2026 at 01:36:07PM -0400, Zi Yan wrote:
> > > On 18 Mar 2026, at 13:19, Michał Cłapiński wrote:
> > > > On Wed, Mar 18, 2026 at 6:08 PM Zi Yan <ziy@nvidia.com> wrote:
> > > >>
> > > >> ## Call site analysis
> > > >>
> > > >> init_pageblock_migratetype() has nine call sites. The init call ordering
> > > >> relevant to scratch is:
> > > >>
> > > >> ```
> > > >> setup_arch()
> > > >>   zone_sizes_init() -> free_area_init() -> memmap_init_range()   [1]
> >
> > Hmm, this is slightly outdated, but largely correct :)
> >
> > > >>
> > > >> mm_init_free_all() / start_kernel():
> > > >>   kho_memory_init() -> kho_release_scratch()                     [2]
> > > >>   memblock_free_all()
> > > >>     free_low_memory_core_early()
> > > >>       memmap_init_reserved_pages()
> > > >>         reserve_bootmem_region() -> __init_deferred_page()
> > > >>           -> __init_page_from_nid()                              [3]
> > > >>   deferred init kthreads -> __init_page_from_nid()               [4]
> >
> > And this is wrong, deferred init does not call __init_page_from_nid, only
> > reserve_bootmem_region() does.
> >
> > And there's a case claude missed:
> >
> > hugetlb_bootmem_free_invalid_page() -> __init_page_from_nid() that
> > shouldn't check for KHO. Well, at least until we have support for hugetlb
> > persistence and most probably even afterwards.
> >
> > I don't think we should modify reserve_bootmem_region(). If there are
> > reserved pages in a pageblock, it does not matter if it's initialized to
> > MIGRATE_CMA. It only becomes important if the reserved pages freed, so we
> > can update pageblock migrate type in free_reserved_area().
> > When we boot with KHO, all memblock allocations come from scratch, so
> > anything freed in free_reserved_area() should become CMA again.
> 
> What happens if the reserved area covers one page and that page is
> pageblock aligned? Then it won't be marked as CMA until it is freed
> and unmovable allocation might appear in that pageblock, right?
>
> > +__init_memblock struct memblock_region *memblock_region_from_iter(u64 iterator)
> > +{
> > +       int index = iterator & 0xffffffff;
> 
> I'm not sure about this. __next_mem_range() has this code:
> /*
> * The region which ends first is
> * advanced for the next iteration.
> */
> if (m_end <= r_end)
>         idx_a++;
> else
>         idx_b++;
> 
> Therefore, the index you get from this might be correct or it might
> already be incremented.

Hmm, right, missed that :/

Still, we can check if an address is inside scratch in
reserve_bootmem_regions() and in deferred_init_pages() and set migrate type
to CMA in that case.

I think something like the patch below should work. It might not be the
most optimized, but it localizes the changes to mm_init and memblock and
does not complicated the code (well, almost).

The patch is on top of
https://lore.kernel.org/linux-mm/20260322143144.3540679-1-rppt@kernel.org/T/#u

and I pushed the entire set here:
https://git.kernel.org/pub/scm/linux/kernel/git/rppt/linux.git/log/?h=kho-deferred-init

It compiles and passes kho self test with both deferred pages enabled and
disabled, but I didn't do further testing yet.

From 97aa1ea8e085a128dd5add73f81a5a1e4e0aad5e Mon Sep 17 00:00:00 2001
From: Michal Clapinski <mclapinski@google.com>
Date: Tue, 17 Mar 2026 15:15:33 +0100
Subject: [PATCH] kho: fix deferred initialization of scratch areas

Currently, if CONFIG_DEFERRED_STRUCT_PAGE_INIT is enabled,
kho_release_scratch() will initialize the struct pages and set migratetype
of KHO scratch. Unless the whole scratch fits below first_deferred_pfn, some
of that will be overwritten either by deferred_init_pages() or
memmap_init_reserved_range().

To fix it, modify kho_release_scratch() to only set the migratetype on
already initialized pages and make deferred_init_pages() and
memmap_init_reserved_range() recognize KHO scratch regions and set
migratetype of pageblocks in that regions to MIGRATE_CMA.

Signed-off-by: Michal Clapinski <mclapinski@google.com>
Co-developed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 include/linux/memblock.h           |  7 ++++--
 kernel/liveupdate/kexec_handover.c | 10 +++++---
 mm/memblock.c                      | 39 +++++++++++++-----------------
 mm/mm_init.c                       | 14 ++++++-----
 4 files changed, 36 insertions(+), 34 deletions(-)

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
index 532f455c5d4f..12292b83bf49 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -1457,8 +1457,7 @@ static void __init kho_release_scratch(void)
 {
 	phys_addr_t start, end;
 	u64 i;
-
-	memmap_init_kho_scratch_pages();
+	int nid;
 
 	/*
 	 * Mark scratch mem as CMA before we return it. That way we
@@ -1466,10 +1465,13 @@ static void __init kho_release_scratch(void)
 	 * we can reuse it as scratch memory again later.
 	 */
 	__for_each_mem_range(i, &memblock.memory, NULL, NUMA_NO_NODE,
-			     MEMBLOCK_KHO_SCRATCH, &start, &end, NULL) {
+			     MEMBLOCK_KHO_SCRATCH, &start, &end, &nid) {
 		ulong start_pfn = pageblock_start_pfn(PFN_DOWN(start));
 		ulong end_pfn = pageblock_align(PFN_UP(end));
 		ulong pfn;
+#ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
+		end_pfn = min(end_pfn, NODE_DATA(nid)->first_deferred_pfn);
+#endif
 
 		for (pfn = start_pfn; pfn < end_pfn; pfn += pageblock_nr_pages)
 			init_pageblock_migratetype(pfn_to_page(pfn),
@@ -1480,8 +1482,8 @@ static void __init kho_release_scratch(void)
 void __init kho_memory_init(void)
 {
 	if (kho_in.scratch_phys) {
-		kho_scratch = phys_to_virt(kho_in.scratch_phys);
 		kho_release_scratch();
+		kho_scratch = phys_to_virt(kho_in.scratch_phys);
 
 		if (kho_mem_retrieve(kho_get_fdt()))
 			kho_in.fdt_phys = 0;
diff --git a/mm/memblock.c b/mm/memblock.c
index 17aa8661b84d..fe50d60db9c6 100644
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
@@ -2262,6 +2253,10 @@ static void __init memmap_init_reserved_range(phys_addr_t start,
 		 * access it yet.
 		 */
 		__SetPageReserved(page);
+
+		if (memblock_is_kho_scratch_memory(PFN_PHYS(pfn)) &&
+		    pageblock_aligned(pfn))
+			init_pageblock_migratetype(page, MIGRATE_CMA, false);
 	}
 }
 
diff --git a/mm/mm_init.c b/mm/mm_init.c
index 96ae6024a75f..5ead2b0f07c6 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -1971,7 +1971,7 @@ unsigned long __init node_map_pfn_alignment(void)
 
 #ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
 static void __init deferred_free_pages(unsigned long pfn,
-		unsigned long nr_pages)
+		unsigned long nr_pages, enum migratetype mt)
 {
 	struct page *page;
 	unsigned long i;
@@ -1984,8 +1984,7 @@ static void __init deferred_free_pages(unsigned long pfn,
 	/* Free a large naturally-aligned chunk if possible */
 	if (nr_pages == MAX_ORDER_NR_PAGES && IS_MAX_ORDER_ALIGNED(pfn)) {
 		for (i = 0; i < nr_pages; i += pageblock_nr_pages)
-			init_pageblock_migratetype(page + i, MIGRATE_MOVABLE,
-					false);
+			init_pageblock_migratetype(page + i, mt, false);
 		__free_pages_core(page, MAX_PAGE_ORDER, MEMINIT_EARLY);
 		return;
 	}
@@ -1995,8 +1994,7 @@ static void __init deferred_free_pages(unsigned long pfn,
 
 	for (i = 0; i < nr_pages; i++, page++, pfn++) {
 		if (pageblock_aligned(pfn))
-			init_pageblock_migratetype(page, MIGRATE_MOVABLE,
-					false);
+			init_pageblock_migratetype(page, mt, false);
 		__free_pages_core(page, 0, MEMINIT_EARLY);
 	}
 }
@@ -2052,6 +2050,7 @@ deferred_init_memmap_chunk(unsigned long start_pfn, unsigned long end_pfn,
 	u64 i = 0;
 
 	for_each_free_mem_range(i, nid, 0, &start, &end, NULL) {
+		enum migratetype mt = MIGRATE_MOVABLE;
 		unsigned long spfn = PFN_UP(start);
 		unsigned long epfn = PFN_DOWN(end);
 
@@ -2061,12 +2060,15 @@ deferred_init_memmap_chunk(unsigned long start_pfn, unsigned long end_pfn,
 		spfn = max(spfn, start_pfn);
 		epfn = min(epfn, end_pfn);
 
+		if (memblock_is_kho_scratch_memory(PFN_PHYS(spfn)))
+			mt = MIGRATE_CMA;
+
 		while (spfn < epfn) {
 			unsigned long mo_pfn = ALIGN(spfn + 1, MAX_ORDER_NR_PAGES);
 			unsigned long chunk_end = min(mo_pfn, epfn);
 
 			nr_pages += deferred_init_pages(zone, spfn, chunk_end);
-			deferred_free_pages(spfn, chunk_end - spfn);
+			deferred_free_pages(spfn, chunk_end - spfn, mt);
 
 			spfn = chunk_end;
 
-- 
2.53.0

-- 
Sincerely yours,
Mike.

