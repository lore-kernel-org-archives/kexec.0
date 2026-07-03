Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A66C1C43458
	for <kexec@archiver.kernel.org>; Fri,  3 Jul 2026 02:08:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=twAjwEQPJQoMPii2nLtsAn0UlOpk5gfqaTEPYw4GO2E=; b=GgVd241x/3vKXneBwiiB+2lGeM
	JbtivGRdlKsUBP/NQeYpVfJcyT2M+ZGT9eEZZWZJpPzzhHekoCRZGt3ZUkhBk0eM37xFp11TrdrmF
	Sn92kAYA0qYgzO6mdyPb+01DZabRkqd3uD88XyEbYjrEdVcj5byglTjC7OFPVi53DZLgaNjnU1Kvy
	lkeAAZx6IQO5A7EdjvXjlgeetWO8QXA+7bVPimlnjsMuvhv3mxuD2T8su1xHrNxYJp5LI0B2015Yq
	iah7p/SenkKuOfmDGVia7pVQ/XY0i9MKjz9qfzXEKeIxaFm55AUpAGfmu8zVbIyO2+4q3PTP+Dpdy
	NqbxlDzw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wfTKf-00000005rna-1kMQ;
	Fri, 03 Jul 2026 02:08:45 +0000
Received: from mail-pg1-x54a.google.com ([2607:f8b0:4864:20::54a])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wfTKd-00000005rlh-36dJ
	for kexec@lists.infradead.org;
	Fri, 03 Jul 2026 02:08:44 +0000
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-c89704da8c7so160081a12.0
        for <kexec@lists.infradead.org>; Thu, 02 Jul 2026 19:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783044522; x=1783649322; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=twAjwEQPJQoMPii2nLtsAn0UlOpk5gfqaTEPYw4GO2E=;
        b=oSRvYPnKQ/TPuK73x+epAewbLrr9ArZhgJAIOzLdTBHz5Qz0TfPaXfKlL0ZhaSIfHr
         7Fl/c9vOywyzSHGokUox+GZ3lRBCf23BUVIvW5ZDtmgVWHe5d9u6Z8Dgp8/6OPvM2JbO
         Bk9Xuubtmaxk4wySLNdEAvhftDK0RKWiIyitTWjYr7/YbQtvfAtIaOGchFTzcZq8Urw4
         NI8NDaCkfnLdS7elczKDxpFmPX/swoE5Zet5r1RS0EPEFZksvSBVeshfM58oCvKQqzcc
         KL3Jlwp5wRp7HqGCMlKDbt+COdO5rPOw8Q72H1vzg+liJ3+5DPXvKbHCvWckg5g0AxfA
         HOlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783044522; x=1783649322;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=twAjwEQPJQoMPii2nLtsAn0UlOpk5gfqaTEPYw4GO2E=;
        b=Y1BjgpColJRWiaYaA7wCePhmSJeJyq3S4/r1G0az3kcmkoNoJsCjf/Udz0rA+8jGZR
         3e5dDC2uIdcOLATAaCKNx8urgjnGarU8uuW0Uc50DGCaEf+zhlHP/TG5CbnXNpD5P81K
         QO3wyUERJ+fWYDRfI31aD7USr47vrpRyiaWMnpilLLRVvRBMMyVMGgkgbX+ZStd5OZ0G
         uMQbIiWBJzvTxV6hP0zpyci8ZxfzrOCNuCOWFPQgsOobqrGMQ6rr6adTC404xU2ZNN4Q
         fEffPLogHPf86RdG/YdYzsH2DFPwBuCzLnPj/Rc1CAB4uIoSYueSYtTm+GosqDVVqcDI
         5Wsg==
X-Forwarded-Encrypted: i=1; AFNElJ/CZhGkl/0fEBumxfsn7oIiu6QemWeYhX7MmoEynbcQeDAmSUW42Elyl6y2JDUN5ZJPrL6t9A==@lists.infradead.org
X-Gm-Message-State: AOJu0YzJkHEVB4LxJJJ11m45Nybv5yE+vOa7qS7iYFuhjVMBNB//DAKU
	IzkHQAy+TjaosXCcmQR0nxV2qEGsNMBGfa8VAWDZ8yyPdScdtVWRzMRiXfFN2aif+hPSfeW5rLT
	9Yw==
