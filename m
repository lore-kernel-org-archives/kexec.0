Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 347D7CD13D2
	for <kexec@archiver.kernel.org>; Wed, 29 Apr 2026 13:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=u11kOx0qSgfZ3Lz8QmF+bGDRYmL355hw50UAdmG9kDg=; b=qP5HH7oHk27s7OlrFDb3cusAll
	13pQuq3VlpxsGVS13n92F+LlTKgx/hT8stFTpWvkCfLPLHEMndz6RgLF7FAqQq2cxG82jOCH5Qqau
	z74U2Ws2HRZpICZ+HcxEXcG0PeanZIxHn3dFWPs1ClbAZvxjXsYGgwyV9EsQmtzEmelNmS86gnSSg
	TOAUlMVL1eiSyMLW6GnPTcXqBpE6F9HC+Trk22K3pCBUbDWLOTEC4F+um70D1/ay87gD/SlDrcZN9
	sfx5NeXnNiv4qy6/Ezhd8tl1hk6ejkYQ4U3JMGIUz+KwDkxuZk2tmAqyHlyHlRZLkV91ENmJZ739f
	EIXw6Ktg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wI595-00000003gfU-3lIW;
	Wed, 29 Apr 2026 13:40:07 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wI593-00000003gdT-32Ay
	for kexec@lists.infradead.org;
	Wed, 29 Apr 2026 13:40:06 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 70F9B44516;
	Wed, 29 Apr 2026 13:40:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68E00C2BCC7;
	Wed, 29 Apr 2026 13:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777470005;
	bh=IHiLzF9pidNOJYX260CdZehqWF3kTGgKyTVeh/Y6T5M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LJb8v1/h5ggsVkAcUDM2gHnjHQ5ZNE0SkWuM9Do3bFIL7WSg0SOVEX9YJi41meDtW
	 WDuCxpnW1ljTV4ZAzRiTYeb4aV1SO53NetPnmiFEtkGbbdzjrUHdqt8iqzBVjm4kYJ
	 z6q4T81iMtJ0NcpENL7TtU2ziJ1fZiHso9lukIiW9FlbT5yBye+sMUbQl8j66fDora
	 l9oZNpH6BJsiIKywHvuBPnF2GVkJmsHpis0yi/N5YYk9T+/eYKeXqrsPQ8zvsRbQ75
	 5mFGzhI/QYT/AI6wMNzyyrUGs5SJAzzY1ZO0Qv31MGqTtAumGT+b0IeZ805JEEr4hY
	 5gajINmizwp2A==
From: Pratyush Yadav <pratyush@kernel.org>
To: Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Alexander Graf <graf@amazon.com>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jason Miu <jasonmiu@google.com>
Cc: kexec@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 09/12] memblock: introduce MEMBLOCK_KHO_SCRATCH_EXT
Date: Wed, 29 Apr 2026 15:39:11 +0200
Message-ID: <20260429133928.850721-10-pratyush@kernel.org>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
In-Reply-To: <20260429133928.850721-1-pratyush@kernel.org>
References: <20260429133928.850721-1-pratyush@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260429_064005_804312_E2724F70 
X-CRM114-Status: GOOD (  21.08  )
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

In the upcoming commits, the KHO will learn how to discover free blocks
of memory by walking the KHO radix tree. It will then mark those regions
as scratch to allow memory allocation in case scratch runs low.

To differentiate the extended scratch areas from the main scratch areas,
introduce MEMBLOCK_KHO_SCRATCH_EXT. Use it when choosing memblock flags
for allocations during scratch-only. Teach should_skip_region() to check
for both flags before deciding if the region should be skipped.

Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>
---

Notes:
    Checkpatch complains about no space after MEMBLOCK_KHO_SCRATCH_EXT in
    the declaration, but doing so makes it nicely align with all the other
    numbers. Mike, if you'd like I can add some whitespace.

 include/linux/memblock.h | 10 ++++++++++
 mm/memblock.c            | 41 ++++++++++++++++++++++++++++++++++------
 2 files changed, 45 insertions(+), 6 deletions(-)

diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index 5afcd99aa8c1..4f535ca4947a 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -51,6 +51,9 @@ extern unsigned long long max_possible_pfn;
  * memory reservations yet, so we get scratch memory from the previous
  * kernel that we know is good to use. It is the only memory that
  * allocations may happen from in this phase.
