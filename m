Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36E92C43458
	for <kexec@archiver.kernel.org>; Mon, 13 Jul 2026 20:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xzJzBgZ7BaDqZpOvHA29oVPMSyBnofRxze7m51B0LYQ=; b=vuHTSrTxPFX2yXQ9LmONOkoSWE
	pgluNqYqPgmFZo7GpdNTe1PcRxP2eomOctXnzAxfJCFFGFK07ZnUj+nQbUwNNnvwC6wmGjzcPy1kW
	pCJwcrvMJLSiK/xmYllxz0PRE9Lu9PBa1k6rsxK+4NMcbHEaZjmd/ypMs4KVBkS5+D1pblLa3BE0I
	FVJ4hk0egw34l5NKBRIYxaE15A8M9sDLWNbce0fMBVfKPQwer6GWg65LcERo/pfbikRpSgPnFma0x
	GcJCByrit9JZnMoimX+p2wAWHprYEkRuOoQCtuYt+W76hNujeHiHK9uENVxznlTjSlQoMspOWeuK5
	R+mt/zMA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjNb0-0000000APU1-0o2g;
	Mon, 13 Jul 2026 20:49:46 +0000
Received: from mail-pf1-x44a.google.com ([2607:f8b0:4864:20::44a])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjNay-0000000APSs-1BZf
	for kexec@lists.infradead.org;
	Mon, 13 Jul 2026 20:49:45 +0000
Received: by mail-pf1-x44a.google.com with SMTP id d2e1a72fcca58-8484b57b98bso6974838b3a.0
        for <kexec@lists.infradead.org>; Mon, 13 Jul 2026 13:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783975783; x=1784580583; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xzJzBgZ7BaDqZpOvHA29oVPMSyBnofRxze7m51B0LYQ=;
        b=b3uhnwKFqNn9oBP4D3BgyZC9aKVR3nLjcfBBh02wf4u9d2FW91PUwTwZxshpPC0LRB
         +UIkkiHAi4WDIzCp4rieSbykLs8e3Pfp1n87dmWhPr9fVx1gLOhVjN3sQWx3P2uGojQf
         mFxdPv6cL+J40iL/dggpiZ7gaGwyxP+2Apq1DY0WJrQKpantzor5VFVRtJTqAv5MkV5Q
         l+FAXjDgqTY51CieHZRmNwY65JzlyUg2TsFKqDlP/AmCiSQywSjE2wi7BLBdijOz1Fml
         m/eh+guI2O0uYHUauAaOykxxk7fxxB87lBgLt0vu4XRA+Iq1VMrIfla8sFqjhDUPlVC5
         9tBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783975783; x=1784580583;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xzJzBgZ7BaDqZpOvHA29oVPMSyBnofRxze7m51B0LYQ=;
        b=MaoLkx5ycclyMWzizcqHO5PvugAqBXrYFiWygsH8xeMmKlFVjO6UDEgsW5tBHlaPbX
         VDhBhFkukzWhZjLtlfPZ4rxArVjs+TjhF/PxIGd3i5F3sTfPpLdPwIrU1j3L6iIfWcHY
         kZ7ksOd97qSHu36747Dp3HlDcQhk/BXY6yEKT+ynua+dEKi82B1wQxNsBIiJqYz0cJBN
         PUvMvSM6zq91mcd26btXtmD0SqplN9Sbib5b5mzQPFIls2jydpq01jFnPfclmbCEc6wt
         yU4hjwZME+2k+cx9bQFqBNsfcQGaPxe+ok9ZdNDl6fzH4c/0Wa0ZgrVGyQWPrAYhP+r+
         nXuw==
X-Forwarded-Encrypted: i=1; AHgh+Rr/JMQ/Mc6uy5zRxUB1GtoshpOpuI+ET4N6s9tTlR6GKUo/hinP8wiyFFETDeNyjCxnW7k9dw==@lists.infradead.org
X-Gm-Message-State: AOJu0Yy4YUM0vCqDF7cNh4UeH5I/27v1lNr7rTlI7PSJhhp/onZztjBU
	m9UqK3UIBKMa3EiNacsPubAY8jv2cqQ4fFioAh+r/XREKrRAiqGR/wVqNOk7VnGWNMXbwAUDTn6
	tgw==
X-Received: from pgh2.prod.google.com ([2002:a05:6a02:4e02:b0:c86:2164:9671])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:c6cb:b0:3aa:c964:3c27
 with SMTP id adf61e73a8af0-3c34d719d0bmr820808637.46.1783975782789; Mon, 13
 Jul 2026 13:49:42 -0700 (PDT)
