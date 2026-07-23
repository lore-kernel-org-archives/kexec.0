Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 654EEC531CC
	for <kexec@archiver.kernel.org>; Thu, 23 Jul 2026 20:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/sU7OskJpEHtaekLlZ/5Z4YIkxuA4+y1ea25Y5pF/Mc=; b=nxceZKO3IXUXkGfxbAUtZ3WN1b
	aKrNbB3e/6dDUIHMdRe5lLIJcRtbQYUdQFvvz935pnPplKSzLcj9HNwDohM6/HMoZgyQ0yaGomSMg
	zND25+CyKBAutSzWNzzseHImgMhpD5YKkWRBCJ6PNBP8pO83FH+EyUfsdtnSMxsm+fRP2tNwLT8iP
	p/BR+Pmrd4su8HjtgiGTzPw+AwKB51svw+DbuyOyMjTIebPEmWshFfcrTgWzmRXlqHbWgkwp4ERbg
	l6XVgeakf46EdM99Cu7qEKBEWkGq6fhNHYA/FuxESMfO0dTEDSfMWB1YYVeV8bO4LblpqL93aQM5+
	tn3I5GCg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wn0FG-0000000F3QK-1XBD;
	Thu, 23 Jul 2026 20:42:18 +0000
Received: from mail-pl1-x648.google.com ([2607:f8b0:4864:20::648])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wn0FD-0000000F3P6-36oq
	for kexec@lists.infradead.org;
	Thu, 23 Jul 2026 20:42:16 +0000
Received: by mail-pl1-x648.google.com with SMTP id d9443c01a7336-2cf1c86963bso8787975ad.0
        for <kexec@lists.infradead.org>; Thu, 23 Jul 2026 13:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784839335; x=1785444135; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/sU7OskJpEHtaekLlZ/5Z4YIkxuA4+y1ea25Y5pF/Mc=;
        b=DQd35ZHjizfJI0GkXSBcB9ivehrHtTlCsfYqD40KFXjHdHfwZTL3Et0c79AmNOqas8
         0Pb04SVD6tLl/2ojrLaUNtSMJVuvVATFVWG6BdEcII4jmM9JkrLEgbSqrLBTahFpO5Fg
         +2JlqYLdJaTgBpNdGoa7NP87lNTzUOnncRGMnrELdGzO2gobL0Yiyu8OIWfN8AH2gf3p
         iQmUMvU+4adhpJTUQ0XLwpYbM/0qsvvJPrEujSXe81Jdsje+UzA1Yby6PyfyrmYYTmME
         eSfFsvbFU5zShZvnWPDKnR25FbGoqhjWhbCK8YIDjfMyF8n3SSRET4BaiJExoWqS1+ZI
         FE6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784839335; x=1785444135;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/sU7OskJpEHtaekLlZ/5Z4YIkxuA4+y1ea25Y5pF/Mc=;
        b=c6GVjxLL+ChVpkrPcG9+SY7u6lCrGvjpSR+inaijEQgMNhPLOZBCg/PAN6fPfkzyjj
         ZAcf3vRmLR6KdBP/wThvHWi9awBPJAPzu93DoG3UgVCG6AjfIp381U8MN4UGE8tzhB63
         5NYqFvW2gHMrq/62DQfQxykqbBkcEBArYl6bCoO8pPS9Y7AOl5/CR8ZWeNWZR0jMosi6
         Jz/z0GM1owXgwTylLgLlS0NEK4aVfvXvKqg33u1o0sJ4bBo3sauMR7zZrTvHtc1FTdPs
         1CECLLK7oByK4ewxFnKCh7bZN6JhoemJWHmjommtiOkuE2wi5a8SJjpkjvwx3Oei6fgB
         qWuw==
X-Forwarded-Encrypted: i=1; AHgh+RrEY+Njg8yPKKtDWeTkUEj2jURXUqsl1tW3bIVL79WuWVCnbRpXGFqq+r/kHLSFseWbBzM1wA==@lists.infradead.org
X-Gm-Message-State: AOJu0YwFVEyJFEPNgqbnNo8O4y/TlF1u8ha1spa9ftcsLk6gQursUyMQ
	aihDdz1KEiDwXi27UvTJrH/EavCHZIoqwsbR1B7bkpGN94ctE0FvmKcFiqe97szHij+sftma/5J
	Utw==
X-Received: from plrs15.prod.google.com ([2002:a17:902:b18f:b0:2cc:ae2b:c324])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:41c3:b0:2c9:fc0d:165b
 with SMTP id d9443c01a7336-2cfa9552729mr45540675ad.23.1784839334260; Thu, 23
 Jul 2026 13:42:14 -0700 (PDT)
