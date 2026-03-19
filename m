Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2C401075274
	for <kexec@archiver.kernel.org>; Thu, 19 Mar 2026 07:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZJlM6g/QcOUSBOg6fM2dyygtO2A6CpgHjPUtdVOtXE4=; b=mq/SNO0wRkEKku+p8wsS7KaoL3
	Zp+p3fxQyomeOzY6jw6AC7Uti10UWclaUmPJDsLxlNt4G0JJbFYBf/hrF052itAZTz45fmfN/J1A+
	7Ns9jJU3dr02cxzPB4NEubjU8C0eCnE+zPZoNERnkLAP8rPp09AAIefnXh83tKEc3ugPdevFCkb+A
	UmR8IJY7sk2V/pz/ayDRDt+jyBtBm2pYw8sUs/J/BTd2HDPKXxKH/sQN3k9UtGoAwkdM1HbQTIdFJ
	2w0ogiOfD+CytrSQ6BGq6fFxeGBz+jm03Ddmj9k7Q+2hNTgDn0O9btafkLBjUWt9GEvCoqnc+B93p
	SWsp+BpQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w38Cy-0000000ABtC-1AeU;
	Thu, 19 Mar 2026 07:54:20 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w38Cx-0000000ABsc-0Zpm
	for kexec@bombadil.infradead.org;
	Thu, 19 Mar 2026 07:54:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=ZJlM6g/QcOUSBOg6fM2dyygtO2A6CpgHjPUtdVOtXE4=; b=HZnKHkSHY38ElUKaCwGdd7fDcw
	9sW3Aptig+dgQhEkxzHE+EUOslIFivYw6T8urAhfdYk5buqeaivwWh7Io/KJevqTBLmStcLWgbCvZ
	nJpY8vhVpz1ExrCbc/Zlx1T7Ou5UhPDw62u5Yqzgxr+DgqF6HZw8w8TWrGDbSe/dNfr7Pwc2qZs08
	zQnUPZdGzhnUU2hfflR18FguoNUjxLMnTCBm/X78Px3hcPVwgLY4LpLSGptDGWfdVFS3i5RxTxwlw
	Kr4I/fmii40+LDSZ9IQYaMYC8fot9GtF/0kEi/yqZ/3BKizLmXwMXR1G5S4lEByhQ5vJnLVDbHBb1
	nsVrjXIg==;
Received: from sea.source.kernel.org ([172.234.252.31])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w38Ct-0000000Cy9M-1OSq
	for kexec@lists.infradead.org;
	Thu, 19 Mar 2026 07:54:17 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 3AD1E43F6E;
	Thu, 19 Mar 2026 07:54:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58FDEC19424;
	Thu, 19 Mar 2026 07:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773906853;
	bh=dP5W3Kndpvm9kB8cRcapsSUyxSzs+yEOaxzwwC5+yTE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LhQFQN2prXyafTb29mtmn2lHjoY58KytAriVs8or6fr7UgLNLmyzkZnrqNOr89tyF
	 c+SRMME9tiUcQN3zYgFdBZRgb5Cn7p8vkDeBWbjwDj2Oe8I3l/g5CfI4uGsEdZIcVz
	 B4RLC6g5epofAZSfHL9lCCGk/IKa/Ha/LlXM8M7B3aXLbF4eN172sPSQcDOCMNUBUE
	 w9MIihXIDcXMTCnPcMElI3l+n0pvPRBf78dM/40BNAsyQturHIzhSYg+zITc58tqm3
	 kqBBwet/VV1CSKoNtyAqLCJF9iNJVHaiE3lREBoQ89s6qdoeTp+kgLXqabm/YD5RMw
	 Wo+UyfktVi3hw==
Date: Thu, 19 Mar 2026 09:54:05 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Zi Yan <ziy@nvidia.com>
Cc: =?utf-8?B?TWljaGHFgiBDxYJhcGnFhHNraQ==?= <mclapinski@google.com>,
	Evangelos Petrongonas <epetron@amazon.de>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Alexander Graf <graf@amazon.com>,
	Samiullah Khawaja <skhawaja@google.com>, kexec@lists.infradead.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v7 2/3] kho: fix deferred init of kho scratch
Message-ID: <aburnbP64n9axmu_@kernel.org>
References: <20260317141534.815634-1-mclapinski@google.com>
 <20260317141534.815634-3-mclapinski@google.com>
 <AD9E1B18-C813-480E-894C-FEEB51EE8A93@nvidia.com>
 <CAAi7L5dSOxXETv-bYs4hJ1SfixMBQXS4fmfKs3SzVvQ=yY7oSg@mail.gmail.com>
 <76559EF5-8740-4691-8776-0ADD1CCBF2A4@nvidia.com>
 <CAAi7L5ex+66qgFzRkLDbuOmC=cVrMyBctPZv6wd15n1rc2U9KQ@mail.gmail.com>
 <0D1F59C7-CA35-49C8-B341-32D8C7F4A345@nvidia.com>
 <CAAi7L5fvUPUqd3A4m6wubeYh90NH+S2KBRE1R8WKerBYhkU8kg@mail.gmail.com>
 <58A8B1B4-A73B-48D2-8492-A58A03634644@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <58A8B1B4-A73B-48D2-8492-A58A03634644@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260319_075416_219062_994248DB 
X-CRM114-Status: GOOD (  22.08  )
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

Hi,

