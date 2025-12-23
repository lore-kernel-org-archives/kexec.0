Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F7F3E6F084
	for <kexec@archiver.kernel.org>; Tue, 23 Dec 2025 10:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=9IYOnHMXqXm+Tf4oCMVqcfeNEvc4/yNfUdZAwxsTL8g=; b=OZiPPSV95Y4DVXKa3n+qabFcaj
	+MSaHMbgvRlKfhdtlnkiSQBcSqEAUnAPDFETPFnqa362Gq5evLQwV6ptqjoLul1e9XrMUVMwx5HkE
	YBK6p7Hndu7KRaeW/8LRMD2te9fv3fIGxWigyjslZdJtmezx3yhwc3hYTNagraoVmKk+kJKCn4DPM
	Vo71MyNI6DVsbaUydMEboZTHYs4xgvbHrDM+hdo6kwzy6zD/r/zt0ETJSUr3CtWKZNwA2UDFLVHmb
	JGTozwcQ7p/ZMRW863fpc3andVkjHq4Rl0/axTnksKQ1ogDkSNogCTil8IZ2an5TP6kgtdeYI1WZy
	hvKxLFZQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vXzt1-0000000Eu6Q-0VCA;
	Tue, 23 Dec 2025 10:45:03 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vXzsz-0000000Eu6F-2VdO
	for kexec@lists.infradead.org;
	Tue, 23 Dec 2025 10:45:01 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 059D1600CB;
	Tue, 23 Dec 2025 10:45:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E4CCC113D0;
	Tue, 23 Dec 2025 10:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766486700;
	bh=OvvBh3rBFu8/YoqGW0OVMvMC2gUrUjk3BKp4jAKJ5cY=;
	h=From:To:Cc:Subject:Date:From;
	b=jON0z822WBdoyLOJjLlvfkXrkqu6HzPdAhG8rpHn/N9eKY3CAu/hCCf7Mc4j2i/3l
	 hQiirZPJNV6uayyXXW51Barhq2M0Oa6KnLSM/vQeC+Y6KjefyvIhwaEuAR5pqK3AoZ
	 3DlDLXkZQkezL9+VkCxrIL0bM/oonhQU2/sIVyLQjQXFHPRysv/bBvCBRsrMcS+vzp
	 S6Z2SQNs8mupbsAA0VwpK3E0LXKHx/2ycceFBxo7wGY3f4Wv80blA2g97eD8TDzUyq
	 jDiJ2DAupbad9j42rzqQjqjaS/lPfm8t8D654SsZM6Dor5tQ8iFxzCBQ7Gn+oO//u7
	 kEvymJfuv8F7A==
From: Pratyush Yadav <pratyush@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Alexander Graf <graf@amazon.com>,
	Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>
Cc: kexec@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] kho: simplify page initialization in kho_restore_page()
Date: Tue, 23 Dec 2025 11:44:46 +0100
Message-ID: <20251223104448.195589-1-pratyush@kernel.org>
X-Mailer: git-send-email 2.43.0
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

Notes:
    This patch is a follow up from
    https://lore.kernel.org/linux-mm/86ms42mj44.fsf@kernel.org/

 kernel/liveupdate/kexec_handover.c | 41 ++++++++++++++++++++----------
 1 file changed, 27 insertions(+), 14 deletions(-)

diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index 2d9ce33c63dc..304c26fd5ee6 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -219,11 +219,33 @@ static int __kho_preserve_order(struct kho_mem_track *track, unsigned long pfn,
 	return 0;
 }
 
+/* For physically contiguous 0-order pages. */
+static void kho_init_pages(struct page *page, unsigned int nr_pages)
+{
+	for (unsigned int i = 0; i < nr_pages; i++)
+		set_page_count(page + i, 1);
+}
+
+static void kho_init_folio(struct page *page, unsigned int order)
+{
+	unsigned int nr_pages = (1 << order);
+
+	/* Head page gets refcount of 1. */
+	set_page_count(page, 1);
+
+	/* For higher order folios, tail pages get a page count of zero. */
+	for (unsigned int i = 1; i < nr_pages; i++)
+		set_page_count(page + i, 0);
+
+	if (order > 0)
+		prep_compound_page(page, order);
+}
+
 static struct page *kho_restore_page(phys_addr_t phys, bool is_folio)
 {
 	struct page *page = pfn_to_online_page(PHYS_PFN(phys));
-	unsigned int nr_pages, ref_cnt;
 	union kho_page_info info;
+	unsigned int nr_pages;
 
 	if (!page)
 		return NULL;
@@ -240,20 +262,11 @@ static struct page *kho_restore_page(phys_addr_t phys, bool is_folio)
 
 	/* Clear private to make sure later restores on this page error out. */
 	page->private = 0;
-	/* Head page gets refcount of 1. */
-	set_page_count(page, 1);
 
-	/*
-	 * For higher order folios, tail pages get a page count of zero.
-	 * For physically contiguous order-0 pages every pages gets a page
-	 * count of 1
-	 */
-	ref_cnt = is_folio ? 0 : 1;
-	for (unsigned int i = 1; i < nr_pages; i++)
-		set_page_count(page + i, ref_cnt);
-
-	if (is_folio && info.order)
-		prep_compound_page(page, info.order);
+	if (is_folio)
+		kho_init_folio(page, info.order);
+	else
+		kho_init_pages(page, nr_pages);
 
 	adjust_managed_page_count(page, nr_pages);
 	return page;

base-commit: 9f7b37a7c250baf3092719d4ebc9a8edaa79a7b4
-- 
2.43.0


