Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C79AD0E6C6
	for <kexec@archiver.kernel.org>; Tue, 25 Nov 2025 11:09:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zcZ/0x2QC5aZSYY0Wx/FbaySR5n1WpjcQwAP9quH9Oc=; b=rO8JDsJIhe8mwHEvScx5c+/dtr
	+hGBroSpwZsTHpByZCxE30tQLWU65mDr8skkQww8oJbi2USAXIhR2MXREj5wSK+KXBZIClGNvU56M
	4fzMgafyle6VwgMV2m4QoWR1UBWHUT9tUVnC+e4QMrH1Nraw+Mksl1cNJ9p/lUVlO5c7U5rCBRETJ
	6MqjHk4SD9t7NVj+UHD++nbjMTt2wGoCBCfNJu/EWaChs8BY6CbC+39I/sm2UOEHzb7M3DuJ6qc41
	yToMRfiu5JcLhd02xwKNRe+oxopUy4bbppx9Qji21234W5b8NQZjKa0K6nakZW0mRTohDJi9FtAG+
	ByT5XafA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNqvM-0000000DBel-18l7;
	Tue, 25 Nov 2025 11:09:32 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNqvJ-0000000DBcf-3SMa
	for kexec@lists.infradead.org;
	Tue, 25 Nov 2025 11:09:30 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id E1F8C43F8C;
	Tue, 25 Nov 2025 11:09:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77BE5C4CEF1;
	Tue, 25 Nov 2025 11:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764068968;
	bh=MS5FYY77YbUK+JnTC70ZJhGSJBc/kCi9Z+1XsOTG/hg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IL+MewD2vccgFyCl83IBplNj7nZAp3OmlK7ap4lcO9Suh408qb8kBRDwhD5hR77RJ
	 +lJioiWjhFZV9M3k2xrBWD+cNXir5DaHSn8KUwDQI59e1wlH4qjQ8fWgHTPemittIP
	 D2OILvVd+b33cfmj6H9JM+GrqAHFwbwb1brsJvFD3FtCexu+X6CneRzKUu4lNqGbzf
	 gzQd7SF319Io0kg6PDxH01y/r/LU5PcgGarQC5XC2XMP0izIOex/YiQbIzBPDr+o+f
	 fkCvr7RRA9+2uTEs3gcNgqi1tgO9VkXfDc3G7ePKncGs7Tfd7ynmcuFGu/Igw95F3R
	 qSzXObEyFSLKQ==
From: Mike Rapoport <rppt@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexander Graf <graf@amazon.com>,
	Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	kexec@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] kho: fix restoring of contiguous ranges of order-0 pages
Date: Tue, 25 Nov 2025 13:09:17 +0200
Message-ID: <20251125110917.843744-3-rppt@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251125110917.843744-1-rppt@kernel.org>
References: <20251125110917.843744-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251125_030929_901921_39BA3EE1 
X-CRM114-Status: GOOD (  15.98  )
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

From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>

When contiguous ranges of order-0 pages are restored, kho_restore_page()
calls prep_compound_page() with the first page in the range and order as
parameters and then kho_restore_pages() calls split_page() to make sure all
pages in the range are order-0.

However, since split_page() is not intended to split compound pages and
with VM_DEBUG enabled it will trigger a VM_BUG_ON_PAGE().

Update kho_restore_page() so that it will use prep_compound_page() when it
restores a folio and make sure it properly sets page count for both large
folios and ranges of order-0 pages.

Reported-by: Pratyush Yadav <pratyush@kernel.org>
Fixes: a667300bd53f ("kho: add support for preserving vmalloc allocations")
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 kernel/liveupdate/kexec_handover.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index e64ee87fa62a..61d17ed1f423 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -219,11 +219,11 @@ static int __kho_preserve_order(struct kho_mem_track *track, unsigned long pfn,
 	return 0;
 }
 
-static struct page *kho_restore_page(phys_addr_t phys)
+static struct page *kho_restore_page(phys_addr_t phys, bool is_folio)
 {
 	struct page *page = pfn_to_online_page(PHYS_PFN(phys));
+	unsigned int nr_pages, ref_cnt;
 	union kho_page_info info;
-	unsigned int nr_pages;
 
 	if (!page)
 		return NULL;
@@ -243,11 +243,16 @@ static struct page *kho_restore_page(phys_addr_t phys)
 	/* Head page gets refcount of 1. */
 	set_page_count(page, 1);
 
-	/* For higher order folios, tail pages get a page count of zero. */
+	/*
+	 * For higher order folios, tail pages get a page count of zero.
+	 * For physically contiguous order-0 pages every pages gets a page
+	 * count of 1
+	 */
+	ref_cnt = is_folio ? 0 : 1;
 	for (unsigned int i = 1; i < nr_pages; i++)
-		set_page_count(page + i, 0);
+		set_page_count(page + i, ref_cnt);
 
-	if (info.order > 0)
+	if (is_folio && info.order)
 		prep_compound_page(page, info.order);
 
 	adjust_managed_page_count(page, nr_pages);
@@ -262,7 +267,7 @@ static struct page *kho_restore_page(phys_addr_t phys)
  */
 struct folio *kho_restore_folio(phys_addr_t phys)
 {
-	struct page *page = kho_restore_page(phys);
+	struct page *page = kho_restore_page(phys, true);
 
 	return page ? page_folio(page) : NULL;
 }
@@ -287,11 +292,10 @@ struct page *kho_restore_pages(phys_addr_t phys, unsigned int nr_pages)
 	while (pfn < end_pfn) {
 		const unsigned int order =
 			min(count_trailing_zeros(pfn), ilog2(end_pfn - pfn));
-		struct page *page = kho_restore_page(PFN_PHYS(pfn));
+		struct page *page = kho_restore_page(PFN_PHYS(pfn), false);
 
 		if (!page)
 			return NULL;
-		split_page(page, order);
 		pfn += 1 << order;
 	}
 
-- 
2.50.1