On Wed, Mar 18, 2026 at 01:36:07PM -0400, Zi Yan wrote:
> On 18 Mar 2026, at 13:19, Michał Cłapiński wrote:
> > On Wed, Mar 18, 2026 at 6:08 PM Zi Yan <ziy@nvidia.com> wrote:
> >>
> >> ## Call site analysis
> >>
> >> init_pageblock_migratetype() has nine call sites. The init call ordering
> >> relevant to scratch is:
> >>
> >> ```
> >> setup_arch()
> >>   zone_sizes_init() -> free_area_init() -> memmap_init_range()   [1]

Hmm, this is slightly outdated, but largely correct :)

> >>
> >> mm_init_free_all() / start_kernel():
> >>   kho_memory_init() -> kho_release_scratch()                     [2]
> >>   memblock_free_all()
> >>     free_low_memory_core_early()
> >>       memmap_init_reserved_pages()
> >>         reserve_bootmem_region() -> __init_deferred_page()
> >>           -> __init_page_from_nid()                              [3]
> >>   deferred init kthreads -> __init_page_from_nid()               [4]

And this is wrong, deferred init does not call __init_page_from_nid, only
reserve_bootmem_region() does.

And there's a case claude missed:

hugetlb_bootmem_free_invalid_page() -> __init_page_from_nid() that
shouldn't check for KHO. Well, at least until we have support for hugetlb
persistence and most probably even afterwards.

I don't think we should modify reserve_bootmem_region(). If there are
reserved pages in a pageblock, it does not matter if it's initialized to
MIGRATE_CMA. It only becomes important if the reserved pages freed, so we
can update pageblock migrate type in free_reserved_area().
When we boot with KHO, all memblock allocations come from scratch, so
anything freed in free_reserved_area() should become CMA again.

> >> ```
> >
> > I don't understand this. deferred_free_pages() doesn't call
> > __init_page_from_nid(). So I would clearly need to modify both
> > deferred_free_pages and __init_page_from_nid.

For deferred_free_pages() we don't need kho_scratch_overlap(), we already
have memblock_region (almost) at hand and it's enough to check if it's
MEMBLOCK_KHO_SCRATCH.

Something along these lines (compile tested only) should do the trick:

diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index 3e217414e12d..b9b1e0991ec8 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -275,6 +275,8 @@ static inline void __next_physmem_range(u64 *idx, struct memblock_type *type,
 	__for_each_mem_range(i, &memblock.reserved, NULL, NUMA_NO_NODE,	\
 			     MEMBLOCK_NONE, p_start, p_end, NULL)
 
+struct memblock_region *memblock_region_from_iter(u64 iterator);
+
 static inline bool memblock_is_hotpluggable(struct memblock_region *m)
 {
 	return m->flags & MEMBLOCK_HOTPLUG;
diff --git a/mm/memblock.c b/mm/memblock.c
index ae6a5af46bd7..9cf99f32279f 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -1359,6 +1359,16 @@ void __init_memblock __next_mem_range_rev(u64 *idx, int nid,
 	*idx = ULLONG_MAX;
 }
 
+__init_memblock struct memblock_region *memblock_region_from_iter(u64 iterator)
+{
+	int index = iterator & 0xffffffff;
+
+	if (index < 0 || index >= memblock.memory.cnt)
+		return NULL;
+
+	return &memblock.memory.regions[index];
+}
+
 /*
  * Common iterator interface used to define for_each_mem_pfn_range().
  */
diff --git a/mm/mm_init.c b/mm/mm_init.c
index cec7bb758bdd..96b25895ffbe 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -1996,7 +1996,7 @@ unsigned long __init node_map_pfn_alignment(void)
 
 #ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
 static void __init deferred_free_pages(unsigned long pfn,
-		unsigned long nr_pages)
+		unsigned long nr_pages, enum migratetype mt)
 {
 	struct page *page;
 	unsigned long i;
@@ -2009,8 +2009,7 @@ static void __init deferred_free_pages(unsigned long pfn,
 	/* Free a large naturally-aligned chunk if possible */
 	if (nr_pages == MAX_ORDER_NR_PAGES && IS_MAX_ORDER_ALIGNED(pfn)) {
 		for (i = 0; i < nr_pages; i += pageblock_nr_pages)
-			init_pageblock_migratetype(page + i, MIGRATE_MOVABLE,
-					false);
+			init_pageblock_migratetype(page + i, mt, false);
 		__free_pages_core(page, MAX_PAGE_ORDER, MEMINIT_EARLY);
 		return;
 	}
@@ -2020,8 +2019,7 @@ static void __init deferred_free_pages(unsigned long pfn,
 
 	for (i = 0; i < nr_pages; i++, page++, pfn++) {
 		if (pageblock_aligned(pfn))
-			init_pageblock_migratetype(page, MIGRATE_MOVABLE,
-					false);
+			init_pageblock_migratetype(page, mt, false);
 		__free_pages_core(page, 0, MEMINIT_EARLY);
 	}
 }
@@ -2077,6 +2075,8 @@ deferred_init_memmap_chunk(unsigned long start_pfn, unsigned long end_pfn,
 	u64 i = 0;
 
 	for_each_free_mem_range(i, nid, 0, &start, &end, NULL) {
+		struct memblock_region *region = memblock_region_from_iter(i);
+		enum migratetype mt = MIGRATE_MOVABLE;
 		unsigned long spfn = PFN_UP(start);
 		unsigned long epfn = PFN_DOWN(end);
 
@@ -2086,12 +2086,15 @@ deferred_init_memmap_chunk(unsigned long start_pfn, unsigned long end_pfn,
 		spfn = max(spfn, start_pfn);
 		epfn = min(epfn, end_pfn);
 
+		if (memblock_is_kho_scratch(region))
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
Sincerely yours,
Mike.

