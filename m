Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE8B6C43458
	for <kexec@archiver.kernel.org>; Thu,  9 Jul 2026 17:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=s0TyfHDGp9MFMmZhGlGKvQfEHqtuRGyQhEAHo3riGeA=; b=swiAj0FTQR7dFcRB7zXRENVliG
	titFIIUExAIL+6QrF5p9lEJFC+Hs2N6Yk0Reuo6Ak4JUKgJizWL50lX201twawYShNrNz6lAc8Oxt
	ilQ0Fj01RFmXNBuuC275Y5/4SHFuAIPxJ86unut3RuiiZ1+f077sDOfD9YvtZOMv91qTn75k3h+V1
	xzA5KhqPsYWwkY5qwmwMkw4JzBGEIaCIlUjzb8aeoevzUpckdWwf7yl7y85pyWuyhd0PYyoa4BQg4
	MkcBxDqtgu6w0aanBfzjoAtSL09SdllGh8GsaQvFnlXKUUD5QqaZHaOqdIszZSjGstLp93zOnIZGf
	6KcIcz3g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whsiQ-000000038T9-3hmb;
	Thu, 09 Jul 2026 17:39:14 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whsiP-000000038RF-1wXZ
	for kexec@lists.infradead.org;
	Thu, 09 Jul 2026 17:39:13 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 3C033437F7;
	Thu,  9 Jul 2026 17:39:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE1111F00A3E;
	Thu,  9 Jul 2026 17:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783618753;
	bh=s0TyfHDGp9MFMmZhGlGKvQfEHqtuRGyQhEAHo3riGeA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NgYUfxJCriwCprEgHQEZJJpPIibQJGmufQxvjuMW7DlOy9/xHqorXKwDUOzWSnDya
	 yiHQPp3Idtq5IrWbUxyb8URxr9iTPsMQerVZwgUMEDto+TQOnX/i98EsP803g0nbVV
	 bi3yNedZnxPX/iMhIzJFa09S1WlQpNuS7CYWP5LNGVuMFDRrk7JWe8B82WUBvhcv7b
	 osmv5mmUmxDjJ7+kBleFRTbACSv6vSo8Pn+eN6t0zvelZHH58zIaOUedzzIQwSQgcE
	 UgQik0N+HAdHdFyF82VDCEmbhaLC/QdJVcxa6yHicokMfyFEcBVAYR6nakKABVtZSn
	 1FWEwzCjzHq2A==
From: Pratyush Yadav <pratyush@kernel.org>
To: Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Alexander Graf <graf@amazon.com>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jason Miu <jasonmiu@google.com>,
	Jork Loeser <jloeser@linux.microsoft.com>
Cc: kexec@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 16/21] mm/mm_init: init deferred page migratetype in deferred_init_pages()
Date: Thu,  9 Jul 2026 19:38:05 +0200
Message-ID: <20260709173821.429921-17-pratyush@kernel.org>
X-Mailer: git-send-email 2.55.0.141.g00534a21ce-goog
In-Reply-To: <20260709173821.429921-1-pratyush@kernel.org>
References: <20260709173821.429921-1-pratyush@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The deferred pages are initialized in deferred_init_pages(), but their
migratetype is initialized later when freeing them in
deferred_free_pages(). Setting the migrate type is part of initializing
the pages, so move it to deferred_init_pages().

This simplifies the logic in deferred_free_pages(), which now only does
the freeing. For non-max-order-aligned pages, it also drops the
if (pageblock_aligned) for each freed page, which in theory should be a
tiny bit faster.

Another motivation for this change is that in a coming patch, KHO will
need to update the migrate type for its scratch pages. Moving all the
pageblock init in one place makes that simpler.

Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>
---
 mm/mm_init.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/mm/mm_init.c b/mm/mm_init.c
index 84d4b1c997bc..bd9dc1829005 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -1985,8 +1985,6 @@ static void __init deferred_free_pages(unsigned long pfn,
 
 	/* Free a large naturally-aligned chunk if possible */
 	if (nr_pages == MAX_ORDER_NR_PAGES && IS_MAX_ORDER_ALIGNED(pfn)) {
-		for (i = 0; i < nr_pages; i += pageblock_nr_pages)
-			init_pageblock_migratetype(page + i, mt, false);
 		__free_pages_core(page, MAX_PAGE_ORDER, MEMINIT_EARLY);
 		return;
 	}
@@ -1994,11 +1992,8 @@ static void __init deferred_free_pages(unsigned long pfn,
 	/* Accept chunks smaller than MAX_PAGE_ORDER upfront */
 	accept_memory(PFN_PHYS(pfn), nr_pages * PAGE_SIZE);
 
-	for (i = 0; i < nr_pages; i++, page++, pfn++) {
-		if (pageblock_aligned(pfn))
-			init_pageblock_migratetype(page, mt, false);
+	for (i = 0; i < nr_pages; i++, page++, pfn++)
 		__free_pages_core(page, 0, MEMINIT_EARLY);
-	}
 }
 
 /* Completion tracking for deferred_init_memmap() threads */
@@ -2017,15 +2012,23 @@ static inline void __init pgdat_init_report_one_done(void)
  * Return number of pages initialized.
  */
 static unsigned long __init deferred_init_pages(struct zone *zone,
-		unsigned long pfn, unsigned long end_pfn)
+		unsigned long start_pfn, unsigned long end_pfn,
+		enum migratetype mt)
 {
 	int nid = zone_to_nid(zone);
-	unsigned long nr_pages = end_pfn - pfn;
+	unsigned long nr_pages = end_pfn - start_pfn, pfn = start_pfn;
 	int zid = zone_idx(zone);
 	struct page *page = pfn_to_page(pfn);
 
 	for (; pfn < end_pfn; pfn++, page++)
 		__init_single_page(page, pfn, zid, nid);
+
+	/* Now initialize migrate types for these pages. */
+	pfn = pageblock_align(start_pfn);
+	page = pfn_to_page(pfn);
+	for (; pfn < end_pfn; pfn += pageblock_nr_pages, page += pageblock_nr_pages)
+		init_pageblock_migratetype(page, mt, false);
+
 	return nr_pages;
 }
 
@@ -2067,7 +2070,7 @@ deferred_init_memmap_chunk(unsigned long start_pfn, unsigned long end_pfn,
 			unsigned long mo_pfn = ALIGN(spfn + 1, MAX_ORDER_NR_PAGES);
 			unsigned long chunk_end = min(mo_pfn, epfn);
 
-			nr_pages += deferred_init_pages(zone, spfn, chunk_end);
+			nr_pages += deferred_init_pages(zone, spfn, chunk_end, mt);
 			deferred_free_pages(spfn, chunk_end - spfn, mt);
 
 			spfn = chunk_end;
-- 
2.55.0.141.g00534a21ce-goog


