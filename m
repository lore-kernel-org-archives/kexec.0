Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0E6BD48984
	for <kexec@archiver.kernel.org>; Fri, 16 Jan 2026 11:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WQowesb/8YsfOv/DKmWEb8eNP0xlm20yGa3uGhlbhQo=; b=nM4Woz1SYT1lnSaEySdbrqFtqH
	QpSZCxhlwzqJsJuqSTOmVzA+omWUoac+NY5sixfQvlbxKV3HMmQ4976cmziGbCfkUMSwxqTLYVcjp
	1V6lV2QiGEpNQf1E7TC15aVHGl6ZL16vpckj1prK7gEEDi09bf339c5+JFPbYD3l3AONLwTQfDLcg
	mfviqriVacsNZVVzTKXqxASDY9kSGgsWmDZFx3P7FXLrIovYDGr2HCV9VW/9VkEFGkf0e4MN00ZLa
	BauKEkLNQyF2VexBZV+0YHddvouE2QWbAcA49fMsVyZbvP84JSyspUeX97U+LXYevqmz1hkUggMeM
	0mwZ+L5A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vghuU-0000000E2g8-0QhU;
	Fri, 16 Jan 2026 11:22:34 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vghuS-0000000E2fD-2aVR
	for kexec@lists.infradead.org;
	Fri, 16 Jan 2026 11:22:33 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 663BB43C78;
	Fri, 16 Jan 2026 11:22:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFA12C116C6;
	Fri, 16 Jan 2026 11:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768562551;
	bh=tCtXq7BO4v6qCmECL0o+wXPIF7pMwPBxgUjHzekhM/8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r0p+LPouc1TxNkjL5n0a74F/8lySb/XPmBfoo4ophrABJu1LgZzCLRDHzCAQ+efhx
	 CDJSH4lDGs4vhv9P+8W5YyZoi5mcssI9wzDQlhD61aZ3v8KJo9D/AO/kfw5WnvxrVy
	 rvFDWih5VS8rXd+FEH904ritvGEl5GyaEPCTC5/JHHHtG4reFM8IvZiL6iDVZiRGis
	 6iMdZr5ZvnZS+i7l74B48UkDvmbfzZeJGDTqD0uZeyJxQHI2gvhP0XAwHQsFbMmckP
	 k/wyduWnsawJFxv5WctNrWJmU/9y8HO8yQWb7DH9KMQZW5cbe0aBJBl0L6e57vdWqo
	 6VZ1624Z8eLPg==
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
Subject: [PATCH v2 1/2] kho: use unsigned long for nr_pages
Date: Fri, 16 Jan 2026 11:22:14 +0000
Message-ID: <20260116112217.915803-2-pratyush@kernel.org>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
In-Reply-To: <20260116112217.915803-1-pratyush@kernel.org>
References: <20260116112217.915803-1-pratyush@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260116_032232_697407_A8E705B9 
X-CRM114-Status: GOOD (  13.13  )
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

With 4k pages, a 32-bit nr_pages can span up to 16 TiB. While it is a
lot, there exist systems with terabytes of RAM. gup is also moving to
using long for nr_pages. Use unsigned long and make KHO future-proof.

Suggested-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Signed-off-by: Pratyush Yadav <pratyush@kernel.org>
---

Changes in v2:
- New in v2.

 include/linux/kexec_handover.h     |  6 +++---
 kernel/liveupdate/kexec_handover.c | 11 ++++++-----
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/include/linux/kexec_handover.h b/include/linux/kexec_handover.h
index 5f7b9de97e8d..81814aa92370 100644
--- a/include/linux/kexec_handover.h
+++ b/include/linux/kexec_handover.h
@@ -45,15 +45,15 @@ bool is_kho_boot(void);
 
 int kho_preserve_folio(struct folio *folio);
 void kho_unpreserve_folio(struct folio *folio);
-int kho_preserve_pages(struct page *page, unsigned int nr_pages);
-void kho_unpreserve_pages(struct page *page, unsigned int nr_pages);
+int kho_preserve_pages(struct page *page, unsigned long nr_pages);
+void kho_unpreserve_pages(struct page *page, unsigned long nr_pages);
 int kho_preserve_vmalloc(void *ptr, struct kho_vmalloc *preservation);
 void kho_unpreserve_vmalloc(struct kho_vmalloc *preservation);
 void *kho_alloc_preserve(size_t size);
 void kho_unpreserve_free(void *mem);
 void kho_restore_free(void *mem);
 struct folio *kho_restore_folio(phys_addr_t phys);
-struct page *kho_restore_pages(phys_addr_t phys, unsigned int nr_pages);
+struct page *kho_restore_pages(phys_addr_t phys, unsigned long nr_pages);
 void *kho_restore_vmalloc(const struct kho_vmalloc *preservation);
 int kho_add_subtree(const char *name, void *fdt);
 void kho_remove_subtree(void *fdt);
diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index 9dc51fab604f..709484fbf9fd 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -222,7 +222,8 @@ static int __kho_preserve_order(struct kho_mem_track *track, unsigned long pfn,
 static struct page *kho_restore_page(phys_addr_t phys, bool is_folio)
 {
 	struct page *page = pfn_to_online_page(PHYS_PFN(phys));
-	unsigned int nr_pages, ref_cnt;
+	unsigned long nr_pages;
+	unsigned int ref_cnt;
 	union kho_page_info info;
 
 	if (!page)
@@ -249,7 +250,7 @@ static struct page *kho_restore_page(phys_addr_t phys, bool is_folio)
 	 * count of 1
 	 */
 	ref_cnt = is_folio ? 0 : 1;
-	for (unsigned int i = 1; i < nr_pages; i++)
+	for (unsigned long i = 1; i < nr_pages; i++)
 		set_page_count(page + i, ref_cnt);
 
 	if (is_folio && info.order)
@@ -283,7 +284,7 @@ EXPORT_SYMBOL_GPL(kho_restore_folio);
  *
  * Return: 0 on success, error code on failure
  */
-struct page *kho_restore_pages(phys_addr_t phys, unsigned int nr_pages)
+struct page *kho_restore_pages(phys_addr_t phys, unsigned long nr_pages)
 {
 	const unsigned long start_pfn = PHYS_PFN(phys);
 	const unsigned long end_pfn = start_pfn + nr_pages;
@@ -829,7 +830,7 @@ EXPORT_SYMBOL_GPL(kho_unpreserve_folio);
  *
  * Return: 0 on success, error code on failure
  */
-int kho_preserve_pages(struct page *page, unsigned int nr_pages)
+int kho_preserve_pages(struct page *page, unsigned long nr_pages)
 {
 	struct kho_mem_track *track = &kho_out.track;
 	const unsigned long start_pfn = page_to_pfn(page);
@@ -873,7 +874,7 @@ EXPORT_SYMBOL_GPL(kho_preserve_pages);
  * kho_preserve_pages() call. Unpreserving arbitrary sub-ranges of larger
  * preserved blocks is not supported.
  */
-void kho_unpreserve_pages(struct page *page, unsigned int nr_pages)
+void kho_unpreserve_pages(struct page *page, unsigned long nr_pages)
 {
 	struct kho_mem_track *track = &kho_out.track;
 	const unsigned long start_pfn = page_to_pfn(page);
-- 
2.52.0.457.g6b5491de43-goog


