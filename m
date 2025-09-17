Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 874F7CAC59D
	for <kexec@archiver.kernel.org>; Wed, 17 Sep 2025 12:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=f1DrSt92L0rrSp7vsZbUR3c3nbZ+vkvUSgLPx2Xn96A=; b=QUwFOL5T2oRrnXQ5SfHCI9bpGB
	FsAG+aUTYLbUFSTS86I6bu6wZyCqWTjY4Ac7X2pYU59cBsCsR00WM/zeGNi/OxGZfM44Kbv+dbPFr
	hfOZSZJuodzLik2LjpoT1XnNnbasA4tiFXmJUVq4j+sFu03JKbM+QGsTCrhucV38EVNfbb17+W73X
	sNk55hbkv9i5ELfB8XJVmRqEtV6N9giMzkNnG+Q/krOGO48yoCVFkR8GeKT4BQh7p04jziFQVz5Fm
	XbJhqmyi67FZGuGz17VHS+dHCTwzW0/CnqtsFVYBP4eaAN9hDsHRlWXYe+xfiCS3fKpkfp4Zn/Oae
	z6C2T03w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyrjA-0000000BTnR-3CiM;
	Wed, 17 Sep 2025 12:57:40 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyrj8-0000000BTm0-0UOn
	for kexec@lists.infradead.org;
	Wed, 17 Sep 2025 12:57:39 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 40CC344A32;
	Wed, 17 Sep 2025 12:57:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CA04C4CEF0;
	Wed, 17 Sep 2025 12:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758113857;
	bh=bVQjh4jiUS12TD+kXPcBc3hIfzoE7mbPAz8+HVg3K0U=;
	h=From:To:Cc:Subject:Date:From;
	b=jKDCpqxrnNtPb3D6338CB7uyKFGcRN9WGPbj3Df0XsYjlUo8y+qkSy8lcqNPNeJxg
	 drm0UKWmmE5vcbRMPvNbrbH28B4MgKh2k1A+SW91COElH+SNM9gBOGY0AHR2PEIO/0
	 uXt+OsBA3Gjbv/u2A5d4t9bWpHnLe4aMDrBEV9iWTJylLVIIEISk/J8v8ASFJf4kZe
	 hof3guPEvNve21kEJ8h5hDC/B2BIM1/dUWtYxiMJv5Fwg08HB9R1T9Y6wk8TCOFmez
	 SWqZglHXOb8AfaGhHDznRI1zByLsENoS99NFWM1+6DUtuJd9JKHfeVOzHK7aBmAcbP
	 KC5lPlEjnq1MQ==
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
Subject: [PATCH v2 1/2] kho: move sanity checks to kho_restore_page()
Date: Wed, 17 Sep 2025 14:56:53 +0200
Message-ID: <20250917125725.665-1-pratyush@kernel.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250917_055738_191928_5A896CC3 
X-CRM114-Status: GOOD (  13.14  )
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

While KHO exposes folio as the primitive externally, internally its
restoration machinery operates on pages. This can be seen with
kho_restore_folio() for example. It performs some sanity checks and
hands it over to kho_restore_page() to do the heavy lifting of page
restoration. After the work done by kho_restore_page(),
kho_restore_folio() only converts the head page to folio and returns it.
Similarly, deserialize_bitmap() operates on the head page directly to
store the order.

Move the sanity checks for valid phys and order from the public-facing
kho_restore_folio() to the private-facing kho_restore_page(). This makes
the boundary between page and folio clearer from KHO's perspective.

While at it, drop the comment above kho_restore_page(). The comment is
misleading now. The function stopped looking like free_reserved_page()
since 12b9a2c05d1b4 ("kho: initialize tail pages for higher order folios
properly"), and now looks even more different.

Signed-off-by: Pratyush Yadav <pratyush@kernel.org>
---

Notes:
    Changes in v2:
    
    - New in v2.

 kernel/kexec_handover.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/kernel/kexec_handover.c b/kernel/kexec_handover.c
index ecd1ac210dbd7..69cab82abaaef 100644
--- a/kernel/kexec_handover.c
+++ b/kernel/kexec_handover.c
@@ -183,10 +183,18 @@ static int __kho_preserve_order(struct kho_mem_track *track, unsigned long pfn,
 	return 0;
 }
 
-/* almost as free_reserved_page(), just don't free the page */
-static void kho_restore_page(struct page *page, unsigned int order)
+static struct page *kho_restore_page(phys_addr_t phys)
 {
-	unsigned int nr_pages = (1 << order);
+	struct page *page = pfn_to_online_page(PHYS_PFN(phys));
+	unsigned int nr_pages, order;
+
+	if (!page)
+		return NULL;
+
+	order = page->private;
+	if (order > MAX_PAGE_ORDER)
+		return NULL;
+	nr_pages = (1 << order);
 
 	/* Head page gets refcount of 1. */
 	set_page_count(page, 1);
@@ -199,6 +207,7 @@ static void kho_restore_page(struct page *page, unsigned int order)
 		prep_compound_page(page, order);
 
 	adjust_managed_page_count(page, nr_pages);
+	return page;
 }
 
 /**
@@ -209,18 +218,9 @@ static void kho_restore_page(struct page *page, unsigned int order)
  */
 struct folio *kho_restore_folio(phys_addr_t phys)
 {
-	struct page *page = pfn_to_online_page(PHYS_PFN(phys));
-	unsigned long order;
-
-	if (!page)
-		return NULL;
-
-	order = page->private;
-	if (order > MAX_PAGE_ORDER)
-		return NULL;
+	struct page *page = kho_restore_page(phys);
 
-	kho_restore_page(page, order);
-	return page_folio(page);
+	return page ? page_folio(page) : NULL;
 }
 EXPORT_SYMBOL_GPL(kho_restore_folio);
 
-- 
2.47.3


