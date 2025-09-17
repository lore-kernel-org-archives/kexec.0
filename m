Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B72A1CAC59A
	for <kexec@archiver.kernel.org>; Wed, 17 Sep 2025 17:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oxL33bY1eMpOBypry9V61ZfTJHnEZnydPGdbjs5GTFA=; b=xDsGGnxlVaBtdy7eEdl1UwL8Uy
	pnLstfMypC0PwW1AfZK38xR9NMskZkzae9x0fzKSbQnnhUz6qKp2TZ9jo/g3GV+JYirmXgQxCwwMQ
	M09bWU/xuGdrpmX0/KW6IZrYbxtwCo2EsjiBFaVjIPVyov4rnL0VQBeO/tFf8MbAowDo3QxPMxp00
	zqDa074TpIv7ka+w8rCSb6tZxv/ig2jFunFaGlJrF3/aY4tIw7QesjhkcDNA88xW3MUWAStnyeehV
	r9EJaYFX+RdGECUqnUq1wSpDY50NgDA63Ot3YfsUFBBxP7aJW7nhWvwr+L+TlE8p5RRDQzYoTIVra
	9nPyYBEg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyw9B-0000000DfIW-3Y8N;
	Wed, 17 Sep 2025 17:40:49 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyw9B-0000000DfHB-0Quu
	for kexec@lists.infradead.org;
	Wed, 17 Sep 2025 17:40:49 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 81F2B60245;
	Wed, 17 Sep 2025 17:40:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CD38C4CEE7;
	Wed, 17 Sep 2025 17:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758130848;
	bh=q/t3uKKPwUDe/VS493c2y7ty/sgLNnbkDT1wsgUidLE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YWNVC2+NhhjJf+hD1kotVftCFqdoDZkFLt5It7TUxiKYJRf3UOOfk0X3WW8ki+GiX
	 KkU1fJdKFjt9BzSmWLeuCYwjt+e5EmLTt0jbv4eGIc44Ha62Nipr9/l+cYYwTIZ7pX
	 tItwXA4/CVyvwh6t9CLCgV2Kao+l46eSUIVQisWIuqc2ovOv6znBhwjiRvCvTE7BGa
	 W/bqshWp76kkI/KnmtBOrXYSUndLrW+96geZMRXLsVFn198LIzSNc1qw+8aBnnS/oX
	 xEVuk4XZ9Jrn29sG+OgcUNu9/KuS4NoQpBVAWeqqZibjpWtG7MXZEQWmZkcdmZbwgC
	 C0mR3JWJch7gQ==
From: Mike Rapoport <rppt@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexander Graf <graf@amazon.com>,
	Baoquan He <bhe@redhat.com>,
	Changyuan Lyu <changyuanl@google.com>,
	Chris Li <chrisl@kernel.org>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	kexec@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/4] kho: replace kho_preserve_phys() with kho_preserve_pages()
Date: Wed, 17 Sep 2025 20:40:31 +0300
Message-ID: <20250917174033.3810435-3-rppt@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250917174033.3810435-1-rppt@kernel.org>
References: <20250917174033.3810435-1-rppt@kernel.org>
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

From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>

to make it clear that KHO operates on pages rather than on a random
physical address.

The kho_preserve_pages() will be also used in upcoming support for
vmalloc preservation.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 include/linux/kexec_handover.h |  5 +++--
 kernel/kexec_handover.c        | 25 +++++++++++--------------
 mm/memblock.c                  |  4 +++-
 3 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/include/linux/kexec_handover.h b/include/linux/kexec_handover.h
