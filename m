Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD2F3FD8777
	for <kexec@archiver.kernel.org>; Tue, 17 Mar 2026 14:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6pQdqVuW3s3IY2V2/GcIHf4+cwJRcBc6iC91+pnO9/s=; b=CYS1r+5Oelw5wV4tHJXWmhj6SY
	+DuNt1chMlKlflLRbdYNB0t2duckk2sxD1/ms8O/dN0RkpOei71EhRrwbnyT0AbdLJi3mjVgB5lgJ
	+uPXqiuddkc4Qv2B0RwMAAChCxotNFNga5rXKNayccu6A0U2UNx3b7XFRo6y/Hi9KHb4LTu8tgT1j
	2FEGk9KdoRgiE5Y3EkH6FSsBWTpT0no8EdiMxok+xhq0WlZCau8HhyQYe1ycDUk9u8PjFDxXlofwH
	CNyy8z+MLXlS5OloxnRACc4qsEHB1P8x402yk8rVwGtZ+VG4k2fOb5wkxvq0o0F4eSC/k81HaMFkz
	6DD5PQZg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2VD4-00000006Xyd-02rW;
	Tue, 17 Mar 2026 14:15:50 +0000
Received: from mail-wr1-x449.google.com ([2a00:1450:4864:20::449])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2VD0-00000006Xvb-2iHg
	for kexec@lists.infradead.org;
	Tue, 17 Mar 2026 14:15:48 +0000
Received: by mail-wr1-x449.google.com with SMTP id ffacd0b85a97d-439bab2d095so3545314f8f.3
        for <kexec@lists.infradead.org>; Tue, 17 Mar 2026 07:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773756944; x=1774361744; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6pQdqVuW3s3IY2V2/GcIHf4+cwJRcBc6iC91+pnO9/s=;
        b=s3Mecmx5MgdTbGBy4RwV4ADRwYCJjmbtf/AHIBn4xTc9QItswIfG5cm9/I7UWRWzky
         FZrdb1U3gG895uUsVSG1oz/mhuk2NKNLAvOHJPq9Mi5Bt9LedaJEsgtLem8brDdmuIts
         LeHUANkJ+UQOdN++wuUOmuXWUojs+WnqE2IbcSndkp0ZSyWNwQ6LJWLEG9IPgt2lBhdM
         v6dIf/JbfyewTBqRhmR8AFebI7LSSSa8uE+1XJntwrycliC8gYFNP8PJc9rgaMnh7wfq
         G4lAVrWZguThDBWOwzY1sRbrFRroivUTJdrU0gV3PI+qO/5EOhdu1krrbtqgzAGLa3ix
         /TUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773756944; x=1774361744;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6pQdqVuW3s3IY2V2/GcIHf4+cwJRcBc6iC91+pnO9/s=;
        b=nu1FFSKnIVLuspFX5LK1S/X3/qQDuNZwfSWfsTScRHJT4p/a+xfK2sc84z79rNN0ky
         quaoPzH/rKmNfLKX92rZpL/wnYf/e8T1lPKCRg+49eOYyO0pXjyqmLampmwLnlCeE/fD
         vkBRV0RWdV/Oa0/C+8PVD1SFL9eS0Mr5kcxmdEzIfSN+cJIDd+bS1l/+26RXTBE/1mQV
         c2UT3tPHHw4E1jUAURZ7ctEXgox8E2oSj6PZ/r9qHk/5Cp/u+K+2Py928Ao4IJ4zZONn
         Yg/DxofgDNEidTVcSxfHtQ1hqahkPkzV8RcyVp7fohgYQsPwWh1QuFo70HMIeMirJCAX
         a/JA==
X-Forwarded-Encrypted: i=1; AJvYcCVIstBNHtnWe8xAcLk97jKziXZmgwaMn2wLB2Kl8XwNQflMywnvWqI03mHmHISWJpSmroQzLQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YxWZcmANngIOVu902YClyE1IEscyUU7AibVftpz5BfTsvyEZcXH
	hVhDoV/XQ8FZWrCr00aPoAb5cuCoPS+m3vyraclFQnof6JLC//0E2wchaoECnJpMB0txbBpJSwI
	Fn4eCHackVHXcyPKdoxr3MQ==