X-Received: from pfbhx24.prod.google.com ([2002:a05:6a00:8998:b0:847:8ef2:f06b])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:c8d:b0:847:81e2:2468
 with SMTP id d2e1a72fcca58-847c0674f36mr8855060b3a.4.1783044522128; Thu, 02
 Jul 2026 19:08:42 -0700 (PDT)
Date: Fri,  3 Jul 2026 02:08:31 +0000
In-Reply-To: <20260703020832.1731864-1-praan@google.com>
Mime-Version: 1.0
References: <20260703020832.1731864-1-praan@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260703020832.1731864-4-praan@google.com>
Subject: [RFC PATCH 3/4] kho: Implement page-aware refcount restoration
From: Pranjal Shrivastava <praan@google.com>
To: Mike Rapoport <rppt@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pratyush Yadav <pratyush@kernel.org>
Cc: Alexander Graf <graf@amazon.com>, Samiullah Khawaja <skhawaja@google.com>, 
	David Matlack <dmatlack@google.com>, kexec@lists.infradead.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Pranjal Shrivastava <praan@google.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260702_190843_784067_B2F93D60 
X-CRM114-Status: GOOD (  15.54  )
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

The KHO restoration logic currently forces a refcount of 1 on every
page of a multi-page block. While that is correct for split pages, it
violates the expectations of the buddy allocator for high-order
non-compound pages allocated by kernel user (like the DMA allocator),
where tail pages are expected to have a refcount of 0.

Update the restoration path to respect the preserved page type stored
in the page->private metadata. For KHO_PAGE_CONTIG blocks, only the
head page is given a reference count of 1. For KHO_PAGE_SPLIT blocks,
every page is given a reference count of 1.

Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 kernel/liveupdate/kexec_handover.c | 35 +++++++++++++++++-------------
 1 file changed, 20 insertions(+), 15 deletions(-)

diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index d6e81f72fe5d..f6ca5e24c740 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -375,11 +375,18 @@ int kho_radix_walk_tree(struct kho_radix_tree *tree,
 }
 EXPORT_SYMBOL_GPL(kho_radix_walk_tree);
 
-/* For physically contiguous 0-order pages. */
-static void kho_init_pages(struct page *page, unsigned long nr_pages)
+/* For physically contiguous pages. */
+static void kho_restore_refcounts(struct page *page, unsigned long nr_pages,
+				  enum kho_page_type type)
 {
-	for (unsigned long i = 0; i < nr_pages; i++) {
-		set_page_count(page + i, 1);
+	/* Head page always gets refcount of 1. */
+	set_page_count(page, 1);
+	clear_page_tag_ref(page);
+
+	for (unsigned long i = 1; i < nr_pages; i++) {
+		unsigned int count = (type == KHO_PAGE_SPLIT) ? 1 : 0;
+
+		set_page_count(page + i, count);
 		/* Clear each page's codetag to avoid accounting mismatch. */
 		clear_page_tag_ref(page + i);
 	}
@@ -387,16 +394,7 @@ static void kho_init_pages(struct page *page, unsigned long nr_pages)
 
 static void kho_init_folio(struct page *page, unsigned int order)
 {
-	unsigned long nr_pages = (1 << order);
-
-	/* Head page gets refcount of 1. */
-	set_page_count(page, 1);
-	/* Clear head page's codetag to avoid accounting mismatch. */
-	clear_page_tag_ref(page);
-
-	/* For higher order folios, tail pages get a page count of zero. */
-	for (unsigned long i = 1; i < nr_pages; i++)
-		set_page_count(page + i, 0);
+	kho_restore_refcounts(page, 1 << order, KHO_PAGE_CONTIG);
 
 	if (order > 0)
 		prep_compound_page(page, order);
@@ -421,13 +419,20 @@ static struct page *kho_restore_page(phys_addr_t phys, bool is_folio)
 		return NULL;
 	nr_pages = (1 << info.order);
 
+	/*
+	 * If we want to restore a folio, but the memory was split in the
+	 * previous kernel, something is wrong.
+	 */
+	if (WARN_ON_ONCE(is_folio && info.type == KHO_PAGE_SPLIT))
+		return NULL;
+
 	/* Clear private to make sure later restores on this page error out. */
 	page->private = 0;
 
 	if (is_folio)
 		kho_init_folio(page, info.order);
 	else
-		kho_init_pages(page, nr_pages);
+		kho_restore_refcounts(page, nr_pages, info.type);
 
 	adjust_managed_page_count(page, nr_pages);
 	return page;
-- 
2.55.0.rc0.799.gd6f94ed593-goog


