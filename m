Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F331C0502E
	for <kexec@archiver.kernel.org>; Sun, 28 Aug 2022 00:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ziOvOKkHNHmT/zNU4jHg/LhU3Ei0ZLjNwdToNhzKOBE=; b=hC/X72zNJgjOX4
	fi9fHDGgiz6E0jEohHVGxNtGbM6dxd/B1uIXEZPfmXORxoJQBaRTRr7nnSZmsN6IywdzgS6FX+oyz
	llh/FIm6p+zJcLQpLntPGjkViuHSHid3Ufx4Qku7CiBiv+iF9shfOSEX/HhSn/w1W0p5dgd7ARIka
	KsbjjLiJwVtIDWYL1NUM5D2QNj0W4quBSaIAFS7q8R3gw4YuWbAOyXfev80oRwAVAs8x7jslZzMVk
	OrW9DpRgCH/fL49ujhJJOUqAT9612l5z+Rq3F8lCrdZTfuH+wBryAc3pNUM2A2qsr24praDnTwt/9
	RC95qWNJNWO3+t7FDNIQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oS6bV-00744A-H8; Sun, 28 Aug 2022 00:56:45 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oS6as-007383-4w
	for kexec@lists.infradead.org; Sun, 28 Aug 2022 00:56:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1661648165;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rvB61AUUyCy58XPpSF7Tow+QnKoMMfrS9peNbMrYXNU=;
	b=RigKhlLV3+IVVcOljiDUoR3nqg7ozWJjOef/HnnlUZu7xuMLP1AJNrSTQmLF44bnW71Zd5
	Rk/noGd3xZBzbpC2mZb2ELQF0bO9WuxqhGsGr2LGH6BZCUEzAwJ47U0APiWzYZCVvmsZLc
	b5yzonzc2EQW3osG6mSblExUOfw8piQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-58-_BgS1K4mNWeHtQcoMRrjUw-1; Sat, 27 Aug 2022 20:56:02 -0400
X-MC-Unique: _BgS1K4mNWeHtQcoMRrjUw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8CFEE801231;
	Sun, 28 Aug 2022 00:56:01 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-25.pek2.redhat.com [10.72.12.25])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 6F22A492C3B;
	Sun, 28 Aug 2022 00:55:55 +0000 (UTC)
From: Baoquan He <bhe@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	catalin.marinas@arm.com,
	ardb@kernel.org,
	rppt@kernel.org,
	guanghuifeng@linux.alibaba.com,
	mark.rutland@arm.com,
	will@kernel.org,
	linux-mm@kvack.org,
	thunder.leizhen@huawei.com,
	wangkefeng.wang@huawei.com,
	kexec@lists.infradead.org,
	Baoquan He <bhe@redhat.com>
Subject: [PATCH 1/2] arm64, kdump: enforce to take 4G as the crashkernel low memory end
Date: Sun, 28 Aug 2022 08:55:44 +0800
Message-Id: <20220828005545.94389-2-bhe@redhat.com>
In-Reply-To: <20220828005545.94389-1-bhe@redhat.com>
References: <20220828005545.94389-1-bhe@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220827_175606_336349_CF61D686 
X-CRM114-Status: GOOD (  19.08  )
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

Problem:
=======
On arm64, block and section mapping is supported to build page tables.
However, currently it enforces to take base page mapping for the whole
linear mapping if CONFIG_ZONE_DMA or CONFIG_ZONE_DMA32 is enabled and
crashkernel kernel parameter is set. This will cause longer time of the
linear mapping process during bootup and severe performance degradation
during running time.

Root cause:
==========
On arm64, crashkernel reservation relies on knowing the upper limit of
low memory zone because it needs to reserve memory in the zone so that
devices' DMA addressing in kdump kernel can be satisfied. However, the
limit on arm64 is variant. And the upper limit can only be decided late
till bootmem_init() is called.

And we need to map the crashkernel region with base page granularity when
doing linear mapping, because kdump needs to protect the crashkernel region
via set_memory_valid(,0) after kdump kernel loading. However, arm64 doesn't
support well on splitting the built block or section mapping due to some
cpu reststriction [1]. And unfortunately, the linear mapping is done before
bootmem_init().

To resolve the above conflict on arm64, the compromise is enforcing to
take base page mapping for the entire linear mapping if crashkernel is
set, and CONFIG_ZONE_DMA or CONFIG_ZONE_DMA32 is enabed. Hence
performance is sacrificed.

Solution:
=========
To fix the problem, we should always take 4G as the crashkernel low
memory end in case CONFIG_ZONE_DMA or CONFIG_ZONE_DMA32 is enabled.
With this, we don't need to defer the crashkernel reservation till
bootmem_init() is called to set the arm64_dma_phys_limit. As long as
memblock init is done, we can conclude what is the upper limit of low
memory zone.