X-Received: from wmz7.prod.google.com ([2002:a05:600c:6b67:b0:485:3aa2:da59])
 (user=mclapinski job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4583:b0:485:3f17:410 with SMTP id 5b1f17b1804b1-485566fd031mr299341025e9.16.1773756943916;
 Tue, 17 Mar 2026 07:15:43 -0700 (PDT)
Date: Tue, 17 Mar 2026 15:15:32 +0100
In-Reply-To: <20260317141534.815634-1-mclapinski@google.com>
Mime-Version: 1.0
References: <20260317141534.815634-1-mclapinski@google.com>
X-Mailer: git-send-email 2.53.0.851.ga537e3e6e9-goog
Message-ID: <20260317141534.815634-2-mclapinski@google.com>
Subject: [PATCH v7 1/3] kho: make kho_scratch_overlap usable outside debugging
From: Michal Clapinski <mclapinski@google.com>
To: Evangelos Petrongonas <epetron@amazon.de>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Mike Rapoport <rppt@kernel.org>, Pratyush Yadav <pratyush@kernel.org>, Alexander Graf <graf@amazon.com>, 
	Samiullah Khawaja <skhawaja@google.com>, kexec@lists.infradead.org, linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	Michal Clapinski <mclapinski@google.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260317_071546_773050_96677691 
X-CRM114-Status: GOOD (  17.19  )
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

Also return false if kho_scratch is NULL.

Signed-off-by: Michal Clapinski <mclapinski@google.com>
---
 include/linux/kexec_handover.h              |  6 +++++
 kernel/liveupdate/Makefile                  |  1 -
 kernel/liveupdate/kexec_handover.c          | 28 ++++++++++++++++++---
 kernel/liveupdate/kexec_handover_debug.c    | 25 ------------------
 kernel/liveupdate/kexec_handover_internal.h |  7 ++++--
 5 files changed, 35 insertions(+), 32 deletions(-)
 delete mode 100644 kernel/liveupdate/kexec_handover_debug.c

diff --git a/include/linux/kexec_handover.h b/include/linux/kexec_handover.h
index ac4129d1d741..6a0e572c3adc 100644
--- a/include/linux/kexec_handover.h
+++ b/include/linux/kexec_handover.h
@@ -35,6 +35,7 @@ void *kho_restore_vmalloc(const struct kho_vmalloc *preservation);
 int kho_add_subtree(const char *name, void *fdt);
 void kho_remove_subtree(void *fdt);
 int kho_retrieve_subtree(const char *name, phys_addr_t *phys);
+bool kho_scratch_overlap(phys_addr_t phys, size_t size);
 
 void kho_memory_init(void);
 
@@ -109,6 +110,11 @@ static inline int kho_retrieve_subtree(const char *name, phys_addr_t *phys)
 	return -EOPNOTSUPP;
 }
 
