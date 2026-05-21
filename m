Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1123CD5BB4
	for <kexec@archiver.kernel.org>; Thu, 21 May 2026 19:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Skwk48BYilyHQDMbYjOBqYYKx+CCGojb2mWZPJknBhk=; b=2FtM79DaIl76aWzWjoV7HQ4XlV
	Oh5NiwLad4UkEraMR3EQbW45tBXGjtAMUVPN3o15jnbpLC5k+gsUVSVyTs06U71AjuFKGLuOEjHe5
	V0ZgYBaMUl3fw6HNJC/7WlpV3qQ9CqTAwfav5RBR9vZzmXdasloS/OgJDcJhY5VXe3DBMikVcjDrG
	CvMygv2Iy5vP8PmQxwySaKTCXWedWAOrY9VVBXA8imxBWRQcigeA6HjIVOg0zGCnB6J36AQGNBGoA
	SQTvMmE+EPHKVSMrkNs7mRe9Fd9OmChYlhvhH9cNIvlLjoRhoGMSujTaRLTCJmsDkgNhfD+EH/yMA
	XbgVYF8w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQ97n-00000008uvW-45Xm;
	Thu, 21 May 2026 19:32:07 +0000
Received: from mail-pg1-x54a.google.com ([2607:f8b0:4864:20::54a])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQ97l-00000008uu0-17OL
	for kexec@lists.infradead.org;
	Thu, 21 May 2026 19:32:06 +0000
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-c8510f91ce8so801925a12.2
        for <kexec@lists.infradead.org>; Thu, 21 May 2026 12:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779391924; x=1779996724; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Skwk48BYilyHQDMbYjOBqYYKx+CCGojb2mWZPJknBhk=;
        b=OD8nooW4TFrOKTFBbpjw1n/vitqxqBwSvm2BO//BGQQFkNmHdZoXLNCAVv8F/4reNk
         +DfIYjIiLRxxdQ9MwdUFeNEkE009dWu4mPAtan/onRhZ3HMt5dhWKcvpQS9Kmj2Na5/z
         Cq7omRqflBQBdj0Gv4VmvMbVzt1ORXCJrrYtKzkp/CII1Bs5ly2UgBkmXntaoSHD6quF
         NCK32ox+eMrIZwuAZAWPRdD+WNORSuj3jBly4rYlliEsQmbs8ODdvkcdhqNElmEEwsJZ
         Ogzv91v0j8/TSfTguZ6uqeVuYjKNqg0wkwDds7ZL5hXzavVw4G9y936BNWWdR7rhxZZZ
         wQoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779391924; x=1779996724;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Skwk48BYilyHQDMbYjOBqYYKx+CCGojb2mWZPJknBhk=;
        b=U+QTwkU9ZB6FDS23XQ/MbP3lptZ5RjSL0WATekgg9ebBUyfsLuiUg+2R2RQFyBQioj
         grhsj3T6MR4Y/sz9vkGVtJXZOMGvgQKwlmnclVFVsqcJui1oFelLYZKsUOUmUsJ7uFCd
         KSZ9EQp5OozVzKVEcY55AUQwDDLw20/AImCZPn1iREKUQDFN9XgeGxpeyxagj1TXVcRN
         Ad1F/RjEKTBhlLZJsJvlz99V/bQmTGuo4LtYyWHyJBncv9k+/gsg6GzQULiThbXCKVTI
         rGyQncfcHppQ1eJEarpKJcUTHKwVMOgimtNN7lU8/c8wjLQT2NIgqCqDhew7hwXe/tvy
         0w7w==
X-Forwarded-Encrypted: i=1; AFNElJ+rH069OB8kiL01JwAgj6uaDo9vx9oRR/cWIX+6tEhjULb/x+Z5Ukib5AXf189q4YSCD6JW9g==@lists.infradead.org
X-Gm-Message-State: AOJu0Yxizg4vlU+uhguGp1wx6cumry+Z5WaDrXepcK+B28rWKRR4f0Xj
	ej8cqAbmlnIhy1NGnSLnW+5V8VmdRrVmbr4udhDi4CMdbqtsv/vGw/tzognsLKnZTGVDaVwWZ5g
	1lGZIlJdvnj5wZQ==
X-Received: from pggk2.prod.google.com ([2002:a63:d102:0:b0:c74:664d:4080])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:32a0:b0:39b:a997:9e40 with SMTP id adf61e73a8af0-3b328eeeac0mr350862637.46.1779391923585;
 Thu, 21 May 2026 12:32:03 -0700 (PDT)
Date: Thu, 21 May 2026 19:32:00 +0000
In-Reply-To: <20260521193202.746810-1-skhawaja@google.com>
Mime-Version: 1.0
References: <20260521193202.746810-1-skhawaja@google.com>
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
Message-ID: <20260521193202.746810-2-skhawaja@google.com>
Subject: [PATCH v2 1/3] kho: Add kunit static stubs
From: Samiullah Khawaja <skhawaja@google.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>, Mike Rapoport <rppt@kernel.org>, 
	Pratyush Yadav <pratyush@kernel.org>, Alexander Graf <graf@amazon.com>
Cc: Samiullah Khawaja <skhawaja@google.com>, David Matlack <dmatlack@google.com>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:KEXEC HANDOVER (KHO)" <kexec@lists.infradead.org>, 
	"open list:KEXEC HANDOVER (KHO)" <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260521_123205_308729_9A720F03 
X-CRM114-Status: GOOD (  11.57  )
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

Add kunit stubs in kho_restore_folio() and kho_restore_pages() so the
users can mock these functions in kunit tests.

Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
 kernel/liveupdate/kexec_handover.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index 11855e275397..902019f36c24 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -10,6 +10,8 @@
 
 #define pr_fmt(fmt) "KHO: " fmt
 
+#include <kunit/static_stub.h>
+
 #include <linux/cleanup.h>
 #include <linux/cma.h>
 #include <linux/kmemleak.h>
@@ -423,7 +425,11 @@ static struct page *kho_restore_page(phys_addr_t phys, bool is_folio)
  */
 struct folio *kho_restore_folio(phys_addr_t phys)
 {
-	struct page *page = kho_restore_page(phys, true);
+	struct page *page;
+
+	KUNIT_STATIC_STUB_REDIRECT(kho_restore_folio, phys);
+
+	page = kho_restore_page(phys, true);
 
 	return page ? page_folio(page) : NULL;
 }
@@ -445,6 +451,8 @@ struct page *kho_restore_pages(phys_addr_t phys, unsigned long nr_pages)
 	const unsigned long end_pfn = start_pfn + nr_pages;
 	unsigned long pfn = start_pfn;
 
+	KUNIT_STATIC_STUB_REDIRECT(kho_restore_pages, phys, nr_pages);
+
 	while (pfn < end_pfn) {
 		const unsigned int order =
 			min(count_trailing_zeros(pfn), ilog2(end_pfn - pfn));
-- 
2.54.0.746.g67dd491aae-goog


