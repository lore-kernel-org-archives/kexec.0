Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A49ECC5516F
	for <kexec@archiver.kernel.org>; Sat,  1 Aug 2026 08:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DcIy9f09G7AFfaW0m/xEV6z6X9TFYUkoxNnVWt25+18=; b=Ly8aIhlIJxrZWj3QzFQxkJaTH0
	YVBzR83JehFvhmALS0GE725/d2EBW1FpknqnT6m4DTvYy1iN0x1UQ5XQHZRGpnTFlnfwK+AUFSI8c
	WJzI2Rw6Jl/VubXOLRfOu8FPebYpZgMY9Ris5X1yWOITKkjOVNWO5ZPcFAMXqS6fJXc5mebOdACwC
	6KRbBeHVRx3E8JwBBvu8ji9cjTOmLQCrYknk+eSxqDnH604G3Q1pv7quhK1VcCOXzAVVxV/RfklxH
	kqnHstRTIy1Db+krCWU2Bug9Va/BxmhjgeGbYK3AujVU9QTk2nF98Jqoic6dgteS2vgKMOldQudwh
	LMrVYLig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wq5PY-0000000E52M-0zPM;
	Sat, 01 Aug 2026 08:49:40 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wq5PX-0000000E50m-0w3D
	for kexec@lists.infradead.org;
	Sat, 01 Aug 2026 08:49:39 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id EF01D45271;
	Sat,  1 Aug 2026 08:49:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87BF81F00ADF;
	Sat,  1 Aug 2026 08:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785574172;
	bh=DcIy9f09G7AFfaW0m/xEV6z6X9TFYUkoxNnVWt25+18=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IygCmeR712ERaVNGY3E7VqhV3DY/W14mNeAS42TBhexbvQmzSwMxzK5hayLtEpm98
	 rGuTR741l4DbCb0rk9Dz+cyeSO2r3AkYhm1lT2gDC42bUav8jn5KR43bxs35SBEw4L
	 1+qcCZN2Vb2kUgL9rp+VA8/tT63HG+mEg1G1GDQW0iqdm1essHXttw/dmf6padVHhR
	 5R9PvjgA+dM+ilQI/DySB7jm6Z0rzcS6w1jjQOrHe54G3rQSCwS6RbU62gmBKWfdBL
	 iLcmhKAVEbZcOmAvQ45vZpJluIuWWnxpzx2IMEh/W5aGfPJ8+MBNiIpUFEYUFgzWcN
	 CdAKM6EFcRWJQ==
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
	linux-kernel@vger.kernel.org,
	Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v6 16/22] mm/mm_init: simplify deferred_free_pages() migratetype init
Date: Sat,  1 Aug 2026 10:48:25 +0200
Message-ID: <20260801084833.1897543-17-pratyush@kernel.org>
X-Mailer: git-send-email 2.55.0.571.g244d577d93-goog
In-Reply-To: <20260801084833.1897543-1-pratyush@kernel.org>
References: <20260801084833.1897543-1-pratyush@kernel.org>
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

From: Muchun Song <songmuchun@bytedance.com>

deferred_free_pages() open-codes two loops to initialize the pageblock
migratetype for a range of pages.

Replace them with pageblock_migratetype_init_range() to remove the
duplication and make the code clearer (Note that deferred_free_pages() may
be called from atomic context).

Link: https://lore.kernel.org/20260612035903.2468601-6-songmuchun@bytedance.com
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Acked-by: Oscar Salvador <osalvador@suse.de>
Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>
---

Notes:
    This patch is taken from Muchun's series [0]. The patch as of today is
    in mm-unstable.
    
    [0] https://lore.kernel.org/linux-mm/20260612035903.2468601-6-songmuchun@bytedance.com/

 mm/mm_init.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/mm/mm_init.c b/mm/mm_init.c
index 84d4b1c997bc..30355effe1f2 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -674,15 +674,15 @@ static inline void fixup_hashdist(void)
 static inline void fixup_hashdist(void) {}
 #endif /* CONFIG_NUMA */
 
-#ifdef CONFIG_ZONE_DEVICE
+#if defined(CONFIG_ZONE_DEVICE) || defined(CONFIG_DEFERRED_STRUCT_PAGE_INIT)
 static __meminit void pageblock_migratetype_init_range(unsigned long pfn,
-		unsigned long nr_pages, int migratetype)
+		unsigned long nr_pages, int migratetype, bool atomic)
 {
 	const unsigned long end = pfn + nr_pages;
 
 	for (pfn = pageblock_align(pfn); pfn < end; pfn += pageblock_nr_pages) {
 		init_pageblock_migratetype(pfn_to_page(pfn), migratetype, false);
-		if (IS_ALIGNED(pfn, PAGES_PER_SECTION))
+		if (!atomic && IS_ALIGNED(pfn, PAGES_PER_SECTION))
 			cond_resched();
 	}
 }
@@ -1142,7 +1142,7 @@ void __ref memmap_init_zone_device(struct zone *zone,
 				     compound_nr_pages(pfn, altmap, pgmap));
 	}
 
-	pageblock_migratetype_init_range(start_pfn, nr_pages, MIGRATE_MOVABLE);
+	pageblock_migratetype_init_range(start_pfn, nr_pages, MIGRATE_MOVABLE, false);
 
 	pr_debug("%s initialised %lu pages in %ums\n", __func__,
 		nr_pages, jiffies_to_msecs(jiffies - start));
@@ -1981,12 +1981,12 @@ static void __init deferred_free_pages(unsigned long pfn,
 	if (!nr_pages)
 		return;
 
+	pageblock_migratetype_init_range(pfn, nr_pages, mt, true);
+
 	page = pfn_to_page(pfn);
 
 	/* Free a large naturally-aligned chunk if possible */
 	if (nr_pages == MAX_ORDER_NR_PAGES && IS_MAX_ORDER_ALIGNED(pfn)) {
-		for (i = 0; i < nr_pages; i += pageblock_nr_pages)
-			init_pageblock_migratetype(page + i, mt, false);
 		__free_pages_core(page, MAX_PAGE_ORDER, MEMINIT_EARLY);
 		return;
 	}
@@ -1994,11 +1994,8 @@ static void __init deferred_free_pages(unsigned long pfn,
 	/* Accept chunks smaller than MAX_PAGE_ORDER upfront */
 	accept_memory(PFN_PHYS(pfn), nr_pages * PAGE_SIZE);
 
-	for (i = 0; i < nr_pages; i++, page++, pfn++) {
-		if (pageblock_aligned(pfn))
-			init_pageblock_migratetype(page, mt, false);
-		__free_pages_core(page, 0, MEMINIT_EARLY);
-	}
+	for (i = 0; i < nr_pages; i++)
+		__free_pages_core(page + i, 0, MEMINIT_EARLY);
 }
 
 /* Completion tracking for deferred_init_memmap() threads */
-- 
2.55.0.571.g244d577d93-goog


