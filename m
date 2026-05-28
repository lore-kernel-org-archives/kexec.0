Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95729CD6E45
	for <kexec@archiver.kernel.org>; Thu, 28 May 2026 00:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NBsrZvFZCaB+Y/+qvoDfxB0s8ldAO6L08kiidL6oEeI=; b=A5/nfvHpJOp2Cj5IdYRz1Mwhzi
	Ih8Hvhh+OG99AMi7K0Zmu1ei6OYGJ4UL8kCpTc04EfCRdhZ0ckltWNuuh4Bc+94z53qUJmq39Xvfn
	rx+q2OxSA4SKsawSRREFNsfJ4xZJu97qBsY9gdofhihK//yJZDdlX+UnvsjnGTIiq8GDkL/1+I1Zb
	9K5u09B93l0330JEnmjuV9s0+KdUHqpitzXhU1y+DlJfaj2swbq/5C+LRy/9k7Sx4rLEKVpPvd5FO
	hzLSL0lQtApdtY0b2gNhQoHm+zXeZlOnkfafpgWZvOv3M3kB8PUJcAPcgsNqXyKqWs9AkgM3ZmzRQ
	zKrCUf2w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSOq0-00000004sgX-4476;
	Thu, 28 May 2026 00:43:04 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSOpQ-00000004s7y-35MK;
	Thu, 28 May 2026 00:42:30 +0000
Received: by linux.microsoft.com (Postfix, from userid 1241)
	id BFE2E20B7178; Wed, 27 May 2026 17:42:17 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BFE2E20B7178
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1779928937;
	bh=NBsrZvFZCaB+Y/+qvoDfxB0s8ldAO6L08kiidL6oEeI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aVvvYYwHjeNot3eIR3oUp6o7Upqmt3WV5LdKAduXaKrJZexICOXvtNvgktsWgX+ZJ
	 utUu36E7dKfzILCi+VELYR8r9Y7mkHMJnwV6BpykT51jf7MOoVXaWiKQy5lyD6ieUx
	 VPZSQEMPfAb90pLP1EyYWFvDqYR2cqaK/TPWiS+I=
From: Jork Loeser <jloeser@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org,
	linux-mm@kvack.org,
	kexec@lists.infradead.org
Cc: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Alexander Graf <graf@amazon.com>,
	Jason Miu <jasonmiu@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Baoquan He <bhe@redhat.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Kees Cook <kees@kernel.org>,
	Ran Xiaokai <ran.xiaokai@zte.com.cn>,
	Justinien Bouron <jbouron@amazon.com>,
	Sourabh Jain <sourabhjain@linux.ibm.com>,
	Pingfan Liu <piliu@redhat.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	linux-arm-kernel@lists.infradead.org,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	Michael Kelley <mhklinux@outlook.com>,
	Jork Loeser <jloeser@linux.microsoft.com>
Subject: [RFC PATCH 09/20] memblock: introduce MEMBLOCK_KHO_SCRATCH_EXT
Date: Wed, 27 May 2026 17:41:51 -0700
Message-ID: <20260528004204.1484584-10-jloeser@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260528004204.1484584-1-jloeser@linux.microsoft.com>
References: <20260528004204.1484584-1-jloeser@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260527_174228_827096_96B2CEF8 
X-CRM114-Status: GOOD (  20.27  )
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
Signed-off-by: Jork Loeser <jloeser@linux.microsoft.com>
---
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
index 6349c48154f4..6f76a6bb96d6 100644
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
@@ -1180,8 +1180,9 @@ int __init_memblock memblock_reserved_mark_kern(phys_addr_t base, phys_addr_t si
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
@@ -1205,6 +1206,23 @@ __init int memblock_clear_kho_scratch(phys_addr_t base, phys_addr_t size)
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
@@ -1238,10 +1256,20 @@ static bool should_skip_region(struct memblock_type *type,
 
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
@@ -2801,6 +2829,7 @@ static const char * const flagname[] = {
 	[ilog2(MEMBLOCK_RSRV_NOINIT)] = "RSV_NIT",
 	[ilog2(MEMBLOCK_RSRV_KERN)] = "RSV_KERN",
 	[ilog2(MEMBLOCK_KHO_SCRATCH)] = "KHO_SCRATCH",
+	[ilog2(MEMBLOCK_KHO_SCRATCH_EXT)] = "KHO_SCRATCH_EXT",
 };
 
 static int memblock_debug_show(struct seq_file *m, void *private)
-- 
2.43.0