Date: Thu, 23 Jul 2026 20:42:02 +0000
In-Reply-To: <20260723204203.2997395-1-praan@google.com>
Mime-Version: 1.0
References: <20260723204203.2997395-1-praan@google.com>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260723204203.2997395-3-praan@google.com>
Subject: [PATCH v3 2/2] kho: Introduce preserve/restore APIs for high-order pages
From: Pranjal Shrivastava <praan@google.com>
To: Mike Rapoport <rppt@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pratyush Yadav <pratyush@kernel.org>
Cc: Alexander Graf <graf@amazon.com>, Samiullah Khawaja <skhawaja@google.com>, 
	David Matlack <dmatlack@google.com>, kexec@lists.infradead.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Pranjal Shrivastava <praan@google.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260723_134215_792688_536FD51C 
X-CRM114-Status: GOOD (  20.13  )
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

The current KHO page preservation APIs (e.g. kho_preserve_pages) assume
that multi-page blocks are split into independent 4KB pages during
restoration. This is incompatible with high-order non-compound pages,
such as DMA buffers, which must be restored with tail pages having a
zero reference count.

Introduce explicit preserve and restore APIs for high-order pages,
which preserve and restore a high-order page block as a single unit,
applying a refcount of 1 to the head page while leaving tail pages at 0.
Rename the existing internal helper to __kho_restore_page() and
consolidate the common restoration code into it.

Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 include/linux/kexec_handover.h     |  10 +++
 kernel/liveupdate/kexec_handover.c | 101 +++++++++++++++++++++++++----
 2 files changed, 98 insertions(+), 13 deletions(-)

diff --git a/include/linux/kexec_handover.h b/include/linux/kexec_handover.h
index 8968c56d2d73..6e2c75b16209 100644
--- a/include/linux/kexec_handover.h
+++ b/include/linux/kexec_handover.h
@@ -22,6 +22,8 @@ bool is_kho_boot(void);
 
 int kho_preserve_folio(struct folio *folio);
 void kho_unpreserve_folio(struct folio *folio);
+int kho_preserve_page(struct page *page, unsigned int order);
+void kho_unpreserve_page(struct page *page, unsigned int order);
 int kho_preserve_pages(struct page *page, unsigned long nr_pages);
 void kho_unpreserve_pages(struct page *page, unsigned long nr_pages);
 int kho_preserve_vmalloc(void *ptr, struct kho_vmalloc *preservation);
@@ -30,6 +32,7 @@ void *kho_alloc_preserve(size_t size);
 void kho_unpreserve_free(void *mem);
 void kho_restore_free(void *mem);
 struct folio *kho_restore_folio(phys_addr_t phys);
+struct page *kho_restore_page(phys_addr_t phys);
 struct page *kho_restore_pages(phys_addr_t phys, unsigned long nr_pages);
 void *kho_restore_vmalloc(const struct kho_vmalloc *preservation);
 int kho_add_subtree(const char *name, void *blob, size_t size);
@@ -65,6 +68,13 @@ static inline int kho_preserve_pages(struct page *page, unsigned int nr_pages)
 
 static inline void kho_unpreserve_pages(struct page *page, unsigned int nr_pages) { }
 
+static inline int kho_preserve_page(struct page *page, unsigned int order)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline void kho_unpreserve_page(struct page *page, unsigned int order) { }
+
 static inline int kho_preserve_vmalloc(void *ptr,
 				       struct kho_vmalloc *preservation)
 {
diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index e836efd98795..abe1a800fb27 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -393,10 +393,9 @@ static void kho_init_folio(struct page *page, unsigned int order)
 		prep_compound_page(page, order);
 }
 
-static struct page *kho_restore_page(phys_addr_t phys, bool is_folio)
+static struct page *__kho_restore_page(phys_addr_t phys, unsigned int *order)
 {
 	struct page *page = pfn_to_online_page(PHYS_PFN(phys));
-	unsigned long nr_pages;
 	union kho_page_info info;
 
 	if (!page)
@@ -410,17 +409,12 @@ static struct page *kho_restore_page(phys_addr_t phys, bool is_folio)
 	 */
 	if (WARN_ON_ONCE(info.magic != KHO_PAGE_MAGIC))
 		return NULL;
-	nr_pages = (1 << info.order);
 
 	/* Clear private to make sure later restores on this page error out. */
 	page->private = 0;
+	if (order)
+		*order = info.order;
 
-	if (is_folio)
-		kho_init_folio(page, info.order);
-	else
-		kho_init_pages(page, nr_pages);
-
-	adjust_managed_page_count(page, nr_pages);
 	return page;
 }
 
