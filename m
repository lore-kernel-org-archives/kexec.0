Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 101D7C982DB
	for <kexec@archiver.kernel.org>; Fri, 16 Jan 2026 16:54:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ORzddBrbw+D4uXnd0lt19gTnZVM9KpKMSRBPxVW3aSw=; b=PYxj/9vNYSuEo2jqP0+LOwhGZU
	4ZVVBzWJkoR2DZKV02E0h/ViWtu8tdd88d7l2WH9MwTYdVogtlfbwJgEGR2zBeZoSGg/AKapz99RT
	3AGozQk/6zTyEFnx5AAnjLxNrxIuldFzmpfllY/nkp1atZUEDAt9kJWaRMy/JyyCZhV616nJCcTYl
	sFovVDFzo2XuDru0Xfg2jZ1Jvmu9XopOv89YTclCAKHNlGh+KDv1+QWrAwSlDXOQR7s0rgtq3qwoB
	XRv0JZAJKV6zSszqHJdRMilbfQnjPnjzo0GutpaFkzxTY0mPZJuANiAGJ3MVzFzv0Wik6r2rdMpxf
	TYLSgQHw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vgn5i-0000000EUnV-2gTY;
	Fri, 16 Jan 2026 16:54:30 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vgn5i-0000000EUnJ-0NMD
	for kexec@lists.infradead.org;
	Fri, 16 Jan 2026 16:54:30 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 1F10F60160;
	Fri, 16 Jan 2026 16:54:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2095C116C6;
	Fri, 16 Jan 2026 16:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768582468;
	bh=AgWf6hPAtL4GliApjS2EmEaZMLApvSCfTMtAOCyeuvI=;
	h=From:To:Cc:Subject:Date:From;
	b=BKf01sPkBRzCsFEmg4ZVDfpmZ90mayC3ZU/FN+ZHAo23vyeGtT+oXnjZyugbGuq74
	 FYKbltjY4O1OLBf2usHtyXNgg7hw6959Ax0Ue9Vz0pIKxmeSxV7l6eObGfrjVtXk9x
	 66r8Z0xoQo+DyIPpSDyqLgRQDiPuP2Ony+VxR5L2XjBO7tuuqUTT5njMafIOjTEn/u
	 8GCsJkk9Nm4+ey5dbbS3DGbC9Mr+2iyqzi+44UfU4bL1bhG/hK2M5i9Ai7qMherKUq
	 s1TiafCUSp5IqGC77jGfCGzpOdbeB+QxJ7qQRplDkh92leWgohrPGmUln2kY1vIOQ4
	 c154X1C7YSDrw==
From: Pratyush Yadav <pratyush@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Alexander Graf <graf@amazon.com>,
	Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>
Cc: kexec@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Samiullah Khawaja <skhawaja@google.com>,
	David Matlack <dmatlack@google.com>,
	Jason Miu <jasonmiu@google.com>
Subject: [PATCH] kho: print which scratch buffer failed to be reserved
Date: Fri, 16 Jan 2026 16:54:11 +0000
Message-ID: <20260116165416.1262531-1-pratyush@kernel.org>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
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

When scratch area fails to reserve, KHO prints a message indicating
that. But it doesn't say which scratch failed to allocate. This can be
useful information for debugging. Even more so when the failure is hard
to reproduce.

Along with the current message, also print which exact scratch area
failed to be reserved.

Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>
---
 kernel/liveupdate/kexec_handover.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index 49bf2cecab12..636bd96780ae 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -651,8 +651,10 @@ static void __init kho_reserve_scratch(void)
 	kho_scratch_cnt = num_online_nodes() + 2;
 	size = kho_scratch_cnt * sizeof(*kho_scratch);
 	kho_scratch = memblock_alloc(size, PAGE_SIZE);
-	if (!kho_scratch)
+	if (!kho_scratch) {
+		pr_err("Failed to reserve scratch array\n");
 		goto err_disable_kho;
+	}
 
 	/*
 	 * reserve scratch area in low memory for lowmem allocations in the
@@ -661,8 +663,10 @@ static void __init kho_reserve_scratch(void)
 	size = scratch_size_lowmem;
 	addr = memblock_phys_alloc_range(size, CMA_MIN_ALIGNMENT_BYTES, 0,
 					 ARCH_LOW_ADDRESS_LIMIT);
-	if (!addr)
+	if (!addr) {
+		pr_err("Failed to reserve lowmem scratch buffer\n");
 		goto err_free_scratch_desc;
+	}
 
 	kho_scratch[i].addr = addr;
 	kho_scratch[i].size = size;
@@ -671,8 +675,10 @@ static void __init kho_reserve_scratch(void)
 	/* reserve large contiguous area for allocations without nid */
 	size = scratch_size_global;
 	addr = memblock_phys_alloc(size, CMA_MIN_ALIGNMENT_BYTES);
-	if (!addr)
+	if (!addr) {
+		pr_err("Failed to reserve global scratch buffer\n");
 		goto err_free_scratch_areas;
+	}
 
 	kho_scratch[i].addr = addr;
 	kho_scratch[i].size = size;
@@ -683,8 +689,10 @@ static void __init kho_reserve_scratch(void)
 		addr = memblock_alloc_range_nid(size, CMA_MIN_ALIGNMENT_BYTES,
 						0, MEMBLOCK_ALLOC_ACCESSIBLE,
 						nid, true);
-		if (!addr)
+		if (!addr) {
+			pr_err("Failed to reserve nid %d scratch buffer\n", nid);
 			goto err_free_scratch_areas;
+		}
 
 		kho_scratch[i].addr = addr;
 		kho_scratch[i].size = size;

base-commit: c37fac0551448c68e36f14782acaf662c7a1775e
-- 
2.52.0.457.g6b5491de43-goog


