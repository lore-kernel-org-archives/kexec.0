Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1A68C43602
	for <kexec@archiver.kernel.org>; Fri,  3 Jul 2026 02:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gHbIAhxt5ZWMRxF4xCIzHhL4IjTclNl9UE6kteWsf7g=; b=i728L+vn80aZ0HHmcC7LWoQR1z
	FQ4Paz13YjXqJ0hWLS5ZasUJCDk/K1AacsTxmSm/4BNs3D8vUG76Kqj9YSGneWggTTwgBVoPL6gOi
	VVRx0jt1Gs0FQ6Aoy+ge9Yc/rQybPbnf3uiXJg9HXjXoqAhTzxoDgU5JiRr75ZA6I0qYTJqGYrU96
	D/mQj49wTspfIDxXrLgXofIIQmjiBUhW98TZd4jz/PhlaSQm6lgjEdNdZQ9Q9sAJMN3dk/U87yrbd
	KWrALIgHMg9+QvBx9MV06emyVlmQlLrQi9ad3Uvj1uc13/KMozKo/t3eqFj4tfLcYOiLutcqzGKu4
	lYNjNx0Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wfTKe-00000005rmq-1SWC;
	Fri, 03 Jul 2026 02:08:44 +0000
Received: from mail-pg1-x549.google.com ([2607:f8b0:4864:20::549])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wfTKb-00000005rkx-0Gtt
	for kexec@lists.infradead.org;
	Fri, 03 Jul 2026 02:08:42 +0000
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-c8952346bb9so68444a12.2
        for <kexec@lists.infradead.org>; Thu, 02 Jul 2026 19:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783044520; x=1783649320; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gHbIAhxt5ZWMRxF4xCIzHhL4IjTclNl9UE6kteWsf7g=;
        b=rc0jGKFw8Y+qOO3npz7wzr8aWq++zMrPrbKMLvamVC6ryG2d6K+vGDG6fTb+ehTRnc
         Gx6Ce5FGKxJyGEHLLoFrO7AUppezA3be85MYACpqExbWacET5B/1eioXj923yyYyotwn
         IA6enMQqDjzvgF2up3XFo9b57riQ9HTReS2KLCOHnRGsmHz+Se5fhLsEaZ43K1myMPBp
         jyfmpUvc/LpPwdwVykxRisECC/STWaI3jXzwP01eEahstFALuMz0AizrvXMLiVrD3QJw
         wQEdX6YAhTwUQ4ZMO7B4m2tvX66sJz0p1614ccMgGWCxDSewzWpVa11Qc8vQGlLtJTCr
         jLog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783044520; x=1783649320;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gHbIAhxt5ZWMRxF4xCIzHhL4IjTclNl9UE6kteWsf7g=;
        b=U9LJ2dvLvsE6dErT5oP6qmiItRVdTKps8yA0XL2FWwbdqEIklwS9Mnna7gBXqv+S+l
         kUftFYIk7H21sMEF5hlEcox2G4SsYXA9ISHdcLyLXU7j6+hhzv3p3gq5Wn+aXSZ9KT+T
         2eCON6+bQsu4qUP4/y3gXSdnmdbZHUM7bS4JL2cNDSk9Y61/f1R5XuIPSEOWU7p7UbMa
         6l+UMLPbCUsjIQYzkwB7fV5At+EXyI03Q+kk30/EXa8M0P9qDsCLcJvpmJZ6UiHjtNjI
         1rbRx5hHKDsRUWZ+zOW2KYhXEYUouveEOW2vvllyP28P8OXOGoLjfxh1aUgC6f6UqnBR
         y8kA==
X-Forwarded-Encrypted: i=1; AFNElJ9z/4f5Anp9CcS99c+E+zNZ2+i+tojCWo/8xkOiq+SUsjCEONuuwlUCbtkRUwz7iVFORdW9HA==@lists.infradead.org
X-Gm-Message-State: AOJu0YyvhPksjP9RIAhnb/cr5dTewL6QOOSJxOe4HXk2GHsVEJFNKNjS
	Rmyu7ixw9kK7+2QPMChSfs9UeP9U+cPIJGiWnuNCdw//kuOuvS4lGKTVAfl1SJ7a+iyIJOqFAZ5
	f+w==
