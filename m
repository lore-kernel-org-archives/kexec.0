Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEC7EC44520
	for <kexec@archiver.kernel.org>; Fri, 17 Jul 2026 13:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:Mime-Version:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=qJ3lF392ZnaDQ7ksH9U+tbRYSBGb3EW5QpOiJ+U17/M=; b=rkw8woZDyXD4jU+19yzlXfueRt
	e+DXUU41n7+r+3dsM65SwqmRdJU1d5jugU+GLGHXF2rgAydDSFMXu1Vg68SXykMTtbDL7O8+ix7JN
	HsdGgbUAK9GoqYg5bjKD/H8TrR3tVOdIYbB8p/TDgELp1Lie35RSyiBhGKgDdbeXbJWcfR+TPlw/J
	z0fh4hx7dnsPxyxpFplxkPe0K7CSrdyUkQNxDjcQU7ovTnZvXV2N7uEhmmYxw+pVW1/6TQrYCmi80
	y1sclfzjJmDwI9gGlqbjV3QGSG9ZjVr1/j9fDeyoqqtmVlTxGy5k7VOm9PLllHQqohWQReDm6BhK+
	pv9WpCzw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wkioM-00000002QK4-3K56;
	Fri, 17 Jul 2026 13:41:06 +0000
Received: from mail-wm1-x34a.google.com ([2a00:1450:4864:20::34a])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wkins-00000002QIi-06Og
	for kexec@lists.infradead.org;
	Fri, 17 Jul 2026 13:41:05 +0000
Received: by mail-wm1-x34a.google.com with SMTP id 5b1f17b1804b1-495427ed72eso24370095e9.2
        for <kexec@lists.infradead.org>; Fri, 17 Jul 2026 06:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784295633; x=1784900433; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qJ3lF392ZnaDQ7ksH9U+tbRYSBGb3EW5QpOiJ+U17/M=;
        b=rqDyEiJ/hkBwweMNkXNdKl20ahmMK/e+AfsjSh2T8txZGHKNU/ixs2Xn10ByBQ6cy3
         HCeeOqQlPtX430+QOSwiK0a58IfCCWU/noz4oMSca56dWwrwt/9vUqsmZemQsuABEYM0
         5QMXMk4bpBkoH07F2m6jWyILvVsygV95XbShuaR1WyABR8bxp/XneRcJ4o3lXeETk32D
         OF4SROtxVRJeHe6Xq2FwJVlHDIxHVuNrhoRhdPv4FUazkRXgt0DwlIIDFY1cKkgtdw9a
         6sTAQTJ3R106PbxP+2AqqfL0/17/EkajOg/+H1U1XVjRm7ZtcxLF0XSiTd/+KpZk+Gl8
         clSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784295633; x=1784900433;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qJ3lF392ZnaDQ7ksH9U+tbRYSBGb3EW5QpOiJ+U17/M=;
        b=NXN1E8Ren9aeGIMYxAyIXzHgXt12uICJKYsuInlod2+5bwmicLMF9NDoK4+PuMU/D2
         Zbt9kmxBvUhIrCLH0Rb+fdMQCRKbIJfK2Iqdvk0pHjnH64xKc7QegeLU6Czh0n4kkpEr
         urcq+Kq/3yDZQlimfY99efi/PYZTqOqA0Y4xb9KuKXyf292j28IV7b1QlPilrBf9DKBu
         7zJztWUZOYfh1VjOGPmz/EIAKepBDXr6m/zLk/7WRR+E7cvZzdb+jdAu/gnTZcNrGVW7
         yDU/N4d2w/5iGfxac1hUJA2zzg8TKvZIBYrSlYIrs+WyUvA7ah08k9qCO8P88ZKU4Ze+
         gJZQ==
