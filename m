Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71457CAC59A
	for <kexec@archiver.kernel.org>; Wed, 17 Sep 2025 12:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rysuZTNXGlhJ/pNo9I//zN6bxCAYHhYiKx0dmE9O/jQ=; b=3le4lZaSwTsa13RHQgr6rTFy67
	geEdD0ucamVsJ3+PHXrQFNzlrGneCGqZeUvRnytPMSDqGm9695vQVQxtvewzRvlDwIYyyKWtiXZgd
	u7w+HyuG0bo+TxUOyfwMTlewc40OnRHez9dArxlGzRCdXpplqCOq9cosBjFHBFY6iq25XbOnudyFa
	9smoxmJx37KFjfmdLYEVrUjwJy7hUBt5AwvJPpwcPK+rZTFk5daZ6nkcPnhukDQWbYGCK8JYhXhWx
	bkA97M4UTGx6zlUR7/aX7HFvtNGx9CveDqJRCM8H8tzN1b6h7CfCFHASWaMLYkiQkg8iqKAJ9ih8I
	9+cbbrXQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyrjC-0000000BToD-0O4y;
	Wed, 17 Sep 2025 12:57:42 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyrj9-0000000BTmg-2TJY
	for kexec@lists.infradead.org;
	Wed, 17 Sep 2025 12:57:40 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 4B05C44E68;
	Wed, 17 Sep 2025 12:57:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 707FEC4CEFA;
	Wed, 17 Sep 2025 12:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758113859;
	bh=r+p/fW1qMMIwpqKIwYaP72h2rsOOsXIYd5AWK52PFjM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MDhxPTlLBJEX7J3Lii/V9VX413VtE8eVKCNeBKb26X7SilRFKRMeS6RdKznIrZIwd
	 2mLPCzdmU41qnSN6vZ8XmntqKfRPB5hie55/t133keMIx5R0WSDyoxoBa5PYQHa+DQ
	 bS9al/X6rX1zlUQVFoHb2Jy7zSiDRVGyOHLvPX8WDleZw1R5t2KlSKU8NRCCzqyqjt
	 5mmwc8Ymr+ZlrYQ039KVM7csj2grE2DOVORw1MpBZjs+VzdwvGmfeRs6AQd52RfqXq
	 WSJd2tVRXZyqY808XSja7d79EhFySiEkJ6BjBW8MTcFVCDSEzQuEfWTMeSz/go9twm
	 i9+PHR6yWbvxw==
From: Pratyush Yadav <pratyush@kernel.org>
To: Alexander Graf <graf@amazon.com>,
	Mike Rapoport <rppt@kernel.org>,
	Changyuan Lyu <changyuanl@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Chris Li <chrisl@kernel.org>,
	Jason Miu <jasonmiu@google.com>
Cc: linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-mm@kvack.org
Subject: [PATCH v2 2/2] kho: make sure page being restored is actually from KHO
Date: Wed, 17 Sep 2025 14:56:54 +0200
Message-ID: <20250917125725.665-2-pratyush@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250917125725.665-1-pratyush@kernel.org>
References: <20250917125725.665-1-pratyush@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250917_055739_665921_66616559 
X-CRM114-Status: GOOD (  20.15  )
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

When restoring a page, no sanity checks are done to make sure the page
actually came from a kexec handover. The caller is trusted to pass in
the right address. If the caller has a bug and passes in a wrong
address, an in-use page might be "restored" and returned, causing all
sorts of memory corruption.

Harden the page restore logic by stashing in a magic number in
page->private along with the order. If the magic number does not match,
the page won't be touched. page->private is an unsigned long. The union
kho_page_info splits it into two parts, with one holding the order and
the other holding the magic number.

Signed-off-by: Pratyush Yadav <pratyush@kernel.org>
---

Notes:
    Changes in v2:
    
    - Add a WARN_ON_ONCE() if order or magic is invalid.
    - Add a comment explaining why the magic check also implicitly makes
      sure phys is order-aligned.
    - Clear page private to make sure later restores of the same page error
      out.
    - Move the checks to kho_restore_page() since patch 1 now moves sanity
      checking to it.

 kernel/kexec_handover.c | 41 ++++++++++++++++++++++++++++++++++-------
 1 file changed, 34 insertions(+), 7 deletions(-)

diff --git a/kernel/kexec_handover.c b/kernel/kexec_handover.c
index 69cab82abaaef..911fda8532b2e 100644
--- a/kernel/kexec_handover.c
+++ b/kernel/kexec_handover.c
@@ -32,6 +32,22 @@
 #define PROP_PRESERVED_MEMORY_MAP "preserved-memory-map"
 #define PROP_SUB_FDT "fdt"
 
+#define KHO_PAGE_MAGIC 0x4b484f50U /* ASCII for 'KHOP' */
+
+/*
+ * KHO uses page->private, which is an unsigned long, to store page metadata.
+ * Use it to store both the magic and the order.
+ */
+union kho_page_info {
+	unsigned long page_private;
+	struct {
+		unsigned int order;
+		unsigned int magic;
+	};
+};
+
+static_assert(sizeof(union kho_page_info) == sizeof(((struct page *)0)->private));
+
 static bool kho_enable __ro_after_init;
 
 bool kho_is_enabled(void)
@@ -186,16 +202,24 @@ static int __kho_preserve_order(struct kho_mem_track *track, unsigned long pfn,
 static struct page *kho_restore_page(phys_addr_t phys)
 {
 	struct page *page = pfn_to_online_page(PHYS_PFN(phys));
-	unsigned int nr_pages, order;
+	union kho_page_info info;
+	unsigned int nr_pages;
 
 	if (!page)
 		return NULL;
 
-	order = page->private;
-	if (order > MAX_PAGE_ORDER)
+	info.page_private = page->private;
+	/*
+	 * deserialize_bitmap() only sets the magic on the head page. This magic
+	 * check also implicitly makes sure phys is order-aligned since for
+	 * non-order-aligned phys addresses, magic will never be set.
+	 */
+	if (WARN_ON_ONCE(info.magic != KHO_PAGE_MAGIC || info.order > MAX_PAGE_ORDER))
 		return NULL;
-	nr_pages = (1 << order);
+	nr_pages = (1 << info.order);
 
+	/* Clear private to make sure later restores on this page error out. */
+	page->private = 0;
 	/* Head page gets refcount of 1. */
 	set_page_count(page, 1);
 
@@ -203,8 +227,8 @@ static struct page *kho_restore_page(phys_addr_t phys)
 	for (unsigned int i = 1; i < nr_pages; i++)
 		set_page_count(page + i, 0);
 
-	if (order > 0)
-		prep_compound_page(page, order);
+	if (info.order > 0)
+		prep_compound_page(page, info.order);
 
 	adjust_managed_page_count(page, nr_pages);
 	return page;
@@ -341,10 +365,13 @@ static void __init deserialize_bitmap(unsigned int order,
 		phys_addr_t phys =
 			elm->phys_start + (bit << (order + PAGE_SHIFT));
 		struct page *page = phys_to_page(phys);
+		union kho_page_info info;
 
 		memblock_reserve(phys, sz);
 		memblock_reserved_mark_noinit(phys, sz);
-		page->private = order;
+		info.magic = KHO_PAGE_MAGIC;
+		info.order = order;
+		page->private = info.page_private;
 	}
 }
 
-- 
2.47.3