@@ -432,12 +426,43 @@ static struct page *kho_restore_page(phys_addr_t phys, bool is_folio)
  */
 struct folio *kho_restore_folio(phys_addr_t phys)
 {
-	struct page *page = kho_restore_page(phys, true);
+	unsigned int order;
+	struct page *page = __kho_restore_page(phys, &order);
+
+	if (!page)
+		return NULL;
+
+	kho_init_folio(page, order);
+	adjust_managed_page_count(page, 1UL << order);
 
-	return page ? page_folio(page) : NULL;
+	return page_folio(page);
 }
 EXPORT_SYMBOL_GPL(kho_restore_folio);
 
+/**
+ * kho_restore_page - restore a high-order page block.
+ * @phys: physical address of the first page.
+ *
+ * Restore a high-order page block that was preserved with
+ * kho_preserve_page().
+ *
+ * Return: the head page on success, NULL on failure.
+ */
+struct page *kho_restore_page(phys_addr_t phys)
+{
+	unsigned int order;
+	struct page *page = __kho_restore_page(phys, &order);
+
+	if (!page)
+		return NULL;
+
+	kho_init_high_order_page(page, order);
+	adjust_managed_page_count(page, 1UL << order);
+
+	return page;
+}
+EXPORT_SYMBOL_GPL(kho_restore_page);
+
 /**
  * kho_restore_pages - restore list of contiguous order 0 pages.
  * @phys: physical address of the first page.
@@ -457,10 +482,14 @@ struct page *kho_restore_pages(phys_addr_t phys, unsigned long nr_pages)
 	while (pfn < end_pfn) {
 		const unsigned int order =
 			min(count_trailing_zeros(pfn), ilog2(end_pfn - pfn));
-		struct page *page = kho_restore_page(PFN_PHYS(pfn), false);
+		unsigned int info_order;
+		struct page *page = __kho_restore_page(PFN_PHYS(pfn), &info_order);
 
 		if (!page)
 			return NULL;
+
+		kho_init_pages(page, 1UL << info_order);
+		adjust_managed_page_count(page, 1UL << info_order);
 		pfn += 1 << order;
 	}
 
@@ -890,6 +919,51 @@ void kho_unpreserve_folio(struct folio *folio)
 }
 EXPORT_SYMBOL_GPL(kho_unpreserve_folio);
 
+/**
+ * kho_preserve_page - preserve a high-order page block.
+ * @page: head page of the block.
+ * @order: order of the allocation.
+ *
+ * Instructs KHO to preserve a high-order contiguous allocation (like a DMA
+ * buffer) as a single unit. It must be restored using kho_restore_page() to
+ * ensure the tail pages are correctly initialized with a zero refcount.
+ *
+ * If a driver needs to split a block that has been preserved with this
+ * function, it must first unpreserve the block using kho_unpreserve_page(),
+ * perform the split, and then re-preserve the individual pages using
+ * kho_preserve_pages().
+ *
+ * Return: 0 on success, error code on failure
+ */
+int kho_preserve_page(struct page *page, unsigned int order)
+{
+	struct kho_radix_tree *tree = &kho_out.radix_tree;
+	const unsigned long pfn = page_to_pfn(page);
+
+	if (WARN_ON(kho_scratch_overlap(pfn << PAGE_SHIFT, PAGE_SIZE << order)))
+		return -EINVAL;
+
+	return kho_radix_add_page(tree, pfn, order);
+}
+EXPORT_SYMBOL_GPL(kho_preserve_page);
+
+/**
+ * kho_unpreserve_page - unpreserve a high-order page block.
+ * @page: head page of the block.
+ * @order: order of the allocation.
+ *
+ * Instructs KHO to unpreserve a high-order block that was preserved by
+ * kho_preserve_page() before.
+ */
+void kho_unpreserve_page(struct page *page, unsigned int order)
+{
+	struct kho_radix_tree *tree = &kho_out.radix_tree;
+	const unsigned long pfn = page_to_pfn(page);
+
+	kho_radix_del_page(tree, pfn, order);
+}
+EXPORT_SYMBOL_GPL(kho_unpreserve_page);
+
 static unsigned int __kho_preserve_pages_order(unsigned long start_pfn,
 					       unsigned long end_pfn)
 {
@@ -927,7 +1001,8 @@ static void __kho_unpreserve(struct kho_radix_tree *tree,
  * @nr_pages: number of pages.
  *
  * Preserve a contiguous list of order 0 pages. Must be restored using
- * kho_restore_pages() to ensure the pages are restored properly as order 0.
+ * kho_restore_pages() to ensure the pages are restored properly as order 0
+ * with each page having a reference count of 1 (split).
  *
  * Return: 0 on success, error code on failure
  */
-- 
2.55.0.229.g6434b31f56-goog