1) both CONFIG_ZONE_DMA or CONFIG_ZONE_DMA32 are disabled or memblock_start_of_DRAM() > 4G
  limit = PHYS_ADDR_MAX+1  (Corner cases)
2) CONFIG_ZONE_DMA or CONFIG_ZONE_DMA32 are enabled:
   limit = 4G  (generic case)

[1]
https://lore.kernel.org/all/YrIIJkhKWSuAqkCx@arm.com/T/#u

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 arch/arm64/mm/init.c | 24 ++++++++++++++----------
 arch/arm64/mm/mmu.c  | 38 ++++++++++++++++++++++----------------
 2 files changed, 36 insertions(+), 26 deletions(-)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index b9af30be813e..8ae55afdd11c 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -90,10 +90,22 @@ phys_addr_t __ro_after_init arm64_dma_phys_limit;
 phys_addr_t __ro_after_init arm64_dma_phys_limit = PHYS_MASK + 1;
 #endif
 
+static phys_addr_t __init crash_addr_low_max(void)
+{
+	phys_addr_t low_mem_mask = U32_MAX;
+	phys_addr_t phys_start = memblock_start_of_DRAM();
+
+	if ((!IS_ENABLED(CONFIG_ZONE_DMA) && !IS_ENABLED(CONFIG_ZONE_DMA32)) ||
+	     (phys_start > U32_MAX))
+		low_mem_mask = PHYS_ADDR_MAX;
+
+	return min(low_mem_mask, memblock_end_of_DRAM() - 1) + 1;
+}
+
 /* Current arm64 boot protocol requires 2MB alignment */
 #define CRASH_ALIGN			SZ_2M
 
-#define CRASH_ADDR_LOW_MAX		arm64_dma_phys_limit
+#define CRASH_ADDR_LOW_MAX		crash_addr_low_max()
 #define CRASH_ADDR_HIGH_MAX		(PHYS_MASK + 1)
 
 static int __init reserve_crashkernel_low(unsigned long long low_size)
@@ -389,8 +401,7 @@ void __init arm64_memblock_init(void)
 
 	early_init_fdt_scan_reserved_mem();
 
-	if (!defer_reserve_crashkernel())
-		reserve_crashkernel();
+	reserve_crashkernel();
 
 	high_memory = __va(memblock_end_of_DRAM() - 1) + 1;
 }
@@ -434,13 +445,6 @@ void __init bootmem_init(void)
 	 */
 	dma_contiguous_reserve(arm64_dma_phys_limit);
 
-	/*
-	 * request_standard_resources() depends on crashkernel's memory being
-	 * reserved, so do it here.
-	 */
-	if (defer_reserve_crashkernel())
-		reserve_crashkernel();
-
 	memblock_dump_all();
 }
 
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index e7ad44585f40..cdd338fa2115 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -547,13 +547,12 @@ static void __init map_mem(pgd_t *pgdp)
 	memblock_mark_nomap(kernel_start, kernel_end - kernel_start);
 
 #ifdef CONFIG_KEXEC_CORE
-	if (crash_mem_map) {
-		if (defer_reserve_crashkernel())
-			flags |= NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
-		else if (crashk_res.end)
-			memblock_mark_nomap(crashk_res.start,
-			    resource_size(&crashk_res));
-	}
+	if (crashk_res.end)
+		memblock_mark_nomap(crashk_res.start,
+				    resource_size(&crashk_res));
+	if (crashk_low_res.end)
+		memblock_mark_nomap(crashk_low_res.start,
+				    resource_size(&crashk_low_res));
 #endif
 
 	/* map all the memory banks */
@@ -589,16 +588,23 @@ static void __init map_mem(pgd_t *pgdp)
 	 * through /sys/kernel/kexec_crash_size interface.
 	 */
 #ifdef CONFIG_KEXEC_CORE
-	if (crash_mem_map && !defer_reserve_crashkernel()) {
-		if (crashk_res.end) {
-			__map_memblock(pgdp, crashk_res.start,
-				       crashk_res.end + 1,
-				       PAGE_KERNEL,
-				       NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS);
-			memblock_clear_nomap(crashk_res.start,
-					     resource_size(&crashk_res));
-		}
+	if (crashk_res.end) {
+		__map_memblock(pgdp, crashk_res.start,
+			       crashk_res.end + 1,
+			       PAGE_KERNEL,
+			       NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS);
+		memblock_clear_nomap(crashk_res.start,
+				     resource_size(&crashk_res));
 	}
+	if (crashk_low_res.end) {
+		__map_memblock(pgdp, crashk_low_res.start,
+			       crashk_low_res.end + 1,
+			       PAGE_KERNEL,
+			       NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS);
+		memblock_clear_nomap(crashk_low_res.start,
+				     resource_size(&crashk_low_res));
+	}
+
 #endif
 }
 
-- 
2.34.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
