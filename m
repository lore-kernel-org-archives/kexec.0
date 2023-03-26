Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5EE1C6FD1C
	for <kexec@archiver.kernel.org>; Sun, 26 Mar 2023 13:03:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=qSi2JYEQVnMruAPX+hsNe6AxLbAMGfIDX3kcbseTq8A=; b=3V2o56pv/ai2Xu
	6Gx4I36A7W+DPftnyg9z/CNhSPzOOs6Mq+40la6krJqSsVLGzdtDXfO3OuU+1Vcg9no741nRZk66F
	uuD3oWg/coPThFYUjmpK8T3MbL62aedrwIdlmAS7uKpcSyyzRFkQhw+xdzFZCyd+73DI1WHVohGkm
	K/DV34+jgQctO8MaYSLGVmdlljk8JCf366xy1K+0/GvY1Tem5lT2VvrJG3yYt6X0Vsapb5gn5zLiz
	ZC4nScVK5SemKO7xfo/HvdMkNYWYz/gh5eSvUEiqnnA/SmmyuNXMQJYkysY543UaKM/vwpgI99bY/
	xQ07F6rku409bmgo+Kdw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pgQ1k-008RQq-1F;
	Sun, 26 Mar 2023 13:03:16 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pgQ1f-008RPg-0H
	for kexec@lists.infradead.org;
	Sun, 26 Mar 2023 13:03:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1679835789;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vdJaRYnSX9U0L2pvuSElq/dLQ18c0a4VffbSn8lfn6g=;
	b=K6j5DybHR4YRP7j1OJg6l6aEalwQ0gqsaw0d5Ra7Uo09mVq04H6lsGRX51+BkpD2PMfC4n
	Ce9shdK3Qoa85AXGcPH185Lm3XXF8Fof1t/FK3FKu2n/fmDP6YN13ZUH20OjUzLLNaTfkf
	zU8ShNH2vPL1QdFSMA9jPcGhZqNZYqk=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-635-2J__UrHtNzCYhC5Nuvh5kA-1; Sun, 26 Mar 2023 09:03:04 -0400
X-MC-Unique: 2J__UrHtNzCYhC5Nuvh5kA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F23351C05199;
	Sun, 26 Mar 2023 13:03:03 +0000 (UTC)
Received: from localhost (ovpn-12-88.pek2.redhat.com [10.72.12.88])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id CA5DA202701E;
	Sun, 26 Mar 2023 13:03:02 +0000 (UTC)
Date: Sun, 26 Mar 2023 21:02:58 +0800
From: Baoquan He <bhe@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: catalin.marinas@arm.com, horms@kernel.org, thunder.leizhen@huawei.com,
	John.p.donnelly@oracle.com, will@kernel.org,
	kexec@lists.infradead.org, ardb@kernel.org, rppt@kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 3/3] arm64: kdump: defer the crashkernel reservation for
 platforms with no DMA memory zones
Message-ID: <ZCBCgkiJ1/QPfgSt@MiWiFi-R3L-srv>
References: <20230324131838.409996-1-bhe@redhat.com>
 <20230324131838.409996-4-bhe@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230324131838.409996-4-bhe@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230326_060311_216913_D6686316 
X-CRM114-Status: GOOD (  21.48  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

In commit 031495635b46 ("arm64: Do not defer reserve_crashkernel() for
platforms with no DMA memory zones"), reserve_crashkernel() is called
much earlier in arm64_memblock_init() to avoid causing base apge
mapping on platforms with no DMA meomry zones.

With taking off protection on crashkernel memory region, no need to call
reserve_crashkernel() specially in advance. The deferred invocation of
reserve_crashkernel() in bootmem_init() can cover all cases. So revert
the commit 031495635b46 now.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
v1->v2:
- When trying to revert commit 031495635b46, two hunks were missed in v1
  post. Remove them in v2. Thanks to Leizhen for pointing out this. 
  - Remove code comment above arm64_dma_phys_limit definition added
    in commit 031495635b46;
  - Move the arm64_dma_phys_limit assignment back into zone_sizes_init()
    when both CONFIG_ZONE_DMA and CONFIG_ZONE_DMA32 are not enabled.

 arch/arm64/include/asm/memory.h |  5 -----
 arch/arm64/mm/init.c            | 34 +++------------------------------
 2 files changed, 3 insertions(+), 36 deletions(-)

diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index 78e5163836a0..efcd68154a3a 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -374,11 +374,6 @@ static inline void *phys_to_virt(phys_addr_t x)
 })
 
 void dump_mem_limit(void);
