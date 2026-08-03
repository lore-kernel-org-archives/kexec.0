Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE908C55184
	for <kexec@archiver.kernel.org>; Mon,  3 Aug 2026 11:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vv6DECOvSmngHsx3EI9j0R7ut4SHpWl9EkNqXk3pPjk=; b=Mgrr7a/oC94FWbYaTUWTluojOS
	bzclqx/pRyP/waBq8z9U58Y7j971G+w4t2tqW13IQ0NAEBqct8c+HansN/C4meR5QtVnnzRBH2pEh
	4BjbxOe5xM3pLRa6wbGcbqIcQK5b8+akiE9KLAopo1g/7JY/odHIySGLpXyqlKu3u9tRaq+qaACx7
	d9wxQF4KIsiSDOIDdlaevzOBtOn+DsxAjL101K7L7lbqKHwciI6/CPFrMLyRweutktXBhm6DKtXRK
	WDVU5pivfMkl3kngcj6MIWA6MBG08AVC+mcYDQ7Ss+2MzBudgI3+8KHH8nAp/2fb+KqmP9hog2qg3
	q2smjhxw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wqr1O-0000000GxSy-3WgF;
	Mon, 03 Aug 2026 11:39:54 +0000
Received: from mail-pl1-x648.google.com ([2607:f8b0:4864:20::648])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wqr1M-0000000GxRP-01ZC
	for kexec@lists.infradead.org;
	Mon, 03 Aug 2026 11:39:53 +0000
Received: by mail-pl1-x648.google.com with SMTP id d9443c01a7336-2cca5e0a0c9so58870915ad.1
        for <kexec@lists.infradead.org>; Mon, 03 Aug 2026 04:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785757190; x=1786361990; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vv6DECOvSmngHsx3EI9j0R7ut4SHpWl9EkNqXk3pPjk=;
        b=FuVdT0LGrIznrRbKjhsuoqDHrSiu2AEqJbZw9/KcZCfCrCVrzdxoVpg8TmSZOWboar
         SLm8wfdVho6RrUHyxQn8luupSaJhk4dtR0PKCRRhgYRY0zKknuWCJC5E58swDB8PfUhy
         iJlw1nUw2DRKq0RjypXNsymnz1oEbgIE6q6eJCpJ+QUiKiqAattYGytRDQ+YCTr2Ujsn
         G2tNjUsZEkRMGiw/WCcFsLCqOg2ZohtJnQqs2QoOr27CuNYQx//Fb0xaCxl9ZNx+gatJ
         wFG87qN1IXNVXAqK23czmGkqH4/INDS5WZu4Y0lv+vdAfOrzsLUuV1KeaAVWi5c97pRd
         S8IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785757190; x=1786361990;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vv6DECOvSmngHsx3EI9j0R7ut4SHpWl9EkNqXk3pPjk=;
        b=SGcVKBbv4WxmOF6TnzTZA06uOFHLRGMnOIIqgCee7sV3fLobMrykwjIP6cQ9D7nnnF
         2TTdUxu70qxkSxxWPxWtDKGuTJij0q6aIO6vSYopLzy5j5XBtHFub0iZdp8CIb4GVuRS
         2cfy3lpT7RwHdvBl+UXZBi5PVhn76TTRB6L0rrB7zi0mlhIiG6MMEa4qum/6PSe5gg6U
         EvHPBH2Ci5Nm0twGgbTCGObB+m4v6qo/O+yiplMXmlR1CXQFlzh1A6vW5JQC8LifdPXq
         a5XrHbUdVSqyIxKsEF3KU3l7o7bPiuZbL7NPQprkJwWkcYnpTQoEJv2/lkd4Z4ktPWky
         ytWg==
X-Forwarded-Encrypted: i=1; AHgh+Rr7bNedI68MSxP96UMBFlo5/cGwwN3TCfz7fh20vzKHbARQPWoBu+k7xNlkM3ms2sKIYj5+OQ==@lists.infradead.org
X-Gm-Message-State: AOJu0Yz03/xPojLoJzltRLUvDeDhZJuMGUBotYubmcTLoLHvnk5Blbcm
	OMKWyqy19hy8j3cnYFLmUswJJvkskL1taIFCWUZE3DuSWt4/ufA4dsVnIk6+LD/KH7mRXjPlrab
	zfg==
X-Received: from pgvi9.prod.google.com ([2002:a65:61a9:0:b0:c9a:c533:8329])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:e58d:b0:3bf:e3d6:ab5a
 with SMTP id adf61e73a8af0-3c92a8f327cmr10771333637.52.1785757190359; Mon, 03
 Aug 2026 04:39:50 -0700 (PDT)
Date: Mon,  3 Aug 2026 11:39:42 +0000
In-Reply-To: <20260803113944.3694290-1-praan@google.com>
Mime-Version: 1.0
References: <20260803113944.3694290-1-praan@google.com>
X-Mailer: git-send-email 2.55.0.508.g3f0d502094-goog
Message-ID: <20260803113944.3694290-2-praan@google.com>
Subject: [PATCH v4 1/2] kho: Introduce a helper to init high order pages
From: Pranjal Shrivastava <praan@google.com>
To: Mike Rapoport <rppt@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pratyush Yadav <pratyush@kernel.org>
Cc: Alexander Graf <graf@amazon.com>, Samiullah Khawaja <skhawaja@google.com>, 
	David Matlack <dmatlack@google.com>, kexec@lists.infradead.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Pranjal Shrivastava <praan@google.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260803_043952_047291_443919F4 
X-CRM114-Status: GOOD (  11.75  )
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

The current KHO restoration logic assumes all multi-page blocks are
split into independent 4KB pages. Break out a helper to prepare for
supporting high-order non-compound pages.

Extract kho_init_high_order_page() to handle the refcount pattern
where only the head page is refcounted. Use the helper for folio
restoration that requires a similar refcount logic.

Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 kernel/liveupdate/kexec_handover.c | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index 4834a809985a..e836efd98795 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -357,6 +357,24 @@ int kho_radix_walk_tree(struct kho_radix_tree *tree,
 }
 EXPORT_SYMBOL_GPL(kho_radix_walk_tree);
 
+/* For physically contiguous pages. */
+static void kho_init_high_order_page(struct page *page, unsigned int order)
+{
+	unsigned long nr_pages = (1UL << order);
+
+	/* Head page gets refcount of 1. */
+	set_page_count(page, 1);
+	/* Clear head page's codetag to avoid accounting mismatch. */
+	clear_page_tag_ref(page);
+
+	/* For high-order blocks, tail pages get a page count of zero. */
+	for (unsigned long i = 1; i < nr_pages; i++) {
+		set_page_count(page + i, 0);
+		/* Clear each page's codetag to avoid accounting mismatch. */
+		clear_page_tag_ref(page + i);
+	}
+}
+
 /* For physically contiguous 0-order pages. */
 static void kho_init_pages(struct page *page, unsigned long nr_pages)
 {
@@ -369,16 +387,7 @@ static void kho_init_pages(struct page *page, unsigned long nr_pages)
 
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
+	kho_init_high_order_page(page, order);
 
 	if (order > 0)
 		prep_compound_page(page, order);
-- 
2.55.0.508.g3f0d502094-goog


