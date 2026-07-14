Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28CCEC43458
	for <kexec@archiver.kernel.org>; Tue, 14 Jul 2026 20:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:Mime-Version:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=d9tldHgHpDRf8TAZCwFzg+tWQLwf+4+RS0Dz7CW5np8=; b=IyHNNk/qfyejgzkz8viRSDNkHe
	FahYsii9jXtk1hcql+zz8wzIfBvAZoTYI77FNCOhRn3RLFEa88WsOQQmm46FMjYZk4F/DM3wJoOZT
	CRSRbjBGJHguBoFJ0klpiDfqGykj+Rt/FnUlq8qkfbr0V9e7kAnfAMuqJDl2G7VExC0rK1fvPJXOX
	o2icm5GqfSYqYYC+sMITt7Of0bvb23acG9cMrI1G0hp0SzqJkp7+B3SvwtrJ6ldE0+2V0TroCJE90
	z3HpsKAMLmXXNAtsHPwXP4blHd594eHhvOiwK/HhEvlDXy5JW/h/4XvGp+QL9KasCAacG8+prEUX7
	DSwDT9Mg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjk6B-0000000DGYQ-2uWw;
	Tue, 14 Jul 2026 20:51:27 +0000
Received: from mail-wr1-x44a.google.com ([2a00:1450:4864:20::44a])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjk69-0000000DGXm-1MFj
	for kexec@lists.infradead.org;
	Tue, 14 Jul 2026 20:51:26 +0000
Received: by mail-wr1-x44a.google.com with SMTP id ffacd0b85a97d-47f3e6cc5c4so794497f8f.3
        for <kexec@lists.infradead.org>; Tue, 14 Jul 2026 13:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784062282; x=1784667082; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=d9tldHgHpDRf8TAZCwFzg+tWQLwf+4+RS0Dz7CW5np8=;
        b=esGzMygqaKmgtHzomQzlYLnGEoZ0ZHHuZR8arAZhMqkf8euDrKCd1S4bqPjWJqcxMl
         28xdd2a4LXAO2iS66ok1CIRHiM99fFJk/FIjrY1LCTHtepcYhaT+TdTNTVYhZ5r2r38G
         3HSYRYZSajIu+751sr2qMLPHYZjL3fFDxOIfEBlduQ+hn+H75vex4lSCjTFQ73M5te93
         aOtDR8sMPLTD6yl/v7wB439xTZ5B6recAi6EP+HeCiZ4k7I6w5ELmB2LPM2r+t1vmrFW
         TxxdUnmJ7mYFhxHHz/Ofr6FUxGOlDBLH/y058JsCUfmj8UKzhP+8g8mU4fMbh9uOFYnj
         +k1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784062282; x=1784667082;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=d9tldHgHpDRf8TAZCwFzg+tWQLwf+4+RS0Dz7CW5np8=;
        b=j9cpvKR6EoZevk7Tj4fyDIIWUu9i4f+agCZtmwjVaC6Zv9ZxRWmE4LsVHRQwY3hpck
         a4W+lOimJN1KXtc7ey8JknDyPez5ho5SZ1TyBJ9+GPA5L9/QgNy+fPDZyRUl2gCZ6BJP
         qC7AhVFhwZI4+EbVzqaZZslBCRsiAtOE3DRPjmc5ORQQ5/eLFeSpeAw595rvOWxW65yY
         rW1aK63UbEyVhCxVbCS2xgjM0fkY5KHGCwF/SujsqUCrNXlXkvmkamQUo/zNK3NLb+hf
         Gz/dQ/v+fJmXq5pqLp2PUnnqOKdtiSXnVPzAs3LUYftcf6+dhwF4Zi0c9JQAfywamkI8
         Qdww==
X-Forwarded-Encrypted: i=1; AHgh+RqoFMnkPrUo6WFRxEMVeBDknTVgQhc86w3z2FqXb4j/U4tU9Pj2rsSXI/panBmfH+mytlW3zQ==@lists.infradead.org
X-Gm-Message-State: AOJu0Yy1SRrtrVR4HDSuxuyglDyk5Z0QPxg5+3tkydO1ZitPP6Q9j7XU
	5L9b1gsJl7+LT9Zywo6bAtXU1GphFSFhy9pCD9arqqxou0x+aWhcuyGnL1nGWEpLYpaOcQLlSFX
	17Mb87kGe908WydlPmjwHXA==
X-Received: from wmkz11.prod.google.com ([2002:a7b:c7cb:0:b0:493:b78f:716b])
 (user=mclapinski job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3f06:b0:493:b9cd:1272 with SMTP id 5b1f17b1804b1-493f881de56mr144831135e9.23.1784062282098;
 Tue, 14 Jul 2026 13:51:22 -0700 (PDT)
Date: Tue, 14 Jul 2026 22:51:11 +0200
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.141.g00534a21ce-goog
Message-ID: <20260714205111.2497151-1-mclapinski@google.com>
Subject: [PATCH] kho: align kho_scratch to MAX_ORDER_NR_PAGES pages
From: Michal Clapinski <mclapinski@google.com>
To: Mike Rapoport <rppt@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Alexander Graf <graf@amazon.com>, 
	Evangelos Petrongonas <epetron@amazon.de>, kexec@lists.infradead.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Michal Clapinski <mclapinski@google.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260714_135125_395336_A997ECC5 
X-CRM114-Status: GOOD (  18.37  )
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

I caught this crash:
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

deferred_init_memmap_chunk() works fine without KHO because free
regions will never be neighbors. However, with KHO, free memory
will be split into (free && scratch) and (free && !scratch).
KHO scratch is aligned to CMA_MIN_ALIGNMENT_BYTES (which on my setup
is equal to 1 << 9 pages) but buddy can look at the neighborhood of
MAX_ORDER_NR_PAGES pages (which is equal to 1 << 10 pages).
This sometimes crashes when one half of the neighborhood is being
initialized but the other part is yet to be initialized.

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
index 4834a809985a..50928aaa3371 100644
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
+#define SCRATCH_ALIGNMENT_BYTES (1 << (PAGE_SHIFT + MAX_PAGE_ORDER))
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
2.55.0.141.g00534a21ce-goog