-
-static inline bool defer_reserve_crashkernel(void)
-{
-	return IS_ENABLED(CONFIG_ZONE_DMA) || IS_ENABLED(CONFIG_ZONE_DMA32);
-}
 #endif /* !ASSEMBLY */
 
 /*
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 58a0bb2c17f1..66e70ca47680 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -61,34 +61,8 @@ EXPORT_SYMBOL(memstart_addr);
  * unless restricted on specific platforms (e.g. 30-bit on Raspberry Pi 4).
  * In such case, ZONE_DMA32 covers the rest of the 32-bit addressable memory,
  * otherwise it is empty.
- *
- * Memory reservation for crash kernel either done early or deferred
- * depending on DMA memory zones configs (ZONE_DMA) --
- *
- * In absence of ZONE_DMA configs arm64_dma_phys_limit initialized
- * here instead of max_zone_phys().  This lets early reservation of
- * crash kernel memory which has a dependency on arm64_dma_phys_limit.
- * Reserving memory early for crash kernel allows linear creation of block
- * mappings (greater than page-granularity) for all the memory bank rangs.
- * In this scheme a comparatively quicker boot is observed.
- *
- * If ZONE_DMA configs are defined, crash kernel memory reservation
- * is delayed until DMA zone memory range size initialization performed in
- * zone_sizes_init().  The defer is necessary to steer clear of DMA zone
- * memory range to avoid overlap allocation.  So crash kernel memory boundaries
- * are not known when mapping all bank memory ranges, which otherwise means
- * not possible to exclude crash kernel range from creating block mappings
- * so page-granularity mappings are created for the entire memory range.
- * Hence a slightly slower boot is observed.
- *
- * Note: Page-granularity mappings are necessary for crash kernel memory
- * range for shrinking its size via /sys/kernel/kexec_crash_size interface.
  */
-#if IS_ENABLED(CONFIG_ZONE_DMA) || IS_ENABLED(CONFIG_ZONE_DMA32)
 phys_addr_t __ro_after_init arm64_dma_phys_limit;
-#else
-phys_addr_t __ro_after_init arm64_dma_phys_limit = PHYS_MASK + 1;
-#endif
 
 /* Current arm64 boot protocol requires 2MB alignment */
 #define CRASH_ALIGN			SZ_2M
@@ -248,6 +222,8 @@ static void __init zone_sizes_init(void)
 	if (!arm64_dma_phys_limit)
 		arm64_dma_phys_limit = dma32_phys_limit;
 #endif
+	if (!arm64_dma_phys_limit)
+		arm64_dma_phys_limit = PHYS_MASK + 1;
 	max_zone_pfns[ZONE_NORMAL] = max_pfn;
 
 	free_area_init(max_zone_pfns);
@@ -408,9 +384,6 @@ void __init arm64_memblock_init(void)
 
 	early_init_fdt_scan_reserved_mem();
 
-	if (!defer_reserve_crashkernel())
-		reserve_crashkernel();
-
 	high_memory = __va(memblock_end_of_DRAM() - 1) + 1;
 }
 
@@ -457,8 +430,7 @@ void __init bootmem_init(void)
 	 * request_standard_resources() depends on crashkernel's memory being
 	 * reserved, so do it here.
 	 */
-	if (defer_reserve_crashkernel())
-		reserve_crashkernel();
+	reserve_crashkernel();
 
 	memblock_dump_all();
 }
-- 
2.34.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
