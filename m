Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D8E3CD4F3C
	for <kexec@archiver.kernel.org>; Tue, 19 May 2026 13:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=8tDEDF47lmmor5B3dnH0s0HGKympEpVrQWKFC3NXQyA=; b=m1b54jRal5ADA6LAcGBc1X6jK/
	Ny20lHitWx1xwOZIrz/vWCxEIYwAavVChSxTPwK9/lhKGtFWek/YgsaXq/4ykPb0NnvgqzIr89c2E
	9nzlaXss9WYSNsgK5LpittFccmTMZVTCvbvolrbFYfuV6iIN+yAb8Ghf03c0VPNPWu3MZtic9U2or
	vaY+9E7MN4juj0XRx8ee/djH4mFTYa5LLNQ6U4el0Srf0tcVDnuqRmYptRDUOYXyBJD62TZQNjwP2
	NhlGQKiH3xU3Cn+APHNIHMGwF2HQ04NHv7xYOz35EllmjDwaiVUG6CtoCnguLs2+2uDP5Mlz81oCO
	POFvh7Mg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPKZu-00000001ftc-0PuJ;
	Tue, 19 May 2026 13:33:46 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPKZt-00000001ftG-1qxY
	for kexec@lists.infradead.org;
	Tue, 19 May 2026 13:33:45 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 0ECC060129;
	Tue, 19 May 2026 13:33:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11D31C2BCB3;
	Tue, 19 May 2026 13:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779197623;
	bh=JxQkTyZSRlzMs7ib8qBrrp+DMXE6y2eWvhI1wckhkbU=;
	h=From:To:Cc:Subject:Date:From;
	b=Eau0cmanZKHslnj0CVI8LxPTFGCh1FTLiuC+Lkq1wU6hXTEkwm3YjuIn13sBtWjTU
	 5k+RRgEs8l1OjQqtmCeVW6GFmcWX6zZs2+HnvOx4PEGYX259ZNIPI0FTwxEj8onqAj
	 +RXegkCMlEwSyn7oFbe6erQM01UBm2ucDcfDEV3jv0+Vxs4jFFBF53fBL7TOC8Haam
	 jeIPjJESRmjSJcflE3K6FL5vNeZ8Q63KLJ5B03EYRgXAhHoVgZmKLwfxU5yEOWbOSK
	 l9aAnt+zDwBdIG8b3mNwWnGUe9gWji6Qz0n3KOlgA2spnUYYs7J6kFWFu1S2rRvO3p
	 /wc8VgON+0C5Q==
From: Pratyush Yadav <pratyush@kernel.org>
To: Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Alexander Graf <graf@amazon.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: kexec@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] kho: fix order calculation for kho_unpreserve_pages()
Date: Tue, 19 May 2026 15:33:30 +0200
Message-ID: <20260519133332.2498092-1-pratyush@kernel.org>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
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

Commit 91e74fa8b1bc ("kho: make sure preservations do not span multiple
NUMA nodes") made sure preservations from kho_preserve_pages() do not
span multiple NUMA nodes. If they do, the order is reduced and tried
again.

The same logic was not implemented for kho_unpreserve_pages(). This can
result in unpreserve calculating a different order than preserve, and
thus not actually unpreserving the pages.

Fix this by moving the order calculation logic to
__kho_preserve_pages_order() and use it from both preserve and
unpreserve paths.

Move __kho_unpreserve() down to avoid having a forward declaration. Its
users are further down in the file anyway. Also, it results in grouping
for all the page-level preservation and unpreservation functions. This
unfortunately makes the diff hard to read, but the main change in
__kho_unpreserve() is to call __kho_preserve_pages_order() instead of
open-coding the order calculation.

Fixes: 91e74fa8b1bc ("kho: make sure preservations do not span multiple NUMA nodes")
Cc: stable@vger.kernel.org
Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>
---
 kernel/liveupdate/kexec_handover.c | 56 +++++++++++++++++-------------
 1 file changed, 32 insertions(+), 24 deletions(-)

diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index 4fde8325c49f..11855e275397 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -357,20 +357,6 @@ int kho_radix_walk_tree(struct kho_radix_tree *tree,
 }
 EXPORT_SYMBOL_GPL(kho_radix_walk_tree);
 
-static void __kho_unpreserve(struct kho_radix_tree *tree,
-			     unsigned long pfn, unsigned long end_pfn)
-{
-	unsigned int order;
-
-	while (pfn < end_pfn) {
-		order = min(count_trailing_zeros(pfn), ilog2(end_pfn - pfn));
-
-		kho_radix_del_page(tree, pfn, order);
-
-		pfn += 1 << order;
-	}
-}
-
 /* For physically contiguous 0-order pages. */
 static void kho_init_pages(struct page *page, unsigned long nr_pages)
 {
@@ -855,6 +841,37 @@ void kho_unpreserve_folio(struct folio *folio)
 }
 EXPORT_SYMBOL_GPL(kho_unpreserve_folio);
 
+static unsigned int __kho_preserve_pages_order(unsigned long start_pfn,
+					       unsigned long end_pfn)
+{
+	unsigned int order = min(count_trailing_zeros(start_pfn),
+				 ilog2(end_pfn - start_pfn));
+
+	/*
+	 * Make sure all the pages in a single preservation are in the same NUMA
+	 * node. The restore machinery can not cope with a preservation spanning
+	 * multiple NUMA nodes.
+	 */
+	while (pfn_to_nid(start_pfn) != pfn_to_nid(start_pfn + (1UL << order) - 1))
+		order--;
+
+	return order;
+}
+
+static void __kho_unpreserve(struct kho_radix_tree *tree,
+			     unsigned long pfn, unsigned long end_pfn)
+{
+	unsigned int order;
+
+	while (pfn < end_pfn) {
+		order = __kho_preserve_pages_order(pfn, end_pfn);
+
+		kho_radix_del_page(tree, pfn, order);
+
+		pfn += 1 << order;
+	}
+}
+
 /**
  * kho_preserve_pages - preserve contiguous pages across kexec
  * @page: first page in the list.
@@ -880,16 +897,7 @@ int kho_preserve_pages(struct page *page, unsigned long nr_pages)
 	}
 
 	while (pfn < end_pfn) {
-		unsigned int order =
-			min(count_trailing_zeros(pfn), ilog2(end_pfn - pfn));
-
-		/*
-		 * Make sure all the pages in a single preservation are in the
-		 * same NUMA node. The restore machinery can not cope with a
-		 * preservation spanning multiple NUMA nodes.
-		 */
-		while (pfn_to_nid(pfn) != pfn_to_nid(pfn + (1UL << order) - 1))
-			order--;
+		unsigned int order = __kho_preserve_pages_order(pfn, end_pfn);
 
 		err = kho_radix_add_page(tree, pfn, order);
 		if (err) {

base-commit: b1378127003b61930ce30064328640503ad3ef6d
-- 
2.54.0.563.g4f69b47b94-goog