Date: Mon, 13 Jul 2026 20:49:35 +0000
In-Reply-To: <20260713204935.3069000-1-praan@google.com>
Mime-Version: 1.0
References: <20260713204935.3069000-1-praan@google.com>
X-Mailer: git-send-email 2.55.0.141.g00534a21ce-goog
Message-ID: <20260713204935.3069000-3-praan@google.com>
Subject: [RFC PATCH v2 2/2] kho: Introduce preserve/restore APIs for unsplit pages
From: Pranjal Shrivastava <praan@google.com>
To: Mike Rapoport <rppt@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pratyush Yadav <pratyush@kernel.org>
Cc: Alexander Graf <graf@amazon.com>, Samiullah Khawaja <skhawaja@google.com>, 
	David Matlack <dmatlack@google.com>, kexec@lists.infradead.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Pranjal Shrivastava <praan@google.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260713_134944_333083_E0917809 
X-CRM114-Status: GOOD (  19.50  )
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

Introduce explicit preserve and restore APIs for unsplit pages,
which preserve and restore a high-order page block as a single unit,
applying a refcount of 1 to the head page while leaving tail pages at 0.
Rename the existing internal helper to __kho_restore_page().

Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 include/linux/kexec_handover.h     | 10 ++++
 kernel/liveupdate/kexec_handover.c | 86 ++++++++++++++++++++++++++++--
 2 files changed, 92 insertions(+), 4 deletions(-)

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
index 07f6f453cd69..43ae3e2de5da 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -393,7 +393,7 @@ static void kho_init_folio(struct page *page, unsigned int order)
 		prep_compound_page(page, order);
 }
 
-static struct page *kho_restore_page(phys_addr_t phys, bool is_folio)
+static struct page *__kho_restore_page(phys_addr_t phys, bool is_folio)
 {
 	struct page *page = pfn_to_online_page(PHYS_PFN(phys));
 	unsigned long nr_pages;
@@ -432,12 +432,44 @@ static struct page *kho_restore_page(phys_addr_t phys, bool is_folio)
  */
 struct folio *kho_restore_folio(phys_addr_t phys)
 {
-	struct page *page = kho_restore_page(phys, true);
+	struct page *page = __kho_restore_page(phys, true);
 
 	return page ? page_folio(page) : NULL;
 }
 EXPORT_SYMBOL_GPL(kho_restore_folio);
 
+/**
+ * kho_restore_page - restore a higher-order unsplit page block.
+ * @phys: physical address of the first page.
+ *
+ * Restore a higher-order unsplit page block that was preserved with
+ * kho_preserve_page().
+ *
+ * Return: the head page on success, NULL on failure.
+ */
+struct page *kho_restore_page(phys_addr_t phys)
+{
+	struct page *page = pfn_to_online_page(PHYS_PFN(phys));
+	unsigned long nr_pages;
+	union kho_page_info info;
+
+	if (!page)
+		return NULL;
+
+	info.page_private = page->private;
+	if (WARN_ON_ONCE(info.magic != KHO_PAGE_MAGIC))
+		return NULL;
+
+	nr_pages = (1UL << info.order);
+	page->private = 0;
+
+	kho_init_unsplit_pages(page, info.order);
+	adjust_managed_page_count(page, nr_pages);
+
+	return page;
+}
+EXPORT_SYMBOL_GPL(kho_restore_page);
+
 /**
  * kho_restore_pages - restore list of contiguous order 0 pages.
  * @phys: physical address of the first page.
@@ -457,7 +489,7 @@ struct page *kho_restore_pages(phys_addr_t phys, unsigned long nr_pages)
 	while (pfn < end_pfn) {
 		const unsigned int order =
 			min(count_trailing_zeros(pfn), ilog2(end_pfn - pfn));
-		struct page *page = kho_restore_page(PFN_PHYS(pfn), false);
+		struct page *page = __kho_restore_page(PFN_PHYS(pfn), false);
 
 		if (!page)
 			return NULL;
@@ -890,6 +922,51 @@ void kho_unpreserve_folio(struct folio *folio)
 }
 EXPORT_SYMBOL_GPL(kho_unpreserve_folio);
 
+/**
+ * kho_preserve_page - preserve a higher-order "unsplit" page block.
+ * @page: head page of the block.
+ * @order: order of the allocation.
+ *
+ * Instructs KHO to preserve a higher-order contiguous allocation (like a DMA
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
+ * kho_unpreserve_page - unpreserve a higher-order "unsplit" page block.
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
@@ -927,7 +1004,8 @@ static void __kho_unpreserve(struct kho_radix_tree *tree,
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
2.55.0.141.g00534a21ce-goog