X-Forwarded-Encrypted: i=1; AHgh+RqxXVdFIYCoHuUqaAK00Bua6KzeC6/C0w2Ob60B4BgiSy2fPUGDdnkkNgvbmVzdXimS66KZsw==@lists.infradead.org
X-Gm-Message-State: AOJu0YwuEkefOxDzu/SbYB7XsXUbOuhoiCZ9zvJtlpe/Gw40StZkra4h
	JwlrDEgaCzGD2U7DZQkz1Ox27TdCYDCXA4PP1913/bIHBGmewEvSRX+nDlsEGrKRw7OSz2tK+dX
	BVIGj7ZqUJcP61HMBaVizgQ==
X-Received: from wrvx6.prod.google.com ([2002:a5d:54c6:0:b0:47f:4443:1db4])
 (user=mclapinski job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1382:b0:495:3f48:5df2 with SMTP id 5b1f17b1804b1-4954a40bcf6mr31154885e9.29.1784295632744;
 Fri, 17 Jul 2026 06:40:32 -0700 (PDT)
Date: Fri, 17 Jul 2026 15:40:28 +0200
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260717134028.2880508-1-mclapinski@google.com>
Subject: [PATCH v2] kho: align kho_scratch to MAX_ORDER_NR_PAGES pages
From: Michal Clapinski <mclapinski@google.com>
To: Mike Rapoport <rppt@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Alexander Graf <graf@amazon.com>, 
	Evangelos Petrongonas <epetron@amazon.de>, kexec@lists.infradead.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Michal Clapinski <mclapinski@google.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260717_064036_115184_5D410B87 
X-CRM114-Status: GOOD (  16.24  )
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

While booting with KHO, the following crash was observed:

BUG: unable to handle page fault for address: ff19164fffff8328
RIP: 0010:__free_one_page+0x1a1/0x6b0
Call Trace:
 <TASK>
 [<ffffffff913208bf>] free_one_page+0xaf/0x240
 [<ffffffff93973288>] deferred_free_pages+0xa8/0xd0
 [<ffffffff93971b4f>] deferred_init_memmap_chunk+0x10f/0x1b0
 [<ffffffff9396e265>] padata_mt_helper+0x65/0xa0
 [<ffffffff90fac402>] process_scheduled_works+0x202/0x410
 [<ffffffff90fae739>] worker_thread+0x1f9/0x2d0
 [<ffffffff90fb62fd>] kthread+0x27d/0x2f0
 [<ffffffff90fae540>] ? __pfx_worker_thread+0x10/0x10
 [<ffffffff90fb6080>] ? __pfx_kthread+0x10/0x10
 [<ffffffff90efdc55>] ret_from_fork+0x145/0x280
 [<ffffffff90fb6080>] ? __pfx_kthread+0x10/0x10
 [<ffffffff90e2e46a>] ret_from_fork_asm+0x1a/0x30
 </TASK>

deferred_init_memmap_chunk() interleaves initialization of struct pages
with freeing them. This works fine without KHO because free regions
will never be neighbors. However, with KHO, free memory will be split
into (free && scratch) and (free && !scratch), which can be neighbors.

KHO scratch is aligned to CMA_MIN_ALIGNMENT_PAGES pages but buddy looks
at the neighborhood of MAX_ORDER_NR_PAGES pages. These values are
configurable but CMA_MIN_ALIGNMENT_PAGES is always less or equal to
MAX_ORDER_NR_PAGES. In the crashing configuration they were set as
follows:
CMA_MIN_ALIGNMENT_PAGES = 1 << 9
MAX_ORDER_NR_PAGES = 1 << 10

So while freeing one chunk, buddy accessed uninitialized struct pages
from another chunk, tried to merge the blocks and crashed.

To fix this, let's just align KHO scratch to MAX_ORDER_NR_PAGES pages.

Fixes: c6073743d0c7 ("kho: make preserved pages compatible with deferred struct page init")
Signed-off-by: Michal Clapinski <mclapinski@google.com>
---
Unfortunately, this is very hard to catch, so I don't have a good
reproducer. But I run the code with the fix through extensive testing
and it seems fine.
I think I've never caught it before because enabling HUGETLB is what
causes CMA_MIN_ALIGNMENT_PAGES to be 1 << 9, instead of 1 << 10.

If this passes review, please cherry-pick it to 7.2 so we don't release
a broken kernel.
---
 kernel/liveupdate/kexec_handover.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index 4834a809985a..175c08a6e41e 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -38,6 +38,16 @@
 #include "../kexec_internal.h"
 #include "kexec_handover_internal.h"
 
+/*
+ * This is the minimal alignment required by deferred struct page init.
+ * deferred_init_memmap_chunk frees memory to the buddy allocator, which looks
+ * at the neighboring pages (up to MAX_PAGE_ORDER) to merge them.
+ * If KHO scratch is not aligned to that value, buddy can access uninitialized
+ * struct pages, which can cause a crash.
+ */
+#define SCRATCH_ALIGNMENT_BYTES (PAGE_SIZE * MAX_ORDER_NR_PAGES)
+static_assert(SCRATCH_ALIGNMENT_BYTES >= CMA_MIN_ALIGNMENT_BYTES);
+
 /* The magic token for preserved pages */
 #define KHO_PAGE_MAGIC 0x4b484f50U /* ASCII for 'KHOP' */
 
@@ -640,8 +650,8 @@ static void __init scratch_size_update(void)
 	 * Scratch areas are released as MIGRATE_CMA. Round them up to the right
 	 * size.
 	 */
-	scratch_size_lowmem = round_up(scratch_size_lowmem, CMA_MIN_ALIGNMENT_BYTES);
-	scratch_size_global = round_up(scratch_size_global, CMA_MIN_ALIGNMENT_BYTES);
+	scratch_size_lowmem = round_up(scratch_size_lowmem, SCRATCH_ALIGNMENT_BYTES);
+	scratch_size_global = round_up(scratch_size_global, SCRATCH_ALIGNMENT_BYTES);
 }
 
 static phys_addr_t __init scratch_size_node(int nid)