+static inline bool kho_scratch_overlap(phys_addr_t phys, size_t size)
+{
+	return false;
+}
+
 static inline void kho_memory_init(void) { }
 
 static inline void kho_populate(phys_addr_t fdt_phys, u64 fdt_len,
diff --git a/kernel/liveupdate/Makefile b/kernel/liveupdate/Makefile
index d2f779cbe279..dc352839ccf0 100644
--- a/kernel/liveupdate/Makefile
+++ b/kernel/liveupdate/Makefile
@@ -7,7 +7,6 @@ luo-y :=								\
 		luo_session.o
 
 obj-$(CONFIG_KEXEC_HANDOVER)		+= kexec_handover.o
-obj-$(CONFIG_KEXEC_HANDOVER_DEBUG)	+= kexec_handover_debug.o
 obj-$(CONFIG_KEXEC_HANDOVER_DEBUGFS)	+= kexec_handover_debugfs.o
 
 obj-$(CONFIG_LIVEUPDATE)		+= luo.o
diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index 532f455c5d4f..c9b982372d6e 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -820,7 +820,8 @@ int kho_preserve_folio(struct folio *folio)
 	const unsigned long pfn = folio_pfn(folio);
 	const unsigned int order = folio_order(folio);
 
-	if (WARN_ON(kho_scratch_overlap(pfn << PAGE_SHIFT, PAGE_SIZE << order)))
+	if (WARN_ON(kho_scratch_overlap_debug(pfn << PAGE_SHIFT,
+					      PAGE_SIZE << order)))
 		return -EINVAL;
 
 	return kho_radix_add_page(tree, pfn, order);
@@ -864,10 +865,9 @@ int kho_preserve_pages(struct page *page, unsigned long nr_pages)
 	unsigned long failed_pfn = 0;
 	int err = 0;
 
-	if (WARN_ON(kho_scratch_overlap(start_pfn << PAGE_SHIFT,
-					nr_pages << PAGE_SHIFT))) {
+	if (WARN_ON(kho_scratch_overlap_debug(start_pfn << PAGE_SHIFT,
+					      nr_pages << PAGE_SHIFT)))
 		return -EINVAL;
-	}
 
 	while (pfn < end_pfn) {
 		unsigned int order =
@@ -1327,6 +1327,26 @@ int kho_retrieve_subtree(const char *name, phys_addr_t *phys)
 }
 EXPORT_SYMBOL_GPL(kho_retrieve_subtree);
 
+bool kho_scratch_overlap(phys_addr_t phys, size_t size)
+{
+	phys_addr_t scratch_start, scratch_end;
+	unsigned int i;
+
+	if (!kho_scratch)
+		return false;
+
+	for (i = 0; i < kho_scratch_cnt; i++) {
+		scratch_start = kho_scratch[i].addr;
+		scratch_end = kho_scratch[i].addr + kho_scratch[i].size;
+
+		if (phys < scratch_end && (phys + size) > scratch_start)
+			return true;
+	}
+
+	return false;
+}
+EXPORT_SYMBOL_GPL(kho_scratch_overlap);
+
 static int __init kho_mem_retrieve(const void *fdt)
 {
 	struct kho_radix_tree tree;
diff --git a/kernel/liveupdate/kexec_handover_debug.c b/kernel/liveupdate/kexec_handover_debug.c
deleted file mode 100644
index 6efb696f5426..000000000000
--- a/kernel/liveupdate/kexec_handover_debug.c
+++ /dev/null
@@ -1,25 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * kexec_handover_debug.c - kexec handover optional debug functionality
- * Copyright (C) 2025 Google LLC, Pasha Tatashin <pasha.tatashin@soleen.com>
- */
-
-#define pr_fmt(fmt) "KHO: " fmt
-
-#include "kexec_handover_internal.h"
-
-bool kho_scratch_overlap(phys_addr_t phys, size_t size)
-{
-	phys_addr_t scratch_start, scratch_end;
-	unsigned int i;
-
-	for (i = 0; i < kho_scratch_cnt; i++) {
-		scratch_start = kho_scratch[i].addr;
-		scratch_end = kho_scratch[i].addr + kho_scratch[i].size;
-
-		if (phys < scratch_end && (phys + size) > scratch_start)
-			return true;
-	}
-
-	return false;
-}
diff --git a/kernel/liveupdate/kexec_handover_internal.h b/kernel/liveupdate/kexec_handover_internal.h
index 9a832a35254c..804d6a1209b8 100644
--- a/kernel/liveupdate/kexec_handover_internal.h
+++ b/kernel/liveupdate/kexec_handover_internal.h
@@ -41,9 +41,12 @@ static inline void kho_debugfs_fdt_remove(struct kho_debugfs *dbg,
 #endif /* CONFIG_KEXEC_HANDOVER_DEBUGFS */
 
 #ifdef CONFIG_KEXEC_HANDOVER_DEBUG
-bool kho_scratch_overlap(phys_addr_t phys, size_t size);
+static inline bool kho_scratch_overlap_debug(phys_addr_t phys, size_t size)
+{
+	return kho_scratch_overlap(phys, size);
+}
 #else
-static inline bool kho_scratch_overlap(phys_addr_t phys, size_t size)
+static inline bool kho_scratch_overlap_debug(phys_addr_t phys, size_t size)
 {
 	return false;
 }
-- 
2.53.0.851.ga537e3e6e9-goog


