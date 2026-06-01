Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4A28CD5BD1
	for <kexec@archiver.kernel.org>; Mon,  1 Jun 2026 19:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:Mime-Version:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=jW432ByeiI/9CIKO6fqWuAkWPnw79sOdzCNmKgXACYI=; b=aPEl7sUgvlES996nXU+0ooAUlQ
	kOKNqQKk1888TZANNR28nJDcOfuvrK5zjZDcsyNEPcQBCnwVz2WMVrhcJ3wOr4Yc1h7Jy4y4jtTRe
	gU/D8NP46DwHLzU2ESWY9eCtjtr0h7k6TCR+a8swUSHFq4OQRs7G34DaXY4kd8yzQDcx7vgValLtf
	965LRvGZRLCsavzqOFk5AcDjENIaQCB7G/0RuO1I1+carNuuun7yHzSp/dEdj+i8L98rdTXFkBnyO
	pRYZ3aDIJ4CdxDwI9Dmog/QJX6k9eoK6lTqs6RO87ZG6CswJcCqzCyWktiuiZEekozVXAtYaJN4lj
	1db94LCw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wU8LJ-0000000Bj3u-2IYx;
	Mon, 01 Jun 2026 19:30:33 +0000
Received: from mail-wr1-x449.google.com ([2a00:1450:4864:20::449])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wU8LG-0000000Bj3C-44eK
	for kexec@lists.infradead.org;
	Mon, 01 Jun 2026 19:30:32 +0000
Received: by mail-wr1-x449.google.com with SMTP id ffacd0b85a97d-46010392f89so1092496f8f.2
        for <kexec@lists.infradead.org>; Mon, 01 Jun 2026 12:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780342228; x=1780947028; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jW432ByeiI/9CIKO6fqWuAkWPnw79sOdzCNmKgXACYI=;
        b=MjBLhruKswrA+bQv4aZCoysoMS+5GkB5yfF5gb/R5yVF3HBEdi/bty9b4iyMASWNpI
         mImw3EyGbvakoTKoTnRakEjGpAVktjfK3UJDrAGtZnVSnszv51uvJfd3xtWj8ikFi+aX
         0vc6iVYKFJn9KpDp2FxyEh2KGymktoVeuyx7+RoAjtrkswD8VFrfLh1WVkGPRJv6GyMM
         adnPfyLPXr4KyBAwHzk8F9MMIWhSQrpRMJzUC9WQ+/Hx8WG4Ki7DrzCH2CSyGr6Gc3Iv
         ix9Sc9Oa0E9N1AU+IcC/5Dv8gZRmT9k4c3WAOBGRU+p6WgzzAEPtusvFFt+Xcwnx++tg
         BoqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780342228; x=1780947028;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jW432ByeiI/9CIKO6fqWuAkWPnw79sOdzCNmKgXACYI=;
        b=ecvlPrNYBR63NCuEigunOGZXxpEddcCx84HMx6z43mSxHHXcMnXg0W52AYXvDL4V0X
         wor7RYw/nMdvY9dmZDTUgx707M29KefJo8xZ7PHkDKyIdlmm+ADpYZUzzqsPR5YJ5uDd
         08XINJ+/jBlJXVfHC6E3HjdglhbHOmckNo2PmksjZw4BOb8/vjRs1Ewrt4JTHswamdxD
         RgrKooqP469DYCS7ONgyhfeBxe7WQ7RdKNUxzDbObtEGfP6nfs2gDGPWBaF1+wbwjmGK
         /FQt0jD5Q5lkJ+XT1zMhs/Lb0/omNYvn6yuHVaeu4kaI3MqZ8evQcauSZm2ijWWQeOjk
         hWpg==