X-Received: from pgbr31.prod.google.com ([2002:a63:5d1f:0:b0:c9a:37aa:b17d])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:6a1b:b0:3b2:924c:566e
 with SMTP id adf61e73a8af0-3bfed3dfce5mr9656083637.36.1783044519485; Thu, 02
 Jul 2026 19:08:39 -0700 (PDT)
Date: Fri,  3 Jul 2026 02:08:30 +0000
In-Reply-To: <20260703020832.1731864-1-praan@google.com>
Mime-Version: 1.0
References: <20260703020832.1731864-1-praan@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260703020832.1731864-3-praan@google.com>
Subject: [RFC PATCH 2/4] kho: Detect preserved page types
From: Pranjal Shrivastava <praan@google.com>
To: Mike Rapoport <rppt@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pratyush Yadav <pratyush@kernel.org>
Cc: Alexander Graf <graf@amazon.com>, Samiullah Khawaja <skhawaja@google.com>, 
	David Matlack <dmatlack@google.com>, kexec@lists.infradead.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Pranjal Shrivastava <praan@google.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260702_190841_143720_54350985 
X-CRM114-Status: GOOD (  14.25  )
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

Detect page types in kho_preserve_pages() by peeking into the refcount
of the second page in each block of order > 0. If the second page has
a non-zero reference count, it indicates that the block has been split.
Otherwise, treated it as a contiguous, unsplit block.

Since the page type is now part of the radix tree key, update the
unpreserve path to use the same detection logic to ensure it can
correctly locate and delete existing entries.

Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 kernel/liveupdate/kexec_handover.c | 28 +++++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index f829ffdd00f4..d6e81f72fe5d 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -918,15 +918,29 @@ static unsigned int __kho_preserve_pages_order(unsigned long start_pfn,
 	return order;
 }
 
+static bool kho_is_page_split(unsigned long pfn, unsigned int order)
+{
+	/*
+	 * If the refcount of the second page is non-zero, this block
+	 * has been split.
+	 */
+	if (order > 0 && page_ref_count(pfn_to_page(pfn + 1)) != 0)
+		return true;
+
+	return false;
+}
+
 static void __kho_unpreserve(struct kho_radix_tree *tree,
 			     unsigned long pfn, unsigned long end_pfn)
 {
-	unsigned int order;
-
 	while (pfn < end_pfn) {
-		order = __kho_preserve_pages_order(pfn, end_pfn);
+		unsigned int order = __kho_preserve_pages_order(pfn, end_pfn);
+		enum kho_page_type type;
 
-		kho_radix_del_page(tree, pfn, order, KHO_PAGE_CONTIG);
+		type = kho_is_page_split(pfn, order) ? KHO_PAGE_SPLIT :
+						       KHO_PAGE_CONTIG;
+
+		kho_radix_del_page(tree, pfn, order, type);
 
 		pfn += 1 << order;
 	}
@@ -958,8 +972,12 @@ int kho_preserve_pages(struct page *page, unsigned long nr_pages)
 
 	while (pfn < end_pfn) {
 		unsigned int order = __kho_preserve_pages_order(pfn, end_pfn);
+		enum kho_page_type type;
+
+		type = kho_is_page_split(pfn, order) ? KHO_PAGE_SPLIT :
+						       KHO_PAGE_CONTIG;
 
-		err = kho_radix_add_page(tree, pfn, order, KHO_PAGE_CONTIG);
+		err = kho_radix_add_page(tree, pfn, order, type);
 		if (err) {
 			failed_pfn = pfn;
 			break;
-- 
2.55.0.rc0.799.gd6f94ed593-goog


