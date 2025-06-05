Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA55EC5B543
	for <kexec@archiver.kernel.org>; Thu,  5 Jun 2025 17:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=HUIdxLZVlGKYPzPaiql8BkW+cbh+sLZLtwTEG7vOauI=; b=PC+3Gdo7Uo4st2mtK8icnhX/PM
	k4UN9raMJRjoEgmlI//6BKTUuH9FPOb/o0bCcj2sNiHtnwNSIW6YkIzOYVoHzLOFtz3pn8SIUUDkI
	OawA6WqOHyQcTYXlByTWM7LqoOD3Jcbfy5KXtQvt1pv/KypQWicCJ/xKW1WcDxJoHVafMFlH7JNVe
	YKhfWSJKj3Ss9VCOXdEjM4CXRWlNQvyN9yGGy6WSuGEWz5DOGvENnpatayu9lVMWT2l97z+8vT+kA
	qr0owCavh6mpXH/RSjZ8lXVg1He/rj5aH8R23htqVxunYd5SVZpFKK3+W4efAz22fEh8YEcZA9yJ5
	4o2iUCgQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uNE8I-0000000G78p-3yhf;
	Thu, 05 Jun 2025 17:12:02 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uNE8F-0000000G78E-3nIM
	for kexec@lists.infradead.org;
	Thu, 05 Jun 2025 17:12:00 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 2A6C444B85;
	Thu,  5 Jun 2025 17:11:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99E6CC4CEE7;
	Thu,  5 Jun 2025 17:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749143518;
	bh=VPsAJMShnkum23FOlcYAYrO6mPJpYIio8qbx3qLulTc=;
	h=From:To:Cc:Subject:Date:From;
	b=MZ8KEY1FI3aFivdxmS7v0djgk2VpJnaC42fl+leC/Zl18zX+AGyshM3gDqhXeufJy
	 omlf7gLJ2ExTjIpEx5foYIX+0tQw3jbHQHTWDgYqQPlcou2pXsHFH7SAmlXNM0WFLZ
	 umbmzHnQykgrTLVgDoc2e4CUuHoWoO8gQQ9FrmfT5Dv4DW8V+Yh7rXLyqpZH+76Nm+
	 SnODbW3kndfYmOXL33LHBAvPwuHp7Ld5nvpzAcTCXc2vbD9p5qlRQZRlFJwC/HLXIw
	 X7QYxW2cgJ9bU/Yro+k4A63ZFedpSKo4+MeYy8ETFSIYNUBDaFOAKVEKtWoSCnOhQW
	 G9ayP+IVU24fg==
From: Pratyush Yadav <pratyush@kernel.org>
To: Alexander Graf <graf@amazon.com>,
	Mike Rapoport <rppt@kernel.org>,
	Changyuan Lyu <changyuanl@google.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>
Cc: Pratyush Yadav <ptyadav@amazon.de>,
	kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH] kho: initialize tail pages for higher order folios properly
Date: Thu,  5 Jun 2025 19:11:41 +0200
Message-ID: <20250605171143.76963-1-pratyush@kernel.org>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250605_101159_985681_74D075FF 
X-CRM114-Status: GOOD (  16.32  )
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

From: Pratyush Yadav <ptyadav@amazon.de>

Currently, when restoring higher order folios, kho_restore_folio() only
calls prep_compound_page() on all the pages. That is not enough to
properly initialize the folios. The managed page count does not
get updated, the reserved flag does not get dropped, and page count does
not get initialized properly.

Restoring a higher order folio with it results in the following BUG with
CONFIG_DEBUG_VM when attempting to free the folio:

    BUG: Bad page state in process test  pfn:104e2b
    page: refcount:1 mapcount:0 mapping:0000000000000000 index:0xffffffffffffffff pfn:0x104e2b
    flags: 0x2fffff80000000(node=0|zone=2|lastcpupid=0x1fffff)
    raw: 002fffff80000000 0000000000000000 00000000ffffffff 0000000000000000
    raw: ffffffffffffffff 0000000000000000 00000001ffffffff 0000000000000000
    page dumped because: nonzero _refcount
    [...]
    Call Trace:
    <TASK>
    dump_stack_lvl+0x4b/0x70
    bad_page.cold+0x97/0xb2
    __free_frozen_pages+0x616/0x850
    [...]

Combine the path for 0-order and higher order folios, initialize the
tail pages with a count of zero, and call adjust_managed_page_count() to
account for all the pages instead of just missing them.

In addition, since all the KHO-preserved pages get marked with
MEMBLOCK_RSRV_NOINIT by deserialize_bitmap(), the reserved flag is not
actually set (as can also be seen from the flags of the dumped page in
the logs above). So drop the ClearPageReserved() calls.

Fixes: fc33e4b44b271 ("kexec: enable KHO support for memory preservation")
Signed-off-by: Pratyush Yadav <ptyadav@amazon.de>
---

Side note: get_maintainers.pl for KHO only lists kexec@ as the mailing list.
Since KHO has a bunch of MM bits as well, should we also add linux-mm@ to its
MAINTAINERS entry?

Adding linux-mm@ to this patch at least, in case MM people have an opinion on
this.

 kernel/kexec_handover.c | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/kernel/kexec_handover.c b/kernel/kexec_handover.c
index eb305e7e61296..5214ab27d1f8d 100644
--- a/kernel/kexec_handover.c
+++ b/kernel/kexec_handover.c
@@ -157,11 +157,21 @@ static int __kho_preserve_order(struct kho_mem_track *track, unsigned long pfn,
 }

 /* almost as free_reserved_page(), just don't free the page */
-static void kho_restore_page(struct page *page)
+static void kho_restore_page(struct page *page, unsigned int order)
 {
-	ClearPageReserved(page);
-	init_page_count(page);
-	adjust_managed_page_count(page, 1);
+	unsigned int i, nr_pages = (1 << order);
+
+	/* Head page gets refcount of 1. */
+	set_page_count(page, 1);
+
+	/* For higher order folios, tail pages get a page count of zero. */
+	for (i = 1; i < nr_pages; i++)
+		set_page_count(page + i, 0);
+
+	if (order > 0)
+		prep_compound_page(page, order);
+
+	adjust_managed_page_count(page, nr_pages);
 }

 /**
@@ -179,15 +189,10 @@ struct folio *kho_restore_folio(phys_addr_t phys)
 		return NULL;

 	order = page->private;
-	if (order) {
-		if (order > MAX_PAGE_ORDER)
-			return NULL;
-
-		prep_compound_page(page, order);
-	} else {
-		kho_restore_page(page);
-	}
+	if (order > MAX_PAGE_ORDER)
+		return NULL;

+	kho_restore_page(page, order);
 	return page_folio(page);
 }
 EXPORT_SYMBOL_GPL(kho_restore_folio);
--
2.47.1