X-Forwarded-Encrypted: i=1; AFNElJ9BBv2br9PtyH9e8nBb+x1hwUbF0DmHjmfyrcIPkRoERvuMIbQCXuyXnZehrQZEyZZTKLXf0g==@lists.infradead.org
X-Gm-Message-State: AOJu0Yze2fyMn9TMaG5r+mNJYNa9HWo+U7OrfKSFi7C3a8ih9ELYJyCd
	2r2HYJNz/XR+D+lK9fGzHzcQ68yKkYSzq93avf4S5XB/3wTcvE86mQRrQtDScsAPVyKyQTUwx6w
	FxhAF//YtEOfQOq4F6B+bqA==
X-Received: from wmk23.prod.google.com ([2002:a05:600c:297:b0:487:386a:fe2e])
 (user=mclapinski job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:a40a:b0:490:3a07:c467 with SMTP id 5b1f17b1804b1-490a293cf15mr202670695e9.22.1780342228062;
 Mon, 01 Jun 2026 12:30:28 -0700 (PDT)
Date: Mon,  1 Jun 2026 21:30:14 +0200
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.929.g9b7fa37559-goog
Message-ID: <20260601193014.896405-1-mclapinski@google.com>
Subject: [PATCH] kho: try to allocate contiguous memory for kexec segments
From: Michal Clapinski <mclapinski@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Mike Rapoport <rppt@kernel.org>, 
	Pratyush Yadav <pratyush@kernel.org>, kexec@lists.infradead.org
Cc: Michal Clapinski <mclapinski@google.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260601_123031_022897_481A7E47 
X-CRM114-Status: GOOD (  14.32  )
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

This allows us to skip relocations (and maybe checksum calculation
in the future).

kho_scratch is marked as MIGRATE_CMA but isn't actually given to the
CMA, so it should only contain movable allocations, therefore this
should always succeed.

Signed-off-by: Michal Clapinski <mclapinski@google.com>
---
 kernel/kexec_core.c                |  6 +++++-
 kernel/liveupdate/kexec_handover.c | 21 +++++++++++++++++----
 2 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index dc770b9a6d05..cba3ce985aa9 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -43,6 +43,7 @@
 #include <linux/kmsg_dump.h>
 #include <linux/dma-map-ops.h>
 #include <linux/sysfs.h>
+#include <linux/kexec_handover.h>
 
 #include <asm/page.h>
 #include <asm/sections.h>
@@ -566,7 +567,10 @@ static void kimage_free_cma(struct kimage *image)
 			continue;
 
 		arch_kexec_pre_free_pages(page_address(cma), nr_pages);
-		dma_release_from_contiguous(NULL, cma, nr_pages);
+		if (kho_is_enabled())
+			free_contig_range(page_to_pfn(cma), nr_pages);
+		else
+			dma_release_from_contiguous(NULL, cma, nr_pages);
 		image->segment_cma[i] = NULL;
 	}
 
diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index 4834a809985a..289fd5948fd2 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -1770,15 +1770,28 @@ static int kho_walk_scratch(struct kexec_buf *kbuf,
 	return ret;
 }
 
+static void kho_try_alloc_contig(struct kexec_buf *kbuf)
+{
+	unsigned long start_pfn = PFN_DOWN(kbuf->mem);
+	unsigned long nr_pages = kbuf->memsz >> PAGE_SHIFT;
+
+	if (alloc_contig_range(start_pfn, start_pfn + nr_pages,
+			       ACR_FLAGS_CMA, GFP_KERNEL))
+		return;
+
+	kbuf->cma = pfn_to_page(start_pfn);
+	arch_kexec_post_alloc_pages(page_address(kbuf->cma), nr_pages, 0);
+}
+
 int kho_locate_mem_hole(struct kexec_buf *kbuf,
 			int (*func)(struct resource *, void *))
 {
-	int ret;
-
 	if (!kho_enable || kbuf->image->type == KEXEC_TYPE_CRASH)
 		return 1;
 
-	ret = kho_walk_scratch(kbuf, func);
+	if (!kho_walk_scratch(kbuf, func))
+		return -EADDRNOTAVAIL;
 
-	return ret == 1 ? 0 : -EADDRNOTAVAIL;
+	kho_try_alloc_contig(kbuf);
+	return 0;
 }
-- 
2.54.0.929.g9b7fa37559-goog