index 348844cffb13..cc5c49b0612b 100644
--- a/include/linux/kexec_handover.h
+++ b/include/linux/kexec_handover.h
@@ -18,6 +18,7 @@ enum kho_event {
 
 struct folio;
 struct notifier_block;
+struct page;
 
 #define DECLARE_KHOSER_PTR(name, type) \
 	union {                        \
@@ -42,7 +43,7 @@ struct kho_serialization;
 bool kho_is_enabled(void);
 
 int kho_preserve_folio(struct folio *folio);
-int kho_preserve_phys(phys_addr_t phys, size_t size);
+int kho_preserve_pages(struct page *page, unsigned int nr_pages);
 struct folio *kho_restore_folio(phys_addr_t phys);
 int kho_add_subtree(struct kho_serialization *ser, const char *name, void *fdt);
 int kho_retrieve_subtree(const char *name, phys_addr_t *phys);
@@ -65,7 +66,7 @@ static inline int kho_preserve_folio(struct folio *folio)
 	return -EOPNOTSUPP;
 }
 
-static inline int kho_preserve_phys(phys_addr_t phys, size_t size)
+static inline int kho_preserve_pages(struct page *page, unsigned int nr_pages)
 {
 	return -EOPNOTSUPP;
 }
diff --git a/kernel/kexec_handover.c b/kernel/kexec_handover.c
index f421acc58c1f..3ad59c5f9eaa 100644
--- a/kernel/kexec_handover.c
+++ b/kernel/kexec_handover.c
@@ -698,26 +698,23 @@ int kho_preserve_folio(struct folio *folio)
 EXPORT_SYMBOL_GPL(kho_preserve_folio);
 
 /**
- * kho_preserve_phys - preserve a physically contiguous range across kexec.
- * @phys: physical address of the range.
- * @size: size of the range.
+ * kho_preserve_pages - preserve contiguous pages across kexec
+ * @page: first page in the list.
+ * @nr_pages: number of pages.
  *
- * Instructs KHO to preserve the memory range from @phys to @phys + @size
- * across kexec.
+ * Preserve a contiguous list of order 0 pages. Must be restored using
+ * kho_restore_page() on each order 0 page.
  *
  * Return: 0 on success, error code on failure
  */
-int kho_preserve_phys(phys_addr_t phys, size_t size)
+int kho_preserve_pages(struct page *page, unsigned int nr_pages)
 {
-	unsigned long pfn = PHYS_PFN(phys);
+	struct kho_mem_track *track = &kho_out.ser.track;
+	const unsigned long start_pfn = page_to_pfn(page);
+	const unsigned long end_pfn = start_pfn + nr_pages;
+	unsigned long pfn = start_pfn;
 	unsigned long failed_pfn = 0;
-	const unsigned long start_pfn = pfn;
-	const unsigned long end_pfn = PHYS_PFN(phys + size);
 	int err = 0;
-	struct kho_mem_track *track = &kho_out.ser.track;
-
-	if (!PAGE_ALIGNED(phys) || !PAGE_ALIGNED(size))
-		return -EINVAL;
 
 	while (pfn < end_pfn) {
 		const unsigned int order =
@@ -737,7 +734,7 @@ int kho_preserve_phys(phys_addr_t phys, size_t size)
 
 	return err;
 }
-EXPORT_SYMBOL_GPL(kho_preserve_phys);
+EXPORT_SYMBOL_GPL(kho_preserve_pages);
 
 /* Handling for debug/kho/out */
 
diff --git a/mm/memblock.c b/mm/memblock.c
index 117d963e677c..6ec3eaa4e8d1 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -2516,8 +2516,10 @@ static int reserve_mem_kho_finalize(struct kho_serialization *ser)
 
 	for (i = 0; i < reserved_mem_count; i++) {
 		struct reserve_mem_table *map = &reserved_mem_table[i];
+		struct page *page = phys_to_page(map->start);
+		unsigned int nr_pages = map->size >> PAGE_SHIFT;
 
-		err |= kho_preserve_phys(map->start, map->size);
+		err |= kho_preserve_pages(page, nr_pages);
 	}
 
 	err |= kho_preserve_folio(page_folio(kho_fdt));
-- 
2.50.1


