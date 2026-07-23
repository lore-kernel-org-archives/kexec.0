Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EF83C531CC
	for <kexec@archiver.kernel.org>; Thu, 23 Jul 2026 20:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pIhtxPilZww/6qXFXyt6pCELZXv5C+7yA4sMxjjosZU=; b=kHzNbwQwTmVe1lmz6L8WjxapQH
	H9A/CzUb68s7t2fjgY9VsHPe8fiw0uDAW2qIQjr/5sMJJ1RnvbLgW+apLv8UNnh2QAb88+yC3P4YX
	Uew2Xu4TzvTnCN/VoZeET/jLA79nnr1wWihwRzDnf/tQChfRfFxhVlbRWzURzkm0Cr7Z7rVzJonyP
	4khOo7tgpKxhlt+lYMwJA73N6MHtsjITg9JCHi/Hlg3EiM+Q5OK48lopSoVIE9qOsKUsExqbgiDKf
	SKI0LoyH399o5sE5NSGG+CAFcdKYucptWrdc70KKjEWO1EM2cKN9L7DuFazhGJURrtXtbG5kQs5ZQ
	bBheAE+w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wn0FD-0000000F3P8-1Bsr;
	Thu, 23 Jul 2026 20:42:15 +0000
Received: from mail-pl1-x648.google.com ([2607:f8b0:4864:20::648])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wn0FA-0000000F3O5-2c9M
	for kexec@lists.infradead.org;
	Thu, 23 Jul 2026 20:42:14 +0000
Received: by mail-pl1-x648.google.com with SMTP id d9443c01a7336-2cee1ec30f2so14647775ad.3
        for <kexec@lists.infradead.org>; Thu, 23 Jul 2026 13:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784839331; x=1785444131; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pIhtxPilZww/6qXFXyt6pCELZXv5C+7yA4sMxjjosZU=;
        b=bmqfQrLViKeqEtSbcONgO6EWhYid9DZFuRi7WA420zxL3PDZ5JMyF+u3ry4czh5LkQ
         R0pxbz1cnY/gE/M2AN17ZuqPCje/i29DBVn4HtIKuaBuXKaIqLr2Z8s7o8EIM+A+O5c3
         K03I2Qg/UF4DEI8gGGavRk7duKEyZ13206FAMEA2CMN9w+kI6qsAH8wUEdxvfo0D8IgN
         SlboVz7BzZLBnAYF8JRDBsUWsG5YaGGy7ccEzDgsqdOgUwhbBzPixU2NMqSZZoUZ2qRD
         35ep7GLN/Ina+37ECorodh3/qP8i6NsPC4E+11UMnlxP0NB9gjBvRCDCCpp3jC+EPJIZ
         rpjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784839331; x=1785444131;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pIhtxPilZww/6qXFXyt6pCELZXv5C+7yA4sMxjjosZU=;
        b=KdIIxUBDd3/E9dOnnaObdUIqGMBgWDKK5uO6wzgYUxuNLIzEbQ8taRK/mZ6tdfCpbJ
         Zub8DhTlxfLnAD9OFt39EsXDF38uHCY+YOpnLf92YbEolHHSDhYzHnyKHzppB3qfgabg
         +Rxi2fTMX4NCC8yZulqypgFR9/ajN2nbC02H4crg6r7rdAc7pouaVqcj0UsDz2F1fEeV
         O3zrQNMxxpW+V0dDCIxecI3f3Iu+cBJYEmYnz7zVJeR/BJCjL+Vd8Nd/25yYp94FRSoi
         AI+o722y6ZoAm/GlZZhmaddVWMr87j1SBZfenB3C5mZQmi2mvGVb8O1vkCty+bqm8U9B
         VtdA==
X-Forwarded-Encrypted: i=1; AHgh+Ro49OMaPly5THsg3zScXP4zUl1XK5gcZNNR71iMTQq+sWl6TQUFhGuuUXIJGPcj95comuAaCA==@lists.infradead.org
X-Gm-Message-State: AOJu0Ywao6ig9PleRrhSJkd9S+X4jnOy3NZ8P3eIWzyUuR7ppSl4CGxb
	+Hh+ispTakg082ItzNg3sfQIvdVodxv3lLBuuaK7ipijj49O2mucxzlh8jVclsPoT+JkeFlgi4E
	CGQ==
X-Received: from plgi16.prod.google.com ([2002:a17:902:cf10:b0:2ca:f1f8:ea00])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d2c9:b0:2ca:6514:9201
 with SMTP id d9443c01a7336-2cfa6b7a10dmr57623865ad.15.1784839330855; Thu, 23
 Jul 2026 13:42:10 -0700 (PDT)
Date: Thu, 23 Jul 2026 20:42:01 +0000
In-Reply-To: <20260723204203.2997395-1-praan@google.com>
Mime-Version: 1.0
References: <20260723204203.2997395-1-praan@google.com>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260723204203.2997395-2-praan@google.com>
Subject: [PATCH v3 1/2] kho: Introduce a helper to init high order pages
From: Pranjal Shrivastava <praan@google.com>
To: Mike Rapoport <rppt@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pratyush Yadav <pratyush@kernel.org>
Cc: Alexander Graf <graf@amazon.com>, Samiullah Khawaja <skhawaja@google.com>, 
	David Matlack <dmatlack@google.com>, kexec@lists.infradead.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Pranjal Shrivastava <praan@google.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260723_134212_668715_2833A5ED 
X-CRM114-Status: GOOD (  11.36  )
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
2.55.0.229.g6434b31f56-goog


