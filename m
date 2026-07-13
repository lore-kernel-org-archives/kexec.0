Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4BE8C44508
	for <kexec@archiver.kernel.org>; Mon, 13 Jul 2026 20:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hg67XY3VqVr1xT4YbJfB+2ZOPF2cG732AuNnOCY2r7I=; b=E+W4bAoDbW/10ync2AiTfbqu8t
	X3UHLHuGcjezTE8z9XJMXoWNqZOom/IkJwpBFpttTorML6Nii/lR6sDoM76cIlbfTFFFEA3ieSW2T
	H6dmUuUy7EwevxnIj4kAYkIOaemFecqdQXO4gUHo9QXHFnnVz8Oud2XfeOahgErqRmyVJKWYCfRPa
	h7RT80EFQRRDOUJuK2IN+DBT6c+l8M2N5zq3qoEWa0ee/CgVG3LCkxPKm3J/BOumji8g2FpFe3F92
	Rw6ULX20BuEc0wXlprxvZ+EqGlyYW1ca8Gt7hSIwX5k/A8S3iKyQgaZqvYbMJq2fLxTZmsckTAzH+
	adKdgsmg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjNay-0000000APSt-0VGa;
	Mon, 13 Jul 2026 20:49:44 +0000
Received: from mail-pg1-x54a.google.com ([2607:f8b0:4864:20::54a])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjNav-0000000APSK-3lYd
	for kexec@lists.infradead.org;
	Mon, 13 Jul 2026 20:49:43 +0000
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-c9c26587e67so437278a12.0
        for <kexec@lists.infradead.org>; Mon, 13 Jul 2026 13:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783975781; x=1784580581; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hg67XY3VqVr1xT4YbJfB+2ZOPF2cG732AuNnOCY2r7I=;
        b=iq6R6gMHytvQkUow29F38s34NvYuT4ENHdWPTOzXEyG+LNUp4RsRZnjnQalQn52b1a
         T3RDRME6MLfYBNtIm5iuwfPp3Tde9PVIpYr+jNuoGxiIyllHCjdANxQMMVA0NlAJC1YJ
         zTfD+mqkpqO6TN0sEtEFtvf49oPy7AcJ11Q6us8yw/EZcw6br00LJcsfSPfTCdbL3+WS
         sYFu7uMkmG4GOhZ9rhcQIegJuNVlx5rrfip77ux8wFeJ25pvX7hUVzZtZQ1AluXapSw4
         UrpveM1n1psRfHE6cZWzEMPq0V3ZrM0tPdOxedS7RVXlF5FcmM24P2MtJfjTHPs8U33a
         JnhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783975781; x=1784580581;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hg67XY3VqVr1xT4YbJfB+2ZOPF2cG732AuNnOCY2r7I=;
        b=JB6JXlwh1uU6b6L7Ng6DSnhm9KgHwj9MJnRlzco8qfiEYWDpMA4s9B7vH4L6dv7CCo
         2DU9K9I7qioFZVDUWe0I1CWWWWFDwvUmGISJEgCDn+9aN4KrAsnSh8u3I0VIdQPGD1nG
         SidEXSK9vdUk0d69w+Ldt+KfGgOuooCSKSFMKkD9oNijuSalDG5ZniXOf8B8uhgJVHfH
         tidqeVpqGQeV+OVSmPayCUWYKHKI/E2JpBUHZa4Ve0agR7G5db/K4W9e3fuqq3H7zR8h
         RZy3vn9EOGav+UuIxMxIUmzTK/sCo/GHuKl8SVfUi/8cPPj3w0ahjzd90/Fo7kb/Wj6C
         ML1w==
X-Forwarded-Encrypted: i=1; AHgh+Ro9zbt+b/hyDJW2Ruo8EO4D0CVf+1U6wOWdTzfQC64Pd5YRqhonoBSsteaPDICWpGuEqX572Q==@lists.infradead.org
X-Gm-Message-State: AOJu0YzadWmCEgmWwioVIYRDb/ENzDzKhjikIesuq3h9vA59YENb+gvr
	XHHC/kfZVPGOlgonxZQIIBlqcrc2FQ22kP8pQpYhesD3HuVRbM9bkedUZhf51xlcyNx+N8D3oLZ
	sOg==
X-Received: from pgl36.prod.google.com ([2002:a63:b24:0:b0:c89:2504:2df5])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:6f01:b0:3b3:ccd0:cf62
 with SMTP id adf61e73a8af0-3c0f0c11140mr14952998637.36.1783975780428; Mon, 13
 Jul 2026 13:49:40 -0700 (PDT)
Date: Mon, 13 Jul 2026 20:49:34 +0000
In-Reply-To: <20260713204935.3069000-1-praan@google.com>
Mime-Version: 1.0
References: <20260713204935.3069000-1-praan@google.com>
X-Mailer: git-send-email 2.55.0.141.g00534a21ce-goog
Message-ID: <20260713204935.3069000-2-praan@google.com>
Subject: [RFC PATCH v2 1/2] kho: Introduce a helper to init unsplit pages
From: Pranjal Shrivastava <praan@google.com>
To: Mike Rapoport <rppt@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pratyush Yadav <pratyush@kernel.org>
Cc: Alexander Graf <graf@amazon.com>, Samiullah Khawaja <skhawaja@google.com>, 
	David Matlack <dmatlack@google.com>, kexec@lists.infradead.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Pranjal Shrivastava <praan@google.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260713_134941_959947_EF1B979E 
X-CRM114-Status: GOOD (  11.79  )
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

Extract kho_init_unsplit_pages() to handle the refcount pattern
where only the head page is refcounted. Use the helper for folio
restoration that requires a similar refcount logic.

Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 kernel/liveupdate/kexec_handover.c | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index 4834a809985a..07f6f453cd69 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -357,6 +357,24 @@ int kho_radix_walk_tree(struct kho_radix_tree *tree,
 }
 EXPORT_SYMBOL_GPL(kho_radix_walk_tree);
 
+/* For physically contiguous pages. */
+static void kho_init_unsplit_pages(struct page *page, unsigned int order)
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
+	kho_init_unsplit_pages(page, order);
 
 	if (order > 0)
 		prep_compound_page(page, order);
-- 
2.55.0.141.g00534a21ce-goog


