Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC485D48981
	for <kexec@archiver.kernel.org>; Fri, 16 Jan 2026 11:22:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HArPDH30zUaP46WbpZrPeDtL/IH19i0ZCljZS0KUGpM=; b=QMrHkl8MqkvJKZ9FWONisita+L
	bBbL6WcwEJru6DmGlCnTRMBjIfbgPS5wzspk1DNMem7ni6xrT4WMICzubo1GpLpTbAzzcbuu9AwYv
	xac3tYRVD6nCstGrhLOj0c2rudY1yxXLD4CK8qhB/q50Jc1X8rrWkScotCfTlS6A+NGcZpuvNVJoF
	lsLopMTQqwjwlVyTyZC6Ia3CATAnQ/Ymvk0JC1No3v+9IlDuDk5HsDT3EE9m9EjnWAPOHIaWWJ09M
	lrM+E2xjEDHcGGGORS/m9J7XPzEaCoO9BYaBzHQ4IMUgftpY9Ce8bwb7O1sqFpSCC7dSQ/9NcPqaE
	Adg0KGTQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vghuW-0000000E2h4-1Z5Y;
	Fri, 16 Jan 2026 11:22:36 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vghuV-0000000E2fi-0QYj
	for kexec@lists.infradead.org;
	Fri, 16 Jan 2026 11:22:35 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 6CF516016F;
	Fri, 16 Jan 2026 11:22:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EFEBC16AAE;
	Fri, 16 Jan 2026 11:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768562553;
	bh=AVBcqfwv4HnAqgcteSfH5IP5ilFZ6g7I/bqNeJQP95I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b8g0cLnTmF6l+lcFfexSzl8Dhd7Ymz/1cfV1yF4r1erM2SBSuDQOTLjMRlD6vvnRF
	 urI7sQFDAFU0EmjW8uRHoSkjk2xjicicMxdJWsvKwl/t4Z1yvULV8YSl/+VnqzRKaX
	 SrCYw45GCQ+uhVjY/7p11O3iueRWY9NETYWrnVRqPdZZaY3i5UzzTRRYzrKw8ZGuhg
	 WgiZa5RV1vk+tQCa4CMdhTToIBNzlyX1cemal/VGTCt2IwVW4rCqEGzPa/P+cBAj7i
	 lYEAkMmAkY0nCU5hTuG2B9Dt9I5svhq7IO3MdTmCfRyQGjrf4FBkCJxlJdCtqgHk5E
	 Z1UC3TU1Vd+YA==
From: Pratyush Yadav <pratyush@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Alexander Graf <graf@amazon.com>,
	Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>
Cc: kexec@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Suren Baghdasaryan <surenb@google.com>
Subject: [PATCH v2 2/2] kho: simplify page initialization in kho_restore_page()
Date: Fri, 16 Jan 2026 11:22:15 +0000
Message-ID: <20260116112217.915803-3-pratyush@kernel.org>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
In-Reply-To: <20260116112217.915803-1-pratyush@kernel.org>
References: <20260116112217.915803-1-pratyush@kernel.org>
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

When restoring a page (from kho_restore_pages()) or folio (from
kho_restore_folio()), KHO must initialize the struct page. The
initialization differs slightly depending on if a folio is requested or
a set of 0-order pages is requested.

Conceptually, it is quite simple to understand. When restoring 0-order
pages, each page gets a refcount of 1 and that's it. When restoring a
folio, head page gets a refcount of 1 and tail pages get 0.

kho_restore_page() tries to combine the two separate initialization flow
into one piece of code. While it works fine, it is more complicated to
read than it needs to be. Make the code simpler by splitting the two
initalization paths into two separate functions. This improves
readability by clearly showing how each type must be initialized.

Signed-off-by: Pratyush Yadav <pratyush@kernel.org>
---

Changes in v2:
- Use unsigned long for nr_pages.

 kernel/liveupdate/kexec_handover.c | 40 +++++++++++++++++++-----------
 1 file changed, 26 insertions(+), 14 deletions(-)

diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index 709484fbf9fd..92da76977684 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -219,11 +219,32 @@ static int __kho_preserve_order(struct kho_mem_track *track, unsigned long pfn,
 	return 0;
 }
 
+/* For physically contiguous 0-order pages. */
+static void kho_init_pages(struct page *page, unsigned long nr_pages)
+{
+	for (unsigned long i = 0; i < nr_pages; i++)
+		set_page_count(page + i, 1);
+}
+
+static void kho_init_folio(struct page *page, unsigned int order)
+{
+	unsigned long nr_pages = (1 << order);
+
+	/* Head page gets refcount of 1. */
+	set_page_count(page, 1);
+
+	/* For higher order folios, tail pages get a page count of zero. */
+	for (unsigned long i = 1; i < nr_pages; i++)
+		set_page_count(page + i, 0);
+
+	if (order > 0)
+		prep_compound_page(page, order);
+}
+
 static struct page *kho_restore_page(phys_addr_t phys, bool is_folio)
 {
 	struct page *page = pfn_to_online_page(PHYS_PFN(phys));
 	unsigned long nr_pages;
-	unsigned int ref_cnt;
 	union kho_page_info info;
 
 	if (!page)
@@ -241,20 +262,11 @@ static struct page *kho_restore_page(phys_addr_t phys, bool is_folio)
 
 	/* Clear private to make sure later restores on this page error out. */
 	page->private = 0;
-	/* Head page gets refcount of 1. */
-	set_page_count(page, 1);
-
-	/*
-	 * For higher order folios, tail pages get a page count of zero.
-	 * For physically contiguous order-0 pages every pages gets a page
-	 * count of 1
-	 */
-	ref_cnt = is_folio ? 0 : 1;
-	for (unsigned long i = 1; i < nr_pages; i++)
-		set_page_count(page + i, ref_cnt);
 
-	if (is_folio && info.order)
-		prep_compound_page(page, info.order);
+	if (is_folio)
+		kho_init_folio(page, info.order);
+	else
+		kho_init_pages(page, nr_pages);
 
 	adjust_managed_page_count(page, nr_pages);
 	return page;
-- 
2.52.0.457.g6b5491de43-goog


