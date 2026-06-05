Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0126CD6E7E
	for <kexec@archiver.kernel.org>; Fri,  5 Jun 2026 18:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LOiNopfyqH+evMdJ4RgcQZeJWf2liHs2K6IwtzYjoWE=; b=dF5FaEUBJ+b7VNaI80ACYN3veS
	Q5P/B2S2Sh8ihqviZQCN7iFwiNYnfEu18IcnatQZE4uo2vdcFZ/wdB6LGwiDpPb7ySRFazJ0yyOTu
	XSwYSKbMejN/xeFuHR8Ebdk/lphTo1ovGmqsxQneeV2RCLdPFClnVrigOE8guP6yMVZattm5EITrr
	O8A+OZp4Htq6vN/CyRT8iVSJ+2VeN9kRw+fK8An+b/Rvt/lSUEnKkxEg17pH0L/Jw5RmTFcFaAjb6
	Z8uxl2vvSK0VW2dZgzC5xETXuQ1pGwGBfOCf/UzAQd2xSPXv3CA97LvNuJzahjfQrTAt6GvcEiYnT
	vV0Ue3dw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wVZOR-000000013Lz-0uDG;
	Fri, 05 Jun 2026 18:35:43 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wVZOQ-000000013LQ-1LqT
	for kexec@lists.infradead.org;
	Fri, 05 Jun 2026 18:35:42 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 1941243BE7;
	Fri,  5 Jun 2026 18:35:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCB0A1F00899;
	Fri,  5 Jun 2026 18:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780684542;
	bh=LOiNopfyqH+evMdJ4RgcQZeJWf2liHs2K6IwtzYjoWE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CCVRNwyby+ygQUpFDO97aU/NeI3sJPjkf8B7Mrxw243tA405VrgkDHfzpVkBBL75D
	 sCr3NTa3AYl5JZTLxRwqzRbnanUFMoh/VLphQ/GLQzn/4gznLTDZWd2iaQAQoc+RGh
	 Mf/kq93HkUIqFIr1IWwHSPNVZ4jHg8gQz1vNXBMjbnx2HktU968oZ8H2jk7/8hges9
	 NvBQBbNXrvbyrsHM4bGiVPxBTCQLW6LMLNM6TQQ+u6adVZHnf6wzo57oKx3m7Q6+pi
	 HKoIhKEVOIUyk/hFcoDJxNyFviWxzqFUNXy5mVs0zWcdGGtC7RRpOtDav5xI7xVF7p
	 xS1nTEabVjOdA==
From: Pratyush Yadav <pratyush@kernel.org>
To: Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Alexander Graf <graf@amazon.com>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jason Miu <jasonmiu@google.com>,
	Jork Loeser <jloeser@linux.microsoft.com>
Cc: kexec@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 12/18] kho: export kho_scratch_overlap()
Date: Fri,  5 Jun 2026 20:34:45 +0200
Message-ID: <20260605183501.3884950-13-pratyush@kernel.org>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
In-Reply-To: <20260605183501.3884950-1-pratyush@kernel.org>
References: <20260605183501.3884950-1-pratyush@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: "Pratyush Yadav (Google)" <pratyush@kernel.org>

Support for discovering memory blocks with no preserved memory will be
added in coming patches. These areas will also be marked as scratch to
allow allocations from them. Memblock will switch to looking through the
scratch array to decide the right migratetype.

Export kho_scratch_overlap(). Since it is now used by non-debug code,
move it out of kexec_handover_debug.c and into kexec_handover.c. Gate
the overlap checks in kho_preserve_folio() and kho_preserve_pages() by
IS_ENABLED(CONFIG_KEXEC_HANDOVER_DEBUG) instead.

Since kexec_handover_debug.c is now empty, delete it.

No functional changes.

Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>
---
 include/linux/kexec_handover.h              |  7 ++++++
 kernel/liveupdate/Makefile                  |  1 -
 kernel/liveupdate/kexec_handover.c          | 22 ++++++++++++++++--
 kernel/liveupdate/kexec_handover_debug.c    | 25 ---------------------
 kernel/liveupdate/kexec_handover_internal.h |  9 --------
 5 files changed, 27 insertions(+), 37 deletions(-)
 delete mode 100644 kernel/liveupdate/kexec_handover_debug.c