+ * @MEMBLOCK_KHO_SCRATCH_EXT: same as MEMBLOCK_KHO_SCRATCH but was discovered at
+ * boot time by finding gaps in preserved memory instead of being passed from
+ * previous kernel. Does not get passed to the next kernel.
  */
 enum memblock_flags {
 	MEMBLOCK_NONE		= 0x0,	/* No special request */
@@ -61,6 +64,7 @@ enum memblock_flags {
 	MEMBLOCK_RSRV_NOINIT	= 0x10,	/* don't initialize struct pages */
 	MEMBLOCK_RSRV_KERN	= 0x20,	/* memory reserved for kernel use */
 	MEMBLOCK_KHO_SCRATCH	= 0x40,	/* scratch memory for kexec handover */
+	MEMBLOCK_KHO_SCRATCH_EXT= 0x80, /* extended scratch memory for KHO */
 };
 
 /**
@@ -157,6 +161,7 @@ int memblock_clear_nomap(phys_addr_t base, phys_addr_t size);
 int memblock_reserved_mark_noinit(phys_addr_t base, phys_addr_t size);
 int memblock_reserved_mark_kern(phys_addr_t base, phys_addr_t size);
 int memblock_mark_kho_scratch(phys_addr_t base, phys_addr_t size);
+int memblock_mark_kho_scratch_ext(phys_addr_t base, phys_addr_t size);
 int memblock_clear_kho_scratch(phys_addr_t base, phys_addr_t size);
 
 void memblock_free(void *ptr, size_t size);
@@ -304,6 +309,11 @@ static inline bool memblock_is_kho_scratch(struct memblock_region *m)
 	return m->flags & MEMBLOCK_KHO_SCRATCH;
 }
 
+static inline bool memblock_is_kho_scratch_ext(struct memblock_region *m)
+{
+	return m->flags & MEMBLOCK_KHO_SCRATCH_EXT;
+}
+
 int memblock_search_pfn_nid(unsigned long pfn, unsigned long *start_pfn,
 			    unsigned long  *end_pfn);
 void __next_mem_pfn_range(int *idx, int nid, unsigned long *out_start_pfn,
diff --git a/mm/memblock.c b/mm/memblock.c
index 01a962681726..79443e004361 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -182,7 +182,7 @@ static enum memblock_flags __init_memblock choose_memblock_flags(void)
 {
 	/* skip non-scratch memory for kho early boot allocations */
 	if (kho_scratch_only)
-		return MEMBLOCK_KHO_SCRATCH;
+		return MEMBLOCK_KHO_SCRATCH | MEMBLOCK_KHO_SCRATCH_EXT;
 
 	return system_has_some_mirror ? MEMBLOCK_MIRROR : MEMBLOCK_NONE;
 }
@@ -1178,8 +1178,9 @@ int __init_memblock memblock_reserved_mark_kern(phys_addr_t base, phys_addr_t si
  * @base: the base phys addr of the region
  * @size: the size of the region
  *
- * Only memory regions marked with %MEMBLOCK_KHO_SCRATCH will be considered
- * for allocations during early boot with kexec handover.
+ * Only memory regions marked with %MEMBLOCK_KHO_SCRATCH or
+ * %MEMBLOCK_KHO_SCRATCH_EXT will be considered for allocations during early
+ * boot with kexec handover.
  *
  * Return: 0 on success, -errno on failure.
  */
@@ -1203,6 +1204,23 @@ __init int memblock_clear_kho_scratch(phys_addr_t base, phys_addr_t size)
 				    MEMBLOCK_KHO_SCRATCH);
 }
 
+/**
+ * memblock_mark_kho_scratch_ext - Mark a memory region as MEMBLOCK_KHO_SCRATCH_EXT.
+ * @base: the base phys addr of the region
+ * @size: the size of the region
+ *
+ * Only memory regions marked with %MEMBLOCK_KHO_SCRATCH or
+ * %MEMBLOCK_KHO_SCRATCH_EXT will be considered for allocations during early
+ * boot with kexec handover.
+ *
+ * Return: 0 on success, -errno on failure.
+ */
+__init int memblock_mark_kho_scratch_ext(phys_addr_t base, phys_addr_t size)
+{
+	return memblock_setclr_flag(&memblock.memory, base, size, 1,
+				    MEMBLOCK_KHO_SCRATCH_EXT);
+}
+
 static bool should_skip_region(struct memblock_type *type,
 			       struct memblock_region *m,
 			       int nid, int flags)
@@ -1236,10 +1254,20 @@ static bool should_skip_region(struct memblock_type *type,
 
 	/*
 	 * In early alloc during kexec handover, we can only consider
-	 * MEMBLOCK_KHO_SCRATCH regions for the allocations
+	 * MEMBLOCK_KHO_SCRATCH or MEMBLOCK_KHO_SCRATCH_EXT regions for the
+	 * allocations.
 	 */
-	if ((flags & MEMBLOCK_KHO_SCRATCH) && !memblock_is_kho_scratch(m))
-		return true;
+	if (flags & (MEMBLOCK_KHO_SCRATCH | MEMBLOCK_KHO_SCRATCH_EXT)) {
+		bool skip = true;
+
+		if ((flags & MEMBLOCK_KHO_SCRATCH) && memblock_is_kho_scratch(m))
+			skip = false;
+
+		if ((flags & MEMBLOCK_KHO_SCRATCH_EXT) && memblock_is_kho_scratch_ext(m))
+			skip = false;
+
+		return skip;
+	}
 
 	return false;
 }
@@ -2799,6 +2827,7 @@ static const char * const flagname[] = {
 	[ilog2(MEMBLOCK_RSRV_NOINIT)] = "RSV_NIT",
 	[ilog2(MEMBLOCK_RSRV_KERN)] = "RSV_KERN",
 	[ilog2(MEMBLOCK_KHO_SCRATCH)] = "KHO_SCRATCH",
+	[ilog2(MEMBLOCK_KHO_SCRATCH_EXT)] = "KHO_SCRATCH_EXT",
 };
 
 static int memblock_debug_show(struct seq_file *m, void *private)
-- 
2.54.0.545.g6539524ca2-goog


