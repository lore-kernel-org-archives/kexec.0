Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3F26CD4F3C
	for <kexec@archiver.kernel.org>; Tue, 19 May 2026 16:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=9QW5SgZY12q+CtgpE3Pdsd4CEZVaIO577Em6GvO5TO8=; b=B3QbeK24zQuPRzFfUQmk6u1K+C
	p2Ys1SDc70hTZzDY43eyitdtmNMRR7jTaAfBhpg40fx8z7Y6ehwp0w8m6yeJ4XksoofIAATvTEaXt
	rAnYDKrDwIo7+rUo6tgdgqYilZ0PtBaHfgV4ZUFo8BRPJOERTk2H6XAqiETBmqpN2BueEiT3Cf5U5
	6IXKpbfBylk924vK8pSElC9VHevsHZdtnUWUioK9Y7cT88kFqQu27F5axN/DWgvaupRU7/9MuxFxZ
	tzUqMFEbdDQvPP0yr7pVIh29cj40E2+g759WGq54ITTm+wleUf1PXqfyI+OBkU1uWOZWknmp+qenW
	EXxSFy4g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPMxL-00000002Afs-2CLa;
	Tue, 19 May 2026 16:06:07 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPMxJ-00000002AfF-39Wh
	for kexec@lists.infradead.org;
	Tue, 19 May 2026 16:06:05 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 3884660145;
	Tue, 19 May 2026 16:06:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65C34C2BCB3;
	Tue, 19 May 2026 16:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779206764;
	bh=3G28d0TOyfNRinSp659QFq62b49e9yvwWyjT8rXN4fw=;
	h=From:To:Cc:Subject:Date:From;
	b=qY9x92PrTGloGMB4sUwDGgLF5j6PDvzeOQDKL4aKnBN+UdjLDRJLp8M4OhkH0o0f/
	 v34wNqWmM/VimJEDe5e1axaWRWXocyGKR6cWpMAs+hfake/ZMolhuYIdXauXdv6Z43
	 C9Lf46v9wMzUX2HBhfo4vkdIRUEcBwCmzArpc0DXnR9W5Ehv07QpSAfM7VSHqFlGmC
	 6gZ8RmjgSn5/KzNcnP/8Ov/aRKVGkBBrQNTHa2OnMgj78lNa1N1uF/WMyVaoX0d7Ac
	 atazB59bpZ1DxNW8juJScVZDXLqjM3PRxw1QOQ1HwEMYzwriQ8HkQ4WwF9X/1pLTuQ
	 KFtCIzvbMnZCg==
From: Pratyush Yadav <pratyush@kernel.org>
To: Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Alexander Graf <graf@amazon.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Changyuan Lyu <changyuanl@google.com>
Cc: kexec@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] kho: make sure scratch size is always aligned by CMA_MIN_ALIGNMENT_BYTES
Date: Tue, 19 May 2026 18:05:49 +0200
Message-ID: <20260519160554.2713361-1-pratyush@kernel.org>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
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

When using scratch_scale, the scratch sizes are rounded up to
CMA_MIN_ALIGNMENT_BYTES since they will be released as MIGRATE_CMA. This
is not done when using fixed scratch sizes via command line. This can
result in user specifying a size which is not aligned, and thus kernel
releasing a pageblock that is only partially scratch.

Do the rounding up for both cases in scratch_size_update().

Fixes: 3dc92c311498 ("kexec: add Kexec HandOver (KHO) generation helpers")
Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>
---
 kernel/liveupdate/kexec_handover.c | 32 ++++++++++++++++++++----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index 4fde8325c49f..c26e4df37479 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -607,20 +607,30 @@ early_param("kho_scratch", kho_parse_scratch_size);
 
 static void __init scratch_size_update(void)
 {
-	phys_addr_t size;
+	/*
+	 * If fixed sizes are not provided via command line, calculate them
+	 * now.
+	 */
+	if (scratch_scale) {
+		phys_addr_t size;
 
-	if (!scratch_scale)
-		return;
+		size = memblock_reserved_kern_size(ARCH_LOW_ADDRESS_LIMIT,
+						   NUMA_NO_NODE);
+		size = size * scratch_scale / 100;
+		scratch_size_lowmem = size;
 
-	size = memblock_reserved_kern_size(ARCH_LOW_ADDRESS_LIMIT,
-					   NUMA_NO_NODE);
-	size = size * scratch_scale / 100;
-	scratch_size_lowmem = round_up(size, CMA_MIN_ALIGNMENT_BYTES);
+		size = memblock_reserved_kern_size(MEMBLOCK_ALLOC_ANYWHERE,
+						   NUMA_NO_NODE);
+		size = size * scratch_scale / 100 - scratch_size_lowmem;
+		scratch_size_global = size;
+	}
 
-	size = memblock_reserved_kern_size(MEMBLOCK_ALLOC_ANYWHERE,
-					   NUMA_NO_NODE);
-	size = size * scratch_scale / 100 - scratch_size_lowmem;
-	scratch_size_global = round_up(size, CMA_MIN_ALIGNMENT_BYTES);
+	/*
+	 * Scratch areas are released as MIGRATE_CMA. Round them up to the right
+	 * size.
+	 */
+	scratch_size_lowmem = round_up(scratch_size_lowmem, CMA_MIN_ALIGNMENT_BYTES);
+	scratch_size_global = round_up(scratch_size_global, CMA_MIN_ALIGNMENT_BYTES);
 }
 
 static phys_addr_t __init scratch_size_node(int nid)

base-commit: b1378127003b61930ce30064328640503ad3ef6d
-- 
2.54.0.563.g4f69b47b94-goog