diff --git a/include/linux/kexec_handover.h b/include/linux/kexec_handover.h
index 8968c56d2d73..3740c14d970d 100644
--- a/include/linux/kexec_handover.h
+++ b/include/linux/kexec_handover.h
@@ -40,6 +40,8 @@ void kho_memory_init(void);
 
 void kho_populate(phys_addr_t fdt_phys, u64 fdt_len, phys_addr_t scratch_phys,
 		  u64 scratch_len);
+
+bool kho_scratch_overlap(phys_addr_t phys, size_t size);
 #else
 static inline bool kho_is_enabled(void)
 {
@@ -116,6 +118,11 @@ static inline void kho_populate(phys_addr_t fdt_phys, u64 fdt_len,
 				phys_addr_t scratch_phys, u64 scratch_len)
 {
 }
+
+static inline bool kho_scratch_overlap(phys_addr_t phys, size_t size)
+{
+	return false;
+}
 #endif /* CONFIG_KEXEC_HANDOVER */
 
 #endif /* LINUX_KEXEC_HANDOVER_H */
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
index 8ab2c7e234e1..a66f23a35389 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -766,6 +766,22 @@ static phys_addr_t __init scratch_size_node(int nid)
 	return round_up(size, CMA_MIN_ALIGNMENT_BYTES);
 }
 
+bool kho_scratch_overlap(phys_addr_t phys, size_t size)
+{
+	phys_addr_t scratch_start, scratch_end;
+	unsigned int i;
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
+
 /**
  * kho_reserve_scratch - Reserve a contiguous chunk of memory for kexec
  *
@@ -963,7 +979,8 @@ int kho_preserve_folio(struct folio *folio)
 	const unsigned long pfn = folio_pfn(folio);
 	const unsigned int order = folio_order(folio);
 
-	if (WARN_ON(kho_scratch_overlap(pfn << PAGE_SHIFT, PAGE_SIZE << order)))
+	if (IS_ENABLED(CONFIG_KEXEC_HANDOVER_DEBUG) &&
+	    WARN_ON(kho_scratch_overlap(pfn << PAGE_SHIFT, PAGE_SIZE << order)))
 		return -EINVAL;
 
 	return kho_radix_add_key(tree, kho_encode_radix_key(PFN_PHYS(pfn),
@@ -1040,7 +1057,8 @@ int kho_preserve_pages(struct page *page, unsigned long nr_pages)
 	unsigned long failed_pfn = 0;
 	int err = 0;
 
-	if (WARN_ON(kho_scratch_overlap(start_pfn << PAGE_SHIFT,
+	if (IS_ENABLED(CONFIG_KEXEC_HANDOVER_DEBUG) &&
+	    WARN_ON(kho_scratch_overlap(start_pfn << PAGE_SHIFT,
 					nr_pages << PAGE_SHIFT))) {
 		return -EINVAL;
 	}
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
index 0399ff107775..805d2a76c388 100644
--- a/kernel/liveupdate/kexec_handover_internal.h
+++ b/kernel/liveupdate/kexec_handover_internal.h
@@ -41,13 +41,4 @@ static inline void kho_debugfs_blob_remove(struct kho_debugfs *dbg,
 					   void *blob) { }
 #endif /* CONFIG_KEXEC_HANDOVER_DEBUGFS */
 
-#ifdef CONFIG_KEXEC_HANDOVER_DEBUG
-bool kho_scratch_overlap(phys_addr_t phys, size_t size);
-#else
-static inline bool kho_scratch_overlap(phys_addr_t phys, size_t size)
-{
-	return false;
-}
-#endif /* CONFIG_KEXEC_HANDOVER_DEBUG */
-
 #endif /* LINUX_KEXEC_HANDOVER_INTERNAL_H */
-- 
2.54.0.1032.g2f8565e1d1-goog