@@ -656,7 +666,7 @@ static phys_addr_t __init scratch_size_node(int nid)
 		size = scratch_size_pernode;
 	}
 
-	return round_up(size, CMA_MIN_ALIGNMENT_BYTES);
+	return round_up(size, SCRATCH_ALIGNMENT_BYTES);
 }
 
 /**
@@ -692,7 +702,7 @@ static void __init kho_reserve_scratch(void)
 	 * next kernel
 	 */
 	size = scratch_size_lowmem;
-	addr = memblock_phys_alloc_range(size, CMA_MIN_ALIGNMENT_BYTES, 0,
+	addr = memblock_phys_alloc_range(size, SCRATCH_ALIGNMENT_BYTES, 0,
 					 ARCH_LOW_ADDRESS_LIMIT);
 	if (!addr) {
 		pr_err("Failed to reserve lowmem scratch buffer\n");
@@ -705,7 +715,7 @@ static void __init kho_reserve_scratch(void)
 
 	/* reserve large contiguous area for allocations without nid */
 	size = scratch_size_global;
-	addr = memblock_phys_alloc(size, CMA_MIN_ALIGNMENT_BYTES);
+	addr = memblock_phys_alloc(size, SCRATCH_ALIGNMENT_BYTES);
 	if (!addr) {
 		pr_err("Failed to reserve global scratch buffer\n");
 		goto err_free_scratch_areas;
@@ -721,7 +731,7 @@ static void __init kho_reserve_scratch(void)
 	 */
 	for_each_node_state(nid, N_MEMORY) {
 		size = scratch_size_node(nid);
-		addr = memblock_alloc_range_nid(size, CMA_MIN_ALIGNMENT_BYTES,
+		addr = memblock_alloc_range_nid(size, SCRATCH_ALIGNMENT_BYTES,
 						0, MEMBLOCK_ALLOC_ACCESSIBLE,
 						nid, true);
 		if (!addr) {
-- 
2.55.0.229.g6434b31f56-goog


